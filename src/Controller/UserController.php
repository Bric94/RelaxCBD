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
        $user = $this->getUser();

        // Liste des avatars par défaut
        $defaultAvatars = [
            'Avatar1.webp',
            'Avatar2.webp',
            'Avatar3.webp',
            'Avatar4.webp',
            'Avatar5.webp',
            'Avatar6.webp',
            'Avatar7.webp',
            'Avatar8.webp',
            'Avatar9.webp',
            'Avatar10.webp'
        ];

        // Sélection d'un avatar aléatoire si l'utilisateur n'a pas uploadé de photo
        $randomAvatar = $defaultAvatars[array_rand($defaultAvatars)];

        return $this->render('user/index.html.twig', [
            'user' => $user,
            'randomAvatar' => $randomAvatar // Passe l'avatar par défaut à Twig
        ]);
    }


    #[Route('/edit', name: 'edit')]
    public function editProfile(Request $request, EntityManagerInterface $entityManager, SluggerInterface $slugger): Response
    {
        /** @var User $user */
        $user = $this->getUser();

        $form = $this->createForm(ProfilePictureType::class, $user);
        $form->handleRequest($request);


        if ($form->isSubmitted() && $form->isValid()) {
                $imageFile = $form->get('profilePicture')->getData();
                if ($imageFile) {
                    $originalFilename = pathinfo($imageFile->getClientOriginalName(), PATHINFO_FILENAME);
                    $safeFilename = $slugger->slug($originalFilename);
                    $newFilename = $safeFilename . '-' . uniqid() . '.' . $imageFile->guessExtension();

                    $imageFile->move($this->getParameter('profiles_directory'), $newFilename);
                    $user->setProfilePicture($newFilename);
                }

                $entityManager->persist($user);
                $entityManager->flush();

                $this->addFlash('success', 'Photo de profil mise à jour avec succès !');
                return $this->redirectToRoute('user_index');
            }
            
            return $this->render('user/edit.html.twig', [
                'form' => $form->createView(),
        ]);
    }
}
