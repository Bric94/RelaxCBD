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
            TextareaField::new('description', 'Description'),
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
            $fields[] = ArrayField::new('priceByWeight', 'Prix par poids (JSON)')
                ->setHelp('Ex: {"1": 10, "5": 9, "10": 8}');
        }


        return $fields;
    }

    public function persistEntity(EntityManagerInterface $entityManager, $entityInstance): void
    {
        if ($entityInstance instanceof Product) {
            $priceByWeight = $entityInstance->getPriceByWeight();

            // Assurer que les données sont bien encodées et propres
            if (is_array($priceByWeight)) {
                $entityInstance->setPriceByWeight(array_map('floatval', $priceByWeight));
            }

            // Si c'est une chaîne JSON stockée dans un tableau, corriger
            if (is_array($priceByWeight) && isset($priceByWeight[0]) && is_string($priceByWeight[0])) {
                $decoded = json_decode($priceByWeight[0], true);
                if (json_last_error() === JSON_ERROR_NONE) {
                    $entityInstance->setPriceByWeight(array_map('floatval', $decoded));
                }
            }
        }

        // Gestion de l'upload d'image
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
