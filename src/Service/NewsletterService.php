<?php

namespace App\Service;

use App\Entity\NewsletterSubscriber;
use Symfony\Component\Mailer\MailerInterface;
use Symfony\Component\Mime\Email;
use Twig\Environment;

class NewsletterService
{
    public function __construct(
        private MailerInterface $mailer,
        private Environment $twig
    ) {}

    public function send(
        NewsletterSubscriber $subscriber,
        string $subject,
        string $template,
        array $context = []
    ): void {
        $body = $this->twig->render($template, [
            'subscriber' => $subscriber,
            'subject' => $subject,
            ...$context,
        ]);

        $email = (new Email())
            ->from('no-reply@example.com')
            ->to($subscriber->getEmail())
            ->subject($subject)
            ->html($body);

        $this->mailer->send($email);
    }
}
