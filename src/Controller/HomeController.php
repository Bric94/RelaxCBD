<?php

// src/Controller/HomeController.php

namespace App\Controller;

use App\Entity\User;
use App\Repository\ProductRepository;
use App\Repository\OrderRepository;
use App\Service\CartService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(ProductRepository $productRepository, CartService $cartService): Response
    {
        $randomProducts = $productRepository->findBy([], [], 5);

        // 🔄 Utilise le CartService comme dans CartController
        $cartItems = $cartService->getCart();
        $total = $cartService->getTotal();

        $user = $this->getUser();
        $profilePicture = 'images/default/avatar1.webp';

        if ($user instanceof User && $user->getProfilePicture()) {
            $profilePicture = 'images/profiles/' . $user->getProfilePicture();
        }

        return $this->render('home/index.html.twig', [
            'randomProducts' => $randomProducts,
            'cartItems' => $cartItems,
            'total' => $total,
            'profilePicture' => $profilePicture,
        ]);
    }
}
