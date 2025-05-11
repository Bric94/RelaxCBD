<?php

namespace App\Controller;

use App\Service\CartService;
use App\Repository\ProductRepository;
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
            'total'     => $cartService->getTotal(),
        ]);
    }

    #[Route('/add/{id}/{weight?}', name: 'add', methods: ['POST'])]
    public function add(
        Request $request,
        CartService $cartService,
        ProductRepository $productRepository,
        int $id
    ): Response {
        $selectedWeight = $request->request->get('selectedWeight');
        $quantity       = (int) $request->request->get('quantity', 1);

        if ($selectedWeight) {
            $quantity = (int) $selectedWeight;
        }

        $product = $productRepository->find($id);
        if (!$product) {
            return $this->json(['error' => 'Produit introuvable.'], 404);
        }

        $cartService->add($id, $quantity, $selectedWeight);

        $cartUrl = $this->generateUrl('cart_index');

        // Si appel AJAX : on renvoie un JSON
        if ($request->isXmlHttpRequest()) {
            return $this->json([
                'message' => sprintf('« %s » a été ajouté à votre panier.', $product->getName()),
                'cartUrl' => $cartUrl,
            ]);
        }

        // Sinon redirection classique
        return $this->redirect($request->headers->get('referer') ?? $cartUrl);
    }

    #[Route('/remove/{id}/{weight?}', name: 'remove')]
    public function remove(
        CartService $cartService,
        int $id,
        ?string $weight = null
    ): Response {
        $cartService->remove($id, $weight);

        return $this->redirectToRoute('cart_index');
    }

    #[Route('/clear', name: 'clear')]
    public function clear(CartService $cartService): RedirectResponse
    {
        $cartService->clear();

        return $this->redirectToRoute('cart_index');
    }
}
