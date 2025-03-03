<?php

namespace App\Controller;

use App\Service\StripeService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

class PaymentController extends AbstractController
{
    #[Route('/create-checkout-session', name: 'payment_create_session', methods: ['POST'])]
    public function createCheckoutSession(StripeService $stripeService, Request $request): JsonResponse
    {
        $lineItems = [
            'price_data' => [
                'currency' => 'eur',
                'product_data' => [
                    'name' => 'Produit test',
                ],
                'unit_amount' => 2000, // 20.00€
            ],
            'quantity' => 1,
        ];

        $session = $stripeService->createCheckoutSession(
            $lineItems,
            $this->generateUrl('app_success', [], 0),
            $this->generateUrl('app_cancel', [], 0)
        );

        return $this->json(['id' => $session->id]);
    }

    #[Route('/payment-success', name: 'app_success')]
    public function paymentSuccess()
    {
        return $this->render('payment/success.html.twig');
    }

    #[Route('/payment-cancel', name: 'app_cancel')]
    public function paymentCancel()
    {
        return $this->render('payment/cancel.html.twig');
    }
}
