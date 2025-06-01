<?php

namespace App\Controller;

use App\Entity\NewsletterSubscriber;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class NewsletterController extends AbstractController
{
    #[Route('/newsletter/subscribe', name: 'newsletter_subscribe', methods: ['POST'])]
    public function subscribe(Request $request, EntityManagerInterface $em): Response
    {
        $email = trim($request->request->get('email', ''));

        // Validation email très basique
        if (!$email || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $message = 'Email invalide';
            if ($request->isXmlHttpRequest()) {
                return new JsonResponse(['success' => false, 'message' => $message], 400);
            }
            $this->addFlash('error', $message);
            return $this->redirectToRoute('home');
        }

        // Vérifier l'existence
        $repo = $em->getRepository(NewsletterSubscriber::class);
        $existing = $repo->findOneBy(['email' => $email]);
        if ($existing) {
            $message = 'Cet email est déjà inscrit à la newsletter.';
            if ($request->isXmlHttpRequest()) {
                return new JsonResponse(['success' => false, 'message' => $message], 409);
            }
            $this->addFlash('info', $message);
            return $this->redirectToRoute('home');
        }

        $subscriber = new NewsletterSubscriber();
        $subscriber->setEmail($email);

        // Si utilisateur connecté, lie le user
        if ($this->getUser()) {
            $subscriber->setUser($this->getUser());
        }

        $em->persist($subscriber);
        $em->flush();

        $message = 'Merci pour votre inscription !';
        if ($request->isXmlHttpRequest()) {
            return new JsonResponse(['success' => true, 'message' => $message]);
        }

        $this->addFlash('success', $message);
        return $this->redirectToRoute('home');
    }
}
