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
CREATE DATABASE IF NOT EXISTS `meuhype` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
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
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(29, 'Tec Mundo Site', 'tecmundosite', 'tec-mundo-site', 'Tec Mundo Site', '<p>Tec Mundo Site</p>', NULL, 'site', 'active', 'https://www.tecmundo.com.br/', 'https://www.tecmundo.com.br/busca?q=', NULL, NULL, NULL, NULL, NULL, 1, '2021-09-21 21:37:24', '2021-09-21 21:37:24');
INSERT INTO `channels` (`id`, `name`, `hash`, `slug`, `description_short`, `description`, `keywords`, `type`, `status`, `link`, `url_crawler`, `youtube`, `instagram`, `facebook`, `twitter`, `image`, `order`, `created_at`, `updated_at`) VALUES
	(30, 'Poltrona Nerd Site', 'poltronanerdsite', 'poltrona-nerd-site', 'Poltrona Nerd Site', '<p>Poltrona Nerd Site</p>', NULL, 'site', 'active', 'https://poltronanerd.com.br/', 'https://poltronanerd.com.br/?s=', NULL, NULL, NULL, NULL, NULL, 1, '2021-09-21 23:23:16', '2021-09-21 23:23:16');
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.crawler: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `crawler` DISABLE KEYS */;
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(1, 'Crawler 2', 4, '20:39:00', 'site', '<p>Crawler 2</p>', 1, 'hidden', '2021-04-18 09:30:31', '2021-04-28 22:08:53');
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(2, 'Crawler 1', 8, '02:59:00', 'site', '<p>Teste</p>', 1, 'active', '2021-04-18 22:05:30', '2021-05-02 02:42:35');
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(3, 'Spotify - Podcasts', 0, '00:18:00', 'spotify', '<p>Spotify</p>', 1, 'active', '2021-04-21 23:14:55', '2021-04-23 21:20:11');
INSERT INTO `crawler` (`id`, `title`, `tags_id`, `time_initial`, `type`, `description`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(4, 'Crawler 3', 12, '23:28:00', 'site', NULL, 1, 'active', '2021-05-01 22:21:31', '2022-04-28 23:24:41');
/*!40000 ALTER TABLE `crawler` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.crawler_configs
CREATE TABLE IF NOT EXISTS `crawler_configs` (
  `id` int NOT NULL,
  `array_canais_ativos` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `qtd_noticias_por_canal` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.crawler_configs: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `crawler_configs` DISABLE KEYS */;
INSERT INTO `crawler_configs` (`id`, `array_canais_ativos`, `qtd_noticias_por_canal`, `created_at`, `updated_at`) VALUES
	(1, '["arenanerdyoutube","caiqueizotonyoutube","caldeiraonerdyoutube","cavernadocarusoyoutube","cinemacomrapadurayoutube","crispandayoutube","einerdyoutube","entremigasyoutube","gustavocunhayoutube","herancanerdyoutube","jovemnerdsite","jovemnerdyoutube","miguellokiayoutube","nerdexperienceyoutube","nerdnewsyoutube","nerdrabugentoyoutube","nerdlandyoutube","omeletesite","omeleteyoutube","operacaocinemayoutube","pipocandoyoutube","poltronanerdsite","quatrocoisasyoutube","sessaonerdyoutube","superoitoyoutube","tecmundosite","thiagoromarizyoutube"]', 10, '2021-09-12 18:01:22', '2022-03-12 01:42:35');
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
) ENGINE=InnoDB AUTO_INCREMENT=196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.news: ~186 rows (aproximadamente)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(1, 3, 'Doutor Estranho 2 | Teaser confirma Xavier e sugere personagem de What If?', 'doutor-estranho-2-teaser-confirma-xavier-e-sugere-personagem-de-what-if', 'doutor-estranho-2-teaser-confirma-xavier-e-sugere-personagem-de-what-if-omeletesite', '/uploads/news/20220428111716_doutor-estranho-2-teaser-confirma-xavier-e-sugere-personagem-de-what-if-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-no-multiverso-da-loucura-professor-xavier-cadeira-teaser', NULL, NULL, 0, '2022-04-28', '2022-04-28 23:17:16', '2022-04-28 23:17:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(2, 3, 'Doutor Estranho salva America Chavez em cena inédita', 'doutor-estranho-salva-america-chavez-em-cena-inedita', 'doutor-estranho-salva-america-chavez-em-cena-inedita-omeletesite', '/uploads/news/20220428111716_doutor-estranho-salva-america-chavez-em-cena-inedita-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-salva-america-chavez-em-nova-cena-inedita', NULL, NULL, 0, '2022-04-28', '2022-04-28 23:17:16', '2022-04-28 23:17:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(3, 3, 'Doutor Estranho 2 | Marvel exibe 20 minutos na CinemaCon; veja a descrição', 'doutor-estranho-2-marvel-exibe-20-minutos-na-cinemacon-veja-a-descricao', 'doutor-estranho-2-marvel-exibe-20-minutos-na-cinemacon-veja-a-descricao-omeletesite', '/uploads/news/20220428111716_doutor-estranho-2-marvel-exibe-20-minutos-na-cinemacon-veja-a-descricao-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-2-abertura-cinemacon', NULL, NULL, 0, '2022-04-27', '2022-04-28 23:17:17', '2022-04-28 23:17:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(4, 3, 'Doutor Estranho 2 | Benedict Cumberbatch comenta banimento na Arábia Saudita', 'doutor-estranho-2-benedict-cumberbatch-comenta-banimento-na-arabia-saudita', 'doutor-estranho-2-benedict-cumberbatch-comenta-banimento-na-arabia-saudita-omeletesite', '/uploads/news/20220428111717_doutor-estranho-2-benedict-cumberbatch-comenta-banimento-na-arabia-saudita-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-2-no-multiverso-da-loucura-benedict-cumberbatch-comenta-censura', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:17', '2022-04-28 23:17:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(5, 3, 'Doutor Estranho 2 | Comercial confirma de vez presença dos Illuminati', 'doutor-estranho-2-comercial-confirma-de-vez-presenca-dos-illuminati', 'doutor-estranho-2-comercial-confirma-de-vez-presenca-dos-illuminati-omeletesite', '/uploads/news/20220428111717_doutor-estranho-2-comercial-confirma-de-vez-presenca-dos-illuminati-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-2-teaser-confirma-illuminati', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:17', '2022-04-28 23:17:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(6, 3, 'Doutor Estranho no Multiverso da Loucura ganha incrível pôster final; veja', 'doutor-estranho-no-multiverso-da-loucura-ganha-incrivel-poster-final-veja', 'doutor-estranho-no-multiverso-da-loucura-ganha-incrivel-poster-final-veja-omeletesite', '/uploads/news/20220428111717_doutor-estranho-no-multiverso-da-loucura-ganha-incrivel-poster-final-veja-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/doutor-estranho-2-poster', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:18', '2022-04-28 23:17:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(7, 3, 'Doutor Estranho 2 | Realidade se estilhaça em novos banners', 'doutor-estranho-2-realidade-se-estilhaca-em-novos-banners', 'doutor-estranho-2-realidade-se-estilhaca-em-novos-banners-omeletesite', '/uploads/news/20220428111718_doutor-estranho-2-realidade-se-estilhaca-em-novos-banners-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-2-no-multiverso-da-loucura-banners-realidades-fraturadas', NULL, NULL, 0, '2022-04-22', '2022-04-28 23:17:18', '2022-04-28 23:17:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(8, 3, 'Doutor Estranho 2 | Chegada de Sam Raimi e visual louco são foco de novo vídeo', 'doutor-estranho-2-chegada-de-sam-raimi-e-visual-louco-sao-foco-de-novo-video', 'doutor-estranho-2-chegada-de-sam-raimi-e-visual-louco-sao-foco-de-novo-video-omeletesite', '/uploads/news/20220428111718_doutor-estranho-2-chegada-de-sam-raimi-e-visual-louco-sao-foco-de-novo-video-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-2-no-multiverso-da-loucura-sam-raimi-featurette', NULL, NULL, 0, '2022-04-22', '2022-04-28 23:17:19', '2022-04-28 23:17:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(9, 3, 'Doutor Estranho no Multiverso da Loucura não será exibido na Arábia Saudita', 'doutor-estranho-no-multiverso-da-loucura-nao-sera-exibido-na-arabia-saudita', 'doutor-estranho-no-multiverso-da-loucura-nao-sera-exibido-na-arabia-saudita-omeletesite', '/uploads/news/20220428111719_doutor-estranho-no-multiverso-da-loucura-nao-sera-exibido-na-arabia-saudita-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/doutor-estranho-2-no-multiverso-da-loucura-proibido-arabia-saudita', NULL, NULL, 0, '2022-04-22', '2022-04-28 23:17:19', '2022-04-28 23:17:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(10, 1, 'Doutor Estranho 2 ganha teaser com Professor Xavier e ligação com What If?', 'doutor-estranho-2-ganha-teaser-com-professor-xavier-e-ligacao-com-what-if', 'doutor-estranho-2-ganha-teaser-com-professor-xavier-e-ligacao-com-what-if-jovemnerdsite', '/uploads/news/20220428111723_doutor-estranho-2-ganha-teaser-com-professor-xavier-e-ligacao-com-what-if-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-ganha-teaser-com-professor-xavier-what-if/', NULL, NULL, 0, '2022-04-28', '2022-04-28 23:17:24', '2022-04-28 23:17:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(11, 1, 'Minutos iniciais de Doutor Estranho 2 trazem multiverso e muita ação; leia a descrição', 'minutos-iniciais-de-doutor-estranho-2-trazem-multiverso-e-muita-acao-leia-a-descricao', 'minutos-iniciais-de-doutor-estranho-2-trazem-multiverso-e-muita-acao-leia-a-descricao-jovemnerdsite', '/uploads/news/20220428111724_minutos-iniciais-de-doutor-estranho-2-trazem-multiverso-e-muita-acao-leia-a-descricao-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-primeiros-minutos-descricao/', NULL, NULL, 0, '2022-04-28', '2022-04-28 23:17:25', '2022-04-28 23:17:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(12, 1, 'Doutor Estranho e America Chavez lutam contra monstro gigante em cena inédita', 'doutor-estranho-e-america-chavez-lutam-contra-monstro-gigante-em-cena-inedita', 'doutor-estranho-e-america-chavez-lutam-contra-monstro-gigante-em-cena-inedita-jovemnerdsite', '/uploads/news/20220428111725_doutor-estranho-e-america-chavez-lutam-contra-monstro-gigante-em-cena-inedita-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-multiverso-da-loucura-cena-inedita-america-chavez/', NULL, NULL, 0, '2022-04-28', '2022-04-28 23:17:26', '2022-04-28 23:17:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(13, 1, 'Benedict Cumberbatch defende personagem LGBT+ em Doutor Estranho 2 após banimento', 'benedict-cumberbatch-defende-personagem-lgbt-em-doutor-estranho-2-apos-banimento', 'benedict-cumberbatch-defende-personagem-lgbt-em-doutor-estranho-2-apos-banimento-jovemnerdsite', '/uploads/news/20220428111726_benedict-cumberbatch-defende-personagem-lgbt-em-doutor-estranho-2-apos-banimento-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-benedict-cumberbatch-defende-personagem-lgbt/', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:28', '2022-04-28 23:17:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(14, 1, 'Variantes tomam conta do novo pôster de Doutor Estranho no Multiverso da Loucura', 'variantes-tomam-conta-do-novo-poster-de-doutor-estranho-no-multiverso-da-loucura', 'variantes-tomam-conta-do-novo-poster-de-doutor-estranho-no-multiverso-da-loucura-jovemnerdsite', '/uploads/news/20220428111728_variantes-tomam-conta-do-novo-poster-de-doutor-estranho-no-multiverso-da-loucura-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-poster-variantes/', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:29', '2022-04-28 23:17:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(15, 1, 'Novo teaser de Doutor Estranho 2 finalmente cita os Illuminati da Marvel', 'novo-teaser-de-doutor-estranho-2-finalmente-cita-os-illuminati-da-marvel', 'novo-teaser-de-doutor-estranho-2-finalmente-cita-os-illuminati-da-marvel-jovemnerdsite', '/uploads/news/20220428111729_novo-teaser-de-doutor-estranho-2-finalmente-cita-os-illuminati-da-marvel-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-teaser-confirma-illuminati/', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:30', '2022-04-28 23:17:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(16, 1, 'Doutor Estranho 2 é banido no Egito e Arábia Saudita por ter conteúdo LGBTQ+', 'doutor-estranho-2-e-banido-no-egito-e-arabia-saudita-por-ter-conteudo-lgbtq', 'doutor-estranho-2-e-banido-no-egito-e-arabia-saudita-por-ter-conteudo-lgbtq-jovemnerdsite', '/uploads/news/20220428111730_doutor-estranho-2-e-banido-no-egito-e-arabia-saudita-por-ter-conteudo-lgbtq-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-banido-egito-arabia-saudita/', NULL, NULL, 0, '2022-04-25', '2022-04-28 23:17:31', '2022-04-28 23:17:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(17, 1, 'Doutor Estranho no Multiverso da Loucura recebe pôsteres de Bosslogic', 'doutor-estranho-no-multiverso-da-loucura-recebe-posteres-de-bosslogic', 'doutor-estranho-no-multiverso-da-loucura-recebe-posteres-de-bosslogic-jovemnerdsite', '/uploads/news/20220428111731_doutor-estranho-no-multiverso-da-loucura-recebe-posteres-de-bosslogic-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-posteres-bosslogic/', NULL, NULL, 0, '2022-04-23', '2022-04-28 23:17:32', '2022-04-28 23:17:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(18, 1, 'Strange comparece ao casamento de Christine Palmer em foto de Doutor Estranho 2', 'strange-comparece-ao-casamento-de-christine-palmer-em-foto-de-doutor-estranho-2', 'strange-comparece-ao-casamento-de-christine-palmer-em-foto-de-doutor-estranho-2-jovemnerdsite', '/uploads/news/20220428111732_strange-comparece-ao-casamento-de-christine-palmer-em-foto-de-doutor-estranho-2-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-casamento/', NULL, NULL, 0, '2022-04-22', '2022-04-28 23:17:33', '2022-04-28 23:17:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(19, 1, 'Doutor Estranho no Multiverso da Loucura destaca Sam Raimi em novo vídeo', 'doutor-estranho-no-multiverso-da-loucura-destaca-sam-raimi-em-novo-video', 'doutor-estranho-no-multiverso-da-loucura-destaca-sam-raimi-em-novo-video-jovemnerdsite', '/uploads/news/20220428111733_doutor-estranho-no-multiverso-da-loucura-destaca-sam-raimi-em-novo-video-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-video-sam-raimi/', NULL, NULL, 0, '2022-04-22', '2022-04-28 23:17:34', '2022-04-28 23:17:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(20, 1, 'Doutor Estranho 2 destaca poderes da Feiticeira Escarlate em teaser', 'doutor-estranho-2-destaca-poderes-da-feiticeira-escarlate-em-teaser', 'doutor-estranho-2-destaca-poderes-da-feiticeira-escarlate-em-teaser-jovemnerdsite', '/uploads/news/20220428111734_doutor-estranho-2-destaca-poderes-da-feiticeira-escarlate-em-teaser-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-multiverso-da-loucura-teaser-feiticeira-escarlate/', NULL, NULL, 0, '2022-04-18', '2022-04-28 23:17:35', '2022-04-28 23:17:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(21, 1, 'Strange tem acerto de contas em novo comercial de Doutor Estranho 2', 'strange-tem-acerto-de-contas-em-novo-comercial-de-doutor-estranho-2', 'strange-tem-acerto-de-contas-em-novo-comercial-de-doutor-estranho-2-jovemnerdsite', '/uploads/news/20220428111735_strange-tem-acerto-de-contas-em-novo-comercial-de-doutor-estranho-2-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/strange-tem-acerto-de-contas-em-novo-comercial-de-doutor-estranho-2/', NULL, NULL, 0, '2022-04-13', '2022-04-28 23:17:37', '2022-04-28 23:17:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(22, 1, 'Personagens de Doutor Estranho no Multiverso da Loucura ganham cartazes individuais', 'personagens-de-doutor-estranho-no-multiverso-da-loucura-ganham-cartazes-individuais', 'personagens-de-doutor-estranho-no-multiverso-da-loucura-ganham-cartazes-individuais-jovemnerdsite', '/uploads/news/20220428111737_personagens-de-doutor-estranho-no-multiverso-da-loucura-ganham-cartazes-individuais-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-cartazes-individuais/', NULL, NULL, 0, '2022-04-11', '2022-04-28 23:17:38', '2022-04-28 23:17:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(23, 1, 'Vídeo de bastidores de Doutor Estranho no Multiverso da Loucura tem cenas inéditas', 'video-de-bastidores-de-doutor-estranho-no-multiverso-da-loucura-tem-cenas-ineditas', 'video-de-bastidores-de-doutor-estranho-no-multiverso-da-loucura-tem-cenas-ineditas-jovemnerdsite', '/uploads/news/20220428111738_video-de-bastidores-de-doutor-estranho-no-multiverso-da-loucura-tem-cenas-ineditas-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/video-de-bastidores-de-doutor-estranho-no-multiverso-da-loucura-tem-cenas-ineditas/', NULL, NULL, 0, '2022-04-11', '2022-04-28 23:17:39', '2022-04-28 23:17:39');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(24, 1, 'Sam Raimi não garante que Patrick Stewart está em Doutor Estranho 2', 'sam-raimi-nao-garante-que-patrick-stewart-esta-em-doutor-estranho-2', 'sam-raimi-nao-garante-que-patrick-stewart-esta-em-doutor-estranho-2-jovemnerdsite', '/uploads/news/20220428111739_sam-raimi-nao-garante-que-patrick-stewart-esta-em-doutor-estranho-2-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/sam-raimi-nao-garante-que-patrick-stewart-esta-em-doutor-estranho-2/', NULL, NULL, 0, '2022-04-07', '2022-04-28 23:17:40', '2022-04-28 23:17:40');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(25, 1, 'Doutor Estranho no Multiverso da Loucura ganha um monte de cartazes inéditos', 'doutor-estranho-no-multiverso-da-loucura-ganha-um-monte-de-cartazes-ineditos', 'doutor-estranho-no-multiverso-da-loucura-ganha-um-monte-de-cartazes-ineditos-jovemnerdsite', '/uploads/news/20220428111740_doutor-estranho-no-multiverso-da-loucura-ganha-um-monte-de-cartazes-ineditos-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-ganha-um-monte-de-cartazes-ineditos/', NULL, NULL, 0, '2022-04-06', '2022-04-28 23:17:41', '2022-04-28 23:17:41');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(26, 1, 'Personagens de WandaVision estão de volta em novo teaser de Doutor Estranho 2', 'personagens-de-wandavision-estao-de-volta-em-novo-teaser-de-doutor-estranho-2', 'personagens-de-wandavision-estao-de-volta-em-novo-teaser-de-doutor-estranho-2-jovemnerdsite', '/uploads/news/20220428111741_personagens-de-wandavision-estao-de-volta-em-novo-teaser-de-doutor-estranho-2-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-teaser-personagens-wandavision/', NULL, NULL, 0, '2022-04-06', '2022-04-28 23:17:42', '2022-04-28 23:17:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(27, 1, 'Doutor Estranho no Multiverso da Loucura pode ter só 2 horas de duração, diz site', 'doutor-estranho-no-multiverso-da-loucura-pode-ter-so-2-horas-de-duracao-diz-site', 'doutor-estranho-no-multiverso-da-loucura-pode-ter-so-2-horas-de-duracao-diz-site-jovemnerdsite', '/uploads/news/20220428111742_doutor-estranho-no-multiverso-da-loucura-pode-ter-so-2-horas-de-duracao-diz-site-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-pode-ter-so-2-horas-de-duracao-diz-site/', NULL, NULL, 0, '2022-04-05', '2022-04-28 23:17:43', '2022-04-28 23:17:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(28, 1, 'Doutor Estranho no Multiverso da Loucura ganha cartazes para anunciar pré-venda', 'doutor-estranho-no-multiverso-da-loucura-ganha-cartazes-para-anunciar-pre-venda', 'doutor-estranho-no-multiverso-da-loucura-ganha-cartazes-para-anunciar-pre-venda-jovemnerdsite', '/uploads/news/20220428111743_doutor-estranho-no-multiverso-da-loucura-ganha-cartazes-para-anunciar-pre-venda-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-pre-venda-cartazes/', NULL, NULL, 0, '2022-04-04', '2022-04-28 23:17:44', '2022-04-28 23:17:44');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(29, 1, 'Wanda é destaque em novo teaser de Doutor Estranho no Multiverso da Loucura', 'wanda-e-destaque-em-novo-teaser-de-doutor-estranho-no-multiverso-da-loucura', 'wanda-e-destaque-em-novo-teaser-de-doutor-estranho-no-multiverso-da-loucura-jovemnerdsite', '/uploads/news/20220428111744_wanda-e-destaque-em-novo-teaser-de-doutor-estranho-no-multiverso-da-loucura-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-novo-teaser-wanda-feiticeira-escarlate/', NULL, NULL, 0, '2022-04-02', '2022-04-28 23:17:45', '2022-04-28 23:17:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(30, 1, 'Pré-venda de ingressos para Doutor Estranho 2 começa na próxima semana', 'pre-venda-de-ingressos-para-doutor-estranho-2-comeca-na-proxima-semana', 'pre-venda-de-ingressos-para-doutor-estranho-2-comeca-na-proxima-semana-jovemnerdsite', '/uploads/news/20220428111745_pre-venda-de-ingressos-para-doutor-estranho-2-comeca-na-proxima-semana-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-data-pre-venda-ingressos/', NULL, NULL, 0, '2022-04-01', '2022-04-28 23:17:46', '2022-04-28 23:17:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(31, 1, 'Strange e America Chavez estão juntos em nova foto de Doutor Estranho 2', 'strange-e-america-chavez-estao-juntos-em-nova-foto-de-doutor-estranho-2', 'strange-e-america-chavez-estao-juntos-em-nova-foto-de-doutor-estranho-2-jovemnerdsite', '/uploads/news/20220428111746_strange-e-america-chavez-estao-juntos-em-nova-foto-de-doutor-estranho-2-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-nova-foto-america-chavez/', NULL, NULL, 0, '2022-03-29', '2022-04-28 23:17:47', '2022-04-28 23:17:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(32, 1, 'James McAvoy diz que não está em Doutor Estranho 2 nem sente falta de X-Men', 'james-mcavoy-diz-que-nao-esta-em-doutor-estranho-2-nem-sente-falta-de-x-men', 'james-mcavoy-diz-que-nao-esta-em-doutor-estranho-2-nem-sente-falta-de-x-men-jovemnerdsite', '/uploads/news/20220428111747_james-mcavoy-diz-que-nao-esta-em-doutor-estranho-2-nem-sente-falta-de-x-men-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/james-mcavoy-diz-que-nao-esta-em-doutor-estranho-2-nem-sente-falta-de-x-men/', NULL, NULL, 0, '2022-03-24', '2022-04-28 23:17:48', '2022-04-28 23:17:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(33, 1, 'Doutor Estranho no Multiverso da Loucura terá quase duas horas e meia, diz site', 'doutor-estranho-no-multiverso-da-loucura-tera-quase-duas-horas-e-meia-diz-site', 'doutor-estranho-no-multiverso-da-loucura-tera-quase-duas-horas-e-meia-diz-site-jovemnerdsite', '/uploads/news/20220428111748_doutor-estranho-no-multiverso-da-loucura-tera-quase-duas-horas-e-meia-diz-site-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-duracao/', NULL, NULL, 0, '2022-03-24', '2022-04-28 23:17:49', '2022-04-28 23:17:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(34, 1, 'Benedict Cumberbatch diz que Doutor Estranho 2 foi difícil, mas muito recompensador', 'benedict-cumberbatch-diz-que-doutor-estranho-2-foi-dificil-mas-muito-recompensador', 'benedict-cumberbatch-diz-que-doutor-estranho-2-foi-dificil-mas-muito-recompensador-jovemnerdsite', '/uploads/news/20220428111749_benedict-cumberbatch-diz-que-doutor-estranho-2-foi-dificil-mas-muito-recompensador-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-multiverso-da-loucura-benedict-cumberbatch-dificil/', NULL, NULL, 0, '2022-03-18', '2022-04-28 23:17:50', '2022-04-28 23:17:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(35, 1, 'Novas fotos de Doutor Estranho 2 mostram America Chavez, Wong e mais', 'novas-fotos-de-doutor-estranho-2-mostram-america-chavez-wong-e-mais', 'novas-fotos-de-doutor-estranho-2-mostram-america-chavez-wong-e-mais-jovemnerdsite', '/uploads/news/20220428111750_novas-fotos-de-doutor-estranho-2-mostram-america-chavez-wong-e-mais-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-no-multiverso-da-loucura-novas-fotos-wong-bastidores/', NULL, NULL, 0, '2022-03-18', '2022-04-28 23:17:51', '2022-04-28 23:17:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(36, 1, 'Doutor Estranho 2 vai deixar fãs de Evil Dead felizes, diz Kevin Feige', 'doutor-estranho-2-vai-deixar-fas-de-evil-dead-felizes-diz-kevin-feige', 'doutor-estranho-2-vai-deixar-fas-de-evil-dead-felizes-diz-kevin-feige-jovemnerdsite', '/uploads/news/20220428111751_doutor-estranho-2-vai-deixar-fas-de-evil-dead-felizes-diz-kevin-feige-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-vai-deixar-fas-de-evil-dead-felizes-diz-kevin-feige/', NULL, NULL, 0, '2022-03-17', '2022-04-28 23:17:53', '2022-04-28 23:17:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(37, 1, 'Benedict Cumberbatch explica que Doutor Estranho não é um Vingador', 'benedict-cumberbatch-explica-que-doutor-estranho-nao-e-um-vingador', 'benedict-cumberbatch-explica-que-doutor-estranho-nao-e-um-vingador-jovemnerdsite', '/uploads/news/20220428111753_benedict-cumberbatch-explica-que-doutor-estranho-nao-e-um-vingador-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/benedict-cumberbatch-explica-que-doutor-estranho-nao-e-um-vingador/', NULL, NULL, 0, '2022-03-17', '2022-04-28 23:17:53', '2022-04-28 23:17:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(38, 29, 'Ir para: Avatar 2 ganha nome oficial e terá trailer durante Doutor Estranho 2', 'ir-para-avatar-2-ganha-nome-oficial-e-tera-trailer-durante-doutor-estranho-2', 'ir-para-avatar-2-ganha-nome-oficial-e-tera-trailer-durante-doutor-estranho-2-tecmundosite', '/uploads/news/20220428111756_ir-para-avatar-2-ganha-nome-oficial-e-tera-trailer-durante-doutor-estranho-2-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/237743-avatar-2-ganha-nome-oficial-tera-trailer-durante-doutor-estranho-2.htm', NULL, NULL, 0, '2022-04-27', '2022-04-28 23:17:56', '2022-04-28 23:17:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(39, 29, 'Ir para: Doutor Estranho 2: vídeo inédito revela presença dos Illuminati; veja!', 'ir-para-doutor-estranho-2-video-inedito-revela-presenca-dos-illuminati-veja', 'ir-para-doutor-estranho-2-video-inedito-revela-presenca-dos-illuminati-veja-tecmundosite', '/uploads/news/20220428111756_ir-para-doutor-estranho-2-video-inedito-revela-presenca-dos-illuminati-veja-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/237641-doutor-estranho-2-video-inedito-illuminati.htm', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:17:56', '2022-04-28 23:17:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(40, 29, 'Ir para: Doutor Estranho 2: filme é banido na Arábia Saudita por personagem LGBT', 'ir-para-doutor-estranho-2-filme-e-banido-na-arabia-saudita-por-personagem-lgbt', 'ir-para-doutor-estranho-2-filme-e-banido-na-arabia-saudita-por-personagem-lgbt-tecmundosite', '/uploads/news/20220428111756_ir-para-doutor-estranho-2-filme-e-banido-na-arabia-saudita-por-personagem-lgbt-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/237492-doutor-estranho-2-filme-banido-arabia-saudita-personagem-lgbt.htm', NULL, NULL, 0, '2022-04-22', '2022-04-28 23:17:57', '2022-04-28 23:17:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(41, 29, 'Ir para: Doutor Estranho 2: filme deve ter mais surpresas que Vingadores: Ultimato', 'ir-para-doutor-estranho-2-filme-deve-ter-mais-surpresas-que-vingadores-ultimato', 'ir-para-doutor-estranho-2-filme-deve-ter-mais-surpresas-que-vingadores-ultimato-tecmundosite', '/uploads/news/20220428111757_ir-para-doutor-estranho-2-filme-deve-ter-mais-surpresas-que-vingadores-ultimato-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/237108-doutor-estranho-2-filme-surpresas-vingadores-ultimato.htm', NULL, NULL, 0, '2022-04-14', '2022-04-28 23:17:57', '2022-04-28 23:17:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(42, 29, 'Ir para: Doutor Estranho 2: Wanda toca o terror em teaser com cenas inéditas; veja!', 'ir-para-doutor-estranho-2-wanda-toca-o-terror-em-teaser-com-cenas-ineditas-veja', 'ir-para-doutor-estranho-2-wanda-toca-o-terror-em-teaser-com-cenas-ineditas-veja-tecmundosite', '/uploads/news/20220428111757_ir-para-doutor-estranho-2-wanda-toca-o-terror-em-teaser-com-cenas-ineditas-veja-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/237041-doutor-estranho-2-wanda-toca-terror-teaser-cenas-ineditas.htm', NULL, NULL, 0, '2022-04-13', '2022-04-28 23:17:58', '2022-04-28 23:17:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(43, 29, 'Ir para: Doutor Estranho 2: novos cartazes mostram personagens do MCU; veja!', 'ir-para-doutor-estranho-2-novos-cartazes-mostram-personagens-do-mcu-veja', 'ir-para-doutor-estranho-2-novos-cartazes-mostram-personagens-do-mcu-veja-tecmundosite', '/uploads/news/20220428111758_ir-para-doutor-estranho-2-novos-cartazes-mostram-personagens-do-mcu-veja-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/236944-doutor-estranho-2-novos-cartazes-personagens-mcu.htm', NULL, NULL, 0, '2022-04-12', '2022-04-28 23:17:59', '2022-04-28 23:17:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(44, 29, 'Ir para: Doutor Estranho 2: tapa de Will Smith vira cena de filme da Marvel', 'ir-para-doutor-estranho-2-tapa-de-will-smith-vira-cena-de-filme-da-marvel', 'ir-para-doutor-estranho-2-tapa-de-will-smith-vira-cena-de-filme-da-marvel-tecmundosite', '/uploads/news/20220428111759_ir-para-doutor-estranho-2-tapa-de-will-smith-vira-cena-de-filme-da-marvel-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/236881-doutor-estranho-2-tapa-will-smith-cena-filme-marvel.htm', NULL, NULL, 0, '2022-04-11', '2022-04-28 23:17:59', '2022-04-28 23:17:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(45, 29, 'Ir para: Doutor Estranho 2: Wanda é mais poderosa do que o mago? Entenda!', 'ir-para-doutor-estranho-2-wanda-e-mais-poderosa-do-que-o-mago-entenda', 'ir-para-doutor-estranho-2-wanda-e-mais-poderosa-do-que-o-mago-entenda-tecmundosite', '/uploads/news/20220428111759_ir-para-doutor-estranho-2-wanda-e-mais-poderosa-do-que-o-mago-entenda-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/236787-doutor-estranho-2-wanda-mais-poderosa-mago.htm', NULL, NULL, 0, '2022-04-08', '2022-04-28 23:18:00', '2022-04-28 23:18:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(46, 29, 'Ir para: Doutor Estranho 2: Wanda e seus filhos retornam em novo vídeo; veja!', 'ir-para-doutor-estranho-2-wanda-e-seus-filhos-retornam-em-novo-video-veja', 'ir-para-doutor-estranho-2-wanda-e-seus-filhos-retornam-em-novo-video-veja-tecmundosite', '/uploads/news/20220428111800_ir-para-doutor-estranho-2-wanda-e-seus-filhos-retornam-em-novo-video-veja-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/236672-doutor-estranho-2-wanda-filhos-novo-video.htm', NULL, NULL, 0, '2022-04-06', '2022-04-28 23:18:00', '2022-04-28 23:18:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(47, 29, 'Ir para: Doutor Estranho 2: pré-venda de ingressos começa hoje (6)', 'ir-para-doutor-estranho-2-pre-venda-de-ingressos-comeca-hoje-6', 'ir-para-doutor-estranho-2-pre-venda-de-ingressos-comeca-hoje-6-tecmundosite', '/uploads/news/20220428111800_ir-para-doutor-estranho-2-pre-venda-de-ingressos-comeca-hoje-6-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/236653-doutor-estranho-2-pre-venda-ingressos-comeca-6.htm', NULL, NULL, 0, '2022-04-06', '2022-04-28 23:18:01', '2022-04-28 23:18:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(48, 30, 'Doutor Estranho no Multiverso da Loucura é banido em vários países', 'doutor-estranho-no-multiverso-da-loucura-e-banido-em-varios-paises', 'doutor-estranho-no-multiverso-da-loucura-e-banido-em-varios-paises-poltronanerdsite', '/uploads/news/20220428111804_doutor-estranho-no-multiverso-da-loucura-e-banido-em-varios-paises-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/doutor-estranho-no-multiverso-da-loucura-e-banido-em-varios-paises-133742', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:18:05', '2022-04-28 23:18:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(49, 30, 'Doutor Estranho no Multiverso da Loucura | Pré-venda bate recorde de vendas', 'doutor-estranho-no-multiverso-da-loucura-pre-venda-bate-recorde-de-vendas', 'doutor-estranho-no-multiverso-da-loucura-pre-venda-bate-recorde-de-vendas-poltronanerdsite', '/uploads/news/20220428111805_doutor-estranho-no-multiverso-da-loucura-pre-venda-bate-recorde-de-vendas-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/doutor-estranho-no-multiverso-da-loucura-pre-venda-bate-recorde-de-vendas-133223', NULL, NULL, 0, '2022-04-08', '2022-04-28 23:18:05', '2022-04-28 23:18:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(50, 30, 'Trailers que foram ao ar durante o Super Bowl: Cavaleiro da Lua, Doutor Estranho e mais!', 'trailers-que-foram-ao-ar-durante-o-super-bowl-cavaleiro-da-lua-doutor-estranho-e-mais', 'trailers-que-foram-ao-ar-durante-o-super-bowl-cavaleiro-da-lua-doutor-estranho-e-mais-poltronanerdsite', '/uploads/news/20220428111805_trailers-que-foram-ao-ar-durante-o-super-bowl-cavaleiro-da-lua-doutor-estranho-e-mais-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/trailers-que-foram-ao-ar-durante-o-super-bowl-cavaleiro-da-lua-doutor-estranho-e-mais-131680', NULL, NULL, 0, '2022-02-15', '2022-04-28 23:18:06', '2022-04-28 23:18:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(51, 30, 'Doutor Estranho I Refilmagens da sequência são finalizadas', 'doutor-estranho-i-refilmagens-da-sequencia-sao-finalizadas', 'doutor-estranho-i-refilmagens-da-sequencia-sao-finalizadas-poltronanerdsite', '/uploads/news/20220428111806_doutor-estranho-i-refilmagens-da-sequencia-sao-finalizadas-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/doutor-estranho-i-refilmagens-da-sequencia-sao-finalizadas-130641', NULL, NULL, 0, '2022-01-13', '2022-04-28 23:18:06', '2022-04-28 23:18:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(52, 30, 'Doutor Estranho | Quebra-cabeça pode ter revelado vilão do filme', 'doutor-estranho-quebra-cabeca-pode-ter-revelado-vilao-do-filme', 'doutor-estranho-quebra-cabeca-pode-ter-revelado-vilao-do-filme-poltronanerdsite', '/uploads/news/20220428111806_doutor-estranho-quebra-cabeca-pode-ter-revelado-vilao-do-filme-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/doutor-estranho-quebra-cabeca-pode-ter-revelado-vilao-do-filme-128290', NULL, NULL, 0, '2021-11-01', '2022-04-28 23:18:07', '2022-04-28 23:18:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(53, 30, 'Marvel Studios adia os lançamentos de Doutor Estranho 2 e mais filmes', 'marvel-studios-adia-os-lancamentos-de-doutor-estranho-2-e-mais-filmes', 'marvel-studios-adia-os-lancamentos-de-doutor-estranho-2-e-mais-filmes-poltronanerdsite', '/uploads/news/20220428111807_marvel-studios-adia-os-lancamentos-de-doutor-estranho-2-e-mais-filmes-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/marvel-studios-adia-os-lancamentos-de-doutor-estranho-2-e-mais-filmes-127747', NULL, NULL, 0, '2021-10-18', '2022-04-28 23:18:07', '2022-04-28 23:18:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(54, 30, 'James McAvoy pode retornar como Xavier em Doutor Estranho 2', 'james-mcavoy-pode-retornar-como-xavier-em-doutor-estranho-2', 'james-mcavoy-pode-retornar-como-xavier-em-doutor-estranho-2-poltronanerdsite', '/uploads/news/20220428111807_james-mcavoy-pode-retornar-como-xavier-em-doutor-estranho-2-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/james-mcavoy-pode-retornar-como-xavier-em-doutor-estranho-2-125276', NULL, NULL, 0, '2021-08-30', '2022-04-28 23:18:08', '2022-04-28 23:18:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(55, 30, 'Doutor Estranho enfrentará o Darkseid em Liga da Justiça', 'doutor-estranho-enfrentara-o-darkseid-em-liga-da-justica', 'doutor-estranho-enfrentara-o-darkseid-em-liga-da-justica-poltronanerdsite', '/uploads/news/20220428111808_doutor-estranho-enfrentara-o-darkseid-em-liga-da-justica-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/doutor-estranho-tera-versao-ajudando-a-liga-da-justica-125116', NULL, NULL, 0, '2021-08-26', '2022-04-28 23:18:09', '2022-04-28 23:18:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(56, 30, 'Doutor Estranho | Roteirista comenta diferença para Loki', 'doutor-estranho-roteirista-comenta-diferenca-para-loki', 'doutor-estranho-roteirista-comenta-diferenca-para-loki-poltronanerdsite', '/uploads/news/20220428111809_doutor-estranho-roteirista-comenta-diferenca-para-loki-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/doutor-estranho-roteirista-comenta-diferenca-para-loki-123506', NULL, NULL, 0, '2021-07-28', '2022-04-28 23:18:09', '2022-04-28 23:18:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(57, 30, 'Doutor Estranho pode ganhar série animada de terror', 'doutor-estranho-pode-ganhar-serie-animada-de-terror', 'doutor-estranho-pode-ganhar-serie-animada-de-terror-poltronanerdsite', '/uploads/news/20220428111809_doutor-estranho-pode-ganhar-serie-animada-de-terror-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/doutor-estranho-pode-ganhar-serie-animada-de-terror-123176', NULL, NULL, 0, '2021-07-23', '2022-04-28 23:18:10', '2022-04-28 23:18:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(58, 30, 'Tom Hiddleston foi confirmado em Doutor Estranho 2?', 'tom-hiddleston-foi-confirmado-em-doutor-estranho-2', 'tom-hiddleston-foi-confirmado-em-doutor-estranho-2-poltronanerdsite', '/uploads/news/20220428111810_tom-hiddleston-foi-confirmado-em-doutor-estranho-2-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/tom-hiddleston-foi-confirmado-em-doutor-estranho-2-122647', NULL, NULL, 0, '2021-07-14', '2022-04-28 23:18:10', '2022-04-28 23:18:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(59, 30, 'Marvel estaria desenvolvendo spin-off de Doutor Estranho', 'marvel-estaria-desenvolvendo-spin-off-de-doutor-estranho', 'marvel-estaria-desenvolvendo-spin-off-de-doutor-estranho-poltronanerdsite', '/uploads/news/20220428111810_marvel-estaria-desenvolvendo-spin-off-de-doutor-estranho-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/marvel-estaria-desenvolvendo-spin-off-de-doutor-estranho-121667', NULL, NULL, 0, '2021-07-05', '2022-04-28 23:18:11', '2022-04-28 23:18:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(60, 8, 'DOUTOR ESTRANHO é bom? - Vale Crítica', 'doutor-estranho-e-bom-vale-critica', 'doutor-estranho-e-bom-vale-critica-superoitoyoutube', '/uploads/news/20220428111817_doutor-estranho-e-bom-vale-critica-superoitoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=k7bziIfSqeA', NULL, NULL, 0, '2016-10-30', '2022-04-28 23:18:18', '2022-04-28 23:18:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(61, 8, 'DOUTOR ESTRANHO - 8 Segredos e Curiosidades', 'doutor-estranho-8-segredos-e-curiosidades', 'doutor-estranho-8-segredos-e-curiosidades-superoitoyoutube', '/uploads/news/20220428111822_doutor-estranho-8-segredos-e-curiosidades-superoitoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=DtlwoBUkibw', NULL, NULL, 0, '2016-09-02', '2022-04-28 23:18:22', '2022-04-28 23:18:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(62, 2, 'Doutor Estranho no Multiverso da Loucura - X-Men 99% confirmado! Trailer Oficial', 'doutor-estranho-no-multiverso-da-loucura-x-men-99-confirmado-trailer-oficial', 'doutor-estranho-no-multiverso-da-loucura-x-men-99-confirmado-trailer-oficial-jovemnerdyoutube', '/uploads/news/20220428111826_doutor-estranho-no-multiverso-da-loucura-x-men-99-confirmado-trailer-oficial-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wgooeqMjFv8', NULL, NULL, 0, '2022-02-23', '2022-04-28 23:18:27', '2022-04-28 23:18:27');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(63, 4, 'DOUTOR ESTRANHO 2 E THE FLASH SÃO O MESMO FILME? | OTV', 'doutor-estranho-2-e-the-flash-sao-o-mesmo-filme-otv', 'doutor-estranho-2-e-the-flash-sao-o-mesmo-filme-otv-omeleteyoutube', '/uploads/news/20220428111832_doutor-estranho-2-e-the-flash-sao-o-mesmo-filme-otv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=B405G_n4Brc', NULL, NULL, 0, '2022-01-19', '2022-04-28 23:18:32', '2022-04-28 23:18:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(64, 4, 'Doutor Estranho - O Veredito | OmeleTV', 'doutor-estranho-o-veredito-omeletv', 'doutor-estranho-o-veredito-omeletv-omeleteyoutube', '/uploads/news/20220428111835_doutor-estranho-o-veredito-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=0HKRwwlgsbo', NULL, NULL, 0, '2016-11-03', '2022-04-28 23:18:35', '2022-04-28 23:18:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(65, 4, '(PIRAMOS!) X-MEN CHEGAM AO MCU E O TRAILER DE DOUTOR ESTRANHO 2 | OTV LIVE', 'piramos-x-men-chegam-ao-mcu-e-o-trailer-de-doutor-estranho-2-otv-live', 'piramos-x-men-chegam-ao-mcu-e-o-trailer-de-doutor-estranho-2-otv-live-omeleteyoutube', '/uploads/news/20220428111837_piramos-x-men-chegam-ao-mcu-e-o-trailer-de-doutor-estranho-2-otv-live-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=BNmCK3xCOnM', NULL, NULL, 0, '2022-02-14', '2022-04-28 23:18:38', '2022-04-28 23:18:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(66, 4, 'A MARVEL MÍSTICA: DOUTOR ESTRANHO | Marvel 10 Anos 14', 'a-marvel-mistica-doutor-estranho-marvel-10-anos-14', 'a-marvel-mistica-doutor-estranho-marvel-10-anos-14-omeleteyoutube', '/uploads/news/20220428111842_a-marvel-mistica-doutor-estranho-marvel-10-anos-14-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=uoXj5_SR8c0', NULL, NULL, 0, '2018-04-06', '2022-04-28 23:18:43', '2022-04-28 23:18:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(67, 4, 'Doutor Estranho - Trailer Comentado', 'doutor-estranho-trailer-comentado', 'doutor-estranho-trailer-comentado-omeleteyoutube', '/uploads/news/20220428111845_doutor-estranho-trailer-comentado-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=P_JeUAhdY70', NULL, NULL, 0, '2016-04-13', '2022-04-28 23:18:45', '2022-04-28 23:18:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(68, 4, 'Vimos 15 minutos de Doutor Estranho E PIRAMOS! | OmeleTV', 'vimos-15-minutos-de-doutor-estranho-e-piramos-omeletv', 'vimos-15-minutos-de-doutor-estranho-e-piramos-omeletv-omeleteyoutube', '/uploads/news/20220428111848_vimos-15-minutos-de-doutor-estranho-e-piramos-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=9uDqjGDkkeE', NULL, NULL, 0, '2016-10-12', '2022-04-28 23:18:49', '2022-04-28 23:18:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(69, 4, 'MULTIVERSO E TERROR NA MARVEL! DOUTOR ESTRANHO 2 VEM AÍ', 'multiverso-e-terror-na-marvel-doutor-estranho-2-vem-ai', 'multiverso-e-terror-na-marvel-doutor-estranho-2-vem-ai-omeleteyoutube', '/uploads/news/20220428111851_multiverso-e-terror-na-marvel-doutor-estranho-2-vem-ai-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=YPk_xtav1aA', NULL, NULL, 0, '2019-07-25', '2022-04-28 23:18:51', '2022-04-28 23:18:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(70, 4, 'DOUTOR ESTRANHO COM ARMADURA HOMEM DE FERRO! A IDEIA DELETADA FiqueEmCasa Comigo', 'doutor-estranho-com-armadura-homem-de-ferro-a-ideia-deletada-fiqueemcasa-comigo', 'doutor-estranho-com-armadura-homem-de-ferro-a-ideia-deletada-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428111853_doutor-estranho-com-armadura-homem-de-ferro-a-ideia-deletada-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=x4QaO-TdKgE', NULL, NULL, 0, '2020-04-27', '2022-04-28 23:18:54', '2022-04-28 23:18:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(71, 4, 'VINGADOR SOBREVIVENTE? DOUTOR ESTRANHO 2 CONFIRMADO', 'vingador-sobrevivente-doutor-estranho-2-confirmado', 'vingador-sobrevivente-doutor-estranho-2-confirmado-omeleteyoutube', '/uploads/news/20220428111858_vingador-sobrevivente-doutor-estranho-2-confirmado-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=gEvS60N_nYI', NULL, NULL, 0, '2018-12-13', '2022-04-28 23:18:58', '2022-04-28 23:18:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(72, 4, 'Doutor Estranho: TUDO sobre o novo herói da Marvel nos cinemas | OmeleTV', 'doutor-estranho-tudo-sobre-o-novo-heroi-da-marvel-nos-cinemas-omeletv', 'doutor-estranho-tudo-sobre-o-novo-heroi-da-marvel-nos-cinemas-omeletv-omeleteyoutube', '/uploads/news/20220428111901_doutor-estranho-tudo-sobre-o-novo-heroi-da-marvel-nos-cinemas-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ucBfn8jA4iU', NULL, NULL, 0, '2016-09-14', '2022-04-28 23:19:02', '2022-04-28 23:19:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(73, 4, 'Doutor Estranho e o segredo das Joias do Infinito | OmeleTV', 'doutor-estranho-e-o-segredo-das-joias-do-infinito-omeletv', 'doutor-estranho-e-o-segredo-das-joias-do-infinito-omeletv-omeleteyoutube', '/uploads/news/20220428111906_doutor-estranho-e-o-segredo-das-joias-do-infinito-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QZNIYQ0RLDQ', NULL, NULL, 0, '2016-10-21', '2022-04-28 23:19:07', '2022-04-28 23:19:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(74, 4, 'Doutor Estranho - 5 perguntas COM spoilers | OmeleTV', 'doutor-estranho-5-perguntas-com-spoilers-omeletv', 'doutor-estranho-5-perguntas-com-spoilers-omeletv-omeleteyoutube', '/uploads/news/20220428111910_doutor-estranho-5-perguntas-com-spoilers-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=VH2ERSss6IM', NULL, NULL, 0, '2016-10-27', '2022-04-28 23:19:10', '2022-04-28 23:19:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(75, 4, 'MELHOR FILME DA MARVEL! DOUTOR ESTRANHO 2 VAI MUDAR TUDO', 'melhor-filme-da-marvel-doutor-estranho-2-vai-mudar-tudo', 'melhor-filme-da-marvel-doutor-estranho-2-vai-mudar-tudo-omeleteyoutube', '/uploads/news/20220428111915_melhor-filme-da-marvel-doutor-estranho-2-vai-mudar-tudo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=IDmkTXGStsw', NULL, NULL, 0, '2020-02-25', '2022-04-28 23:19:15', '2022-04-28 23:19:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(76, 4, 'O FIM DO DOUTOR ESTRANHO?!', 'o-fim-do-doutor-estranho', 'o-fim-do-doutor-estranho-omeleteyoutube', '/uploads/news/20220428111918_o-fim-do-doutor-estranho-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=oHUaBvUquRE', NULL, NULL, 0, '2018-04-16', '2022-04-28 23:19:19', '2022-04-28 23:19:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(77, 4, 'EXPLICANDO O PLANO DE DOUTOR ESTRANHO', 'explicando-o-plano-de-doutor-estranho', 'explicando-o-plano-de-doutor-estranho-omeleteyoutube', '/uploads/news/20220428111922_explicando-o-plano-de-doutor-estranho-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=llG1q3hIOvo', NULL, NULL, 0, '2018-05-02', '2022-04-28 23:19:23', '2022-04-28 23:19:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(78, 4, 'DOUTOR ESTRANHO 2: O MISTÉRIO DO TEMPO NA MARVEL | HYPERDRIVE SAC 2', 'doutor-estranho-2-o-misterio-do-tempo-na-marvel-hyperdrive-sac-2', 'doutor-estranho-2-o-misterio-do-tempo-na-marvel-hyperdrive-sac-2-omeleteyoutube', '/uploads/news/20220428111926_doutor-estranho-2-o-misterio-do-tempo-na-marvel-hyperdrive-sac-2-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=KNoAVdAKE1Y', NULL, NULL, 0, '2018-06-29', '2022-04-28 23:19:26', '2022-04-28 23:19:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(79, 4, 'DOUTOR ESTRANHO, PIETRO, WANDAVISION: ERRAMOS TODAS AS TEORIAS? FicaEmCasa Comigo', 'doutor-estranho-pietro-wandavision-erramos-todas-as-teorias-ficaemcasa-comigo', 'doutor-estranho-pietro-wandavision-erramos-todas-as-teorias-ficaemcasa-comigo-omeleteyoutube', '/uploads/news/20220428111929_doutor-estranho-pietro-wandavision-erramos-todas-as-teorias-ficaemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Iyu0T0LcPDU', NULL, NULL, 0, '2021-03-08', '2022-04-28 23:19:30', '2022-04-28 23:19:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(80, 4, 'COMEÇOU O MULTIVERSO! LOKI E DOUTOR ESTRANHO JUNTOS', 'comecou-o-multiverso-loki-e-doutor-estranho-juntos', 'comecou-o-multiverso-loki-e-doutor-estranho-juntos-omeleteyoutube', '/uploads/news/20220428111934_comecou-o-multiverso-loki-e-doutor-estranho-juntos-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=MA-xlhAD3JY', NULL, NULL, 0, '2019-11-08', '2022-04-28 23:19:34', '2022-04-28 23:19:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(81, 7, 'DOUTOR ESTRANHO É O MELHOR FILME DA MARVEL? - Crítica', 'doutor-estranho-e-o-melhor-filme-da-marvel-critica', 'doutor-estranho-e-o-melhor-filme-da-marvel-critica-pipocandoyoutube', '/uploads/news/20220428111938_doutor-estranho-e-o-melhor-filme-da-marvel-critica-pipocandoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=sz5HXsdEy8A', NULL, NULL, 0, '2016-10-30', '2022-04-28 23:19:39', '2022-04-28 23:19:39');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(82, 5, '37 PERSONAGENS QUE VÃO OU QUE PODEM APARECER EM DOUTOR ESTRANHO 2', '37-personagens-que-vao-ou-que-podem-aparecer-em-doutor-estranho-2', '37-personagens-que-vao-ou-que-podem-aparecer-em-doutor-estranho-2-einerdyoutube', '/uploads/news/20220428111945_37-personagens-que-vao-ou-que-podem-aparecer-em-doutor-estranho-2-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=SZI25Z5M_6U', NULL, NULL, 0, '2022-04-27', '2022-04-28 23:19:46', '2022-04-28 23:19:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(83, 5, 'BOMBA! TRIBUNAL VIVO EM DOUTOR ESTRANHO 2? NÃO É RUMOR!', 'bomba-tribunal-vivo-em-doutor-estranho-2-nao-e-rumor', 'bomba-tribunal-vivo-em-doutor-estranho-2-nao-e-rumor-einerdyoutube', '/uploads/news/20220428111949_bomba-tribunal-vivo-em-doutor-estranho-2-nao-e-rumor-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=7x2DQJyjbr0', NULL, NULL, 0, '2022-04-27', '2022-04-28 23:19:49', '2022-04-28 23:19:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(84, 5, 'POR QUE O DOUTOR ESTRANHO NÃO FEZ THANOS ESQUECER AS JOIAS DO INFINITO?', 'por-que-o-doutor-estranho-nao-fez-thanos-esquecer-as-joias-do-infinito', 'por-que-o-doutor-estranho-nao-fez-thanos-esquecer-as-joias-do-infinito-einerdyoutube', '/uploads/news/20220428111954_por-que-o-doutor-estranho-nao-fez-thanos-esquecer-as-joias-do-infinito-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QuNWAZzPHF0', NULL, NULL, 0, '2022-04-24', '2022-04-28 23:19:54', '2022-04-28 23:19:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(85, 5, 'DOUTOR ESTRANHO E FEITICEIRA ESCARLATE DO UCM - QUEM VENCERIA?', 'doutor-estranho-e-feiticeira-escarlate-do-ucm-quem-venceria', 'doutor-estranho-e-feiticeira-escarlate-do-ucm-quem-venceria-einerdyoutube', '/uploads/news/20220428111958_doutor-estranho-e-feiticeira-escarlate-do-ucm-quem-venceria-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=GNBkpYtG0y8', NULL, NULL, 0, '2021-03-07', '2022-04-28 23:19:59', '2022-04-28 23:19:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(86, 5, 'COMO O HOMEM-ARANHA DERROTOU O DOUTOR ESTRANHO? [Doutor Estranho é muito superior!]', 'como-o-homem-aranha-derrotou-o-doutor-estranho-doutor-estranho-e-muito-superior', 'como-o-homem-aranha-derrotou-o-doutor-estranho-doutor-estranho-e-muito-superior-einerdyoutube', '/uploads/news/20220428112002_como-o-homem-aranha-derrotou-o-doutor-estranho-doutor-estranho-e-muito-superior-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=mFUUCLBAsno', NULL, NULL, 0, '2022-01-09', '2022-04-28 23:20:02', '2022-04-28 23:20:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(87, 3, 'Duna, WandaVision, Arcane, Loki e mais são indicados ao Hugo Awards; veja lista', 'duna-wandavision-arcane-loki-e-mais-sao-indicados-ao-hugo-awards-veja-lista', 'duna-wandavision-arcane-loki-e-mais-sao-indicados-ao-hugo-awards-veja-lista-omeletesite', '/uploads/news/20220428112447_duna-wandavision-arcane-loki-e-mais-sao-indicados-ao-hugo-awards-veja-lista-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/hugo-2022-indicados', NULL, NULL, 0, '2022-04-08', '2022-04-28 23:24:47', '2022-04-28 23:24:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(88, 3, 'Vídeo explora efeitos especiais de cena emocionante de WandaVision; veja', 'video-explora-efeitos-especiais-de-cena-emocionante-de-wandavision-veja', 'video-explora-efeitos-especiais-de-cena-emocionante-de-wandavision-veja-omeletesite', '/uploads/news/20220428112447_video-explora-efeitos-especiais-de-cena-emocionante-de-wandavision-veja-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/wandavision-video-efeitos', NULL, NULL, 0, '2022-01-22', '2022-04-28 23:24:47', '2022-04-28 23:24:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(89, 3, 'WandaVision: ator de Billy revela fotos do set no aniversário de um ano da série', 'wandavision-ator-de-billy-revela-fotos-do-set-no-aniversario-de-um-ano-da-serie', 'wandavision-ator-de-billy-revela-fotos-do-set-no-aniversario-de-um-ano-da-serie-omeletesite', '/uploads/news/20220428112447_wandavision-ator-de-billy-revela-fotos-do-set-no-aniversario-de-um-ano-da-serie-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/marvel-cinema/wandavision-aniversario-um-ano', NULL, NULL, 0, '2022-01-16', '2022-04-28 23:24:47', '2022-04-28 23:24:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(90, 3, 'Succession, WandaVision e mais: As melhores performances de 2021', 'succession-wandavision-e-mais-as-melhores-performances-de-2021', 'succession-wandavision-e-mais-as-melhores-performances-de-2021-omeletesite', '/uploads/news/20220428112448_succession-wandavision-e-mais-as-melhores-performances-de-2021-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/melhores-performances-2021', NULL, NULL, 0, '2021-12-27', '2022-04-28 23:24:48', '2022-04-28 23:24:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(91, 1, 'Artes mostram visuais alternativos de Agatha Harkness em WandaVision', 'artes-mostram-visuais-alternativos-de-agatha-harkness-em-wandavision', 'artes-mostram-visuais-alternativos-de-agatha-harkness-em-wandavision-jovemnerdsite', '/uploads/news/20220428112451_artes-mostram-visuais-alternativos-de-agatha-harkness-em-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-visuais-alternativos-agatha-harkness/', NULL, NULL, 0, '2022-03-07', '2022-04-28 23:24:52', '2022-04-28 23:24:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(92, 1, 'Industrial Light &038; Magic revela bastidores dos efeitos visuais de WandaVision', 'industrial-light-038-magic-revela-bastidores-dos-efeitos-visuais-de-wandavision', 'industrial-light-038-magic-revela-bastidores-dos-efeitos-visuais-de-wandavision-jovemnerdsite', '/uploads/news/20220428112452_industrial-light-038-magic-revela-bastidores-dos-efeitos-visuais-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-video-efeitos-visuais-marvel/', NULL, NULL, 0, '2022-01-22', '2022-04-28 23:24:53', '2022-04-28 23:24:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(93, 1, 'Ator mirim de WandaVision comemora 1 ano da série com foto de bastidores', 'ator-mirim-de-wandavision-comemora-1-ano-da-serie-com-foto-de-bastidores', 'ator-mirim-de-wandavision-comemora-1-ano-da-serie-com-foto-de-bastidores-jovemnerdsite', '/uploads/news/20220428112453_ator-mirim-de-wandavision-comemora-1-ano-da-serie-com-foto-de-bastidores-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/ator-mirim-de-wandavision-comemora-1-ano-da-serie-com-foto-de-bastidores/', NULL, NULL, 0, '2022-01-17', '2022-04-28 23:24:54', '2022-04-28 23:24:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(94, 1, 'WandaVision e Loki foram as séries mais pirateadas de 2021', 'wandavision-e-loki-foram-as-series-mais-pirateadas-de-2021', 'wandavision-e-loki-foram-as-series-mais-pirateadas-de-2021-jovemnerdsite', '/uploads/news/20220428112454_wandavision-e-loki-foram-as-series-mais-pirateadas-de-2021-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-e-loki-foram-as-series-mais-pirateadas-de-2021/', NULL, NULL, 0, '2021-12-29', '2022-04-28 23:24:55', '2022-04-28 23:24:55');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(95, 1, 'Música de WandaVision, &8220;Agatha All Along&8221; é indicada ao Grammy Awards', 'musica-de-wandavision-8220agatha-all-along8221-e-indicada-ao-grammy-awards', 'musica-de-wandavision-8220agatha-all-along8221-e-indicada-ao-grammy-awards-jovemnerdsite', '/uploads/news/20220428112455_musica-de-wandavision-8220agatha-all-along8221-e-indicada-ao-grammy-awards-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-agatha-all-along-indicacao-grammy/', NULL, NULL, 0, '2021-11-23', '2022-04-28 23:24:56', '2022-04-28 23:24:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(96, 1, 'Marvel anuncia derivado de WandaVision e novas séries; veja todas', 'marvel-anuncia-derivado-de-wandavision-e-novas-series-veja-todas', 'marvel-anuncia-derivado-de-wandavision-e-novas-series-veja-todas-jovemnerdsite', '/uploads/news/20220428112456_marvel-anuncia-derivado-de-wandavision-e-novas-series-veja-todas-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/marvel-anuncia-derivado-de-wandavision-novas-series-disney-plus-day/', NULL, NULL, 0, '2021-11-12', '2022-04-28 23:24:57', '2022-04-28 23:24:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(97, 1, 'Kathryn Hahn nega rumores sobre derivado de WandaVision', 'kathryn-hahn-nega-rumores-sobre-derivado-de-wandavision', 'kathryn-hahn-nega-rumores-sobre-derivado-de-wandavision-jovemnerdsite', '/uploads/news/20220428112457_kathryn-hahn-nega-rumores-sobre-derivado-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-kathryn-hahn-nega-rumores-derivado-agatha-harkness/', NULL, NULL, 0, '2021-10-29', '2022-04-28 23:24:58', '2022-04-28 23:24:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(98, 1, 'Disney Plus está desenvolvendo série derivada de WandaVision com Kathryn Hahn, diz site', 'disney-plus-esta-desenvolvendo-serie-derivada-de-wandavision-com-kathryn-hahn-diz-site', 'disney-plus-esta-desenvolvendo-serie-derivada-de-wandavision-com-kathryn-hahn-diz-site-jovemnerdsite', '/uploads/news/20220428112458_disney-plus-esta-desenvolvendo-serie-derivada-de-wandavision-com-kathryn-hahn-diz-site-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-serie-derivada-agatha-harkness-kathryn-hahn/', NULL, NULL, 0, '2021-10-07', '2022-04-28 23:24:59', '2022-04-28 23:24:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(99, 1, 'Homem de Ferro ganha armadura bizarra em HQ sobre Darkhold, o livro sombrio de WandaVision', 'homem-de-ferro-ganha-armadura-bizarra-em-hq-sobre-darkhold-o-livro-sombrio-de-wandavision', 'homem-de-ferro-ganha-armadura-bizarra-em-hq-sobre-darkhold-o-livro-sombrio-de-wandavision-jovemnerdsite', '/uploads/news/20220428112459_homem-de-ferro-ganha-armadura-bizarra-em-hq-sobre-darkhold-o-livro-sombrio-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/homem-de-ferro-marvel-armadura-bizarra-hq-darkhold-livro-wandavision/', NULL, NULL, 0, '2021-10-04', '2022-04-28 23:25:01', '2022-04-28 23:25:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(100, 1, 'WandaVision se torna a primeira série da Marvel a vencer um Emmy', 'wandavision-se-torna-a-primeira-serie-da-marvel-a-vencer-um-emmy', 'wandavision-se-torna-a-primeira-serie-da-marvel-a-vencer-um-emmy-jovemnerdsite', '/uploads/news/20220428112501_wandavision-se-torna-a-primeira-serie-da-marvel-a-vencer-um-emmy-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-primeira-serie-marvel-vencedora-emmy/', NULL, NULL, 0, '2021-09-13', '2022-04-28 23:25:01', '2022-04-28 23:25:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(101, 1, 'Será que WandaVision previu a data do trailer de Homem-Aranha: Sem Volta Para Casa?', 'sera-que-wandavision-previu-a-data-do-trailer-de-homem-aranha-sem-volta-para-casa', 'sera-que-wandavision-previu-a-data-do-trailer-de-homem-aranha-sem-volta-para-casa-jovemnerdsite', '/uploads/news/20220428112502_sera-que-wandavision-previu-a-data-do-trailer-de-homem-aranha-sem-volta-para-casa-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-previu-data-trailer-homem-aranha-sem-volta-para-casa/', NULL, NULL, 0, '2021-08-24', '2022-04-28 23:25:02', '2022-04-28 23:25:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(102, 1, 'Paul Bettany revela diferentes faces do Visão em fotos dos bastidores de WandaVision', 'paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision', 'paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision-jovemnerdsite', '/uploads/news/20220428112502_paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/paul-bettany-revela-diferentes-faces-do-visao-em-fotos-dos-bastidores-de-wandavision/', NULL, NULL, 0, '2021-08-16', '2022-04-28 23:25:03', '2022-04-28 23:25:03');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(103, 1, 'Doutor Estranho 2 não faria sentido sem WandaVision, diz Elizabeth Olsen', 'doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen', 'doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen-jovemnerdsite', '/uploads/news/20220428112503_doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/doutor-estranho-2-nao-faria-sentido-sem-wandavision-diz-elizabeth-olsen/', NULL, NULL, 0, '2021-07-13', '2022-04-28 23:25:04', '2022-04-28 23:25:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(104, 1, 'Elizabeth Olsen, de Vingadores e WandaVision, fez um teste &8220;terrível&8221; para Game of Thrones', 'elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-8220terrivel8221-para-game-of-thrones', 'elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-8220terrivel8221-para-game-of-thrones-jovemnerdsite', '/uploads/news/20220428112504_elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-8220terrivel8221-para-game-of-thrones-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/elizabeth-olsen-de-vingadores-e-wandavision-fez-um-teste-terrivel-para-game-of-thrones/', NULL, NULL, 0, '2021-06-22', '2022-04-28 23:25:05', '2022-04-28 23:25:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(105, 1, 'Randall Park, de WandaVision, entra para o elenco de derivado de Big Mouth', 'randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth', 'randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth-jovemnerdsite', '/uploads/news/20220428112505_randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/randall-park-de-wandavision-entra-para-o-elenco-de-derivado-de-big-mouth/', NULL, NULL, 0, '2021-06-14', '2022-04-28 23:25:06', '2022-04-28 23:25:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(106, 1, 'WandaVision não terá segunda temporada, diz Elizabeth Olsen', 'wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen', 'wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen-jovemnerdsite', '/uploads/news/20220428112507_wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-nao-tera-segunda-temporada-diz-elizabeth-olsen/', NULL, NULL, 0, '2021-06-09', '2022-04-28 23:25:07', '2022-04-28 23:25:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(107, 1, 'Agatha seria bem diferente em WandaVision, revela roteirista', 'agatha-seria-bem-diferente-em-wandavision-revela-roteirista', 'agatha-seria-bem-diferente-em-wandavision-revela-roteirista-jovemnerdsite', '/uploads/news/20220428112507_agatha-seria-bem-diferente-em-wandavision-revela-roteirista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/agatha-seria-bem-diferente-em-wandavision-revela-roteirista/', NULL, NULL, 0, '2021-06-03', '2022-04-28 23:25:08', '2022-04-28 23:25:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(108, 1, 'Kat Dennings esperava ter participação menor em WandaVision', 'kat-dennings-esperava-ter-participacao-menor-em-wandavision', 'kat-dennings-esperava-ter-participacao-menor-em-wandavision-jovemnerdsite', '/uploads/news/20220428112508_kat-dennings-esperava-ter-participacao-menor-em-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/kat-dennings-esperava-participacao-menor-wandavision/', NULL, NULL, 0, '2021-05-24', '2022-04-28 23:25:09', '2022-04-28 23:25:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(109, 1, 'WandaVision teria a aparição de Doutor Estranho, revela Kevin Feige', 'wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige', 'wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige-jovemnerdsite', '/uploads/news/20220428112509_wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-teria-a-aparicao-de-doutor-estranho-revela-kevin-feige/', NULL, NULL, 0, '2021-05-03', '2022-04-28 23:25:10', '2022-04-28 23:25:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(110, 1, 'WandaVision faz crossover com diferentes séries em ilustrações', 'wandavision-faz-crossover-com-diferentes-series-em-ilustracoes', 'wandavision-faz-crossover-com-diferentes-series-em-ilustracoes-jovemnerdsite', '/uploads/news/20220428112510_wandavision-faz-crossover-com-diferentes-series-em-ilustracoes-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/wandavision-ganha-crossover-com-diferentes-series-em-ilustracoes/', NULL, NULL, 0, '2021-03-27', '2022-04-28 23:25:11', '2022-04-28 23:25:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(111, 1, 'Fã faz abertura de WandaVision inspirada em Friends', 'fa-faz-abertura-de-wandavision-inspirada-em-friends', 'fa-faz-abertura-de-wandavision-inspirada-em-friends-jovemnerdsite', '/uploads/news/20220428112511_fa-faz-abertura-de-wandavision-inspirada-em-friends-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/fa-faz-abertura-de-wandavision-inspirada-em-friends/', NULL, NULL, 0, '2021-03-25', '2022-04-28 23:25:12', '2022-04-28 23:25:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(112, 1, 'Confira a magia dos efeitos visuais de WandaVision', 'confira-a-magia-dos-efeitos-visuais-de-wandavision', 'confira-a-magia-dos-efeitos-visuais-de-wandavision-jovemnerdsite', '/uploads/news/20220428112512_confira-a-magia-dos-efeitos-visuais-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/veja-a-magia-dos-efeitos-visuais-de-wandavision/', NULL, NULL, 0, '2021-03-24', '2022-04-28 23:25:13', '2022-04-28 23:25:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(113, 1, 'Roteiro de WandaVision também deixou a atriz da Monica Rambeau confusa', 'roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa', 'roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa-jovemnerdsite', '/uploads/news/20220428112514_roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/roteiro-de-wandavision-tambem-deixou-a-atriz-da-monica-rambeau-confusa/', NULL, NULL, 0, '2021-03-18', '2022-04-28 23:25:14', '2022-04-28 23:25:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(114, 1, 'Falcão e o Soldado Invernal é completamente diferente de WandaVision, diz roteirista', 'falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista', 'falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista-jovemnerdsite', '/uploads/news/20220428112515_falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/falcao-e-o-soldado-invernal-e-completamente-diferente-de-wandavision-diz-roteirista/', NULL, NULL, 0, '2021-03-17', '2022-04-28 23:25:15', '2022-04-28 23:25:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(115, 1, 'Benedict Cumberbatch pede desculpas aos fãs de WandaVision', 'benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision', 'benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision-jovemnerdsite', '/uploads/news/20220428112515_benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/benedict-cumberbatch-pede-desculpas-aos-fas-de-wandavision/', NULL, NULL, 0, '2021-03-12', '2022-04-28 23:25:17', '2022-04-28 23:25:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(116, 1, 'Criadora de WandaVision nunca tinha ouvido falar do Mefisto', 'criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto', 'criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto-jovemnerdsite', '/uploads/news/20220428112517_criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/criadora-de-wandavision-nunca-tinha-ouvido-falar-do-mefisto/', NULL, NULL, 0, '2021-03-12', '2022-04-28 23:25:18', '2022-04-28 23:25:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(117, 1, 'WandaVision: Nostalgia, teorias e luto', 'wandavision-nostalgia-teorias-e-luto', 'wandavision-nostalgia-teorias-e-luto-jovemnerdsite', '/uploads/news/20220428112518_wandavision-nostalgia-teorias-e-luto-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdcast/wandavision-nostalgia-teorias-e-luto/', NULL, NULL, 0, '2021-03-12', '2022-04-28 23:25:19', '2022-04-28 23:25:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(118, 29, 'Ir para: WandaVision ganhará série spin-off focada na vilã Agatha Harkness', 'ir-para-wandavision-ganhara-serie-spin-off-focada-na-vila-agatha-harkness', 'ir-para-wandavision-ganhara-serie-spin-off-focada-na-vila-agatha-harkness-tecmundosite', '/uploads/news/20220428112522_ir-para-wandavision-ganhara-serie-spin-off-focada-na-vila-agatha-harkness-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/226490-wandavision-ganhara-spin-off-focado-vila-agatha-harkness.htm', NULL, NULL, 0, '2021-10-07', '2022-04-28 23:25:22', '2022-04-28 23:25:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(119, 29, 'Ir para: Emmy 2021: WandaVision é esnobada e fãs da Marvel reclamam; veja reações!', 'ir-para-emmy-2021-wandavision-e-esnobada-e-fas-da-marvel-reclamam-veja-reacoes', 'ir-para-emmy-2021-wandavision-e-esnobada-e-fas-da-marvel-reclamam-veja-reacoes-tecmundosite', '/uploads/news/20220428112522_ir-para-emmy-2021-wandavision-e-esnobada-e-fas-da-marvel-reclamam-veja-reacoes-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/225273-emmy-2021-wandavision-esnobada-fas-marvel-reclamam-veja-reacoes.htm', NULL, NULL, 0, '2021-09-20', '2022-04-28 23:25:23', '2022-04-28 23:25:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(120, 29, 'Ir para: WandaVision: roteiristas não entenderam trama da série da Marvel', 'ir-para-wandavision-roteiristas-nao-entenderam-trama-da-serie-da-marvel', 'ir-para-wandavision-roteiristas-nao-entenderam-trama-da-serie-da-marvel-tecmundosite', '/uploads/news/20220428112523_ir-para-wandavision-roteiristas-nao-entenderam-trama-da-serie-da-marvel-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/220561-wandavision-roteiristas-nao-entenderam-trama-serie-marvel.htm', NULL, NULL, 0, '2021-07-06', '2022-04-28 23:25:23', '2022-04-28 23:25:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(121, 29, 'Ir para: WandaVision: Kevin Feige fala sobre possível 2ª temporada', 'ir-para-wandavision-kevin-feige-fala-sobre-possivel-2a-temporada', 'ir-para-wandavision-kevin-feige-fala-sobre-possivel-2a-temporada-tecmundosite', '/uploads/news/20220428112523_ir-para-wandavision-kevin-feige-fala-sobre-possivel-2a-temporada-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/219437-wandavision-kevin-feige-fala-possivel-2-temporada.htm', NULL, NULL, 0, '2021-06-17', '2022-04-28 23:25:24', '2022-04-28 23:25:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(122, 29, 'Ir para: Entre Facas e Segredos 2: atriz de WandaVision é confirmada na sequência', 'ir-para-entre-facas-e-segredos-2-atriz-de-wandavision-e-confirmada-na-sequencia', 'ir-para-entre-facas-e-segredos-2-atriz-de-wandavision-e-confirmada-na-sequencia-tecmundosite', '/uploads/news/20220428112524_ir-para-entre-facas-e-segredos-2-atriz-de-wandavision-e-confirmada-na-sequencia-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/cultura-geek/217335-entre-facas-segredos-2-atriz-wandavision-confirmada-sequencia.htm', NULL, NULL, 0, '2021-05-14', '2022-04-28 23:25:24', '2022-04-28 23:25:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(123, 29, 'Ir para: MTV Movie &amp; TV Awards: WandaVision e Borat 2 lideram indicações', 'ir-para-mtv-movie-amp-tv-awards-wandavision-e-borat-2-lideram-indicacoes', 'ir-para-mtv-movie-amp-tv-awards-wandavision-e-borat-2-lideram-indicacoes-tecmundosite', '/uploads/news/20220428112524_ir-para-mtv-movie-amp-tv-awards-wandavision-e-borat-2-lideram-indicacoes-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/cultura-geek/215891-mtv-movie-tv-awards-wandavision-borat-2-lideram-indicacoes.htm', NULL, NULL, 0, '2021-04-20', '2022-04-28 23:25:25', '2022-04-28 23:25:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(124, 29, 'Ir para: Marvel lança documentário dos bastidores de WandaVision: trailer', 'ir-para-marvel-lanca-documentario-dos-bastidores-de-wandavision-trailer', 'ir-para-marvel-lanca-documentario-dos-bastidores-de-wandavision-trailer-tecmundosite', '/uploads/news/20220428112525_ir-para-marvel-lanca-documentario-dos-bastidores-de-wandavision-trailer-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/212704-marvel-lanca-documentario-bastidores-wandavision-trailer.htm', NULL, NULL, 0, '2021-03-12', '2022-04-28 23:25:26', '2022-04-28 23:25:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(125, 29, 'Ir para: WandaVision: diretor e roteirista falam dos momentos finais', 'ir-para-wandavision-diretor-e-roteirista-falam-dos-momentos-finais', 'ir-para-wandavision-diretor-e-roteirista-falam-dos-momentos-finais-tecmundosite', '/uploads/news/20220428112526_ir-para-wandavision-diretor-e-roteirista-falam-dos-momentos-finais-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/212583-wandavision-diretor-roteirista-falam-momentos-finais.htm', NULL, NULL, 0, '2021-03-11', '2022-04-28 23:25:26', '2022-04-28 23:25:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(126, 29, 'Ir para: WandaVision: o que aconteceu com os moradores de Westview?', 'ir-para-wandavision-o-que-aconteceu-com-os-moradores-de-westview', 'ir-para-wandavision-o-que-aconteceu-com-os-moradores-de-westview-tecmundosite', '/uploads/news/20220428112526_ir-para-wandavision-o-que-aconteceu-com-os-moradores-de-westview-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/212500-wandavision-aconteceu-moradores-westview.htm', NULL, NULL, 0, '2021-03-10', '2022-04-28 23:25:26', '2022-04-28 23:25:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(127, 29, 'Ir para: WandaVision: Agatha Harkness pode voltar ao MCU com Kathryn Hahn', 'ir-para-wandavision-agatha-harkness-pode-voltar-ao-mcu-com-kathryn-hahn', 'ir-para-wandavision-agatha-harkness-pode-voltar-ao-mcu-com-kathryn-hahn-tecmundosite', '/uploads/news/20220428112527_ir-para-wandavision-agatha-harkness-pode-voltar-ao-mcu-com-kathryn-hahn-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/212424-wandavision-agatha-harkness-voltar-mcu-kathryn-hahn.htm', NULL, NULL, 0, '2021-03-09', '2022-04-28 23:25:27', '2022-04-28 23:25:27');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(128, 30, 'WandaVision I Nomes dos personagens se tornam populares em bebês nascidos em 2021', 'wandavision-i-nomes-dos-personagens-se-tornam-populares-em-bebes-nascidos-em-2021', 'wandavision-i-nomes-dos-personagens-se-tornam-populares-em-bebes-nascidos-em-2021-poltronanerdsite', '/uploads/news/20220428112530_wandavision-i-nomes-dos-personagens-se-tornam-populares-em-bebes-nascidos-em-2021-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-i-nomes-dos-personagens-se-tornam-populares-em-bebes-nascidos-em-2021-128515', NULL, NULL, 0, '2021-11-09', '2022-04-28 23:25:30', '2022-04-28 23:25:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(129, 30, 'WandaVision vai ganhar série derivada focada em Agatha Harkness', 'wandavision-vai-ganhar-serie-derivada-focada-em-agatha-harkness', 'wandavision-vai-ganhar-serie-derivada-focada-em-agatha-harkness-poltronanerdsite', '/uploads/news/20220428112530_wandavision-vai-ganhar-serie-derivada-focada-em-agatha-harkness-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/streaming/disney/wandavision-vai-ganhar-serie-derivada-focada-em-agatha-harkness-127172', NULL, NULL, 0, '2021-10-07', '2022-04-28 23:25:31', '2022-04-28 23:25:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(130, 30, 'Marvel | Quais são os próximos projetos depois de WandaVision', 'marvel-quais-sao-os-proximos-projetos-depois-de-wandavision', 'marvel-quais-sao-os-proximos-projetos-depois-de-wandavision-poltronanerdsite', '/uploads/news/20220428112531_marvel-quais-sao-os-proximos-projetos-depois-de-wandavision-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/marvel-quais-sao-os-proximos-projetos-depois-de-wandavision-116571', NULL, NULL, 0, '2021-03-15', '2022-04-28 23:25:31', '2022-04-28 23:25:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(131, 30, 'WandaVision | Confira os easter eggs do nono episódio da série', 'wandavision-confira-os-easter-eggs-do-nono-episodio-da-serie', 'wandavision-confira-os-easter-eggs-do-nono-episodio-da-serie-poltronanerdsite', '/uploads/news/20220428112531_wandavision-confira-os-easter-eggs-do-nono-episodio-da-serie-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-confira-os-easter-eggs-do-nono-episodio-da-serie-116479', NULL, NULL, 0, '2021-03-06', '2022-04-28 23:25:32', '2022-04-28 23:25:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(132, 30, 'WandaVision | Diretor fala sobre teorias dos fãs para o último episódio', 'wandavision-diretor-fala-sobre-teorias-dos-fas-para-o-ultimo-episodio', 'wandavision-diretor-fala-sobre-teorias-dos-fas-para-o-ultimo-episodio-poltronanerdsite', '/uploads/news/20220428112532_wandavision-diretor-fala-sobre-teorias-dos-fas-para-o-ultimo-episodio-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-diretor-fala-sobre-teorias-dos-fas-para-o-ultimo-episodio-116285', NULL, NULL, 0, '2021-03-03', '2022-04-28 23:25:32', '2022-04-28 23:25:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(133, 30, 'WandaVision ultrapassa Bridgerton como a série mais vista do streaming', 'wandavision-ultrapassa-bridgerton-como-a-serie-mais-vista-do-streaming', 'wandavision-ultrapassa-bridgerton-como-a-serie-mais-vista-do-streaming-poltronanerdsite', '/uploads/news/20220428112533_wandavision-ultrapassa-bridgerton-como-a-serie-mais-vista-do-streaming-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-ultrapassa-bridgerton-como-a-serie-mais-vista-do-streaming-116092', NULL, NULL, 0, '2021-02-28', '2022-04-28 23:25:33', '2022-04-28 23:25:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(134, 30, 'WandaVision | Confira os easter eggs do oitavo episódio da série', 'wandavision-confira-os-easter-eggs-do-oitavo-episodio-da-serie', 'wandavision-confira-os-easter-eggs-do-oitavo-episodio-da-serie-poltronanerdsite', '/uploads/news/20220428112533_wandavision-confira-os-easter-eggs-do-oitavo-episodio-da-serie-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-confira-os-easter-eggs-do-oitavo-episodio-da-serie-115991', NULL, NULL, 0, '2021-02-26', '2022-04-28 23:25:34', '2022-04-28 23:25:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(135, 30, 'WandaVision | Paul Bettany diz que um personagem secreto será revelado', 'wandavision-paul-bettany-diz-que-um-personagem-secreto-sera-revelado', 'wandavision-paul-bettany-diz-que-um-personagem-secreto-sera-revelado-poltronanerdsite', '/uploads/news/20220428112534_wandavision-paul-bettany-diz-que-um-personagem-secreto-sera-revelado-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-paul-bettany-diz-que-um-personagem-secreto-sera-revelado-115577', NULL, NULL, 0, '2021-02-21', '2022-04-28 23:25:34', '2022-04-28 23:25:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(136, 30, 'WandaVision | Paul Bettany diz que falar sobre Mephisto pode levar à demissão', 'wandavision-paul-bettany-diz-que-falar-sobre-mephisto-pode-levar-a-demissao', 'wandavision-paul-bettany-diz-que-falar-sobre-mephisto-pode-levar-a-demissao-poltronanerdsite', '/uploads/news/20220428112534_wandavision-paul-bettany-diz-que-falar-sobre-mephisto-pode-levar-a-demissao-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-paul-bettany-diz-que-falar-sobre-mephisto-pode-levar-a-demissao-115552', NULL, NULL, 0, '2021-02-20', '2022-04-28 23:25:35', '2022-04-28 23:25:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(137, 30, 'WandaVision | Confira os easter eggs do sétimo episódio da série', 'wandavision-confira-os-easter-eggs-do-setimo-episodio-da-serie', 'wandavision-confira-os-easter-eggs-do-setimo-episodio-da-serie-poltronanerdsite', '/uploads/news/20220428112535_wandavision-confira-os-easter-eggs-do-setimo-episodio-da-serie-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-confira-os-easter-eggs-do-setimo-episodio-da-serie-115470', NULL, NULL, 0, '2021-02-19', '2022-04-28 23:25:35', '2022-04-28 23:25:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(138, 30, 'WandaVision | Wanda &8216;se pune&8217; com um tempo em casa no novo vídeo', 'wandavision-wanda-8216se-pune8217-com-um-tempo-em-casa-no-novo-video', 'wandavision-wanda-8216se-pune8217-com-um-tempo-em-casa-no-novo-video-poltronanerdsite', '/uploads/news/20220428112535_wandavision-wanda-8216se-pune8217-com-um-tempo-em-casa-no-novo-video-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-wanda-se-pune-com-um-tempo-em-casa-no-novo-video-115455', NULL, NULL, 0, '2021-02-18', '2022-04-28 23:25:36', '2022-04-28 23:25:36');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(139, 30, 'WandaVision | Confira os easter eggs do sexto episódio da série', 'wandavision-confira-os-easter-eggs-do-sexto-episodio-da-serie', 'wandavision-confira-os-easter-eggs-do-sexto-episodio-da-serie-poltronanerdsite', '/uploads/news/20220428112536_wandavision-confira-os-easter-eggs-do-sexto-episodio-da-serie-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-confira-os-easter-eggs-do-sexto-episodio-da-serie-115048', NULL, NULL, 0, '2021-02-12', '2022-04-28 23:25:36', '2022-04-28 23:25:36');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(140, 30, 'WandaVision | Featurette mostra o que está por vir na série do Disney+', 'wandavision-featurette-mostra-o-que-esta-por-vir-na-serie-do-disney', 'wandavision-featurette-mostra-o-que-esta-por-vir-na-serie-do-disney-poltronanerdsite', '/uploads/news/20220428112536_wandavision-featurette-mostra-o-que-esta-por-vir-na-serie-do-disney-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-featurette-mostra-o-que-esta-por-vir-na-serie-do-disney-115034', NULL, NULL, 0, '2021-02-11', '2022-04-28 23:25:37', '2022-04-28 23:25:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(141, 30, 'WandaVision | Confira os easter eggs do quinto episódio da série', 'wandavision-confira-os-easter-eggs-do-quinto-episodio-da-serie', 'wandavision-confira-os-easter-eggs-do-quinto-episodio-da-serie-poltronanerdsite', '/uploads/news/20220428112537_wandavision-confira-os-easter-eggs-do-quinto-episodio-da-serie-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/series/wandavision-confira-os-easter-eggs-do-quinto-episodio-da-serie-114797', NULL, NULL, 0, '2021-02-06', '2022-04-28 23:25:37', '2022-04-28 23:25:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(142, 8, 'WANDAVISION - Contexto, curiosidades e segredos', 'wandavision-contexto-curiosidades-e-segredos', 'wandavision-contexto-curiosidades-e-segredos-superoitoyoutube', '/uploads/news/20220428112543_wandavision-contexto-curiosidades-e-segredos-superoitoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=amwhiwADr8c', NULL, NULL, 0, '2021-02-12', '2022-04-28 23:25:43', '2022-04-28 23:25:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(143, 4, 'EXPLICANDO O FINAL DE WANDAVISION FiqueEmCasa Comigo', 'explicando-o-final-de-wandavision-fiqueemcasa-comigo', 'explicando-o-final-de-wandavision-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112549_explicando-o-final-de-wandavision-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=pZPH4VuKQPY', NULL, NULL, 0, '2021-03-06', '2022-04-28 23:25:49', '2022-04-28 23:25:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(144, 4, 'QUEM É MONICA RAMBEAU E QUAL O FUTURO DA PERSONAGEM NO MCU DEPOIS DE WANDAVISION?', 'quem-e-monica-rambeau-e-qual-o-futuro-da-personagem-no-mcu-depois-de-wandavision', 'quem-e-monica-rambeau-e-qual-o-futuro-da-personagem-no-mcu-depois-de-wandavision-omeleteyoutube', '/uploads/news/20220428112554_quem-e-monica-rambeau-e-qual-o-futuro-da-personagem-no-mcu-depois-de-wandavision-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=co0XvGCCSfM', NULL, NULL, 0, '2021-02-02', '2022-04-28 23:25:54', '2022-04-28 23:25:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(145, 4, 'WANDAVISON - O VEREDITO AO VIVO! FiqueEmCasa Comigo', 'wandavison-o-veredito-ao-vivo-fiqueemcasa-comigo', 'wandavison-o-veredito-ao-vivo-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112556_wandavison-o-veredito-ao-vivo-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-NDwmfvSPlU', NULL, NULL, 0, '2021-03-05', '2022-04-28 23:25:57', '2022-04-28 23:25:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(146, 4, 'WANDAVISION: A HQ QUE VOCÊ PRECISA LER ANTES DE VER A SÉRIE DA MARVEL FiqueEmCasa Comigo', 'wandavision-a-hq-que-voce-precisa-ler-antes-de-ver-a-serie-da-marvel-fiqueemcasa-comigo', 'wandavision-a-hq-que-voce-precisa-ler-antes-de-ver-a-serie-da-marvel-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112600_wandavision-a-hq-que-voce-precisa-ler-antes-de-ver-a-serie-da-marvel-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=jJ0rJ-OcyJM', NULL, NULL, 0, '2021-01-15', '2022-04-28 23:26:00', '2022-04-28 23:26:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(147, 4, 'PRIMEIRAS IMPRESSÕES DE WANDAVISION FiqueEmCasa Comigo', 'primeiras-impressoes-de-wandavision-fiqueemcasa-comigo', 'primeiras-impressoes-de-wandavision-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112603_primeiras-impressoes-de-wandavision-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dqkhE5JQRl8', NULL, NULL, 0, '2021-01-15', '2022-04-28 23:26:04', '2022-04-28 23:26:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(148, 4, '7 SEGREDOS DE WANDAVISION', '7-segredos-de-wandavision', '7-segredos-de-wandavision-omeleteyoutube', '/uploads/news/20220428112606_7-segredos-de-wandavision-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=M-H93YrQQz4', NULL, NULL, 0, '2020-02-04', '2022-04-28 23:26:07', '2022-04-28 23:26:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(149, 4, 'VOCÊ ENTENDEU A REFERÊNCIA? PRINCIPAIS EASTER EGGS DE WANDAVISION', 'voce-entendeu-a-referencia-principais-easter-eggs-de-wandavision', 'voce-entendeu-a-referencia-principais-easter-eggs-de-wandavision-omeleteyoutube', '/uploads/news/20220428112609_voce-entendeu-a-referencia-principais-easter-eggs-de-wandavision-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5PU94LvXsnY', NULL, NULL, 0, '2021-01-31', '2022-04-28 23:26:09', '2022-04-28 23:26:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(150, 4, 'WANDAVISION: O QUE É A SWORD NA SÉRIE DA MARVEL NO DISNEY+ ? FiqueEmCasa Comigo', 'wandavision-o-que-e-a-sword-na-serie-da-marvel-no-disney-fiqueemcasa-comigo', 'wandavision-o-que-e-a-sword-na-serie-da-marvel-no-disney-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112612_wandavision-o-que-e-a-sword-na-serie-da-marvel-no-disney-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=nURlu1DYcu0', NULL, NULL, 0, '2021-01-19', '2022-04-28 23:26:13', '2022-04-28 23:26:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(151, 4, 'QUEM É A AGNES EM WANDAVISION? FiqueEmCasa Comigo', 'quem-e-a-agnes-em-wandavision-fiqueemcasa-comigo', 'quem-e-a-agnes-em-wandavision-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112615_quem-e-a-agnes-em-wandavision-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=T5WbTuntyrw', NULL, NULL, 0, '2021-02-19', '2022-04-28 23:26:16', '2022-04-28 23:26:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(152, 4, 'COMO WANDAVISION MUDOU O UNIVERSO MARVEL FiqueEmCasa Comigo', 'como-wandavision-mudou-o-universo-marvel-fiqueemcasa-comigo', 'como-wandavision-mudou-o-universo-marvel-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112620_como-wandavision-mudou-o-universo-marvel-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=aNI1LPDv__g', NULL, NULL, 0, '2021-03-05', '2022-04-28 23:26:21', '2022-04-28 23:26:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(153, 4, 'WANDAVISION EM 2020! MARVEL EXPANDE UNIVERSO AINDA ESTE ANO FiqueEmCasa Comigo', 'wandavision-em-2020-marvel-expande-universo-ainda-este-ano-fiqueemcasa-comigo', 'wandavision-em-2020-marvel-expande-universo-ainda-este-ano-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112624_wandavision-em-2020-marvel-expande-universo-ainda-este-ano-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ijPRJhTfIeY', NULL, NULL, 0, '2020-09-16', '2022-04-28 23:26:24', '2022-04-28 23:26:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(154, 4, 'WANDAVISION: A PRIMEIRA SITCOM DO MCU E SUAS INFLUÊNCIAS FiqueEmCasa Comigo', 'wandavision-a-primeira-sitcom-do-mcu-e-suas-influencias-fiqueemcasa-comigo', 'wandavision-a-primeira-sitcom-do-mcu-e-suas-influencias-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112628_wandavision-a-primeira-sitcom-do-mcu-e-suas-influencias-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-SpATgFBqGc', NULL, NULL, 0, '2021-01-16', '2022-04-28 23:26:28', '2022-04-28 23:26:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(155, 4, 'WANDAVISION GANHA TRAILER IMPRESSIONANTE! CONFIRA DETALHES DA SÉRIE MARVEL FiqueEmCasa Comigo', 'wandavision-ganha-trailer-impressionante-confira-detalhes-da-serie-marvel-fiqueemcasa-comigo', 'wandavision-ganha-trailer-impressionante-confira-detalhes-da-serie-marvel-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112633_wandavision-ganha-trailer-impressionante-confira-detalhes-da-serie-marvel-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dv-v_LCJRso', NULL, NULL, 0, '2020-09-21', '2022-04-28 23:26:34', '2022-04-28 23:26:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(156, 4, 'VISÃO BRANCO EM WANDAVISION! O QUE ESPERAR DO GRANDE FINAL FiqueEmCasa Comigo', 'visao-branco-em-wandavision-o-que-esperar-do-grande-final-fiqueemcasa-comigo', 'visao-branco-em-wandavision-o-que-esperar-do-grande-final-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112638_visao-branco-em-wandavision-o-que-esperar-do-grande-final-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=JblTNXbsR9g', NULL, NULL, 0, '2021-02-27', '2022-04-28 23:26:38', '2022-04-28 23:26:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(157, 4, 'EXPECTATIVA WANDAVISION: O QUE ESPERAR DA NOVA SÉRIE FiqueEmCasa Comigo', 'expectativa-wandavision-o-que-esperar-da-nova-serie-fiqueemcasa-comigo', 'expectativa-wandavision-o-que-esperar-da-nova-serie-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112643_expectativa-wandavision-o-que-esperar-da-nova-serie-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=tRouCDydYJ8', NULL, NULL, 0, '2021-01-12', '2022-04-28 23:26:43', '2022-04-28 23:26:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(158, 4, 'WANDAVISION, LOKI E FALCÃO: ERROS E ACERTOS DO MCU NA TV', 'wandavision-loki-e-falcao-erros-e-acertos-do-mcu-na-tv', 'wandavision-loki-e-falcao-erros-e-acertos-do-mcu-na-tv-omeleteyoutube', '/uploads/news/20220428112646_wandavision-loki-e-falcao-erros-e-acertos-do-mcu-na-tv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=xdjyTmqroTQ', NULL, NULL, 0, '2021-05-27', '2022-04-28 23:26:47', '2022-04-28 23:26:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(159, 4, 'NOVA HEROÍNA EM WANDAVISION?', 'nova-heroina-em-wandavision', 'nova-heroina-em-wandavision-omeleteyoutube', '/uploads/news/20220428112649_nova-heroina-em-wandavision-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wN32hElOF_A', NULL, NULL, 0, '2019-12-17', '2022-04-28 23:26:49', '2022-04-28 23:26:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(160, 4, 'WANDAVISION: DARCY, JIMMY WOO E A CONEXÃO COM O QUARTETO FANTÁSTICO FiqueEmCasa Comigo', 'wandavision-darcy-jimmy-woo-e-a-conexao-com-o-quarteto-fantastico-fiqueemcasa-comigo', 'wandavision-darcy-jimmy-woo-e-a-conexao-com-o-quarteto-fantastico-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112652_wandavision-darcy-jimmy-woo-e-a-conexao-com-o-quarteto-fantastico-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=K9RdePLk9Sg', NULL, NULL, 0, '2021-02-03', '2022-04-28 23:26:53', '2022-04-28 23:26:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(161, 4, 'MULTIVERSO COMEÇANDO? ENTENDENDO O NOVO TRAILER DE WANDAVISION! FiqueEmCasa Comigo', 'multiverso-comecando-entendendo-o-novo-trailer-de-wandavision-fiqueemcasa-comigo', 'multiverso-comecando-entendendo-o-novo-trailer-de-wandavision-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220428112656_multiverso-comecando-entendendo-o-novo-trailer-de-wandavision-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=2rqazptbeU8', NULL, NULL, 0, '2020-12-16', '2022-04-28 23:26:56', '2022-04-28 23:26:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(162, 7, 'WANDAVISION: FINAL EXPLICADO e o FUTURO da MARVEL! (+ CENAS PÓS-CRÉDITOS)', 'wandavision-final-explicado-e-o-futuro-da-marvel-cenas-pos-creditos', 'wandavision-final-explicado-e-o-futuro-da-marvel-cenas-pos-creditos-pipocandoyoutube', '/uploads/news/20220428112701_wandavision-final-explicado-e-o-futuro-da-marvel-cenas-pos-creditos-pipocandoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=q81uqKDi_JE', NULL, NULL, 0, '2021-03-05', '2022-04-28 23:27:02', '2022-04-28 23:27:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(163, 7, 'WANDAVISION EP 8: TUDO FEZ SENTIDO! - Teorias pro FINAL', 'wandavision-ep-8-tudo-fez-sentido-teorias-pro-final', 'wandavision-ep-8-tudo-fez-sentido-teorias-pro-final-pipocandoyoutube', '/uploads/news/20220428112705_wandavision-ep-8-tudo-fez-sentido-teorias-pro-final-pipocandoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5Q4JJdsJPek', NULL, NULL, 0, '2021-02-26', '2022-04-28 23:27:05', '2022-04-28 23:27:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(164, 5, 'WANDAVISON: RESUMO COMPLETO PARA IR PREPARADO VER DR. ESTRANHO 2', 'wandavison-resumo-completo-para-ir-preparado-ver-dr-estranho-2', 'wandavison-resumo-completo-para-ir-preparado-ver-dr-estranho-2-einerdyoutube', '/uploads/news/20220428112709_wandavison-resumo-completo-para-ir-preparado-ver-dr-estranho-2-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dTx01hrx8pc', NULL, NULL, 0, '2022-04-26', '2022-04-28 23:27:10', '2022-04-28 23:27:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(165, 5, 'O FINAL DE WANDAVISION E O FUTURO DA MARVEL!', 'o-final-de-wandavision-e-o-futuro-da-marvel', 'o-final-de-wandavision-e-o-futuro-da-marvel-einerdyoutube', '/uploads/news/20220428112713_o-final-de-wandavision-e-o-futuro-da-marvel-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=fk9hqe8FFmg', NULL, NULL, 0, '2021-03-05', '2022-04-28 23:27:13', '2022-04-28 23:27:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(166, 5, 'WANDAVISION ESTREOU! FASE 4 COMEÇOU - ANÁLISE COMPLETA', 'wandavision-estreou-fase-4-comecou-analise-completa', 'wandavision-estreou-fase-4-comecou-analise-completa-einerdyoutube', '/uploads/news/20220428112716_wandavision-estreou-fase-4-comecou-analise-completa-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=2wGCLp6lZ2w', NULL, NULL, 0, '2021-01-16', '2022-04-28 23:27:17', '2022-04-28 23:27:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(167, 5, 'WANDAVISION É HORRÍVEL MESMO?', 'wandavision-e-horrivel-mesmo', 'wandavision-e-horrivel-mesmo-einerdyoutube', '/uploads/news/20220428112721_wandavision-e-horrivel-mesmo-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=LxdAQIH3a_4', NULL, NULL, 0, '2021-01-17', '2022-04-28 23:27:22', '2022-04-28 23:27:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(168, 5, '5 MISTÉRIOS QUE WANDAVISION ESQUECEU DE RESPONDER!', '5-misterios-que-wandavision-esqueceu-de-responder', '5-misterios-que-wandavision-esqueceu-de-responder-einerdyoutube', '/uploads/news/20220428112726_5-misterios-que-wandavision-esqueceu-de-responder-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=6d4QtIAqRM4', NULL, NULL, 0, '2021-03-13', '2022-04-28 23:27:26', '2022-04-28 23:27:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(169, 5, 'REVELADO: PORQUE O DR. ESTRANHO NÃO PARTICIPOU DE WANDAVISION!', 'revelado-porque-o-dr-estranho-nao-participou-de-wandavision', 'revelado-porque-o-dr-estranho-nao-participou-de-wandavision-einerdyoutube', '/uploads/news/20220428112729_revelado-porque-o-dr-estranho-nao-participou-de-wandavision-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ujKroPSN2-s', NULL, NULL, 0, '2022-02-03', '2022-04-28 23:27:30', '2022-04-28 23:27:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(170, 5, 'MARVEL APONTOU O VILÃO DE WANDAVISION E VOCÊ NEM PERCEBEU!', 'marvel-apontou-o-vilao-de-wandavision-e-voce-nem-percebeu', 'marvel-apontou-o-vilao-de-wandavision-e-voce-nem-percebeu-einerdyoutube', '/uploads/news/20220428112734_marvel-apontou-o-vilao-de-wandavision-e-voce-nem-percebeu-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=SBDEePpqKTg', NULL, NULL, 0, '2021-02-18', '2022-04-28 23:27:35', '2022-04-28 23:27:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(171, 5, 'WANDAVISION REVELA TODOS OS SEGREDOS DA WANDA!', 'wandavision-revela-todos-os-segredos-da-wanda', 'wandavision-revela-todos-os-segredos-da-wanda-einerdyoutube', '/uploads/news/20220428112738_wandavision-revela-todos-os-segredos-da-wanda-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=0BoB75vXWZ0', NULL, NULL, 0, '2021-02-26', '2022-04-28 23:27:38', '2022-04-28 23:27:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(172, 5, 'JÁ ASSISTIRAM WANDAVISION - SERÁ QUE É ISSO TUDO MESMO?', 'ja-assistiram-wandavision-sera-que-e-isso-tudo-mesmo', 'ja-assistiram-wandavision-sera-que-e-isso-tudo-mesmo-einerdyoutube', '/uploads/news/20220428112743_ja-assistiram-wandavision-sera-que-e-isso-tudo-mesmo-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=kF7E8jDU8FE', NULL, NULL, 0, '2021-01-10', '2022-04-28 23:27:43', '2022-04-28 23:27:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(173, 5, 'MEPHISTO ESTÁ EM WANDAVISION E VOCÊ NEM NOTOU!', 'mephisto-esta-em-wandavision-e-voce-nem-notou', 'mephisto-esta-em-wandavision-e-voce-nem-notou-einerdyoutube', '/uploads/news/20220428112747_mephisto-esta-em-wandavision-e-voce-nem-notou-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=uv-8yRC9vUE', NULL, NULL, 0, '2021-01-23', '2022-04-28 23:27:48', '2022-04-28 23:27:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(174, 5, 'REVELADO O MAIOR MISTÉRIO DE WANDAVISION!', 'revelado-o-maior-misterio-de-wandavision', 'revelado-o-maior-misterio-de-wandavision-einerdyoutube', '/uploads/news/20220428112752_revelado-o-maior-misterio-de-wandavision-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=iBOf2Ux5q0w', NULL, NULL, 0, '2021-02-10', '2022-04-28 23:27:53', '2022-04-28 23:27:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(175, 5, 'WANDAVISION DISNEY PLUS | TRAILER DUBLADO - REACT E PRIMEIRAS ANÁLISES', 'wandavision-disney-plus-trailer-dublado-react-e-primeiras-analises', 'wandavision-disney-plus-trailer-dublado-react-e-primeiras-analises-einerdyoutube', '/uploads/news/20220428112756_wandavision-disney-plus-trailer-dublado-react-e-primeiras-analises-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=sXXGj75YnFE', NULL, NULL, 0, '2020-09-21', '2022-04-28 23:27:56', '2022-04-28 23:27:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(176, 5, 'O MERCÚRIO NÃO É UM X-MAN? WANDA ESTÁ NO CONTROLE DE TUDO? - ANÁLISE WANDAVISION EP. 6', 'o-mercurio-nao-e-um-x-man-wanda-esta-no-controle-de-tudo-analise-wandavision-ep-6', 'o-mercurio-nao-e-um-x-man-wanda-esta-no-controle-de-tudo-analise-wandavision-ep-6-einerdyoutube', '/uploads/news/20220428112800_o-mercurio-nao-e-um-x-man-wanda-esta-no-controle-de-tudo-analise-wandavision-ep-6-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ivRwW2RoHMU', NULL, NULL, 0, '2021-02-12', '2022-04-28 23:28:00', '2022-04-28 23:28:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(177, 6, 'WANDAVISION! PORQUE NENHUM VINGADOR APARECEU PARA AJUDAR', 'wandavision-porque-nenhum-vingador-apareceu-para-ajudar', 'wandavision-porque-nenhum-vingador-apareceu-para-ajudar-nerdlandyoutube', '/uploads/news/20220428112806_wandavision-porque-nenhum-vingador-apareceu-para-ajudar-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=mttR-K4bK-4', NULL, NULL, 0, '2021-02-15', '2022-04-28 23:28:07', '2022-04-28 23:28:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(178, 6, 'EXPLICADO COMO MERCURIO DE X MEN NO FINAL DE WANDAVISION É O RALPH!', 'explicado-como-mercurio-de-x-men-no-final-de-wandavision-e-o-ralph', 'explicado-como-mercurio-de-x-men-no-final-de-wandavision-e-o-ralph-nerdlandyoutube', '/uploads/news/20220428112811_explicado-como-mercurio-de-x-men-no-final-de-wandavision-e-o-ralph-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=k1q4gIlV-Ok', NULL, NULL, 0, '2021-03-09', '2022-04-28 23:28:12', '2022-04-28 23:28:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(179, 6, 'WANDAVISION EP. 9 FINAL EXPLICADO (SEGREDOS + ANÁLISE + TEORIA)', 'wandavision-ep-9-final-explicado-segredos-analise-teoria', 'wandavision-ep-9-final-explicado-segredos-analise-teoria-nerdlandyoutube', '/uploads/news/20220428112814_wandavision-ep-9-final-explicado-segredos-analise-teoria-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=V9JwaS88KKs', NULL, NULL, 0, '2021-03-05', '2022-04-28 23:28:15', '2022-04-28 23:28:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(180, 6, 'WANDAVISION EP. 5 EXPLICADO (FINAL + ANÁLISE + TEORIA)', 'wandavision-ep-5-explicado-final-analise-teoria', 'wandavision-ep-5-explicado-final-analise-teoria-nerdlandyoutube', '/uploads/news/20220428112816_wandavision-ep-5-explicado-final-analise-teoria-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=CGnFutTvrSk', NULL, NULL, 0, '2021-02-05', '2022-04-28 23:28:17', '2022-04-28 23:28:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(181, 6, 'WANDAVISION EP. 3 EXPLICADO (FINAL + ANÁLISE + TEORIA)', 'wandavision-ep-3-explicado-final-analise-teoria', 'wandavision-ep-3-explicado-final-analise-teoria-nerdlandyoutube', '/uploads/news/20220428112821_wandavision-ep-3-explicado-final-analise-teoria-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=FjRBaMbkv_U', NULL, NULL, 0, '2021-01-22', '2022-04-28 23:28:22', '2022-04-28 23:28:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(182, 6, '54 DETALHES QUE VOCÊ PERDEU! WANDAVISION EP. 9 FINAL (EASTER EGGS + REFERÊNCIAS + SEGREDOS)', '54-detalhes-que-voce-perdeu-wandavision-ep-9-final-easter-eggs-referencias-segredos', '54-detalhes-que-voce-perdeu-wandavision-ep-9-final-easter-eggs-referencias-segredos-nerdlandyoutube', '/uploads/news/20220428112825_54-detalhes-que-voce-perdeu-wandavision-ep-9-final-easter-eggs-referencias-segredos-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=1CqrpZpQfRE', NULL, NULL, 0, '2021-03-05', '2022-04-28 23:28:26', '2022-04-28 23:28:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(183, 6, 'WANDAVISION EPISÓDIO 6! COMERCIAL EXPLICADO!', 'wandavision-episodio-6-comercial-explicado', 'wandavision-episodio-6-comercial-explicado-nerdlandyoutube', '/uploads/news/20220428112829_wandavision-episodio-6-comercial-explicado-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=HroyBXResFo', NULL, NULL, 0, '2021-02-12', '2022-04-28 23:28:30', '2022-04-28 23:28:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(184, 6, 'ESSE FINAL DE WANDAVISION É FALSO! Shorts', 'esse-final-de-wandavision-e-falso-shorts', 'esse-final-de-wandavision-e-falso-shorts-nerdlandyoutube', '/uploads/news/20220428112834_esse-final-de-wandavision-e-falso-shorts-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Xoil8LS_U_c', NULL, NULL, 0, '2021-09-04', '2022-04-28 23:28:34', '2022-04-28 23:28:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(185, 6, 'WANDAVISION SEM EFEITOS ESPECIAIS! HILÁRIO!', 'wandavision-sem-efeitos-especiais-hilario', 'wandavision-sem-efeitos-especiais-hilario-nerdlandyoutube', '/uploads/news/20220428112838_wandavision-sem-efeitos-especiais-hilario-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dmM3FqxmsnU', NULL, NULL, 0, '2021-03-16', '2022-04-28 23:28:38', '2022-04-28 23:28:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(186, 6, 'WANDAVISION! NOVA CENA PÓS CRÉDITOS! DR. ESTRANHO APARECEU EXPLICADO!', 'wandavision-nova-cena-pos-creditos-dr-estranho-apareceu-explicado', 'wandavision-nova-cena-pos-creditos-dr-estranho-apareceu-explicado-nerdlandyoutube', '/uploads/news/20220428112842_wandavision-nova-cena-pos-creditos-dr-estranho-apareceu-explicado-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=cQuPXxcNvwY', NULL, NULL, 0, '2021-06-28', '2022-04-28 23:28:42', '2022-04-28 23:28:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(187, 6, 'WANDAVISION EP. 1 E 2 EXPLICADO (FINAL + ANÁLISE + TEORIA)', 'wandavision-ep-1-e-2-explicado-final-analise-teoria', 'wandavision-ep-1-e-2-explicado-final-analise-teoria-nerdlandyoutube', '/uploads/news/20220428112847_wandavision-ep-1-e-2-explicado-final-analise-teoria-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=w7kX29s_83M', NULL, NULL, 0, '2021-01-15', '2022-04-28 23:28:47', '2022-04-28 23:28:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(188, 6, 'WANDAVISION! QUEM A WANDA VIU NA EXPLOSÃO DA JOIA DO INFINITO EXPLICADO!', 'wandavision-quem-a-wanda-viu-na-explosao-da-joia-do-infinito-explicado', 'wandavision-quem-a-wanda-viu-na-explosao-da-joia-do-infinito-explicado-nerdlandyoutube', '/uploads/news/20220428112850_wandavision-quem-a-wanda-viu-na-explosao-da-joia-do-infinito-explicado-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=B7zFMSvq4Us', NULL, NULL, 0, '2021-03-02', '2022-04-28 23:28:51', '2022-04-28 23:28:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(189, 6, 'WANDA É A VERDADEIRA VILÃ DE WANDAVISION', 'wanda-e-a-verdadeira-vila-de-wandavision', 'wanda-e-a-verdadeira-vila-de-wandavision-nerdlandyoutube', '/uploads/news/20220428112855_wanda-e-a-verdadeira-vila-de-wandavision-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=gh2whLgfNEE', NULL, NULL, 0, '2021-02-03', '2022-04-28 23:28:56', '2022-04-28 23:28:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(190, 6, 'VAZOU CENA DELETADA ÉPICA DO FINAL DE WANDAVISION EP 9', 'vazou-cena-deletada-epica-do-final-de-wandavision-ep-9', 'vazou-cena-deletada-epica-do-final-de-wandavision-ep-9-nerdlandyoutube', '/uploads/news/20220428112859_vazou-cena-deletada-epica-do-final-de-wandavision-ep-9-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=SsL0KcHnC9g', NULL, NULL, 0, '2021-03-08', '2022-04-28 23:28:59', '2022-04-28 23:28:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(191, 6, 'WANDAVISION EXPLICADO! COMO A MONICA SOBREVIVEU AO ATAQUE DA WANDA', 'wandavision-explicado-como-a-monica-sobreviveu-ao-ataque-da-wanda', 'wandavision-explicado-como-a-monica-sobreviveu-ao-ataque-da-wanda-nerdlandyoutube', '/uploads/news/20220428112901_wandavision-explicado-como-a-monica-sobreviveu-ao-ataque-da-wanda-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ELXt5CFuMW8', NULL, NULL, 0, '2021-02-04', '2022-04-28 23:29:02', '2022-04-28 23:29:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(192, 6, 'COMERCIAIS DE WANDAVISION EXPLICADO! A Ligação com as JOIAS DO INFINITO!', 'comerciais-de-wandavision-explicado-a-ligacao-com-as-joias-do-infinito', 'comerciais-de-wandavision-explicado-a-ligacao-com-as-joias-do-infinito-nerdlandyoutube', '/uploads/news/20220428112906_comerciais-de-wandavision-explicado-a-ligacao-com-as-joias-do-infinito-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=i09r_fw1Dro', NULL, NULL, 0, '2021-02-09', '2022-04-28 23:29:06', '2022-04-28 23:29:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(193, 6, 'OS FILHOS DA WANDA VAO VOLTAR EM DR ESTRANHO 2? FINAL WANDAVISION EXPLICADO!', 'os-filhos-da-wanda-vao-voltar-em-dr-estranho-2-final-wandavision-explicado', 'os-filhos-da-wanda-vao-voltar-em-dr-estranho-2-final-wandavision-explicado-nerdlandyoutube', '/uploads/news/20220428112908_os-filhos-da-wanda-vao-voltar-em-dr-estranho-2-final-wandavision-explicado-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dK4byRwk7AE', NULL, NULL, 0, '2021-03-09', '2022-04-28 23:29:09', '2022-04-28 23:29:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(194, 6, '44 DETALHES QUE VOCÊ PERDEU! WANDAVISION EPISÓDIO 6', '44-detalhes-que-voce-perdeu-wandavision-episodio-6', '44-detalhes-que-voce-perdeu-wandavision-episodio-6-nerdlandyoutube', '/uploads/news/20220428112912_44-detalhes-que-voce-perdeu-wandavision-episodio-6-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=VeGhOTBEOg0', NULL, NULL, 0, '2021-02-12', '2022-04-28 23:29:12', '2022-04-28 23:29:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(195, 6, 'FINAL DE WANDAVISION! PORQUE A DARCY SUMIU', 'final-de-wandavision-porque-a-darcy-sumiu', 'final-de-wandavision-porque-a-darcy-sumiu-nerdlandyoutube', '/uploads/news/20220428112916_final-de-wandavision-porque-a-darcy-sumiu-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=0BLJ5e0qeKQ', NULL, NULL, 0, '2021-02-16', '2022-04-28 23:29:17', '2022-04-28 23:29:17');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.news_tags
CREATE TABLE IF NOT EXISTS `news_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int NOT NULL,
  `tags_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=198 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.news_tags: ~195 rows (aproximadamente)
/*!40000 ALTER TABLE `news_tags` DISABLE KEYS */;
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 11, '2022-04-28 23:17:16', '2022-04-28 23:17:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(2, 2, 11, '2022-04-28 23:17:16', '2022-04-28 23:17:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(3, 3, 11, '2022-04-28 23:17:17', '2022-04-28 23:17:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(4, 4, 11, '2022-04-28 23:17:17', '2022-04-28 23:17:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(5, 5, 11, '2022-04-28 23:17:17', '2022-04-28 23:17:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(6, 6, 11, '2022-04-28 23:17:18', '2022-04-28 23:17:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(7, 7, 11, '2022-04-28 23:17:18', '2022-04-28 23:17:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(8, 8, 11, '2022-04-28 23:17:19', '2022-04-28 23:17:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(9, 9, 11, '2022-04-28 23:17:19', '2022-04-28 23:17:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(10, 10, 11, '2022-04-28 23:17:24', '2022-04-28 23:17:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(11, 11, 11, '2022-04-28 23:17:25', '2022-04-28 23:17:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(12, 12, 11, '2022-04-28 23:17:26', '2022-04-28 23:17:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(13, 13, 11, '2022-04-28 23:17:28', '2022-04-28 23:17:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(14, 14, 11, '2022-04-28 23:17:29', '2022-04-28 23:17:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(15, 15, 11, '2022-04-28 23:17:30', '2022-04-28 23:17:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(16, 16, 11, '2022-04-28 23:17:31', '2022-04-28 23:17:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(17, 17, 11, '2022-04-28 23:17:32', '2022-04-28 23:17:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(18, 18, 11, '2022-04-28 23:17:33', '2022-04-28 23:17:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(19, 19, 11, '2022-04-28 23:17:34', '2022-04-28 23:17:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(20, 20, 11, '2022-04-28 23:17:35', '2022-04-28 23:17:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(21, 21, 11, '2022-04-28 23:17:37', '2022-04-28 23:17:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(22, 22, 11, '2022-04-28 23:17:38', '2022-04-28 23:17:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(23, 23, 11, '2022-04-28 23:17:39', '2022-04-28 23:17:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(24, 24, 11, '2022-04-28 23:17:40', '2022-04-28 23:17:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(25, 25, 11, '2022-04-28 23:17:41', '2022-04-28 23:17:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(26, 26, 11, '2022-04-28 23:17:42', '2022-04-28 23:17:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(27, 27, 11, '2022-04-28 23:17:43', '2022-04-28 23:17:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(28, 28, 11, '2022-04-28 23:17:44', '2022-04-28 23:17:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(29, 29, 11, '2022-04-28 23:17:45', '2022-04-28 23:17:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(30, 30, 11, '2022-04-28 23:17:46', '2022-04-28 23:17:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(31, 31, 11, '2022-04-28 23:17:47', '2022-04-28 23:17:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(32, 32, 11, '2022-04-28 23:17:48', '2022-04-28 23:17:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(33, 33, 11, '2022-04-28 23:17:49', '2022-04-28 23:17:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(34, 34, 11, '2022-04-28 23:17:50', '2022-04-28 23:17:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(35, 35, 11, '2022-04-28 23:17:51', '2022-04-28 23:17:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(36, 36, 11, '2022-04-28 23:17:53', '2022-04-28 23:17:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(37, 37, 11, '2022-04-28 23:17:53', '2022-04-28 23:17:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(38, 38, 11, '2022-04-28 23:17:56', '2022-04-28 23:17:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(39, 39, 11, '2022-04-28 23:17:56', '2022-04-28 23:17:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(40, 40, 11, '2022-04-28 23:17:57', '2022-04-28 23:17:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(41, 41, 11, '2022-04-28 23:17:57', '2022-04-28 23:17:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(42, 42, 11, '2022-04-28 23:17:58', '2022-04-28 23:17:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(43, 43, 11, '2022-04-28 23:17:59', '2022-04-28 23:17:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(44, 44, 11, '2022-04-28 23:17:59', '2022-04-28 23:17:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(45, 45, 11, '2022-04-28 23:18:00', '2022-04-28 23:18:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(46, 46, 11, '2022-04-28 23:18:00', '2022-04-28 23:18:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(47, 47, 11, '2022-04-28 23:18:01', '2022-04-28 23:18:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(48, 48, 11, '2022-04-28 23:18:05', '2022-04-28 23:18:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(49, 49, 11, '2022-04-28 23:18:05', '2022-04-28 23:18:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(50, 50, 11, '2022-04-28 23:18:06', '2022-04-28 23:18:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(51, 51, 11, '2022-04-28 23:18:06', '2022-04-28 23:18:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(52, 52, 11, '2022-04-28 23:18:07', '2022-04-28 23:18:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(53, 53, 11, '2022-04-28 23:18:07', '2022-04-28 23:18:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(54, 54, 11, '2022-04-28 23:18:08', '2022-04-28 23:18:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(55, 55, 11, '2022-04-28 23:18:09', '2022-04-28 23:18:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(56, 56, 11, '2022-04-28 23:18:09', '2022-04-28 23:18:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(57, 57, 11, '2022-04-28 23:18:10', '2022-04-28 23:18:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(58, 58, 11, '2022-04-28 23:18:10', '2022-04-28 23:18:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(59, 59, 11, '2022-04-28 23:18:11', '2022-04-28 23:18:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(60, 60, 11, '2022-04-28 23:18:18', '2022-04-28 23:18:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(61, 61, 11, '2022-04-28 23:18:22', '2022-04-28 23:18:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(62, 62, 11, '2022-04-28 23:18:27', '2022-04-28 23:18:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(63, 63, 11, '2022-04-28 23:18:32', '2022-04-28 23:18:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(64, 64, 11, '2022-04-28 23:18:35', '2022-04-28 23:18:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(65, 65, 11, '2022-04-28 23:18:38', '2022-04-28 23:18:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(66, 66, 11, '2022-04-28 23:18:43', '2022-04-28 23:18:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(67, 67, 11, '2022-04-28 23:18:45', '2022-04-28 23:18:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(68, 68, 11, '2022-04-28 23:18:49', '2022-04-28 23:18:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(69, 69, 11, '2022-04-28 23:18:51', '2022-04-28 23:18:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(70, 70, 11, '2022-04-28 23:18:54', '2022-04-28 23:18:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(71, 71, 11, '2022-04-28 23:18:58', '2022-04-28 23:18:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(72, 72, 11, '2022-04-28 23:19:02', '2022-04-28 23:19:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(73, 73, 11, '2022-04-28 23:19:07', '2022-04-28 23:19:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(74, 74, 11, '2022-04-28 23:19:10', '2022-04-28 23:19:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(75, 75, 11, '2022-04-28 23:19:15', '2022-04-28 23:19:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(76, 76, 11, '2022-04-28 23:19:19', '2022-04-28 23:19:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(77, 77, 11, '2022-04-28 23:19:23', '2022-04-28 23:19:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(78, 78, 11, '2022-04-28 23:19:26', '2022-04-28 23:19:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(79, 79, 11, '2022-04-28 23:19:30', '2022-04-28 23:19:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(80, 80, 11, '2022-04-28 23:19:34', '2022-04-28 23:19:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(81, 81, 11, '2022-04-28 23:19:39', '2022-04-28 23:19:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(82, 82, 11, '2022-04-28 23:19:46', '2022-04-28 23:19:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(83, 83, 11, '2022-04-28 23:19:49', '2022-04-28 23:19:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(84, 84, 11, '2022-04-28 23:19:54', '2022-04-28 23:19:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(85, 85, 11, '2022-04-28 23:19:59', '2022-04-28 23:19:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(86, 86, 11, '2022-04-28 23:20:02', '2022-04-28 23:20:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(87, 87, 12, '2022-04-28 23:24:47', '2022-04-28 23:24:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(88, 88, 12, '2022-04-28 23:24:47', '2022-04-28 23:24:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(89, 89, 12, '2022-04-28 23:24:47', '2022-04-28 23:24:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(90, 90, 12, '2022-04-28 23:24:48', '2022-04-28 23:24:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(91, 26, 12, '2022-04-28 23:24:51', '2022-04-28 23:24:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(92, 91, 12, '2022-04-28 23:24:52', '2022-04-28 23:24:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(93, 92, 12, '2022-04-28 23:24:53', '2022-04-28 23:24:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(94, 93, 12, '2022-04-28 23:24:54', '2022-04-28 23:24:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(95, 94, 12, '2022-04-28 23:24:55', '2022-04-28 23:24:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(96, 95, 12, '2022-04-28 23:24:56', '2022-04-28 23:24:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(97, 96, 12, '2022-04-28 23:24:57', '2022-04-28 23:24:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(98, 97, 12, '2022-04-28 23:24:58', '2022-04-28 23:24:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(99, 98, 12, '2022-04-28 23:24:59', '2022-04-28 23:24:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(100, 99, 12, '2022-04-28 23:25:01', '2022-04-28 23:25:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(101, 100, 12, '2022-04-28 23:25:01', '2022-04-28 23:25:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(102, 101, 12, '2022-04-28 23:25:02', '2022-04-28 23:25:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(103, 102, 12, '2022-04-28 23:25:03', '2022-04-28 23:25:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(104, 103, 12, '2022-04-28 23:25:04', '2022-04-28 23:25:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(105, 104, 12, '2022-04-28 23:25:05', '2022-04-28 23:25:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(106, 105, 12, '2022-04-28 23:25:07', '2022-04-28 23:25:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(107, 106, 12, '2022-04-28 23:25:07', '2022-04-28 23:25:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(108, 107, 12, '2022-04-28 23:25:08', '2022-04-28 23:25:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(109, 108, 12, '2022-04-28 23:25:09', '2022-04-28 23:25:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(110, 109, 12, '2022-04-28 23:25:10', '2022-04-28 23:25:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(111, 110, 12, '2022-04-28 23:25:11', '2022-04-28 23:25:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(112, 111, 12, '2022-04-28 23:25:12', '2022-04-28 23:25:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(113, 112, 12, '2022-04-28 23:25:14', '2022-04-28 23:25:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(114, 113, 12, '2022-04-28 23:25:15', '2022-04-28 23:25:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(115, 114, 12, '2022-04-28 23:25:15', '2022-04-28 23:25:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(116, 115, 12, '2022-04-28 23:25:17', '2022-04-28 23:25:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(117, 116, 12, '2022-04-28 23:25:18', '2022-04-28 23:25:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(118, 117, 12, '2022-04-28 23:25:19', '2022-04-28 23:25:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(119, 118, 12, '2022-04-28 23:25:22', '2022-04-28 23:25:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(120, 119, 12, '2022-04-28 23:25:23', '2022-04-28 23:25:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(121, 120, 12, '2022-04-28 23:25:23', '2022-04-28 23:25:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(122, 121, 12, '2022-04-28 23:25:24', '2022-04-28 23:25:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(123, 122, 12, '2022-04-28 23:25:24', '2022-04-28 23:25:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(124, 123, 12, '2022-04-28 23:25:25', '2022-04-28 23:25:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(125, 124, 12, '2022-04-28 23:25:26', '2022-04-28 23:25:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(126, 125, 12, '2022-04-28 23:25:26', '2022-04-28 23:25:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(127, 126, 12, '2022-04-28 23:25:27', '2022-04-28 23:25:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(128, 127, 12, '2022-04-28 23:25:28', '2022-04-28 23:25:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(129, 128, 12, '2022-04-28 23:25:30', '2022-04-28 23:25:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(130, 129, 12, '2022-04-28 23:25:31', '2022-04-28 23:25:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(131, 130, 12, '2022-04-28 23:25:31', '2022-04-28 23:25:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(132, 131, 12, '2022-04-28 23:25:32', '2022-04-28 23:25:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(133, 132, 12, '2022-04-28 23:25:32', '2022-04-28 23:25:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(134, 133, 12, '2022-04-28 23:25:33', '2022-04-28 23:25:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(135, 134, 12, '2022-04-28 23:25:34', '2022-04-28 23:25:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(136, 135, 12, '2022-04-28 23:25:34', '2022-04-28 23:25:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(137, 136, 12, '2022-04-28 23:25:35', '2022-04-28 23:25:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(138, 137, 12, '2022-04-28 23:25:35', '2022-04-28 23:25:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(139, 138, 12, '2022-04-28 23:25:36', '2022-04-28 23:25:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(140, 139, 12, '2022-04-28 23:25:36', '2022-04-28 23:25:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(141, 140, 12, '2022-04-28 23:25:37', '2022-04-28 23:25:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(142, 141, 12, '2022-04-28 23:25:37', '2022-04-28 23:25:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(143, 142, 12, '2022-04-28 23:25:43', '2022-04-28 23:25:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(144, 143, 12, '2022-04-28 23:25:49', '2022-04-28 23:25:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(145, 144, 12, '2022-04-28 23:25:54', '2022-04-28 23:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(146, 145, 12, '2022-04-28 23:25:57', '2022-04-28 23:25:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(147, 146, 12, '2022-04-28 23:26:00', '2022-04-28 23:26:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(148, 147, 12, '2022-04-28 23:26:04', '2022-04-28 23:26:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(149, 148, 12, '2022-04-28 23:26:07', '2022-04-28 23:26:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(150, 149, 12, '2022-04-28 23:26:09', '2022-04-28 23:26:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(151, 150, 12, '2022-04-28 23:26:13', '2022-04-28 23:26:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(152, 151, 12, '2022-04-28 23:26:16', '2022-04-28 23:26:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(153, 152, 12, '2022-04-28 23:26:21', '2022-04-28 23:26:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(154, 153, 12, '2022-04-28 23:26:24', '2022-04-28 23:26:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(155, 154, 12, '2022-04-28 23:26:28', '2022-04-28 23:26:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(156, 79, 12, '2022-04-28 23:26:28', '2022-04-28 23:26:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(157, 155, 12, '2022-04-28 23:26:34', '2022-04-28 23:26:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(158, 156, 12, '2022-04-28 23:26:38', '2022-04-28 23:26:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(159, 157, 12, '2022-04-28 23:26:43', '2022-04-28 23:26:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(160, 158, 12, '2022-04-28 23:26:47', '2022-04-28 23:26:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(161, 159, 12, '2022-04-28 23:26:49', '2022-04-28 23:26:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(162, 160, 12, '2022-04-28 23:26:53', '2022-04-28 23:26:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(163, 161, 12, '2022-04-28 23:26:56', '2022-04-28 23:26:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(164, 162, 12, '2022-04-28 23:27:02', '2022-04-28 23:27:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(165, 163, 12, '2022-04-28 23:27:05', '2022-04-28 23:27:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(166, 164, 12, '2022-04-28 23:27:10', '2022-04-28 23:27:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(167, 165, 12, '2022-04-28 23:27:13', '2022-04-28 23:27:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(168, 166, 12, '2022-04-28 23:27:17', '2022-04-28 23:27:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(169, 167, 12, '2022-04-28 23:27:22', '2022-04-28 23:27:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(170, 168, 12, '2022-04-28 23:27:26', '2022-04-28 23:27:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(171, 169, 12, '2022-04-28 23:27:30', '2022-04-28 23:27:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(172, 170, 12, '2022-04-28 23:27:35', '2022-04-28 23:27:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(173, 171, 12, '2022-04-28 23:27:38', '2022-04-28 23:27:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(174, 172, 12, '2022-04-28 23:27:43', '2022-04-28 23:27:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(175, 173, 12, '2022-04-28 23:27:48', '2022-04-28 23:27:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(176, 174, 12, '2022-04-28 23:27:53', '2022-04-28 23:27:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(177, 175, 12, '2022-04-28 23:27:56', '2022-04-28 23:27:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(178, 176, 12, '2022-04-28 23:28:00', '2022-04-28 23:28:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(179, 177, 12, '2022-04-28 23:28:07', '2022-04-28 23:28:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(180, 178, 12, '2022-04-28 23:28:12', '2022-04-28 23:28:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(181, 179, 12, '2022-04-28 23:28:15', '2022-04-28 23:28:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(182, 180, 12, '2022-04-28 23:28:17', '2022-04-28 23:28:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(183, 181, 12, '2022-04-28 23:28:22', '2022-04-28 23:28:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(184, 182, 12, '2022-04-28 23:28:26', '2022-04-28 23:28:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(185, 183, 12, '2022-04-28 23:28:31', '2022-04-28 23:28:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(186, 184, 12, '2022-04-28 23:28:34', '2022-04-28 23:28:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(187, 185, 12, '2022-04-28 23:28:38', '2022-04-28 23:28:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(188, 186, 12, '2022-04-28 23:28:42', '2022-04-28 23:28:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(189, 187, 12, '2022-04-28 23:28:47', '2022-04-28 23:28:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(190, 188, 12, '2022-04-28 23:28:51', '2022-04-28 23:28:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(191, 189, 12, '2022-04-28 23:28:56', '2022-04-28 23:28:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(192, 190, 12, '2022-04-28 23:28:59', '2022-04-28 23:28:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(193, 191, 12, '2022-04-28 23:29:02', '2022-04-28 23:29:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(194, 192, 12, '2022-04-28 23:29:06', '2022-04-28 23:29:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(195, 193, 12, '2022-04-28 23:29:09', '2022-04-28 23:29:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(196, 194, 12, '2022-04-28 23:29:12', '2022-04-28 23:29:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(197, 195, 12, '2022-04-28 23:29:17', '2022-04-28 23:29:17');
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
) ENGINE=InnoDB AUTO_INCREMENT=128 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.podcasts: ~127 rows (aproximadamente)
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
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(51, 27, 'Lá do Bunker 13 - O trem do hype', 'la-do-bunker-13-o-trem-do-hype', 'la-do-bunker-13-o-trem-do-hype-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1ffac612f8e36de82ad12370df', NULL, 'show', 'https://open.spotify.com/episode/27tjZqajfqS75vMq7j7uJS', NULL, NULL, 0, '2021-10-25', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(52, 27, 'Caneca de Mamicas 25 - Cacete de trampo', 'caneca-de-mamicas-25-cacete-de-trampo', 'caneca-de-mamicas-25-cacete-de-trampo-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fbbd508df8ef53f0d55588325', NULL, 'show', 'https://open.spotify.com/episode/3Fx3DU8MzOcvtNPVsGSwxD', NULL, NULL, 0, '2021-10-23', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(53, 27, 'NerdCast 800 - O Melhor de 800 Nerdcasts!', 'nerdcast-800-o-melhor-de-800-nerdcasts', 'nerdcast-800-o-melhor-de-800-nerdcasts-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f234a708400214f6c866d263e', NULL, 'show', 'https://open.spotify.com/episode/4HvwxIiI4KabOXRhZmWmRJ', NULL, NULL, 0, '2021-10-22', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(54, 27, 'Papo de Parceiro 03 - Usando soft skills na arte das vendas', 'papo-de-parceiro-03-usando-soft-skills-na-arte-das-vendas', 'papo-de-parceiro-03-usando-soft-skills-na-arte-das-vendas-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f8165d6f14a13e66043cb37b9', NULL, 'show', 'https://open.spotify.com/episode/4ydkfeKSR4F0SgUSBm8vhl', NULL, NULL, 0, '2021-10-19', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(55, 27, 'Lá do Bunker 12 - Cenas dos próximos capítulos', 'la-do-bunker-12-cenas-dos-proximos-capitulos', 'la-do-bunker-12-cenas-dos-proximos-capitulos-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f5024dbaaa954afa46a3f7879', NULL, 'show', 'https://open.spotify.com/episode/5xnvaPDPq6P6JHBmsrixHN', NULL, NULL, 0, '2021-10-18', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(56, 27, 'Caneca de Mamicas 24 - Você trampa como eu trampo?', 'caneca-de-mamicas-24-voce-trampa-como-eu-trampo', 'caneca-de-mamicas-24-voce-trampa-como-eu-trampo-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f53966f02777dc2eca533390d', NULL, 'show', 'https://open.spotify.com/episode/4agAIzja2u8PpB93V9WYpk', NULL, NULL, 0, '2021-10-16', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(57, 27, 'NerdCast 799 - What If? E se a Marvel fosse ousada?', 'nerdcast-799-what-if-e-se-a-marvel-fosse-ousada', 'nerdcast-799-what-if-e-se-a-marvel-fosse-ousada-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fd46f05864b23aa5fca05c05d', NULL, 'show', 'https://open.spotify.com/episode/7KOHHrXWsC4RZ3pUvJmQBK', NULL, NULL, 0, '2021-10-15', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(58, 27, 'Speak English 44 - O Halloween da vida real', 'speak-english-44-o-halloween-da-vida-real', 'speak-english-44-o-halloween-da-vida-real-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f1a779f7d54973dbaf87ced5a', NULL, 'show', 'https://open.spotify.com/episode/0ewUeVsqtUmsYQfvUpsis5', NULL, NULL, 0, '2021-10-15', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(59, 27, 'Lá do Bunker 11 - Saudade da minha ex', 'la-do-bunker-11-saudade-da-minha-ex', 'la-do-bunker-11-saudade-da-minha-ex-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f2adfb7648f79bba0ffa78733', NULL, 'show', 'https://open.spotify.com/episode/1EVruG1LH6ry9eDHQZukIg', NULL, NULL, 0, '2021-10-11', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(60, 27, 'Caneca de Mamicas 23 - O Super Favorito', 'caneca-de-mamicas-23-o-super-favorito', 'caneca-de-mamicas-23-o-super-favorito-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f19d131441e27ea73d66d8b59', NULL, 'show', 'https://open.spotify.com/episode/00lJ1ts8soyFfmYaJFIz6N', NULL, NULL, 0, '2021-10-09', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(61, 27, 'NerdCast 798 - Perrengues da hora do almoço', 'nerdcast-798-perrengues-da-hora-do-almoco', 'nerdcast-798-perrengues-da-hora-do-almoco-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f118f6319597553f887166edf', NULL, 'show', 'https://open.spotify.com/episode/2gX23BUe7vlq0IKQEMyskR', NULL, NULL, 0, '2021-10-08', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(62, 27, 'NerdCash 40 - Evergrande: Minha casa, minha crise', 'nerdcash-40-evergrande-minha-casa-minha-crise', 'nerdcash-40-evergrande-minha-casa-minha-crise-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fe05f74587b2b7633c8d6f51b', NULL, 'show', 'https://open.spotify.com/episode/5gY84HdYdppN1fHtcLWcfF', NULL, NULL, 0, '2021-10-08', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(63, 27, 'Lá do Bunker 10 - Olimpíadas do Faustão Mortais', 'la-do-bunker-10-olimpiadas-do-faustao-mortais', 'la-do-bunker-10-olimpiadas-do-faustao-mortais-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fbb1e49c80845a3da3be47a79', NULL, 'show', 'https://open.spotify.com/episode/4bwXhw5A4moQVxqip98ITz', NULL, NULL, 0, '2021-10-04', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(64, 27, 'Caneca de Mamicas 22 - A Favorita', 'caneca-de-mamicas-22-a-favorita', 'caneca-de-mamicas-22-a-favorita-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f5c3fed77b306a8c27bafa30b', NULL, 'show', 'https://open.spotify.com/episode/5LyhaEzUDy4KxPCA3wIpej', NULL, NULL, 0, '2021-10-02', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(65, 27, 'NerdCast 797 - Nós vemos a realidade como ela realmente é?', 'nerdcast-797-nos-vemos-a-realidade-como-ela-realmente-e', 'nerdcast-797-nos-vemos-a-realidade-como-ela-realmente-e-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f6e5ee7825fd4c9a07cec52ac', NULL, 'show', 'https://open.spotify.com/episode/4opYd1xfvgb0CHsTgdglSW', NULL, NULL, 0, '2021-10-01', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(66, 27, 'NerdTech 68 - O browser comeu o meu sistema operacional?', 'nerdtech-68-o-browser-comeu-o-meu-sistema-operacional', 'nerdtech-68-o-browser-comeu-o-meu-sistema-operacional-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f8fe818afb4aded5f3f895b55', NULL, 'show', 'https://open.spotify.com/episode/6zOEwD8sKlKHSQ42xrlC6l', NULL, NULL, 0, '2021-10-01', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(67, 27, 'Lá do Bunker 09 - O amor sufoca', 'la-do-bunker-09-o-amor-sufoca', 'la-do-bunker-09-o-amor-sufoca-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fa2ac90380b1c4832f34f2ba7', NULL, 'show', 'https://open.spotify.com/episode/0oJaexw64yCv4MnjeBQFH8', NULL, NULL, 0, '2021-09-27', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(68, 27, 'Caneca de Mamicas 21 - TRANS-borde gentileza', 'caneca-de-mamicas-21-trans-borde-gentileza', 'caneca-de-mamicas-21-trans-borde-gentileza-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f299cd85a7f9a4ac8aacbc33e', NULL, 'show', 'https://open.spotify.com/episode/3iTdSoWmSyVhJL4vIyY1UN', NULL, NULL, 0, '2021-09-25', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(69, 27, 'NerdCast 796 - A internet que amamos odiar', 'nerdcast-796-a-internet-que-amamos-odiar', 'nerdcast-796-a-internet-que-amamos-odiar-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1ff0f52627ab69b7c6d2147fe4', NULL, 'show', 'https://open.spotify.com/episode/5IAezoncLnqnmTQmT5FKES', NULL, NULL, 0, '2021-09-24', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(70, 27, 'Empreendedor 80 - E-Sports como negócio', 'empreendedor-80-e-sports-como-negocio', 'empreendedor-80-e-sports-como-negocio-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f727c205809caa2d0075dba26', NULL, 'show', 'https://open.spotify.com/episode/6Atxnt0yqumroSe7Zi1tbk', NULL, NULL, 0, '2021-09-24', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(71, 27, 'Papo de Parceiro 02 - Amour pelo o que faz só ajuda a vender mais', 'papo-de-parceiro-02-amour-pelo-o-que-faz-so-ajuda-a-vender-mais', 'papo-de-parceiro-02-amour-pelo-o-que-faz-so-ajuda-a-vender-mais-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fb7b123a256bb5b465d05611e', NULL, 'show', 'https://open.spotify.com/episode/47yjqBkCV2mfe21gsqW3Pi', NULL, NULL, 0, '2021-09-21', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(72, 27, 'Lá do Bunker 08 - Fofoca: gostoso demais', 'la-do-bunker-08-fofoca-gostoso-demais', 'la-do-bunker-08-fofoca-gostoso-demais-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1f720841c9e83e684125ccec2f', NULL, 'show', 'https://open.spotify.com/episode/6M2PjoaxFAI4nwUjUlTqSm', NULL, NULL, 0, '2021-09-20', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(73, 27, 'Caneca de Mamicas 20 - O Amor TRANS-forma', 'caneca-de-mamicas-20-o-amor-trans-forma', 'caneca-de-mamicas-20-o-amor-trans-forma-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fca81590bdb2d6c138c0f1455', NULL, 'show', 'https://open.spotify.com/episode/3a02iHhQDD3SvYyodHTCWH', NULL, NULL, 0, '2021-09-18', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(74, 27, 'NerdCast 795 - O The Esquadrão Suicida: Pimenta no Starro dos outros é nam nam', 'nerdcast-795-o-the-esquadrao-suicida-pimenta-no-starro-dos-outros-e-nam-nam', 'nerdcast-795-o-the-esquadrao-suicida-pimenta-no-starro-dos-outros-e-nam-nam-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fd613179756ec915edd944042', NULL, 'show', 'https://open.spotify.com/episode/0XH0xeoF2K8wXLhFmcEB0P', NULL, NULL, 0, '2021-09-17', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(75, 27, 'Speak English 43 - Estados Unidos: estereótipos VS vida real', 'speak-english-43-estados-unidos-estereotipos-vs-vida-real', 'speak-english-43-estados-unidos-estereotipos-vs-vida-real-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fd89fc0f64f078b19f31b731e', NULL, 'show', 'https://open.spotify.com/episode/1HvOe0U6cDDJzqIaWQTaUf', NULL, NULL, 0, '2021-09-17', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(76, 27, 'NerdCast Oferecido por BIS XTRA - Adestrando cachorro-quente com Tik-Tik para alienígenas: Nerdcast Descontrolado e sem pauta', 'nerdcast-oferecido-por-bis-xtra-adestrando-cachorro-quente-com-tik-tik-para-alienigenas-nerdcast-descontrolado-e-sem-pauta', 'nerdcast-oferecido-por-bis-xtra-adestrando-cachorro-quente-com-tik-tik-para-alienigenas-nerdcast-descontrolado-e-sem-pauta-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fffd8d68197e8e59f2de930fe', NULL, 'show', 'https://open.spotify.com/episode/22lyWi5UGKLC52laX0T4fr', NULL, NULL, 0, '2021-09-14', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(77, 27, 'Lá do Bunker 07 - Depende, vamos ver', 'la-do-bunker-07-depende-vamos-ver', 'la-do-bunker-07-depende-vamos-ver-jovemnerd-spotify', 'https://i.scdn.co/image/ab67656300005f1fbe65ae0bb9db94e53a9994af', NULL, 'show', 'https://open.spotify.com/episode/3KvcL60BsdINU8TvpvupRy', NULL, NULL, 0, '2021-09-13', '2021-10-25 21:25:11', '2021-10-25 21:25:11');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(78, 28, 'RapaduraCast 686 - Venom 2: Tempo de Carnificina', 'rapaduracast-686-venom-2-tempo-de-carnificina', 'rapaduracast-686-venom-2-tempo-de-carnificina-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f28573f53b677a6e4bf8d8c33', NULL, 'show', 'https://open.spotify.com/episode/27iHiY61nSE9zFg8evhiTG', NULL, NULL, 0, '2021-10-23', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(79, 28, 'RapaduraCast 685 - What If...? (Temporada 1, Disney+)', 'rapaduracast-685-what-if-temporada-1-disney', 'rapaduracast-685-what-if-temporada-1-disney-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f8c5baf4c54b7b9b6ae0101bd', NULL, 'show', 'https://open.spotify.com/episode/3q1K3CARi5xbTrkiDl5U6S', NULL, NULL, 0, '2021-10-15', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(80, 28, 'RapaduraCast 684 - Round 6 (Netflix, Squid Game, Temporada 1)', 'rapaduracast-684-round-6-netflix-squid-game-temporada-1', 'rapaduracast-684-round-6-netflix-squid-game-temporada-1-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f5135a73e36a9308073d506c1', NULL, 'show', 'https://open.spotify.com/episode/5rCWQYbBQprzC1gcNabQLU', NULL, NULL, 0, '2021-10-09', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(81, 28, 'RapaduraCast 683 - O cinema reabriu. O que mudou?', 'rapaduracast-683-o-cinema-reabriu-o-que-mudou', 'rapaduracast-683-o-cinema-reabriu-o-que-mudou-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f3743bd2ad4247110a492473a', NULL, 'show', 'https://open.spotify.com/episode/5uSdJQoE3d3LjSCoX9XARU', NULL, NULL, 0, '2021-10-02', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(82, 28, 'RapaduraCast 682 - One Piece (Sagas East Blue-Alabasta 1-130)', 'rapaduracast-682-one-piece-sagas-east-blue-alabasta-1-130', 'rapaduracast-682-one-piece-sagas-east-blue-alabasta-1-130-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fb61b0bc2234e0f24f5768d5c', NULL, 'show', 'https://open.spotify.com/episode/0Vu2cbzbmrVgwgCjbqvxKL', NULL, NULL, 0, '2021-09-26', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(83, 28, 'RapaduraCast 681  Superman - O Filme', 'rapaduracast-681-superman-o-filme', 'rapaduracast-681-superman-o-filme-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fbe1c6bdfb0e55a148c1f103f', NULL, 'show', 'https://open.spotify.com/episode/29iSuyw6Ar8cAX3gyCv6xf', NULL, NULL, 0, '2021-09-17', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(84, 28, 'RapaduraCast 680 - Shang-Chi e a Lenda dos Dez Anéis', 'rapaduracast-680-shang-chi-e-a-lenda-dos-dez-aneis', 'rapaduracast-680-shang-chi-e-a-lenda-dos-dez-aneis-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f26bd908c9b782d08c76c7adb', NULL, 'show', 'https://open.spotify.com/episode/030VYBtbhSlO5bIOGvMZPO', NULL, NULL, 0, '2021-09-10', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(85, 28, 'RapaduraCast 679  10 Anos de Netflix no Brasil', 'rapaduracast-679-10-anos-de-netflix-no-brasil', 'rapaduracast-679-10-anos-de-netflix-no-brasil-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f8c566355ec0f401d59ea8e8b', NULL, 'show', 'https://open.spotify.com/episode/3rDLoVkkz842AjgetXiTHs', NULL, NULL, 0, '2021-09-03', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(86, 28, 'RapaduraCast 678  Uma revolução chamada A24 e seus filmes!', 'rapaduracast-678-uma-revolucao-chamada-a24-e-seus-filmes', 'rapaduracast-678-uma-revolucao-chamada-a24-e-seus-filmes-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f94c73947ffff4d39e182b25c', NULL, 'show', 'https://open.spotify.com/episode/78zW78DnbW1Or0SwOaXUGf', NULL, NULL, 0, '2021-08-27', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(87, 28, 'RapaduraCast 677  Sex/Life, Ted Lasso, The Morning Show e The Flight Attendant', 'rapaduracast-677-sexlife-ted-lasso-the-morning-show-e-the-flight-attendant', 'rapaduracast-677-sexlife-ted-lasso-the-morning-show-e-the-flight-attendant-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f25e2841edc45b7d4f7c5c80d', NULL, 'show', 'https://open.spotify.com/episode/0oiwL1TNfDHMfRBXPSOx0V', NULL, NULL, 0, '2021-08-20', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(88, 28, 'RapaduraCast EXTRA - Dr. Morte: O Homem dos Milagres', 'rapaduracast-extra-dr-morte-o-homem-dos-milagres', 'rapaduracast-extra-dr-morte-o-homem-dos-milagres-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f0261390b3959edb8296a364b', NULL, 'show', 'https://open.spotify.com/episode/5KjL7lZQLmN3OkUKNS8oll', NULL, NULL, 0, '2021-08-19', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(89, 28, 'RapaduraCast 676  O Esquadrão Suicida', 'rapaduracast-676-o-esquadrao-suicida', 'rapaduracast-676-o-esquadrao-suicida-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f2bfe1d783f37cc8107b190c1', NULL, 'show', 'https://open.spotify.com/episode/6QtUD18j3KWDwnfOgryalh', NULL, NULL, 0, '2021-08-17', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(90, 28, 'RapaduraCast 675  Cinema LGBTQIAP+', 'rapaduracast-675-cinema-lgbtqiap', 'rapaduracast-675-cinema-lgbtqiap-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f3889b64d22e1204c4645de4d', NULL, 'show', 'https://open.spotify.com/episode/3fUlsMrdD6dCSdGIcBtUTc', NULL, NULL, 0, '2021-08-13', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(91, 28, 'RapaduraCast 674  Rua do Medo (Fear Street) // Parte 1: 1994, Parte 2: 1978 e Parte 3: 1666', 'rapaduracast-674-rua-do-medo-fear-street-parte-1-1994-parte-2-1978-e-parte-3-1666', 'rapaduracast-674-rua-do-medo-fear-street-parte-1-1994-parte-2-1978-e-parte-3-1666-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f551ec6e0d4ac0eaa506e54cb', NULL, 'show', 'https://open.spotify.com/episode/1nZaOvX3VpnaBi2SO91mBd', NULL, NULL, 0, '2021-08-06', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(92, 28, 'RapaduraCast 673  Um Lugar Silencioso - Parte II', 'rapaduracast-673-um-lugar-silencioso-parte-ii', 'rapaduracast-673-um-lugar-silencioso-parte-ii-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f858295a0c9b7171e1e3dfe7c', NULL, 'show', 'https://open.spotify.com/episode/6LJNt9j9qO72nOrXxfUyUl', NULL, NULL, 0, '2021-07-30', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(93, 28, 'RapaduraCast 672  Loki (Temporada 1, Disney+)', 'rapaduracast-672-loki-temporada-1-disney', 'rapaduracast-672-loki-temporada-1-disney-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f3e3dc2dc9b2d54baf0144a87', NULL, 'show', 'https://open.spotify.com/episode/6knUtGqqrnJioR6VrxWhE3', NULL, NULL, 0, '2021-07-23', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(94, 28, 'RapaduraCast 671  Viúva Negra e o adeus de Natasha Romanoff', 'rapaduracast-671-viuva-negra-e-o-adeus-de-natasha-romanoff', 'rapaduracast-671-viuva-negra-e-o-adeus-de-natasha-romanoff-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fa314b5b8f82d77319ff5acce', NULL, 'show', 'https://open.spotify.com/episode/12nTH6MlRzSOz3w7RKiFwV', NULL, NULL, 0, '2021-07-16', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(95, 28, 'RapaduraCast 670  Top Gun: Ases Indomáveis', 'rapaduracast-670-top-gun-ases-indomaveis', 'rapaduracast-670-top-gun-ases-indomaveis-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f95e9c78aa12cd006449bd996', NULL, 'show', 'https://open.spotify.com/episode/0q9IXuoZiOiBeargCsfYh1', NULL, NULL, 0, '2021-07-09', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(96, 28, 'RapaduraCast 669  Remakes Americanos Desnecessários', 'rapaduracast-669-remakes-americanos-desnecessarios', 'rapaduracast-669-remakes-americanos-desnecessarios-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f6a5710266405b5507fe2cc3f', NULL, 'show', 'https://open.spotify.com/episode/79vthYIlJLqosCvRVGznUv', NULL, NULL, 0, '2021-07-02', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(97, 28, 'RapaduraCast 668  Cidade de Deus', 'rapaduracast-668-cidade-de-deus', 'rapaduracast-668-cidade-de-deus-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f15322aa8fe9243342254541d', NULL, 'show', 'https://open.spotify.com/episode/1JZYXrDcnx7NzuPJSvw5zq', NULL, NULL, 0, '2021-06-26', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(98, 28, 'RapaduraCast 667  Filmes Impactantes que você não quer rever', 'rapaduracast-667-filmes-impactantes-que-voce-nao-quer-rever', 'rapaduracast-667-filmes-impactantes-que-voce-nao-quer-rever-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f52fdda74ecf7876056a1722c', NULL, 'show', 'https://open.spotify.com/episode/6aAr0XKpWgZ9WnpvkTp9dS', NULL, NULL, 0, '2021-06-18', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(99, 28, 'RapaduraCast 666  Listão: 30 filmes sobre Demônios, Exorcismos e o Diabo', 'rapaduracast-666-listao-30-filmes-sobre-demonios-exorcismos-e-o-diabo', 'rapaduracast-666-listao-30-filmes-sobre-demonios-exorcismos-e-o-diabo-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fb631bc63c00f27ee8e27b89b', NULL, 'show', 'https://open.spotify.com/episode/1rkfCSnsf8BGmVXP9TQoZf', NULL, NULL, 0, '2021-06-18', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(100, 28, 'RapaduraCast 665  Cruella e os filmes de vilões', 'rapaduracast-665-cruella-e-os-filmes-de-viloes', 'rapaduracast-665-cruella-e-os-filmes-de-viloes-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f191645674ab175fc8f12ec8a', NULL, 'show', 'https://open.spotify.com/episode/5NL7RTSKt6DG9AOtx9J6Qe', NULL, NULL, 0, '2021-06-15', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(101, 28, 'RapaduraCast 664  Army of the Dead: Invasão em Las Vegas', 'rapaduracast-664-army-of-the-dead-invasao-em-las-vegas', 'rapaduracast-664-army-of-the-dead-invasao-em-las-vegas-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f36bd44c729a71693fae4cbe3', NULL, 'show', 'https://open.spotify.com/episode/4PeT0JIdJwUO0qYUmZ24PQ', NULL, NULL, 0, '2021-06-04', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(102, 28, 'RapaduraCast 663 - Godzilla vs. Kong e Mortal Kombat', 'rapaduracast-663-godzilla-vs-kong-e-mortal-kombat', 'rapaduracast-663-godzilla-vs-kong-e-mortal-kombat-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fbb183e5da6ea5b341748224a', NULL, 'show', 'https://open.spotify.com/episode/6HACNMEa0AA8M6PSrmDtzU', NULL, NULL, 0, '2021-05-22', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(103, 28, 'RapaduraCast 662  Indiana Jones e Os Caçadores da Arca Perdida', 'rapaduracast-662-indiana-jones-e-os-cacadores-da-arca-perdida', 'rapaduracast-662-indiana-jones-e-os-cacadores-da-arca-perdida-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f51fa6e3deb2bc0102b7e41a0', NULL, 'show', 'https://open.spotify.com/episode/47bxX1MLdC33oDTt4az7Ob', NULL, NULL, 0, '2021-05-14', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(104, 28, 'RapaduraCast 661  Invencível (Temporada 1, Amazon Prime Vídeo)', 'rapaduracast-661-invencivel-temporada-1-amazon-prime-video', 'rapaduracast-661-invencivel-temporada-1-amazon-prime-video-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f5a2251f82d7b2f62bc931b37', NULL, 'show', 'https://open.spotify.com/episode/1F6iipTGGpaEUYvXsrFhat', NULL, NULL, 0, '2021-05-13', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(105, 28, 'RapaduraCast 660 - Summer Movies 2021 (Cinema e Streaming)', 'rapaduracast-660-summer-movies-2021-cinema-e-streaming', 'rapaduracast-660-summer-movies-2021-cinema-e-streaming-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f29ba6089d01de5daa58568a1', NULL, 'show', 'https://open.spotify.com/episode/5u48gUWtNPDqpidoRT6d9i', NULL, NULL, 0, '2021-05-07', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(106, 28, 'RapaduraCast 659 - Falcão e o Soldado Invernal', 'rapaduracast-659-falcao-e-o-soldado-invernal', 'rapaduracast-659-falcao-e-o-soldado-invernal-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1ff432d1fa05ba8a2558b6373d', NULL, 'show', 'https://open.spotify.com/episode/4dls7pRP4R2K6HKsDLbmcL', NULL, NULL, 0, '2021-04-30', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(107, 28, 'RapaduraCast 658 - Oscars 2021: palpites, apostas e vencedores!', 'rapaduracast-658-oscars-2021-palpites-apostas-e-vencedores', 'rapaduracast-658-oscars-2021-palpites-apostas-e-vencedores-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f8a084a271b53d47162839b0d', NULL, 'show', 'https://open.spotify.com/episode/0dwQiHZgCPzDL3892zezz2', NULL, NULL, 0, '2021-04-23', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(108, 28, 'RapaduraCast 657 - Analisando os 8 indicados a Melhor Filme do Oscars 2021', 'rapaduracast-657-analisando-os-8-indicados-a-melhor-filme-do-oscars-2021', 'rapaduracast-657-analisando-os-8-indicados-a-melhor-filme-do-oscars-2021-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fa01dc55b700e256a9d6c8d87', NULL, 'show', 'https://open.spotify.com/episode/63oYXhe0dIkvEzSIzq6cj0', NULL, NULL, 0, '2021-04-22', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(109, 28, 'RapaduraCast 656 - Pulp Fiction: Tempo de Violência', 'rapaduracast-656-pulp-fiction-tempo-de-violencia', 'rapaduracast-656-pulp-fiction-tempo-de-violencia-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f892daede2e973e77fc53c9e5', NULL, 'show', 'https://open.spotify.com/episode/0tWVryuOwgrz2jvPD97JSG', NULL, NULL, 0, '2021-04-18', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(110, 28, 'RapaduraCast 655  Fazendo as pazes com Game of Thrones (Especial 10 Anos)', 'rapaduracast-655-fazendo-as-pazes-com-game-of-thrones-especial-10-anos', 'rapaduracast-655-fazendo-as-pazes-com-game-of-thrones-especial-10-anos-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f3a38a9b61f7e8f49b82f570f', NULL, 'show', 'https://open.spotify.com/episode/498zTLpw2iu1kkykpuqvAA', NULL, NULL, 0, '2021-04-11', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(111, 28, 'RapaduraCast 654  TOP10 maiores bilheterias de cinema! Como eles conseguiram?', 'rapaduracast-654-top10-maiores-bilheterias-de-cinema-como-eles-conseguiram', 'rapaduracast-654-top10-maiores-bilheterias-de-cinema-como-eles-conseguiram-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f92f574f36d999c007f4e77df', NULL, 'show', 'https://open.spotify.com/episode/5FbZFkA0uJZxw7BOQhVXOt', NULL, NULL, 0, '2021-04-05', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(112, 28, 'RapaduraCast 653  Liga da Justiça de Zack Snyder', 'rapaduracast-653-liga-da-justica-de-zack-snyder', 'rapaduracast-653-liga-da-justica-de-zack-snyder-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f3c7f4616e1e57e0b8b67b112', NULL, 'show', 'https://open.spotify.com/episode/3QKwxL4xzd6jwg65dz9OyV', NULL, NULL, 0, '2021-03-27', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(113, 28, 'RapaduraCast 652  Os Melhores Filmes de... COMÉDIA ROMÂNTICA', 'rapaduracast-652-os-melhores-filmes-de-comedia-romantica', 'rapaduracast-652-os-melhores-filmes-de-comedia-romantica-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f74f75aa36af7c36440c349bd', NULL, 'show', 'https://open.spotify.com/episode/0wxJNpWkr5eJhDhA72r9Kw', NULL, NULL, 0, '2021-03-20', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(114, 28, 'RapaduraCast 651  O Exterminador do Futuro 2: O Julgamento Final', 'rapaduracast-651-o-exterminador-do-futuro-2-o-julgamento-final', 'rapaduracast-651-o-exterminador-do-futuro-2-o-julgamento-final-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fa476504ad355d8f67e5e4c0e', NULL, 'show', 'https://open.spotify.com/episode/3FEbIbr6Hd4fauGEfN1dcG', NULL, NULL, 0, '2021-03-18', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(115, 28, 'RapaduraCast 650  WandaVision, o luto e o futuro do MCU', 'rapaduracast-650-wandavision-o-luto-e-o-futuro-do-mcu', 'rapaduracast-650-wandavision-o-luto-e-o-futuro-do-mcu-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1febf95582bc753cf6c51da60e', NULL, 'show', 'https://open.spotify.com/episode/0kLFFYsSeNxwg84ic84erF', NULL, NULL, 0, '2021-03-12', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(116, 28, 'RapaduraCast 649 - Serial Killers: Seven - Os Sete Crimes Capitais', 'rapaduracast-649-serial-killers-seven-os-sete-crimes-capitais', 'rapaduracast-649-serial-killers-seven-os-sete-crimes-capitais-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1fbf7a76ab9509cd088efa1ec6', NULL, 'show', 'https://open.spotify.com/episode/27skHzIzM9EVMNZcNV4APL', NULL, NULL, 0, '2021-03-05', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(117, 28, 'RapaduraCast 648  O que fez a gente amar cinema!', 'rapaduracast-648-o-que-fez-a-gente-amar-cinema', 'rapaduracast-648-o-que-fez-a-gente-amar-cinema-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f9274c758d55c475fa8572d7b', NULL, 'show', 'https://open.spotify.com/episode/3avHuH4AUQfKPPNlQwY3Ur', NULL, NULL, 0, '2021-02-26', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(118, 28, 'RapaduraCast 647 - Listão: 30 Filmes sobre o Fim do Mundo', 'rapaduracast-647-listao-30-filmes-sobre-o-fim-do-mundo', 'rapaduracast-647-listao-30-filmes-sobre-o-fim-do-mundo-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ab67656300005f1f7700973093cc7681bc47dbed', NULL, 'show', 'https://open.spotify.com/episode/77XGDGuoFv9S1xPd6KIosy', NULL, NULL, 0, '2021-02-19', '2021-10-25 21:25:12', '2021-10-25 21:25:12');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(119, 28, 'RapaduraCast 646  O Melhor Filme do Nicolas Cage', 'rapaduracast-646-o-melhor-filme-do-nicolas-cage', 'rapaduracast-646-o-melhor-filme-do-nicolas-cage-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/1c24987c2e4f20edd4cb0d1487684ded4a801a33', NULL, 'show', 'https://open.spotify.com/episode/4Rzze0DH3MP3QSDZM82Cl4', NULL, NULL, 0, '2021-02-13', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(120, 28, 'RapaduraCast 645  Imediatismo na Cultura Pop', 'rapaduracast-645-imediatismo-na-cultura-pop', 'rapaduracast-645-imediatismo-na-cultura-pop-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/ced7115b04311f63273b680773918e301890d920', NULL, 'show', 'https://open.spotify.com/episode/1ihCmGJZZQ3Vp3vKEDvdae', NULL, NULL, 0, '2021-02-05', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(121, 28, 'RapaduraCast 644 - Cobra Kai (Temporada 3, Netflix)', 'rapaduracast-644-cobra-kai-temporada-3-netflix', 'rapaduracast-644-cobra-kai-temporada-3-netflix-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/45b7149280a94319f5f9402337e6a815e03bf8e9', NULL, 'show', 'https://open.spotify.com/episode/1BjoC9w4K2TpkilmELTCPL', NULL, NULL, 0, '2021-01-31', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(122, 28, 'RapaduraCast 643 - Tubarão (1975), o pai do blockbuster!', 'rapaduracast-643-tubarao-1975-o-pai-do-blockbuster', 'rapaduracast-643-tubarao-1975-o-pai-do-blockbuster-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/fb6027c98f2635673a7ea942ec651863f00f0977', NULL, 'show', 'https://open.spotify.com/episode/3gVuEP0bRfrgelfT8koRAX', NULL, NULL, 0, '2021-01-22', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(123, 28, 'RapaduraCast 642  Soul: A Pixar não é mais para criança?', 'rapaduracast-642-soul-a-pixar-nao-e-mais-para-crianca', 'rapaduracast-642-soul-a-pixar-nao-e-mais-para-crianca-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/70891ca941fb6ae943c47c8dbba538992bc56b35', NULL, 'show', 'https://open.spotify.com/episode/25xkqa7EwYc7z5Cbm5Zthq', NULL, NULL, 0, '2021-01-18', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(124, 28, 'RapaduraCast 641  Resumão 2020: Filmes, Séries, Cinema e Streaming', 'rapaduracast-641-resumao-2020-filmes-series-cinema-e-streaming', 'rapaduracast-641-resumao-2020-filmes-series-cinema-e-streaming-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/08b391652d7092d6f18491412600db46db01d38c', NULL, 'show', 'https://open.spotify.com/episode/0XVJ539sWJra3u5ysSNwhx', NULL, NULL, 0, '2021-01-09', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(125, 28, 'RapaduraCast 640  2020, o pior ano da história do cinema!', 'rapaduracast-640-2020-o-pior-ano-da-historia-do-cinema', 'rapaduracast-640-2020-o-pior-ano-da-historia-do-cinema-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/0043fd5f1144a09bbda5a161db47d1903afcc3f5', NULL, 'show', 'https://open.spotify.com/episode/7iwuvtskyKUb7pIZGAee1D', NULL, NULL, 0, '2020-12-31', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(126, 28, 'RapaduraCast 639  Mulher-Maravilha 1984', 'rapaduracast-639-mulher-maravilha-1984', 'rapaduracast-639-mulher-maravilha-1984-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/8b6a5213d9b3c703201255143c23afd0abfbd9dc', NULL, 'show', 'https://open.spotify.com/episode/1nzPBhyjPoJiRHHHfb3aW6', NULL, NULL, 0, '2020-12-30', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
INSERT INTO `podcasts` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(127, 28, 'RapaduraCast 638  The Mandalorian (Temporadas 1 e 2, Disney+)', 'rapaduracast-638-the-mandalorian-temporadas-1-e-2-disney', 'rapaduracast-638-the-mandalorian-temporadas-1-e-2-disney-cinema-com-rapadura-spotify', 'https://i.scdn.co/image/d7b6961c5569177559d1ee46b029f5ef15a16cbd', NULL, 'show', 'https://open.spotify.com/episode/4bmHffwETT6Kv1kA6vIwR5', NULL, NULL, 0, '2020-12-28', '2021-10-25 21:25:13', '2021-10-25 21:25:13');
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_unicode_ci;

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
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(14, 'Venom', 'venom', '<p>Venom</p>', '', 'Venom', 'Venom', '', 1, 'active', '2021-09-22 20:48:22', '2021-09-22 20:48:22');
INSERT INTO `tags` (`id`, `title`, `slug`, `description`, `image`, `keywords`, `description_short`, `categoria`, `order`, `status`, `created_at`, `updated_at`) VALUES
	(15, 'The Batman', 'the-batman', '<p>The Batman</p>', '', 'Batman', 'The Batman', '', 1, 'active', '2022-03-03 21:31:39', '2022-03-03 21:39:34');
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
	(1, 'Carlos Alberto Esteves Junior', 'carlosestevesjr0@gmail.com', 'masculino', '$2y$10$WWE.c9blXqU0DvaMaU2fMu1Rt4G/lEIs3dE53vBu3EHOrf2h26ywW', 'kUD8C9Bi5S2kSyB2BlTr9RM2DoRlQVmDDMoPD4FzneTs1HfNn7SdmpYd8NT86256082bba745', NULL, '2020-07-26 17:51:24', '2022-04-12 20:15:55');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.user_tags: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `user_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_tags` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
