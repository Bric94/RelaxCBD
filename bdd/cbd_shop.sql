-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mer. 12 mars 2025 à 12:51
-- Version du serveur : 9.1.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `cbd_shop`
--

-- --------------------------------------------------------

--
-- Structure de la table `blog_post`
--

DROP TABLE IF EXISTS `blog_post`;
CREATE TABLE IF NOT EXISTS `blog_post` (
  `id` int NOT NULL AUTO_INCREMENT,
  `author_id` int DEFAULT NULL,
  `category_id` int DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `is_published` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_BA5AE01DF675F31B` (`author_id`),
  KEY `IDX_BA5AE01D12469DE2` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `category`
--

INSERT INTO `category` (`id`, `name`, `description`) VALUES
(1, 'Fleurs de CBD', '<div>Les fleurs de CBD sont des bourgeons issus du chanvre, riches en cannabinoïdes, et utilisées pour la détente et le bien-être. Elles se déclinent en plusieurs types selon leur mode de culture et leur qualité :<br><br></div><ul><li><strong>🌱 Fleurs Indoor</strong> : Cultivées en intérieur pour une qualité premium et des arômes intenses.</li><li><strong>🌞 Fleurs Outdoor</strong> : Cultivées en extérieur, offrant un goût plus naturel et un rapport qualité/prix intéressant.</li><li><strong>🏡 Fleurs Greenhouse</strong> : Issues de serres, elles combinent qualité et accessibilité.</li><li><strong>💎 Fleurs Premium</strong> : Sélection de variétés haut de gamme aux arômes puissants et aux effets optimisés.</li><li><strong>🍃 Fleurs Bio</strong> : Cultivées sans pesticides ni engrais chimiques, pour une expérience plus naturelle.</li><li><strong>🌿 Trim &amp; Petites Buds</strong> : Mélanges de petites fleurs et de résidus de manucure, parfaits pour une consommation économique.</li></ul><pre>+ 🌱 Idéal pour une expérience naturelle et authentique.\r\n- 🚫 Ne pas confondre avec du cannabis récréatif (faible taux de THC).</pre>'),
(2, 'Résines & Hash CBD', '<div>Les résines de CBD sont des concentrés issus des fleurs, offrant des effets plus puissants et des arômes authentiques.<br><br></div><ul><li><strong>🧱 Hash CBD classique</strong> : Résine compacte aux saveurs variées, souvent inspirée des traditions marocaines ou libanaises.</li><li><strong>❄️ Hash filtré (Ice-O-Lator, Dry Sift)</strong> : Résine obtenue par extraction à froid, offrant une pureté et une concentration élevées en CBD.</li><li><strong>🌼 Pollen CBD</strong> : Une version plus légère et poudreuse du hash, riche en terpènes et en saveurs naturelles.</li><li><strong>🔥 Wax &amp; Crumble</strong> : Extraits ultra-concentrés en CBD, parfaits pour la vaporisation ou le dabbing.</li></ul><pre>⚠️ Puissance élevée : parfait pour les amateurs de grosse détente.</pre>'),
(3, 'Huiles de CBD', '<div>Les huiles de CBD sont une des formes les plus populaires de consommation, offrant une absorption rapide et des effets prolongés.<br><br></div><ul><li><strong>💧 Huiles Full Spectrum</strong> : Contiennent tous les cannabinoïdes (<em>y compris une trace de THC &lt;0,3%</em>) pour un effet d\'entourage optimal.</li><li><strong>🔵 Huiles Broad Spectrum</strong> : Similaires aux Full Spectrum, mais sans THC, pour un équilibre entre efficacité et légalité.</li><li><strong>⚪ Huiles Isolat (sans THC)</strong> : <em>CBD pur</em>, idéal pour ceux qui veulent éviter toute trace de THC.</li><li><strong>🍃 Huiles CBD Bio</strong> : Formulées avec des ingrédients issus de l\'agriculture biologique pour une consommation plus saine.</li><li><strong>🐶 Huiles CBD pour animaux</strong> : Spécialement conçues pour le bien-être des chiens et chats.</li></ul>'),
(4, 'E-liquides & Vapes CBD', '<div>Pour ceux qui préfèrent inhaler le CBD, les e-liquides et vapes sont une alternative rapide et efficace.<br><br></div><ul><li><strong>💨 E-liquides CBD (Nicotine Free)</strong> : Liquides pour cigarettes électroniques, sans nicotine, disponibles en plusieurs saveurs.</li><li><strong>🎯 Cartouches pré-remplies</strong> : Pratiques et prêtes à l\'emploi pour les stylos vapes et pods compatibles.</li><li><strong>🔋 CBD Vapes &amp; Pods</strong> : Dispositifs dédiés à la vaporisation du CBD, combinant simplicité et efficacité.</li><li><strong>🧊 Cristaux de CBD pour DIY</strong> : CBD pur sous forme cristalline, idéal pour créer ses propres e-liquides ou huiles.</li></ul><pre>+ Effet rapide et biodisponibilité élevée \r\n- Peut irriter la gorge chez certaines personnes </pre>'),
(5, 'Infusions & Tisanes CBD', '<div>Les infusions au CBD combinent les bienfaits des plantes et du chanvre pour favoriser détente et bien-être.<br><br></div><ul><li><strong>☕ Tisanes Relaxantes</strong> : Plantes apaisantes + CBD pour améliorer le sommeil.</li><li><strong>🌿 Infusions Anti-stress</strong> : Formules pour soulager le stress et l\'anxiété.</li><li><strong>🍋 Infusions Detox</strong> : Aident à purifier l\'organisme naturellement.</li><li><strong>🫖 Thé &amp; Rooibos CBD</strong> : Saveurs variées pour une dégustation bien-être.</li></ul><pre> Meilleur moment : en soirée pour un effet apaisant </pre>'),
(6, 'Cosmétiques au CBD', '<div>Le CBD en application cutanée pour hydrater, réparer et apaiser la peau.<br><br></div><ul><li><strong>🧴 Crèmes et baumes</strong> : Pour les douleurs musculaires, l\'hydratation et l\'irritation.</li><li><strong>💆 Sérums &amp; huiles</strong> : Anti-imperfections et hydratants.</li><li><strong>🛀 Shampoings &amp; soins capillaires</strong> : Favorisent la santé des cheveux.</li><li><strong>💋 Baumes à lèvres</strong> : Nourrissent et protègent.</li></ul><pre> Bon à savoir : Anti-inflammatoire et hydratant </pre>'),
(7, 'Compléments alimentaires CBD', '<div>Le CBD sous forme de compléments pour un usage quotidien.<br><br></div><ul><li><strong>💊 Gélules CBD</strong> : Dosage précis et absorption facile.</li><li><strong>🍬 Gommes &amp; bonbons</strong> : Gourmand et pratique.</li><li><strong>🍯 Miel &amp; édulcorants</strong> : Pour une consommation plus douce.</li><li><strong>🏋️‍♂️ Protéines &amp; boosters</strong> : Pour le bien-être et la récupération.</li></ul><pre> + 🥇 Idéal pour une prise quotidienne sans goût de chanvre. </pre>'),
(8, 'Produits alimentaires CBD', '<div>Une gamme de produits gourmands infusés au CBD.<br><br></div><ul><li><strong>🍫 Chocolats &amp; biscuits</strong> : Délicieux et relaxants.</li><li><strong>🥤 Boissons au CBD</strong> : Eau, thé glacé et autres boissons infusées.</li><li><strong>🍬 Bonbons &amp; gummies</strong> : Un plaisir sucré à emporter partout.</li><li><strong>🍯 Miel et sucres CBD</strong> : Idéal pour sucrer vos infusions.</li></ul><pre>🧑‍🍳 Ajoutez du CBD à votre cuisine pour une expérience unique !</pre>'),
(9, 'Produits pour animaux', '<div>Le CBD pour soulager le stress et les douleurs des compagnons à quatre pattes.<br><br></div><ul><li><strong>🐾 Huiles CBD</strong> : Spécialement dosées pour chiens et chats.</li><li><strong>🦴 Friandises CBD</strong> : Une prise facile et savoureuse.</li><li><strong>🧬 Compléments bien-être</strong> : Adaptés aux besoins des animaux.</li></ul>'),
(10, 'Accessoires', '<div>Tous les indispensables pour une expérience CBD optimale.<br><br></div><ul><li><strong>💨 Vapoteuses &amp; Vapes</strong> : Pour e-liquides et concentrés.</li><li><strong>🌿 Grinders &amp; Broyeurs</strong> : Pour moudre parfaitement les fleurs.</li><li><strong>📜 Papiers à rouler &amp; Filtres</strong> : Essentiels pour rouler vos propres mélanges.</li><li><strong>🔥 Briquets &amp; torchs</strong> : Outils pratiques.</li><li><strong>💨 Bongs &amp; pipes</strong> : Pour une consommation filtrée et douce.</li></ul><pre> Des accessoires pour chaque mode de consommation </pre>');

-- --------------------------------------------------------

--
-- Structure de la table `contact`
--

DROP TABLE IF EXISTS `contact`;
CREATE TABLE IF NOT EXISTS `contact` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `object` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `contact`
--

INSERT INTO `contact` (`id`, `first_name`, `email`, `message`, `last_name`, `object`, `date`) VALUES
(1, 'Eliott', 'eliottbricout@yahoo.fr', 'My bad mother fucker', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(2, 'Eliott', 'eliottbricout@yahoo.fr', 'HAHAHAHAH', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(3, 'Eliott', 'eliottbricout@yahoo.fr', 'Bretz', 'Bricout', 'Je souhaite devenir formateur', '2025-03-05'),
(4, 'Eliott', 'eliottbricout@yahoo.fr', 'Bretz', 'Bricout', 'Je souhaite devenir formateur', '2025-03-05'),
(5, 'Eliott', 'eliottbricout@yahoo.fr', 'ertegdg', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(6, 'Eliott', 'eliottbricout@yahoo.fr', 'ertegdg', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(7, 'Eliott', 'eliottbricout@yahoo.fr', 'ertegdg', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(8, 'Eliott', 'eliottbricout@yahoo.fr', 'ertegdg', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(9, 'Eliott', 'eliottbricout@yahoo.fr', 'HASgiujshqcdfb', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(10, 'Eliott', 'eliottbricout@yahoo.fr', 'yzutgedauyzegdf', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(11, 'Eliott', 'eliottbricout@yahoo.fr', 'Hddhg', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(12, 'Eliott', 'eliottbricout@yahoo.fr', 'sdfdfsvd', 'Bricout', 'Je souhaite devenir formateur', '2025-03-05'),
(13, 'Eliott', 'eliottbricout@yahoo.fr', 'J memmerde', 'Bricout', 'Je souhaite devenir développeur', '2025-03-05'),
(14, 'Kendall', 'kendall.dewis@gmail.com', 'je suis pas antisémite', 'Oliver', 'Je souhaite postuler', '2025-03-05'),
(15, 'Jamy', 'Jamy.Senlabeu@kush.com', 'Bonjour, j\'aime grave la cons et je suis motivé, inshallah un poste a pourvoir svp', 'Senlabeu', 'Je souhaite postuler', '2025-03-05'),
(16, 'Orange', 'xswany@gmail.com', 'Jveux former les gens a fumer de la bonne beuh', 'Bud', 'Je souhaite devenir formateur', '2025-03-05');

-- --------------------------------------------------------

--
-- Structure de la table `discount`
--

DROP TABLE IF EXISTS `discount`;
CREATE TABLE IF NOT EXISTS `discount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `percentage` double NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `discount_product`
--

DROP TABLE IF EXISTS `discount_product`;
CREATE TABLE IF NOT EXISTS `discount_product` (
  `discount_id` int NOT NULL,
  `product_id` int NOT NULL,
  PRIMARY KEY (`discount_id`,`product_id`),
  KEY `IDX_654269BC4C7C611F` (`discount_id`),
  KEY `IDX_654269BC4584665A` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250304131824', '2025-03-04 13:19:56', 77),
('DoctrineMigrations\\Version20250305104326', '2025-03-05 12:28:00', 4),
('DoctrineMigrations\\Version20250305105759', '2025-03-05 12:28:00', 3),
('DoctrineMigrations\\Version20250306124952', '2025-03-06 12:51:58', 55),
('DoctrineMigrations\\Version20250306130406', '2025-03-06 13:57:45', 5),
('DoctrineMigrations\\Version20250310134135', '2025-03-10 13:41:39', 149);

-- --------------------------------------------------------

--
-- Structure de la table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
CREATE TABLE IF NOT EXISTS `invoice` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orders_id` int DEFAULT NULL,
  `total_amount` double NOT NULL,
  `created_at` datetime NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_90651744CFFE9AD6` (`orders_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `messenger_messages`
--

INSERT INTO `messenger_messages` (`id`, `body`, `headers`, `queue_name`, `created_at`, `available_at`, `delivered_at`) VALUES
(1, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:41:\\\"registration/confirmation_email.html.twig\\\";i:1;N;i:2;a:3:{s:9:\\\"signedUrl\\\";s:173:\\\"https://cbd.eliott-bricout.fr/verify/email?expires=1741173691&signature=QU7jd7lKFVDcDgBMoZWYXXodRvWeMjybyXMtJLkKUgg%3D&token=MIFxQJv%2BGwrNHksQfqhQYVhMZyLYD28tW8GNlAMrP8A%3D\\\";s:19:\\\"expiresAtMessageKey\\\";s:26:\\\"%count% hour|%count% hours\\\";s:20:\\\"expiresAtMessageData\\\";a:1:{s:7:\\\"%count%\\\";i:1;}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:3:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:19:\\\"infos@relax-cbd.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:14:\\\"Relax CBD Shop\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"eliottbricout@yahoo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:25:\\\"Please Confirm your Email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2025-03-05 10:21:31', '2025-03-05 10:21:31', NULL),
(2, 'O:36:\\\"Symfony\\\\Component\\\\Messenger\\\\Envelope\\\":2:{s:44:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0stamps\\\";a:1:{s:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\";a:1:{i:0;O:46:\\\"Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\\":1:{s:55:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Stamp\\\\BusNameStamp\\0busName\\\";s:21:\\\"messenger.bus.default\\\";}}}s:45:\\\"\\0Symfony\\\\Component\\\\Messenger\\\\Envelope\\0message\\\";O:51:\\\"Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\\":2:{s:60:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0message\\\";O:39:\\\"Symfony\\\\Bridge\\\\Twig\\\\Mime\\\\TemplatedEmail\\\":5:{i:0;s:23:\\\"email/contact.html.twig\\\";i:1;N;i:2;a:1:{s:7:\\\"contact\\\";O:18:\\\"App\\\\Entity\\\\Contact\\\":7:{s:22:\\\"\\0App\\\\Entity\\\\Contact\\0id\\\";i:1;s:29:\\\"\\0App\\\\Entity\\\\Contact\\0firstName\\\";s:6:\\\"Eliott\\\";s:28:\\\"\\0App\\\\Entity\\\\Contact\\0lastName\\\";s:7:\\\"Bricout\\\";s:25:\\\"\\0App\\\\Entity\\\\Contact\\0email\\\";s:22:\\\"eliottbricout@yahoo.fr\\\";s:26:\\\"\\0App\\\\Entity\\\\Contact\\0object\\\";s:32:\\\"Je souhaite devenir développeur\\\";s:27:\\\"\\0App\\\\Entity\\\\Contact\\0message\\\";s:20:\\\"My bad mother fucker\\\";s:24:\\\"\\0App\\\\Entity\\\\Contact\\0date\\\";O:8:\\\"DateTime\\\":3:{s:4:\\\"date\\\";s:26:\\\"2025-03-05 13:20:03.570727\\\";s:13:\\\"timezone_type\\\";i:3;s:8:\\\"timezone\\\";s:3:\\\"UTC\\\";}}}i:3;a:6:{i:0;N;i:1;N;i:2;N;i:3;N;i:4;a:0:{}i:5;a:2:{i:0;O:37:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\\":2:{s:46:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0headers\\\";a:4:{s:4:\\\"from\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:4:\\\"From\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:20:\\\"rocketbric@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"to\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"To\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:20:\\\"rocketbric@gmail.com\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:2:\\\"cc\\\";a:1:{i:0;O:47:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:2:\\\"Cc\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:58:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\MailboxListHeader\\0addresses\\\";a:1:{i:0;O:30:\\\"Symfony\\\\Component\\\\Mime\\\\Address\\\":2:{s:39:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0address\\\";s:22:\\\"eliottbricout@yahoo.fr\\\";s:36:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Address\\0name\\\";s:0:\\\"\\\";}}}}s:7:\\\"subject\\\";a:1:{i:0;O:48:\\\"Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\\":5:{s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0name\\\";s:7:\\\"Subject\\\";s:56:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lineLength\\\";i:76;s:50:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0lang\\\";N;s:53:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\AbstractHeader\\0charset\\\";s:5:\\\"utf-8\\\";s:55:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\UnstructuredHeader\\0value\\\";s:11:\\\"Votre email\\\";}}}s:49:\\\"\\0Symfony\\\\Component\\\\Mime\\\\Header\\\\Headers\\0lineLength\\\";i:76;}i:1;N;}}i:4;N;}s:61:\\\"\\0Symfony\\\\Component\\\\Mailer\\\\Messenger\\\\SendEmailMessage\\0envelope\\\";N;}}', '[]', 'default', '2025-03-05 13:20:03', '2025-03-05 13:20:03', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `order`
--

DROP TABLE IF EXISTS `order`;
CREATE TABLE IF NOT EXISTS `order` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `total_price` double NOT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_F5299398A76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `order`
--

INSERT INTO `order` (`id`, `user_id`, `total_price`, `status`, `created_at`) VALUES
(1, 1, 176, 'pending', '2025-03-10 13:10:34'),
(2, 1, 48, 'pending', '2025-03-10 13:11:49'),
(3, 1, 48, 'pending', '2025-03-11 12:34:49'),
(4, 1, 63, 'pending', '2025-03-11 15:30:50');

-- --------------------------------------------------------

--
-- Structure de la table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
CREATE TABLE IF NOT EXISTS `order_item` (
  `id` int NOT NULL AUTO_INCREMENT,
  `orders_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `quantity` int NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_52EA1F09CFFE9AD6` (`orders_id`),
  KEY `IDX_52EA1F094584665A` (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `order_item`
--

INSERT INTO `order_item` (`id`, `orders_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 1, 22, 8),
(2, 2, 1, 6, 8),
(3, 3, 1, 6, 8),
(4, 4, 3, 1, 9),
(5, 4, 5, 6, 9);

-- --------------------------------------------------------

--
-- Structure de la table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `stock` int NOT NULL,
  `created_at` datetime NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_weight_based` tinyint(1) NOT NULL,
  `price_by_weight` json DEFAULT NULL,
  `stock_by_weight` json DEFAULT NULL,
  `discount_by_weight` json DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_D34A04AD12469DE2` (`category_id`)
) ;

--
-- Déchargement des données de la table `product`
--

INSERT INTO `product` (`id`, `category_id`, `name`, `description`, `price`, `stock`, `created_at`, `image`, `is_weight_based`, `price_by_weight`, `stock_by_weight`, `discount_by_weight`) VALUES
(1, 1, 'Amnesia', '🌿 Amnesia CBD - Une Fleur Puissante et Énergisante 🌿\r\nPlongez dans l\'univers captivant de l\'Amnesia CBD, une fleur de chanvre réputée pour son profil aromatique intense et ses effets équilibrés. Inspirée de la célèbre Amnesia Haze, cette variété combine des saveurs citronnées et terreuses avec des notes subtiles d\'épices et de pin, offrant une expérience sensorielle unique.\r\n\r\n💨 Arômes & Saveurs\r\n\r\nAgrumes (citron, orange)\r\nNotes terreuses et épicées\r\nLégère touche sucrée en fin de bouche\r\n⚡ Effets\r\nGrâce à son taux élevé de CBD, l\'Amnesia CBD est parfaite pour favoriser la relaxation tout en stimulant la créativité et la concentration. Elle est idéale pour une consommation en journée, procurant une sensation de bien-être sans effet psychotrope.\r\n\r\n✅ Caractéristiques\r\n\r\nTaux de CBD : Élevé (variant selon le lot)\r\nTaux de THC : < 0,3% (conforme à la législation européenne)\r\nCulture : Indoor/Greenhouse\r\nAspect : Têtes denses, résineuses, aux teintes vert clair et orangées\r\n🌱 Idéale pour\r\n\r\nSe détendre sans somnolence\r\nStimuler la créativité et la concentration\r\nSoulager le stress et les tensions quotidiennes\r\n🔬 Qualité Premium\r\nNotre Amnesia CBD est soigneusement sélectionnée et cultivée sans pesticides ni additifs chimiques, garantissant une expérience authentique et naturelle.\r\n\r\n📦 Disponible en plusieurs grammages avec des tarifs dégressifs.\r\n\r\nEssayez l\'Amnesia CBD et laissez-vous emporter par ses arômes envoûtants et ses effets revitalisants ! 🚀', 8, 100, '2025-03-06 12:53:00', 'b59e87b097bb20ae9ab4b18e0271868ef44877a6.webp', 1, NULL, NULL, NULL),
(2, 1, 'Gelato', '🌿 Gelato CBD - Une Fleur Gourmande et Relaxante 🌿\r\n\r\nDécouvrez la Gelato CBD, une fleur de chanvre aux arômes doux et sucrés rappelant les célèbres glaces italiennes. Son profil gustatif unique marie des notes fruitées et crémeuses pour une expérience sensorielle délicieuse.\r\n\r\n💨 Arômes & Saveurs\r\n\r\nFruits mûrs (baies, agrumes)\r\n\r\nNotes sucrées et crémeuses\r\n\r\nLégère touche vanillée en fin de bouche\r\n\r\n⚡ Effets\r\nGrâce à son taux élevé de CBD, la Gelato CBD procure un effet apaisant profond, idéal pour détendre le corps et l\'esprit après une longue journée. Parfaite pour un moment de bien-être sans somnolence excessive.\r\n\r\n✅ Caractéristiques\r\n\r\nTaux de CBD : 18%\r\n\r\nTaux de THC : < 0,3% (conforme à la législation européenne)\r\n\r\nCulture : Indoor\r\n\r\nAspect : Têtes compactes et résineuses, aux teintes violet clair et vert foncé\r\n\r\n🌱 Idéale pour\r\n\r\nSoulager les tensions musculaires\r\n\r\nAméliorer la qualité du sommeil\r\n\r\nFavoriser une relaxation profonde\r\n\r\n🔬 Qualité Premium\r\nCultivée en intérieur dans des conditions optimales, la Gelato CBD est garantie sans pesticides ni additifs chimiques pour une pureté exceptionnelle.\r\n\r\n📦 Disponible en plusieurs grammages avec des tarifs dégressifs.\r\n\r\nEssayez la Gelato CBD et laissez-vous séduire par ses arômes envoûtants et ses effets relaxants ! 🍦💨', 9, 150, '2025-03-11 14:51:01', '1bea15cfe643bacf3b24dea0c1f6353cf5d75585.webp', 1, NULL, NULL, NULL),
(3, 1, 'Orange Bud', '🌿 Orange Bud CBD - Une Fleur Fruitée et Dynamisante 🌿\r\n\r\nL\'Orange Bud CBD est une variété aux arômes puissants d\'agrumes, offrant une explosion de saveurs fruitées et sucrées. Elle est parfaite pour ceux qui recherchent une détente équilibrée accompagnée d\'un regain d\'énergie douce.\r\n\r\n💨 Arômes & Saveurs\r\n\r\nOrange et mandarine\r\n\r\nNotes sucrées et légèrement boisées\r\n\r\nFinale fraîche et citronnée\r\n\r\n⚡ Effets\r\nAvec un taux de CBD modéré, l\'Orange Bud CBD procure une sensation de bien-être général, idéale pour favoriser une humeur positive tout en relaxant le corps.\r\n\r\n✅ Caractéristiques\r\n\r\nTaux de CBD : 14% - 16%\r\n\r\nTaux de THC : < 0,3% (conforme à la législation européenne)\r\n\r\nCulture : Outdoor\r\n\r\nAspect : Têtes denses aux reflets orangés\r\n\r\n🌱 Idéale pour\r\n\r\nSe détendre sans perte d\'énergie\r\n\r\nAméliorer l\'humeur et réduire le stress\r\n\r\nUne consommation en journée ou en soirée\r\n\r\n🔬 Qualité Premium\r\nCultivée en extérieur selon des méthodes respectueuses de l\'environnement, notre Orange Bud CBD est garantie sans produits chimiques nocifs.\r\n\r\n📦 Disponible en plusieurs grammages avec des tarifs dégressifs.\r\n\r\nPlongez dans l\'univers fruité de l\'Orange Bud CBD et laissez-vous envahir par sa douceur revitalisante ! 🍊🌿', 9, 199, '2025-03-11 14:52:13', 'bd42167a4e3dd2d9192744465b9acaa5360d8418.webp', 1, NULL, NULL, NULL),
(4, 1, 'Lemon Haze', '🌿 Lemon Haze CBD - Une Explosion d\'Agrumes 🌿\r\n\r\nLa Lemon Haze CBD est une fleur de chanvre au parfum intense d\'agrumes, avec une dominance citronnée qui éveille les sens. Son goût frais et acidulé en fait une variété idéale pour un moment de clarté mentale et de relaxation légère.\r\n\r\n💨 Arômes & Saveurs\r\n\r\nCitron intense\r\n\r\nNotes zestées et légèrement épicées\r\n\r\nArrière-goût sucré et rafraîchissant\r\n\r\n⚡ Effets\r\nGrâce à son équilibre parfait entre stimulation et détente, la Lemon Haze CBD est idéale pour revitaliser l\'esprit tout en relâchant les tensions corporelles.\r\n\r\n✅ Caractéristiques\r\n\r\nTaux de CBD : 16% - 18%\r\n\r\nTaux de THC : < 0,3% (conforme à la législation européenne)\r\n\r\nCulture : Greenhouse\r\n\r\nAspect : Têtes compactes, trichomes abondants\r\n\r\n🌱 Idéale pour\r\n\r\nBooster l\'énergie et la concentration\r\n\r\nRéduire la fatigue et le stress\r\n\r\nProfiter d\'une relaxation légère en journée\r\n\r\n🔬 Qualité Premium\r\nNotre Lemon Haze CBD est cultivée sous serre pour garantir une qualité constante et une concentration élevée en terpènes naturels.\r\n\r\n📦 Disponible en plusieurs grammages avec des tarifs dégressifs.\r\n\r\nProfitez des bienfaits rafraîchissants de la Lemon Haze CBD et savourez chaque bouffée de son arôme ensoleillé ! 🍋💨', 9, 200, '2025-03-11 14:52:57', 'cc836c70fdbc8add811dcf6c9eb590a16053860b.webp', 1, NULL, NULL, NULL),
(5, 1, 'Bubble Gum', '🌿 Bubble Gum CBD - Une Fleur Douce et Gourmande 🌿\r\n\r\nPlongez dans l\'univers sucré de la Bubble Gum CBD, une variété aux arômes rappelant le célèbre chewing-gum. Son goût fruité et sa douceur en bouche en font une expérience sensorielle unique.\r\n\r\n💨 Arômes & Saveurs\r\n\r\nFruits rouges et baies sucrées\r\n\r\nNotes de bonbon et vanille\r\n\r\nTexture douce et légère\r\n\r\n⚡ Effets\r\nParfaite pour un moment de détente tout en douceur, la Bubble Gum CBD apporte un apaisement général sans sensation de lourdeur.\r\n\r\n✅ Caractéristiques\r\n\r\nTaux de CBD : 12%\r\n\r\nTaux de THC : < 0,3% (conforme à la législation européenne)\r\n\r\nCulture : Indoor\r\n\r\nAspect : Têtes résineuses et compactes, aux nuances violettes\r\n\r\n🌱 Idéale pour\r\n\r\nRéduire le stress et l\'anxiété\r\n\r\nSe détendre sans somnolence\r\n\r\nProfiter d\'une saveur gourmande et réconfortante\r\n\r\n🔬 Qualité Premium\r\nNotre Bubble Gum CBD est cultivée avec soin pour garantir un produit pur et naturel, sans additifs chimiques.\r\n\r\n📦 Disponible en plusieurs grammages avec des tarifs dégressifs.\r\n\r\nSuccombez à la douceur de la Bubble Gum CBD et laissez-vous emporter par ses saveurs irrésistibles ! 🍬💨', 9, 194, '2025-03-11 14:54:42', '1461fb5fd078ec617433dfd8c3bffbb1c6ac0981.webp', 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `review`
--

DROP TABLE IF EXISTS `review`;
CREATE TABLE IF NOT EXISTS `review` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `product_id` int DEFAULT NULL,
  `rating` int DEFAULT NULL,
  `comment` longtext COLLATE utf8mb4_unicode_ci,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_794381C6A76ED395` (`user_id`),
  KEY `IDX_794381C64584665A` (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `is_verified` tinyint(1) NOT NULL,
  `profile_picture` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `email`, `password`, `roles`, `first_name`, `last_name`, `created_at`, `is_verified`, `profile_picture`) VALUES
(1, 'eliottbricout@yahoo.fr', '$2y$13$Ux/hvWEW15YGa3NpxMztyuqetHVqwokfDgH2HP16DJJd/g3NGGiLS', '[\"ROLE_ADMIN\"]', 'Eliott', 'Bricout', '2025-03-05 10:21:31', 1, 'IMG-20250310-150331001-67cef8fe27704-67d011c4f2ff6.jpg'),
(2, 'jacques.dufour@gmail.com', '$2y$13$X.XrwPX4UeRxLAaXQLEG9uw/AKZ9u4I7KvDPiJ5pd6a1X2TXqLh9m', '[]', 'Jacques', 'Dufour', '2025-03-10 15:08:55', 0, 'IMG-20250310-150331001-67cf01e721120.jpg'),
(3, 'jeandupres@gmail.com', '$2y$13$5VMi1LPT8TnT5Es2qdyXVeY.JvWHSiAmBuhazANp6lu7llgqlatbu', '[]', 'Jean', 'Dupres', '2025-03-10 15:17:58', 0, 'A realistic digital portrait of a woman of Nordic descent with piercing blue eyes and long, straight blonde hair. She has a confident expressio.webp'),
(4, 'mariedutrou@gmail.com', '$2y$13$R2QC1/CGsz2I0nasyIdhN.cwkgDMoyg7gyIckA2p3MtJbdu1NBUMi', '[]', 'Marie', 'Dutrou', '2025-03-11 07:49:21', 0, 'A-realistic-digital-portrait-of-a-man-of-Mediterranean-descent-with-deep-brown-eyes-and-short-curly-dark-brown-hair-He-has-a-strong-jawline-67cfee205778d.webp'),
(5, 'samihhabanni@gmail.com', '$2y$13$V4BISi1i7uSbaPyIc8emxOleQGqKH4QmVZO4NaOrTTNDO0yRyqPsC', '[]', 'Samih', 'Habanni', '2025-03-11 08:03:50', 0, 'A-realistic-digital-portrait-of-a-non-binary-person-of-Middle-Eastern-descent-with-androgynous-features-hazel-eyes-and-short-curly-dark-brow-67cfee89d0d39.webp'),
(6, 'velotricycle@gmail.com', '$2y$13$RXrVtMJm1yKmIRL3Fk6I..2VcsFd8CYvoxPL6VXvrmUE4MPNG.t9u', '[\"ROLE_USER\"]', 'Vélo', 'Tricycle', '2025-03-11 08:13:23', 0, 'A realistic digital portrait of a woman of African descent with deep brown eyes and voluminous curly black hair. She has a confident expression.webp'),
(7, 'voiturevroomvroom@gmail.com', '$2y$13$X22H16tDaoxsZIMGvJHmvuOpp54UBDZ8qdlQcH.43FtSm2LAd/WlK', '[\"ROLE_USER\"]', 'Voiture', 'Vroomvroom', '2025-03-11 09:15:18', 0, 'A realistic digital portrait of a non-binary person with androgynous features, warm brown eyes, and short, asymmetrical hair dyed in a mix of p.webp'),
(8, 'motoouin@gmail.com', '$2y$13$XP5EJdIaIcUEH9GEsZN/eOEQ7HWFrOBFkfeti1ycx/PGCDGvzKU4.', '[\"ROLE_USER\"]', 'moto', 'ouin', '2025-03-11 09:17:10', 0, 'A realistic digital portrait of a non-binary person with androgynous features, warm brown eyes, and short, asymmetrical hair dyed in a mix of p.webp'),
(9, 'deldel@gmail.com', '$2y$13$3UjmTw1QZlLTF0cSySTKxeXQig56GG7veQ5VwXRO8aagNhLZOg4pm', '[\"ROLE_USER\"]', 'Del', 'del', '2025-03-11 09:21:50', 0, 'Avatar (8).webp'),
(10, 'vivi@gmaiul.com', '$2y$13$.3B3sRN0b..70yD6TGlUJ.aBNWaHsZy5dqzZlcjx5NPiaz2ufKB5q', '[\"ROLE_USER\"]', 'Vi', 'Vi', '2025-03-11 09:59:49', 0, 'Avatar8.webp'),
(11, 'sowesign@gmail.com', '$2y$13$wnX/od4DIecRa.F3nCcowOCCLOiJKcS1bEgsxoU/oDLacx0FLbehm', '[\"ROLE_USER\"]', 'sowesign', 'wesign', '2025-03-11 10:21:43', 0, 'default-avatar.webp'),
(12, 'fritesurgelee@gmail.com', '$2y$13$fzQGbt34c2AKwL8ecpmKP.gistsobBsZbQLloLzAZQKQoxxaMNIUW', '[\"ROLE_USER\"]', 'Frite', 'Surgelée', '2025-03-11 10:25:21', 0, 'Avatar8.webp'),
(13, 'tototo@gmail.com', '$2y$13$5yuzBaB58eylB3Tu64OCC.FTSd5NyU8rU2puTlJZoUfSPBE8BIumK', '[]', 'toto', 'toto', '2025-03-11 10:28:51', 0, 'Avatar4.webp'),
(14, 'tata@gmail.com', '$2y$13$gdZnVUr7F1yMjq5kDnsJH.p4zpJHKzFugOf2/e0Yy05e5xokXMh.a', '[]', 'tata', 'tata', '2025-03-11 10:31:40', 0, 'Avatar2.webp');

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `blog_post`
--
ALTER TABLE `blog_post`
  ADD CONSTRAINT `FK_BA5AE01D12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`),
  ADD CONSTRAINT `FK_BA5AE01DF675F31B` FOREIGN KEY (`author_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `discount_product`
--
ALTER TABLE `discount_product`
  ADD CONSTRAINT `FK_654269BC4584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_654269BC4C7C611F` FOREIGN KEY (`discount_id`) REFERENCES `discount` (`id`) ON DELETE CASCADE;

--
-- Contraintes pour la table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `FK_90651744CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `order` (`id`);

--
-- Contraintes pour la table `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `FK_F5299398A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);

--
-- Contraintes pour la table `order_item`
--
ALTER TABLE `order_item`
  ADD CONSTRAINT `FK_52EA1F094584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_52EA1F09CFFE9AD6` FOREIGN KEY (`orders_id`) REFERENCES `order` (`id`);

--
-- Contraintes pour la table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `FK_D34A04AD12469DE2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`);

--
-- Contraintes pour la table `review`
--
ALTER TABLE `review`
  ADD CONSTRAINT `FK_794381C64584665A` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`),
  ADD CONSTRAINT `FK_794381C6A76ED395` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
