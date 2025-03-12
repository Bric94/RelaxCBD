<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250310134135 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE product CHANGE price_by_weight price_by_weight JSON DEFAULT NULL, CHANGE stock_by_weight stock_by_weight JSON DEFAULT NULL, CHANGE discount_by_weight discount_by_weight JSON DEFAULT NULL');
        $this->addSql('ALTER TABLE user ADD profile_picture VARCHAR(255) DEFAULT NULL, CHANGE roles roles JSON NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE user DROP profile_picture, CHANGE roles roles LONGTEXT NOT NULL COLLATE `utf8mb4_bin`');
        $this->addSql('ALTER TABLE product CHANGE discount_by_weight discount_by_weight LONGTEXT DEFAULT NULL COLLATE `utf8mb4_bin`, CHANGE price_by_weight price_by_weight LONGTEXT DEFAULT NULL COLLATE `utf8mb4_bin`, CHANGE stock_by_weight stock_by_weight LONGTEXT DEFAULT NULL COLLATE `utf8mb4_bin`');
    }
}
