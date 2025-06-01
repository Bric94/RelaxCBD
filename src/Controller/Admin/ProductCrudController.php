<?php

namespace App\Controller\Admin;

use App\Entity\Product;
use Doctrine\ORM\EntityManagerInterface;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\BooleanField;
use EasyCorp\Bundle\EasyAdminBundle\Field\CollectionField;
use EasyCorp\Bundle\EasyAdminBundle\Field\Field;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use FOS\CKEditorBundle\Form\Type\CKEditorType;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;

class ProductCrudController extends AbstractCrudController
{
    public function __construct(private SluggerInterface $slugger) {}

    public static function getEntityFqcn(): string
    {
        return Product::class;
    }

    /* public function configureFields(string $pageName): iterable
    {
        $fields = [
            yield TextField::new('name', 'Nom du produit'),
            yield MoneyField::new('price', 'Prix')
                ->setStoredAsCents(false)
                ->setCurrency('EUR'),
            yield AssociationField::new('category', 'Catégorie')
                ->setRequired(true),
            yield TextareaField::new('description')
                ->setFormType(CKEditorType::class),
            yield BooleanField::new('isWeightBased', "Basé sur le poids"),
            yield IntegerField::new('stock', 'Stock'),
            yield ImageField::new('image', 'Image')
                ->setBasePath('/uploads/products')
                ->setUploadDir('public/uploads/products')
                ->setUploadedFileNamePattern('[randomhash].[extension]')
                ->setRequired(false),
        ];

        // Ajout du VirtualField pour l'affichage
        if ($pageName === 'index') {
            yield TextField::new('priceByWeightDisplay', 'Prix par poids');
        }
        if ($pageName === 'detail') {
            yield TextareaField::new('priceByWeightDisplay', 'Prix par poids');
        }
        if ($pageName === 'new' || $pageName === 'edit') {
            yield \EasyCorp\Bundle\EasyAdminBundle\Field\CollectionField::new('priceByWeight', 'Prix par poids')
                ->setEntryType(\App\Form\PriceByWeightItemType::class)
                ->allowAdd()
                ->allowDelete()
                ->setHelp('Ajoutez des plages (ex : 1-4g:10€/g, 5-9g:9€/g...)');
        }
    } */

    public function configureFields(string $pageName): iterable
    {
        $fields = [];

        $fields[] = TextField::new('name', 'Nom du produit');
        $fields[] = AssociationField::new('category', 'Catégorie')->setRequired(true);
        $fields[] = TextareaField::new('description')->setFormType(CKEditorType::class);
        $fields[] = BooleanField::new('isWeightBased', 'Basé sur le poids')
            ->setFormTypeOption('attr', ['id' => 'product_isWeightBased']);
        $fields[] = IntegerField::new('stock', 'Stock');
        $fields[] = ImageField::new('image', 'Image')
            ->setBasePath('/uploads/products')
            ->setUploadDir('public/uploads/products')
            ->setUploadedFileNamePattern('[randomhash].[extension]')
            ->setRequired(false);

        if (in_array($pageName, ['new', 'edit'])) {
            $fields[] = MoneyField::new('price', 'Prix unitaire (€)')
                ->setCurrency('EUR')
                ->setStoredAsCents(false)
                ->setHelp('Requis uniquement si le produit n\'est pas vendu au poids.')
                ->setFormTypeOption('attr', ['class' => 'field-price']);

            $fields[] = CollectionField::new('priceByWeight', 'Prix par poids')
                ->setEntryType(\App\Form\PriceByWeightItemType::class)
                ->allowAdd()
                ->allowDelete()
                ->setHelp('Ajoutez des plages (ex : 1-4g:10€/g, 5-9g:9€/g...).')
                ->setFormTypeOption('attr', ['class' => 'field-priceByWeight']);
        }

        if ($pageName === 'index') {
            $fields[] = TextField::new('priceByWeightDisplay', 'Prix par poids');
        }

        if ($pageName === 'detail') {
            $fields[] = TextareaField::new('priceByWeightDisplay', 'Prix par poids');
        }

        return $fields;
    }


    public function persistEntity(EntityManagerInterface $entityManager, $entityInstance): void
    {
        $this->processPriceByWeight($entityInstance);
        $this->handleImageUpload($entityInstance);
        parent::persistEntity($entityManager, $entityInstance);
    }

    public function updateEntity(EntityManagerInterface $entityManager, $entityInstance): void
    {
        $this->processPriceByWeight($entityInstance);
        $this->handleImageUpload($entityInstance);
        parent::updateEntity($entityManager, $entityInstance);
    }

    private function processPriceByWeight($product): void
    {
        if ($product instanceof Product) {
            $priceData = $product->getPriceByWeight();
            $cleanedData = [];

            if (is_array($priceData)) {
                foreach ($priceData as $range) {
                    if (isset($range['min'], $range['max'], $range['price'])) {
                        $cleanedData[] = [
                            'min' => (int)$range['min'],
                            'max' => (int)$range['max'],
                            'price' => (float)$range['price']
                        ];
                    }
                }
            }

            $product->setPriceByWeight($cleanedData);
        }
    }

    private function handleImageUpload(Product $product): void
    {
        $imageFile = $this->getContext()->getRequest()->files->get('Product')['imageFile'] ?? null;

        if ($imageFile instanceof UploadedFile) {
            $newFilename = $this->uploadImage($imageFile);
            $product->setImage($newFilename);
        }
    }

    private function uploadImage(UploadedFile $file): string
    {
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($originalFilename);
        $newFilename = $safeFilename . '-' . uniqid() . '.' . $file->guessExtension();

        $file->move('public/uploads/products', $newFilename);

        return $newFilename;
    }
}
