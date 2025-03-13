<?php

namespace App\Controller;

use App\Entity\Order;
use App\Entity\OrderItem;
use App\Repository\OrderRepository;
use App\Service\CartService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/orders', name: 'order_')]  // ✅ Préfixe pour générer des noms de routes cohérents
final class OrderController extends AbstractController
{
    #[Route('/', name: 'index')]
    public function index(OrderRepository $orderRepository): Response
    {
        $user = $this->getUser(); // Récupère l'utilisateur connecté

        // Vérifie si l'utilisateur est bien connecté
        if (!$user) {
            return $this->redirectToRoute('app_login'); // Redirige vers la page de connexion
        }

        // Récupère les commandes de l'utilisateur
        $orders = $orderRepository->findBy(['user' => $user]);

        return $this->render('order/index.html.twig', [
            'orders' => $orders, // ✅ Envoie les commandes au template
        ]);
    }

    #[Route('/checkout/process-payment', name: 'process_payment', methods: ['POST'])]
    public function processPayment(Request $request, CartService $cartService, EntityManagerInterface $entityManager): Response
    {
        $user = $this->getUser();

        if (!$user) {
            return $this->redirectToRoute('app_login');
        }

        $cartItems = $cartService->getCart();
        $total = $cartService->getTotal();

        if (empty($cartItems)) {
            $this->addFlash('warning', 'Votre panier est vide, impossible de passer commande.');
            return $this->redirectToRoute('cart_index');
        }

        try {
            $order = new Order();
            $order->setUser($user);
            $order->setTotalPrice($total);
            $order->setCreatedAt(new \DateTime());
            $order->setStatus('pending');

            foreach ($cartItems as $item) {
                if (!$item['product']) {
                    throw new \LogicException('Produit introuvable dans le panier');
                }

                $orderItem = new OrderItem();
                $orderItem->setOrders($order);
                $orderItem->setProduct($item['product']);
                $orderItem->setQuantity($item['quantity']);
                $orderItem->setPrice($item['price']);

                // Mise à jour du stock
                $product = $item['product'];
                if ($product->isWeightBased()) {
                    $stockByWeight = $product->getStockByWeight();
                    if (isset($stockByWeight[$item['weight']])) {
                        $stockByWeight[$item['weight']] -= $item['quantity'];
                        $product->setStockByWeight($stockByWeight);
                    } else {
                        throw new \LogicException('Le poids selectionné n\'a pas de stock associé');
                    }
                } else {
                    $product->setStock($product->getStock() - $item['quantity']);
                }

                $entityManager->persist($product);
                $entityManager->persist($orderItem);
            }

            $entityManager->persist($order);
            $entityManager->flush();

            $cartService->remove('cart');

            $this->addFlash('success', 'Votre commande a été enregistrée avec succès ! ');
        } catch (\Exception $e) {
            $this->addFlash('danger', 'Une erreur est survenue lors de la commande: ' . $e->getMessage());
        }

        return $this->redirectToRoute('order_index');
    }



    #[Route('{id}', name: 'show')]
    public function show(int $id, OrderRepository $orderRepository): Response
    {
        $order = $orderRepository->find($id);

        if (!$order || $order->getUser() !== $this->getUser()) {
            throw $this->createNotFoundException('Commande introuvable.');
        }

        return $this->render('order/show.html.twig', [
            'order' => $order,
        ]);
    }

    #[Route('/checkout', name: 'checkout')]
    public function checkout(CartService $cartService): Response
    {
        return $this->render('order/checkout.html.twig', [
            'controller_name' => 'OrderController',
            'cartItems' => $cartService->getCart(),  // ✅ Envoi du panier
            'total' => $cartService->getTotal(), // ✅ Envoi du total
        ]);
    }
}
