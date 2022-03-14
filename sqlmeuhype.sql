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
	(4, 'Crawler 3', 15, '16:51:00', 'site', NULL, 1, 'active', '2021-05-01 22:21:31', '2022-03-13 16:29:28');
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
) ENGINE=InnoDB AUTO_INCREMENT=214 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Copiando dados para a tabela meuhype.news: ~209 rows (aproximadamente)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(1, 3, 'The Penguin | DC oficializa minissérie derivada de Batman', 'the-penguin-dc-oficializa-minisserie-derivada-de-batman', 'the-penguin-dc-oficializa-minisserie-derivada-de-batman-omeletesite', '/uploads/news/20220312021423_the-penguin-dc-oficializa-minisserie-derivada-de-batman-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/batman-7/the-penguin-anuncio-hbo-max', NULL, NULL, 0, '2022-03-09', '2022-03-12 02:14:24', '2022-03-12 02:14:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(2, 3, 'The Batman | Homem solta morcego vivo em cinema e interrompe sessão', 'the-batman-homem-solta-morcego-vivo-em-cinema-e-interrompe-sessao', 'the-batman-homem-solta-morcego-vivo-em-cinema-e-interrompe-sessao-omeletesite', '/uploads/news/20220312021424_the-batman-homem-solta-morcego-vivo-em-cinema-e-interrompe-sessao-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/the-batman-morcego-vivo-cinema', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:14:24', '2022-03-12 02:14:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(3, 3, 'The Batman | Zoë Kravitz perdeu papel em Cavaleiro das Trevas por cor da pele', 'the-batman-zoe-kravitz-perdeu-papel-em-cavaleiro-das-trevas-por-cor-da-pele', 'the-batman-zoe-kravitz-perdeu-papel-em-cavaleiro-das-trevas-por-cor-da-pele-omeletesite', '/uploads/news/20220312021424_the-batman-zoe-kravitz-perdeu-papel-em-cavaleiro-das-trevas-por-cor-da-pele-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/dc-comics/zoe-kravitz-papel-batman', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:14:24', '2022-03-12 02:14:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(4, 1, 'The Batman: A vingança nunca é plena, mata a alma e a envenena', 'the-batman-a-vinganca-nunca-e-plena-mata-a-alma-e-a-envenena', 'the-batman-a-vinganca-nunca-e-plena-mata-a-alma-e-a-envenena-jovemnerdsite', '/uploads/news/20220312021426_the-batman-a-vinganca-nunca-e-plena-mata-a-alma-e-a-envenena-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdcast/the-batman-a-vinganca-nunca-e-plena-mata-a-alma-e-a-envenena/', NULL, NULL, 0, '2022-03-11', '2022-03-12 02:14:28', '2022-03-12 02:14:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(5, 1, 'Música-tema de The Batman é lançada oficialmente; ouça', 'musica-tema-de-the-batman-e-lancada-oficialmente-ouca', 'musica-tema-de-the-batman-e-lancada-oficialmente-ouca-jovemnerdsite', '/uploads/news/20220312021428_musica-tema-de-the-batman-e-lancada-oficialmente-ouca-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/musica-tema-de-the-batman-e-lancada-oficialmente-ouca/', NULL, NULL, 0, '2022-01-21', '2022-03-12 02:14:29', '2022-03-12 02:14:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(6, 1, 'The Batman terá quase três horas de duração, confirma site', 'the-batman-tera-quase-tres-horas-de-duracao-confirma-site', 'the-batman-tera-quase-tres-horas-de-duracao-confirma-site-jovemnerdsite', '/uploads/news/20220312021429_the-batman-tera-quase-tres-horas-de-duracao-confirma-site-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-tera-quase-tres-horas-de-duracao-confirma-site/', NULL, NULL, 0, '2022-01-20', '2022-03-12 02:14:30', '2022-03-12 02:14:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(7, 1, 'The Batman: Vingança servida quente! (Trailer Oficial)', 'the-batman-vinganca-servida-quente-trailer-oficial', 'the-batman-vinganca-servida-quente-trailer-oficial-jovemnerdsite', '/uploads/news/20220312021430_the-batman-vinganca-servida-quente-trailer-oficial-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdoffice/the-batman-vinganca-servida-quente-trailer-oficial/', NULL, NULL, 0, '2021-10-20', '2022-03-12 02:14:31', '2022-03-12 02:14:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(8, 1, 'Vídeo de The Batman revela visual de Zöe Kravitz como Mulher-Gato', 'video-de-the-batman-revela-visual-de-zoe-kravitz-como-mulher-gato', 'video-de-the-batman-revela-visual-de-zoe-kravitz-como-mulher-gato-jovemnerdsite', '/uploads/news/20220312021431_video-de-the-batman-revela-visual-de-zoe-kravitz-como-mulher-gato-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/video-de-the-batman-revela-visual-de-zoe-kravitz-como-mulher-gato/', NULL, NULL, 0, '2021-05-06', '2022-03-12 02:14:32', '2022-03-12 02:14:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(9, 1, 'The Batman &8211; Reaction e vingança!', 'the-batman-8211-reaction-e-vinganca', 'the-batman-8211-reaction-e-vinganca-jovemnerdsite', '/uploads/news/20220312021432_the-batman-8211-reaction-e-vinganca-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdoffice/the-batman-reaction-e-vinganca/', NULL, NULL, 0, '2020-09-02', '2022-03-12 02:14:34', '2022-03-12 02:14:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(10, 1, 'Teaser de The Batman é recriado em LEGO', 'teaser-de-the-batman-e-recriado-em-lego', 'teaser-de-the-batman-e-recriado-em-lego-jovemnerdsite', '/uploads/news/20220312021434_teaser-de-the-batman-e-recriado-em-lego-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/teaser-de-the-batman-e-recriado-em-lego/', NULL, NULL, 0, '2020-08-31', '2022-03-12 02:14:35', '2022-03-12 02:14:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(11, 1, 'Fã mistura teaser de The Batman com trailer de Cats e o resultado é bizarro', 'fa-mistura-teaser-de-the-batman-com-trailer-de-cats-e-o-resultado-e-bizarro', 'fa-mistura-teaser-de-the-batman-com-trailer-de-cats-e-o-resultado-e-bizarro-jovemnerdsite', '/uploads/news/20220312021435_fa-mistura-teaser-de-the-batman-com-trailer-de-cats-e-o-resultado-e-bizarro-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/fa-mistura-trailer-de-the-batman-e-cats/', NULL, NULL, 0, '2020-08-26', '2022-03-12 02:14:36', '2022-03-12 02:14:36');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(12, 1, 'The Batman | &8220;Como fã, é o tipo de filme que eu quero ver&8221;, diz Zack Snyder', 'the-batman-8220como-fa-e-o-tipo-de-filme-que-eu-quero-ver8221-diz-zack-snyder', 'the-batman-8220como-fa-e-o-tipo-de-filme-que-eu-quero-ver8221-diz-zack-snyder-jovemnerdsite', '/uploads/news/20220312021436_the-batman-8220como-fa-e-o-tipo-de-filme-que-eu-quero-ver8221-diz-zack-snyder-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-como-fa-e-o-tipo-de-filme-que-eu-quero-ver-diz-zack-snyder/', NULL, NULL, 0, '2020-08-25', '2022-03-12 02:14:37', '2022-03-12 02:14:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(13, 1, 'The Batman | Fã decifra mensagem do Charada que aparece no teaser', 'the-batman-fa-decifra-mensagem-do-charada-que-aparece-no-teaser', 'the-batman-fa-decifra-mensagem-do-charada-que-aparece-no-teaser-jovemnerdsite', '/uploads/news/20220312021437_the-batman-fa-decifra-mensagem-do-charada-que-aparece-no-teaser-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-fa-decifra-mensagem-do-charada-que-aparece-no-teaser/', NULL, NULL, 0, '2020-08-24', '2022-03-12 02:14:37', '2022-03-12 02:14:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(14, 1, 'The Batman | Herói ainda é visto com desconfiança e medo pelas pessoas de Gotham', 'the-batman-heroi-ainda-e-visto-com-desconfianca-e-medo-pelas-pessoas-de-gotham', 'the-batman-heroi-ainda-e-visto-com-desconfianca-e-medo-pelas-pessoas-de-gotham-jovemnerdsite', '/uploads/news/20220312021437_the-batman-heroi-ainda-e-visto-com-desconfianca-e-medo-pelas-pessoas-de-gotham-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-heroi-ainda-e-visto-com-desconfianca-e-medo-pelas-pessoas-de-gotham/', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:14:39', '2022-03-12 02:14:39');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(15, 1, 'The Batman ganha primeiro teaser; assista', 'the-batman-ganha-primeiro-teaser-assista', 'the-batman-ganha-primeiro-teaser-assista-jovemnerdsite', '/uploads/news/20220312021439_the-batman-ganha-primeiro-teaser-assista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-ganha-primeiro-teaser-assista/', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:14:40', '2022-03-12 02:14:40');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(16, 1, 'The Batman | Primeiras imagens de Robert Pattinson como Bruce Wayne são reveladas; veja', 'the-batman-primeiras-imagens-de-robert-pattinson-como-bruce-wayne-sao-reveladas-veja', 'the-batman-primeiras-imagens-de-robert-pattinson-como-bruce-wayne-sao-reveladas-veja-jovemnerdsite', '/uploads/news/20220312021440_the-batman-primeiras-imagens-de-robert-pattinson-como-bruce-wayne-sao-reveladas-veja-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-primeiras-imagens-de-robert-pattinsons-como-bruce-wayne-sao-reveladas-veja/', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:14:41', '2022-03-12 02:14:41');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(17, 1, 'The Batman se passa em um universo diferente do apresentado em Liga da Justiça', 'the-batman-se-passa-em-um-universo-diferente-do-apresentado-em-liga-da-justica', 'the-batman-se-passa-em-um-universo-diferente-do-apresentado-em-liga-da-justica-jovemnerdsite', '/uploads/news/20220312021441_the-batman-se-passa-em-um-universo-diferente-do-apresentado-em-liga-da-justica-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-se-passa-em-universo-diferente-do-apresentado-em-liga-da-justica/', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:14:42', '2022-03-12 02:14:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(18, 1, 'The Batman | Matt Reeves divulga logo e nova arte do filme', 'the-batman-matt-reeves-divulga-logo-e-nova-arte-do-filme', 'the-batman-matt-reeves-divulga-logo-e-nova-arte-do-filme-jovemnerdsite', '/uploads/news/20220312021442_the-batman-matt-reeves-divulga-logo-e-nova-arte-do-filme-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-matt-reeves-divulga-logo-e-nova-arte-do-filme/', NULL, NULL, 0, '2020-08-20', '2022-03-12 02:14:43', '2022-03-12 02:14:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(19, 1, 'Gravações de The Batman devem ser retomadas em setembro', 'gravacoes-de-the-batman-devem-ser-retomadas-em-setembro', 'gravacoes-de-the-batman-devem-ser-retomadas-em-setembro-jovemnerdsite', '/uploads/news/20220312021443_gravacoes-de-the-batman-devem-ser-retomadas-em-setembro-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/gravacoes-de-the-batman-devem-ser-retomadas-em-setembro/', NULL, NULL, 0, '2020-08-19', '2022-03-12 02:14:45', '2022-03-12 02:14:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(20, 1, 'The Batman | Novo símbolo do herói é registrado pela DC e Warner', 'the-batman-novo-simbolo-do-heroi-e-registrado-pela-dc-e-warner', 'the-batman-novo-simbolo-do-heroi-e-registrado-pela-dc-e-warner-jovemnerdsite', '/uploads/news/20220312021445_the-batman-novo-simbolo-do-heroi-e-registrado-pela-dc-e-warner-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-novo-simbolo-do-heroi-e-registrado-pela-dc-e-warner/', NULL, NULL, 0, '2020-08-19', '2022-03-12 02:14:46', '2022-03-12 02:14:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(21, 1, 'Robert Pattinson revela ter mentido para Christopher Nolan sobre teste de The Batman', 'robert-pattinson-revela-ter-mentido-para-christopher-nolan-sobre-teste-de-the-batman', 'robert-pattinson-revela-ter-mentido-para-christopher-nolan-sobre-teste-de-the-batman-jovemnerdsite', '/uploads/news/20220312021446_robert-pattinson-revela-ter-mentido-para-christopher-nolan-sobre-teste-de-the-batman-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/robert-pattinson-revela-ter-mentido-para-christopher-nolan-sobre-teste-de-the-batman/', NULL, NULL, 0, '2020-08-10', '2022-03-12 02:14:47', '2022-03-12 02:14:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(22, 1, 'Zack Snyder está empolgado pra assistir The Batman de Matt Reeves', 'zack-snyder-esta-empolgado-pra-assistir-the-batman-de-matt-reeves', 'zack-snyder-esta-empolgado-pra-assistir-the-batman-de-matt-reeves-jovemnerdsite', '/uploads/news/20220312021447_zack-snyder-esta-empolgado-pra-assistir-the-batman-de-matt-reeves-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/zack-snyder-esta-empolgado-pra-assistir-the-batman-de-matt-reeves/', NULL, NULL, 0, '2020-07-21', '2022-03-12 02:14:47', '2022-03-12 02:14:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(23, 1, 'The Batman ganhará série derivada no HBO Max', 'the-batman-ganhara-serie-derivada-no-hbo-max', 'the-batman-ganhara-serie-derivada-no-hbo-max-jovemnerdsite', '/uploads/news/20220312021447_the-batman-ganhara-serie-derivada-no-hbo-max-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-ganhara-serie-derivada-no-hbo-max/', NULL, NULL, 0, '2020-07-10', '2022-03-12 02:14:49', '2022-03-12 02:14:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(24, 1, 'The Batman é sobre o Alfred e o Batman, diz diretor de fotografia', 'the-batman-e-sobre-o-alfred-e-o-batman-diz-diretor-de-fotografia', 'the-batman-e-sobre-o-alfred-e-o-batman-diz-diretor-de-fotografia-jovemnerdsite', '/uploads/news/20220312021449_the-batman-e-sobre-o-alfred-e-o-batman-diz-diretor-de-fotografia-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-e-sobre-o-alfred-e-o-batman-diz-diretor-de-fotografia/', NULL, NULL, 0, '2020-07-07', '2022-03-12 02:14:50', '2022-03-12 02:14:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(25, 1, 'The Batman | Zoë Kravitz explica motivos que tornam Robert Pattinson o Batman perfeito', 'the-batman-zoe-kravitz-explica-motivos-que-tornam-robert-pattinson-o-batman-perfeito', 'the-batman-zoe-kravitz-explica-motivos-que-tornam-robert-pattinson-o-batman-perfeito-jovemnerdsite', '/uploads/news/20220312021450_the-batman-zoe-kravitz-explica-motivos-que-tornam-robert-pattinson-o-batman-perfeito-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-zoe-kravitz-explica-porque-robert-pattinson-e-perfeito-como-batman/', NULL, NULL, 0, '2020-06-26', '2022-03-12 02:14:51', '2022-03-12 02:14:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(26, 1, 'The Batman | Peter Sarsgaard elogia Robert Pattinson: &8220;ele está incrível&8221;', 'the-batman-peter-sarsgaard-elogia-robert-pattinson-8220ele-esta-incrivel8221', 'the-batman-peter-sarsgaard-elogia-robert-pattinson-8220ele-esta-incrivel8221-jovemnerdsite', '/uploads/news/20220312021451_the-batman-peter-sarsgaard-elogia-robert-pattinson-8220ele-esta-incrivel8221-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-peter-sarsgaard-elogia-robert-pattinson-ele-esta-incrivel/', NULL, NULL, 0, '2020-06-20', '2022-03-12 02:14:52', '2022-03-12 02:14:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(27, 1, 'The Batman | Robert Pattinson revela se inspirar em atores da Marvel para entrar em forma', 'the-batman-robert-pattinson-revela-se-inspirar-em-atores-da-marvel-para-entrar-em-forma', 'the-batman-robert-pattinson-revela-se-inspirar-em-atores-da-marvel-para-entrar-em-forma-jovemnerdsite', '/uploads/news/20220312021452_the-batman-robert-pattinson-revela-se-inspirar-em-atores-da-marvel-para-entrar-em-forma-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-robert-pattinson-releva-se-inspirar-em-atores-da-marvel-para-entrar-em-forma/', NULL, NULL, 0, '2020-06-19', '2022-03-12 02:14:53', '2022-03-12 02:14:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(28, 1, 'The Batman | Zöe Kravitz fala sobre o traje da Mulher-Gato no filme', 'the-batman-zoe-kravitz-fala-sobre-o-traje-da-mulher-gato-no-filme', 'the-batman-zoe-kravitz-fala-sobre-o-traje-da-mulher-gato-no-filme-jovemnerdsite', '/uploads/news/20220312021453_the-batman-zoe-kravitz-fala-sobre-o-traje-da-mulher-gato-no-filme-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-zoe-kravitz-fala-sobre-o-traje-da-mulher-gato-no-filme/', NULL, NULL, 0, '2020-06-18', '2022-03-12 02:14:54', '2022-03-12 02:14:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(29, 1, 'The Batman | &8220;Fiquei realmente surpreso com o roteiro&8221; diz Paul Dano, o Charada do filme', 'the-batman-8220fiquei-realmente-surpreso-com-o-roteiro8221-diz-paul-dano-o-charada-do-filme', 'the-batman-8220fiquei-realmente-surpreso-com-o-roteiro8221-diz-paul-dano-o-charada-do-filme-jovemnerdsite', '/uploads/news/20220312021454_the-batman-8220fiquei-realmente-surpreso-com-o-roteiro8221-diz-paul-dano-o-charada-do-filme-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-fiquei-realmente-surpreso-com-o-roteiro-diz-paul-dano-o-charada-do-filme/', NULL, NULL, 0, '2020-06-04', '2022-03-12 02:14:55', '2022-03-12 02:14:55');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(30, 1, 'The Batman | Modelo conceitual do novo Batmóvel revela detalhes do veículo', 'the-batman-modelo-conceitual-do-novo-batmovel-revela-detalhes-do-veiculo', 'the-batman-modelo-conceitual-do-novo-batmovel-revela-detalhes-do-veiculo-jovemnerdsite', '/uploads/news/20220312021455_the-batman-modelo-conceitual-do-novo-batmovel-revela-detalhes-do-veiculo-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-modelo-conceitual-do-novo-batmovel-revela-detalhes-do-veiculo/', NULL, NULL, 0, '2020-06-01', '2022-03-12 02:14:56', '2022-03-12 02:14:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(31, 1, 'The Batman será a &8220;próxima evolução&8221; do super-herói, diz Jeffrey Wright, o Gordon do filme', 'the-batman-sera-a-8220proxima-evolucao8221-do-super-heroi-diz-jeffrey-wright-o-gordon-do-filme', 'the-batman-sera-a-8220proxima-evolucao8221-do-super-heroi-diz-jeffrey-wright-o-gordon-do-filme-jovemnerdsite', '/uploads/news/20220312021456_the-batman-sera-a-8220proxima-evolucao8221-do-super-heroi-diz-jeffrey-wright-o-gordon-do-filme-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/the-batman-filme-sera-a-proxima-evolucao-do-super-heroi-diz-jeffrey-wright/', NULL, NULL, 0, '2020-05-22', '2022-03-12 02:14:57', '2022-03-12 02:14:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(32, 29, 'Ir para: The Batman: música do Nirvana no filme teve aumento de 1.200% no Spotify', 'ir-para-the-batman-musica-do-nirvana-no-filme-teve-aumento-de-1200-no-spotify', 'ir-para-the-batman-musica-do-nirvana-no-filme-teve-aumento-de-1200-no-spotify-tecmundosite', '/uploads/news/20220312021458_ir-para-the-batman-musica-do-nirvana-no-filme-teve-aumento-de-1200-no-spotify-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/235268-the-batman-musica-nirvana-filme-spotify.htm', NULL, NULL, 0, '2022-03-11', '2022-03-12 02:14:59', '2022-03-12 02:14:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(33, 29, 'Ir para: The Batman: o que é um filme noir?', 'ir-para-the-batman-o-que-e-um-filme-noir', 'ir-para-the-batman-o-que-e-um-filme-noir-tecmundosite', '/uploads/news/20220312021459_ir-para-the-batman-o-que-e-um-filme-noir-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/235166-the-batman-filme-noir.htm', NULL, NULL, 0, '2022-03-10', '2022-03-12 02:14:59', '2022-03-12 02:14:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(34, 29, 'Ir para: The Batman: Zoë Kravitz foi recusada em trilogia anterior de filmes', 'ir-para-the-batman-zoe-kravitz-foi-recusada-em-trilogia-anterior-de-filmes', 'ir-para-the-batman-zoe-kravitz-foi-recusada-em-trilogia-anterior-de-filmes-tecmundosite', '/uploads/news/20220312021459_ir-para-the-batman-zoe-kravitz-foi-recusada-em-trilogia-anterior-de-filmes-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/235011-the-batman-zoe-kravitz-recusada-trilogia-anterior-filmes.htm', NULL, NULL, 0, '2022-03-08', '2022-03-12 02:14:59', '2022-03-12 02:14:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(35, 29, 'Ir para: The Batman: série prequel não acontecerá mais no HBO Max; veja!', 'ir-para-the-batman-serie-prequel-nao-acontecera-mais-no-hbo-max-veja', 'ir-para-the-batman-serie-prequel-nao-acontecera-mais-no-hbo-max-veja-tecmundosite', '/uploads/news/20220312021459_ir-para-the-batman-serie-prequel-nao-acontecera-mais-no-hbo-max-veja-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/235028-the-batman-serie-prequel-nao-acontecera-hbo-max.htm', NULL, NULL, 0, '2022-03-08', '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(36, 29, 'Ir para: The Batman: bilheteria de estreia é maior do que o esperado; veja valor!', 'ir-para-the-batman-bilheteria-de-estreia-e-maior-do-que-o-esperado-veja-valor', 'ir-para-the-batman-bilheteria-de-estreia-e-maior-do-que-o-esperado-veja-valor-tecmundosite', '/uploads/news/20220312021500_ir-para-the-batman-bilheteria-de-estreia-e-maior-do-que-o-esperado-veja-valor-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/234958-the-batman-bilheteria-estreia-maior-esperado-valor.htm', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(37, 29, 'Ir para: The Batman: Matt Reeves fala sobre possível crossover com Coringa', 'ir-para-the-batman-matt-reeves-fala-sobre-possivel-crossover-com-coringa', 'ir-para-the-batman-matt-reeves-fala-sobre-possivel-crossover-com-coringa-tecmundosite', '/uploads/news/20220312021500_ir-para-the-batman-matt-reeves-fala-sobre-possivel-crossover-com-coringa-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/234910-the-batman-matt-reeves-crossover-coringa.htm', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(38, 29, 'Ir para: The Batman: fãs exaltam filme como um dos melhores da DC; veja reações!', 'ir-para-the-batman-fas-exaltam-filme-como-um-dos-melhores-da-dc-veja-reacoes', 'ir-para-the-batman-fas-exaltam-filme-como-um-dos-melhores-da-dc-veja-reacoes-tecmundosite', '/uploads/news/20220312021500_ir-para-the-batman-fas-exaltam-filme-como-um-dos-melhores-da-dc-veja-reacoes-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/234862-the-batman-fas-exaltam-filme-melhores-dc-veja-reacoes.htm', NULL, NULL, 0, '2022-03-04', '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(39, 29, 'Ir para: The Batman: diretor responde críticas sobre tempo de duração do filme', 'ir-para-the-batman-diretor-responde-criticas-sobre-tempo-de-duracao-do-filme', 'ir-para-the-batman-diretor-responde-criticas-sobre-tempo-de-duracao-do-filme-tecmundosite', '/uploads/news/20220312021501_ir-para-the-batman-diretor-responde-criticas-sobre-tempo-de-duracao-do-filme-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/234809-the-batman-diretor-criticas-tempo-duracao-filme.htm', NULL, NULL, 0, '2022-03-04', '2022-03-12 02:15:01', '2022-03-12 02:15:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(40, 29, 'Ir para: Além de The Batman e Crepúsculo: 5 filmes para conhecer Robert Pattinson', 'ir-para-alem-de-the-batman-e-crepusculo-5-filmes-para-conhecer-robert-pattinson', 'ir-para-alem-de-the-batman-e-crepusculo-5-filmes-para-conhecer-robert-pattinson-tecmundosite', '/uploads/news/20220312021501_ir-para-alem-de-the-batman-e-crepusculo-5-filmes-para-conhecer-robert-pattinson-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/234756-batman-crepusculo-5-filmes-conhecer-robert-pattinson.htm', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:15:01', '2022-03-12 02:15:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(41, 29, 'Ir para: The Batman 2: produtor fala sobre quando sequência deve ser lançada', 'ir-para-the-batman-2-produtor-fala-sobre-quando-sequencia-deve-ser-lancada', 'ir-para-the-batman-2-produtor-fala-sobre-quando-sequencia-deve-ser-lancada-tecmundosite', '/uploads/news/20220312021501_ir-para-the-batman-2-produtor-fala-sobre-quando-sequencia-deve-ser-lancada-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/234719-the-batman-2-produtor-sequencia-lancamento.htm', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:15:02', '2022-03-12 02:15:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(42, 30, 'Matt Reeves fala do personagem misterioso de The Batman', 'matt-reeves-fala-do-personagem-misterioso-de-the-batman', 'matt-reeves-fala-do-personagem-misterioso-de-the-batman-poltronanerdsite', '/uploads/news/20220312021502_matt-reeves-fala-do-personagem-misterioso-de-the-batman-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/matt-reeves-fala-do-personagem-misterioso-de-the-batman-132229', NULL, NULL, 0, '2022-03-04', '2022-03-12 02:15:02', '2022-03-12 02:15:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(43, 30, 'Sonic 2 &8211; O Filme ganha trailer com referência a The Batman', 'sonic-2-8211-o-filme-ganha-trailer-com-referencia-a-the-batman', 'sonic-2-8211-o-filme-ganha-trailer-com-referencia-a-the-batman-poltronanerdsite', '/uploads/news/20220312021503_sonic-2-8211-o-filme-ganha-trailer-com-referencia-a-the-batman-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/sonic-2-o-filme-ganha-trailer-com-referencia-a-the-batman-132177', NULL, NULL, 0, '2022-03-02', '2022-03-12 02:15:03', '2022-03-12 02:15:03');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(44, 30, 'The Batman | Crítica', 'the-batman-critica', 'the-batman-critica-poltronanerdsite', '/uploads/news/20220312021503_the-batman-critica-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/site/criticas/the-batman-critica-132113', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:15:04', '2022-03-12 02:15:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(45, 30, 'The Batman I Escute o tema de Michael Giacchino para o longa', 'the-batman-i-escute-o-tema-de-michael-giacchino-para-o-longa', 'the-batman-i-escute-o-tema-de-michael-giacchino-para-o-longa-poltronanerdsite', '/uploads/news/20220312021504_the-batman-i-escute-o-tema-de-michael-giacchino-para-o-longa-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-i-escute-o-tema-de-michael-giacchino-para-o-longa-130935', NULL, NULL, 0, '2022-01-21', '2022-03-12 02:15:04', '2022-03-12 02:15:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(46, 30, 'The Batman | Kristen Stewart revela se faria o Coringa no filme', 'the-batman-kristen-stewart-revela-se-faria-o-coringa-no-filme', 'the-batman-kristen-stewart-revela-se-faria-o-coringa-no-filme-poltronanerdsite', '/uploads/news/20220312021504_the-batman-kristen-stewart-revela-se-faria-o-coringa-no-filme-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-kristen-stewart-revela-se-faria-o-coringa-no-filme-127870', NULL, NULL, 0, '2021-10-23', '2022-03-12 02:15:05', '2022-03-12 02:15:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(47, 30, 'The Batman ganha novos cartazes para o DC FanDome 2021', 'the-batman-ganha-novos-cartazes-para-o-dc-fandome-2021', 'the-batman-ganha-novos-cartazes-para-o-dc-fandome-2021-poltronanerdsite', '/uploads/news/20220312021505_the-batman-ganha-novos-cartazes-para-o-dc-fandome-2021-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-ganha-novos-cartazes-para-o-dc-fandome-2021-127525', NULL, NULL, 0, '2021-10-15', '2022-03-12 02:15:05', '2022-03-12 02:15:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(48, 30, 'The Batman | Novo teaser do filme destaca o Batsinal', 'the-batman-novo-teaser-do-filme-destaca-o-batsinal', 'the-batman-novo-teaser-do-filme-destaca-o-batsinal-poltronanerdsite', '/uploads/news/20220312021505_the-batman-novo-teaser-do-filme-destaca-o-batsinal-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-novo-teaser-do-filme-destaca-o-batsinal-127454', NULL, NULL, 0, '2021-10-14', '2022-03-12 02:15:05', '2022-03-12 02:15:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(49, 30, 'The Batman | HBO Max está desenvolvendo spin-off do Pinguim', 'the-batman-hbo-max-esta-desenvolvendo-spin-off-do-pinguim', 'the-batman-hbo-max-esta-desenvolvendo-spin-off-do-pinguim-poltronanerdsite', '/uploads/news/20220312021505_the-batman-hbo-max-esta-desenvolvendo-spin-off-do-pinguim-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-hbo-max-esta-desenvolvendo-spin-off-do-pinguim-125910', NULL, NULL, 0, '2021-09-18', '2022-03-12 02:15:06', '2022-03-12 02:15:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(50, 30, 'The Batman | Teaser mostra Batmóvel, Mulher-Gato e revela data do novo trailer', 'the-batman-teaser-mostra-batmovel-mulher-gato-e-revela-data-do-novo-trailer', 'the-batman-teaser-mostra-batmovel-mulher-gato-e-revela-data-do-novo-trailer-poltronanerdsite', '/uploads/news/20220312021506_the-batman-teaser-mostra-batmovel-mulher-gato-e-revela-data-do-novo-trailer-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-teaser-batmovel-mulher-gato-trailer-126033', NULL, NULL, 0, '2021-09-16', '2022-03-12 02:15:06', '2022-03-12 02:15:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(51, 30, 'The Batman | Robert Pattinson está insatisfeito com o papel', 'the-batman-robert-pattinson-esta-insatisfeito-com-o-papel', 'the-batman-robert-pattinson-esta-insatisfeito-com-o-papel-poltronanerdsite', '/uploads/news/20220312021506_the-batman-robert-pattinson-esta-insatisfeito-com-o-papel-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-robert-pattinson-esta-insatisfeito-com-o-papel-123803', NULL, NULL, 0, '2021-08-07', '2022-03-12 02:15:07', '2022-03-12 02:15:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(52, 30, 'The Batman | Robert Pattinson é visto no set em Liverpool', 'the-batman-robert-pattinson-e-visto-no-set-em-liverpool', 'the-batman-robert-pattinson-e-visto-no-set-em-liverpool-poltronanerdsite', '/uploads/news/20220312021507_the-batman-robert-pattinson-e-visto-no-set-em-liverpool-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-robert-pattinson-e-visto-no-set-em-liverpool-109918', NULL, NULL, 0, '2020-10-12', '2022-03-12 02:15:07', '2022-03-12 02:15:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(53, 30, 'The Batman tem data de lançamento adiada', 'the-batman-tem-data-de-lancamento-adiada', 'the-batman-tem-data-de-lancamento-adiada-poltronanerdsite', '/uploads/news/20220312021507_the-batman-tem-data-de-lancamento-adiada-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-tem-data-de-lancamento-adiada-109532', NULL, NULL, 0, '2020-10-06', '2022-03-12 02:15:08', '2022-03-12 02:15:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(54, 30, 'Robert Pattinson diz que poder estragar The Batman o anima', 'robert-pattinson-diz-que-poder-estragar-the-batman-o-anima', 'robert-pattinson-diz-que-poder-estragar-the-batman-o-anima-poltronanerdsite', '/uploads/news/20220312021508_robert-pattinson-diz-que-poder-estragar-the-batman-o-anima-poltronanerdsite.jpg', NULL, 'show', 'https://poltronanerd.com.br/filmes/the-batman-robert-pattinson-estragar-109050', NULL, NULL, 0, '2020-09-28', '2022-03-12 02:15:09', '2022-03-12 02:15:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(55, 8, 'THE BATMAN é bom? - Vale Crítica', 'the-batman-e-bom-vale-critica', 'the-batman-e-bom-vale-critica-superoitoyoutube', '/uploads/news/20220312021516_the-batman-e-bom-vale-critica-superoitoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=IS6NkxTsWAM', NULL, NULL, 0, '2022-03-06', '2022-03-12 02:15:16', '2022-03-12 02:15:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(56, 2, 'The Batman: EXCLUSIVO! Conversamos com Robert Pattinson, Matt Reeves e elenco', 'the-batman-exclusivo-conversamos-com-robert-pattinson-matt-reeves-e-elenco', 'the-batman-exclusivo-conversamos-com-robert-pattinson-matt-reeves-e-elenco-jovemnerdyoutube', '/uploads/news/20220312021521_the-batman-exclusivo-conversamos-com-robert-pattinson-matt-reeves-e-elenco-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=_EyDqnD4Jjo', NULL, NULL, 0, '2022-03-04', '2022-03-12 02:15:22', '2022-03-12 02:15:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(57, 2, 'The Batman: Vingança servida quente! (Trailer Oficial)', 'the-batman-vinganca-servida-quente-trailer-oficial', 'the-batman-vinganca-servida-quente-trailer-oficial-jovemnerdyoutube', '/uploads/news/20220312021525_the-batman-vinganca-servida-quente-trailer-oficial-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=sLkikrwkSSU', NULL, NULL, 0, '2021-10-20', '2022-03-12 02:15:25', '2022-03-12 02:15:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(58, 2, 'The Batman - Reaction e vingança!', 'the-batman-reaction-e-vinganca', 'the-batman-reaction-e-vinganca-jovemnerdyoutube', '/uploads/news/20220312021528_the-batman-reaction-e-vinganca-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=vl1dcQwuGow', NULL, NULL, 0, '2020-09-02', '2022-03-12 02:15:29', '2022-03-12 02:15:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(59, 2, 'Batman Arkham Origins - Eu sou BÁTIMA', 'batman-arkham-origins-eu-sou-batima', 'batman-arkham-origins-eu-sou-batima-jovemnerdyoutube', '/uploads/news/20220312021532_batman-arkham-origins-eu-sou-batima-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=K_X7MZP42p0', NULL, NULL, 0, '2014-02-17', '2022-03-12 02:15:33', '2022-03-12 02:15:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(60, 2, 'Batman Arkham City - I\'M BATMAN!', 'batman-arkham-city-im-batman', 'batman-arkham-city-im-batman-jovemnerdyoutube', '/uploads/news/20220312021539_batman-arkham-city-im-batman-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=vZVB5utuYAI', NULL, NULL, 0, '2011-10-31', '2022-03-12 02:15:39', '2022-03-12 02:15:39');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(61, 4, '(CRÍTICA) THE BATMAN: ASSISTIMOS E É BOM? | VEREDITO', 'critica-the-batman-assistimos-e-e-bom-veredito', 'critica-the-batman-assistimos-e-e-bom-veredito-omeleteyoutube', '/uploads/news/20220312021545_critica-the-batman-assistimos-e-e-bom-veredito-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=D8ospvqt_Pk', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:15:45', '2022-03-12 02:15:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(62, 4, 'THE BATMAN: 5 PERGUNTAS RESPONDIDAS COM SPOILERS (OMG!) | OTV', 'the-batman-5-perguntas-respondidas-com-spoilers-omg-otv', 'the-batman-5-perguntas-respondidas-com-spoilers-omg-otv-omeleteyoutube', '/uploads/news/20220312021549_the-batman-5-perguntas-respondidas-com-spoilers-omg-otv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Heh5gVCEU8U', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:15:49', '2022-03-12 02:15:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(63, 4, 'THE BATMAN: 5 PERGUNTAS RESPONDIDAS SEM SPOILERS | OTV', 'the-batman-5-perguntas-respondidas-sem-spoilers-otv', 'the-batman-5-perguntas-respondidas-sem-spoilers-otv-omeleteyoutube', '/uploads/news/20220312021553_the-batman-5-perguntas-respondidas-sem-spoilers-otv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=p1DussuIrtQ', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:15:54', '2022-03-12 02:15:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(64, 4, '10 EASTER EGGS NÃO VISTOS EM THE BATMAN (O 5 É DEMAIS!) | OMELISTA', '10-easter-eggs-nao-vistos-em-the-batman-o-5-e-demais-omelista', '10-easter-eggs-nao-vistos-em-the-batman-o-5-e-demais-omelista-omeleteyoutube', '/uploads/news/20220312021558_10-easter-eggs-nao-vistos-em-the-batman-o-5-e-demais-omelista-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=x1nyeFbrsA4', NULL, NULL, 0, '2022-03-10', '2022-03-12 02:15:58', '2022-03-12 02:15:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(65, 4, 'TRAILER THE BATMAN NA DC FANDOME 2021: O QUE ACHAMOS? | OmeleTV', 'trailer-the-batman-na-dc-fandome-2021-o-que-achamos-omeletv', 'trailer-the-batman-na-dc-fandome-2021-o-que-achamos-omeletv-omeleteyoutube', '/uploads/news/20220312021602_trailer-the-batman-na-dc-fandome-2021-o-que-achamos-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=SDivhxdAfIo', NULL, NULL, 0, '2021-10-18', '2022-03-12 02:16:03', '2022-03-12 02:16:03');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(66, 4, 'THE BATMAN: O QUE ESPERAMOS DO NOVO FILME DA DC? DESCUBRA! | OmeleTV', 'the-batman-o-que-esperamos-do-novo-filme-da-dc-descubra-omeletv', 'the-batman-o-que-esperamos-do-novo-filme-da-dc-descubra-omeletv-omeleteyoutube', '/uploads/news/20220312021606_the-batman-o-que-esperamos-do-novo-filme-da-dc-descubra-omeletv-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=rq8AMPJeLJk', NULL, NULL, 0, '2022-02-03', '2022-03-12 02:16:06', '2022-03-12 02:16:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(67, 4, 'THE BATMAN: O MAIOR QUE JÁ TIVEMOS ATÉ HOJE? | OTV AO VIVO', 'the-batman-o-maior-que-ja-tivemos-ate-hoje-otv-ao-vivo', 'the-batman-o-maior-que-ja-tivemos-ate-hoje-otv-ao-vivo-omeleteyoutube', '/uploads/news/20220312021609_the-batman-o-maior-que-ja-tivemos-ate-hoje-otv-ao-vivo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=luXJdV6707g', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:16:09', '2022-03-12 02:16:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(68, 4, 'THE BATMAN! UNIFORME DO HERÓI REVELADO | Live Omelete', 'the-batman-uniforme-do-heroi-revelado-live-omelete', 'the-batman-uniforme-do-heroi-revelado-live-omelete-omeleteyoutube', '/uploads/news/20220312021613_the-batman-uniforme-do-heroi-revelado-live-omelete-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=iCeHulhznVI', NULL, NULL, 0, '2020-02-14', '2022-03-12 02:16:13', '2022-03-12 02:16:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(69, 4, 'REVELADO! QUEM SÃO OS VILÕES DE THE BATMAN | Live', 'revelado-quem-sao-os-viloes-de-the-batman-live', 'revelado-quem-sao-os-viloes-de-the-batman-live-omeleteyoutube', '/uploads/news/20220312021618_revelado-quem-sao-os-viloes-de-the-batman-live-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wLscudiMiEE', NULL, NULL, 0, '2019-10-18', '2022-03-12 02:16:18', '2022-03-12 02:16:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(70, 4, 'QUEM É QUEM EM THE BATMAN', 'quem-e-quem-em-the-batman', 'quem-e-quem-em-the-batman-omeleteyoutube', '/uploads/news/20220312021620_quem-e-quem-em-the-batman-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=idC8w7or41Y', NULL, NULL, 0, '2020-01-28', '2022-03-12 02:16:21', '2022-03-12 02:16:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(71, 4, 'TUDO QUE SABEMOS SOBRE THE BATMAN (ATÉ AGORA)', 'tudo-que-sabemos-sobre-the-batman-ate-agora', 'tudo-que-sabemos-sobre-the-batman-ate-agora-omeleteyoutube', '/uploads/news/20220312021623_tudo-que-sabemos-sobre-the-batman-ate-agora-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=f7ys-ZB5C0M', NULL, NULL, 0, '2020-03-05', '2022-03-12 02:16:23', '2022-03-12 02:16:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(72, 4, 'FINALMENTE! QUEM É O VILÃO DE THE BATMAN', 'finalmente-quem-e-o-vilao-de-the-batman', 'finalmente-quem-e-o-vilao-de-the-batman-omeleteyoutube', '/uploads/news/20220312021628_finalmente-quem-e-o-vilao-de-the-batman-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ibTBuTSUtrE', NULL, NULL, 0, '2018-05-31', '2022-03-12 02:16:28', '2022-03-12 02:16:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(73, 4, 'BOMBA: The Batman sem Ben Affleck. E agora? | OmeleTV AO VIVO', 'bomba-the-batman-sem-ben-affleck-e-agora-omeletv-ao-vivo', 'bomba-the-batman-sem-ben-affleck-e-agora-omeletv-ao-vivo-omeleteyoutube', '/uploads/news/20220312021631_bomba-the-batman-sem-ben-affleck-e-agora-omeletv-ao-vivo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=AbERBAZjQCc', NULL, NULL, 0, '2017-01-31', '2022-03-12 02:16:32', '2022-03-12 02:16:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(74, 4, 'SEGREDOS DO TRAILER DE THE BATMAN! FiqueEmCasa Comigo', 'segredos-do-trailer-de-the-batman-fiqueemcasa-comigo', 'segredos-do-trailer-de-the-batman-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20220312021634_segredos-do-trailer-de-the-batman-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=MVLtgZP5ZXA', NULL, NULL, 0, '2020-08-28', '2022-03-12 02:16:35', '2022-03-12 02:16:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(75, 5, 'THE BATMAN: ANÁLISE COMPLETA [Com Spoilers]', 'the-batman-analise-completa-com-spoilers', 'the-batman-analise-completa-com-spoilers-einerdyoutube', '/uploads/news/20220312021644_the-batman-analise-completa-com-spoilers-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=UfTnBwRGUlU', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:16:44', '2022-03-12 02:16:44');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(76, 5, 'ASSISTI THE BATMAN - O FILME REALMENTE É BOM? [Sem Spoilers]', 'assisti-the-batman-o-filme-realmente-e-bom-sem-spoilers', 'assisti-the-batman-o-filme-realmente-e-bom-sem-spoilers-einerdyoutube', '/uploads/news/20220312021649_assisti-the-batman-o-filme-realmente-e-bom-sem-spoilers-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=8nr8e09OMkY', NULL, NULL, 0, '2022-03-02', '2022-03-12 02:16:50', '2022-03-12 02:16:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(77, 5, 'CENA PÓS-CRÉDITOS DE THE BATMAN TEM ALGO QUE VAI EXPLODIR CABEÇAS!', 'cena-pos-creditos-de-the-batman-tem-algo-que-vai-explodir-cabecas', 'cena-pos-creditos-de-the-batman-tem-algo-que-vai-explodir-cabecas-einerdyoutube', '/uploads/news/20220312021652_cena-pos-creditos-de-the-batman-tem-algo-que-vai-explodir-cabecas-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=i21UkpDpgU4', NULL, NULL, 0, '2022-03-06', '2022-03-12 02:16:53', '2022-03-12 02:16:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(78, 5, 'CONFIRMADO THE BATMAN 2 E VÁRIAS SÉRIES! - VEJA O QUE VEM POR AÍ', 'confirmado-the-batman-2-e-varias-series-veja-o-que-vem-por-ai', 'confirmado-the-batman-2-e-varias-series-veja-o-que-vem-por-ai-einerdyoutube', '/uploads/news/20220312021656_confirmado-the-batman-2-e-varias-series-veja-o-que-vem-por-ai-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=qya8-SPsQhM', NULL, NULL, 0, '2022-03-05', '2022-03-12 02:16:57', '2022-03-12 02:16:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(79, 5, 'THE BATMAN VS. CAVALEIRO DAS TREVAS, QUEM FOI O MELHOR BATMAN?', 'the-batman-vs-cavaleiro-das-trevas-quem-foi-o-melhor-batman', 'the-batman-vs-cavaleiro-das-trevas-quem-foi-o-melhor-batman-einerdyoutube', '/uploads/news/20220312021701_the-batman-vs-cavaleiro-das-trevas-quem-foi-o-melhor-batman-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=CG3R3WyQiVY', NULL, NULL, 0, '2022-03-04', '2022-03-12 02:17:02', '2022-03-12 02:17:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(80, 5, 'THE BATMAN - A CORTE DAS CORUJAS ESTÁ POR TRÁS DE TUDO E EU POSSO PROVAR!', 'the-batman-a-corte-das-corujas-esta-por-tras-de-tudo-e-eu-posso-provar', 'the-batman-a-corte-das-corujas-esta-por-tras-de-tudo-e-eu-posso-provar-einerdyoutube', '/uploads/news/20220312021706_the-batman-a-corte-das-corujas-esta-por-tras-de-tudo-e-eu-posso-provar-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=KUtjSjPHfgg', NULL, NULL, 0, '2022-02-19', '2022-03-12 02:17:07', '2022-03-12 02:17:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(81, 5, 'TRAILER THE BATMAN: ANÁLISE SUPER COMPLETA (fizemos a investigação do Batman)', 'trailer-the-batman-analise-super-completa-fizemos-a-investigacao-do-batman', 'trailer-the-batman-analise-super-completa-fizemos-a-investigacao-do-batman-einerdyoutube', '/uploads/news/20220312021710_trailer-the-batman-analise-super-completa-fizemos-a-investigacao-do-batman-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=78Sg91d4Vi8', NULL, NULL, 0, '2021-10-17', '2022-03-12 02:17:11', '2022-03-12 02:17:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(82, 5, 'A FAMÍLIA WAYNE ERA CORRUPTA? - ANÁLISE COMPLETA THE BATMAN TRAILER 3', 'a-familia-wayne-era-corrupta-analise-completa-the-batman-trailer-3', 'a-familia-wayne-era-corrupta-analise-completa-the-batman-trailer-3-einerdyoutube', '/uploads/news/20220312021715_a-familia-wayne-era-corrupta-analise-completa-the-batman-trailer-3-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=eohzSne1nHk', NULL, NULL, 0, '2021-12-28', '2022-03-12 02:17:15', '2022-03-12 02:17:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(83, 5, 'THE BATMAN É SEQUÊNCIA DIRETA DE CORINGA E EU POSSO PROVAR!', 'the-batman-e-sequencia-direta-de-coringa-e-eu-posso-provar', 'the-batman-e-sequencia-direta-de-coringa-e-eu-posso-provar-einerdyoutube', '/uploads/news/20220312021720_the-batman-e-sequencia-direta-de-coringa-e-eu-posso-provar-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=RHXyeD87Yck', NULL, NULL, 0, '2021-10-28', '2022-03-12 02:17:21', '2022-03-12 02:17:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(84, 5, 'THE BATMAN: ANÁLISE COMPLETA DO TRAILER', 'the-batman-analise-completa-do-trailer', 'the-batman-analise-completa-do-trailer-einerdyoutube', '/uploads/news/20220312021725_the-batman-analise-completa-do-trailer-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=cfpIlgjzPjA', NULL, NULL, 0, '2020-08-24', '2022-03-12 02:17:25', '2022-03-12 02:17:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(85, 5, 'THE BATMAN - ROBERT PATTINSON PODE SER O MELHOR BATMAN DE TODOS OS TEMPOS', 'the-batman-robert-pattinson-pode-ser-o-melhor-batman-de-todos-os-tempos', 'the-batman-robert-pattinson-pode-ser-o-melhor-batman-de-todos-os-tempos-einerdyoutube', '/uploads/news/20220312021728_the-batman-robert-pattinson-pode-ser-o-melhor-batman-de-todos-os-tempos-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wl5B35LKVaE', NULL, NULL, 0, '2020-08-26', '2022-03-12 02:17:28', '2022-03-12 02:17:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(86, 5, 'THE BATMAN ESTÁ FORA DO UNIVERSO COMPARTILHADO DC', 'the-batman-esta-fora-do-universo-compartilhado-dc', 'the-batman-esta-fora-do-universo-compartilhado-dc-einerdyoutube', '/uploads/news/20220312021731_the-batman-esta-fora-do-universo-compartilhado-dc-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=oE2q009xo1M', NULL, NULL, 0, '2019-11-03', '2022-03-12 02:17:32', '2022-03-12 02:17:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(87, 5, 'THE BATMAN - PREVISÕES PARA O FILME OU TRILOGIA', 'the-batman-previsoes-para-o-filme-ou-trilogia', 'the-batman-previsoes-para-o-filme-ou-trilogia-einerdyoutube', '/uploads/news/20220312021736_the-batman-previsoes-para-o-filme-ou-trilogia-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Q5EKbHeDGyE', NULL, NULL, 0, '2020-09-05', '2022-03-12 02:17:36', '2022-03-12 02:17:36');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(88, 6, 'EU VI E SURTEI! THE BATMAN É SIMPLESMENTE O MELHOR FILME DA DC!', 'eu-vi-e-surtei-the-batman-e-simplesmente-o-melhor-filme-da-dc', 'eu-vi-e-surtei-the-batman-e-simplesmente-o-melhor-filme-da-dc-nerdlandyoutube', '/uploads/news/20220312021741_eu-vi-e-surtei-the-batman-e-simplesmente-o-melhor-filme-da-dc-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=kOlkdd_PGTo', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:17:42', '2022-03-12 02:17:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(89, 6, 'ENTENDA O FINAL DO FILME THE BATMAN E O CORINGA LIGADO DIRETO AO BATMAN! FINAL THE BATMAN EXPLICADO!', 'entenda-o-final-do-filme-the-batman-e-o-coringa-ligado-direto-ao-batman-final-the-batman-explicado', 'entenda-o-final-do-filme-the-batman-e-o-coringa-ligado-direto-ao-batman-final-the-batman-explicado-nerdlandyoutube', '/uploads/news/20220312021744_entenda-o-final-do-filme-the-batman-e-o-coringa-ligado-direto-ao-batman-final-the-batman-explicado-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ewW1AnDwtP8', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:17:45', '2022-03-12 02:17:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(90, 6, 'EXPLICADO! THE BATMAN TRAILER 2 OFICIAL! CHARADA, PINGUIM, MULHER GATO E MUITO MAIS!', 'explicado-the-batman-trailer-2-oficial-charada-pinguim-mulher-gato-e-muito-mais', 'explicado-the-batman-trailer-2-oficial-charada-pinguim-mulher-gato-e-muito-mais-nerdlandyoutube', '/uploads/news/20220312021749_explicado-the-batman-trailer-2-oficial-charada-pinguim-mulher-gato-e-muito-mais-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=LmnEo5z4MCI', NULL, NULL, 0, '2021-10-17', '2022-03-12 02:17:49', '2022-03-12 02:17:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(91, 6, 'THE BATMAN TRAILER OFICIAL LEGENDADO', 'the-batman-trailer-oficial-legendado', 'the-batman-trailer-oficial-legendado-nerdlandyoutube', '/uploads/news/20220312021752_the-batman-trailer-oficial-legendado-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=z2URKRqzMI4', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:17:53', '2022-03-12 02:17:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(92, 6, 'SAIU! PRIMEIRO TEASER TRAILER THE BATMAN E TODOS OS SEGREDOS ESCONDIDOS', 'saiu-primeiro-teaser-trailer-the-batman-e-todos-os-segredos-escondidos', 'saiu-primeiro-teaser-trailer-the-batman-e-todos-os-segredos-escondidos-nerdlandyoutube', '/uploads/news/20220312021758_saiu-primeiro-teaser-trailer-the-batman-e-todos-os-segredos-escondidos-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=RV1KaH4UoGw', NULL, NULL, 0, '2020-02-14', '2022-03-12 02:17:58', '2022-03-12 02:17:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(93, 6, '38 SEGREDOS TRAILER THE BATMAN ANALISE COMPLETA', '38-segredos-trailer-the-batman-analise-completa', '38-segredos-trailer-the-batman-analise-completa-nerdlandyoutube', '/uploads/news/20220312021800_38-segredos-trailer-the-batman-analise-completa-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Mv2t5V5DsII', NULL, NULL, 0, '2020-08-24', '2022-03-12 02:18:01', '2022-03-12 02:18:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(94, 6, 'MAIORES DIFERENÇAS ENTRE O NOVO BATMAN DO ROBERT PATTINSON E BATMAN DO BEN AFFLECK (LIGA DA JUSTIÇA)', 'maiores-diferencas-entre-o-novo-batman-do-robert-pattinson-e-batman-do-ben-affleck-liga-da-justica', 'maiores-diferencas-entre-o-novo-batman-do-robert-pattinson-e-batman-do-ben-affleck-liga-da-justica-nerdlandyoutube', '/uploads/news/20220312021805_maiores-diferencas-entre-o-novo-batman-do-robert-pattinson-e-batman-do-ben-affleck-liga-da-justica-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=MdHy1FHtPYc', NULL, NULL, 0, '2022-03-02', '2022-03-12 02:18:06', '2022-03-12 02:18:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(95, 6, 'VILÃO DO FILME THE BATMAN VAI GANHAR SÉRIE! Shorts', 'vilao-do-filme-the-batman-vai-ganhar-serie-shorts', 'vilao-do-filme-the-batman-vai-ganhar-serie-shorts-nerdlandyoutube', '/uploads/news/20220312021810_vilao-do-filme-the-batman-vai-ganhar-serie-shorts-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wDvWYWQrQN8', NULL, NULL, 0, '2021-09-18', '2022-03-12 02:18:10', '2022-03-12 02:18:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(96, 6, 'EXPLICADO! TRAILER THE FLASH! SUPERGIRL, BATMAN E FLASHPOINT!', 'explicado-trailer-the-flash-supergirl-batman-e-flashpoint', 'explicado-trailer-the-flash-supergirl-batman-e-flashpoint-nerdlandyoutube', '/uploads/news/20220312021815_explicado-trailer-the-flash-supergirl-batman-e-flashpoint-nerdlandyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=RhRR7-9oVdo', NULL, NULL, 0, '2021-10-17', '2022-03-12 02:18:15', '2022-03-12 02:18:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(97, 9, 'FUTURO DE THE BATMAN | 5 NOVIDADES QUENTES', 'futuro-de-the-batman-5-novidades-quentes', 'futuro-de-the-batman-5-novidades-quentes-cinemacomrapadurayoutube', '/uploads/news/20220312021821_futuro-de-the-batman-5-novidades-quentes-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=gfHklYX1AB8', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:18:21', '2022-03-12 02:18:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(98, 9, 'CRÍTICA | THE BATMAN É FANTÁSTICO! (Sem Spoilers)', 'critica-the-batman-e-fantastico-sem-spoilers', 'critica-the-batman-e-fantastico-sem-spoilers-cinemacomrapadurayoutube', '/uploads/news/20220312021824_critica-the-batman-e-fantastico-sem-spoilers-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=4iIZ08MVQ90', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:18:25', '2022-03-12 02:18:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(99, 9, 'THE BATMAN | RAIO-X DO TRAILER 2', 'the-batman-raio-x-do-trailer-2', 'the-batman-raio-x-do-trailer-2-cinemacomrapadurayoutube', '/uploads/news/20220312021829_the-batman-raio-x-do-trailer-2-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=B57SIrrQppA', NULL, NULL, 0, '2021-10-16', '2022-03-12 02:18:29', '2022-03-12 02:18:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(100, 9, 'OS ACERTOS DE THE BATMAN | COM SPOILERS', 'os-acertos-de-the-batman-com-spoilers', 'os-acertos-de-the-batman-com-spoilers-cinemacomrapadurayoutube', '/uploads/news/20220312021833_os-acertos-de-the-batman-com-spoilers-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=udnEs-qvvjk', NULL, NULL, 0, '2022-03-02', '2022-03-12 02:18:33', '2022-03-12 02:18:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(101, 9, 'FILMAGENS DE THE BATMAN COMEÇARAM! QUEM ESTÁ NO ELENCO?', 'filmagens-de-the-batman-comecaram-quem-esta-no-elenco', 'filmagens-de-the-batman-comecaram-quem-esta-no-elenco-cinemacomrapadurayoutube', '/uploads/news/20220312021837_filmagens-de-the-batman-comecaram-quem-esta-no-elenco-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=pfmdqq-JmN8', NULL, NULL, 0, '2020-01-28', '2022-03-12 02:18:38', '2022-03-12 02:18:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(102, 9, 'THE BATMAN: 10 ATORES PARA VIVER O HERÓI!', 'the-batman-10-atores-para-viver-o-heroi', 'the-batman-10-atores-para-viver-o-heroi-cinemacomrapadurayoutube', '/uploads/news/20220312021842_the-batman-10-atores-para-viver-o-heroi-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=_d6zZtqPz4w', NULL, NULL, 0, '2018-09-08', '2022-03-12 02:18:43', '2022-03-12 02:18:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(103, 9, 'THE BATMAN | VEJA O NOVO VISUAL DO BATMAN DE ROBERT PATTINSON', 'the-batman-veja-o-novo-visual-do-batman-de-robert-pattinson', 'the-batman-veja-o-novo-visual-do-batman-de-robert-pattinson-cinemacomrapadurayoutube', '/uploads/news/20220312021846_the-batman-veja-o-novo-visual-do-batman-de-robert-pattinson-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=8BuZ4IwLIgU', NULL, NULL, 0, '2020-02-14', '2022-03-12 02:18:46', '2022-03-12 02:18:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(104, 9, 'THE BATMAN VAI GANHAR SÉRIE NO STREAMING', 'the-batman-vai-ganhar-serie-no-streaming', 'the-batman-vai-ganhar-serie-no-streaming-cinemacomrapadurayoutube', '/uploads/news/20220312021849_the-batman-vai-ganhar-serie-no-streaming-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=d_3TIZVm0ic', NULL, NULL, 0, '2020-07-15', '2022-03-12 02:18:51', '2022-03-12 02:18:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(105, 9, 'CENAS INÉDITAS DA DC 2022! THE FLASH, ADÃO NEGRO, THE BATMAN E AQUAMAN 2!', 'cenas-ineditas-da-dc-2022-the-flash-adao-negro-the-batman-e-aquaman-2', 'cenas-ineditas-da-dc-2022-the-flash-adao-negro-the-batman-e-aquaman-2-cinemacomrapadurayoutube', '/uploads/news/20220312021854_cenas-ineditas-da-dc-2022-the-flash-adao-negro-the-batman-e-aquaman-2-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Vyfy7eFKeCc', NULL, NULL, 0, '2022-02-11', '2022-03-12 02:18:54', '2022-03-12 02:18:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(106, 9, 'ANÁLISE DO PRIMEIRO TRAILER DE \'THE BATMAN\'', 'analise-do-primeiro-trailer-de-the-batman', 'analise-do-primeiro-trailer-de-the-batman-cinemacomrapadurayoutube', '/uploads/news/20220312021856_analise-do-primeiro-trailer-de-the-batman-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=kQNyGCNatHo', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:18:57', '2022-03-12 02:18:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(107, 9, 'THE BATMAN: QUEM SERÃO OS VILÕES? ESCALAMOS O ELENCO!!', 'the-batman-quem-serao-os-viloes-escalamos-o-elenco', 'the-batman-quem-serao-os-viloes-escalamos-o-elenco-cinemacomrapadurayoutube', '/uploads/news/20220312021901_the-batman-quem-serao-os-viloes-escalamos-o-elenco-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=BTKMGpgLhLg', NULL, NULL, 0, '2019-06-27', '2022-03-12 02:19:01', '2022-03-12 02:19:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(108, 9, 'THE BATMAN, o que está acontecendo?', 'the-batman-o-que-esta-acontecendo', 'the-batman-o-que-esta-acontecendo-cinemacomrapadurayoutube', '/uploads/news/20220312021907_the-batman-o-que-esta-acontecendo-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=iQs5QuE9uGg', NULL, NULL, 0, '2017-03-14', '2022-03-12 02:19:08', '2022-03-12 02:19:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(109, 9, 'DCFANDOME TRAILERS DE THE BATMAN, SNYDERCUT E O ESQUADRÃO SUICIDA', 'dcfandome-trailers-de-the-batman-snydercut-e-o-esquadrao-suicida', 'dcfandome-trailers-de-the-batman-snydercut-e-o-esquadrao-suicida-cinemacomrapadurayoutube', '/uploads/news/20220312021910_dcfandome-trailers-de-the-batman-snydercut-e-o-esquadrao-suicida-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=gyKbYlHBBdI', NULL, NULL, 0, '2020-08-21', '2022-03-12 02:19:10', '2022-03-12 02:19:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(110, 9, 'THE BATMAN TERÁ NOVA VERSÃO DO CORINGA?', 'the-batman-tera-nova-versao-do-coringa', 'the-batman-tera-nova-versao-do-coringa-cinemacomrapadurayoutube', '/uploads/news/20220312021913_the-batman-tera-nova-versao-do-coringa-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=hsFubwAo6bU', NULL, NULL, 0, '2020-06-13', '2022-03-12 02:19:13', '2022-03-12 02:19:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(111, 9, 'TRETA NA DC!!! DIRETOR THE BATMAN x WARNER (de novo )', 'treta-na-dc-diretor-the-batman-x-warner-de-novo', 'treta-na-dc-diretor-the-batman-x-warner-de-novo-cinemacomrapadurayoutube', '/uploads/news/20220312021915_treta-na-dc-diretor-the-batman-x-warner-de-novo-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=lWs71_2KkuY', NULL, NULL, 0, '2021-08-31', '2022-03-12 02:19:16', '2022-03-12 02:19:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(112, 9, 'BEN AFFLECK ESTÁ FORA DE VEZ DE THE BATMAN?', 'ben-affleck-esta-fora-de-vez-de-the-batman', 'ben-affleck-esta-fora-de-vez-de-the-batman-cinemacomrapadurayoutube', '/uploads/news/20220312021919_ben-affleck-esta-fora-de-vez-de-the-batman-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=cZ_nO7tAB_8', NULL, NULL, 0, '2018-09-06', '2022-03-12 02:19:19', '2022-03-12 02:19:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(113, 10, 'THE BATMAN Trailer 2 - Qual O Plano do Charada?', 'the-batman-trailer-2-qual-o-plano-do-charada', 'the-batman-trailer-2-qual-o-plano-do-charada-caiqueizotonyoutube', '/uploads/news/20220312021925_the-batman-trailer-2-qual-o-plano-do-charada-caiqueizotonyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QaEmPuDOusU', NULL, NULL, 0, '2021-10-20', '2022-03-12 02:19:26', '2022-03-12 02:19:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(114, 10, 'THE BATMAN | Análise do Trailer!', 'the-batman-analise-do-trailer', 'the-batman-analise-do-trailer-caiqueizotonyoutube', '/uploads/news/20220312021929_the-batman-analise-do-trailer-caiqueizotonyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=YdbISjPGMZM', NULL, NULL, 0, '2020-08-25', '2022-03-12 02:19:29', '2022-03-12 02:19:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(115, 12, 'CRÍTICA: THE BATMAN EXPLICADO COM SPOILERS PELA TIA DO BÁTIMA EM PESSOA', 'critica-the-batman-explicado-com-spoilers-pela-tia-do-batima-em-pessoa', 'critica-the-batman-explicado-com-spoilers-pela-tia-do-batima-em-pessoa-quatrocoisasyoutube', '/uploads/news/20220312021937_critica-the-batman-explicado-com-spoilers-pela-tia-do-batima-em-pessoa-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=XqGUifqbS7g', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:19:37', '2022-03-12 02:19:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(116, 12, 'PRIMEIRAS CRÍTICAS: O QUE ESTÃO FALANDO DE THE BATMAN?', 'primeiras-criticas-o-que-estao-falando-de-the-batman', 'primeiras-criticas-o-que-estao-falando-de-the-batman-quatrocoisasyoutube', '/uploads/news/20220312021941_primeiras-criticas-o-que-estao-falando-de-the-batman-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=VpvGe1aGbAs', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:19:41', '2022-03-12 02:19:41');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(117, 12, 'THE BATMAN É BARRADO NA CENSURA DO REINO UNIDO - E AGORA?', 'the-batman-e-barrado-na-censura-do-reino-unido-e-agora', 'the-batman-e-barrado-na-censura-do-reino-unido-e-agora-quatrocoisasyoutube', '/uploads/news/20220312021943_the-batman-e-barrado-na-censura-do-reino-unido-e-agora-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=xcJ3t9_Bw98', NULL, NULL, 0, '2022-02-26', '2022-03-12 02:19:43', '2022-03-12 02:19:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(118, 12, 'PRÉ ESTREIA DE "THE BATMAN" DERRUBOU SITE E ESGOTOU EM POUCOS MINUTOS', 'pre-estreia-de-the-batman-derrubou-site-e-esgotou-em-poucos-minutos', 'pre-estreia-de-the-batman-derrubou-site-e-esgotou-em-poucos-minutos-quatrocoisasyoutube', '/uploads/news/20220312021947_pre-estreia-de-the-batman-derrubou-site-e-esgotou-em-poucos-minutos-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=2C__-rHWNFg', NULL, NULL, 0, '2022-02-10', '2022-03-12 02:19:47', '2022-03-12 02:19:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(119, 12, 'FALANDO SOBRE THE BATMAN (SEM SPOILERS) TÁ LIBERADO ALMOÇAR (Segunda 28/02) - STREAM AO VIVO', 'falando-sobre-the-batman-sem-spoilers-ta-liberado-almocar-segunda-2802-stream-ao-vivo', 'falando-sobre-the-batman-sem-spoilers-ta-liberado-almocar-segunda-2802-stream-ao-vivo-quatrocoisasyoutube', '/uploads/news/20220312021952_falando-sobre-the-batman-sem-spoilers-ta-liberado-almocar-segunda-2802-stream-ao-vivo-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5gxaLxG8dHs', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:19:52', '2022-03-12 02:19:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(120, 12, 'ANÁLISE TRAILER DE THE BATMAN!', 'analise-trailer-de-the-batman', 'analise-trailer-de-the-batman-quatrocoisasyoutube', '/uploads/news/20220312021954_analise-trailer-de-the-batman-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Xnzkt4JwBVk', NULL, NULL, 0, '2021-10-17', '2022-03-12 02:19:55', '2022-03-12 02:19:55');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(121, 12, 'NÃO ASSISTE SEM VER: RECAP DE TODOS OS SPOTS DE THE BATMAN - O QUE SABEMOS ATÉ AQUI!', 'nao-assiste-sem-ver-recap-de-todos-os-spots-de-the-batman-o-que-sabemos-ate-aqui', 'nao-assiste-sem-ver-recap-de-todos-os-spots-de-the-batman-o-que-sabemos-ate-aqui-quatrocoisasyoutube', '/uploads/news/20220312021958_nao-assiste-sem-ver-recap-de-todos-os-spots-de-the-batman-o-que-sabemos-ate-aqui-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=tUZShiut9d8', NULL, NULL, 0, '2022-02-25', '2022-03-12 02:19:58', '2022-03-12 02:19:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(122, 12, 'THE BATMAN - TRAILER 3 REAÇÃO', 'the-batman-trailer-3-reacao', 'the-batman-trailer-3-reacao-quatrocoisasyoutube', '/uploads/news/20220312022001_the-batman-trailer-3-reacao-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=LGzxeAH42wA', NULL, NULL, 0, '2021-12-27', '2022-03-12 02:20:02', '2022-03-12 02:20:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(123, 12, 'MARVEL, POR QUE CHORAS? THE BATMAN É LIBERADO NA CHINA', 'marvel-por-que-choras-the-batman-e-liberado-na-china', 'marvel-por-que-choras-the-batman-e-liberado-na-china-quatrocoisasyoutube', '/uploads/news/20220312022005_marvel-por-que-choras-the-batman-e-liberado-na-china-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=6VNyQ33YWew', NULL, NULL, 0, '2022-02-18', '2022-03-12 02:20:05', '2022-03-12 02:20:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(124, 12, 'MATT REEVES RECUSOU O ROTEIRO DE BEN AFFLECK PARA THE BATMAN', 'matt-reeves-recusou-o-roteiro-de-ben-affleck-para-the-batman', 'matt-reeves-recusou-o-roteiro-de-ben-affleck-para-the-batman-quatrocoisasyoutube', '/uploads/news/20220312022007_matt-reeves-recusou-o-roteiro-de-ben-affleck-para-the-batman-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=vX-aIG7RDpg', NULL, NULL, 0, '2022-01-27', '2022-03-12 02:20:08', '2022-03-12 02:20:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(125, 12, 'BOMBA! DIRETOR CONFIRMA CORINGA EM THE BATMAN!', 'bomba-diretor-confirma-coringa-em-the-batman', 'bomba-diretor-confirma-coringa-em-the-batman-quatrocoisasyoutube', '/uploads/news/20220312022011_bomba-diretor-confirma-coringa-em-the-batman-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QTyeehyH65I', NULL, NULL, 0, '2022-03-05', '2022-03-12 02:20:12', '2022-03-12 02:20:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(126, 12, 'THE BATMAN ESQUENTA A FANDOME! BATSINAL E BAT-ALVORADA', 'the-batman-esquenta-a-fandome-batsinal-e-bat-alvorada', 'the-batman-esquenta-a-fandome-batsinal-e-bat-alvorada-quatrocoisasyoutube', '/uploads/news/20220312022015_the-batman-esquenta-a-fandome-batsinal-e-bat-alvorada-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=C2KkX-VMyto', NULL, NULL, 0, '2021-10-14', '2022-03-12 02:20:16', '2022-03-12 02:20:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(127, 12, 'EXISTE SUPERMAN EM "THE BATMAN"? NOVELIZAÇÃO DIZ QUE SIM!', 'existe-superman-em-the-batman-novelizacao-diz-que-sim', 'existe-superman-em-the-batman-novelizacao-diz-que-sim-quatrocoisasyoutube', '/uploads/news/20220312022019_existe-superman-em-the-batman-novelizacao-diz-que-sim-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=fCjEAJI0BjM', NULL, NULL, 0, '2022-02-09', '2022-03-12 02:20:21', '2022-03-12 02:20:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(128, 12, 'FÃS AINDA NÃO CONSEGUIRAM SUPERAR O TRAILER DE THE BATMAN DUBLADO!', 'fas-ainda-nao-conseguiram-superar-o-trailer-de-the-batman-dublado', 'fas-ainda-nao-conseguiram-superar-o-trailer-de-the-batman-dublado-quatrocoisasyoutube', '/uploads/news/20220312022023_fas-ainda-nao-conseguiram-superar-o-trailer-de-the-batman-dublado-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=sG5qpPYx-H8', NULL, NULL, 0, '2021-11-03', '2022-03-12 02:20:23', '2022-03-12 02:20:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(129, 12, 'THE BATMAN TERÁ QUASE 3 HORAS DE DURAÇÃO, SEGUNDO IMDB. É MUITO?', 'the-batman-tera-quase-3-horas-de-duracao-segundo-imdb-e-muito', 'the-batman-tera-quase-3-horas-de-duracao-segundo-imdb-e-muito-quatrocoisasyoutube', '/uploads/news/20220312022027_the-batman-tera-quase-3-horas-de-duracao-segundo-imdb-e-muito-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=l_YLSIrW-P4', NULL, NULL, 0, '2022-01-18', '2022-03-12 02:20:28', '2022-03-12 02:20:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(130, 12, 'THE BATMAN VEM AÍ E VAI CHEGAR ATROPELANDO', 'the-batman-vem-ai-e-vai-chegar-atropelando', 'the-batman-vem-ai-e-vai-chegar-atropelando-quatrocoisasyoutube', '/uploads/news/20220312022032_the-batman-vem-ai-e-vai-chegar-atropelando-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=w30qDkdSsL8', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:20:33', '2022-03-12 02:20:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(131, 12, 'REAÇÃO: PAINEL E TRAILER DE THE BATMAN - AO VIVO DA FANDOME', 'reacao-painel-e-trailer-de-the-batman-ao-vivo-da-fandome', 'reacao-painel-e-trailer-de-the-batman-ao-vivo-da-fandome-quatrocoisasyoutube', '/uploads/news/20220312022038_reacao-painel-e-trailer-de-the-batman-ao-vivo-da-fandome-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=uREIe-EI1OA', NULL, NULL, 0, '2021-10-17', '2022-03-12 02:20:38', '2022-03-12 02:20:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(132, 14, 'POLÊMICA: THE BATMAN É O MELHOR FILME DO BATMAN?', 'polemica-the-batman-e-o-melhor-filme-do-batman', 'polemica-the-batman-e-o-melhor-filme-do-batman-nerdrabugentoyoutube', '/uploads/news/20220312022045_polemica-the-batman-e-o-melhor-filme-do-batman-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=F93HvdzoPt8', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:20:46', '2022-03-12 02:20:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(133, 14, 'DEZ ERROS INCRÍVEIS EM THE BATMAN QUE VOCÊ NÃO PERCEBEU! - CORTES DO RABUGENTO', 'dez-erros-incriveis-em-the-batman-que-voce-nao-percebeu-cortes-do-rabugento', 'dez-erros-incriveis-em-the-batman-que-voce-nao-percebeu-cortes-do-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022050_dez-erros-incriveis-em-the-batman-que-voce-nao-percebeu-cortes-do-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=NAbnDUTD_lA', NULL, NULL, 0, '2022-03-11', '2022-03-12 02:20:50', '2022-03-12 02:20:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(134, 14, 'THE BATMAN - REAÇÃO AO TRAILER DA DC FANDOME -  NERD RABUGENTO', 'the-batman-reacao-ao-trailer-da-dc-fandome-nerd-rabugento', 'the-batman-reacao-ao-trailer-da-dc-fandome-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022055_the-batman-reacao-ao-trailer-da-dc-fandome-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=NCJMcMxTluQ', NULL, NULL, 0, '2021-10-16', '2022-03-12 02:20:55', '2022-03-12 02:20:55');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(135, 14, 'TUDO DE ERRADO EM THE BATMAN!- AO VIVO - NERD RABUGENTO', 'tudo-de-errado-em-the-batman-ao-vivo-nerd-rabugento', 'tudo-de-errado-em-the-batman-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022058_tudo-de-errado-em-the-batman-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Z8scj-4LnoY', NULL, NULL, 0, '2022-03-10', '2022-03-12 02:20:59', '2022-03-12 02:20:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(136, 14, 'THE BATMAN - FINAL EXPLICADO - NERD RABUGENTO', 'the-batman-final-explicado-nerd-rabugento', 'the-batman-final-explicado-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022102_the-batman-final-explicado-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=FVqb8SpBplI', NULL, NULL, 0, '2022-03-05', '2022-03-12 02:21:02', '2022-03-12 02:21:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(137, 14, 'THE BATMAN FLOPOU NAS BILHETERIAS?- AO VIVO - NERD RABUGENTO', 'the-batman-flopou-nas-bilheterias-ao-vivo-nerd-rabugento', 'the-batman-flopou-nas-bilheterias-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022107_the-batman-flopou-nas-bilheterias-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=BfWwCIPvbTY', NULL, NULL, 0, '2022-03-06', '2022-03-12 02:21:07', '2022-03-12 02:21:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(138, 14, 'THE BATMAN: A DC NÃO DEIXA VAZAR NADA! - AO VIVO - NERD RABUGENTO', 'the-batman-a-dc-nao-deixa-vazar-nada-ao-vivo-nerd-rabugento', 'the-batman-a-dc-nao-deixa-vazar-nada-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022109_the-batman-a-dc-nao-deixa-vazar-nada-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=znthVRPxgmY', NULL, NULL, 0, '2022-02-01', '2022-03-12 02:21:10', '2022-03-12 02:21:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(139, 14, 'THE BATMAN: FINAL EXPLICADO! - AO VIVO - NERD RABUGENTO', 'the-batman-final-explicado-ao-vivo-nerd-rabugento', 'the-batman-final-explicado-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022113_the-batman-final-explicado-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=4LHXEl_K6A4', NULL, NULL, 0, '2022-03-04', '2022-03-12 02:21:14', '2022-03-12 02:21:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(140, 14, 'EU TENHO CERTEZA DE QUE THE BATMAN VAI FAZER MUITO DINHEIRO! - AO VIVO DE DOMINGO - NERD RABUGENTO', 'eu-tenho-certeza-de-que-the-batman-vai-fazer-muito-dinheiro-ao-vivo-de-domingo-nerd-rabugento', 'eu-tenho-certeza-de-que-the-batman-vai-fazer-muito-dinheiro-ao-vivo-de-domingo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022117_eu-tenho-certeza-de-que-the-batman-vai-fazer-muito-dinheiro-ao-vivo-de-domingo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=fM32oqBqRvk', NULL, NULL, 0, '2022-02-27', '2022-03-12 02:21:17', '2022-03-12 02:21:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(141, 14, 'THE BATMAN E O COMPORTAMENTO DE MANADA - AO VIVO - NERD RABUGENTO', 'the-batman-e-o-comportamento-de-manada-ao-vivo-nerd-rabugento', 'the-batman-e-o-comportamento-de-manada-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022119_the-batman-e-o-comportamento-de-manada-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=vVsSArbM36I', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:21:20', '2022-03-12 02:21:20');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(142, 14, 'E SE THE BATMAN FOSSE DA MARVEL? - AO VIVO - NERD RABUGENTO', 'e-se-the-batman-fosse-da-marvel-ao-vivo-nerd-rabugento', 'e-se-the-batman-fosse-da-marvel-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022123_e-se-the-batman-fosse-da-marvel-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=fk_iZA_mkag', NULL, NULL, 0, '2022-03-08', '2022-03-12 02:21:24', '2022-03-12 02:21:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(143, 14, 'EU ACHEI THE BATMAN MUITO MELHOR QUE HOMEM-ARANHA: SEM VOLTA PARA CASA! - AO VIVO - NERD RABUGENTO', 'eu-achei-the-batman-muito-melhor-que-homem-aranha-sem-volta-para-casa-ao-vivo-nerd-rabugento', 'eu-achei-the-batman-muito-melhor-que-homem-aranha-sem-volta-para-casa-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022127_eu-achei-the-batman-muito-melhor-que-homem-aranha-sem-volta-para-casa-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-lnCMQd59gY', NULL, NULL, 0, '2022-03-02', '2022-03-12 02:21:27', '2022-03-12 02:21:27');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(144, 14, 'CONFIRMADO: THE BATMAN 2 VEM AI, E MAIS NOVAS SÉRIES! - AO VIVO - NERD RABUGENTO', 'confirmado-the-batman-2-vem-ai-e-mais-novas-series-ao-vivo-nerd-rabugento', 'confirmado-the-batman-2-vem-ai-e-mais-novas-series-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022130_confirmado-the-batman-2-vem-ai-e-mais-novas-series-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=eNFzjH_mGyE', NULL, NULL, 0, '2022-03-05', '2022-03-12 02:21:31', '2022-03-12 02:21:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(145, 14, 'EU ACHEI TODOS OS FUROS DE ROTEIRO DE THE BATMAN! - AO VIVO - NERD RABUGENTO', 'eu-achei-todos-os-furos-de-roteiro-de-the-batman-ao-vivo-nerd-rabugento', 'eu-achei-todos-os-furos-de-roteiro-de-the-batman-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20220312022136_eu-achei-todos-os-furos-de-roteiro-de-the-batman-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=TvzGuovknvI', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:21:37', '2022-03-12 02:21:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(146, 14, 'SPOILERS: THE BATMAN FILME COMPLETO - AO VIVO', 'spoilers-the-batman-filme-completo-ao-vivo', 'spoilers-the-batman-filme-completo-ao-vivo-nerdrabugentoyoutube', '/uploads/news/20220312022141_spoilers-the-batman-filme-completo-ao-vivo-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=h4snw2dNHh0', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:21:41', '2022-03-12 02:21:41');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(147, 14, 'THE BATMAN / DC FANDOME - NERD RABUGENTO AO VIVO', 'the-batman-dc-fandome-nerd-rabugento-ao-vivo', 'the-batman-dc-fandome-nerd-rabugento-ao-vivo-nerdrabugentoyoutube', '/uploads/news/20220312022144_the-batman-dc-fandome-nerd-rabugento-ao-vivo-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=8GYUm9B7Jak', NULL, NULL, 0, '2020-08-20', '2022-03-12 02:21:45', '2022-03-12 02:21:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(148, 16, 'THE BATMAN  Entregou tudo o que prometeu? ft. Gabi Orsini e Dinho Lima', 'the-batman-entregou-tudo-o-que-prometeu-ft-gabi-orsini-e-dinho-lima', 'the-batman-entregou-tudo-o-que-prometeu-ft-gabi-orsini-e-dinho-lima-crispandayoutube', '/uploads/news/20220312022150_the-batman-entregou-tudo-o-que-prometeu-ft-gabi-orsini-e-dinho-lima-crispandayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=t8oSJ9tOMlg', NULL, NULL, 0, '2022-03-07', '2022-03-12 02:21:51', '2022-03-12 02:21:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(149, 18, 'THE BATMAN - Isso é Cinema feat cacadorescult', 'the-batman-isso-e-cinema-feat-cacadorescult', 'the-batman-isso-e-cinema-feat-cacadorescult-caldeiraonerdyoutube', '/uploads/news/20220312022159_the-batman-isso-e-cinema-feat-cacadorescult-caldeiraonerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=XzQWS6GUAX0', NULL, NULL, 0, '2022-03-09', '2022-03-12 02:22:00', '2022-03-12 02:22:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(150, 19, 'THE BATMAN: Tudo o que já sabemos sobre o novo filme da DC | Arena Nerd', 'the-batman-tudo-o-que-ja-sabemos-sobre-o-novo-filme-da-dc-arena-nerd', 'the-batman-tudo-o-que-ja-sabemos-sobre-o-novo-filme-da-dc-arena-nerd-arenanerdyoutube', '/uploads/news/20220312022206_the-batman-tudo-o-que-ja-sabemos-sobre-o-novo-filme-da-dc-arena-nerd-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=9B0FTGqnX_8', NULL, NULL, 0, '2019-11-28', '2022-03-12 02:22:07', '2022-03-12 02:22:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(151, 19, 'THE BATMAN | Visual do Batmóvel ficou bom? | Bate-Papo | Arena Filmes', 'the-batman-visual-do-batmovel-ficou-bom-bate-papo-arena-filmes', 'the-batman-visual-do-batmovel-ficou-bom-bate-papo-arena-filmes-arenanerdyoutube', '/uploads/news/20220312022211_the-batman-visual-do-batmovel-ficou-bom-bate-papo-arena-filmes-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=TlO2HJY5vTY', NULL, NULL, 0, '2020-03-13', '2022-03-12 02:22:11', '2022-03-12 02:22:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(152, 19, 'The Batman Trailer Comentado | DC FanDome | Arena Filmes', 'the-batman-trailer-comentado-dc-fandome-arena-filmes', 'the-batman-trailer-comentado-dc-fandome-arena-filmes-arenanerdyoutube', '/uploads/news/20220312022216_the-batman-trailer-comentado-dc-fandome-arena-filmes-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=XU4OsoMnJnk', NULL, NULL, 0, '2020-09-01', '2022-03-12 02:22:17', '2022-03-12 02:22:17');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(153, 19, '[LIVE] THE BATMAN: Robert Pattinson larga o treino para viver o personagem | Notícias Nerd', 'live-the-batman-robert-pattinson-larga-o-treino-para-viver-o-personagem-noticias-nerd', 'live-the-batman-robert-pattinson-larga-o-treino-para-viver-o-personagem-noticias-nerd-arenanerdyoutube', '/uploads/news/20220312022219_live-the-batman-robert-pattinson-larga-o-treino-para-viver-o-personagem-noticias-nerd-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=LhipQQq1K4c', NULL, NULL, 0, '2020-05-19', '2022-03-12 02:22:20', '2022-03-12 02:22:20');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(154, 19, 'The Batman | Robert Pattinson vai ser um bom Batman? | Arena Nerd', 'the-batman-robert-pattinson-vai-ser-um-bom-batman-arena-nerd', 'the-batman-robert-pattinson-vai-ser-um-bom-batman-arena-nerd-arenanerdyoutube', '/uploads/news/20220312022222_the-batman-robert-pattinson-vai-ser-um-bom-batman-arena-nerd-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=sHhWf5NPjcU', NULL, NULL, 0, '2019-05-29', '2022-03-12 02:22:23', '2022-03-12 02:22:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(155, 19, 'Gotham Central | A nova série spin-off de THE BATMAN | Arena News', 'gotham-central-a-nova-serie-spin-off-de-the-batman-arena-news', 'gotham-central-a-nova-serie-spin-off-de-the-batman-arena-news-arenanerdyoutube', '/uploads/news/20220312022226_gotham-central-a-nova-serie-spin-off-de-the-batman-arena-news-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=YD20uQHUItw', NULL, NULL, 0, '2020-07-14', '2022-03-12 02:22:26', '2022-03-12 02:22:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(156, 19, 'Novo Universo da DC nos Cinemas? | The Batman e O Coringa de Joaquin Phoenix | Arena News', 'novo-universo-da-dc-nos-cinemas-the-batman-e-o-coringa-de-joaquin-phoenix-arena-news', 'novo-universo-da-dc-nos-cinemas-the-batman-e-o-coringa-de-joaquin-phoenix-arena-news-arenanerdyoutube', '/uploads/news/20220312022228_novo-universo-da-dc-nos-cinemas-the-batman-e-o-coringa-de-joaquin-phoenix-arena-news-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=HBwLi1mFBnc', NULL, NULL, 0, '2018-06-25', '2022-03-12 02:22:30', '2022-03-12 02:22:30');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(157, 19, 'Resumão DC FanDome | Da Snyder Cut ao The Batman | Arena News LIVE', 'resumao-dc-fandome-da-snyder-cut-ao-the-batman-arena-news-live', 'resumao-dc-fandome-da-snyder-cut-ao-the-batman-arena-news-live-arenanerdyoutube', '/uploads/news/20220312022233_resumao-dc-fandome-da-snyder-cut-ao-the-batman-arena-news-live-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=XLRhugj8_ho', NULL, NULL, 0, '2020-08-25', '2022-03-12 02:22:34', '2022-03-12 02:22:34');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(158, 19, 'Henry Cavill Ainda É O Superman? | The Batman e The Walking Dead | Arena News 65', 'henry-cavill-ainda-e-o-superman-the-batman-e-the-walking-dead-arena-news-65', 'henry-cavill-ainda-e-o-superman-the-batman-e-the-walking-dead-arena-news-65-arenanerdyoutube', '/uploads/news/20220312022236_henry-cavill-ainda-e-o-superman-the-batman-e-the-walking-dead-arena-news-65-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=M9dHGB2IyOw', NULL, NULL, 0, '2018-09-17', '2022-03-12 02:22:37', '2022-03-12 02:22:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(159, 19, 'Notícias da Semana: The Batman, Série do Senhor dos Anéis e Final Space | Arena News 60', 'noticias-da-semana-the-batman-serie-do-senhor-dos-aneis-e-final-space-arena-news-60', 'noticias-da-semana-the-batman-serie-do-senhor-dos-aneis-e-final-space-arena-news-60-arenanerdyoutube', '/uploads/news/20220312022242_noticias-da-semana-the-batman-serie-do-senhor-dos-aneis-e-final-space-arena-news-60-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-tOWXJUA65Y', NULL, NULL, 0, '2018-08-06', '2022-03-12 02:22:42', '2022-03-12 02:22:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(160, 19, 'Notícias da Semana: Refilmagens de X-Men: Fênix Negra, The Batman e Supergirl | Arena News 61', 'noticias-da-semana-refilmagens-de-x-men-fenix-negra-the-batman-e-supergirl-arena-news-61', 'noticias-da-semana-refilmagens-de-x-men-fenix-negra-the-batman-e-supergirl-arena-news-61-arenanerdyoutube', '/uploads/news/20220312022246_noticias-da-semana-refilmagens-de-x-men-fenix-negra-the-batman-e-supergirl-arena-news-61-arenanerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5fovW0oDCKY', NULL, NULL, 0, '2018-08-13', '2022-03-12 02:22:47', '2022-03-12 02:22:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(161, 20, 'TODOS os DETALHES que você PERDEU em THE BATMAN (2022) | Easter eggs & Referências', 'todos-os-detalhes-que-voce-perdeu-em-the-batman-2022-easter-eggs-referencias', 'todos-os-detalhes-que-voce-perdeu-em-the-batman-2022-easter-eggs-referencias-sessaonerdyoutube', '/uploads/news/20220312022251_todos-os-detalhes-que-voce-perdeu-em-the-batman-2022-easter-eggs-referencias-sessaonerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=mpbgu3nn6yM', NULL, NULL, 0, '2022-03-05', '2022-03-12 02:22:52', '2022-03-12 02:22:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(162, 20, '23 DETALHES que você PERDEU no Trailer de THE BATMAN', '23-detalhes-que-voce-perdeu-no-trailer-de-the-batman', '23-detalhes-que-voce-perdeu-no-trailer-de-the-batman-sessaonerdyoutube', '/uploads/news/20220312022254_23-detalhes-que-voce-perdeu-no-trailer-de-the-batman-sessaonerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=cmLuYreU_Lk', NULL, NULL, 0, '2020-08-25', '2022-03-12 02:22:54', '2022-03-12 02:22:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(163, 21, 'PRIMEIRAS CRÍTICAS DE THE BATMAN! (FILME DE TERROR?!)', 'primeiras-criticas-de-the-batman-filme-de-terror', 'primeiras-criticas-de-the-batman-filme-de-terror-nerdnewsyoutube', '/uploads/news/20220312022259_primeiras-criticas-de-the-batman-filme-de-terror-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=3woMARk2FO4', NULL, NULL, 0, '2021-08-31', '2022-03-12 02:23:00', '2022-03-12 02:23:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(164, 21, 'THE BATMAN  O NOVO UNIFORME FICOU RIDÍCULO!!!', 'the-batman-o-novo-uniforme-ficou-ridiculo', 'the-batman-o-novo-uniforme-ficou-ridiculo-nerdnewsyoutube', '/uploads/news/20220312022303_the-batman-o-novo-uniforme-ficou-ridiculo-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=TkMeUPVQMbk', NULL, NULL, 0, '2020-03-05', '2022-03-12 02:23:04', '2022-03-12 02:23:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(165, 21, 'QUEM É QUEM NO FILME? TODOS OS PERSONAGENS DE THE BATMAN (ROBERT PATTINSON, 2021)', 'quem-e-quem-no-filme-todos-os-personagens-de-the-batman-robert-pattinson-2021', 'quem-e-quem-no-filme-todos-os-personagens-de-the-batman-robert-pattinson-2021-nerdnewsyoutube', '/uploads/news/20220312022308_quem-e-quem-no-filme-todos-os-personagens-de-the-batman-robert-pattinson-2021-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=fN-79zNFvEA', NULL, NULL, 0, '2020-09-16', '2022-03-12 02:23:08', '2022-03-12 02:23:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(166, 21, 'THE BATMAN: O MELHOR FILME SOLO DO BATMAN DA HISTÓRIA!', 'the-batman-o-melhor-filme-solo-do-batman-da-historia', 'the-batman-o-melhor-filme-solo-do-batman-da-historia-nerdnewsyoutube', '/uploads/news/20220312022312_the-batman-o-melhor-filme-solo-do-batman-da-historia-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=asb1t1foFQc', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:23:13', '2022-03-12 02:23:13');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(167, 21, 'THE BATMAN  TUDO QUE VOCÊ PRECISA SABER SOBRE O ELENCO DO FILME!', 'the-batman-tudo-que-voce-precisa-saber-sobre-o-elenco-do-filme', 'the-batman-tudo-que-voce-precisa-saber-sobre-o-elenco-do-filme-nerdnewsyoutube', '/uploads/news/20220312022315_the-batman-tudo-que-voce-precisa-saber-sobre-o-elenco-do-filme-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=NhSXR4FGiBA', NULL, NULL, 0, '2019-11-14', '2022-03-12 02:23:15', '2022-03-12 02:23:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(168, 21, 'TRAILER OFICIAL THE BATMAN (2021)', 'trailer-oficial-the-batman-2021', 'trailer-oficial-the-batman-2021-nerdnewsyoutube', '/uploads/news/20220312022318_trailer-oficial-the-batman-2021-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dzR8wGiIfX8', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:23:19', '2022-03-12 02:23:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(169, 5, 'THE BATMAN: TEORIA EXPLICA QUE CHARADA FOI CRIADO POR BRUCE WAYNE (+ corte das corujas)', 'the-batman-teoria-explica-que-charada-foi-criado-por-bruce-wayne-corte-das-corujas', 'the-batman-teoria-explica-que-charada-foi-criado-por-bruce-wayne-corte-das-corujas-einerdyoutube', '/uploads/news/20220312022436_the-batman-teoria-explica-que-charada-foi-criado-por-bruce-wayne-corte-das-corujas-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=uxYR2nrgGgg', NULL, NULL, 0, '2020-08-27', '2022-03-12 02:24:38', '2022-03-12 02:24:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(170, 9, 'CORINGA DO JOAQUIN PHOENIX ESTARÁ EM THE BATMAN?', 'coringa-do-joaquin-phoenix-estara-em-the-batman', 'coringa-do-joaquin-phoenix-estara-em-the-batman-cinemacomrapadurayoutube', '/uploads/news/20220312022448_coringa-do-joaquin-phoenix-estara-em-the-batman-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=vFUjTSFEeMU', NULL, NULL, 0, '2019-05-31', '2022-03-12 02:24:49', '2022-03-12 02:24:49');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(171, 21, '5 COISAS QUE VOCÊ PRECISA SABER SOBRE THE BATMAN', '5-coisas-que-voce-precisa-saber-sobre-the-batman', '5-coisas-que-voce-precisa-saber-sobre-the-batman-nerdnewsyoutube', '/uploads/news/20220312022521_5-coisas-que-voce-precisa-saber-sobre-the-batman-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=pCmezYb2fvY', NULL, NULL, 0, '2018-06-07', '2022-03-12 02:25:22', '2022-03-12 02:25:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(172, 21, 'THE BATMAN: PRIMEIRAS IMPRESSÕES DO FILME REVELADAS', 'the-batman-primeiras-impressoes-do-filme-reveladas', 'the-batman-primeiras-impressoes-do-filme-reveladas-nerdnewsyoutube', '/uploads/news/20220312022524_the-batman-primeiras-impressoes-do-filme-reveladas-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=nxQVK3DLm2c', NULL, NULL, 0, '2021-09-05', '2022-03-12 02:25:24', '2022-03-12 02:25:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(173, 21, 'THE BATMAN TERÁ ROBIN E TRÊS VILÕES CLÁSSICOS!!!', 'the-batman-tera-robin-e-tres-viloes-classicos', 'the-batman-tera-robin-e-tres-viloes-classicos-nerdnewsyoutube', '/uploads/news/20220312022528_the-batman-tera-robin-e-tres-viloes-classicos-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=yj-TLuE8vWw', NULL, NULL, 0, '2019-06-03', '2022-03-12 02:25:29', '2022-03-12 02:25:29');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(174, 21, 'THE BATMAN: O QUE ESPERAR DE ROBERT PATTINSON EM 2021?!', 'the-batman-o-que-esperar-de-robert-pattinson-em-2021', 'the-batman-o-que-esperar-de-robert-pattinson-em-2021-nerdnewsyoutube', '/uploads/news/20220312022532_the-batman-o-que-esperar-de-robert-pattinson-em-2021-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=I20V0_rFSwE', NULL, NULL, 0, '2019-10-28', '2022-03-12 02:25:33', '2022-03-12 02:25:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(175, 21, '5 COISAS QUE JÁ SABEMOS SOBRE THE BATMAN | Nerd News 72', '5-coisas-que-ja-sabemos-sobre-the-batman-nerd-news-72', '5-coisas-que-ja-sabemos-sobre-the-batman-nerd-news-72-nerdnewsyoutube', '/uploads/news/20220312022535_5-coisas-que-ja-sabemos-sobre-the-batman-nerd-news-72-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-q8mHcmPr_k', NULL, NULL, 0, '2016-12-08', '2022-03-12 02:25:36', '2022-03-12 02:25:36');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(176, 21, 'TODOS OS 6 FILMES DA DC ATÉ 2023! (TEM ATÉ THE BATMAN) shorts', 'todos-os-6-filmes-da-dc-ate-2023-tem-ate-the-batman-shorts', 'todos-os-6-filmes-da-dc-ate-2023-tem-ate-the-batman-shorts-nerdnewsyoutube', '/uploads/news/20220312022538_todos-os-6-filmes-da-dc-ate-2023-tem-ate-the-batman-shorts-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-brs5oT_r7I', NULL, NULL, 0, '2021-08-19', '2022-03-12 02:25:38', '2022-03-12 02:25:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(177, 21, 'BEN AFFLECK AMARELOU NO FILME THE BATMAN? | Falando Nerda 16', 'ben-affleck-amarelou-no-filme-the-batman-falando-nerda-16', 'ben-affleck-amarelou-no-filme-the-batman-falando-nerda-16-nerdnewsyoutube', '/uploads/news/20220312022541_ben-affleck-amarelou-no-filme-the-batman-falando-nerda-16-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=U0jZI8E-jUY', NULL, NULL, 0, '2017-02-01', '2022-03-12 02:25:42', '2022-03-12 02:25:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(178, 21, 'CONFIRMADO O NOVO DIRETOR DE THE BATMAN | Nerd News Drops 19', 'confirmado-o-novo-diretor-de-the-batman-nerd-news-drops-19', 'confirmado-o-novo-diretor-de-the-batman-nerd-news-drops-19-nerdnewsyoutube', '/uploads/news/20220312022545_confirmado-o-novo-diretor-de-the-batman-nerd-news-drops-19-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=viV4ibpU6uk', NULL, NULL, 0, '2017-02-24', '2022-03-12 02:25:47', '2022-03-12 02:25:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(179, 21, 'THE BATMAN: NOVO DIRETOR DO FILME FALA SOBRE O HERÓI! | Nerd News Drops 46', 'the-batman-novo-diretor-do-filme-fala-sobre-o-heroi-nerd-news-drops-46', 'the-batman-novo-diretor-do-filme-fala-sobre-o-heroi-nerd-news-drops-46-nerdnewsyoutube', '/uploads/news/20220312022550_the-batman-novo-diretor-do-filme-fala-sobre-o-heroi-nerd-news-drops-46-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=2Uy8GigavpQ', NULL, NULL, 0, '2017-05-04', '2022-03-12 02:25:50', '2022-03-12 02:25:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(180, 21, 'BEN AFFLECK FORA DO ROTEIRO DE THE BATMAN? | Nerd News Drops 7', 'ben-affleck-fora-do-roteiro-de-the-batman-nerd-news-drops-7', 'ben-affleck-fora-do-roteiro-de-the-batman-nerd-news-drops-7-nerdnewsyoutube', '/uploads/news/20220312022553_ben-affleck-fora-do-roteiro-de-the-batman-nerd-news-drops-7-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wx5iMIcMlvE', NULL, NULL, 0, '2017-02-01', '2022-03-12 02:25:55', '2022-03-12 02:25:55');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(181, 21, 'ZACK SNYDER DIRETOR EM THE BATMAN? | Nerd News Drops 8', 'zack-snyder-diretor-em-the-batman-nerd-news-drops-8', 'zack-snyder-diretor-em-the-batman-nerd-news-drops-8-nerdnewsyoutube', '/uploads/news/20220312022559_zack-snyder-diretor-em-the-batman-nerd-news-drops-8-nerdnewsyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=bBVESLg9ofA', NULL, NULL, 0, '2017-02-03', '2022-03-12 02:26:00', '2022-03-12 02:26:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(182, 22, 'THE BATMAN | CRÍTICA COM SPOILER', 'the-batman-critica-com-spoiler', 'the-batman-critica-com-spoiler-thiagoromarizyoutube', '/uploads/news/20220312022607_the-batman-critica-com-spoiler-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=buE5IH5Rxpo', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:26:07', '2022-03-12 02:26:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(183, 22, 'THE BATMAN | CRÍTICA SEM SPOILER', 'the-batman-critica-sem-spoiler', 'the-batman-critica-sem-spoiler-thiagoromarizyoutube', '/uploads/news/20220312022611_the-batman-critica-sem-spoiler-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=vk80XT3ZwTg', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:26:11', '2022-03-12 02:26:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(184, 22, 'EU ASSISTI THE BATMAN E MEU DEUS DO CÉU!!!!!!', 'eu-assisti-the-batman-e-meu-deus-do-ceu', 'eu-assisti-the-batman-e-meu-deus-do-ceu-thiagoromarizyoutube', '/uploads/news/20220312022615_eu-assisti-the-batman-e-meu-deus-do-ceu-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=qCZ0yiUHDQQ', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:26:16', '2022-03-12 02:26:16');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(185, 22, 'THE BATMAN: FINAL EXPLICADO + CENA PÓS-CRÉDITOS', 'the-batman-final-explicado-cena-pos-creditos', 'the-batman-final-explicado-cena-pos-creditos-thiagoromarizyoutube', '/uploads/news/20220312022618_the-batman-final-explicado-cena-pos-creditos-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ofFQ21fpleA', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:26:18', '2022-03-12 02:26:18');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(186, 22, 'THE BATMAN: O MAIOR FILME DA DC!', 'the-batman-o-maior-filme-da-dc', 'the-batman-o-maior-filme-da-dc-thiagoromarizyoutube', '/uploads/news/20220312022621_the-batman-o-maior-filme-da-dc-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=v41x7Eg-cak', NULL, NULL, 0, '2022-01-20', '2022-03-12 02:26:22', '2022-03-12 02:26:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(187, 22, 'THE BATMAN - CLIPE OFICIAL "BATMAN vs GORDON"', 'the-batman-clipe-oficial-batman-vs-gordon', 'the-batman-clipe-oficial-batman-vs-gordon-thiagoromarizyoutube', '/uploads/news/20220312022625_the-batman-clipe-oficial-batman-vs-gordon-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=8XFS3RLsl4Q', NULL, NULL, 0, '2022-02-17', '2022-03-12 02:26:26', '2022-03-12 02:26:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(188, 22, 'THE BATMAN | TRAILER OFICIAL: A Gata e o Morcego', 'the-batman-trailer-oficial-a-gata-e-o-morcego', 'the-batman-trailer-oficial-a-gata-e-o-morcego-thiagoromarizyoutube', '/uploads/news/20220312022628_the-batman-trailer-oficial-a-gata-e-o-morcego-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ustGB6CVc5A', NULL, NULL, 0, '2021-12-27', '2022-03-12 02:26:28', '2022-03-12 02:26:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(189, 22, 'THE BATMAN | TRAILER OFICIAL | REAÇÃO', 'the-batman-trailer-oficial-reacao', 'the-batman-trailer-oficial-reacao-thiagoromarizyoutube', '/uploads/news/20220312022632_the-batman-trailer-oficial-reacao-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=pjFiae6Y-Uk', NULL, NULL, 0, '2021-10-16', '2022-03-12 02:26:33', '2022-03-12 02:26:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(190, 22, 'THE BATMAN | CLIPE OFICIAL: Charada no Funeral | ANÁLISE e REAÇÃO', 'the-batman-clipe-oficial-charada-no-funeral-analise-e-reacao', 'the-batman-clipe-oficial-charada-no-funeral-analise-e-reacao-thiagoromarizyoutube', '/uploads/news/20220312022637_the-batman-clipe-oficial-charada-no-funeral-analise-e-reacao-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=CeBW_B4UBmM', NULL, NULL, 0, '2022-01-23', '2022-03-12 02:26:37', '2022-03-12 02:26:37');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(191, 22, 'THE BATMAN: QUANDO EU ASSISTIREI AO FILME!', 'the-batman-quando-eu-assistirei-ao-filme', 'the-batman-quando-eu-assistirei-ao-filme-thiagoromarizyoutube', '/uploads/news/20220312022642_the-batman-quando-eu-assistirei-ao-filme-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=nPQWNt0XGYg', NULL, NULL, 0, '2022-02-09', '2022-03-12 02:26:42', '2022-03-12 02:26:42');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(192, 22, 'THE BATMAN | TRAILER FINAL NBA 2022 OFICIAL', 'the-batman-trailer-final-nba-2022-oficial', 'the-batman-trailer-final-nba-2022-oficial-thiagoromarizyoutube', '/uploads/news/20220312022646_the-batman-trailer-final-nba-2022-oficial-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=hob8M_R0f40', NULL, NULL, 0, '2022-02-21', '2022-03-12 02:26:47', '2022-03-12 02:26:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(193, 23, 'THE BATMAN | REVIEW COM SPOILERS | EASTER EGGS e REFERÊNCIAS aos QUADRINHOS (EXPLICADO)', 'the-batman-review-com-spoilers-easter-eggs-e-referencias-aos-quadrinhos-explicado', 'the-batman-review-com-spoilers-easter-eggs-e-referencias-aos-quadrinhos-explicado-gustavocunhayoutube', '/uploads/news/20220312022652_the-batman-review-com-spoilers-easter-eggs-e-referencias-aos-quadrinhos-explicado-gustavocunhayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=IkMl_-WPgGg', NULL, NULL, 0, '2022-03-06', '2022-03-12 02:26:52', '2022-03-12 02:26:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(194, 23, 'THE BATMAN | REVIEW SEM SPOILERS', 'the-batman-review-sem-spoilers', 'the-batman-review-sem-spoilers-gustavocunhayoutube', '/uploads/news/20220312022655_the-batman-review-sem-spoilers-gustavocunhayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=xqwm-yQuNhk', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:26:56', '2022-03-12 02:26:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(195, 23, 'THE BATMAN | O PERSONAGEM MISTERIOSO EXPLICADO e SÉRIE do ASILO ARKHAM', 'the-batman-o-personagem-misterioso-explicado-e-serie-do-asilo-arkham', 'the-batman-o-personagem-misterioso-explicado-e-serie-do-asilo-arkham-gustavocunhayoutube', '/uploads/news/20220312022700_the-batman-o-personagem-misterioso-explicado-e-serie-do-asilo-arkham-gustavocunhayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=EVMXnjLkdX0', NULL, NULL, 0, '2022-03-09', '2022-03-12 02:27:00', '2022-03-12 02:27:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(196, 23, 'BATMAN UNIFORME NOVO | que EMBLEMA é ESSE? BATMAN 2021 TEASER', 'batman-uniforme-novo-que-emblema-e-esse-batman-2021-teaser', 'batman-uniforme-novo-que-emblema-e-esse-batman-2021-teaser-gustavocunhayoutube', '/uploads/news/20220312022704_batman-uniforme-novo-que-emblema-e-esse-batman-2021-teaser-gustavocunhayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=F4zB1ZrNLZU', NULL, NULL, 0, '2020-02-16', '2022-03-12 02:27:05', '2022-03-12 02:27:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(197, 24, 'SÓ UM DEFEITO!!! JÁ VI THE BATMAN E MORRI', 'so-um-defeito-ja-vi-the-batman-e-morri', 'so-um-defeito-ja-vi-the-batman-e-morri-miguellokiayoutube', '/uploads/news/20220312022709_so-um-defeito-ja-vi-the-batman-e-morri-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=wydb3-0niLI', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:27:10', '2022-03-12 02:27:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(198, 24, 'THE BATMAN: TRAILER OFICIAL DC FANDOME - ANÁLISE COMPLETA e RESUMO', 'the-batman-trailer-oficial-dc-fandome-analise-completa-e-resumo', 'the-batman-trailer-oficial-dc-fandome-analise-completa-e-resumo-miguellokiayoutube', '/uploads/news/20220312022713_the-batman-trailer-oficial-dc-fandome-analise-completa-e-resumo-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=bfnKFJ87IM4', NULL, NULL, 0, '2021-10-16', '2022-03-12 02:27:14', '2022-03-12 02:27:14');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(199, 24, 'THE BATMAN 2: DATA, TEASER OFICIAL e COMO VAI SER', 'the-batman-2-data-teaser-oficial-e-como-vai-ser', 'the-batman-2-data-teaser-oficial-e-como-vai-ser-miguellokiayoutube', '/uploads/news/20220312022718_the-batman-2-data-teaser-oficial-e-como-vai-ser-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=T313TqvdHf0', NULL, NULL, 0, '2022-03-03', '2022-03-12 02:27:19', '2022-03-12 02:27:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(200, 24, 'THE BATMAN DUBLADO CONFUNDIU TUDO! TRAILER COM WENDEL BEZERRA E QUE VOZ É ESSA?', 'the-batman-dublado-confundiu-tudo-trailer-com-wendel-bezerra-e-que-voz-e-essa', 'the-batman-dublado-confundiu-tudo-trailer-com-wendel-bezerra-e-que-voz-e-essa-miguellokiayoutube', '/uploads/news/20220312022722_the-batman-dublado-confundiu-tudo-trailer-com-wendel-bezerra-e-que-voz-e-essa-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=BRlgKSXyKbQ', NULL, NULL, 0, '2020-09-03', '2022-03-12 02:27:22', '2022-03-12 02:27:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(201, 24, 'VOCÊ VIU O PINGUIM EM THE BATMAN? - TRAILER DC FANDOME', 'voce-viu-o-pinguim-em-the-batman-trailer-dc-fandome', 'voce-viu-o-pinguim-em-the-batman-trailer-dc-fandome-miguellokiayoutube', '/uploads/news/20220312022727_voce-viu-o-pinguim-em-the-batman-trailer-dc-fandome-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=6zrxuzlisjI', NULL, NULL, 0, '2020-08-23', '2022-03-12 02:27:28', '2022-03-12 02:27:28');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(202, 24, 'THE BATMAN MENTIU PRA GENTE?', 'the-batman-mentiu-pra-gente', 'the-batman-mentiu-pra-gente-miguellokiayoutube', '/uploads/news/20220312022732_the-batman-mentiu-pra-gente-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5KDAv6iofdc', NULL, NULL, 0, '2020-10-19', '2022-03-12 02:27:33', '2022-03-12 02:27:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(203, 24, 'THE BATMAN REVELA BATMÓVEL DE VELOZES E FURIOSOS', 'the-batman-revela-batmovel-de-velozes-e-furiosos', 'the-batman-revela-batmovel-de-velozes-e-furiosos-miguellokiayoutube', '/uploads/news/20220312022734_the-batman-revela-batmovel-de-velozes-e-furiosos-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QpgBocl3iSQ', NULL, NULL, 0, '2020-03-04', '2022-03-12 02:27:35', '2022-03-12 02:27:35');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(204, 24, 'AGORA TEMOS PROVAS! TODAS AS INFLUÊNCIAS INCRÍVEIS POR TRÁS DE THE BATMAN', 'agora-temos-provas-todas-as-influencias-incriveis-por-tras-de-the-batman', 'agora-temos-provas-todas-as-influencias-incriveis-por-tras-de-the-batman-miguellokiayoutube', '/uploads/news/20220312022737_agora-temos-provas-todas-as-influencias-incriveis-por-tras-de-the-batman-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5y3cnx-oN-Q', NULL, NULL, 0, '2020-09-04', '2022-03-12 02:27:38', '2022-03-12 02:27:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(205, 24, 'EU NÃO ESPERAVA POR ISSO! THE BATMAN (2021) TRAILER ANÁLISE COMPLETA!', 'eu-nao-esperava-por-isso-the-batman-2021-trailer-analise-completa', 'eu-nao-esperava-por-isso-the-batman-2021-trailer-analise-completa-miguellokiayoutube', '/uploads/news/20220312022742_eu-nao-esperava-por-isso-the-batman-2021-trailer-analise-completa-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=PArNr5PCkVQ', NULL, NULL, 0, '2020-08-22', '2022-03-12 02:27:43', '2022-03-12 02:27:43');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(206, 24, 'THE BATMAN ESTÁ COM PROBLEMAS AGORA', 'the-batman-esta-com-problemas-agora', 'the-batman-esta-com-problemas-agora-miguellokiayoutube', '/uploads/news/20220312022745_the-batman-esta-com-problemas-agora-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=3iSV4GOh86g', NULL, NULL, 0, '2019-11-26', '2022-03-12 02:27:46', '2022-03-12 02:27:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(207, 24, 'PRECISÁVAMOS DESSA BOA NOTÍCIA SOBRE THE BATMAN', 'precisavamos-dessa-boa-noticia-sobre-the-batman', 'precisavamos-dessa-boa-noticia-sobre-the-batman-miguellokiayoutube', '/uploads/news/20220312022750_precisavamos-dessa-boa-noticia-sobre-the-batman-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=UGv8mF6P1kg', NULL, NULL, 0, '2020-09-18', '2022-03-12 02:27:51', '2022-03-12 02:27:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(208, 24, 'AH NÃO! THE BATMAN PAROU! ROBERT PATTINSON TESTA POSITIVO!', 'ah-nao-the-batman-parou-robert-pattinson-testa-positivo', 'ah-nao-the-batman-parou-robert-pattinson-testa-positivo-miguellokiayoutube', '/uploads/news/20220312022753_ah-nao-the-batman-parou-robert-pattinson-testa-positivo-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=oUs1S49cM3U', NULL, NULL, 0, '2020-09-03', '2022-03-12 02:27:53', '2022-03-12 02:27:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(209, 25, 'JÁ VIMOS THE BATMAN! - Análise SEM SPOILERS', 'ja-vimos-the-batman-analise-sem-spoilers', 'ja-vimos-the-batman-analise-sem-spoilers-entremigasyoutube', '/uploads/news/20220312022758_ja-vimos-the-batman-analise-sem-spoilers-entremigasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-8wHICUUoLE', NULL, NULL, 0, '2022-02-28', '2022-03-12 02:27:59', '2022-03-12 02:27:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(210, 25, 'COM SPOILERS: THE BATMAN | Análise Honesta', 'com-spoilers-the-batman-analise-honesta', 'com-spoilers-the-batman-analise-honesta-entremigasyoutube', '/uploads/news/20220312022803_com-spoilers-the-batman-analise-honesta-entremigasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=pIg4imCuTSs', NULL, NULL, 0, '2022-03-01', '2022-03-12 02:28:04', '2022-03-12 02:28:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(211, 25, 'THE BATMAN: TRAILER COMPLETO + REACT E PRIMEIRAS IMPRESSÕES', 'the-batman-trailer-completo-react-e-primeiras-impressoes', 'the-batman-trailer-completo-react-e-primeiras-impressoes-entremigasyoutube', '/uploads/news/20220312022806_the-batman-trailer-completo-react-e-primeiras-impressoes-entremigasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=GccJkJmxLXA', NULL, NULL, 0, '2021-10-16', '2022-03-12 02:28:07', '2022-03-12 02:28:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(212, 29, 'Ir para: The Batman: onde está Gotham na vida real? Conheça cenários do filme!', 'ir-para-the-batman-onde-esta-gotham-na-vida-real-conheca-cenarios-do-filme', 'ir-para-the-batman-onde-esta-gotham-na-vida-real-conheca-cenarios-do-filme-tecmundosite', '/uploads/news/20220313041758_ir-para-the-batman-onde-esta-gotham-na-vida-real-conheca-cenarios-do-filme-tecmundosite.jpg', NULL, 'show', 'https://www.tecmundo.com.br/minha-serie/235096-the-batman-gotham-vida-real-cenarios-filme.htm', NULL, NULL, 0, '2022-03-12', '2022-03-13 16:17:58', '2022-03-13 16:17:58');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(213, 12, 'PREÇO DE BALA! O ORÇAMENTO DE THE BATMAN É ESCANDALOSAMENTE BAIXO!', 'preco-de-bala-o-orcamento-de-the-batman-e-escandalosamente-baixo', 'preco-de-bala-o-orcamento-de-the-batman-e-escandalosamente-baixo-quatrocoisasyoutube', '/uploads/news/20220313041859_preco-de-bala-o-orcamento-de-the-batman-e-escandalosamente-baixo-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=L8JPhAOTs20', NULL, NULL, 0, '2021-11-16', '2022-03-13 16:18:59', '2022-03-13 16:18:59');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.news_tags
CREATE TABLE IF NOT EXISTS `news_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int NOT NULL,
  `tags_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1188 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.news_tags: ~1.114 rows (aproximadamente)
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
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(86, 86, 12, '2021-09-21 23:08:40', '2021-09-21 23:08:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(87, 87, 12, '2021-09-21 23:08:41', '2021-09-21 23:08:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(88, 88, 12, '2021-09-21 23:08:42', '2021-09-21 23:08:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(89, 89, 12, '2021-09-21 23:08:43', '2021-09-21 23:08:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(90, 90, 12, '2021-09-21 23:08:44', '2021-09-21 23:08:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(91, 91, 12, '2021-09-21 23:08:46', '2021-09-21 23:08:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(92, 92, 12, '2021-09-21 23:08:47', '2021-09-21 23:08:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(93, 93, 12, '2021-09-21 23:08:48', '2021-09-21 23:08:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(94, 94, 12, '2021-09-21 23:08:49', '2021-09-21 23:08:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(95, 95, 12, '2021-09-21 23:08:50', '2021-09-21 23:08:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(96, 96, 12, '2021-09-22 00:15:09', '2021-09-22 00:15:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(97, 97, 12, '2021-09-22 00:15:09', '2021-09-22 00:15:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(98, 98, 12, '2021-09-22 00:15:10', '2021-09-22 00:15:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(99, 99, 12, '2021-09-22 00:15:10', '2021-09-22 00:15:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(100, 100, 12, '2021-09-22 00:15:10', '2021-09-22 00:15:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(101, 101, 12, '2021-09-22 00:15:11', '2021-09-22 00:15:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(102, 102, 12, '2021-09-22 00:15:11', '2021-09-22 00:15:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(103, 103, 12, '2021-09-22 00:15:11', '2021-09-22 00:15:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(104, 104, 12, '2021-09-22 00:15:11', '2021-09-22 00:15:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(105, 105, 12, '2021-09-22 00:15:12', '2021-09-22 00:15:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(106, 106, 12, '2021-09-22 00:15:12', '2021-09-22 00:15:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(107, 107, 12, '2021-09-22 00:15:13', '2021-09-22 00:15:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(108, 108, 12, '2021-09-22 00:15:13', '2021-09-22 00:15:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(109, 109, 12, '2021-09-22 00:15:13', '2021-09-22 00:15:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(110, 110, 12, '2021-09-22 00:25:53', '2021-09-22 00:25:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(111, 111, 12, '2021-09-22 00:25:53', '2021-09-22 00:25:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(112, 112, 12, '2021-09-22 00:25:53', '2021-09-22 00:25:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(113, 113, 12, '2021-09-22 00:25:53', '2021-09-22 00:25:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(114, 114, 12, '2021-09-22 00:25:53', '2021-09-22 00:25:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(115, 115, 12, '2021-09-22 00:25:53', '2021-09-22 00:25:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(116, 116, 12, '2021-09-22 00:25:54', '2021-09-22 00:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(117, 117, 12, '2021-09-22 00:25:54', '2021-09-22 00:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(118, 118, 12, '2021-09-22 00:25:54', '2021-09-22 00:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(119, 119, 12, '2021-09-22 00:25:54', '2021-09-22 00:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(120, 120, 12, '2021-09-22 00:25:54', '2021-09-22 00:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(121, 121, 12, '2021-09-22 00:25:54', '2021-09-22 00:25:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(122, 122, 12, '2021-09-22 00:25:55', '2021-09-22 00:25:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(123, 123, 12, '2021-09-22 00:25:55', '2021-09-22 00:25:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(124, 124, 14, '2021-09-22 21:01:49', '2021-09-22 21:01:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(125, 125, 14, '2021-09-22 21:01:51', '2021-09-22 21:01:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(126, 126, 14, '2021-09-22 21:01:51', '2021-09-22 21:01:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(127, 127, 14, '2021-09-22 21:01:52', '2021-09-22 21:01:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(128, 128, 14, '2021-09-22 21:01:54', '2021-09-22 21:01:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(129, 129, 14, '2021-09-22 21:01:59', '2021-09-22 21:01:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(130, 130, 14, '2021-09-22 21:01:59', '2021-09-22 21:01:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(131, 131, 14, '2021-09-22 21:02:02', '2021-09-22 21:02:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(132, 132, 14, '2021-09-22 21:02:03', '2021-09-22 21:02:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(133, 133, 14, '2021-09-22 21:02:08', '2021-09-22 21:02:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(134, 134, 14, '2021-09-22 21:02:12', '2021-09-22 21:02:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(135, 135, 14, '2021-09-22 21:02:15', '2021-09-22 21:02:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(136, 136, 14, '2021-09-22 21:02:16', '2021-09-22 21:02:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(137, 137, 14, '2021-09-22 21:02:17', '2021-09-22 21:02:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(138, 138, 14, '2021-09-22 21:02:19', '2021-09-22 21:02:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(139, 139, 14, '2021-09-22 21:02:22', '2021-09-22 21:02:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(140, 140, 14, '2021-09-22 21:02:24', '2021-09-22 21:02:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(141, 141, 14, '2021-09-22 21:02:26', '2021-09-22 21:02:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(142, 142, 14, '2021-09-22 21:02:27', '2021-09-22 21:02:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(143, 143, 14, '2021-09-22 21:02:29', '2021-09-22 21:02:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(144, 144, 14, '2021-09-22 21:02:31', '2021-09-22 21:02:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(145, 145, 14, '2021-09-22 21:02:33', '2021-09-22 21:02:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(146, 146, 14, '2021-09-22 21:02:35', '2021-09-22 21:02:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(147, 147, 14, '2021-09-22 21:02:38', '2021-09-22 21:02:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(148, 148, 14, '2021-09-22 21:02:39', '2021-09-22 21:02:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(149, 149, 14, '2021-09-22 21:02:39', '2021-09-22 21:02:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(150, 150, 14, '2021-09-22 21:02:42', '2021-09-22 21:02:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(151, 151, 14, '2021-09-22 21:02:42', '2021-09-22 21:02:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(152, 152, 14, '2021-09-22 21:08:17', '2021-09-22 21:08:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(153, 153, 14, '2021-09-22 21:08:26', '2021-09-22 21:08:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(154, 154, 14, '2021-09-22 21:08:29', '2021-09-22 21:08:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(155, 155, 14, '2021-09-22 21:08:33', '2021-09-22 21:08:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(156, 156, 14, '2021-09-22 21:08:34', '2021-09-22 21:08:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(157, 157, 14, '2021-09-22 21:08:36', '2021-09-22 21:08:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(158, 158, 14, '2021-09-22 21:08:41', '2021-09-22 21:08:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(159, 159, 14, '2021-09-22 21:08:44', '2021-09-22 21:08:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(160, 160, 14, '2021-09-22 21:08:47', '2021-09-22 21:08:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(161, 161, 14, '2021-09-22 21:08:52', '2021-09-22 21:08:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(162, 162, 14, '2021-09-22 21:11:59', '2021-09-22 21:11:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(163, 163, 14, '2021-09-22 21:12:04', '2021-09-22 21:12:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(164, 164, 14, '2021-09-22 21:12:07', '2021-09-22 21:12:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(165, 165, 14, '2021-09-22 21:12:11', '2021-09-22 21:12:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(166, 166, 14, '2021-09-22 21:12:16', '2021-09-22 21:12:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(167, 167, 14, '2021-09-22 21:12:22', '2021-09-22 21:12:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(168, 168, 14, '2021-09-22 21:12:26', '2021-09-22 21:12:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(169, 169, 14, '2021-09-22 21:12:29', '2021-09-22 21:12:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(170, 170, 14, '2021-09-22 21:12:32', '2021-09-22 21:12:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(171, 171, 14, '2021-09-22 21:12:42', '2021-09-22 21:12:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(172, 172, 14, '2021-09-22 21:12:46', '2021-09-22 21:12:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(173, 173, 14, '2021-09-22 21:12:49', '2021-09-22 21:12:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(174, 174, 14, '2021-09-22 21:12:51', '2021-09-22 21:12:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(175, 175, 14, '2021-09-22 21:12:55', '2021-09-22 21:12:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(176, 176, 14, '2021-09-22 21:12:59', '2021-09-22 21:12:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(177, 177, 14, '2021-09-22 21:13:01', '2021-09-22 21:13:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(178, 178, 14, '2021-09-22 21:13:07', '2021-09-22 21:13:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(179, 179, 14, '2021-09-22 21:13:14', '2021-09-22 21:13:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(180, 180, 14, '2021-09-22 21:13:19', '2021-09-22 21:13:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(181, 181, 14, '2021-09-22 21:13:26', '2021-09-22 21:13:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(182, 182, 14, '2021-09-22 21:13:30', '2021-09-22 21:13:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(183, 183, 14, '2021-09-22 21:13:34', '2021-09-22 21:13:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(184, 184, 14, '2021-09-22 21:13:39', '2021-09-22 21:13:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(185, 185, 14, '2021-09-22 21:13:42', '2021-09-22 21:13:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(186, 186, 14, '2021-09-22 21:13:47', '2021-09-22 21:13:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(187, 187, 14, '2021-09-22 21:13:52', '2021-09-22 21:13:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(188, 188, 14, '2021-09-22 21:13:55', '2021-09-22 21:13:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(189, 189, 14, '2021-09-22 21:13:58', '2021-09-22 21:13:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(190, 190, 14, '2021-09-22 21:14:03', '2021-09-22 21:14:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(191, 191, 14, '2021-09-22 21:14:09', '2021-09-22 21:14:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(192, 192, 14, '2021-09-22 21:14:11', '2021-09-22 21:14:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(193, 193, 14, '2021-09-22 21:14:14', '2021-09-22 21:14:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(194, 194, 14, '2021-09-22 21:14:17', '2021-09-22 21:14:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(195, 195, 14, '2021-09-22 21:14:22', '2021-09-22 21:14:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(196, 196, 14, '2021-09-22 21:14:24', '2021-09-22 21:14:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(197, 197, 14, '2021-09-22 21:14:28', '2021-09-22 21:14:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(198, 198, 14, '2021-09-22 21:14:31', '2021-09-22 21:14:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(199, 199, 14, '2021-09-22 21:14:35', '2021-09-22 21:14:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(200, 200, 14, '2021-09-22 21:14:39', '2021-09-22 21:14:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(201, 201, 14, '2021-09-22 21:14:41', '2021-09-22 21:14:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(202, 202, 14, '2021-09-22 21:14:43', '2021-09-22 21:14:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(203, 203, 14, '2021-10-25 21:03:31', '2021-10-25 21:03:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(204, 204, 14, '2021-10-25 21:03:34', '2021-10-25 21:03:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(205, 205, 14, '2021-10-25 21:03:35', '2021-10-25 21:03:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(206, 206, 14, '2021-10-25 21:03:41', '2021-10-25 21:03:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(207, 207, 14, '2021-10-25 21:03:42', '2021-10-25 21:03:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(208, 208, 14, '2021-10-25 21:03:44', '2021-10-25 21:03:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(209, 209, 14, '2021-10-25 21:03:45', '2021-10-25 21:03:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(210, 210, 14, '2021-10-25 21:03:47', '2021-10-25 21:03:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(211, 211, 14, '2021-10-25 21:03:48', '2021-10-25 21:03:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(212, 212, 14, '2021-10-25 21:03:50', '2021-10-25 21:03:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(213, 213, 14, '2021-10-25 21:03:50', '2021-10-25 21:03:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(214, 214, 14, '2021-10-25 21:04:02', '2021-10-25 21:04:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(215, 215, 14, '2021-10-25 21:04:05', '2021-10-25 21:04:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(216, 216, 14, '2021-10-25 21:04:08', '2021-10-25 21:04:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(217, 217, 14, '2021-10-25 21:04:11', '2021-10-25 21:04:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(218, 218, 14, '2021-10-25 21:04:14', '2021-10-25 21:04:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(219, 219, 14, '2021-10-25 21:04:17', '2021-10-25 21:04:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(220, 220, 14, '2021-10-25 21:04:20', '2021-10-25 21:04:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(221, 221, 14, '2021-10-25 21:04:26', '2021-10-25 21:04:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(222, 222, 14, '2021-10-25 21:04:30', '2021-10-25 21:04:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(223, 223, 14, '2021-10-25 21:04:35', '2021-10-25 21:04:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(224, 224, 14, '2021-10-25 21:04:38', '2021-10-25 21:04:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(225, 225, 9, '2021-10-25 21:36:28', '2021-10-25 21:36:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(226, 226, 9, '2021-10-25 21:36:29', '2021-10-25 21:36:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(227, 227, 9, '2021-10-25 21:36:30', '2021-10-25 21:36:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(228, 228, 9, '2021-10-25 21:36:31', '2021-10-25 21:36:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(229, 229, 9, '2021-10-25 21:36:31', '2021-10-25 21:36:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(230, 230, 9, '2021-10-25 21:36:33', '2021-10-25 21:36:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(231, 231, 9, '2021-10-25 21:36:33', '2021-10-25 21:36:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(232, 232, 9, '2021-10-25 21:36:34', '2021-10-25 21:36:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(233, 233, 9, '2021-10-25 21:36:39', '2021-10-25 21:36:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(234, 234, 9, '2021-10-25 21:36:40', '2021-10-25 21:36:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(235, 235, 9, '2021-10-25 21:36:41', '2021-10-25 21:36:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(236, 236, 9, '2021-10-25 21:36:43', '2021-10-25 21:36:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(237, 237, 9, '2021-10-25 21:36:45', '2021-10-25 21:36:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(238, 238, 9, '2021-10-25 21:36:47', '2021-10-25 21:36:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(239, 239, 9, '2021-10-25 21:36:58', '2021-10-25 21:36:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(240, 240, 9, '2021-10-25 21:37:01', '2021-10-25 21:37:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(241, 241, 9, '2021-10-25 21:37:03', '2021-10-25 21:37:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(242, 242, 9, '2021-10-25 21:37:04', '2021-10-25 21:37:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(243, 243, 9, '2021-10-25 21:37:05', '2021-10-25 21:37:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(244, 244, 9, '2021-10-25 21:37:12', '2021-10-25 21:37:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(245, 245, 9, '2021-10-25 21:37:13', '2021-10-25 21:37:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(246, 246, 9, '2021-10-25 21:37:16', '2021-10-25 21:37:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(247, 247, 9, '2021-10-25 21:37:22', '2021-10-25 21:37:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(248, 248, 9, '2021-10-25 21:37:25', '2021-10-25 21:37:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(249, 249, 9, '2021-10-25 21:37:27', '2021-10-25 21:37:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(250, 250, 9, '2021-10-25 21:37:29', '2021-10-25 21:37:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(251, 251, 9, '2021-10-25 21:37:30', '2021-10-25 21:37:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(252, 252, 9, '2021-10-25 21:37:33', '2021-10-25 21:37:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(253, 253, 9, '2021-10-25 21:37:34', '2021-10-25 21:37:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(254, 254, 9, '2021-10-25 21:37:35', '2021-10-25 21:37:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(255, 255, 9, '2021-10-25 21:37:37', '2021-10-25 21:37:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(256, 256, 9, '2021-10-25 21:37:39', '2021-10-25 21:37:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(257, 257, 9, '2021-10-25 21:37:40', '2021-10-25 21:37:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(258, 258, 9, '2021-10-25 21:37:42', '2021-10-25 21:37:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(259, 259, 9, '2021-10-25 21:37:43', '2021-10-25 21:37:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(260, 260, 9, '2021-10-25 21:37:45', '2021-10-25 21:37:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(261, 261, 9, '2021-10-25 21:37:46', '2021-10-25 21:37:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(262, 262, 9, '2021-10-25 21:37:47', '2021-10-25 21:37:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(263, 263, 9, '2021-10-25 21:37:48', '2021-10-25 21:37:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(264, 264, 9, '2021-10-25 21:37:48', '2021-10-25 21:37:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(265, 265, 9, '2021-10-25 21:37:49', '2021-10-25 21:37:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(266, 266, 9, '2021-10-25 21:37:49', '2021-10-25 21:37:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(267, 267, 9, '2021-10-25 21:37:50', '2021-10-25 21:37:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(268, 268, 9, '2021-10-25 21:37:51', '2021-10-25 21:37:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(269, 269, 9, '2021-10-25 21:37:51', '2021-10-25 21:37:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(270, 270, 9, '2021-10-25 21:37:52', '2021-10-25 21:37:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(271, 271, 9, '2021-10-25 21:37:58', '2021-10-25 21:37:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(272, 272, 9, '2021-10-25 21:38:01', '2021-10-25 21:38:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(273, 273, 9, '2021-10-25 21:38:03', '2021-10-25 21:38:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(274, 274, 9, '2021-10-25 21:38:08', '2021-10-25 21:38:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(275, 275, 9, '2021-10-25 21:38:09', '2021-10-25 21:38:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(276, 276, 9, '2021-10-25 21:38:10', '2021-10-25 21:38:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(277, 277, 9, '2021-10-25 21:38:17', '2021-10-25 21:38:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(278, 278, 9, '2021-10-25 21:38:19', '2021-10-25 21:38:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(279, 279, 9, '2021-10-25 21:38:20', '2021-10-25 21:38:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(280, 280, 9, '2021-10-25 21:38:22', '2021-10-25 21:38:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(281, 281, 9, '2021-10-25 21:38:36', '2021-10-25 21:38:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(282, 282, 9, '2021-10-25 21:38:41', '2021-10-25 21:38:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(283, 283, 9, '2021-10-25 21:38:45', '2021-10-25 21:38:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(284, 284, 9, '2021-10-25 21:38:49', '2021-10-25 21:38:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(285, 285, 9, '2021-10-25 21:38:52', '2021-10-25 21:38:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(286, 286, 9, '2021-10-25 21:38:55', '2021-10-25 21:38:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(287, 287, 9, '2021-10-25 21:39:00', '2021-10-25 21:39:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(288, 288, 9, '2021-10-25 21:39:03', '2021-10-25 21:39:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(289, 289, 9, '2021-10-25 21:39:06', '2021-10-25 21:39:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(290, 290, 9, '2021-10-25 21:39:13', '2021-10-25 21:39:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(291, 291, 9, '2021-10-25 21:39:18', '2021-10-25 21:39:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(292, 292, 9, '2021-10-25 21:39:22', '2021-10-25 21:39:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(293, 293, 9, '2021-10-25 21:39:33', '2021-10-25 21:39:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(294, 294, 9, '2021-10-25 21:39:38', '2021-10-25 21:39:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(295, 295, 9, '2021-10-25 21:39:40', '2021-10-25 21:39:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(296, 296, 9, '2021-10-25 21:39:44', '2021-10-25 21:39:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(297, 297, 9, '2021-10-25 21:39:49', '2021-10-25 21:39:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(298, 298, 9, '2021-10-25 21:39:52', '2021-10-25 21:39:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(299, 299, 9, '2021-10-25 21:39:57', '2021-10-25 21:39:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(300, 300, 9, '2021-10-25 21:40:03', '2021-10-25 21:40:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(301, 301, 9, '2021-10-25 21:40:08', '2021-10-25 21:40:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(302, 302, 9, '2021-10-25 21:40:14', '2021-10-25 21:40:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(303, 303, 9, '2021-10-25 21:40:17', '2021-10-25 21:40:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(304, 304, 9, '2021-10-25 21:40:21', '2021-10-25 21:40:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(305, 305, 9, '2021-10-25 21:40:24', '2021-10-25 21:40:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(306, 306, 9, '2021-10-25 21:40:28', '2021-10-25 21:40:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(307, 307, 9, '2021-10-25 21:40:31', '2021-10-25 21:40:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(308, 308, 9, '2021-10-25 21:40:34', '2021-10-25 21:40:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(309, 309, 9, '2021-10-25 21:40:39', '2021-10-25 21:40:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(310, 310, 9, '2021-10-25 21:40:43', '2021-10-25 21:40:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(311, 311, 9, '2021-10-25 21:40:51', '2021-10-25 21:40:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(312, 312, 9, '2021-10-25 21:40:56', '2021-10-25 21:40:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(313, 313, 9, '2021-10-25 21:41:01', '2021-10-25 21:41:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(314, 314, 9, '2021-10-25 21:41:05', '2021-10-25 21:41:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(315, 315, 9, '2021-10-25 21:41:07', '2021-10-25 21:41:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(316, 316, 9, '2021-10-25 21:41:10', '2021-10-25 21:41:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(317, 317, 9, '2021-10-25 21:49:33', '2021-10-25 21:49:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(318, 318, 9, '2021-10-25 21:49:37', '2021-10-25 21:49:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(319, 319, 9, '2021-10-25 21:49:41', '2021-10-25 21:49:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(320, 320, 9, '2021-10-25 21:49:44', '2021-10-25 21:49:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(321, 321, 9, '2021-10-25 21:49:48', '2021-10-25 21:49:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(322, 322, 9, '2021-10-25 21:49:53', '2021-10-25 21:49:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(323, 323, 9, '2021-10-25 21:49:58', '2021-10-25 21:49:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(324, 324, 9, '2021-10-25 21:50:01', '2021-10-25 21:50:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(325, 325, 9, '2021-10-25 21:50:06', '2021-10-25 21:50:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(326, 326, 9, '2021-10-25 21:50:10', '2021-10-25 21:50:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(327, 327, 9, '2021-10-25 21:50:13', '2021-10-25 21:50:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(328, 328, 9, '2021-10-25 21:50:16', '2021-10-25 21:50:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(329, 329, 9, '2021-10-25 21:50:20', '2021-10-25 21:50:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(330, 330, 9, '2021-10-25 21:50:25', '2021-10-25 21:50:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(331, 331, 9, '2021-10-25 21:50:30', '2021-10-25 21:50:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(332, 332, 9, '2021-10-25 21:50:39', '2021-10-25 21:50:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(333, 333, 9, '2022-03-03 21:43:40', '2022-03-03 21:43:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(334, 334, 9, '2022-03-03 21:43:41', '2022-03-03 21:43:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(335, 335, 9, '2022-03-03 21:43:43', '2022-03-03 21:43:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(336, 336, 9, '2022-03-03 21:43:43', '2022-03-03 21:43:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(337, 337, 9, '2022-03-03 21:43:46', '2022-03-03 21:43:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(338, 338, 9, '2022-03-03 21:43:47', '2022-03-03 21:43:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(339, 339, 9, '2022-03-03 21:43:47', '2022-03-03 21:43:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(340, 340, 9, '2022-03-03 21:43:47', '2022-03-03 21:43:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(341, 341, 9, '2022-03-03 21:43:48', '2022-03-03 21:43:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(342, 342, 9, '2022-03-03 21:43:53', '2022-03-03 21:43:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(343, 343, 9, '2022-03-03 21:43:55', '2022-03-03 21:43:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(344, 344, 9, '2022-03-03 21:43:56', '2022-03-03 21:43:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(345, 345, 9, '2022-03-03 21:43:58', '2022-03-03 21:43:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(346, 346, 9, '2022-03-03 21:43:59', '2022-03-03 21:43:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(347, 347, 9, '2022-03-03 21:44:00', '2022-03-03 21:44:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(348, 348, 9, '2022-03-03 21:44:02', '2022-03-03 21:44:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(349, 349, 9, '2022-03-03 21:44:02', '2022-03-03 21:44:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(350, 350, 9, '2022-03-03 21:44:03', '2022-03-03 21:44:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(351, 351, 9, '2022-03-03 21:44:04', '2022-03-03 21:44:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(352, 352, 9, '2022-03-03 21:44:05', '2022-03-03 21:44:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(353, 353, 9, '2022-03-03 21:44:20', '2022-03-03 21:44:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(354, 354, 9, '2022-03-03 21:44:20', '2022-03-03 21:44:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(355, 356, 9, '2022-03-03 21:44:21', '2022-03-03 21:44:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(356, 355, 9, '2022-03-03 21:44:21', '2022-03-03 21:44:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(357, 357, 9, '2022-03-03 21:44:22', '2022-03-03 21:44:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(358, 358, 9, '2022-03-03 21:44:22', '2022-03-03 21:44:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(359, 359, 9, '2022-03-03 21:44:24', '2022-03-03 21:44:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(360, 360, 9, '2022-03-03 21:44:24', '2022-03-03 21:44:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(361, 361, 9, '2022-03-03 21:44:25', '2022-03-03 21:44:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(362, 362, 9, '2022-03-03 21:44:25', '2022-03-03 21:44:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(363, 363, 9, '2022-03-03 21:44:26', '2022-03-03 21:44:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(364, 364, 9, '2022-03-03 21:44:26', '2022-03-03 21:44:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(365, 365, 9, '2022-03-03 21:44:27', '2022-03-03 21:44:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(366, 366, 9, '2022-03-03 21:44:27', '2022-03-03 21:44:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(367, 367, 9, '2022-03-03 21:44:28', '2022-03-03 21:44:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(368, 368, 9, '2022-03-03 21:44:29', '2022-03-03 21:44:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(369, 369, 9, '2022-03-03 21:45:31', '2022-03-03 21:45:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(370, 370, 9, '2022-03-03 21:45:41', '2022-03-03 21:45:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(371, 371, 15, '2022-03-03 21:48:54', '2022-03-03 21:48:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(372, 372, 15, '2022-03-03 21:49:00', '2022-03-03 21:49:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(373, 373, 15, '2022-03-03 21:49:00', '2022-03-03 21:49:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(374, 374, 15, '2022-03-03 21:49:02', '2022-03-03 21:49:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(375, 375, 15, '2022-03-03 21:49:03', '2022-03-03 21:49:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(376, 376, 15, '2022-03-03 21:49:05', '2022-03-03 21:49:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(377, 377, 15, '2022-03-03 21:49:06', '2022-03-03 21:49:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(378, 378, 15, '2022-03-03 21:49:07', '2022-03-03 21:49:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(379, 379, 15, '2022-03-03 21:49:08', '2022-03-03 21:49:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(380, 380, 15, '2022-03-03 21:49:09', '2022-03-03 21:49:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(381, 381, 15, '2022-03-03 21:49:10', '2022-03-03 21:49:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(382, 382, 15, '2022-03-03 21:49:11', '2022-03-03 21:49:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(383, 383, 15, '2022-03-03 21:49:12', '2022-03-03 21:49:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(384, 384, 15, '2022-03-03 21:49:13', '2022-03-03 21:49:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(385, 385, 15, '2022-03-03 21:49:14', '2022-03-03 21:49:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(386, 386, 15, '2022-03-03 21:49:17', '2022-03-03 21:49:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(387, 387, 15, '2022-03-03 21:49:18', '2022-03-03 21:49:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(388, 388, 15, '2022-03-03 21:49:19', '2022-03-03 21:49:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(389, 389, 15, '2022-03-03 21:49:20', '2022-03-03 21:49:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(390, 390, 15, '2022-03-03 21:49:24', '2022-03-03 21:49:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(391, 391, 15, '2022-03-03 21:49:25', '2022-03-03 21:49:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(392, 392, 15, '2022-03-03 21:49:27', '2022-03-03 21:49:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(393, 393, 15, '2022-03-03 21:49:28', '2022-03-03 21:49:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(394, 394, 15, '2022-03-03 21:49:30', '2022-03-03 21:49:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(395, 395, 15, '2022-03-03 21:49:32', '2022-03-03 21:49:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(396, 396, 15, '2022-03-03 21:49:33', '2022-03-03 21:49:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(397, 397, 15, '2022-03-03 21:49:34', '2022-03-03 21:49:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(398, 398, 15, '2022-03-03 21:49:35', '2022-03-03 21:49:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(399, 399, 15, '2022-03-03 21:49:36', '2022-03-03 21:49:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(400, 400, 15, '2022-03-03 21:49:44', '2022-03-03 21:49:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(401, 401, 15, '2022-03-03 21:49:49', '2022-03-03 21:49:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(402, 402, 15, '2022-03-03 21:49:52', '2022-03-03 21:49:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(403, 403, 15, '2022-03-03 21:49:57', '2022-03-03 21:49:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(404, 404, 15, '2022-03-03 22:58:09', '2022-03-03 22:58:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(405, 405, 15, '2022-03-03 22:58:13', '2022-03-03 22:58:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(406, 406, 15, '2022-03-03 22:58:17', '2022-03-03 22:58:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(407, 407, 15, '2022-03-03 22:58:20', '2022-03-03 22:58:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(408, 408, 15, '2022-03-03 22:58:25', '2022-03-03 22:58:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(409, 409, 15, '2022-03-03 22:58:28', '2022-03-03 22:58:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(410, 410, 15, '2022-03-03 22:58:30', '2022-03-03 22:58:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(411, 411, 15, '2022-03-03 22:58:33', '2022-03-03 22:58:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(412, 412, 15, '2022-03-03 22:58:35', '2022-03-03 22:58:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(413, 413, 15, '2022-03-03 22:58:37', '2022-03-03 22:58:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(414, 414, 15, '2022-03-03 22:58:40', '2022-03-03 22:58:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(415, 415, 15, '2022-03-03 22:58:43', '2022-03-03 22:58:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(416, 416, 15, '2022-03-03 22:58:48', '2022-03-03 22:58:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(417, 417, 15, '2022-03-03 23:01:47', '2022-03-03 23:01:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(418, 418, 15, '2022-03-03 23:01:51', '2022-03-03 23:01:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(419, 419, 15, '2022-03-03 23:05:54', '2022-03-03 23:05:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(420, 420, 15, '2022-03-03 23:05:58', '2022-03-03 23:05:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(421, 421, 15, '2022-03-03 23:11:23', '2022-03-03 23:11:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(422, 422, 15, '2022-03-03 23:13:08', '2022-03-03 23:13:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(423, 423, 15, '2022-03-03 23:23:49', '2022-03-03 23:23:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(424, 424, 15, '2022-03-03 23:23:51', '2022-03-03 23:23:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(425, 425, 15, '2022-03-08 21:56:23', '2022-03-08 21:56:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(426, 426, 15, '2022-03-08 21:56:24', '2022-03-08 21:56:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(427, 427, 15, '2022-03-08 21:56:28', '2022-03-08 21:56:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(428, 428, 15, '2022-03-08 21:56:29', '2022-03-08 21:56:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(429, 429, 15, '2022-03-08 21:59:51', '2022-03-08 21:59:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(430, 430, 15, '2022-03-08 21:59:54', '2022-03-08 21:59:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(431, 431, 15, '2022-03-08 21:59:55', '2022-03-08 21:59:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(432, 432, 15, '2022-03-08 21:59:56', '2022-03-08 21:59:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(433, 433, 15, '2022-03-08 22:17:12', '2022-03-08 22:17:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(434, 434, 15, '2022-03-08 22:25:41', '2022-03-08 22:25:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(435, 435, 15, '2022-03-08 22:25:46', '2022-03-08 22:25:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(436, 436, 15, '2022-03-08 22:25:51', '2022-03-08 22:25:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(437, 437, 15, '2022-03-08 22:25:57', '2022-03-08 22:25:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(438, 438, 15, '2022-03-08 22:26:43', '2022-03-08 22:26:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(439, 439, 15, '2022-03-08 22:26:46', '2022-03-08 22:26:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(440, 440, 15, '2022-03-08 22:26:50', '2022-03-08 22:26:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(441, 441, 15, '2022-03-08 22:26:55', '2022-03-08 22:26:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(442, 442, 15, '2022-03-11 22:17:13', '2022-03-11 22:17:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(443, 443, 15, '2022-03-11 22:17:34', '2022-03-11 22:17:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(444, 444, 15, '2022-03-11 22:17:44', '2022-03-11 22:17:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(445, 445, 15, '2022-03-11 22:17:47', '2022-03-11 22:17:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(446, 446, 15, '2022-03-11 22:17:50', '2022-03-11 22:17:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(447, 447, 15, '2022-03-11 22:17:55', '2022-03-11 22:17:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(448, 448, 15, '2022-03-11 22:18:03', '2022-03-11 22:18:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(449, 449, 15, '2022-03-11 22:18:08', '2022-03-11 22:18:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(450, 450, 15, '2022-03-11 22:18:12', '2022-03-11 22:18:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(451, 451, 15, '2022-03-11 22:18:17', '2022-03-11 22:18:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(452, 452, 15, '2022-03-11 22:22:28', '2022-03-11 22:22:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(453, 453, 15, '2022-03-11 22:22:34', '2022-03-11 22:22:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(454, 454, 15, '2022-03-11 22:22:36', '2022-03-11 22:22:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(455, 455, 15, '2022-03-11 22:44:02', '2022-03-11 22:44:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(456, 456, 15, '2022-03-11 22:44:09', '2022-03-11 22:44:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(457, 457, 15, '2022-03-11 22:44:14', '2022-03-11 22:44:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(458, 458, 15, '2022-03-11 22:44:17', '2022-03-11 22:44:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(459, 459, 15, '2022-03-11 22:44:21', '2022-03-11 22:44:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(460, 460, 15, '2022-03-11 22:44:24', '2022-03-11 22:44:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(461, 461, 15, '2022-03-11 22:44:27', '2022-03-11 22:44:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(462, 462, 15, '2022-03-11 22:44:30', '2022-03-11 22:44:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(463, 463, 15, '2022-03-11 22:44:36', '2022-03-11 22:44:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(464, 464, 15, '2022-03-11 22:44:40', '2022-03-11 22:44:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(465, 465, 15, '2022-03-11 22:44:42', '2022-03-11 22:44:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(466, 466, 15, '2022-03-11 22:44:48', '2022-03-11 22:44:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(467, 467, 15, '2022-03-11 22:44:50', '2022-03-11 22:44:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(468, 468, 15, '2022-03-11 22:52:39', '2022-03-11 22:52:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(469, 469, 15, '2022-03-11 22:52:47', '2022-03-11 22:52:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(470, 470, 15, '2022-03-11 22:52:50', '2022-03-11 22:52:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(471, 471, 15, '2022-03-11 22:52:51', '2022-03-11 22:52:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(472, 472, 15, '2022-03-11 22:52:57', '2022-03-11 22:52:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(473, 473, 15, '2022-03-11 22:53:01', '2022-03-11 22:53:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(474, 474, 15, '2022-03-11 22:53:05', '2022-03-11 22:53:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(475, 475, 15, '2022-03-11 22:53:09', '2022-03-11 22:53:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(476, 476, 15, '2022-03-11 22:53:15', '2022-03-11 22:53:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(477, 477, 15, '2022-03-11 22:53:17', '2022-03-11 22:53:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(478, 478, 15, '2022-03-11 22:53:21', '2022-03-11 22:53:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(479, 479, 15, '2022-03-11 22:53:23', '2022-03-11 22:53:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(480, 480, 15, '2022-03-11 22:53:28', '2022-03-11 22:53:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(481, 481, 15, '2022-03-11 22:59:40', '2022-03-11 22:59:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(482, 482, 15, '2022-03-11 22:59:47', '2022-03-11 22:59:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(483, 483, 15, '2022-03-11 22:59:52', '2022-03-11 22:59:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(484, 484, 15, '2022-03-11 22:59:54', '2022-03-11 22:59:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(485, 485, 15, '2022-03-11 22:59:59', '2022-03-11 22:59:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(486, 486, 15, '2022-03-11 23:00:04', '2022-03-11 23:00:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(487, 487, 15, '2022-03-11 23:00:09', '2022-03-11 23:00:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(488, 488, 15, '2022-03-11 23:00:14', '2022-03-11 23:00:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(489, 489, 15, '2022-03-11 23:00:19', '2022-03-11 23:00:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(490, 490, 15, '2022-03-11 23:00:24', '2022-03-11 23:00:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(491, 491, 15, '2022-03-11 23:00:29', '2022-03-11 23:00:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(492, 492, 15, '2022-03-11 23:00:34', '2022-03-11 23:00:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(493, 493, 15, '2022-03-11 23:00:39', '2022-03-11 23:00:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(494, 494, 15, '2022-03-12 00:01:56', '2022-03-12 00:01:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(495, 495, 15, '2022-03-12 00:02:00', '2022-03-12 00:02:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(496, 496, 15, '2022-03-12 00:07:14', '2022-03-12 00:07:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(497, 497, 15, '2022-03-12 00:07:18', '2022-03-12 00:07:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(498, 498, 15, '2022-03-12 00:17:28', '2022-03-12 00:17:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(499, 499, 15, '2022-03-12 00:22:39', '2022-03-12 00:22:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(500, 500, 15, '2022-03-12 00:22:41', '2022-03-12 00:22:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(501, 501, 15, '2022-03-12 00:22:47', '2022-03-12 00:22:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(502, 502, 15, '2022-03-12 00:22:52', '2022-03-12 00:22:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(503, 503, 15, '2022-03-12 00:22:55', '2022-03-12 00:22:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(504, 504, 15, '2022-03-12 00:23:00', '2022-03-12 00:23:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(505, 505, 15, '2022-03-12 00:23:02', '2022-03-12 00:23:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(506, 506, 15, '2022-03-12 00:23:07', '2022-03-12 00:23:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(507, 507, 15, '2022-03-12 00:23:10', '2022-03-12 00:23:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(508, 508, 15, '2022-03-12 00:26:10', '2022-03-12 00:26:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(509, 509, 15, '2022-03-12 00:26:17', '2022-03-12 00:26:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(510, 510, 15, '2022-03-12 00:26:21', '2022-03-12 00:26:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(511, 511, 15, '2022-03-12 00:26:24', '2022-03-12 00:26:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(512, 512, 15, '2022-03-12 00:26:30', '2022-03-12 00:26:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(513, 513, 15, '2022-03-12 00:26:34', '2022-03-12 00:26:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(514, 514, 15, '2022-03-12 00:26:38', '2022-03-12 00:26:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(515, 515, 15, '2022-03-12 00:26:40', '2022-03-12 00:26:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(516, 516, 15, '2022-03-12 00:26:45', '2022-03-12 00:26:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(517, 517, 15, '2022-03-12 00:26:48', '2022-03-12 00:26:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(518, 518, 15, '2022-03-12 00:26:51', '2022-03-12 00:26:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(519, 519, 15, '2022-03-12 00:26:53', '2022-03-12 00:26:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(520, 520, 15, '2022-03-12 00:26:56', '2022-03-12 00:26:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(521, 521, 15, '2022-03-12 00:33:53', '2022-03-12 00:33:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(522, 522, 15, '2022-03-12 00:34:01', '2022-03-12 00:34:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(523, 523, 15, '2022-03-12 00:34:04', '2022-03-12 00:34:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(524, 524, 15, '2022-03-12 00:34:05', '2022-03-12 00:34:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(525, 525, 15, '2022-03-12 00:34:11', '2022-03-12 00:34:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(526, 526, 15, '2022-03-12 00:34:15', '2022-03-12 00:34:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(527, 527, 15, '2022-03-12 00:34:18', '2022-03-12 00:34:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(528, 528, 15, '2022-03-12 00:34:21', '2022-03-12 00:34:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(529, 529, 15, '2022-03-12 00:34:24', '2022-03-12 00:34:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(530, 530, 15, '2022-03-12 00:34:30', '2022-03-12 00:34:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(531, 531, 15, '2022-03-12 00:34:32', '2022-03-12 00:34:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(532, 532, 15, '2022-03-12 00:34:34', '2022-03-12 00:34:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(533, 533, 15, '2022-03-12 00:34:35', '2022-03-12 00:34:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(534, 534, 15, '2022-03-12 00:45:08', '2022-03-12 00:45:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(535, 535, 15, '2022-03-12 00:45:11', '2022-03-12 00:45:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(536, 536, 15, '2022-03-12 00:45:12', '2022-03-12 00:45:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(537, 537, 15, '2022-03-12 00:45:17', '2022-03-12 00:45:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(538, 538, 15, '2022-03-12 00:45:20', '2022-03-12 00:45:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(539, 539, 15, '2022-03-12 00:45:24', '2022-03-12 00:45:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(540, 540, 15, '2022-03-12 00:45:28', '2022-03-12 00:45:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(541, 541, 15, '2022-03-12 00:45:32', '2022-03-12 00:45:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(542, 542, 15, '2022-03-12 00:45:36', '2022-03-12 00:45:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(543, 543, 15, '2022-03-12 00:45:39', '2022-03-12 00:45:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(544, 544, 15, '2022-03-12 00:45:44', '2022-03-12 00:45:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(545, 545, 15, '2022-03-12 00:45:46', '2022-03-12 00:45:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(546, 546, 15, '2022-03-12 00:48:08', '2022-03-12 00:48:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(547, 547, 15, '2022-03-12 00:48:11', '2022-03-12 00:48:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(548, 548, 15, '2022-03-12 00:48:12', '2022-03-12 00:48:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(549, 549, 15, '2022-03-12 00:48:19', '2022-03-12 00:48:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(550, 550, 15, '2022-03-12 00:48:25', '2022-03-12 00:48:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(551, 551, 15, '2022-03-12 00:48:34', '2022-03-12 00:48:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(552, 552, 15, '2022-03-12 00:48:40', '2022-03-12 00:48:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(553, 553, 15, '2022-03-12 00:48:44', '2022-03-12 00:48:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(554, 554, 15, '2022-03-12 00:48:48', '2022-03-12 00:48:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(555, 555, 15, '2022-03-12 00:48:53', '2022-03-12 00:48:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(556, 556, 15, '2022-03-12 00:48:59', '2022-03-12 00:48:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(557, 557, 15, '2022-03-12 00:49:06', '2022-03-12 00:49:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(558, 558, 15, '2022-03-12 01:06:33', '2022-03-12 01:06:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(559, 559, 15, '2022-03-12 01:06:36', '2022-03-12 01:06:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(560, 560, 15, '2022-03-12 01:06:37', '2022-03-12 01:06:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(561, 561, 15, '2022-03-12 01:06:43', '2022-03-12 01:06:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(562, 562, 15, '2022-03-12 01:06:45', '2022-03-12 01:06:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(563, 563, 15, '2022-03-12 01:06:50', '2022-03-12 01:06:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(564, 564, 15, '2022-03-12 01:06:54', '2022-03-12 01:06:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(565, 565, 15, '2022-03-12 01:06:57', '2022-03-12 01:06:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(566, 566, 15, '2022-03-12 01:07:01', '2022-03-12 01:07:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(567, 567, 15, '2022-03-12 01:07:05', '2022-03-12 01:07:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(568, 568, 15, '2022-03-12 01:07:09', '2022-03-12 01:07:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(569, 569, 15, '2022-03-12 01:07:11', '2022-03-12 01:07:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(570, 570, 15, '2022-03-12 01:26:18', '2022-03-12 01:26:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(571, 571, 15, '2022-03-12 01:26:21', '2022-03-12 01:26:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(572, 572, 15, '2022-03-12 01:26:22', '2022-03-12 01:26:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(573, 573, 15, '2022-03-12 01:26:27', '2022-03-12 01:26:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(574, 574, 15, '2022-03-12 01:26:32', '2022-03-12 01:26:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(575, 575, 15, '2022-03-12 01:26:36', '2022-03-12 01:26:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(576, 576, 15, '2022-03-12 01:26:41', '2022-03-12 01:26:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(577, 577, 15, '2022-03-12 01:26:45', '2022-03-12 01:26:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(578, 578, 15, '2022-03-12 01:26:49', '2022-03-12 01:26:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(579, 579, 15, '2022-03-12 01:26:54', '2022-03-12 01:26:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(580, 580, 15, '2022-03-12 01:26:58', '2022-03-12 01:26:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(581, 581, 15, '2022-03-12 01:27:00', '2022-03-12 01:27:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(582, 582, 15, '2022-03-12 01:28:21', '2022-03-12 01:28:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(583, 583, 15, '2022-03-12 01:28:24', '2022-03-12 01:28:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(584, 584, 15, '2022-03-12 01:28:25', '2022-03-12 01:28:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(585, 585, 15, '2022-03-12 01:28:33', '2022-03-12 01:28:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(586, 586, 15, '2022-03-12 01:28:37', '2022-03-12 01:28:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(587, 587, 15, '2022-03-12 01:28:43', '2022-03-12 01:28:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(588, 588, 15, '2022-03-12 01:28:47', '2022-03-12 01:28:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(589, 589, 15, '2022-03-12 01:28:52', '2022-03-12 01:28:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(590, 590, 15, '2022-03-12 01:28:55', '2022-03-12 01:28:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(591, 591, 15, '2022-03-12 01:28:59', '2022-03-12 01:28:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(592, 592, 15, '2022-03-12 01:29:03', '2022-03-12 01:29:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(593, 593, 15, '2022-03-12 01:31:48', '2022-03-12 01:31:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(594, 594, 15, '2022-03-12 01:31:49', '2022-03-12 01:31:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(595, 595, 15, '2022-03-12 01:31:57', '2022-03-12 01:31:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(596, 596, 15, '2022-03-12 01:38:05', '2022-03-12 01:38:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(597, 597, 15, '2022-03-12 01:38:09', '2022-03-12 01:38:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(598, 598, 15, '2022-03-12 01:39:33', '2022-03-12 01:39:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(599, 599, 15, '2022-03-12 01:39:40', '2022-03-12 01:39:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(600, 600, 15, '2022-03-12 01:39:46', '2022-03-12 01:39:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(601, 601, 15, '2022-03-12 01:39:51', '2022-03-12 01:39:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(602, 602, 15, '2022-03-12 01:39:59', '2022-03-12 01:39:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(603, 603, 15, '2022-03-12 01:40:04', '2022-03-12 01:40:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(604, 604, 15, '2022-03-12 01:40:09', '2022-03-12 01:40:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(605, 605, 15, '2022-03-12 01:40:13', '2022-03-12 01:40:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(606, 606, 15, '2022-03-12 01:40:18', '2022-03-12 01:40:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(607, 607, 15, '2022-03-12 01:40:23', '2022-03-12 01:40:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(608, 608, 15, '2022-03-12 01:40:27', '2022-03-12 01:40:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(609, 609, 15, '2022-03-12 01:40:32', '2022-03-12 01:40:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(610, 610, 15, '2022-03-12 01:40:37', '2022-03-12 01:40:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(611, 611, 15, '2022-03-12 01:43:00', '2022-03-12 01:43:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(612, 612, 15, '2022-03-12 01:43:02', '2022-03-12 01:43:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(613, 613, 15, '2022-03-12 01:43:02', '2022-03-12 01:43:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(614, 614, 15, '2022-03-12 01:43:03', '2022-03-12 01:43:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(615, 615, 15, '2022-03-12 01:43:03', '2022-03-12 01:43:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(616, 616, 15, '2022-03-12 01:43:03', '2022-03-12 01:43:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(617, 617, 15, '2022-03-12 01:43:04', '2022-03-12 01:43:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(618, 618, 15, '2022-03-12 01:43:04', '2022-03-12 01:43:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(619, 619, 15, '2022-03-12 01:43:04', '2022-03-12 01:43:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(620, 620, 15, '2022-03-12 01:43:05', '2022-03-12 01:43:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(621, 621, 15, '2022-03-12 01:43:05', '2022-03-12 01:43:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(622, 622, 15, '2022-03-12 01:43:16', '2022-03-12 01:43:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(623, 623, 15, '2022-03-12 01:43:17', '2022-03-12 01:43:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(624, 624, 15, '2022-03-12 01:43:18', '2022-03-12 01:43:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(625, 625, 15, '2022-03-12 01:43:18', '2022-03-12 01:43:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(626, 626, 15, '2022-03-12 01:43:18', '2022-03-12 01:43:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(627, 627, 15, '2022-03-12 01:43:19', '2022-03-12 01:43:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(628, 628, 15, '2022-03-12 01:43:19', '2022-03-12 01:43:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(629, 629, 15, '2022-03-12 01:43:20', '2022-03-12 01:43:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(630, 630, 15, '2022-03-12 01:43:20', '2022-03-12 01:43:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(631, 631, 15, '2022-03-12 01:43:21', '2022-03-12 01:43:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(632, 632, 15, '2022-03-12 01:43:22', '2022-03-12 01:43:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(633, 633, 15, '2022-03-12 01:43:22', '2022-03-12 01:43:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(634, 634, 15, '2022-03-12 01:43:23', '2022-03-12 01:43:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(635, 635, 15, '2022-03-12 01:43:38', '2022-03-12 01:43:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(636, 636, 15, '2022-03-12 01:43:43', '2022-03-12 01:43:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(637, 637, 15, '2022-03-12 01:43:47', '2022-03-12 01:43:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(638, 638, 15, '2022-03-12 01:43:50', '2022-03-12 01:43:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(639, 639, 15, '2022-03-12 01:43:53', '2022-03-12 01:43:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(640, 640, 15, '2022-03-12 01:43:57', '2022-03-12 01:43:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(641, 641, 15, '2022-03-12 01:44:02', '2022-03-12 01:44:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(642, 642, 15, '2022-03-12 01:44:04', '2022-03-12 01:44:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(643, 643, 15, '2022-03-12 01:44:08', '2022-03-12 01:44:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(644, 644, 15, '2022-03-12 01:44:12', '2022-03-12 01:44:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(645, 645, 15, '2022-03-12 01:44:17', '2022-03-12 01:44:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(646, 646, 15, '2022-03-12 01:44:21', '2022-03-12 01:44:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(647, 647, 15, '2022-03-12 01:44:26', '2022-03-12 01:44:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(648, 648, 15, '2022-03-12 01:44:33', '2022-03-12 01:44:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(649, 649, 15, '2022-03-12 01:44:37', '2022-03-12 01:44:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(650, 650, 15, '2022-03-12 01:44:40', '2022-03-12 01:44:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(651, 651, 15, '2022-03-12 01:44:45', '2022-03-12 01:44:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(652, 652, 15, '2022-03-12 01:44:48', '2022-03-12 01:44:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(653, 653, 15, '2022-03-12 01:44:51', '2022-03-12 01:44:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(654, 654, 15, '2022-03-12 01:44:54', '2022-03-12 01:44:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(655, 655, 15, '2022-03-12 01:44:58', '2022-03-12 01:44:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(656, 656, 15, '2022-03-12 01:45:03', '2022-03-12 01:45:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(657, 657, 15, '2022-03-12 01:45:08', '2022-03-12 01:45:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(658, 658, 15, '2022-03-12 01:45:13', '2022-03-12 01:45:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(659, 659, 15, '2022-03-12 01:45:16', '2022-03-12 01:45:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(660, 660, 15, '2022-03-12 01:45:21', '2022-03-12 01:45:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(661, 661, 15, '2022-03-12 01:45:25', '2022-03-12 01:45:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(662, 662, 15, '2022-03-12 01:45:30', '2022-03-12 01:45:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(663, 663, 15, '2022-03-12 01:45:36', '2022-03-12 01:45:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(664, 664, 15, '2022-03-12 01:45:40', '2022-03-12 01:45:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(665, 665, 15, '2022-03-12 01:45:45', '2022-03-12 01:45:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(666, 666, 15, '2022-03-12 01:45:49', '2022-03-12 01:45:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(667, 667, 15, '2022-03-12 01:45:55', '2022-03-12 01:45:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(668, 668, 15, '2022-03-12 01:46:00', '2022-03-12 01:46:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(669, 669, 15, '2022-03-12 01:46:05', '2022-03-12 01:46:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(670, 670, 15, '2022-03-12 01:46:08', '2022-03-12 01:46:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(671, 671, 15, '2022-03-12 01:46:12', '2022-03-12 01:46:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(672, 672, 15, '2022-03-12 01:46:15', '2022-03-12 01:46:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(673, 673, 15, '2022-03-12 01:46:22', '2022-03-12 01:46:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(674, 674, 15, '2022-03-12 01:46:26', '2022-03-12 01:46:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(675, 675, 15, '2022-03-12 01:46:35', '2022-03-12 01:46:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(676, 676, 15, '2022-03-12 01:46:41', '2022-03-12 01:46:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(677, 677, 15, '2022-03-12 01:46:46', '2022-03-12 01:46:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(678, 678, 15, '2022-03-12 01:46:51', '2022-03-12 01:46:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(679, 679, 15, '2022-03-12 01:46:54', '2022-03-12 01:46:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(680, 680, 15, '2022-03-12 01:46:59', '2022-03-12 01:46:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(681, 681, 15, '2022-03-12 01:47:02', '2022-03-12 01:47:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(682, 682, 15, '2022-03-12 01:47:05', '2022-03-12 01:47:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(683, 683, 15, '2022-03-12 01:47:09', '2022-03-12 01:47:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(684, 684, 15, '2022-03-12 01:47:11', '2022-03-12 01:47:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(685, 685, 15, '2022-03-12 01:47:16', '2022-03-12 01:47:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(686, 686, 15, '2022-03-12 01:47:19', '2022-03-12 01:47:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(687, 687, 15, '2022-03-12 01:47:25', '2022-03-12 01:47:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(688, 688, 15, '2022-03-12 01:47:28', '2022-03-12 01:47:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(689, 689, 15, '2022-03-12 01:47:34', '2022-03-12 01:47:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(690, 690, 15, '2022-03-12 01:47:37', '2022-03-12 01:47:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(691, 691, 15, '2022-03-12 01:47:42', '2022-03-12 01:47:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(692, 692, 15, '2022-03-12 01:47:46', '2022-03-12 01:47:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(693, 693, 12, '2022-03-12 01:54:59', '2022-03-12 01:54:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(694, 694, 12, '2022-03-12 01:55:00', '2022-03-12 01:55:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(695, 695, 12, '2022-03-12 01:55:00', '2022-03-12 01:55:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(696, 696, 12, '2022-03-12 01:55:02', '2022-03-12 01:55:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(697, 697, 12, '2022-03-12 01:55:09', '2022-03-12 01:55:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(698, 698, 12, '2022-03-12 01:55:10', '2022-03-12 01:55:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(699, 699, 12, '2022-03-12 01:55:12', '2022-03-12 01:55:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(700, 700, 12, '2022-03-12 01:55:13', '2022-03-12 01:55:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(701, 701, 12, '2022-03-12 01:55:14', '2022-03-12 01:55:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(702, 702, 12, '2022-03-12 01:55:15', '2022-03-12 01:55:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(703, 703, 12, '2022-03-12 01:55:16', '2022-03-12 01:55:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(704, 704, 12, '2022-03-12 01:55:17', '2022-03-12 01:55:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(705, 705, 12, '2022-03-12 01:55:18', '2022-03-12 01:55:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(706, 706, 12, '2022-03-12 01:55:19', '2022-03-12 01:55:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(707, 707, 12, '2022-03-12 01:55:22', '2022-03-12 01:55:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(708, 708, 12, '2022-03-12 01:55:26', '2022-03-12 01:55:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(709, 709, 12, '2022-03-12 01:55:27', '2022-03-12 01:55:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(710, 710, 12, '2022-03-12 01:55:33', '2022-03-12 01:55:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(711, 711, 12, '2022-03-12 01:55:44', '2022-03-12 01:55:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(712, 712, 12, '2022-03-12 01:55:47', '2022-03-12 01:55:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(713, 713, 12, '2022-03-12 01:55:50', '2022-03-12 01:55:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(714, 714, 12, '2022-03-12 01:55:56', '2022-03-12 01:55:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(715, 715, 12, '2022-03-12 01:56:01', '2022-03-12 01:56:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(716, 716, 12, '2022-03-12 01:56:05', '2022-03-12 01:56:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(717, 717, 12, '2022-03-12 01:56:09', '2022-03-12 01:56:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(718, 718, 12, '2022-03-12 01:56:12', '2022-03-12 01:56:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(719, 719, 12, '2022-03-12 01:56:18', '2022-03-12 01:56:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(720, 720, 12, '2022-03-12 01:56:22', '2022-03-12 01:56:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(721, 721, 12, '2022-03-12 01:56:26', '2022-03-12 01:56:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(722, 722, 12, '2022-03-12 01:56:30', '2022-03-12 01:56:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(723, 723, 12, '2022-03-12 01:56:33', '2022-03-12 01:56:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(724, 724, 12, '2022-03-12 01:56:38', '2022-03-12 01:56:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(725, 725, 12, '2022-03-12 01:56:43', '2022-03-12 01:56:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(726, 726, 12, '2022-03-12 01:56:48', '2022-03-12 01:56:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(727, 727, 12, '2022-03-12 01:56:52', '2022-03-12 01:56:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(728, 728, 12, '2022-03-12 01:57:00', '2022-03-12 01:57:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(729, 729, 12, '2022-03-12 01:57:05', '2022-03-12 01:57:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(730, 730, 12, '2022-03-12 01:57:08', '2022-03-12 01:57:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(731, 731, 12, '2022-03-12 01:57:15', '2022-03-12 01:57:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(732, 732, 12, '2022-03-12 01:57:18', '2022-03-12 01:57:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(733, 733, 12, '2022-03-12 01:57:24', '2022-03-12 01:57:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(734, 734, 12, '2022-03-12 01:57:26', '2022-03-12 01:57:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(735, 735, 12, '2022-03-12 01:57:31', '2022-03-12 01:57:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(736, 736, 12, '2022-03-12 01:57:35', '2022-03-12 01:57:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(737, 737, 12, '2022-03-12 01:57:39', '2022-03-12 01:57:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(738, 738, 12, '2022-03-12 01:57:46', '2022-03-12 01:57:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(739, 739, 12, '2022-03-12 01:57:49', '2022-03-12 01:57:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(740, 740, 12, '2022-03-12 01:57:53', '2022-03-12 01:57:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(741, 741, 12, '2022-03-12 01:57:57', '2022-03-12 01:57:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(742, 742, 12, '2022-03-12 01:58:01', '2022-03-12 01:58:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(743, 743, 12, '2022-03-12 01:58:05', '2022-03-12 01:58:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(744, 744, 12, '2022-03-12 01:58:08', '2022-03-12 01:58:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(745, 745, 12, '2022-03-12 01:58:11', '2022-03-12 01:58:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(746, 746, 12, '2022-03-12 01:58:18', '2022-03-12 01:58:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(747, 747, 12, '2022-03-12 01:58:21', '2022-03-12 01:58:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(748, 748, 12, '2022-03-12 01:58:25', '2022-03-12 01:58:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(749, 749, 12, '2022-03-12 01:58:30', '2022-03-12 01:58:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(750, 750, 12, '2022-03-12 01:58:35', '2022-03-12 01:58:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(751, 751, 12, '2022-03-12 01:58:41', '2022-03-12 01:58:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(752, 752, 12, '2022-03-12 01:58:45', '2022-03-12 01:58:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(753, 753, 12, '2022-03-12 01:58:47', '2022-03-12 01:58:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(754, 754, 12, '2022-03-12 01:58:51', '2022-03-12 01:58:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(755, 755, 12, '2022-03-12 01:58:54', '2022-03-12 01:58:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(756, 756, 12, '2022-03-12 01:58:57', '2022-03-12 01:58:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(757, 757, 12, '2022-03-12 01:59:02', '2022-03-12 01:59:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(758, 758, 12, '2022-03-12 01:59:04', '2022-03-12 01:59:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(759, 759, 12, '2022-03-12 01:59:09', '2022-03-12 01:59:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(760, 760, 12, '2022-03-12 01:59:12', '2022-03-12 01:59:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(761, 761, 12, '2022-03-12 01:59:15', '2022-03-12 01:59:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(762, 762, 12, '2022-03-12 01:59:18', '2022-03-12 01:59:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(763, 763, 12, '2022-03-12 01:59:21', '2022-03-12 01:59:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(764, 764, 12, '2022-03-12 01:59:27', '2022-03-12 01:59:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(765, 765, 12, '2022-03-12 01:59:32', '2022-03-12 01:59:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(766, 766, 12, '2022-03-12 01:59:38', '2022-03-12 01:59:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(767, 767, 12, '2022-03-12 01:59:43', '2022-03-12 01:59:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(768, 768, 12, '2022-03-12 01:59:47', '2022-03-12 01:59:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(769, 769, 12, '2022-03-12 01:59:54', '2022-03-12 01:59:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(770, 770, 12, '2022-03-12 01:59:58', '2022-03-12 01:59:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(771, 771, 12, '2022-03-12 02:00:04', '2022-03-12 02:00:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(772, 772, 12, '2022-03-12 02:00:07', '2022-03-12 02:00:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(773, 773, 12, '2022-03-12 02:00:12', '2022-03-12 02:00:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(774, 774, 12, '2022-03-12 02:00:17', '2022-03-12 02:00:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(775, 775, 12, '2022-03-12 02:00:21', '2022-03-12 02:00:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(776, 776, 12, '2022-03-12 02:00:27', '2022-03-12 02:00:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(777, 777, 12, '2022-03-12 02:00:32', '2022-03-12 02:00:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(778, 778, 12, '2022-03-12 02:00:34', '2022-03-12 02:00:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(779, 779, 12, '2022-03-12 02:00:38', '2022-03-12 02:00:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(780, 780, 12, '2022-03-12 02:00:43', '2022-03-12 02:00:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(781, 781, 12, '2022-03-12 02:00:48', '2022-03-12 02:00:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(782, 782, 12, '2022-03-12 02:00:54', '2022-03-12 02:00:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(783, 783, 12, '2022-03-12 02:00:59', '2022-03-12 02:00:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(784, 784, 12, '2022-03-12 02:01:03', '2022-03-12 02:01:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(785, 785, 12, '2022-03-12 02:01:08', '2022-03-12 02:01:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(786, 786, 12, '2022-03-12 02:01:12', '2022-03-12 02:01:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(787, 787, 12, '2022-03-12 02:01:17', '2022-03-12 02:01:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(788, 788, 12, '2022-03-12 02:01:21', '2022-03-12 02:01:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(789, 789, 12, '2022-03-12 02:01:26', '2022-03-12 02:01:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(790, 790, 12, '2022-03-12 02:01:31', '2022-03-12 02:01:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(791, 791, 12, '2022-03-12 02:01:35', '2022-03-12 02:01:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(792, 792, 12, '2022-03-12 02:01:37', '2022-03-12 02:01:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(793, 793, 12, '2022-03-12 02:01:42', '2022-03-12 02:01:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(794, 794, 12, '2022-03-12 02:01:42', '2022-03-12 02:01:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(795, 795, 12, '2022-03-12 02:01:48', '2022-03-12 02:01:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(796, 796, 12, '2022-03-12 02:01:50', '2022-03-12 02:01:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(797, 798, 12, '2022-03-12 02:01:52', '2022-03-12 02:01:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(798, 797, 12, '2022-03-12 02:01:52', '2022-03-12 02:01:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(799, 799, 12, '2022-03-12 02:01:58', '2022-03-12 02:01:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(800, 800, 12, '2022-03-12 02:02:03', '2022-03-12 02:02:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(801, 801, 12, '2022-03-12 02:02:08', '2022-03-12 02:02:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(802, 802, 12, '2022-03-12 02:02:11', '2022-03-12 02:02:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(803, 803, 12, '2022-03-12 02:02:13', '2022-03-12 02:02:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(804, 804, 12, '2022-03-12 02:02:19', '2022-03-12 02:02:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(805, 805, 12, '2022-03-12 02:02:19', '2022-03-12 02:02:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(806, 806, 12, '2022-03-12 02:02:23', '2022-03-12 02:02:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(807, 807, 12, '2022-03-12 02:02:24', '2022-03-12 02:02:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(808, 808, 12, '2022-03-12 02:02:27', '2022-03-12 02:02:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(809, 809, 12, '2022-03-12 02:02:28', '2022-03-12 02:02:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(810, 810, 12, '2022-03-12 02:02:31', '2022-03-12 02:02:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(811, 811, 12, '2022-03-12 02:02:33', '2022-03-12 02:02:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(812, 812, 12, '2022-03-12 02:02:34', '2022-03-12 02:02:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(813, 813, 12, '2022-03-12 02:02:39', '2022-03-12 02:02:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(814, 814, 12, '2022-03-12 02:02:39', '2022-03-12 02:02:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(815, 815, 12, '2022-03-12 02:02:43', '2022-03-12 02:02:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(816, 816, 12, '2022-03-12 02:02:45', '2022-03-12 02:02:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(817, 817, 12, '2022-03-12 02:02:46', '2022-03-12 02:02:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(818, 818, 12, '2022-03-12 02:02:48', '2022-03-12 02:02:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(819, 819, 12, '2022-03-12 02:02:50', '2022-03-12 02:02:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(820, 820, 12, '2022-03-12 02:02:52', '2022-03-12 02:02:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(821, 821, 12, '2022-03-12 02:02:52', '2022-03-12 02:02:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(822, 822, 12, '2022-03-12 02:02:55', '2022-03-12 02:02:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(823, 823, 12, '2022-03-12 02:02:56', '2022-03-12 02:02:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(824, 824, 12, '2022-03-12 02:02:59', '2022-03-12 02:02:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(825, 825, 12, '2022-03-12 02:03:00', '2022-03-12 02:03:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(826, 826, 12, '2022-03-12 02:03:06', '2022-03-12 02:03:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(827, 827, 12, '2022-03-12 02:03:11', '2022-03-12 02:03:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(828, 828, 12, '2022-03-12 02:03:11', '2022-03-12 02:03:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(829, 829, 12, '2022-03-12 02:03:14', '2022-03-12 02:03:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(830, 830, 12, '2022-03-12 02:03:16', '2022-03-12 02:03:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(831, 831, 12, '2022-03-12 02:03:18', '2022-03-12 02:03:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(832, 832, 12, '2022-03-12 02:03:19', '2022-03-12 02:03:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(833, 833, 12, '2022-03-12 02:03:22', '2022-03-12 02:03:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(834, 834, 12, '2022-03-12 02:03:23', '2022-03-12 02:03:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(835, 835, 12, '2022-03-12 02:03:24', '2022-03-12 02:03:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(836, 836, 12, '2022-03-12 02:03:27', '2022-03-12 02:03:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(837, 838, 12, '2022-03-12 02:03:31', '2022-03-12 02:03:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(838, 837, 12, '2022-03-12 02:03:31', '2022-03-12 02:03:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(839, 839, 12, '2022-03-12 02:03:35', '2022-03-12 02:03:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(840, 840, 12, '2022-03-12 02:03:35', '2022-03-12 02:03:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(841, 842, 12, '2022-03-12 02:03:40', '2022-03-12 02:03:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(842, 841, 12, '2022-03-12 02:03:40', '2022-03-12 02:03:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(843, 843, 12, '2022-03-12 02:03:43', '2022-03-12 02:03:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(844, 844, 12, '2022-03-12 02:03:43', '2022-03-12 02:03:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(845, 845, 12, '2022-03-12 02:03:47', '2022-03-12 02:03:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(846, 846, 12, '2022-03-12 02:03:49', '2022-03-12 02:03:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(847, 847, 12, '2022-03-12 02:03:50', '2022-03-12 02:03:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(848, 848, 12, '2022-03-12 02:03:54', '2022-03-12 02:03:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(849, 849, 12, '2022-03-12 02:03:55', '2022-03-12 02:03:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(850, 850, 12, '2022-03-12 02:03:58', '2022-03-12 02:03:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(851, 851, 12, '2022-03-12 02:04:00', '2022-03-12 02:04:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(852, 852, 12, '2022-03-12 02:04:01', '2022-03-12 02:04:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(853, 853, 12, '2022-03-12 02:04:04', '2022-03-12 02:04:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(854, 854, 12, '2022-03-12 02:04:07', '2022-03-12 02:04:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(855, 855, 12, '2022-03-12 02:04:07', '2022-03-12 02:04:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(856, 856, 12, '2022-03-12 02:04:10', '2022-03-12 02:04:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(857, 857, 12, '2022-03-12 02:04:15', '2022-03-12 02:04:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(858, 858, 12, '2022-03-12 02:04:16', '2022-03-12 02:04:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(859, 859, 12, '2022-03-12 02:04:22', '2022-03-12 02:04:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(860, 860, 12, '2022-03-12 02:04:23', '2022-03-12 02:04:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(861, 861, 12, '2022-03-12 02:04:25', '2022-03-12 02:04:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(862, 862, 12, '2022-03-12 02:04:27', '2022-03-12 02:04:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(863, 863, 12, '2022-03-12 02:04:28', '2022-03-12 02:04:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(864, 864, 12, '2022-03-12 02:04:30', '2022-03-12 02:04:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(865, 865, 12, '2022-03-12 02:04:32', '2022-03-12 02:04:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(866, 866, 12, '2022-03-12 02:04:35', '2022-03-12 02:04:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(867, 867, 12, '2022-03-12 02:04:36', '2022-03-12 02:04:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(868, 868, 12, '2022-03-12 02:04:40', '2022-03-12 02:04:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(869, 869, 12, '2022-03-12 02:04:41', '2022-03-12 02:04:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(870, 870, 12, '2022-03-12 02:04:43', '2022-03-12 02:04:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(871, 871, 12, '2022-03-12 02:04:45', '2022-03-12 02:04:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(872, 872, 12, '2022-03-12 02:04:46', '2022-03-12 02:04:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(873, 873, 12, '2022-03-12 02:04:49', '2022-03-12 02:04:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(874, 874, 12, '2022-03-12 02:04:50', '2022-03-12 02:04:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(875, 875, 12, '2022-03-12 02:04:54', '2022-03-12 02:04:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(876, 876, 12, '2022-03-12 02:04:57', '2022-03-12 02:04:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(877, 877, 12, '2022-03-12 02:05:06', '2022-03-12 02:05:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(878, 878, 12, '2022-03-12 02:05:11', '2022-03-12 02:05:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(879, 879, 12, '2022-03-12 02:05:18', '2022-03-12 02:05:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(880, 880, 12, '2022-03-12 02:05:22', '2022-03-12 02:05:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(881, 881, 12, '2022-03-12 02:05:25', '2022-03-12 02:05:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(882, 882, 12, '2022-03-12 02:05:27', '2022-03-12 02:05:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(883, 883, 12, '2022-03-12 02:05:31', '2022-03-12 02:05:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(884, 884, 12, '2022-03-12 02:05:34', '2022-03-12 02:05:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(885, 885, 12, '2022-03-12 02:05:38', '2022-03-12 02:05:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(886, 886, 12, '2022-03-12 02:05:42', '2022-03-12 02:05:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(887, 887, 12, '2022-03-12 02:05:46', '2022-03-12 02:05:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(888, 888, 12, '2022-03-12 02:05:50', '2022-03-12 02:05:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(889, 889, 12, '2022-03-12 02:05:57', '2022-03-12 02:05:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(890, 890, 12, '2022-03-12 02:06:01', '2022-03-12 02:06:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(891, 891, 12, '2022-03-12 02:06:04', '2022-03-12 02:06:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(892, 892, 12, '2022-03-12 02:06:08', '2022-03-12 02:06:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(893, 893, 12, '2022-03-12 02:06:11', '2022-03-12 02:06:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(894, 894, 12, '2022-03-12 02:06:16', '2022-03-12 02:06:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(895, 895, 12, '2022-03-12 02:06:19', '2022-03-12 02:06:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(896, 896, 12, '2022-03-12 02:06:24', '2022-03-12 02:06:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(897, 897, 12, '2022-03-12 02:06:27', '2022-03-12 02:06:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(898, 898, 12, '2022-03-12 02:06:31', '2022-03-12 02:06:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(899, 899, 12, '2022-03-12 02:06:47', '2022-03-12 02:06:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(900, 900, 12, '2022-03-12 02:06:53', '2022-03-12 02:06:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(901, 901, 12, '2022-03-12 02:06:55', '2022-03-12 02:06:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(902, 902, 12, '2022-03-12 02:07:00', '2022-03-12 02:07:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(903, 903, 12, '2022-03-12 02:07:01', '2022-03-12 02:07:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(904, 904, 12, '2022-03-12 02:07:05', '2022-03-12 02:07:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(905, 905, 12, '2022-03-12 02:07:10', '2022-03-12 02:07:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(906, 906, 12, '2022-03-12 02:07:14', '2022-03-12 02:07:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(907, 907, 12, '2022-03-12 02:07:15', '2022-03-12 02:07:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(908, 908, 12, '2022-03-12 02:07:17', '2022-03-12 02:07:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(909, 909, 12, '2022-03-12 02:07:20', '2022-03-12 02:07:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(910, 910, 12, '2022-03-12 02:07:23', '2022-03-12 02:07:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(911, 911, 12, '2022-03-12 02:07:29', '2022-03-12 02:07:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(912, 912, 12, '2022-03-12 02:07:32', '2022-03-12 02:07:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(913, 913, 12, '2022-03-12 02:07:34', '2022-03-12 02:07:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(914, 914, 12, '2022-03-12 02:07:37', '2022-03-12 02:07:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(915, 915, 12, '2022-03-12 02:07:38', '2022-03-12 02:07:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(916, 916, 12, '2022-03-12 02:07:43', '2022-03-12 02:07:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(917, 917, 12, '2022-03-12 02:07:48', '2022-03-12 02:07:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(918, 918, 12, '2022-03-12 02:07:52', '2022-03-12 02:07:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(919, 919, 12, '2022-03-12 02:07:56', '2022-03-12 02:07:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(920, 920, 12, '2022-03-12 02:08:02', '2022-03-12 02:08:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(921, 921, 12, '2022-03-12 02:08:06', '2022-03-12 02:08:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(922, 922, 12, '2022-03-12 02:08:07', '2022-03-12 02:08:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(923, 923, 12, '2022-03-12 02:08:11', '2022-03-12 02:08:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(924, 924, 12, '2022-03-12 02:08:16', '2022-03-12 02:08:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(925, 925, 12, '2022-03-12 02:08:17', '2022-03-12 02:08:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(926, 926, 12, '2022-03-12 02:08:21', '2022-03-12 02:08:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(927, 927, 12, '2022-03-12 02:08:21', '2022-03-12 02:08:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(928, 928, 12, '2022-03-12 02:08:26', '2022-03-12 02:08:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(929, 929, 12, '2022-03-12 02:08:26', '2022-03-12 02:08:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(930, 930, 12, '2022-03-12 02:08:29', '2022-03-12 02:08:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(931, 931, 12, '2022-03-12 02:08:31', '2022-03-12 02:08:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(932, 932, 12, '2022-03-12 02:08:32', '2022-03-12 02:08:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(933, 933, 12, '2022-03-12 02:08:35', '2022-03-12 02:08:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(934, 934, 12, '2022-03-12 02:08:36', '2022-03-12 02:08:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(935, 935, 12, '2022-03-12 02:08:40', '2022-03-12 02:08:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(936, 936, 12, '2022-03-12 02:08:40', '2022-03-12 02:08:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(937, 937, 12, '2022-03-12 02:08:45', '2022-03-12 02:08:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(938, 938, 12, '2022-03-12 02:08:46', '2022-03-12 02:08:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(939, 939, 12, '2022-03-12 02:08:49', '2022-03-12 02:08:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(940, 940, 12, '2022-03-12 02:08:50', '2022-03-12 02:08:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(941, 941, 12, '2022-03-12 02:08:54', '2022-03-12 02:08:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(942, 942, 12, '2022-03-12 02:08:56', '2022-03-12 02:08:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(943, 943, 12, '2022-03-12 02:08:59', '2022-03-12 02:08:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(944, 944, 12, '2022-03-12 02:09:00', '2022-03-12 02:09:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(945, 945, 12, '2022-03-12 02:09:04', '2022-03-12 02:09:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(946, 946, 12, '2022-03-12 02:09:05', '2022-03-12 02:09:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(947, 947, 12, '2022-03-12 02:09:08', '2022-03-12 02:09:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(948, 948, 12, '2022-03-12 02:09:09', '2022-03-12 02:09:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(949, 949, 12, '2022-03-12 02:09:14', '2022-03-12 02:09:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(950, 950, 12, '2022-03-12 02:09:15', '2022-03-12 02:09:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(951, 951, 12, '2022-03-12 02:09:21', '2022-03-12 02:09:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(952, 952, 12, '2022-03-12 02:09:21', '2022-03-12 02:09:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(953, 953, 12, '2022-03-12 02:09:24', '2022-03-12 02:09:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(954, 954, 12, '2022-03-12 02:09:26', '2022-03-12 02:09:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(955, 955, 12, '2022-03-12 02:09:28', '2022-03-12 02:09:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(956, 956, 12, '2022-03-12 02:09:31', '2022-03-12 02:09:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(957, 957, 12, '2022-03-12 02:09:33', '2022-03-12 02:09:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(958, 958, 12, '2022-03-12 02:09:37', '2022-03-12 02:09:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(959, 959, 12, '2022-03-12 02:09:40', '2022-03-12 02:09:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(960, 960, 12, '2022-03-12 02:09:41', '2022-03-12 02:09:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(961, 961, 12, '2022-03-12 02:09:44', '2022-03-12 02:09:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(962, 962, 12, '2022-03-12 02:09:45', '2022-03-12 02:09:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(963, 963, 12, '2022-03-12 02:09:50', '2022-03-12 02:09:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(964, 964, 12, '2022-03-12 02:09:50', '2022-03-12 02:09:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(965, 965, 12, '2022-03-12 02:09:54', '2022-03-12 02:09:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(966, 966, 12, '2022-03-12 02:09:55', '2022-03-12 02:09:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(967, 967, 12, '2022-03-12 02:10:00', '2022-03-12 02:10:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(968, 968, 12, '2022-03-12 02:10:00', '2022-03-12 02:10:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(969, 969, 12, '2022-03-12 02:10:12', '2022-03-12 02:10:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(970, 970, 12, '2022-03-12 02:10:13', '2022-03-12 02:10:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(971, 971, 12, '2022-03-12 02:10:16', '2022-03-12 02:10:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(972, 972, 12, '2022-03-12 02:10:17', '2022-03-12 02:10:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(973, 973, 12, '2022-03-12 02:10:20', '2022-03-12 02:10:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(974, 974, 12, '2022-03-12 02:10:21', '2022-03-12 02:10:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(975, 1, 15, '2022-03-12 02:14:24', '2022-03-12 02:14:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(976, 2, 15, '2022-03-12 02:14:24', '2022-03-12 02:14:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(977, 3, 15, '2022-03-12 02:14:24', '2022-03-12 02:14:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(978, 4, 15, '2022-03-12 02:14:28', '2022-03-12 02:14:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(979, 5, 15, '2022-03-12 02:14:29', '2022-03-12 02:14:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(980, 6, 15, '2022-03-12 02:14:30', '2022-03-12 02:14:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(981, 7, 15, '2022-03-12 02:14:31', '2022-03-12 02:14:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(982, 8, 15, '2022-03-12 02:14:32', '2022-03-12 02:14:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(983, 9, 15, '2022-03-12 02:14:34', '2022-03-12 02:14:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(984, 10, 15, '2022-03-12 02:14:35', '2022-03-12 02:14:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(985, 11, 15, '2022-03-12 02:14:36', '2022-03-12 02:14:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(986, 12, 15, '2022-03-12 02:14:37', '2022-03-12 02:14:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(987, 13, 15, '2022-03-12 02:14:37', '2022-03-12 02:14:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(988, 14, 15, '2022-03-12 02:14:39', '2022-03-12 02:14:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(989, 15, 15, '2022-03-12 02:14:40', '2022-03-12 02:14:40');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(990, 16, 15, '2022-03-12 02:14:41', '2022-03-12 02:14:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(991, 17, 15, '2022-03-12 02:14:42', '2022-03-12 02:14:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(992, 18, 15, '2022-03-12 02:14:43', '2022-03-12 02:14:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(993, 19, 15, '2022-03-12 02:14:45', '2022-03-12 02:14:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(994, 20, 15, '2022-03-12 02:14:46', '2022-03-12 02:14:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(995, 21, 15, '2022-03-12 02:14:47', '2022-03-12 02:14:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(996, 22, 15, '2022-03-12 02:14:47', '2022-03-12 02:14:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(997, 23, 15, '2022-03-12 02:14:49', '2022-03-12 02:14:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(998, 24, 15, '2022-03-12 02:14:50', '2022-03-12 02:14:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(999, 25, 15, '2022-03-12 02:14:51', '2022-03-12 02:14:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1000, 26, 15, '2022-03-12 02:14:52', '2022-03-12 02:14:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1001, 27, 15, '2022-03-12 02:14:53', '2022-03-12 02:14:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1002, 28, 15, '2022-03-12 02:14:54', '2022-03-12 02:14:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1003, 29, 15, '2022-03-12 02:14:55', '2022-03-12 02:14:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1004, 30, 15, '2022-03-12 02:14:56', '2022-03-12 02:14:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1005, 31, 15, '2022-03-12 02:14:57', '2022-03-12 02:14:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1006, 32, 15, '2022-03-12 02:14:59', '2022-03-12 02:14:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1007, 33, 15, '2022-03-12 02:14:59', '2022-03-12 02:14:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1008, 34, 15, '2022-03-12 02:14:59', '2022-03-12 02:14:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1009, 35, 15, '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1010, 36, 15, '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1011, 37, 15, '2022-03-12 02:15:00', '2022-03-12 02:15:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1012, 38, 15, '2022-03-12 02:15:01', '2022-03-12 02:15:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1013, 39, 15, '2022-03-12 02:15:01', '2022-03-12 02:15:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1014, 40, 15, '2022-03-12 02:15:01', '2022-03-12 02:15:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1015, 41, 15, '2022-03-12 02:15:02', '2022-03-12 02:15:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1016, 42, 15, '2022-03-12 02:15:03', '2022-03-12 02:15:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1017, 43, 15, '2022-03-12 02:15:03', '2022-03-12 02:15:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1018, 44, 15, '2022-03-12 02:15:04', '2022-03-12 02:15:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1019, 45, 15, '2022-03-12 02:15:04', '2022-03-12 02:15:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1020, 46, 15, '2022-03-12 02:15:05', '2022-03-12 02:15:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1021, 47, 15, '2022-03-12 02:15:05', '2022-03-12 02:15:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1022, 48, 15, '2022-03-12 02:15:05', '2022-03-12 02:15:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1023, 49, 15, '2022-03-12 02:15:06', '2022-03-12 02:15:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1024, 50, 15, '2022-03-12 02:15:06', '2022-03-12 02:15:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1025, 51, 15, '2022-03-12 02:15:07', '2022-03-12 02:15:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1026, 52, 15, '2022-03-12 02:15:07', '2022-03-12 02:15:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1027, 53, 15, '2022-03-12 02:15:08', '2022-03-12 02:15:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1028, 54, 15, '2022-03-12 02:15:09', '2022-03-12 02:15:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1029, 55, 15, '2022-03-12 02:15:16', '2022-03-12 02:15:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1030, 56, 15, '2022-03-12 02:15:22', '2022-03-12 02:15:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1031, 57, 15, '2022-03-12 02:15:25', '2022-03-12 02:15:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1032, 58, 15, '2022-03-12 02:15:29', '2022-03-12 02:15:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1033, 59, 15, '2022-03-12 02:15:33', '2022-03-12 02:15:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1034, 60, 15, '2022-03-12 02:15:39', '2022-03-12 02:15:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1035, 61, 15, '2022-03-12 02:15:45', '2022-03-12 02:15:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1036, 62, 15, '2022-03-12 02:15:49', '2022-03-12 02:15:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1037, 63, 15, '2022-03-12 02:15:54', '2022-03-12 02:15:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1038, 64, 15, '2022-03-12 02:15:58', '2022-03-12 02:15:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1039, 65, 15, '2022-03-12 02:16:03', '2022-03-12 02:16:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1040, 66, 15, '2022-03-12 02:16:06', '2022-03-12 02:16:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1041, 67, 15, '2022-03-12 02:16:10', '2022-03-12 02:16:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1042, 68, 15, '2022-03-12 02:16:13', '2022-03-12 02:16:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1043, 69, 15, '2022-03-12 02:16:18', '2022-03-12 02:16:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1044, 70, 15, '2022-03-12 02:16:21', '2022-03-12 02:16:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1045, 71, 15, '2022-03-12 02:16:23', '2022-03-12 02:16:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1046, 72, 15, '2022-03-12 02:16:28', '2022-03-12 02:16:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1047, 73, 15, '2022-03-12 02:16:32', '2022-03-12 02:16:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1048, 74, 15, '2022-03-12 02:16:35', '2022-03-12 02:16:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1049, 75, 15, '2022-03-12 02:16:44', '2022-03-12 02:16:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1050, 76, 15, '2022-03-12 02:16:50', '2022-03-12 02:16:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1051, 77, 15, '2022-03-12 02:16:53', '2022-03-12 02:16:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1052, 78, 15, '2022-03-12 02:16:57', '2022-03-12 02:16:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1053, 79, 15, '2022-03-12 02:17:02', '2022-03-12 02:17:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1054, 80, 15, '2022-03-12 02:17:07', '2022-03-12 02:17:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1055, 81, 15, '2022-03-12 02:17:11', '2022-03-12 02:17:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1056, 82, 15, '2022-03-12 02:17:16', '2022-03-12 02:17:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1057, 83, 15, '2022-03-12 02:17:21', '2022-03-12 02:17:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1058, 84, 15, '2022-03-12 02:17:25', '2022-03-12 02:17:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1059, 85, 15, '2022-03-12 02:17:28', '2022-03-12 02:17:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1060, 86, 15, '2022-03-12 02:17:32', '2022-03-12 02:17:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1061, 87, 15, '2022-03-12 02:17:36', '2022-03-12 02:17:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1062, 88, 15, '2022-03-12 02:17:42', '2022-03-12 02:17:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1063, 89, 15, '2022-03-12 02:17:45', '2022-03-12 02:17:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1064, 90, 15, '2022-03-12 02:17:49', '2022-03-12 02:17:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1065, 91, 15, '2022-03-12 02:17:53', '2022-03-12 02:17:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1066, 92, 15, '2022-03-12 02:17:58', '2022-03-12 02:17:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1067, 93, 15, '2022-03-12 02:18:01', '2022-03-12 02:18:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1068, 94, 15, '2022-03-12 02:18:06', '2022-03-12 02:18:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1069, 95, 15, '2022-03-12 02:18:10', '2022-03-12 02:18:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1070, 96, 15, '2022-03-12 02:18:15', '2022-03-12 02:18:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1071, 97, 15, '2022-03-12 02:18:21', '2022-03-12 02:18:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1072, 98, 15, '2022-03-12 02:18:25', '2022-03-12 02:18:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1073, 99, 15, '2022-03-12 02:18:29', '2022-03-12 02:18:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1074, 100, 15, '2022-03-12 02:18:33', '2022-03-12 02:18:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1075, 101, 15, '2022-03-12 02:18:38', '2022-03-12 02:18:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1076, 102, 15, '2022-03-12 02:18:43', '2022-03-12 02:18:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1077, 103, 15, '2022-03-12 02:18:46', '2022-03-12 02:18:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1078, 104, 15, '2022-03-12 02:18:51', '2022-03-12 02:18:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1079, 105, 15, '2022-03-12 02:18:54', '2022-03-12 02:18:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1080, 106, 15, '2022-03-12 02:18:57', '2022-03-12 02:18:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1081, 107, 15, '2022-03-12 02:19:01', '2022-03-12 02:19:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1082, 108, 15, '2022-03-12 02:19:08', '2022-03-12 02:19:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1083, 109, 15, '2022-03-12 02:19:10', '2022-03-12 02:19:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1084, 110, 15, '2022-03-12 02:19:13', '2022-03-12 02:19:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1085, 111, 15, '2022-03-12 02:19:16', '2022-03-12 02:19:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1086, 112, 15, '2022-03-12 02:19:19', '2022-03-12 02:19:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1087, 113, 15, '2022-03-12 02:19:26', '2022-03-12 02:19:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1088, 114, 15, '2022-03-12 02:19:29', '2022-03-12 02:19:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1089, 115, 15, '2022-03-12 02:19:37', '2022-03-12 02:19:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1090, 116, 15, '2022-03-12 02:19:41', '2022-03-12 02:19:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1091, 117, 15, '2022-03-12 02:19:43', '2022-03-12 02:19:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1092, 118, 15, '2022-03-12 02:19:47', '2022-03-12 02:19:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1093, 119, 15, '2022-03-12 02:19:52', '2022-03-12 02:19:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1094, 120, 15, '2022-03-12 02:19:55', '2022-03-12 02:19:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1095, 121, 15, '2022-03-12 02:19:58', '2022-03-12 02:19:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1096, 122, 15, '2022-03-12 02:20:02', '2022-03-12 02:20:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1097, 123, 15, '2022-03-12 02:20:05', '2022-03-12 02:20:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1098, 124, 15, '2022-03-12 02:20:08', '2022-03-12 02:20:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1099, 125, 15, '2022-03-12 02:20:12', '2022-03-12 02:20:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1100, 126, 15, '2022-03-12 02:20:16', '2022-03-12 02:20:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1101, 127, 15, '2022-03-12 02:20:21', '2022-03-12 02:20:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1102, 128, 15, '2022-03-12 02:20:23', '2022-03-12 02:20:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1103, 129, 15, '2022-03-12 02:20:28', '2022-03-12 02:20:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1104, 130, 15, '2022-03-12 02:20:33', '2022-03-12 02:20:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1105, 131, 15, '2022-03-12 02:20:38', '2022-03-12 02:20:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1106, 132, 15, '2022-03-12 02:20:46', '2022-03-12 02:20:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1107, 133, 15, '2022-03-12 02:20:50', '2022-03-12 02:20:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1108, 134, 15, '2022-03-12 02:20:55', '2022-03-12 02:20:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1109, 135, 15, '2022-03-12 02:20:59', '2022-03-12 02:20:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1110, 136, 15, '2022-03-12 02:21:02', '2022-03-12 02:21:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1111, 137, 15, '2022-03-12 02:21:07', '2022-03-12 02:21:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1112, 138, 15, '2022-03-12 02:21:10', '2022-03-12 02:21:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1113, 139, 15, '2022-03-12 02:21:14', '2022-03-12 02:21:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1114, 140, 15, '2022-03-12 02:21:17', '2022-03-12 02:21:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1115, 141, 15, '2022-03-12 02:21:20', '2022-03-12 02:21:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1116, 142, 15, '2022-03-12 02:21:24', '2022-03-12 02:21:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1117, 143, 15, '2022-03-12 02:21:27', '2022-03-12 02:21:27');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1118, 144, 15, '2022-03-12 02:21:31', '2022-03-12 02:21:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1119, 145, 15, '2022-03-12 02:21:37', '2022-03-12 02:21:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1120, 146, 15, '2022-03-12 02:21:41', '2022-03-12 02:21:41');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1121, 147, 15, '2022-03-12 02:21:45', '2022-03-12 02:21:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1122, 148, 15, '2022-03-12 02:21:51', '2022-03-12 02:21:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1123, 149, 15, '2022-03-12 02:22:00', '2022-03-12 02:22:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1124, 150, 15, '2022-03-12 02:22:07', '2022-03-12 02:22:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1125, 151, 15, '2022-03-12 02:22:11', '2022-03-12 02:22:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1126, 152, 15, '2022-03-12 02:22:17', '2022-03-12 02:22:17');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1127, 153, 15, '2022-03-12 02:22:20', '2022-03-12 02:22:20');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1128, 154, 15, '2022-03-12 02:22:23', '2022-03-12 02:22:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1129, 155, 15, '2022-03-12 02:22:26', '2022-03-12 02:22:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1130, 156, 15, '2022-03-12 02:22:30', '2022-03-12 02:22:30');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1131, 157, 15, '2022-03-12 02:22:34', '2022-03-12 02:22:34');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1132, 158, 15, '2022-03-12 02:22:37', '2022-03-12 02:22:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1133, 159, 15, '2022-03-12 02:22:42', '2022-03-12 02:22:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1134, 160, 15, '2022-03-12 02:22:47', '2022-03-12 02:22:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1135, 161, 15, '2022-03-12 02:22:52', '2022-03-12 02:22:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1136, 162, 15, '2022-03-12 02:22:54', '2022-03-12 02:22:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1137, 163, 15, '2022-03-12 02:23:00', '2022-03-12 02:23:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1138, 164, 15, '2022-03-12 02:23:04', '2022-03-12 02:23:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1139, 165, 15, '2022-03-12 02:23:08', '2022-03-12 02:23:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1140, 166, 15, '2022-03-12 02:23:13', '2022-03-12 02:23:13');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1141, 167, 15, '2022-03-12 02:23:15', '2022-03-12 02:23:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1142, 168, 15, '2022-03-12 02:23:19', '2022-03-12 02:23:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1143, 169, 15, '2022-03-12 02:24:38', '2022-03-12 02:24:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1144, 170, 15, '2022-03-12 02:24:49', '2022-03-12 02:24:49');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1145, 171, 15, '2022-03-12 02:25:22', '2022-03-12 02:25:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1146, 172, 15, '2022-03-12 02:25:24', '2022-03-12 02:25:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1147, 173, 15, '2022-03-12 02:25:29', '2022-03-12 02:25:29');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1148, 174, 15, '2022-03-12 02:25:33', '2022-03-12 02:25:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1149, 175, 15, '2022-03-12 02:25:36', '2022-03-12 02:25:36');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1150, 176, 15, '2022-03-12 02:25:38', '2022-03-12 02:25:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1151, 177, 15, '2022-03-12 02:25:42', '2022-03-12 02:25:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1152, 178, 15, '2022-03-12 02:25:47', '2022-03-12 02:25:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1153, 179, 15, '2022-03-12 02:25:50', '2022-03-12 02:25:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1154, 180, 15, '2022-03-12 02:25:55', '2022-03-12 02:25:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1155, 181, 15, '2022-03-12 02:26:00', '2022-03-12 02:26:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1156, 182, 15, '2022-03-12 02:26:07', '2022-03-12 02:26:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1157, 183, 15, '2022-03-12 02:26:11', '2022-03-12 02:26:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1158, 184, 15, '2022-03-12 02:26:16', '2022-03-12 02:26:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1159, 185, 15, '2022-03-12 02:26:18', '2022-03-12 02:26:18');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1160, 186, 15, '2022-03-12 02:26:22', '2022-03-12 02:26:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1161, 187, 15, '2022-03-12 02:26:26', '2022-03-12 02:26:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1162, 188, 15, '2022-03-12 02:26:28', '2022-03-12 02:26:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1163, 189, 15, '2022-03-12 02:26:33', '2022-03-12 02:26:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1164, 190, 15, '2022-03-12 02:26:37', '2022-03-12 02:26:37');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1165, 191, 15, '2022-03-12 02:26:42', '2022-03-12 02:26:42');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1166, 192, 15, '2022-03-12 02:26:47', '2022-03-12 02:26:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1167, 193, 15, '2022-03-12 02:26:52', '2022-03-12 02:26:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1168, 194, 15, '2022-03-12 02:26:56', '2022-03-12 02:26:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1169, 195, 15, '2022-03-12 02:27:00', '2022-03-12 02:27:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1170, 196, 15, '2022-03-12 02:27:05', '2022-03-12 02:27:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1171, 197, 15, '2022-03-12 02:27:10', '2022-03-12 02:27:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1172, 198, 15, '2022-03-12 02:27:14', '2022-03-12 02:27:14');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1173, 199, 15, '2022-03-12 02:27:19', '2022-03-12 02:27:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1174, 200, 15, '2022-03-12 02:27:22', '2022-03-12 02:27:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1175, 201, 15, '2022-03-12 02:27:28', '2022-03-12 02:27:28');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1176, 202, 15, '2022-03-12 02:27:33', '2022-03-12 02:27:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1177, 203, 15, '2022-03-12 02:27:35', '2022-03-12 02:27:35');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1178, 204, 15, '2022-03-12 02:27:38', '2022-03-12 02:27:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1179, 205, 15, '2022-03-12 02:27:43', '2022-03-12 02:27:43');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1180, 206, 15, '2022-03-12 02:27:46', '2022-03-12 02:27:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1181, 207, 15, '2022-03-12 02:27:51', '2022-03-12 02:27:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1182, 208, 15, '2022-03-12 02:27:53', '2022-03-12 02:27:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1183, 209, 15, '2022-03-12 02:27:59', '2022-03-12 02:27:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1184, 210, 15, '2022-03-12 02:28:04', '2022-03-12 02:28:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1185, 211, 15, '2022-03-12 02:28:07', '2022-03-12 02:28:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1186, 212, 15, '2022-03-13 16:17:58', '2022-03-13 16:17:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1187, 213, 15, '2022-03-13 16:18:59', '2022-03-13 16:18:59');
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
