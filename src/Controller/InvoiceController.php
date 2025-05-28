<?php

namespace App\Controller;

use App\Entity\Invoice;
use App\Repository\OrderRepository;
use App\Repository\InvoiceRepository;
use Doctrine\ORM\EntityManagerInterface;
use Dompdf\Dompdf;
use Dompdf\Options;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class InvoiceController extends AbstractController
{
    #[Route('/order/{id}/invoice', name: 'order_invoice')]
    public function invoice(
        int $id,
        OrderRepository $orderRepo,
        InvoiceRepository $invoiceRepo,
        EntityManagerInterface $em
    ): Response {
        $order = $orderRepo->find($id);
        if (!$order) {
            throw $this->createNotFoundException('Commande introuvable.');
        }

        $invoice = $invoiceRepo->findOneBy(['orders' => $order])
            ?: new Invoice();

        if (null === $invoice->getId()) {
            $invoice
                ->setOrders($order)
                ->setTotalAmount($order->getTotalPrice())
                ->setCreatedAt(new \DateTime())
                ->setStatus('issued');
            $em->persist($invoice);
            $em->flush();
        }

        $options = new Options();
        $options->set('defaultFont', 'Helvetica');
        $dompdf = new Dompdf($options);

        $html = $this->renderView('invoice/invoice.html.twig', [
            'order'   => $order,
            'invoice' => $invoice,
        ]);
        $dompdf->loadHtml($html);
        $dompdf->setPaper('A4', 'portrait');
        $dompdf->render();

        $pdfOutput = $dompdf->output();

        $filename = sprintf('facture-%s.pdf', $order->getOrderNumber());
        return new Response($pdfOutput, 200, [
            'Content-Type'        => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="' . $filename . '"',
        ]);
    }
}
