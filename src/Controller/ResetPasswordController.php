<?php

// src/Controller/ResetPasswordController.php
namespace App\Controller;

use App\Entity\User;
use App\Form\ResetPasswordRequestFormType;
use App\Form\ResetPasswordFormType;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Twig\Attribute\Template;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Uid\Uuid;

class ResetPasswordController extends AbstractController
{
    #[Route('/reset-password', name: 'app_forgot_password_request')]
    #[Template('security/reset_password_request.html.twig')]
    public function request(Request $request, UserRepository $userRepository, MailerInterface $mailer, EntityManagerInterface $entityManager): Response
    {
        $form = $this->createForm(ResetPasswordRequestFormType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user = $userRepository->findOneBy(['email' => $form->get('email')->getData()]);
            if ($user) {
                $token = Uuid::v4()->toRfc4122();
                $user->setResetToken($token);
                $user->setResetTokenExpiresAt(new \DateTime('+1 hour'));
                $entityManager->flush();

                $email = (new Email())
                    ->from('no-reply@relaxcbdshop.fr')
                    ->to($user->getEmail())
                    ->subject('Réinitialisation de votre mot de passe')
                    ->html($this->renderView('email/password_reset_email.html.twig', [
                        'token' => $token
                    ]));
                $mailer->send($email);
                $this->addFlash('success', 'Un email vous a été envoyé.');
            }
            return $this->redirectToRoute('app_login');
        }

        return $this->render('security/reset_password_request.html.twig', [
            'requestForm' => $form->createView(),
        ]);
    }

    #[Route('/reset-password/{token}', name: 'app_reset_password')]
    #[Template('security/reset_password.html.twig')]
    public function reset(string $token, Request $request, UserRepository $userRepository, EntityManagerInterface $entityManager, UserPasswordHasherInterface $passwordHasher): Response
    {
        $user = $userRepository->findOneBy(['resetToken' => $token]);
        if (!$user || $user->getResetTokenExpiresAt() < new \DateTime()) {
            $this->addFlash('danger', 'Le lien de réinitialisation est invalide ou expiré.');
            return $this->redirectToRoute('app_forgot_password_request');
        }

        $form = $this->createForm(ResetPasswordFormType::class);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $user->setPassword(
                $passwordHasher->hashPassword(
                    $user,
                    $form->get('plainPassword')->getData()
                )
            );
            $user->setResetToken(null);
            $user->setResetTokenExpiresAt(null);
            $entityManager->flush();

            $this->addFlash('success', 'Mot de passe mis à jour. Vous pouvez vous connecter.');
            return $this->redirectToRoute('app_login');
        }

        return $this->render('security/reset_password.html.twig', [
            'resetForm' => $form->createView(),
        ]);
    }
}
