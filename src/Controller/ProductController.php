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

    /**
     * Liste paginée des produits
     */
    #[Route('/list', name: 'list')]
    public function list(Request $request): Response
    {
        $page = max(1, $request->query->getInt('page', 1)); // Assure que la page est toujours >= 1
        $products = $this->productRepository->findPaginatedProducts(null, $page, 10);

        return $this->render('product/list.html.twig', [
            'products' => $products,
            'page' => $page,
        ]);
    }

    /**
     * Page d'accueil des produits avec pagination
     */
    // src/Controller/ProductController.php

    #[Route('/', name: 'index')]
    public function index(Request $request, ProductRepository $productRepository): Response
    {
        $page = max(1, $request->query->getInt('page', 1)); // Récupération du numéro de page
        $productsPerPage = 10; // Nombre de produits par page
        $totalProducts = $productRepository->count([]); // Nombre total de produits
        $totalPages = ceil($totalProducts / $productsPerPage); // Calcul du nombre total de pages

        $products = $productRepository->findBy([], [], $productsPerPage, ($page - 1) * $productsPerPage);

        return $this->render('product/index.html.twig', [
            'products' => $products,
            'page' => $page,
            'totalPages' => $totalPages, // On passe bien totalPages à la vue
        ]);
    }


    /**
     * Liste des best-sellers
     */
    #[Route('/best-sellers', name: 'best_sellers')]
    public function bestSellers(): Response
    {
        $products = $this->productRepository->findBestSellers(5);

        return $this->render('product/best_sellers.html.twig', [
            'products' => $products,
        ]);
    }

    /**
     * Liste des produits d'une catégorie avec pagination
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
        $products = $this->productRepository->findByCategory($id, $page, $productsPerPage);

        return $this->render('product/category.html.twig', [
            'category' => $category,
            'products' => $products,
            'page' => $page, // Ajout de la variable page pour éviter l'erreur
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
