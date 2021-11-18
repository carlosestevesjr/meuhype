-- --------------------------------------------------------
-- Servidor:                     192.168.10.10
-- Versão do servidor:           8.0.26-0ubuntu0.20.04.2 - (Ubuntu)
-- OS do Servidor:               Linux
-- HeidiSQL Versão:              11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Copiando estrutura do banco de dados para meuhype
CREATE DATABASE IF NOT EXISTS `meuhype` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `meuhype`;

-- Copiando estrutura para tabela meuhype.admins
CREATE TABLE IF NOT EXISTS `admins` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admins_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela meuhype.admins: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `admins` DISABLE KEYS */;
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `image`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Carlos Alberto Esteves Junior', 'carlosestevesjr0@gmail.com', '$2y$10$70anvcjSIY3hubLDDut0fOyDhZsBF8CQBYpPCPZ9Id.FeisgoRyKS', '/uploads/fotos/20210415102850_no-image-available-icon-6.jpg', 'active', 'VjJfQoIjHvNMgTEdLLu0GpI0TgqK5LOYaynTrpJZRBZsPoU65sQuXZnWJwM1', '2017-08-28 17:03:23', '2021-04-15 23:40:19');
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `image`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(2, 'Developer Highpix', 'developer@highpix.com.br', '$2y$10$T2.ituGPrzKWhu7Yt/aiX.4ziFR9DU8oT.QHev2C5EI2go5m1RmLm', NULL, 'active', 'TzS8wXvvx1ilbmAaF6TdpB8mH8e06iajlwiiTnblZCJLSugWueLCEyUViYNg', '2017-08-28 17:03:23', '2017-08-28 17:03:23');
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `image`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(5, 'Valter Gomes Galhardo', 'valter.vgg@gmail.com', '$2y$10$XyvIwC063XyQcEuEZ8YuM.51bNuNa.xQAuAiAjcmfl5eNfQSdmAKS', '', 'active', NULL, '2018-07-10 20:55:47', '2018-07-10 20:55:47');
INSERT INTO `admins` (`id`, `name`, `email`, `password`, `image`, `status`, `remember_token`, `created_at`, `updated_at`) VALUES
	(6, 'Teste teste', 'teste@gmail.com', '$2y$10$/IxzjIQ7wZdbk5X6Hpgxmup5QGuxnruJl49NLmp2APiKHW8VLnn7G', '', 'hidden', NULL, '2021-04-16 00:51:33', '2021-04-17 19:59:35');
/*!40000 ALTER TABLE `admins` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.admin_password_resets
CREATE TABLE IF NOT EXISTS `admin_password_resets` (
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `admin_password_resets_email_index` (`email`),
  KEY `admin_password_resets_token_index` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela meuhype.admin_password_resets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `admin_password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_password_resets` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.channels
CREATE TABLE IF NOT EXISTS `channels` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_short` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `url_crawler` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `youtube` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `instagram` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `facebook` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `twitter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `order` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.channels: ~27 rows (aproximadamente)
/*!40000 ALTER TABLE `channels` DISABLE KEYS */;
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(1, 'Jovem Nerd - Site', 'jovemnerdsite', 'jovem-nerd-site', 'Jovem Nerd', '<p>Jovem Nerd</p>', 'jovrm nerd', 'site', 'active', 'https://jovemnerd.com.br/', 'https://jovemnerd.com.br/?s=', NULL, NULL, NULL, NULL, '/uploads/channels/20210121110212_LogoJovemnerd.png', 0, '2020-12-02 23:02:18', '2021-04-18 10:09:04');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(2, 'Jovem Nerd Youtube', 'jovemnerdyoutube', 'jovem-nerd-youtube', 'Jovem Nerd Youtube', '<p>Jovem Nerd Youtube</p>', 'jovrm nerd youtube', 'youtube', 'active', 'https://www.youtube.com/c/JovemNerd', 'https://www.youtube.com/c/JovemNerd/search?query=', '', '', '', '', '/uploads/channels/20210121110144_LogoJovemnerd.png', 0, '2020-12-02 23:03:31', '2021-01-21 23:01:44');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(3, 'Omelete - Site', 'omeletesite', 'omelete-site', 'Omelete', '<p>Omelete</p>', 'omelete', 'site', 'active', 'https://www.omelete.com.br/', 'https://www.omelete.com.br/busca?q=', NULL, NULL, NULL, NULL, '/uploads/channels/20210121110108_LogoOmelete.png', 0, '2020-12-02 23:05:03', '2021-04-19 21:04:08');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(4, 'Omelete Youtube', 'omeleteyoutube', 'omelete-youtube', 'Omelete Youtube', '<p>Omelete Youtube</p>', 'omelete', 'youtube', 'active', 'https://www.youtube.com/user/omeleteve', 'https://www.youtube.com/c/omeleteve/search?query=', '', '', '', '', '/uploads/channels/20210121110011_LogoOmelete.png', 0, '2020-12-02 23:05:56', '2021-01-21 23:00:11');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(5, 'Ei Nerd', 'einerdyoutube', 'ei-nerd', 'Ei Nerd', '<p>Ei Nerd</p>', 'ei nerd', 'youtube', 'active', 'https://www.youtube.com/user/einerdtv', 'https://www.youtube.com/c/einerdtv/search?query=', '', '', '', '', '/uploads/channels/20210125074507_LogoEinerd.png', 0, '2020-12-02 23:08:03', '2021-01-25 19:45:07');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(6, 'Nerdland', 'nerdlandyoutube', 'nerdland', 'Nerdland', '<p>Nerdland</p>', 'nerdland', 'youtube', 'active', 'https://www.youtube.com/user/NeerdLand', 'https://www.youtube.com/c/NerdLand/search?query=', '', '', '', '', '/uploads/channels/20201202111051_LogoNerdland.png', 0, '2020-12-02 23:10:51', '2020-12-02 23:10:51');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(7, 'Pipocando', 'pipocandoyoutube', 'pipocando', 'Pipocando', '<p>Pipocando</p>', 'pipocando', 'youtube', 'active', 'https://www.youtube.com/user/pipocandovideos', 'https://www.youtube.com/c/Pipocando/search?query=', '', '', '', '', '/uploads/channels/20201202111142_LogoPipocando.png', 0, '2020-12-02 23:11:42', '2020-12-02 23:11:42');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(8, 'Super Oito', 'superoitoyoutube', 'super-oito', 'Super Oito', '<p>Super Oito</p>', 'super oito', 'youtube', 'active', 'https://www.youtube.com/user/otaviouga', 'https://www.youtube.com/user/otaviouga/search?query=', '', '', '', '', '/uploads/channels/20201202111259_LogoSuperoito.png', 0, '2020-12-02 23:12:59', '2021-01-21 23:56:14');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(9, 'Cinema Com Rapadura - Youtube', 'cinemacomrapadurayoutube', 'cinema-com-rapadura-youtube', 'Cinema Com Rapadura', '<p>Cinema Com Rapadura</p>', 'cinema com arapadura', 'youtube', 'active', 'https://cinemacomrapadura.com.br/', 'https://www.youtube.com/c/CinemacomRapaduraoficial/search?query=', '', '', '', '', '/uploads/channels/20210121015123_LogoCinemaComRapadura.png', 0, '2021-01-21 01:51:23', '2021-01-21 01:51:53');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(10, 'Caique Izoton', 'caiqueizotonyoutube', 'caique-izoton', 'Caique Izoton', '<p>Caique Izoton</p>', 'Caique Izoton', 'youtube', 'active', 'https://www.youtube.com/c/CaiqueIzoton/featured', 'https://www.youtube.com/c/CaiqueIzoton/search?query=', '', '', '', '', '/uploads/channels/20210121015954_LogoCaiqueIzoton.png', 0, '2021-01-21 01:53:37', '2021-01-21 01:59:54');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(11, 'Caverna Do Caruso', 'cavernadocarusoyoutube', 'caverna-do-caruso', 'Caverna Do Caruso', '<p>Caverna Do Caruso</p>', 'caverna do caruso', 'youtube', 'active', 'https://www.youtube.com/CAVERNADOCARUSO', 'https://www.youtube.com/c/CAVERNADOCARUSO/search?query=', '', '', '', '', '/uploads/channels/20210121021054_LogoCavernaDoCaruso.png', 0, '2021-01-21 02:10:54', '2021-01-21 02:10:54');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(12, 'Quatro Coisas', 'quatrocoisasyoutube', 'quatro-coisas', 'Quatro Coisas', '<p>Quatro Coisas</p>', 'quatro coisas', 'youtube', 'active', 'https://www.youtube.com/user/Qu4troCoisas', 'https://www.youtube.com/c/Qu4troCoisas/search?query=', '', '', '', '', '/uploads/channels/20210121071920_LogoQuatroCoisas.png', 0, '2021-01-21 19:19:20', '2021-01-21 23:56:48');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(13, 'Operação Cinema', 'operacaocinemayoutube', 'operacao-cinema', 'Operação Cinema', '<p>Opera&ccedil;&atilde;o Cinema</p>', 'operação', 'youtube', 'active', 'https://www.youtube.com/channel/UCT-QobdGYczKTSuWAQbQFAA', 'https://www.youtube.com/c/Opera%C3%A7%C3%A3oCinema/search?query=', '', '', '', '', '/uploads/channels/20210121075750_LogoOperacaoCinema.png', 0, '2021-01-21 19:57:50', '2021-01-21 19:57:50');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(14, 'Nerd Rabugento', 'nerdrabugentoyoutube', 'nerd-rabugento', 'Nerd Rabugento', '<p>Nerd Rabugento</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/c/NerdRabugentoOficial', 'https://www.youtube.com/c/NerdRabugentoOficial/search?query=', '', '', '', '', '/uploads/channels/20210121080815_LogoNerdRabugento.png', 0, '2021-01-21 20:08:15', '2021-01-21 20:08:15');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(15, 'Herança Nerd', 'herancanerdyoutube', 'heranca-nerd', 'Herança Nerd', '<p>Heran&ccedil;a Nerd</p>', NULL, 'youtube', 'active', '', '', '', '', '', '', '/uploads/channels/20210121083225_LogoHerancaNerd.png', 0, '2021-01-21 20:31:20', '2021-01-21 20:32:25');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(16, 'Cris e Panda', 'crispandayoutube', 'cris-e-panda', 'Cris e Panda', '<p>Cris e Panda</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/user/CoxinhaNerd', 'https://www.youtube.com/user/CoxinhaNerd/search?query=', '', '', '', '', '/uploads/channels/20210121084319_LogoCrisPanda.png', 0, '2021-01-21 20:43:19', '2021-01-21 20:43:19');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(17, 'Nerd Experience', 'nerdexperienceyoutube', 'nerd-experience', 'Nerd Experience', '<p>Nerd Experience</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/c/NERDEXPERIENCEOFICIAL/featured', 'https://www.youtube.com/c/NERDEXPERIENCEOFICIAL/search?query=', '', '', '', '', '/uploads/channels/20210121090104_LogoNerdExperience.png', 0, '2021-01-21 21:00:33', '2021-01-21 21:01:04');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(18, 'Caldeirão Nerd', 'caldeiraonerdyoutube', 'caldeirao-nerd', 'Caldeirão Nerd', '<p>Caldeir&atilde;o Nerd</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/c/Caldeir%C3%A3oNerd/videos', 'https://www.youtube.com/c/Caldeir%C3%A3oNerd/search?query=', '', '', '', '', '/uploads/channels/20210121090934_LogoCaldeiraoNerd.png', 0, '2021-01-21 21:09:34', '2021-01-21 21:09:34');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(19, 'Arena Nerd', 'arenanerdyoutube', 'arena-nerd', 'Arena Nerd', '<p>O Arena Nerd &eacute; um ve&iacute;culo de comunica&ccedil;&atilde;o composto por canal no youtube, podcast e site, que tem o objetivo de construir um ambiente de entretenimento, debate e informa&ccedil;&atilde;o, sobre diversos assuntos de interesse do p&uacute;blico nerd, n&atilde;o limitado &agrave; cultura pop. Nossos conte&uacute;dos s&atilde;o focados em opini&otilde;es e experi&ecirc;ncias pr&oacute;prias dos apresentadores. Dessa forma, mesmo que algum tema j&aacute; tenha sido abordado por outros canais e podcasts, a vis&atilde;o apresentada pelo Arena Nerd, torna os programas sempre &uacute;nicos e relevantes.</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/c/ArenaNerdOficial/videos', 'https://www.youtube.com/c/ArenaNerdOficial/search?query=', NULL, NULL, 'https://www.facebook.com/canalarenanerd', 'https://www.youtube.com/redirect?event=channel_description&redir_token=QUFFLUhqbjc0ZDJISzhjQVpjY0FENHBzdXZraVYwTEdRQXxBQ3Jtc0tuNGd3bVlUMkZUeEVQSmk5VmUxUS1DUGgyQkM1bWQyTUg1cWZhczlRUkFLZWxMRVVvZjdUY1o3ZGk1UkFXT1BrdEhrelZMUUxRRkJMZWp4NU13R0drUFhjVEI5QmhpNnZ5T0dPOTF1RjFCcVNIZzFBZw&q=https%3A%2F%2Fwww.instagram.com%2Farenanerdoficial%2F', '/uploads/channels/20210121091636_LogoArenaNerd.png', 2, '2021-01-21 21:16:36', '2021-04-18 08:49:19');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(20, 'Sessão Nerd', 'sessaonerdyoutube', 'sessao-nerd', 'Sessão Nerd', '<p>Sess&atilde;o Nerd</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/c/Sess%C3%A3oNerdOficial/featured', 'https://www.youtube.com/c/Sess%C3%A3oNerdOficial/search?query=', '', '', '', '', '/uploads/channels/20210121092910_LogoSessaoNerd.png', 0, '2021-01-21 21:29:10', '2021-01-21 23:56:30');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(21, 'Nerd News', 'nerdnewsyoutube', 'nerd-news', 'Nerd News', '<p>Nerd News</p>', '0', 'youtube', 'active', 'https://www.youtube.com/c/NerdNewsOficial/featured', 'https://www.youtube.com/c/NerdNewsOficial/search?query=', '', '', '', '', '/uploads/channels/20210121103524_LogoNerdNews.png', 0, '2021-01-21 22:35:24', '2021-01-21 22:35:24');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(22, 'Thiago Romariz', 'thiagoromarizyoutube', 'thiago-romariz', 'Thiago Romariz', '<p>Thiago Romariz</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/user/thiagoromariz', 'https://www.youtube.com/c/ThiagoRomariz/search?query=', NULL, NULL, NULL, NULL, '/uploads/channels/20210121103618_LogoThiagoRomariz.png', 0, '2021-01-21 22:36:02', '2021-07-13 21:44:07');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(23, 'Gustavo Cunha', 'gustavocunhayoutube', 'gustavo-cunha', 'Gustavo Cunha', '<p>Gustavo Cunha</p>', '0', 'youtube', 'active', 'https://www.youtube.com/channel/UCfUE4aSsJSOmeGcnwue9TnQ', 'https://www.youtube.com/c/GustavoCunhavideos/search?query=', '', '', '', '', '/uploads/channels/20210121103820_LogoGustavoCunha.png', 0, '2021-01-21 22:38:20', '2021-01-21 22:38:20');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(24, 'Miguel Lokia', 'miguellokiayoutube', 'miguel-lokia', 'Miguel Lokia', '<p>Miguel Lokia</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/channel/UCP_Hxwf6ajGjPsMw0a8rnLQ', 'https://www.youtube.com/c/MiguelLokiaMesmo/search?query=', '', '', '', '', '/uploads/channels/20210121103933_LogoMiguelLokia.png', 0, '2021-01-21 22:39:06', '2021-01-21 22:39:33');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(25, 'Entre Migas', 'entremigasyoutube', 'entre-migas', 'Entre Migas', '<p>Entre Migas</p>', NULL, 'youtube', 'active', 'https://www.youtube.com/c/EntreMigas/featured', 'https://www.youtube.com/c/EntreMigas/search?query=', '', '', '', '', '/uploads/channels/20210121104048_LogoEntreMigas.png', 0, '2021-01-21 22:40:48', '2021-01-21 22:40:48');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(27, 'Jovem Nerd - Podcast', 'jovemnerdspotify', 'jovem-nerd-podcast', 'Jovem Nerd - Podcast', '<p>Jovem Nerd - Podcast</p>', NULL, 'podcast', 'active', 'https://open.spotify.com/show/22Wgt4ASeaw8mmoqAWNUn1', NULL, NULL, NULL, NULL, NULL, '/uploads/channels/20210519103525_20210121110144LogoJovemnerd.png', 1, '2021-04-21 22:12:09', '2021-05-19 22:35:25');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(28, 'Cinema Com Rapadura - Podcast', 'cinemacomrapaduraspotify', 'cinema-com-rapadura-podcast', 'Cinema Com Rapadura - Podcast', '<p>Cinema Com Rapadura - Podcast</p>', 'cinema com rarapadura', 'podcast', 'active', 'https://open.spotify.com/show/0kof6vwnq6i1zlvbh9lwsY', NULL, NULL, NULL, NULL, NULL, '/uploads/channels/20210421115137_CinemaComRapadura.png', 1, '2021-04-21 23:51:37', '2021-04-22 20:19:48');
/*!40000 ALTER TABLE `channels` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.configs
CREATE TABLE IF NOT EXISTS `configs` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image_logo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `endereco` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description_short` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `email1` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `email2` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel1` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `tel2` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebook` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `twitter` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `instagram` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `youtube` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `vimeo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedin` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `color_painel` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `desconto` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela meuhype.configs: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` (`id`, `title`, `slug`, `description`, `image_logo`, `keywords`, `endereco`, `description_short`, `email1`, `email2`, `tel1`, `tel2`, `facebook`, `twitter`, `instagram`, `youtube`, `vimeo`, `linkedin`, `color_painel`, `desconto`, `created_at`, `updated_at`) VALUES
	(1, 'Meu Hype', 'meu-hype', 'Meu Hype', '', 'meu hype', '', '', 'contato.meuhype.com.br', NULL, '', NULL, '', NULL, NULL, NULL, NULL, NULL, 'red', 20.00, '2017-08-28 17:03:23', '2018-07-10 20:58:29');
/*!40000 ALTER TABLE `configs` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.crawler
CREATE TABLE IF NOT EXISTS `crawler` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tags_id` int DEFAULT '0',
  `time_initial` time NOT NULL,
  `type` varchar(10) NOT NULL DEFAULT '',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `order` int NOT NULL,
  `status` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.crawler: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `crawler` DISABLE KEYS */;
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Crawler 2', 4, '20:39:00', 'site', '<p>Crawler 2</p>', 1, 'hidden', '2021-04-18 09:30:31', '2021-04-28 22:08:53');
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(2, 'Crawler 1', 8, '02:59:00', 'site', '<p>Teste</p>', 1, 'active', '2021-04-18 22:05:30', '2021-05-02 02:42:35');
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(3, 'Spotify - Podcasts', 0, '00:18:00', 'spotify', '<p>Spotify</p>', 1, 'active', '2021-04-21 23:14:55', '2021-04-23 21:20:11');
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(4, 'Crawler 3', 12, '21:13:00', 'spotify', NULL, 1, 'active', '2021-05-01 22:21:31', '2021-09-12 20:48:07');
/*!40000 ALTER TABLE `crawler` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.crawler_configs
CREATE TABLE IF NOT EXISTS `crawler_configs` (
  `id` int NOT NULL,
  `array_canais_ativos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `qtd_noticias_por_canal` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.crawler_configs: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `crawler_configs` DISABLE KEYS */;
INSERT INTO `crawler_configs` (`id`, `array_canais_ativos`, `qtd_noticias_por_canal`, `created_at`, `updated_at`) VALUES
	(1, '["jovemnerdspotify"]', 10, '2021-09-12 18:01:22', '2021-09-12 20:47:03');
/*!40000 ALTER TABLE `crawler_configs` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.migrations: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.news
CREATE TABLE IF NOT EXISTS `news` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `channels_id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_short` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `order` int DEFAULT NULL,
  `data` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.news: ~78 rows (aproximadamente)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(2, 3, 'Mortal Kombat Legends: Battle of the Realms | Trailer mostra batalha épica; veja', 'mortal-kombat-legends-battle-of-the-realms-trailer-mostra-batalha-epica-veja', 'mortal-kombat-legends-battle-of-the-realms-trailer-mostra-batalha-epica-veja-omeletesite', '/uploads/news/20210909113234_mortal-kombat-legends-battle-of-the-realms-trailer-mostra-batalha-epica-veja-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-legends-battle-of-realms-trailer', NULL, NULL, 0, '2021-07-01', '2021-09-09 23:32:35', '2021-09-09 23:32:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(3, 3, 'Mortal Kombat Legends: Scorpion&39;s Revenge | Animação ganhará sequência neste ano', 'mortal-kombat-legends-scorpion39s-revenge-animacao-ganhara-sequencia-neste-ano', 'mortal-kombat-legends-scorpion39s-revenge-animacao-ganhara-sequencia-neste-ano-omeletesite', '/uploads/news/20210909113235_mortal-kombat-legends-scorpion39s-revenge-animacao-ganhara-sequencia-neste-ano-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-legends-scorpions-revenge-ganha-sequencia', NULL, NULL, 0, '2021-06-16', '2021-09-09 23:32:37', '2021-09-09 23:32:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(4, 3, 'Mortal Kombat: comparamos os personagens do novo filme com o clássico de 1995', 'mortal-kombat-comparamos-os-personagens-do-novo-filme-com-o-classico-de-1995', 'mortal-kombat-comparamos-os-personagens-do-novo-filme-com-o-classico-de-1995-omeletesite', '/uploads/news/20210909113237_mortal-kombat-comparamos-os-personagens-do-novo-filme-com-o-classico-de-1995-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-antes-e-depois-1995-2021', NULL, NULL, 0, '2021-05-18', '2021-09-09 23:32:40', '2021-09-09 23:32:40');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(5, 3, 'Crítica: Mortal Kombat vive pelo fan service em filme morno', 'critica-mortal-kombat-vive-pelo-fan-service-em-filme-morno', 'critica-mortal-kombat-vive-pelo-fan-service-em-filme-morno-omeletesite', '/uploads/news/20210909113240_critica-mortal-kombat-vive-pelo-fan-service-em-filme-morno-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/criticas/mortal-kombat-2021', NULL, NULL, 0, '2021-05-18', '2021-09-09 23:32:46', '2021-09-09 23:32:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(6, 3, 'Demon Slayer ultrapassa Mortal Kombat e chega ao topo da bilheteria nos EUA', 'demon-slayer-ultrapassa-mortal-kombat-e-chega-ao-topo-da-bilheteria-nos-eua', 'demon-slayer-ultrapassa-mortal-kombat-e-chega-ao-topo-da-bilheteria-nos-eua-omeletesite', '/uploads/news/20210909113246_demon-slayer-ultrapassa-mortal-kombat-e-chega-ao-topo-da-bilheteria-nos-eua-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/demon-slayer-recorde-bilheteria', NULL, NULL, 0, '2021-05-02', '2021-09-09 23:32:47', '2021-09-09 23:32:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(7, 3, 'Mortal Kombat | Como o Sub-Zero é o coração do novo filme', 'mortal-kombat-como-o-sub-zero-e-o-coracao-do-novo-filme', 'mortal-kombat-como-o-sub-zero-e-o-coracao-do-novo-filme-omeletesite', '/uploads/news/20210909113247_mortal-kombat-como-o-sub-zero-e-o-coracao-do-novo-filme-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-visita-ao-set-importancia-de-sub-zero', NULL, NULL, 0, '2021-04-27', '2021-09-09 23:32:47', '2021-09-09 23:32:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(8, 3, 'Mortal Kombat Legends: Battle of the Realms ganha clipe cheio de ação', 'mortal-kombat-legends-battle-of-the-realms-ganha-clipe-cheio-de-acao', 'mortal-kombat-legends-battle-of-the-realms-ganha-clipe-cheio-de-acao-omeletesite', '/uploads/news/20210910122833_mortal-kombat-legends-battle-of-the-realms-ganha-clipe-cheio-de-acao-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-legends-battle-of-the-realms-primeiro-clipe', NULL, NULL, 0, '2021-07-24', '2021-09-10 00:28:33', '2021-09-10 00:28:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(9, 1, 'Warner faz zoeira com o Salsicha do Scooby-Doo em animação de Mortal Kombat', 'warner-faz-zoeira-com-o-salsicha-do-scooby-doo-em-animacao-de-mortal-kombat', 'warner-faz-zoeira-com-o-salsicha-do-scooby-doo-em-animacao-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210910123307_warner-faz-zoeira-com-o-salsicha-do-scooby-doo-em-animacao-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/warner-faz-zoeira-com-salsicha-do-scooby-doo-em-animacao-de-mortal-kombat/', NULL, NULL, 0, '2021-08-31', '2021-09-10 00:33:07', '2021-09-10 00:33:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(10, 1, 'Cena inédita de Mortal Kombat Legends: Battle of the Realms com Johnny Cage é revelada', 'cena-inedita-de-mortal-kombat-legends-battle-of-the-realms-com-johnny-cage-e-revelada', 'cena-inedita-de-mortal-kombat-legends-battle-of-the-realms-com-johnny-cage-e-revelada-jovemnerdsite', '/uploads/news/20210910123307_cena-inedita-de-mortal-kombat-legends-battle-of-the-realms-com-johnny-cage-e-revelada-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/cena-inedita-de-mortal-kombat-legends-battle-of-the-realms-com-johnny-cage-e-revelada/', NULL, NULL, 0, '2021-08-24', '2021-09-10 00:33:08', '2021-09-10 00:33:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(11, 1, 'Mortal Kombat 11 ultrapassa a marca de 12 milhões de cópias vendidas', 'mortal-kombat-11-ultrapassa-a-marca-de-12-milhoes-de-copias-vendidas', 'mortal-kombat-11-ultrapassa-a-marca-de-12-milhoes-de-copias-vendidas-jovemnerdsite', '/uploads/news/20210910123308_mortal-kombat-11-ultrapassa-a-marca-de-12-milhoes-de-copias-vendidas-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-11-ultrapassa-a-marca-de-12-milhoes-de-copias-vendidas/', NULL, NULL, 0, '2021-07-26', '2021-09-10 00:33:09', '2021-09-10 00:33:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(12, 1, 'Mortal Kombat Legends: Battle of the Realms ganha cena inédita com muita pancadaria', 'mortal-kombat-legends-battle-of-the-realms-ganha-cena-inedita-com-muita-pancadaria', 'mortal-kombat-legends-battle-of-the-realms-ganha-cena-inedita-com-muita-pancadaria-jovemnerdsite', '/uploads/news/20210910123309_mortal-kombat-legends-battle-of-the-realms-ganha-cena-inedita-com-muita-pancadaria-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-legends-battle-of-the-realms-ganha-cena-inedita-com-muita-pancadaria/', NULL, NULL, 0, '2021-07-24', '2021-09-10 00:33:09', '2021-09-10 00:33:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(13, 1, 'Mortal Kombat 11 não receberá mais DLCs', 'mortal-kombat-11-nao-recebera-mais-dlcs', 'mortal-kombat-11-nao-recebera-mais-dlcs-jovemnerdsite', '/uploads/news/20210910123309_mortal-kombat-11-nao-recebera-mais-dlcs-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-11-nao-recebera-mais-dlcs/', NULL, NULL, 0, '2021-07-02', '2021-09-10 00:33:09', '2021-09-10 00:33:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(14, 1, 'Mortal Kombat Legends: Battle of the Realms ganha trailer com destaque para torneio final', 'mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final', 'mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final-jovemnerdsite', '/uploads/news/20210910123309_mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final/', NULL, NULL, 0, '2021-07-01', '2021-09-10 00:33:11', '2021-09-10 00:33:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(15, 1, 'Sequência de Mortal Kombat Legends é confirmada', 'sequencia-de-mortal-kombat-legends-e-confirmada', 'sequencia-de-mortal-kombat-legends-e-confirmada-jovemnerdsite', '/uploads/news/20210910123311_sequencia-de-mortal-kombat-legends-e-confirmada-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/sequencia-de-mortal-kombat-legends-e-confirmada/', NULL, NULL, 0, '2021-06-16', '2021-09-10 00:33:11', '2021-09-10 00:33:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(16, 1, 'Mortal Kombat supera Godzilla vs. Kong e se torna a maior estreia do HBO Max', 'mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max', 'mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max-jovemnerdsite', '/uploads/news/20210910123311_mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max/', NULL, NULL, 0, '2021-04-27', '2021-09-10 00:33:11', '2021-09-10 00:33:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(17, 1, 'Roteirista de Mortal Kombat revela ter pensado em trilogia', 'roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia', 'roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia-jovemnerdsite', '/uploads/news/20210910123311_roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia/', NULL, NULL, 0, '2021-04-26', '2021-09-10 00:33:12', '2021-09-10 00:33:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(18, 1, 'Mortal Kombat é a &8220;melhor adaptação de video game de todos os tempos&8221;, diz Mehcad Brooks', 'mortal-kombat-e-a-8220melhor-adaptacao-de-video-game-de-todos-os-tempos8221-diz-mehcad-brooks', 'mortal-kombat-e-a-8220melhor-adaptacao-de-video-game-de-todos-os-tempos8221-diz-mehcad-brooks-jovemnerdsite', '/uploads/news/20210910123312_mortal-kombat-e-a-8220melhor-adaptacao-de-video-game-de-todos-os-tempos8221-diz-mehcad-brooks-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-e-a-melhor-adaptacao-de-um-video-game-de-todos-os-tempos-diz-mehcad-brooks/', NULL, NULL, 0, '2021-04-22', '2021-09-10 00:33:12', '2021-09-10 00:33:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(19, 1, 'Assista aos primeiros minutos do filme live-action de Mortal Kombat', 'assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat', 'assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210910123312_assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat/', NULL, NULL, 0, '2021-04-20', '2021-09-10 00:33:12', '2021-09-10 00:33:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(20, 1, 'Scorpion e Sub-Zero tem confronto violento em trecho de Mortal Kombat', 'scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat', 'scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210910123312_scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat/', NULL, NULL, 0, '2021-04-16', '2021-09-10 00:33:13', '2021-09-10 00:33:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(21, 1, 'Diretor do filme de Mortal Kombat quer expandir a franquia respeitando os fãs', 'diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas', 'diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas-jovemnerdsite', '/uploads/news/20210910123313_diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas/', NULL, NULL, 0, '2021-04-12', '2021-09-10 00:33:13', '2021-09-10 00:33:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(22, 1, 'Filme de Mortal Kombat ganha nova versão do tema musical clássico; ouça', 'filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca', 'filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca-jovemnerdsite', '/uploads/news/20210910123313_filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca/', NULL, NULL, 0, '2021-04-09', '2021-09-10 00:33:13', '2021-09-10 00:33:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(23, 1, 'Filme de Mortal Kombat ganha pôster oficial feito por BossLogic', 'filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic', 'filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic-jovemnerdsite', '/uploads/news/20210910123313_filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic/', NULL, NULL, 0, '2021-04-08', '2021-09-10 00:33:14', '2021-09-10 00:33:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(24, 1, 'Vídeo de bastidores de Mortal Kombat revela cenas inéditas; assista', 'video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista', 'video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista-jovemnerdsite', '/uploads/news/20210910123314_video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista/', NULL, NULL, 0, '2021-04-05', '2021-09-10 00:33:14', '2021-09-10 00:33:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(25, 1, 'Mortal Kombat ganha novos teasers focados em Raiden, Jax, Kung Lao e Liu Kang', 'mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang', 'mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang-jovemnerdsite', '/uploads/news/20210910123314_mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang/', NULL, NULL, 0, '2021-04-02', '2021-09-10 00:33:15', '2021-09-10 00:33:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(26, 1, 'Nitara aparece em nova imagem do filme live-action de Mortal Kombat', 'nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat', 'nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210910123315_nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat/', NULL, NULL, 0, '2021-03-25', '2021-09-10 00:33:15', '2021-09-10 00:33:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(27, 1, 'Diretor de Mortal Kombat fala sobre linha do tempo do filme live-action', 'diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action', 'diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action-jovemnerdsite', '/uploads/news/20210910123315_diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action/', NULL, NULL, 0, '2021-03-22', '2021-09-10 00:33:15', '2021-09-10 00:33:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(28, 1, 'Funko anuncia novos colecionáveis de Mortal Kombat', 'funko-anuncia-novos-colecionaveis-de-mortal-kombat', 'funko-anuncia-novos-colecionaveis-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210910123315_funko-anuncia-novos-colecionaveis-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/funko-anuncia-novos-colecionaveis-de-mortal-kombat/', NULL, NULL, 0, '2021-03-19', '2021-09-10 00:33:16', '2021-09-10 00:33:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(29, 1, 'Filme de Mortal Kombat tem &8220;uma das cenas mais brutais do cinema&8221;, diz produtor', 'filme-de-mortal-kombat-tem-8220uma-das-cenas-mais-brutais-do-cinema8221-diz-produtor', 'filme-de-mortal-kombat-tem-8220uma-das-cenas-mais-brutais-do-cinema8221-diz-produtor-jovemnerdsite', '/uploads/news/20210910123316_filme-de-mortal-kombat-tem-8220uma-das-cenas-mais-brutais-do-cinema8221-diz-produtor-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-tem-uma-das-cenas-mais-brutais-do-cinema-diz-produtor/', NULL, NULL, 0, '2021-03-17', '2021-09-10 00:33:16', '2021-09-10 00:33:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(30, 1, 'Filme de Mortal Kombat não será tão violento quanto os jogos, explica produtor', 'filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos-explica-produtor', 'filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos-explica-produtor-jovemnerdsite', '/uploads/news/20210910123316_filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos-explica-produtor-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos/', NULL, NULL, 0, '2021-03-17', '2021-09-10 00:33:16', '2021-09-10 00:33:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(31, 1, 'Filme de Mortal Kombat recebe novos teasers com foco nos personagens', 'filme-de-mortal-kombat-recebe-novos-teasers-com-foco-nos-personagens', 'filme-de-mortal-kombat-recebe-novos-teasers-com-foco-nos-personagens-jovemnerdsite', '/uploads/news/20210910123317_filme-de-mortal-kombat-recebe-novos-teasers-com-foco-nos-personagens-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-recebe-novos-teasers/', NULL, NULL, 0, '2021-03-12', '2021-09-10 00:33:17', '2021-09-10 00:33:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(32, 1, 'Filme de Mortal Kombat recebe classificação indicativa para maiores de idade', 'filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade', 'filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade-jovemnerdsite', '/uploads/news/20210910123317_filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade/', NULL, NULL, 0, '2021-03-11', '2021-09-10 00:33:17', '2021-09-10 00:33:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(33, 1, 'Pôster de Mortal Kombat confirma presença do Kabal no filme live-action', 'poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action', 'poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action-jovemnerdsite', '/uploads/news/20210910123317_poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action/', NULL, NULL, 0, '2021-03-10', '2021-09-10 00:33:18', '2021-09-10 00:33:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(34, 1, 'Mortal Kombat | Diretor promete que filme terá as melhores cenas de luta do cinema', 'mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema', 'mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema-jovemnerdsite', '/uploads/news/20210910123318_mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema/', NULL, NULL, 0, '2021-03-04', '2021-09-10 00:33:18', '2021-09-10 00:33:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(35, 1, 'Mortal Kombat | Fotos dos bastidores do live-action mostram Sub-Zero, Scorpion e mais', 'mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais', 'mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais-jovemnerdsite', '/uploads/news/20210910123318_mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais/', NULL, NULL, 0, '2021-03-03', '2021-09-10 00:33:18', '2021-09-10 00:33:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(36, 1, 'Mortal Kombat &8211; AGORA VAI!', 'mortal-kombat-8211-agora-vai', 'mortal-kombat-8211-agora-vai-jovemnerdsite', '/uploads/news/20210910123318_mortal-kombat-8211-agora-vai-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdoffice/mortal-kombat-agora-vai/', NULL, NULL, 0, '2021-03-03', '2021-09-10 00:33:20', '2021-09-10 00:33:20');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(37, 8, 'MORTAL KOMBAT é bom? - Vale Crítica', 'mortal-kombat-e-bom-vale-critica', 'mortal-kombat-e-bom-vale-critica-superoitoyoutube', '/uploads/news/20210910123841_mortal-kombat-e-bom-vale-critica-superoitoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5cYBwfEXpqs', NULL, NULL, 0, '2021-05-02', '2021-09-10 00:38:42', '2021-09-10 00:38:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(38, 1, 'Será que WandaVision previu a data do trailer de Homem-Aranha: Sem Volta Para Casa?', 'sera-que-wandavision-previu-a-data-do-trailer-de-homem-aranha-sem-volta-para-casa', 'sera-que-wandavision-previu-a-data-do-trailer-de-homem-aranha-sem-volta-para-casa-jovemnerdsite', '/uploads/news/20210912072247_sera-que-wandavision-previu-a-data-do-trailer-de-homem-aranha-sem-volta-para-casa-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-previu-data-trailer-homem-aranha-sem-volta-para-casa/', NULL, NULL, 0, '2021-08-24', '2021-09-12 19:22:48', '2021-09-12 19:22:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(39, 1, 'Paul Bettany revela diferentes faces do Visão em fotos dos bastidores de WandaVision', 'paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision', 'paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision-jovemnerdsite', '/uploads/news/20210912072248_paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision/', NULL, NULL, 0, '2021-08-16', '2021-09-12 19:22:50', '2021-09-12 19:22:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(40, 1, 'Doutor Estranho 2 não faria sentido sem WandaVision, diz Elizabeth Olsen', 'doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen', 'doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen-jovemnerdsite', '/uploads/news/20210912072250_doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen/', NULL, NULL, 0, '2021-07-13', '2021-09-12 19:22:56', '2021-09-12 19:22:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(41, 1, 'Elizabeth Olsen, de Vingadores e WandaVision, fez um teste &8220;terrível&8221; para Game of Thrones', 'elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-8220terrivel8221-para-game-of-thrones', 'elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-8220terrivel8221-para-game-of-thrones-jovemnerdsite', '/uploads/news/20210912072256_elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-8220terrivel8221-para-game-of-thrones-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-terrivel-para-game-of-thrones/', NULL, NULL, 0, '2021-06-22', '2021-09-12 19:22:57', '2021-09-12 19:22:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(42, 1, 'Randall Park, de WandaVision, entra para o elenco de derivado de Big Mouth', 'randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth', 'randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth-jovemnerdsite', '/uploads/news/20210912072257_randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth/', NULL, NULL, 0, '2021-06-14', '2021-09-12 19:22:58', '2021-09-12 19:22:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(43, 1, 'WandaVision não terá segunda temporada, diz Elizabeth Olsen', 'wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen', 'wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen-jovemnerdsite', '/uploads/news/20210912072258_wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen/', NULL, NULL, 0, '2021-06-09', '2021-09-12 19:22:59', '2021-09-12 19:22:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(44, 1, 'Agatha seria bem diferente em WandaVision, revela roteirista', 'agatha-seria-bem-diferente-em-wandavision-revela-roteirista', 'agatha-seria-bem-diferente-em-wandavision-revela-roteirista-jovemnerdsite', '/uploads/news/20210912072259_agatha-seria-bem-diferente-em-wandavision-revela-roteirista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/agatha-seria-bem-diferente-em-wandavision-revela-roteirista/', NULL, NULL, 0, '2021-06-03', '2021-09-12 19:22:59', '2021-09-12 19:22:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(45, 1, 'Kat Dennings esperava ter participação menor em WandaVision', 'kat-dennings-esperava-ter-participacao-menor-em-wandavision', 'kat-dennings-esperava-ter-participacao-menor-em-wandavision-jovemnerdsite', '/uploads/news/20210912072259_kat-dennings-esperava-ter-participacao-menor-em-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/kat-dennings-esperava-participacao-menor-wandavision/', NULL, NULL, 0, '2021-05-24', '2021-09-12 19:23:04', '2021-09-12 19:23:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(46, 1, 'WandaVision teria a aparição de Doutor Estranho, revela Kevin Feige', 'wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige', 'wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige-jovemnerdsite', '/uploads/news/20210912072304_wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige/', NULL, NULL, 0, '2021-05-03', '2021-09-12 19:23:05', '2021-09-12 19:23:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(47, 1, 'WandaVision faz crossover com diferentes séries em ilustrações', 'wandavision-faz-crossover-com-diferentes-series-em-ilustracoes', 'wandavision-faz-crossover-com-diferentes-series-em-ilustracoes-jovemnerdsite', '/uploads/news/20210912072305_wandavision-faz-crossover-com-diferentes-series-em-ilustracoes-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-ganha-crossover-com-diferentes-series-em-ilustracoes/', NULL, NULL, 0, '2021-03-27', '2021-09-12 19:23:06', '2021-09-12 19:23:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(48, 1, 'Fã faz abertura de WandaVision inspirada em Friends', 'fa-faz-abertura-de-wandavision-inspirada-em-friends', 'fa-faz-abertura-de-wandavision-inspirada-em-friends-jovemnerdsite', '/uploads/news/20210912072306_fa-faz-abertura-de-wandavision-inspirada-em-friends-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/fa-faz-abertura-de-wandavision-inspirada-em-friends/', NULL, NULL, 0, '2021-03-25', '2021-09-12 19:23:07', '2021-09-12 19:23:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(49, 1, 'Confira a magia dos efeitos visuais de WandaVision', 'confira-a-magia-dos-efeitos-visuais-de-wandavision', 'confira-a-magia-dos-efeitos-visuais-de-wandavision-jovemnerdsite', '/uploads/news/20210912072307_confira-a-magia-dos-efeitos-visuais-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/veja-a-magia-dos-efeitos-visuais-de-wandavision/', NULL, NULL, 0, '2021-03-24', '2021-09-12 19:23:08', '2021-09-12 19:23:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(50, 1, 'Roteiro de WandaVision também deixou a atriz da Monica Rambeau confusa', 'roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa', 'roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa-jovemnerdsite', '/uploads/news/20210912072308_roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa/', NULL, NULL, 0, '2021-03-18', '2021-09-12 19:23:08', '2021-09-12 19:23:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(51, 1, 'Falcão e o Soldado Invernal é completamente diferente de WandaVision, diz roteirista', 'falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista', 'falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista-jovemnerdsite', '/uploads/news/20210912072308_falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista/', NULL, NULL, 0, '2021-03-17', '2021-09-12 19:23:09', '2021-09-12 19:23:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(52, 1, 'Benedict Cumberbatch pede desculpas aos fãs de WandaVision', 'benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision', 'benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision-jovemnerdsite', '/uploads/news/20210912072309_benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision/', NULL, NULL, 0, '2021-03-12', '2021-09-12 19:23:10', '2021-09-12 19:23:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(53, 1, 'Criadora de WandaVision nunca tinha ouvido falar do Mefisto', 'criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto', 'criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto-jovemnerdsite', '/uploads/news/20210912072310_criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto/', NULL, NULL, 0, '2021-03-12', '2021-09-12 19:23:11', '2021-09-12 19:23:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(54, 1, 'WandaVision: Nostalgia, teorias e luto', 'wandavision-nostalgia-teorias-e-luto', 'wandavision-nostalgia-teorias-e-luto-jovemnerdsite', '/uploads/news/20210912072311_wandavision-nostalgia-teorias-e-luto-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdcast/wandavision-nostalgia-teorias-e-luto/', NULL, NULL, 0, '2021-03-12', '2021-09-12 19:23:13', '2021-09-12 19:23:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(55, 1, 'Elizabeth Olsen ajudou no design do uniforme da Wanda em WandaVision', 'elizabeth-olsen-ajudou-no-design-do-uniforme-da-wanda-em-wandavision', 'elizabeth-olsen-ajudou-no-design-do-uniforme-da-wanda-em-wandavision-jovemnerdsite', '/uploads/news/20210912072313_elizabeth-olsen-ajudou-no-design-do-uniforme-da-wanda-em-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/elizabeth-olsen-ajudou-no-design-do-uniforme-da-wanda-em-wandavision/', NULL, NULL, 0, '2021-03-11', '2021-09-12 19:23:14', '2021-09-12 19:23:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(56, 1, 'Comerciais de WandaVision estão ligados ao subconsciente de Wanda, explica criadora', 'comerciais-de-wandavision-estao-ligados-ao-subconsciente-de-wanda-explica-criadora', 'comerciais-de-wandavision-estao-ligados-ao-subconsciente-de-wanda-explica-criadora-jovemnerdsite', '/uploads/news/20210912072314_comerciais-de-wandavision-estao-ligados-ao-subconsciente-de-wanda-explica-criadora-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/comerciais-de-wandavision-estao-ligados-ao-subconsciente-de-wanda-explica-criadora/', NULL, NULL, 0, '2021-03-11', '2021-09-12 19:23:15', '2021-09-12 19:23:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(57, 1, 'Com o final de WandaVision, Paul Betanny pede aos fãs que confiem em Kevin Feige', 'com-o-final-de-wandavision-paul-betanny-pede-aos-fas-que-confiem-em-kevin-feige', 'com-o-final-de-wandavision-paul-betanny-pede-aos-fas-que-confiem-em-kevin-feige-jovemnerdsite', '/uploads/news/20210912072315_com-o-final-de-wandavision-paul-betanny-pede-aos-fas-que-confiem-em-kevin-feige-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/com-o-final-de-wandavision-paul-betanny-pede-aos-fas-que-confiem-em-kevin-feige/', NULL, NULL, 0, '2021-03-10', '2021-09-12 19:23:15', '2021-09-12 19:23:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(58, 1, 'Elizabeth Olsen também pensou que aquela aparição em WandaVision seria um crossover', 'elizabeth-olsen-tambem-pensou-que-aquela-aparicao-em-wandavision-seria-um-crossover', 'elizabeth-olsen-tambem-pensou-que-aquela-aparicao-em-wandavision-seria-um-crossover-jovemnerdsite', '/uploads/news/20210912072315_elizabeth-olsen-tambem-pensou-que-aquela-aparicao-em-wandavision-seria-um-crossover-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/elizabeth-olsen-tambem-pensou-que-aquela-aparicao-em-wandavision-seria-um-crossover/', NULL, NULL, 0, '2021-03-10', '2021-09-12 19:23:21', '2021-09-12 19:23:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(59, 1, 'Roteirista fala sobre destino de Westview no final de WandaVision', 'roteirista-fala-sobre-destino-de-westview-no-final-de-wandavision', 'roteirista-fala-sobre-destino-de-westview-no-final-de-wandavision-jovemnerdsite', '/uploads/news/20210912072321_roteirista-fala-sobre-destino-de-westview-no-final-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/roteirista-fala-sobre-destino-de-westview-no-final-de-wandavision/', NULL, NULL, 0, '2021-03-10', '2021-09-12 19:23:22', '2021-09-12 19:23:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(60, 1, 'Criadora de WandaVision ficou surpresa com as teorias doidas dos fãs', 'criadora-de-wandavision-ficou-surpresa-com-as-teorias-doidas-dos-fas', 'criadora-de-wandavision-ficou-surpresa-com-as-teorias-doidas-dos-fas-jovemnerdsite', '/uploads/news/20210912072322_criadora-de-wandavision-ficou-surpresa-com-as-teorias-doidas-dos-fas-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/criadora-de-wandavision-ficou-surpresa-com-as-teorias-doidas-dos-fas/', NULL, NULL, 0, '2021-03-10', '2021-09-12 19:23:22', '2021-09-12 19:23:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(61, 1, 'Criadora de WandaVision explica por que aquele personagem não apareceu na série', 'criadora-de-wandavision-explica-por-que-aquele-personagem-nao-apareceu-na-serie', 'criadora-de-wandavision-explica-por-que-aquele-personagem-nao-apareceu-na-serie-jovemnerdsite', '/uploads/news/20210912072322_criadora-de-wandavision-explica-por-que-aquele-personagem-nao-apareceu-na-serie-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/criadora-de-wandavision-explica-por-que-aquele-personagem-nao-apareceu-na-serie/', NULL, NULL, 0, '2021-03-09', '2021-09-12 19:23:23', '2021-09-12 19:23:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(62, 1, 'WandaVision ganha linha de colecionáveis com detalhes impressionantes', 'wandavision-ganha-linha-de-colecionaveis-com-detalhes-impressionantes', 'wandavision-ganha-linha-de-colecionaveis-com-detalhes-impressionantes-jovemnerdsite', '/uploads/news/20210912072323_wandavision-ganha-linha-de-colecionaveis-com-detalhes-impressionantes-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-ganha-linha-de-colecionaveis-com-detalhes-impressionantes/', NULL, NULL, 0, '2021-03-09', '2021-09-12 19:23:24', '2021-09-12 19:23:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(63, 1, 'Episódio final de WandaVision ganha ilustração de Butcher Billy', 'episodio-final-de-wandavision-ganha-ilustracao-de-butcher-billy', 'episodio-final-de-wandavision-ganha-ilustracao-de-butcher-billy-jovemnerdsite', '/uploads/news/20210912072324_episodio-final-de-wandavision-ganha-ilustracao-de-butcher-billy-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/episodio-final-de-wandavision-ganha-ilustracao-de-butcher-billy/', NULL, NULL, 0, '2021-03-09', '2021-09-12 19:23:25', '2021-09-12 19:23:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(64, 1, 'Atriz de WandaVision diz que &8220;era impossível que as pessoas não ficassem desapontadas&8221;', 'atriz-de-wandavision-diz-que-8220era-impossivel-que-as-pessoas-nao-ficassem-desapontadas8221', 'atriz-de-wandavision-diz-que-8220era-impossivel-que-as-pessoas-nao-ficassem-desapontadas8221-jovemnerdsite', '/uploads/news/20210912072325_atriz-de-wandavision-diz-que-8220era-impossivel-que-as-pessoas-nao-ficassem-desapontadas8221-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/atriz-de-wandavision-diz-que-era-impossivel-que-as-pessoas-nao-ficassem-desapontadas/', NULL, NULL, 0, '2021-03-08', '2021-09-12 19:23:26', '2021-09-12 19:23:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(65, 1, 'WandaVision ganha novo Funko POP! com referências à cena pós-créditos', 'wandavision-ganha-novo-funko-pop-com-referencias-a-cena-pos-creditos', 'wandavision-ganha-novo-funko-pop-com-referencias-a-cena-pos-creditos-jovemnerdsite', '/uploads/news/20210912072326_wandavision-ganha-novo-funko-pop-com-referencias-a-cena-pos-creditos-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-ganha-novo-funko-pop-com-referencias-a-cena-pos-creditos/', NULL, NULL, 0, '2021-03-08', '2021-09-12 19:23:28', '2021-09-12 19:23:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(66, 12, 'DOUTOR ESTRANHO? MUDARAM O FINAL DE WANDAVISION!', 'doutor-estranho-mudaram-o-final-de-wandavision', 'doutor-estranho-mudaram-o-final-de-wandavision-quatrocoisasyoutube', '/uploads/news/20210912072523_doutor-estranho-mudaram-o-final-de-wandavision-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=bcHBAYkHH9k', NULL, NULL, 0, '2021-06-27', '2021-09-12 19:25:23', '2021-09-12 19:25:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(67, 12, 'CRÍTICA - EPISÓDIO FINAL DE WANDAVISION - ERA SÓ ISSO TUDO MESMO (SPOILERS)', 'critica-episodio-final-de-wandavision-era-so-isso-tudo-mesmo-spoilers', 'critica-episodio-final-de-wandavision-era-so-isso-tudo-mesmo-spoilers-quatrocoisasyoutube', '/uploads/news/20210912072525_critica-episodio-final-de-wandavision-era-so-isso-tudo-mesmo-spoilers-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=s7Mp2PUtQks', NULL, NULL, 0, '2021-03-05', '2021-09-12 19:25:26', '2021-09-12 19:25:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(68, 12, 'CONFIRMADO: DR. ESTRANHO FOI BARRADO EM WANDAVISION, ENTENDA PORQUE.', 'confirmado-dr-estranho-foi-barrado-em-wandavision-entenda-porque', 'confirmado-dr-estranho-foi-barrado-em-wandavision-entenda-porque-quatrocoisasyoutube', '/uploads/news/20210912072528_confirmado-dr-estranho-foi-barrado-em-wandavision-entenda-porque-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QPVmg2fWQog', NULL, NULL, 0, '2021-05-04', '2021-09-12 19:25:29', '2021-09-12 19:25:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(69, 12, 'ALGUÉM SABE PRA ONDE FOI O VISÃO? FINAL DE WANDAVISION EXPLICADO', 'alguem-sabe-pra-onde-foi-o-visao-final-de-wandavision-explicado', 'alguem-sabe-pra-onde-foi-o-visao-final-de-wandavision-explicado-quatrocoisasyoutube', '/uploads/news/20210912072533_alguem-sabe-pra-onde-foi-o-visao-final-de-wandavision-explicado-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=bqBrshSPfuY', NULL, NULL, 0, '2021-03-06', '2021-09-12 19:25:34', '2021-09-12 19:25:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(70, 12, 'WANDAVISION: CRÍTICA, EASTER EGGS E MUITO MAIS! (COM SPOILERS)', 'wandavision-critica-easter-eggs-e-muito-mais-com-spoilers', 'wandavision-critica-easter-eggs-e-muito-mais-com-spoilers-quatrocoisasyoutube', '/uploads/news/20210912072535_wandavision-critica-easter-eggs-e-muito-mais-com-spoilers-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=VRER3kuJqL8', NULL, NULL, 0, '2021-01-15', '2021-09-12 19:25:36', '2021-09-12 19:25:36');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(71, 12, 'PODE ACREDITAR! IMAGENS VAZADAS DE WANDAVISION SÃO INCRÍVEIS!', 'pode-acreditar-imagens-vazadas-de-wandavision-sao-incriveis', 'pode-acreditar-imagens-vazadas-de-wandavision-sao-incriveis-quatrocoisasyoutube', '/uploads/news/20210912072541_pode-acreditar-imagens-vazadas-de-wandavision-sao-incriveis-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=VEMzHt9DT38', NULL, NULL, 0, '2021-01-30', '2021-09-12 19:25:41', '2021-09-12 19:25:41');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(72, 12, 'É FALSO O POST COM UM MEGA SPOILER DE WANDAVISION? INVESTIGAMOS!', 'e-falso-o-post-com-um-mega-spoiler-de-wandavision-investigamos', 'e-falso-o-post-com-um-mega-spoiler-de-wandavision-investigamos-quatrocoisasyoutube', '/uploads/news/20210912072545_e-falso-o-post-com-um-mega-spoiler-de-wandavision-investigamos-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=KoZRxtE-sYI', NULL, NULL, 0, '2021-01-20', '2021-09-12 19:25:45', '2021-09-12 19:25:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(73, 12, 'RESPOSTAS! CRÍTICA QUARTO EPISÓDIO DE WANDAVISION (COM SPOILERS)', 'respostas-critica-quarto-episodio-de-wandavision-com-spoilers', 'respostas-critica-quarto-episodio-de-wandavision-com-spoilers-quatrocoisasyoutube', '/uploads/news/20210912072549_respostas-critica-quarto-episodio-de-wandavision-com-spoilers-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=LgkQGB10VPw', NULL, NULL, 0, '2021-01-29', '2021-09-12 19:25:50', '2021-09-12 19:25:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(74, 12, 'CENA CORTADA REVELA UM DEMÔNIO EM WANDAVISION, SERÁ ELE?', 'cena-cortada-revela-um-demonio-em-wandavision-sera-ele', 'cena-cortada-revela-um-demonio-em-wandavision-sera-ele-quatrocoisasyoutube', '/uploads/news/20210912072554_cena-cortada-revela-um-demonio-em-wandavision-sera-ele-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Z6Cqwrvle94', NULL, NULL, 0, '2021-03-09', '2021-09-12 19:25:54', '2021-09-12 19:25:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(75, 12, 'O HYPE FOI O VERDADEIRO VILÃO DE WANDAVISION?', 'o-hype-foi-o-verdadeiro-vilao-de-wandavision', 'o-hype-foi-o-verdadeiro-vilao-de-wandavision-quatrocoisasyoutube', '/uploads/news/20210912072559_o-hype-foi-o-verdadeiro-vilao-de-wandavision-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=1ercpOqUCTg', NULL, NULL, 0, '2021-03-06', '2021-09-12 19:25:59', '2021-09-12 19:25:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(76, 12, 'WANDAVISION! MUITOS DETALHES REVELADOS! REAÇÃO AO VIVO E COMENTÁRIOS SOBRE O TRAILER DUBLADO', 'wandavision-muitos-detalhes-revelados-reacao-ao-vivo-e-comentarios-sobre-o-trailer-dublado', 'wandavision-muitos-detalhes-revelados-reacao-ao-vivo-e-comentarios-sobre-o-trailer-dublado-quatrocoisasyoutube', '/uploads/news/20210912072603_wandavision-muitos-detalhes-revelados-reacao-ao-vivo-e-comentarios-sobre-o-trailer-dublado-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=lCJ-N86g6eY', NULL, NULL, 0, '2020-12-11', '2021-09-12 19:26:03', '2021-09-12 19:26:03');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(77, 12, 'WANDAVISION: PODE SER UMA SÉRIE SEM UM VILÃO?', 'wandavision-pode-ser-uma-serie-sem-um-vilao', 'wandavision-pode-ser-uma-serie-sem-um-vilao-quatrocoisasyoutube', '/uploads/news/20210912072605_wandavision-pode-ser-uma-serie-sem-um-vilao-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=A0DGeKGqM-0', NULL, NULL, 0, '2021-01-31', '2021-09-12 19:26:06', '2021-09-12 19:26:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(78, 12, 'FINAIS DE WANDAVISION E LOKI ACONTECEM AO MESMO TEMPO! FÃS JURAM QUE SIM!', 'finais-de-wandavision-e-loki-acontecem-ao-mesmo-tempo-fas-juram-que-sim', 'finais-de-wandavision-e-loki-acontecem-ao-mesmo-tempo-fas-juram-que-sim-quatrocoisasyoutube', '/uploads/news/20210912072609_finais-de-wandavision-e-loki-acontecem-ao-mesmo-tempo-fas-juram-que-sim-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Df_jcWgmOfU', NULL, NULL, 0, '2021-07-20', '2021-09-12 19:26:09', '2021-09-12 19:26:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(79, 12, 'PERSONAGEM ULTRASSECRETO DE WANDAVISION AINDA NÃO FOI REVELADO, DIZ ATOR. QUEM É ELE?', 'personagem-ultrassecreto-de-wandavision-ainda-nao-foi-revelado-diz-ator-quem-e-ele', 'personagem-ultrassecreto-de-wandavision-ainda-nao-foi-revelado-diz-ator-quem-e-ele-quatrocoisasyoutube', '/uploads/news/20210912072613_personagem-ultrassecreto-de-wandavision-ainda-nao-foi-revelado-diz-ator-quem-e-ele-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=4md275NM3Ro', NULL, NULL, 0, '2021-02-19', '2021-09-12 19:26:14', '2021-09-12 19:26:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(80, 12, 'REAÇÃO - TRAILER WANDAVISION | NOVA SÉRIE DA DISNEY+', 'reacao-trailer-wandavision-nova-serie-da-disney', 'reacao-trailer-wandavision-nova-serie-da-disney-quatrocoisasyoutube', '/uploads/news/20210912072619_reacao-trailer-wandavision-nova-serie-da-disney-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=VEiZFV8ctQk', NULL, NULL, 0, '2020-09-20', '2021-09-12 19:26:19', '2021-09-12 19:26:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(81, 12, '10 PERGUNTAS QUE WANDAVISION TEM QUE RESPONDER! (a 8 principalmente)', '10-perguntas-que-wandavision-tem-que-responder-a-8-principalmente', '10-perguntas-que-wandavision-tem-que-responder-a-8-principalmente-quatrocoisasyoutube', '/uploads/news/20210912075410_10-perguntas-que-wandavision-tem-que-responder-a-8-principalmente-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Ax2MlYbRDKM', NULL, NULL, 0, '2021-01-14', '2021-09-12 19:54:11', '2021-09-12 19:54:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(82, 12, 'CRÍTICA WANDAVISION: VAMOS FALAR SOBRE O EPISÍODIO 8 E TODO AQUELE FLASHBACK', 'critica-wandavision-vamos-falar-sobre-o-episiodio-8-e-todo-aquele-flashback', 'critica-wandavision-vamos-falar-sobre-o-episiodio-8-e-todo-aquele-flashback-quatrocoisasyoutube', '/uploads/news/20210912075415_critica-wandavision-vamos-falar-sobre-o-episiodio-8-e-todo-aquele-flashback-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Hr_v2BVXaMI', NULL, NULL, 0, '2021-02-26', '2021-09-12 19:54:15', '2021-09-12 19:54:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(83, 12, 'VOCÊ VIU? WANDAVISION FEZ UMA REFERÊNCIA CLARA AO QUARTETO FANTÁSTICO!', 'voce-viu-wandavision-fez-uma-referencia-clara-ao-quarteto-fantastico', 'voce-viu-wandavision-fez-uma-referencia-clara-ao-quarteto-fantastico-quatrocoisasyoutube', '/uploads/news/20210912075419_voce-viu-wandavision-fez-uma-referencia-clara-ao-quarteto-fantastico-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ZF-8evRvE2M', NULL, NULL, 0, '2021-02-02', '2021-09-12 19:54:20', '2021-09-12 19:54:20');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(84, 12, 'TEMOS MUITAS ATUALIZAÇÕES DA SÉRIE WANDAVISION PARA VOCÊ!', 'temos-muitas-atualizacoes-da-serie-wandavision-para-voce', 'temos-muitas-atualizacoes-da-serie-wandavision-para-voce-quatrocoisasyoutube', '/uploads/news/20210912075421_temos-muitas-atualizacoes-da-serie-wandavision-para-voce-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=MQ61E9ruT0M', NULL, NULL, 0, '2020-11-11', '2021-09-12 19:54:22', '2021-09-12 19:54:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(85, 12, 'BRINQUEDO ENTREGOU O GRANDE VILÃO DE WANDAVISION?', 'brinquedo-entregou-o-grande-vilao-de-wandavision', 'brinquedo-entregou-o-grande-vilao-de-wandavision-quatrocoisasyoutube', '/uploads/news/20210912075424_brinquedo-entregou-o-grande-vilao-de-wandavision-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=PthkyxXS85o', NULL, NULL, 0, '2021-02-03', '2021-09-12 19:54:25', '2021-09-12 19:54:25');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.news_tags
CREATE TABLE IF NOT EXISTS `news_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int NOT NULL,
  `tags_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.news_tags: ~82 rows (aproximadamente)
/*!40000 ALTER TABLE `news_tags` DISABLE KEYS */;
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 10, '2021-09-09 23:32:34', '2021-09-09 23:32:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(2, 2, 10, '2021-09-09 23:32:35', '2021-09-09 23:32:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(3, 3, 10, '2021-09-09 23:32:37', '2021-09-09 23:32:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(4, 4, 10, '2021-09-09 23:32:40', '2021-09-09 23:32:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(5, 5, 10, '2021-09-09 23:32:46', '2021-09-09 23:32:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(6, 6, 10, '2021-09-09 23:32:47', '2021-09-09 23:32:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(7, 7, 10, '2021-09-09 23:32:47', '2021-09-09 23:32:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(8, 8, 10, '2021-09-10 00:28:34', '2021-09-10 00:28:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(9, 9, 10, '2021-09-10 00:33:07', '2021-09-10 00:33:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(10, 10, 10, '2021-09-10 00:33:08', '2021-09-10 00:33:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(11, 11, 10, '2021-09-10 00:33:09', '2021-09-10 00:33:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(12, 12, 10, '2021-09-10 00:33:09', '2021-09-10 00:33:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(13, 13, 10, '2021-09-10 00:33:09', '2021-09-10 00:33:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(14, 14, 10, '2021-09-10 00:33:11', '2021-09-10 00:33:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(15, 15, 10, '2021-09-10 00:33:11', '2021-09-10 00:33:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(16, 16, 10, '2021-09-10 00:33:11', '2021-09-10 00:33:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(17, 17, 10, '2021-09-10 00:33:12', '2021-09-10 00:33:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(18, 18, 10, '2021-09-10 00:33:12', '2021-09-10 00:33:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(19, 19, 10, '2021-09-10 00:33:12', '2021-09-10 00:33:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(20, 20, 10, '2021-09-10 00:33:13', '2021-09-10 00:33:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(21, 21, 10, '2021-09-10 00:33:13', '2021-09-10 00:33:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(22, 22, 10, '2021-09-10 00:33:13', '2021-09-10 00:33:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(23, 23, 10, '2021-09-10 00:33:14', '2021-09-10 00:33:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(24, 24, 10, '2021-09-10 00:33:14', '2021-09-10 00:33:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(25, 25, 10, '2021-09-10 00:33:15', '2021-09-10 00:33:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(26, 26, 10, '2021-09-10 00:33:15', '2021-09-10 00:33:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(27, 27, 10, '2021-09-10 00:33:15', '2021-09-10 00:33:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(28, 28, 10, '2021-09-10 00:33:16', '2021-09-10 00:33:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(29, 29, 10, '2021-09-10 00:33:16', '2021-09-10 00:33:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(30, 30, 10, '2021-09-10 00:33:17', '2021-09-10 00:33:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(31, 31, 10, '2021-09-10 00:33:17', '2021-09-10 00:33:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(32, 32, 10, '2021-09-10 00:33:17', '2021-09-10 00:33:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(33, 33, 10, '2021-09-10 00:33:18', '2021-09-10 00:33:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(34, 34, 10, '2021-09-10 00:33:18', '2021-09-10 00:33:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(35, 35, 10, '2021-09-10 00:33:18', '2021-09-10 00:33:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(36, 36, 10, '2021-09-10 00:33:20', '2021-09-10 00:33:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(37, 37, 10, '2021-09-10 00:38:42', '2021-09-10 00:38:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(38, 38, 12, '2021-09-12 19:22:48', '2021-09-12 19:22:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(39, 39, 12, '2021-09-12 19:22:50', '2021-09-12 19:22:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(40, 40, 12, '2021-09-12 19:22:56', '2021-09-12 19:22:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(41, 41, 12, '2021-09-12 19:22:57', '2021-09-12 19:22:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(42, 42, 12, '2021-09-12 19:22:58', '2021-09-12 19:22:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(43, 43, 12, '2021-09-12 19:22:59', '2021-09-12 19:22:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(44, 44, 12, '2021-09-12 19:22:59', '2021-09-12 19:22:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(45, 45, 12, '2021-09-12 19:23:04', '2021-09-12 19:23:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(46, 46, 12, '2021-09-12 19:23:05', '2021-09-12 19:23:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(47, 47, 12, '2021-09-12 19:23:06', '2021-09-12 19:23:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(48, 48, 12, '2021-09-12 19:23:07', '2021-09-12 19:23:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(49, 49, 12, '2021-09-12 19:23:08', '2021-09-12 19:23:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(50, 50, 12, '2021-09-12 19:23:08', '2021-09-12 19:23:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(51, 51, 12, '2021-09-12 19:23:09', '2021-09-12 19:23:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(52, 52, 12, '2021-09-12 19:23:10', '2021-09-12 19:23:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(53, 53, 12, '2021-09-12 19:23:11', '2021-09-12 19:23:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(54, 54, 12, '2021-09-12 19:23:13', '2021-09-12 19:23:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(55, 55, 12, '2021-09-12 19:23:14', '2021-09-12 19:23:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(56, 56, 12, '2021-09-12 19:23:15', '2021-09-12 19:23:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(57, 57, 12, '2021-09-12 19:23:15', '2021-09-12 19:23:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(58, 58, 12, '2021-09-12 19:23:21', '2021-09-12 19:23:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(59, 59, 12, '2021-09-12 19:23:22', '2021-09-12 19:23:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(60, 60, 12, '2021-09-12 19:23:22', '2021-09-12 19:23:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(61, 61, 12, '2021-09-12 19:23:23', '2021-09-12 19:23:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(62, 62, 12, '2021-09-12 19:23:24', '2021-09-12 19:23:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(63, 63, 12, '2021-09-12 19:23:25', '2021-09-12 19:23:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(64, 64, 12, '2021-09-12 19:23:26', '2021-09-12 19:23:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(65, 65, 12, '2021-09-12 19:23:28', '2021-09-12 19:23:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(66, 66, 12, '2021-09-12 19:25:23', '2021-09-12 19:25:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(67, 67, 12, '2021-09-12 19:25:26', '2021-09-12 19:25:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(68, 68, 12, '2021-09-12 19:25:29', '2021-09-12 19:25:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(69, 69, 12, '2021-09-12 19:25:34', '2021-09-12 19:25:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(70, 70, 12, '2021-09-12 19:25:36', '2021-09-12 19:25:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(71, 71, 12, '2021-09-12 19:25:41', '2021-09-12 19:25:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(72, 72, 12, '2021-09-12 19:25:45', '2021-09-12 19:25:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(73, 73, 12, '2021-09-12 19:25:50', '2021-09-12 19:25:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(74, 74, 12, '2021-09-12 19:25:54', '2021-09-12 19:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(75, 75, 12, '2021-09-12 19:25:59', '2021-09-12 19:25:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(76, 76, 12, '2021-09-12 19:26:03', '2021-09-12 19:26:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(77, 77, 12, '2021-09-12 19:26:06', '2021-09-12 19:26:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(78, 78, 12, '2021-09-12 19:26:09', '2021-09-12 19:26:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(79, 79, 12, '2021-09-12 19:26:14', '2021-09-12 19:26:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(80, 80, 12, '2021-09-12 19:26:19', '2021-09-12 19:26:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(81, 81, 12, '2021-09-12 19:54:11', '2021-09-12 19:54:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(82, 82, 12, '2021-09-12 19:54:15', '2021-09-12 19:54:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(83, 83, 12, '2021-09-12 19:54:20', '2021-09-12 19:54:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(84, 84, 12, '2021-09-12 19:54:22', '2021-09-12 19:54:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(85, 85, 12, '2021-09-12 19:54:25', '2021-09-12 19:54:25');
/*!40000 ALTER TABLE `news_tags` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.password_resets
CREATE TABLE IF NOT EXISTS `password_resets` (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.password_resets: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `password_resets` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_resets` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.podcasts
CREATE TABLE IF NOT EXISTS `podcasts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channels_id` int NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description_short` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `order` int DEFAULT NULL,
  `data` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.podcasts: ~50 rows (aproximadamente)
/*!40000 ALTER TABLE `podcasts` DISABLE KEYS */;
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(1, 27, 'Caneca de Mamicas 19 - A pressa é inimiga do parto ideal', 'caneca-de-mamicas-19-a-pressa-e-inimiga-do-parto-ideal', 'caneca-de-mamicas-19-a-pressa-e-inimiga-do-parto-ideal-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f3a2c8432a594a091309cbef6', NULL, 'show', 'https://open.spotify.com/episode/68R7RqNKwELXI5cI2Dg9tT', NULL, NULL, 0, '2021-09-11', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(2, 27, 'NerdCast 794 - Oh Canada! A vida lá no norte da América', 'nerdcast-794-oh-canada-a-vida-la-no-norte-da-america', 'nerdcast-794-oh-canada-a-vida-la-no-norte-da-america-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fab1f6503654d537e040ba6d8', NULL, 'show', 'https://open.spotify.com/episode/5L6G2HZA3DIis45houZ5kJ', NULL, NULL, 0, '2021-09-10', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(3, 27, 'NerdCash 39 - As inevitáveis crises financeiras mundiais', 'nerdcash-39-as-inevitaveis-crises-financeiras-mundiais', 'nerdcash-39-as-inevitaveis-crises-financeiras-mundiais-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f4b071417cf9943e167733231', NULL, 'show', 'https://open.spotify.com/episode/6XdbVIIPBUI2XSFVPy8win', NULL, NULL, 0, '2021-09-10', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(4, 27, 'Lá do Bunker 06 - Hollywood odeia celular', 'la-do-bunker-06-hollywood-odeia-celular', 'la-do-bunker-06-hollywood-odeia-celular-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f64cf0155c3bbe7ff4f3e7134', NULL, 'show', 'https://open.spotify.com/episode/1ROn1bLO211nFeGGapmw0u', NULL, NULL, 0, '2021-09-06', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(5, 27, 'Caneca de Mamicas 18 - Quando o parto vira circo', 'caneca-de-mamicas-18-quando-o-parto-vira-circo', 'caneca-de-mamicas-18-quando-o-parto-vira-circo-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fa14d80c545e9407db3de1447', NULL, 'show', 'https://open.spotify.com/episode/4WMhHK7I3qWWfVE4ZvTtLq', NULL, NULL, 0, '2021-09-04', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(6, 27, 'NerdCast 793 - Pra entender o Afeganistão', 'nerdcast-793-pra-entender-o-afeganistao', 'nerdcast-793-pra-entender-o-afeganistao-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f8d60bcf23605c33ad8705cd8', NULL, 'show', 'https://open.spotify.com/episode/4slZCrZe8IxvNMUOvEjh4t', NULL, NULL, 0, '2021-09-03', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(7, 27, 'NerdTech 67 - Game DEV: Por trás do código', 'nerdtech-67-game-dev-por-tras-do-codigo', 'nerdtech-67-game-dev-por-tras-do-codigo-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fdf9404218124212bd7b88c6b', NULL, 'show', 'https://open.spotify.com/episode/5Xvl7Niqj6y4j9makrWIPE', NULL, NULL, 0, '2021-09-03', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(8, 27, 'Lá do Bunker 05 - E o Aranha, hein?', 'la-do-bunker-05-e-o-aranha-hein', 'la-do-bunker-05-e-o-aranha-hein-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f0149564b0434b821de0794bd', NULL, 'show', 'https://open.spotify.com/episode/0s1rjO42GfMebAHOixS7vt', NULL, NULL, 0, '2021-08-30', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(9, 27, 'Caneca de Mamicas 17 - BDSM  Bad Ass Modafoca', 'caneca-de-mamicas-17-bdsm-bad-ass-modafoca', 'caneca-de-mamicas-17-bdsm-bad-ass-modafoca-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f32469344287a5700fc43ffd3', NULL, 'show', 'https://open.spotify.com/episode/3d6ojcA2XSHqPlwe4T0N0o', NULL, NULL, 0, '2021-08-28', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(10, 27, 'NerdCast 792 - Hábitos estranhos e onde habitam', 'nerdcast-792-habitos-estranhos-e-onde-habitam', 'nerdcast-792-habitos-estranhos-e-onde-habitam-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f0b1d73a136842309a4188b61', NULL, 'show', 'https://open.spotify.com/episode/1elY0nPmLR3HMNkgFOpxSl', NULL, NULL, 0, '2021-08-27', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(11, 27, 'Empreendedor 79 - Dobrando a meta', 'empreendedor-79-dobrando-a-meta', 'empreendedor-79-dobrando-a-meta-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f8dba698b10c4eb248a84919f', NULL, 'show', 'https://open.spotify.com/episode/15ZRyiY2yaKdiy0rLW2uzv', NULL, NULL, 0, '2021-08-27', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(12, 27, 'Lá do Bunker 04 - Temos que pegar eu sei', 'la-do-bunker-04-temos-que-pegar-eu-sei', 'la-do-bunker-04-temos-que-pegar-eu-sei-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f9635a6190e02d330f07239aa', NULL, 'show', 'https://open.spotify.com/episode/4TXXZZYGwBaM56cA0siw3V', NULL, NULL, 0, '2021-08-23', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(13, 27, 'Caneca de Mamicas 16 - Quando o beijo é grego o tântrico desconfia', 'caneca-de-mamicas-16-quando-o-beijo-e-grego-o-tantrico-desconfia', 'caneca-de-mamicas-16-quando-o-beijo-e-grego-o-tantrico-desconfia-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f6fcc265279772b42d5159449', NULL, 'show', 'https://open.spotify.com/episode/1kGxHoQxuZz3o1aJrQIpse', NULL, NULL, 0, '2021-08-21', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(14, 27, 'NerdCast 791 - TENET: Entropia é cagar pra dentro!', 'nerdcast-791-tenet-entropia-e-cagar-pra-dentro', 'nerdcast-791-tenet-entropia-e-cagar-pra-dentro-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f8c784cf1c290bc716e88b3b5', NULL, 'show', 'https://open.spotify.com/episode/1MK08lXffIsgGwXCIgElFi', NULL, NULL, 0, '2021-08-20', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(15, 27, 'Speak English 42 - Frases marcantes do cinema', 'speak-english-42-frases-marcantes-do-cinema', 'speak-english-42-frases-marcantes-do-cinema-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f60a9f35644efd7196d2d9e10', NULL, 'show', 'https://open.spotify.com/episode/4odGy8sjAM4DIFCzIMGCzd', NULL, NULL, 0, '2021-08-20', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(16, 27, 'Papo de Parceiro 01 - O pior que pode acontecer é você vender!', 'papo-de-parceiro-01-o-pior-que-pode-acontecer-e-voce-vender', 'papo-de-parceiro-01-o-pior-que-pode-acontecer-e-voce-vender-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f536298f0abff9ecf19b95e29', NULL, 'show', 'https://open.spotify.com/episode/37JZ4uIv7oqDkVEdqBjvaH', NULL, NULL, 0, '2021-08-17', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(17, 27, 'Lá do Bunker 03 - Saudação à quinta série', 'la-do-bunker-03-saudacao-a-quinta-serie', 'la-do-bunker-03-saudacao-a-quinta-serie-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f7a09cbb4df5e09368226b574', NULL, 'show', 'https://open.spotify.com/episode/3BOW8627EqPB8H4IOZDdFo', NULL, NULL, 0, '2021-08-16', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(18, 27, 'Caneca de Mamicas 15 - Zerando a vida como um Rockstar', 'caneca-de-mamicas-15-zerando-a-vida-como-um-rockstar', 'caneca-de-mamicas-15-zerando-a-vida-como-um-rockstar-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1ff47ab9c3f7b54b31590d0a16', NULL, 'show', 'https://open.spotify.com/episode/6HFH1O0TCwn0LpzrSpekBb', NULL, NULL, 0, '2021-08-14', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(19, 27, 'NerdCast 790 - Egiptologia: Tutancamon, Napoleão e Durepox arqueológico', 'nerdcast-790-egiptologia-tutancamon-napoleao-e-durepox-arqueologico', 'nerdcast-790-egiptologia-tutancamon-napoleao-e-durepox-arqueologico-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f13c738d1a76ef0bf19a751eb', NULL, 'show', 'https://open.spotify.com/episode/3654oPT0plZ7DlhlWWoEwj', NULL, NULL, 0, '2021-08-13', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(20, 27, 'NerdCash 38 - O inevitável monstro da inflação', 'nerdcash-38-o-inevitavel-monstro-da-inflacao', 'nerdcash-38-o-inevitavel-monstro-da-inflacao-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1faf2d6d52b9f6708a20b89705', NULL, 'show', 'https://open.spotify.com/episode/5r9padwzpRjcvqbT6AkOS8', NULL, NULL, 0, '2021-08-13', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(21, 27, 'NerdCast Oferecido por Spotify - Paciente 63: De viajante do tempo e louco todo mundo tem um pouco', 'nerdcast-oferecido-por-spotify-paciente-63-de-viajante-do-tempo-e-louco-todo-mundo-tem-um-pouco', 'nerdcast-oferecido-por-spotify-paciente-63-de-viajante-do-tempo-e-louco-todo-mundo-tem-um-pouco-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1faeee24c55f512b68ac9fbaf8', NULL, 'show', 'https://open.spotify.com/episode/19PDOi9FVfYIck3HfCKiUn', NULL, NULL, 0, '2021-08-10', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(22, 27, 'Lá do Bunker 02 - A Revolta da Vacina', 'la-do-bunker-02-a-revolta-da-vacina', 'la-do-bunker-02-a-revolta-da-vacina-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f6024391f64034a27fefec178', NULL, 'show', 'https://open.spotify.com/episode/3oTZkk0mhP75upEbxNuzAx', NULL, NULL, 0, '2021-08-09', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(23, 27, 'Caneca de Mamicas 14 - Credo que 90s delícia', 'caneca-de-mamicas-14-credo-que-90s-delicia', 'caneca-de-mamicas-14-credo-que-90s-delicia-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fcfdd2abe24cb817e4350db4b', NULL, 'show', 'https://open.spotify.com/episode/3SSJ4mtCYdZM5OYQGLcrpF', NULL, NULL, 0, '2021-08-07', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(24, 27, 'NerdCast 789 - O que é um Rockstar? Histórias de músicos, músicas e estrada', 'nerdcast-789-o-que-e-um-rockstar-historias-de-musicos-musicas-e-estrada', 'nerdcast-789-o-que-e-um-rockstar-historias-de-musicos-musicas-e-estrada-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f217229914657a59fefc26048', NULL, 'show', 'https://open.spotify.com/episode/4Um6CL42X9ah4EKrL2jXQg', NULL, NULL, 0, '2021-08-06', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(25, 27, 'NerdTech 66 - UX no Pop-Up dos outros é refresco', 'nerdtech-66-ux-no-pop-up-dos-outros-e-refresco', 'nerdtech-66-ux-no-pop-up-dos-outros-e-refresco-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f91f96d6dcda4ead4a5b6d518', NULL, 'show', 'https://open.spotify.com/episode/5u3gKHkNhz21FFli7NXjyI', NULL, NULL, 0, '2021-08-06', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(26, 27, 'Lá do Bunker 01 - Começando do começo', 'la-do-bunker-01-comecando-do-comeco', 'la-do-bunker-01-comecando-do-comeco-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fdff466a81d5a49ad203b398d', NULL, 'show', 'https://open.spotify.com/episode/7m9VZU7N8YPwZVpK4Y00W2', NULL, NULL, 0, '2021-08-02', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(27, 27, 'Caneca de Mamicas 13 - Luiza Trajano e as mulheres do Brasil', 'caneca-de-mamicas-13-luiza-trajano-e-as-mulheres-do-brasil', 'caneca-de-mamicas-13-luiza-trajano-e-as-mulheres-do-brasil-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f3e197d6c930350b21f5cd8f5', NULL, 'show', 'https://open.spotify.com/episode/7021VTUwRvfKgFK092F7kg', NULL, NULL, 0, '2021-07-31', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(28, 27, 'NerdCast 788 - Qual é a pauta? Pelos desagradáveis, Rolex e p!r0c4 espacial!', 'nerdcast-788-qual-e-a-pauta-pelos-desagradaveis-rolex-e-pr0c4-espacial', 'nerdcast-788-qual-e-a-pauta-pelos-desagradaveis-rolex-e-pr0c4-espacial-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fa7bc21a87d52c911b58de3b9', NULL, 'show', 'https://open.spotify.com/episode/55TUJ37flHguAcMuOHDDQY', NULL, NULL, 0, '2021-07-30', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(29, 27, 'Empreendedor 78 - Falar em Público: Dom, Dor ou Habilidade?', 'empreendedor-78-falar-em-publico-dom-dor-ou-habilidade', 'empreendedor-78-falar-em-publico-dom-dor-ou-habilidade-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f09053fcf31e30d4e738c240e', NULL, 'show', 'https://open.spotify.com/episode/2BKPjOkucApVzA5pJFokGs', NULL, NULL, 0, '2021-07-30', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(30, 27, 'Generacast 07 - Genes, envelhecimento e imortalidade', 'generacast-07-genes-envelhecimento-e-imortalidade', 'generacast-07-genes-envelhecimento-e-imortalidade-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f395ebfadc04fc5ad0940f1c9', NULL, 'show', 'https://open.spotify.com/episode/5Xm3uA7uB43YsZZ7UfKplv', NULL, NULL, 0, '2021-07-27', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(31, 27, 'Caneca de Mamicas 12 - A gente quer, mas não precisa', 'caneca-de-mamicas-12-a-gente-quer-mas-nao-precisa', 'caneca-de-mamicas-12-a-gente-quer-mas-nao-precisa-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f048e381bbcd9ff9576f6d39b', NULL, 'show', 'https://open.spotify.com/episode/2api5oBKjeQonJFo82Gj2O', NULL, NULL, 0, '2021-07-24', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(32, 27, 'NerdCast 787 - Loki, Loki jacaré, Loki clássico, Loki arrependido, Loki apaixonado', 'nerdcast-787-loki-loki-jacare-loki-classico-loki-arrependido-loki-apaixonado', 'nerdcast-787-loki-loki-jacare-loki-classico-loki-arrependido-loki-apaixonado-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f7da26b55da0e0fa828ab3ed0', NULL, 'show', 'https://open.spotify.com/episode/3hYCbh21LUkEVtKOui3sN3', NULL, NULL, 0, '2021-07-23', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(33, 27, 'Speak English 41 - Luz, câmera e inglês!', 'speak-english-41-luz-camera-e-ingles', 'speak-english-41-luz-camera-e-ingles-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f839ea70267dce6e5a75f97bd', NULL, 'show', 'https://open.spotify.com/episode/1fiqddAD1GzunCvYnzrXpG', NULL, NULL, 0, '2021-07-23', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(34, 27, 'Caneca de Mamicas 11 - Culpa, fome, desespero e calça apertada', 'caneca-de-mamicas-11-culpa-fome-desespero-e-calca-apertada', 'caneca-de-mamicas-11-culpa-fome-desespero-e-calca-apertada-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fa38985c434867c8ae8f091fd', NULL, 'show', 'https://open.spotify.com/episode/5YoNwg0J4Y3t9EXjMLxNXG', NULL, NULL, 0, '2021-07-17', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(35, 27, 'NerdCast 786 - Viúva Negra: Casos de família e passagem de bastão', 'nerdcast-786-viuva-negra-casos-de-familia-e-passagem-de-bastao', 'nerdcast-786-viuva-negra-casos-de-familia-e-passagem-de-bastao-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fed4b3cb5b7f9e548af4990b2', NULL, 'show', 'https://open.spotify.com/episode/3HIYpu7h00Sr3HYMySYEJ2', NULL, NULL, 0, '2021-07-16', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(36, 27, 'Caneca de Mamicas 10 - O amor não está no mérito', 'caneca-de-mamicas-10-o-amor-nao-esta-no-merito', 'caneca-de-mamicas-10-o-amor-nao-esta-no-merito-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f3a7b387afa3825036ab3f045', NULL, 'show', 'https://open.spotify.com/episode/4Lf57ehZ9gYnPZYiduOOoT', NULL, NULL, 0, '2021-07-10', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(37, 27, 'NerdCast 785 - As vantagens, desafios e os macacos do home office', 'nerdcast-785-as-vantagens-desafios-e-os-macacos-do-home-office', 'nerdcast-785-as-vantagens-desafios-e-os-macacos-do-home-office-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f93da046f6e49b35da83992ce', NULL, 'show', 'https://open.spotify.com/episode/5l1CgXG6ery2S2BJPaFSk0', NULL, NULL, 0, '2021-07-09', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(38, 27, 'NerdCash 37 - Entendendo fundos de investimento', 'nerdcash-37-entendendo-fundos-de-investimento', 'nerdcash-37-entendendo-fundos-de-investimento-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1ff7031d2463a66148b910e900', NULL, 'show', 'https://open.spotify.com/episode/22USW8jb5V62UWMSKrUklB', NULL, NULL, 0, '2021-07-09', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(39, 27, 'Caneca de Mamicas 09 - Todos contra o bullying', 'caneca-de-mamicas-09-todos-contra-o-bullying', 'caneca-de-mamicas-09-todos-contra-o-bullying-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f3ea7cf237f5b284b1bdf6619', NULL, 'show', 'https://open.spotify.com/episode/22LmccGAImcJMguuPy3xPn', NULL, NULL, 0, '2021-07-03', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(40, 27, 'NerdCast 784 - CRINGE! MILLENNIALS E ZENIALS EM GUERRA (E OS BOOMERS ASSISTINDO)', 'nerdcast-784-cringe-millennials-e-zenials-em-guerra-e-os-boomers-assistindo', 'nerdcast-784-cringe-millennials-e-zenials-em-guerra-e-os-boomers-assistindo-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f88dc24f2b6e7711ef8179700', NULL, 'show', 'https://open.spotify.com/episode/7npQOHODMg6JMQhL22sp7v', NULL, NULL, 0, '2021-07-02', '2021-09-12 20:56:23', '2021-09-12 20:56:23');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(41, 27, 'NerdTech 65 - Autodefesa digital', 'nerdtech-65-autodefesa-digital', 'nerdtech-65-autodefesa-digital-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f6cd927ca4b2b46b87f042059', NULL, 'show', 'https://open.spotify.com/episode/2jpJet6JGpWSBffRTc1Auj', NULL, NULL, 0, '2021-07-02', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(42, 27, 'Caneca de Mamicas 08 - Vamos! Comigo! Que tá Magalvilhoso!', 'caneca-de-mamicas-08-vamos-comigo-que-ta-magalvilhoso', 'caneca-de-mamicas-08-vamos-comigo-que-ta-magalvilhoso-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1ffabd81d6813b726d2b8bc08c', NULL, 'show', 'https://open.spotify.com/episode/10kf8PX5khiOFhDo7HDkan', NULL, NULL, 0, '2021-06-26', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(43, 27, 'NerdCast 783 - Morangos, Morte & Robôtos 2', 'nerdcast-783-morangos-morte-robotos-2', 'nerdcast-783-morangos-morte-robotos-2-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fa27532d19e581be498838c1f', NULL, 'show', 'https://open.spotify.com/episode/65Xp2ja7FRP0vTRdNkxz70', NULL, NULL, 0, '2021-06-25', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(44, 27, 'Empreendedor 77 - M&A: quando 2+2=5', 'empreendedor-77-ma-quando-225', 'empreendedor-77-ma-quando-225-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1ffd2f8f332210ecf9333aaeda', NULL, 'show', 'https://open.spotify.com/episode/1ckhZN7q9LXJypTMHpLOl3', NULL, NULL, 0, '2021-06-25', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(45, 27, 'Caneca de Mamicas 07 - Sidney Magal (en)canta Mamicas', 'caneca-de-mamicas-07-sidney-magal-encanta-mamicas', 'caneca-de-mamicas-07-sidney-magal-encanta-mamicas-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f89c1d57e1b95b187deceefdf', NULL, 'show', 'https://open.spotify.com/episode/4wPFQtKK321QVRWds4DgS8', NULL, NULL, 0, '2021-06-19', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(46, 27, 'NerdCast 782 - Star Wars: A gente reclama mais do que sonha', 'nerdcast-782-star-wars-a-gente-reclama-mais-do-que-sonha', 'nerdcast-782-star-wars-a-gente-reclama-mais-do-que-sonha-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f57e609edb47d9dedb1a80efa', NULL, 'show', 'https://open.spotify.com/episode/2oeOUBu98DBy7L6i8zwwOS', NULL, NULL, 0, '2021-06-18', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(47, 27, 'Speak English 40 - Aprendendo inglês (e sobre  abacaxi invertido) em São Francisco', 'speak-english-40-aprendendo-ingles-e-sobre-abacaxi-invertido-em-sao-francisco', 'speak-english-40-aprendendo-ingles-e-sobre-abacaxi-invertido-em-sao-francisco-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f37ec21a4a1be801aa8bc03bf', NULL, 'show', 'https://open.spotify.com/episode/5FgNehf1LbPzZ3olFEIYMg', NULL, NULL, 0, '2021-06-18', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(48, 27, 'Caneca de Mamicas 06 - Me chama que eu vou, mas tudo no amor', 'caneca-de-mamicas-06-me-chama-que-eu-vou-mas-tudo-no-amor', 'caneca-de-mamicas-06-me-chama-que-eu-vou-mas-tudo-no-amor-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f66765b799f0401637848de08', NULL, 'show', 'https://open.spotify.com/episode/5qBaosSBJvygL4uf0L3bXp', NULL, NULL, 0, '2021-06-12', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(49, 27, 'NerdCast 781 - Especial Dia dos Namorados 2021', 'nerdcast-781-especial-dia-dos-namorados-2021', 'nerdcast-781-especial-dia-dos-namorados-2021-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f62ccce6ba27124a36483f30c', NULL, 'show', 'https://open.spotify.com/episode/2Hm2B6qGaYcyJEautseSan', NULL, NULL, 0, '2021-06-11', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(50, 27, 'NerdCash 36 - Especulação vs Dividendos', 'nerdcash-36-especulacao-vs-dividendos', 'nerdcash-36-especulacao-vs-dividendos-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f8c57b11347711e0add959f0b', NULL, 'show', 'https://open.spotify.com/episode/7ILtY7o9Is8pWo6PaUtyoL', NULL, NULL, 0, '2021-06-11', '2021-09-12 20:56:24', '2021-09-12 20:56:24');
/*!40000 ALTER TABLE `podcasts` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.tags
CREATE TABLE IF NOT EXISTS `tags` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `image` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `keywords` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `description_short` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `categoria` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `order` int NOT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela meuhype.tags: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(4, 'The Bad Batch', 'the-bad-batch', '<p>The Bad Batch</p>', '/uploads/fotos/20210523073544_TheBadBatch.jpg', 'The Bad Batch', 'The Bad Batch', '', 1, 'active', '2021-04-17 23:40:16', '2021-05-23 19:35:44');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(8, 'Falcão e Soldado Invernal', 'falcao-e-soldado-invernal', '<p>Descri&ccedil;&atilde;o Falc&atilde;o e Soldado Invernal</p>', '/uploads/fotos/20210523070702_FalcaoSoldadoInvernal.jpg', 'Falcão e Soldado Invernal', 'Falcão e Soldado Invernal', '', 1, 'active', '2021-04-18 10:49:40', '2021-05-23 19:07:02');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(9, 'Cobra Kai', 'cobra-kai', '<p>Cobra Kai</p>', '/uploads/fotos/20210523070329_KobraKai.jpg', 'Cobra Kai', 'Cobra Kai', '', 1, 'active', '2021-04-23 20:42:57', '2021-05-23 19:03:29');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(10, 'Mortal Kombat', 'mortal-kombat', '<p>Mortal Kombat</p>', '/uploads/fotos/20210523073530_MortalKombat.jpg', 'Mortal Kombat', 'Mortal Kombat', '', 1, 'active', '2021-05-01 22:20:33', '2021-05-23 19:35:30');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(11, 'Doutor Estranho', 'doutor-estranho', '<p>Doutor Estranho</p>', '/uploads/fotos/20210523072909_DoutorEstranho.jpg', 'Doutor Estranho', 'Doutor Estranho', '', 0, 'active', '2021-05-20 20:29:03', '2021-05-23 19:29:09');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(12, 'WandaVision', 'wandavision', '<p>WandaVision</p>', '/uploads/fotos/20210523073555_Wandavision.jpg', 'WandaVision', 'WandaVision', '', 0, 'active', '2021-05-20 20:30:18', '2021-05-23 19:35:55');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(13, 'Army of the Dead', 'army-of-the-dead', '<p>Army Of The Dead</p>', '/uploads/fotos/20210523064627_ArmyOfTheDead.jpg', 'Army Of The Dead', 'Army Of The Dead', '', 0, 'active', '2021-05-22 20:01:00', '2021-05-23 18:46:27');
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.uploads
CREATE TABLE IF NOT EXISTS `uploads` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `id_modulo` int NOT NULL,
  `modulo` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `size` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `size2` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `order` int NOT NULL,
  `status` varchar(10) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

-- Copiando dados para a tabela meuhype.uploads: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `uploads` DISABLE KEYS */;
/*!40000 ALTER TABLE `uploads` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sexo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `api_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_api_token_unique` (`api_token`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.users: ~5 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `name`, `email`, `sexo`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
	(1, 'Carlos Alberto Esteves Junior', 'carlosestevesjr0@gmail.com', 'masculino', '$2y$10$WWE.c9blXqU0DvaMaU2fMu1Rt4G/lEIs3dE53vBu3EHOrf2h26ywW', NULL, NULL, '2020-07-26 17:51:24', '2021-07-11 22:46:16');
INSERT INTO `users` (`id`, `name`, `email`, `sexo`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
	(2, 'Thays Gomes', 'thaysgalhardo03@gmail.com', 'feminino', '$2y$10$LLZOJKoOGL4xNcz43CMPtu5AvgRWDRXevYvq2C7lCe52zwLjwOpTe', 'LZ4eTcNolH3LRJsAWxcjgYZ7xo4Q90548Zaud0yJ82OMMV76Nglg77m53DFH60a913494fcf8', NULL, '2021-05-22 11:20:57', '2021-05-22 11:20:57');
INSERT INTO `users` (`id`, `name`, `email`, `sexo`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
	(3, 'Thays Gomes', 'thaysgalhardso03@gmail.com', 'masculino', '$2y$10$GHIdjZZzEaEgoOIwT.YYv.jjP62.OrnaWRIH5.6oaLoWpM0l9ZhW.', 'euK8XuvJ44mKVlRGiask4riiYkSOrODcHqbYdlDiwV5PgfuJl7dS0El3uwpz60a924a003b9a', NULL, '2021-05-22 12:34:56', '2021-05-22 12:34:56');
INSERT INTO `users` (`id`, `name`, `email`, `sexo`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
	(4, 'Thays Gomes', 'thaysgalhardsso03@gmail.com', 'masculino', '$2y$10$qXNs0dH/YhbBp0eA6j0hJe3TOzNN2EnXeRw9Ol5WLTrxaM.F2tlhy', 'RQDJzY14Sf0tfsDbSFspEqCHRvOE8pgo2rMsD8bWVq1XQorAFtwPOSW10gt860a924d6c9f13', NULL, '2021-05-22 12:35:51', '2021-05-22 12:35:51');
INSERT INTO `users` (`id`, `name`, `email`, `sexo`, `password`, `api_token`, `remember_token`, `created_at`, `updated_at`) VALUES
	(5, 'Julio Cezar', 'juliocezar@gmail.com', 'masculino', '$2y$10$MYdWsyxcg6JI4a/0fGa97e2smlslWfXu.RbP6q2bm1g3ZqFunQm.u', NULL, NULL, '2021-05-22 12:36:53', '2021-05-22 12:59:22');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.user_channels
CREATE TABLE IF NOT EXISTS `user_channels` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int DEFAULT NULL,
  `channels_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.user_channels: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_channels` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_channels` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.user_tags
CREATE TABLE IF NOT EXISTS `user_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `users_id` int DEFAULT NULL,
  `tags_id` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.user_tags: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tags` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
