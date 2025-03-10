/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.10-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: u495628816_relax_cbd_shop
-- ------------------------------------------------------
-- Server version	10.11.10-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `blog_post`
--

DROP TABLE IF EXISTS `blog_post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blog_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `excerpt` longtext NOT NULL,
  `image_name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BA5AE01DF675F31B` (`author_id`),
  KEY `IDX_BA5AE01D12469DE2` (`category_id`),
  CONSTRAINT `FK_BA5AE01D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  CONSTRAINT `FK_BA5AE01DF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blog_post`
--

LOCK TABLES `blog_post` WRITE;
/*!40000 ALTER TABLE `blog_post` DISABLE KEYS */;
/*!40000 ALTER TABLE `blog_post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES
(1,'Fleurs de CBD','<div>Les fleurs de CBD sont des bourgeons issus du chanvre, riches en cannabinoïdes, et utilisées pour la détente et le bien-être. Elles se déclinent en plusieurs types selon leur mode de culture et leur qualité :<br><br></div><ul><li><strong>🌱 Fleurs Indoor</strong> : Cultivées en intérieur pour une qualité premium et des arômes intenses.</li><li><strong>🌞 Fleurs Outdoor</strong> : Cultivées en extérieur, offrant un goût plus naturel et un rapport qualité/prix intéressant.</li><li><strong>🏡 Fleurs Greenhouse</strong> : Issues de serres, elles combinent qualité et accessibilité.</li><li><strong>💎 Fleurs Premium</strong> : Sélection de variétés haut de gamme aux arômes puissants et aux effets optimisés.</li><li><strong>🍃 Fleurs Bio</strong> : Cultivées sans pesticides ni engrais chimiques, pour une expérience plus naturelle.</li><li><strong>🌿 Trim &amp; Petites Buds</strong> : Mélanges de petites fleurs et de résidus de manucure, parfaits pour une consommation économique.</li></ul><pre>+ 🌱 Idéal pour une expérience naturelle et authentique.\r\n- 🚫 Ne pas confondre avec du cannabis récréatif (faible taux de THC).</pre>'),
(2,'Résines & Hash CBD','<div>Les résines de CBD sont des concentrés issus des fleurs, offrant des effets plus puissants et des arômes authentiques.<br><br></div><ul><li><strong>🧱 Hash CBD classique</strong> : Résine compacte aux saveurs variées, souvent inspirée des traditions marocaines ou libanaises.</li><li><strong>❄️ Hash filtré (Ice-O-Lator, Dry Sift)</strong> : Résine obtenue par extraction à froid, offrant une pureté et une concentration élevées en CBD.</li><li><strong>🌼 Pollen CBD</strong> : Une version plus légère et poudreuse du hash, riche en terpènes et en saveurs naturelles.</li><li><strong>🔥 Wax &amp; Crumble</strong> : Extraits ultra-concentrés en CBD, parfaits pour la vaporisation ou le dabbing.</li></ul><pre>⚠️ Puissance élevée : parfait pour les amateurs de grosse détente.</pre>'),
(3,'Huiles de CBD','<div>Les huiles de CBD sont une des formes les plus populaires de consommation, offrant une absorption rapide et des effets prolongés.<br><br></div><ul><li><strong>💧 Huiles Full Spectrum</strong> : Contiennent tous les cannabinoïdes (<em>y compris une trace de THC &lt;0,3%</em>) pour un effet d’entourage optimal.</li><li><strong>🔵 Huiles Broad Spectrum</strong> : Similaires aux Full Spectrum, mais sans THC, pour un équilibre entre efficacité et légalité.</li><li><strong>⚪ Huiles Isolat (sans THC)</strong> : <em>CBD pur</em>, idéal pour ceux qui veulent éviter toute trace de THC.</li><li><strong>🍃 Huiles CBD Bio</strong> : Formulées avec des ingrédients issus de l’agriculture biologique pour une consommation plus saine.</li><li><strong>🐶 Huiles CBD pour animaux</strong> : Spécialement conçues pour le bien-être des chiens et chats.</li></ul>'),
(4,'E-liquides & Vapes CBD','<div>Pour ceux qui préfèrent inhaler le CBD, les e-liquides et vapes sont une alternative rapide et efficace.<br><br></div><ul><li><strong>💨 E-liquides CBD (Nicotine Free)</strong> : Liquides pour cigarettes électroniques, sans nicotine, disponibles en plusieurs saveurs.</li><li><strong>🎯 Cartouches pré-remplies</strong> : Pratiques et prêtes à l’emploi pour les stylos vapes et pods compatibles.</li><li><strong>🔋 CBD Vapes &amp; Pods</strong> : Dispositifs dédiés à la vaporisation du CBD, combinant simplicité et efficacité.</li><li><strong>🧊 Cristaux de CBD pour DIY</strong> : CBD pur sous forme cristalline, idéal pour créer ses propres e-liquides ou huiles.</li></ul><pre>+ Effet rapide et biodisponibilité élevée \r\n- Peut irriter la gorge chez certaines personnes </pre>'),
(5,'Infusions & Tisanes CBD','<div>Les infusions au CBD combinent les bienfaits des plantes et du chanvre pour favoriser détente et bien-être.<br><br></div><ul><li><strong>☕ Tisanes Relaxantes</strong> : Plantes apaisantes + CBD pour améliorer le sommeil.</li><li><strong>🌿 Infusions Anti-stress</strong> : Formules pour soulager le stress et l’anxiété.</li><li><strong>🍋 Infusions Detox</strong> : Aident à purifier l’organisme naturellement.</li><li><strong>🫖 Thé &amp; Rooibos CBD</strong> : Saveurs variées pour une dégustation bien-être.</li></ul><pre> Meilleur moment : en soirée pour un effet apaisant </pre>'),
(6,'Cosmétiques au CBD','<div>Le CBD en application cutanée pour hydrater, réparer et apaiser la peau.<br><br></div><ul><li><strong>🧴 Crèmes et baumes</strong> : Pour les douleurs musculaires, l’hydratation et l’irritation.</li><li><strong>💆 Sérums &amp; huiles</strong> : Anti-imperfections et hydratants.</li><li><strong>🛀 Shampoings &amp; soins capillaires</strong> : Favorisent la santé des cheveux.</li><li><strong>💋 Baumes à lèvres</strong> : Nourrissent et protègent.</li></ul><pre> Bon à savoir : Anti-inflammatoire et hydratant </pre>'),
(7,'Compléments alimentaires CBD','<div>Le CBD sous forme de compléments pour un usage quotidien.<br><br></div><ul><li><strong>💊 Gélules CBD</strong> : Dosage précis et absorption facile.</li><li><strong>🍬 Gommes &amp; bonbons</strong> : Gourmand et pratique.</li><li><strong>🍯 Miel &amp; édulcorants</strong> : Pour une consommation plus douce.</li><li><strong>🏋️‍♂️ Protéines &amp; boosters</strong> : Pour le bien-être et la récupération.</li></ul><pre> + 🥇 Idéal pour une prise quotidienne sans goût de chanvre. </pre>'),
(8,'Produits alimentaires CBD','<div>Une gamme de produits gourmands infusés au CBD.<br><br></div><ul><li><strong>🍫 Chocolats &amp; biscuits</strong> : Délicieux et relaxants.</li><li><strong>🥤 Boissons au CBD</strong> : Eau, thé glacé et autres boissons infusées.</li><li><strong>🍬 Bonbons &amp; gummies</strong> : Un plaisir sucré à emporter partout.</li><li><strong>🍯 Miel et sucres CBD</strong> : Idéal pour sucrer vos infusions.</li></ul><pre>🧑‍🍳 Ajoutez du CBD à votre cuisine pour une expérience unique !</pre>'),
(9,'Produits pour animaux','<div>Le CBD pour soulager le stress et les douleurs des compagnons à quatre pattes.<br><br></div><ul><li><strong>🐾 Huiles CBD</strong> : Spécialement dosées pour chiens et chats.</li><li><strong>🦴 Friandises CBD</strong> : Une prise facile et savoureuse.</li><li><strong>🧬 Compléments bien-être</strong> : Adaptés aux besoins des animaux.</li></ul>'),
(10,'Accessoires','<div>Tous les indispensables pour une expérience CBD optimale.<br><br></div><ul><li><strong>💨 Vapoteuses &amp; Vapes</strong> : Pour e-liquides et concentrés.</li><li><strong>🌿 Grinders &amp; Broyeurs</strong> : Pour moudre parfaitement les fleurs.</li><li><strong>📜 Papiers à rouler &amp; Filtres</strong> : Essentiels pour rouler vos propres mélanges.</li><li><strong>🔥 Briquets &amp; torchs</strong> : Outils pratiques.</li><li><strong>💨 Bongs &amp; pipes</strong> : Pour une consommation filtrée et douce.</li></ul><pre> Des accessoires pour chaque mode de consommation </pre>');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `message` longtext NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `object` varchar(255) NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES
(1,'Eliott','eliottbricout@yahoo.fr','My bad mother fucker','Bricout','Je souhaite devenir développeur','2025-03-05'),
(2,'Eliott','eliottbricout@yahoo.fr','HAHAHAHAH','Bricout','Je souhaite devenir développeur','2025-03-05'),
(3,'Eliott','eliottbricout@yahoo.fr','Bretz','Bricout','Je souhaite devenir formateur','2025-03-05'),
(4,'Eliott','eliottbricout@yahoo.fr','Bretz','Bricout','Je souhaite devenir formateur','2025-03-05'),
(5,'Eliott','eliottbricout@yahoo.fr','ertegdg','Bricout','Je souhaite devenir développeur','2025-03-05'),
(6,'Eliott','eliottbricout@yahoo.fr','ertegdg','Bricout','Je souhaite devenir développeur','2025-03-05'),
(7,'Eliott','eliottbricout@yahoo.fr','ertegdg','Bricout','Je souhaite devenir développeur','2025-03-05'),
(8,'Eliott','eliottbricout@yahoo.fr','ertegdg','Bricout','Je souhaite devenir développeur','2025-03-05'),
(9,'Eliott','eliottbricout@yahoo.fr','HASgiujshqcdfb','Bricout','Je souhaite devenir développeur','2025-03-05'),
(10,'Eliott','eliottbricout@yahoo.fr','yzutgedauyzegdf','Bricout','Je souhaite devenir développeur','2025-03-05'),
(11,'Eliott','eliottbricout@yahoo.fr','Hddhg','Bricout','Je souhaite devenir développeur','2025-03-05'),
(12,'Eliott','eliottbricout@yahoo.fr','sdfdfsvd','Bricout','Je souhaite devenir formateur','2025-03-05'),
(13,'Eliott','eliottbricout@yahoo.fr','J memmerde','Bricout','Je souhaite devenir développeur','2025-03-05'),
(14,'Kendall','kendall.dewis@gmail.com','je suis pas antisémite','Oliver','Je souhaite postuler','2025-03-05'),
(15,'Jamy','Jamy.Senlabeu@kush.com','Bonjour, j\'aime grave la cons et je suis motivé, inshallah un poste a pourvoir svp','Senlabeu','Je souhaite postuler','2025-03-05'),
(16,'Orange','xswany@gmail.com','Jveux former les gens a fumer de la bonne beuh','Bud','Je souhaite devenir formateur','2025-03-05');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount`
--

DROP TABLE IF EXISTS `discount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `percentage` double NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount`
--

LOCK TABLES `discount` WRITE;
/*!40000 ALTER TABLE `discount` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `discount_product`
--

DROP TABLE IF EXISTS `discount_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `discount_product` (
  `discount_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`discount_id`,`product_id`),
  KEY `IDX_654269BC4C7C611F` (`discount_id`),
  KEY `IDX_654269BC4584665A` (`product_id`),
  CONSTRAINT `FK_654269BC4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `FK_654269BC4C7C611F` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `discount_product`
--

LOCK TABLES `discount_product` WRITE;
/*!40000 ALTER TABLE `discount_product` DISABLE KEYS */;
/*!40000 ALTER TABLE `discount_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES
('DoctrineMigrations\\Version20250304131824','2025-03-04 13:19:56',77),
('DoctrineMigrations\\Version20250305104326','2025-03-05 12:28:00',4),
('DoctrineMigrations\\Version20250305105759','2025-03-05 12:28:00',3),
('DoctrineMigrations\\Version20250306124952','2025-03-06 12:51:58',55),
('DoctrineMigrations\\Version20250306130406','2025-03-06 13:57:45',5);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) DEFAULT NULL,
  `total_amount` double NOT NULL,
  `created_at` datetime NOT NULL,
  `status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_90651744CFFE9AD6` (`orders_id`),
  CONSTRAINT `FK_90651744CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messenger_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `body` longtext NOT NULL,
  `headers` longtext NOT NULL,
  `queue_name` varchar(190) NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messenger_messages`
--

LOCK TABLES `messenger_messages` WRITE;
/*!40000 ALTER TABLE `messenger_messages` DISABLE KEYS */;
INSERT INTO `messenger_messages` VALUES
(1,'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:173:\\\"https://cbd.eliott-bricout.fr/verify/email?expires=1741173691&signature=QU7jd7lKFVDcDgBMoZWYXXodRvWeMjybyXMtJLkKUgg%3D&token=MIFxQJv%2BGwrNHksQfqhQYVhMZyLYD28tW8GNlAMrP8A%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:19:\\\"infos@relax-cbd.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:14:\\\"Relax CBD Shop\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"eliottbricout@yahoo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}','[]','default','2025-03-05 10:21:31','2025-03-05 10:21:31',NULL),
(2,'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:23:\\\"email/contact.html.twig\\\";i:1;N;i:2;a:1:{s:7:\\\"contact\\\";O:18:\\\"App\\\\Entity\\\\Contact\\\":7:{s:22:\\\"\\0App\\\\Entity\\\\Contact\\0id\\\";i:1;s:29:\\\"\\0App\\\\Entity\\\\Contact\\0firstName\\\";s:6:\\\"Eliott\\\";s:28:\\\"\\0App\\\\Entity\\\\Contact\\0lastName\\\";s:7:\\\"Bricout\\\";s:25:\\\"\\0App\\\\Entity\\\\Contact\\0email\\\";s:22:\\\"eliottbricout@yahoo.fr\\\";s:26:\\\"\\0App\\\\Entity\\\\Contact\\0object\\\";s:32:\\\"Je souhaite devenir développeur\\\";s:27:\\\"\\0App\\\\Entity\\\\Contact\\0message\\\";s:20:\\\"My bad mother fucker\\\";s:24:\\\"\\0App\\\\Entity\\\\Contact\\0date\\\";O:8:\\\"DateTime\\\":3:{s:4:\\\"date\\\";s:26:\\\"2025-03-05 13:20:03.570727\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:4:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:20:\\\"rocketbric@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:20:\\\"rocketbric@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"cc\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"Cc\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"eliottbricout@yahoo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:11:\\\"Votre email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}','[]','default','2025-03-05 13:20:03','2025-03-05 13:20:03',NULL);
/*!40000 ALTER TABLE `messenger_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `total_price` double NOT NULL,
  `status` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`),
  CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `orders_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_52EA1F09CFFE9AD6` (`orders_id`),
  KEY `IDX_52EA1F094584665A` (`product_id`),
  CONSTRAINT `FK_52EA1F094584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_52EA1F09CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `order` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `price` double NOT NULL,
  `stock` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_weight_based` tinyint(1) NOT NULL,
  `price_by_weight` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`price_by_weight`)),
  `stock_by_weight` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`stock_by_weight`)),
  `discount_by_weight` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`discount_by_weight`)),
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`),
  CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES
(1,NULL,'Amnesia','🌿 Amnesia CBD - Une Fleur Puissante et Énergisante 🌿\r\nPlongez dans l\'univers captivant de l\'Amnesia CBD, une fleur de chanvre réputée pour son profil aromatique intense et ses effets équilibrés. Inspirée de la célèbre Amnesia Haze, cette variété combine des saveurs citronnées et terreuses avec des notes subtiles d’épices et de pin, offrant une expérience sensorielle unique.\r\n\r\n💨 Arômes & Saveurs\r\n\r\nAgrumes (citron, orange)\r\nNotes terreuses et épicées\r\nLégère touche sucrée en fin de bouche\r\n⚡ Effets\r\nGrâce à son taux élevé de CBD, l’Amnesia CBD est parfaite pour favoriser la relaxation tout en stimulant la créativité et la concentration. Elle est idéale pour une consommation en journée, procurant une sensation de bien-être sans effet psychotrope.\r\n\r\n✅ Caractéristiques\r\n\r\nTaux de CBD : Élevé (variant selon le lot)\r\nTaux de THC : < 0,3% (conforme à la législation européenne)\r\nCulture : Indoor/Greenhouse\r\nAspect : Têtes denses, résineuses, aux teintes vert clair et orangées\r\n🌱 Idéale pour\r\n\r\nSe détendre sans somnolence\r\nStimuler la créativité et la concentration\r\nSoulager le stress et les tensions quotidiennes\r\n🔬 Qualité Premium\r\nNotre Amnesia CBD est soigneusement sélectionnée et cultivée sans pesticides ni additifs chimiques, garantissant une expérience authentique et naturelle.\r\n\r\n📦 Disponible en plusieurs grammages avec des tarifs dégressifs.\r\n\r\nEssayez l\'Amnesia CBD et laissez-vous emporter par ses arômes envoûtants et ses effets revitalisants ! 🚀',8,100,'2025-03-06 12:53:00',NULL,1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `review` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` longtext DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_794381C6A76ED395` (`user_id`),
  KEY `IDX_794381C64584665A` (`product_id`),
  CONSTRAINT `FK_794381C64584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  CONSTRAINT `FK_794381C6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review`
--

LOCK TABLES `review` WRITE;
/*!40000 ALTER TABLE `review` DISABLE KEYS */;
/*!40000 ALTER TABLE `review` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`roles`)),
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES
(1,'eliottbricout@yahoo.fr','$2y$13$Ux/hvWEW15YGa3NpxMztyuqetHVqwokfDgH2HP16DJJd/g3NGGiLS','[\"ROLE_ADMIN\"]','Eliott','Bricout','2025-03-05 10:21:31',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-10 12:40:23
