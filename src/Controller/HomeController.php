<?php
// src/Controller/HomeController.php
namespace App\Controller;

use App\Entity\User;
use App\Form\NewsletterType;
use App\Repository\ProductRepository;
use App\Service\CartService;
use Symfony\Bridge\Twig\Mime\TemplatedEmail;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Address;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(
        Request $request,
        ProductRepository $productRepository,
        CartService $cartService,
        MailerInterface $mailer   // 👈 on injecte MailerInterface
    ): Response {
        $randomProducts = $productRepository->findBy([], [], 5);
        $cartItems       = $cartService->getCart();
        $total           = $cartService->getTotal();

        $user = $this->getUser();
        $profilePicture = 'images/default/avatar1.webp';
        if ($user instanceof User && $user->getProfilePicture()) {
            $profilePicture = 'images/profiles/' . $user->getProfilePicture();
        }

        // ── Formulaire Newsletter ──
        $newsletterForm = $this->createForm(NewsletterType::class);
        $newsletterForm->handleRequest($request);

        if ($newsletterForm->isSubmitted() && $newsletterForm->isValid()) {
            $data = $newsletterForm->getData();
            $emailAddress = $data['email'];

            // 1) Envoi de l'email de bienvenue
            $email = (new TemplatedEmail())
                ->from(new Address('newsletter@relaxcbdshop.com', 'Relax CBD Shop'))
                ->to($emailAddress)
                ->subject('Bienvenue chez Relax CBD Shop !')
                ->htmlTemplate('email/newsletter_welcome.html.twig')
                ->context([
                    // variables disponibles dans le template
                    'subscriberEmail' => $emailAddress,
                ]);
            $mailer->send($email);

            // 2) Confirmation à l’utilisateur
            $this->addFlash('success', 'Merci pour votre inscription ! Un e-mail de bienvenue vous a été envoyé.');

            // Empêche la réaffichage de la modal
            return $this->redirectToRoute('home');
        }

        return $this->render('home/index.html.twig', [
            'randomProducts'  => $randomProducts,
            'cartItems'       => $cartItems,
            'total'           => $total,
            'profilePicture'  => $profilePicture,
            'newsletterForm'  => $newsletterForm->createView(),
        ]);
    }
}
