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

    // ✅ Création de la commande avec un statut par défaut
    $order = new Order();
    $order->setUser($user);
    $order->setTotalPrice($total);
    $order->setCreatedAt(new \DateTime());
    $order->setStatus('pending'); // ✅ Ajout du statut

    foreach ($cartItems as $id => $item) {
        $orderItem = new OrderItem();
        $orderItem->setOrders($order);
        $orderItem->setProduct($item['product']);
        $orderItem->setQuantity($item['quantity']);
        $orderItem->setPrice($item['product']->getPrice());

        $entityManager->persist($orderItem);
    }

    $entityManager->persist($order);
    $entityManager->flush();

    $cartService->clear();

    $this->addFlash('success', 'Votre commande a été enregistrée avec succès ! 🚀');

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
