<?php

namespace App\Controller;

use App\Service\CartService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
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

    #[Route('/add/{id}/{weight?}', name: 'add', methods: ['POST'])]
    public function add(Request $request, CartService $cartService, int $id): RedirectResponse
    {
        $selectedWeight = $request->request->get('selectedWeight'); // Récupère le poids sélectionné
        $quantity = (int) $request->request->get('quantity', 1); // Récupère la quantité uniquement si ce n'est pas un produit au poids

        if ($selectedWeight) {
            $quantity = (int) $selectedWeight; // La quantité devient le grammage sélectionné
        }

        $cartService->add($id, $quantity, $selectedWeight); // Ajout au panier

        return $this->redirectToRoute('cart_index');
    }




    #[Route('/remove/{id}/{weight?}', name: 'remove')]
    public function remove(CartService $cartService, int $id, ?string $weight = null): RedirectResponse
    {
        $cartService->remove($id, $weight);
        return $this->redirectToRoute('cart_index');
    }


    #[Route('/clear', name: 'clear')]
    public function clear(CartService $cartService): RedirectResponse
    {
        $cartService->remove('cart');
        return $this->redirectToRoute('cart_index');
    }
}
