<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\ProfilePictureType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\String\Slugger\SluggerInterface;

#[Route('/user', name: 'user_')]
class UserController extends AbstractController
{
    #[Route('/', name: 'index')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function index(): Response
    {
        return $this->render('user/index.html.twig', [
            'user' => $this->getUser(),
        ]);
    }

    #[Route('/edit', name: 'edit')]
    public function editProfile(Request $request, EntityManagerInterface $entityManager, SluggerInterface $slugger): Response
    {
        /** @var User $user */
        $user = $this->getUser(); // Récupération de l'utilisateur connecté

        $form = $this->createForm(ProfilePictureType::class, $user);
        $form->handleRequest($request);


        if ($form->isSubmitted() && $form->isValid()) {
            $imageFile = $form->get('profilePicture')->getData();

            if ($imageFile) {
                $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);
                $safeFilename = $slugger->slug($originalFilename);
                $newFilename = $safeFilename . '-' . uniqid() . '.' . $imageFile->guessExtension();

                // Déplace le fichier dans le dossier public/images/profiles/
                $imageFile->move($this->getParameter('profiles_directory'), $newFilename);

                // Met à jour le profil utilisateur
                $user->setProfilePicture($newFilename);
            }

            $entityManager->persist($user);
            $entityManager->flush();

            return $this->redirectToRoute('user_index');
        }

        return $this->render('user/edit.html.twig', [
            'form' => $form->createView(),
        ]);
    }
}
