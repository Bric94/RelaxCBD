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

        $key = $weight ? "{$productId}_{$weight}" : (string)$productId;

        if (!isset($cart[$key])) {
            $cart[$key] = 0;
        }

        $cart[$key] += max(1, $quantity);

        $this->session->set('cart', $cart);
    }

    public function remove(int $productId, ?string $weight = null)
    {
        $product = $this->productRepository->find($productId);
        if ($product && ! $product->isWeightBased()) {
            $weight = null;
        }

        $cart = $this->session->get('cart', []);
        $key = $weight ? "{$productId}_{$weight}" : (string)$productId;

        if (isset($cart[$key])) {
            unset($cart[$key]);
            $this->session->set('cart', $cart);
        }
    }


    public function getCart(): array
    {
        $cart = $this->session->get('cart', []);
        $cartItems = [];

        foreach ($cart as $key => $quantity) {
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

            $selectedPrice = $weight ? $product->calculateDiscountedPrice((int)$weight) : $product->getPrice();
            $pricePerGram = $product->calculateDiscountedPrice(1);
            $discount = 0;

            if ($weight && $product->isWeightBased() && $pricePerGram > 0) {
                $discount = round((($pricePerGram - $selectedPrice) / $pricePerGram) * 100, 2);
            }

            $cartItems[] = [
                'product' => $product,
                'quantity' => $quantity,
                'weight' => $weight,
                'price' => $selectedPrice,
                'original_price' => $pricePerGram,
                'discount' => $discount
            ];
        }

        return $cartItems;
    }

    public function clear(): void
    {
        $this->session->set('cart', []);
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
