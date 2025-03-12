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

    public function add(int $productId, int $quantity, ?string $weight = null): void
    {
        $cart = $this->session->get('cart', []);

        // Générer une clé unique pour les produits au poids
        $key = $weight ? "{$productId}_{$weight}" : (string)$productId;

        if (!isset($cart[$key])) {
            $cart[$key] = 0;
        }

        $cart[$key] += max(1, $quantity); // Ajout du grammage directement

        $this->session->set('cart', $cart);
    }

    public function remove(int $productId, ?string $weight = null)
    {
        $cart = $this->session->get('cart', []);

        $key = $weight ? "{$productId}_{$weight}" : (string)$productId;

        if (isset($cart[$key])) {
            unset($cart[$key]); // Supprime seulement l'entrée correspondante
        }

        $this->session->set('cart', $cart);
    }


    public function getCart(): array
    {
        $cart = $this->session->get('cart', []);
        $cartItems = [];

        foreach ($cart as $key => $quantity) {
            // Vérifie si la clé contient un "_" (produits au poids)
            if (str_contains($key, '_')) {
                [$productId, $weight] = explode('_', $key);
            } else {
                $productId = $key;
                $weight = null;
            }

            $product = $this->productRepository->find($productId);

            if (!$product) {
                continue;
            }

            // Récupérer le prix en fonction du poids sélectionné
            $price = $product->isWeightBased() && $weight && isset($product->getPriceByWeight()[$weight])
                ? $product->getPriceByWeight()[$weight]
                : $product->getPrice();

            $discount = $weight ? ($product->getDiscountForWeight($weight) ?? 0) : 0;
            $discountedPrice = $price - ($price * $discount / 100);

            $cartItems[] = [
                'product' => $product,
                'quantity' => $quantity, // Quantité représente le grammage si le produit est au poids
                'weight' => $weight,
                'price' => $discountedPrice,
                'original_price' => $price,
                'discount' => $discount
            ];
        }

        return $cartItems;
    }

    public function getTotal(): float
    {
        $cartItems = $this->getCart();
        $total = 0.0;

        foreach ($cartItems as $item) {
            if (!isset($item['price']) || !isset($item['quantity'])) {
                continue; // Évite les erreurs si des données sont manquantes
            }

            $total += $item['price'] * $item['quantity'];
        }

        return round($total, 2);
    }
}
