<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use App\Repository\CategoryRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/products', name: 'product_')]
class ProductController extends AbstractController
{
    private ProductRepository $productRepository;
    private CategoryRepository $categoryRepository;

    public function __construct(ProductRepository $productRepository, CategoryRepository $categoryRepository)
    {
        $this->productRepository = $productRepository;
        $this->categoryRepository = $categoryRepository;
    }

    /* #[Route('/', name: 'index')]
    public function index(ProductRepository $productRepository, Request $request): Response
    {
        $page = max(1, $request->query->getInt('page', 1)); // S'assure que la page est au moins 1
        $limit = 10; // Nombre de produits par page

        // Récupérer les produits paginés
        $paginator = $productRepository->findPaginatedProducts(null, $page, $limit);

        // Calculer le nombre total de pages
        $totalProducts = count($paginator); // Nombre total de produits
        $totalPages = max(1, ceil($totalProducts / $limit)); // Nombre total de pages

        return $this->render('product/index.html.twig', [
            'products' => $paginator,
            'page' => $page,
            'totalPages' => $totalPages, // ✅ Ajout de totalPages
        ]);
    } */

    /**
     * Liste paginée des produits avec recherche et tri
     */

    #[Route('/', name: 'index')]
    public function index(Request $request): Response
    {
        $query = $request->query->get('q');
        $categoryId = $request->query->getInt('category');
        $sort = $request->query->get('sort', 'newest');
        $page = max(1, $request->query->getInt('page', 1));
        $productsPerPage = 10;

        // Récupération des produits selon les critères
        $products = $this->productRepository->searchProducts($query, $categoryId, $sort, $page, $productsPerPage);
        $totalProducts = count($products);
        $totalPages = ceil($totalProducts / $productsPerPage);

        // Récupération des catégories pour le filtre
        $categories = $this->categoryRepository->findAll();

        foreach ($products as $product) {
            dump($product->getId(), $product->getName(), $product->getPriceByWeight());
        }

        return $this->render('product/index.html.twig', [
            'products' => $products,
            'categories' => $categories,
            'page' => $page,
            'totalPages' => $totalPages,
        ]);
    }

    /**
     * Liste des produits d'une catégorie spécifique avec pagination
     */
    #[Route('/category/{id}', name: 'by_category')]
    public function byCategory(int $id, Request $request): Response
    {
        $category = $this->categoryRepository->find($id);
        if (!$category) {
            throw $this->createNotFoundException('Catégorie non trouvée');
        }

        $page = max(1, $request->query->getInt('page', 1)); // Gestion de la pagination
        $productsPerPage = 10;

        $products = $this->productRepository->findBy(
            ['category' => $id], // Filtrer par catégorie
            ['name' => 'ASC'],   // Tri par nom
            $productsPerPage,    // Limite
            ($page - 1) * $productsPerPage // Offset
        );

        return $this->render('product/category.html.twig', [
            'category' => $category,
            'products' => $products,
            'page' => $page,
        ]);
    }

    /**
     * Affiche les détails d'un produit
     */
    #[Route('/{id}', name: 'show', requirements: ['id' => '\d+'])]
    public function show(int $id): Response
    {
        $product = $this->productRepository->find($id);

        if (!$product) {
            throw $this->createNotFoundException('Produit non trouvé');
        }

        // 📌 Vérifie si `priceByWeight` est bien récupéré pour ce produit
        dump($product->getId(), $product->getName(), $product->getPriceByWeight());

        return $this->render('product/show.html.twig', [
            'product' => $product,
        ]);
    }





    /**
     * Recherche de produits en AJAX
     */
    #[Route('/search', name: 'search')]
    public function search(Request $request): JsonResponse
    {
        $query = $request->query->get('q', '');

        if (empty($query)) {
            return new JsonResponse([]);
        }

        $products = $this->productRepository->searchProducts($query);

        $results = array_map(function ($product) {
            return [
                'id' => $product->getId(),
                'name' => $product->getName(),
                'image' => $product->getImage() ?? '/images/default-product.jpg',
                'price' => $product->getPrice(),
            ];
        }, $products);

        return new JsonResponse($results);
    }
}
