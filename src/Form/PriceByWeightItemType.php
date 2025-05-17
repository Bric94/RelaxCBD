<?php

namespace App\Form;

use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class PriceByWeightItemType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options)
    {
        $builder
            ->add('min', IntegerType::class, [
                'label' => 'Min (g)',
                'required' => true,
            ])
            ->add('max', IntegerType::class, [
                'label' => 'Max (g)',
                'required' => false, // null = illimité
            ])
            ->add('price', NumberType::class, [
                'label' => 'Prix par g (€)',
                'scale' => 2,
                'required' => true,
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver)
    {
        $resolver->setDefaults([
            'data_class' => null, // On stocke un array simple
        ]);
    }
}
