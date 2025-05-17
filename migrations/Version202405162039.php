<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20240516XXXXXX extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Migration manuelle pour corriger les données price_by_weight';
    }

    public function up(Schema $schema): void
    {
        // Remets à zéro les colonnes corrompues (exemple)
        $this->addSql("UPDATE product SET price_by_weight = NULL WHERE price_by_weight IS NOT NULL");
    }

    public function down(Schema $schema): void
    {
        // Optionnel
    }
}
