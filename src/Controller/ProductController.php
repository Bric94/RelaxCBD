<?php

namespace App\Controller;

use App\Repository\ProductRepository;
use App\Repository\CategoryRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
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
    #[Route('/', name: 'list')]
    public function list(Request $request): Response
    {
        $page = max(1, $request->query->getInt('page', 1)); // Assure que la page est toujours >= 1
        $products = $this->productRepository->findPaginatedProducts($page, 10);

        return $this->render('product/list.html.twig', [
            'products' => $products,
            'page' => $page,
        ]);
    }

    #[Route('/', name: 'index')]
    public function index(ProductRepository $productRepository): Response
    {
        $products = $productRepository->findAll();

        return $this->render('product/index.html.twig', [
            'products' => $products,
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
     * Liste des produits d'une catégorie
     */
    #[Route('/category/{id}', name: 'by_category')]
    public function byCategory(int $id, Request $request): Response
    {
        $category = $this->categoryRepository->find($id);
        if (!$category) {
            throw $this->createNotFoundException('Catégorie non trouvée');
        }
        
        $page = max(1, $request->query->getInt('page', 1));
        $products = $this->productRepository->findPaginatedProducts($id, $page, 10);

        return $this->render('product/category.html.twig', [
            'category' => $category,
            'products' => $products,
            'page' => $page,
        ]);
    }
}
