<?php

namespace App\Service;

use App\Repository\ProductRepository;
use Symfony\Component\HttpFoundation\RequestStack;

class CartService
{
    private $session;
    private $productRepository;

    public function __construct(RequestStack $requestStack, ProductRepository $productRepository)
    {
        $this->session = $requestStack->getSession();
        $this->productRepository = $productRepository;
    }

    public function add(int $productId, int $quantity = 1, ?string $weight = null)
    {
        $cart = $this->session->get('cart', []);

        // Générer une clé unique pour les produits avec grammage (ex: "12_3g")
        $key = $weight ? "{$productId}_{$weight}" : (string)$productId;

        if (isset($cart[$key])) {
            $cart[$key] += $quantity;
        } else {
            $cart[$key] = $quantity;
        }

        $this->session->set('cart', $cart);
    }

    public function remove(int $productId, ?string $weight = null)
    {
        $cart = $this->session->get('cart', []);

        // Générer la clé en fonction du grammage
        $key = $weight ? "{$productId}_{$weight}" : (string)$productId;

        if (isset($cart[$key])) {
            unset($cart[$key]);
        }

        $this->session->set('cart', $cart);
    }

    public function getCart(): array
    {
        $cart = $this->session->get('cart', []);
        $cartItems = [];

        foreach ($cart as $key => $quantity) {
            list($productId, $weight) = explode('_', $key) + [null, null];
            $product = $this->productRepository->find($productId);

            if (!$product) {
                continue;
            }

            // Vérifier si c'est un produit au poids et récupérer le bon prix
            $price = $product->isWeightBased() && isset($product->getPriceByWeight()[$weight])
                ? $product->getPriceByWeight()[$weight]
                : $product->getPrice();

            $cartItems[] = [
                'product' => $product,
                'quantity' => $quantity,
                'weight' => $weight,
                'price' => $price
            ];
        }

        return $cartItems;
    }

    public function getTotal(): float
    {
        $cartItems = $this->getCart();
        $total = 0.0;

        foreach ($cartItems as $item) {
            $total += $item['price'] * $item['quantity'];
        }

        return $total;
    }

    public function clear()
    {
        $this->session->remove('cart');
    }
}
