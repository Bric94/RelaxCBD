<?php

namespace App\Command;

use Doctrine\ORM\EntityManagerInterface;
use Doctrine\Persistence\Mapping\ClassMetadata;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Symfony\Component\Filesystem\Filesystem;

#[AsCommand(name: 'app:generate-fixtures', description: 'Génère un fichier de fixtures basé sur les données de la base de données.')]
class GenerateFixturesCommand extends Command
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->entityManager = $entityManager;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $filesystem = new Filesystem();

        // Récupérer toutes les entités connues par Doctrine
        $metadata = $this->entityManager->getMetadataFactory()->getAllMetadata();
        $fixtureCode = "<?php\n\nnamespace App\DataFixtures;\n\n";
        $fixtureCode .= "use Doctrine\\Bundle\\FixturesBundle\\Fixture;\n";
        $fixtureCode .= "use Doctrine\\Persistence\\ObjectManager;\n";

        // Importer les classes des entités
        foreach ($metadata as $meta) {
            $fixtureCode .= "use " . $meta->getName() . ";\n";
        }

        $fixtureCode .= "\nclass AppFixtures extends Fixture\n{\n";
        $fixtureCode .= "    public function load(ObjectManager \$manager): void\n    {\n";

        foreach ($metadata as $meta) {
            $entityClass = $meta->getName();
            $repository = $this->entityManager->getRepository($entityClass);
            $entities = $repository->findAll();

            foreach ($entities as $entity) {
                $entityShortName = (new \ReflectionClass($entity))->getShortName();
                $fixtureCode .= "        \$object = new $entityShortName();\n";

                // Récupérer les propriétés et leurs valeurs
                foreach ($meta->getFieldNames() as $field) {
                    $getter = 'get' . ucfirst($field);
                    if (method_exists($entity, $getter)) {
                        $value = $entity->$getter();
                        if (is_string($value)) {
                            $value = '"' . addslashes($value) . '"';
                        } elseif (is_bool($value)) {
                            $value = $value ? 'true' : 'false';
                        } elseif ($value instanceof \DateTime) {
                            $value = '"' . $value->format('Y-m-d H:i:s') . '"';
                        } elseif (is_array($value)) {
                            // Convertir un tableau en JSON
                            $value = '"' . addslashes(json_encode($value)) . '"';
                        } elseif (is_object($value) && method_exists($value, '__toString')) {
                            // Si l'objet a une méthode __toString, on l\'utilise
                            $value = '"' . addslashes((string) $value) . '"';
                        } elseif (is_null($value)) {
                            $value = 'null';
                        } else {
                            // Pour tout autre type (ex : integer, float)
                            $value = var_export($value, true);
                        }


                        $fixtureCode .= "        \$object->set" . ucfirst($field) . "($value);\n";
                    }
                }

                $fixtureCode .= "        \$manager->persist(\$object);\n\n";
            }
        }

        $fixtureCode .= "        \$manager->flush();\n";
        $fixtureCode .= "    }\n";
        $fixtureCode .= "}\n";

        // Écrire le fichier de fixtures
        $fixturePath = 'src/DataFixtures/AppFixtures.php';
        $filesystem->dumpFile($fixturePath, $fixtureCode);
        $io->success("Le fichier de fixtures a été généré avec succès : $fixturePath");

        return Command::SUCCESS;
    }
}
