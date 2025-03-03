<?php

namespace App\Controller;

use App\Service\CartService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/cart', name: 'cart_')]
final class CartController extends AbstractController
{
    #[Route('/', name: 'index')]
    public function index(CartService $cartService): Response
    {
        return $this->render('cart/index.html.twig', [
            'cartItems' => $cartService->getCart(),
            'total' => $cartService->getTotal() // Ajout du total
        ]);
    }

    #[Route('/add/{id}', name: 'add')]
    public function add(CartService $cartService, int $id): RedirectResponse
    {
        $cartService->add($id);
        return $this->redirectToRoute('cart_index');
    }

    #[Route('/remove/{id}', name: 'remove')]
    public function remove(CartService $cartService, int $id): RedirectResponse
    {
        $cartService->remove($id);
        return $this->redirectToRoute('cart_index');
    }

    #[Route('/clear', name: 'clear')]
    public function clear(CartService $cartService): RedirectResponse
    {
        $cartService->clear();
        return $this->redirectToRoute('cart_index');
    }
}
