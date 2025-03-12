<?php

namespace App\Controller\Admin;

use App\Entity\Category;
use App\Entity\Product;
use Doctrine\ORM\EntityManagerInterface;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\ArrayField;
use EasyCorp\Bundle\EasyAdminBundle\Field\AssociationField;
use EasyCorp\Bundle\EasyAdminBundle\Field\BooleanField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IdField;
use EasyCorp\Bundle\EasyAdminBundle\Field\ImageField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\MoneyField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextareaField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\String\Slugger\SluggerInterface;

class ProductCrudController extends AbstractCrudController
{

    public function __construct(private SluggerInterface $slugger) {}

    public static function getEntityFqcn(): string
    {
        return Product::class;
    }

    public function configureFields(string $pageName): iterable
    {
        $fields = [
            TextField::new('name', 'Nom du produit'),
            MoneyField::new('price', 'Prix')->setStoredAsCents(false)->setCurrency('EUR'),
            AssociationField::new('category', 'Catégorie')->setRequired(true),
            TextEditorField::new('description', 'Description'),
            BooleanField::new('isWeightBased', "Basé sur le poids <br> (en grammes)"), // Ajout du switch pour activer/désactiver le mode poids
            IntegerField::new('stock', 'Stock'),

            // Champ pour l'upload
            ImageField::new('image', 'Image')
                ->setBasePath('/uploads/products') // Chemin pour afficher l'image
                ->setUploadDir('public/uploads/products') // Chemin de stockage
                ->setUploadedFileNamePattern('[randomhash].[extension]') // Nom de fichier unique
                ->setRequired(false),
        ];

        // 🔥 Ajouter discountByWeight seulement si c'est un produit au poids
        if ($pageName === 'edit' || $pageName === 'new') {
            $fields[] = ArrayField::new('discountByWeight', 'Réductions par poids (ex: {"3g":5, "5g":10})');
        }

        return $fields;
    }

    public function persistEntity(EntityManagerInterface $entityManager, $entityInstance): void
    {
        /** @var Product $product */
        $product = $entityInstance;

        $imageFile = $this->getContext()->getRequest()->files->get('Product')['imageFile'] ?? null;
        if ($imageFile instanceof UploadedFile) {
            $newFilename = $this->uploadImage($imageFile);
            $product->setImage($newFilename);
        }

        $entityManager->persist($product);
        $entityManager->flush();
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
