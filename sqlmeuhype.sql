-- --------------------------------------------------------
-- Servidor:                     192.168.10.10
-- Versão do servidor:           8.0.25-0ubuntu0.20.04.1 - (Ubuntu)
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
	(1, 'Carlos Alberto Esteves Junior', 'carlosestevesjr0@gmail.com', '$2y$10$70anvcjSIY3hubLDDut0fOyDhZsBF8CQBYpPCPZ9Id.FeisgoRyKS', '/uploads/fotos/20210415102850_no-image-available-icon-6.jpg', 'active', 'UR3Xq3crb8DtPombyGfTlQGKCJQ7y1QUh5THXqIpRvF1n7dK6v07Mm6xGdHY', '2017-08-28 17:03:23', '2021-04-15 23:40:19');
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

-- Copiando dados para a tabela meuhype.configs: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `configs` DISABLE KEYS */;
INSERT INTO `configs` (`id`, `title`, `slug`, `description`, `image_logo`, `keywords`, `endereco`, `description_short`, `email1`, `email2`, `tel1`, `tel2`, `facebook`, `twitter`, `instagram`, `youtube`, `vimeo`, `linkedin`, `color_painel`, `desconto`, `created_at`, `updated_at`) VALUES
	(1, 'Meu Hype', 'casa-grande-hotel', 'Casa Grande Hotel', '', 'casa, casa grande, casa grande hotel, andradina, hotel andradina', 'Endereço', 'Casa Grande Hotel', 'hotel.casagrande@ig.com.br', NULL, '(18) 3723-6650', NULL, 'https://www.facebook.com/cghotelandradina/', NULL, NULL, NULL, NULL, NULL, 'red', 20.00, '2017-08-28 17:03:23', '2018-07-10 20:58:29');
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
	(4, 'Crawler 3', 10, '01:18:00', 'site', NULL, 1, 'active', '2021-05-01 22:21:31', '2021-07-14 00:58:24');
/*!40000 ALTER TABLE `crawler` ENABLE KEYS */;

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

-- Copiando dados para a tabela meuhype.news: ~85 rows (aproximadamente)
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(1, 3, 'Mortal Kombat Legends: Battle of the Realms | Trailer mostra batalha épica; veja', 'mortal-kombat-legends-battle-of-the-realms-trailer-mostra-batalha-epica-veja', 'mortal-kombat-legends-battle-of-the-realms-trailer-mostra-batalha-epica-veja-omeletesite', '/uploads/news/20210714124446_mortal-kombat-legends-battle-of-the-realms-trailer-mostra-batalha-epica-veja-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-legends-battle-of-realms-trailer', NULL, NULL, 0, '2021-07-01', '2021-07-14 00:44:46', '2021-07-14 00:44:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(2, 3, 'Mortal Kombat Legends: Scorpion&39;s Revenge | Animação ganhará sequência neste ano', 'mortal-kombat-legends-scorpion39s-revenge-animacao-ganhara-sequencia-neste-ano', 'mortal-kombat-legends-scorpion39s-revenge-animacao-ganhara-sequencia-neste-ano-omeletesite', '/uploads/news/20210714124446_mortal-kombat-legends-scorpion39s-revenge-animacao-ganhara-sequencia-neste-ano-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-legends-scorpions-revenge-ganha-sequencia', NULL, NULL, 0, '2021-06-16', '2021-07-14 00:44:47', '2021-07-14 00:44:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(3, 3, 'Crítica: Mortal Kombat vive pelo fan service em filme morno', 'critica-mortal-kombat-vive-pelo-fan-service-em-filme-morno', 'critica-mortal-kombat-vive-pelo-fan-service-em-filme-morno-omeletesite', '/uploads/news/20210714124447_critica-mortal-kombat-vive-pelo-fan-service-em-filme-morno-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/criticas/mortal-kombat-2021', NULL, NULL, 0, '2021-05-18', '2021-07-14 00:44:48', '2021-07-14 00:44:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(4, 3, 'Demon Slayer ultrapassa Mortal Kombat e chega ao topo da bilheteria nos EUA', 'demon-slayer-ultrapassa-mortal-kombat-e-chega-ao-topo-da-bilheteria-nos-eua', 'demon-slayer-ultrapassa-mortal-kombat-e-chega-ao-topo-da-bilheteria-nos-eua-omeletesite', '/uploads/news/20210714124448_demon-slayer-ultrapassa-mortal-kombat-e-chega-ao-topo-da-bilheteria-nos-eua-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/filmes/demon-slayer-recorde-bilheteria', NULL, NULL, 0, '2021-05-02', '2021-07-14 00:44:48', '2021-07-14 00:44:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(5, 3, 'Mortal Kombat | Como o Sub-Zero é o coração do novo filme', 'mortal-kombat-como-o-sub-zero-e-o-coracao-do-novo-filme', 'mortal-kombat-como-o-sub-zero-e-o-coracao-do-novo-filme-omeletesite', '/uploads/news/20210714124448_mortal-kombat-como-o-sub-zero-e-o-coracao-do-novo-filme-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-visita-ao-set-importancia-de-sub-zero', NULL, NULL, 0, '2021-04-27', '2021-07-14 00:44:50', '2021-07-14 00:44:50');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(6, 3, 'Mortal Kombat se torna maior estreia da HBO Max', 'mortal-kombat-se-torna-maior-estreia-da-hbo-max', 'mortal-kombat-se-torna-maior-estreia-da-hbo-max-omeletesite', '/uploads/news/20210714124450_mortal-kombat-se-torna-maior-estreia-da-hbo-max-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-recorde-hbo-max', NULL, NULL, 0, '2021-04-26', '2021-07-14 00:44:51', '2021-07-14 00:44:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(7, 3, 'Alex Ross relembra sua capa para o game Mortal Kombat vs. DC Universe', 'alex-ross-relembra-sua-capa-para-o-game-mortal-kombat-vs-dc-universe', 'alex-ross-relembra-sua-capa-para-o-game-mortal-kombat-vs-dc-universe-omeletesite', '/uploads/news/20210714124451_alex-ross-relembra-sua-capa-para-o-game-mortal-kombat-vs-dc-universe-omeletesite.jpg', NULL, 'show', 'https://www.omelete.com.br/mortal-kombat/mortal-kombat-vs-dc-universe-alex-ross-relembra-capa-game', NULL, NULL, 0, '2021-04-22', '2021-07-14 00:44:51', '2021-07-14 00:44:51');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(8, 1, 'Mortal Kombat 11 não receberá mais DLCs', 'mortal-kombat-11-nao-recebera-mais-dlcs', 'mortal-kombat-11-nao-recebera-mais-dlcs-jovemnerdsite', '/uploads/news/20210714124452_mortal-kombat-11-nao-recebera-mais-dlcs-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-11-nao-recebera-mais-dlcs/', NULL, NULL, 0, '2021-07-02', '2021-07-14 00:44:53', '2021-07-14 00:44:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(9, 1, 'Mortal Kombat Legends: Battle of the Realms ganha trailer com destaque para torneio final', 'mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final', 'mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final-jovemnerdsite', '/uploads/news/20210714124453_mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-legends-battle-of-the-realms-ganha-trailer-com-destaque-para-torneio-final/', NULL, NULL, 0, '2021-07-01', '2021-07-14 00:44:53', '2021-07-14 00:44:53');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(10, 1, 'Sequência de Mortal Kombat Legends é confirmada', 'sequencia-de-mortal-kombat-legends-e-confirmada', 'sequencia-de-mortal-kombat-legends-e-confirmada-jovemnerdsite', '/uploads/news/20210714124453_sequencia-de-mortal-kombat-legends-e-confirmada-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/sequencia-de-mortal-kombat-legends-e-confirmada/', NULL, NULL, 0, '2021-06-16', '2021-07-14 00:44:54', '2021-07-14 00:44:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(11, 1, 'Mortal Kombat supera Godzilla vs. Kong e se torna a maior estreia do HBO Max', 'mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max', 'mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max-jovemnerdsite', '/uploads/news/20210714124454_mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-supera-godzilla-vs-kong-e-se-torna-a-maior-estreia-do-hbo-max/', NULL, NULL, 0, '2021-04-27', '2021-07-14 00:44:54', '2021-07-14 00:44:54');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(12, 1, 'Roteirista de Mortal Kombat revela ter pensado em trilogia', 'roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia', 'roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia-jovemnerdsite', '/uploads/news/20210714124454_roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/roteirista-de-mortal-kombat-revela-ter-pensado-em-trilogia/', NULL, NULL, 0, '2021-04-26', '2021-07-14 00:44:55', '2021-07-14 00:44:55');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(13, 1, 'Mortal Kombat é a &8220;melhor adaptação de video game de todos os tempos&8221;, diz Mehcad Brooks', 'mortal-kombat-e-a-8220melhor-adaptacao-de-video-game-de-todos-os-tempos8221-diz-mehcad-brooks', 'mortal-kombat-e-a-8220melhor-adaptacao-de-video-game-de-todos-os-tempos8221-diz-mehcad-brooks-jovemnerdsite', '/uploads/news/20210714124455_mortal-kombat-e-a-8220melhor-adaptacao-de-video-game-de-todos-os-tempos8221-diz-mehcad-brooks-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-e-a-melhor-adaptacao-de-um-video-game-de-todos-os-tempos-diz-mehcad-brooks/', NULL, NULL, 0, '2021-04-22', '2021-07-14 00:44:56', '2021-07-14 00:44:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(14, 1, 'Assista aos primeiros minutos do filme live-action de Mortal Kombat', 'assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat', 'assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210714124456_assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/assista-aos-primeiros-minutos-do-filme-live-action-de-mortal-kombat/', NULL, NULL, 0, '2021-04-20', '2021-07-14 00:44:56', '2021-07-14 00:44:56');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(15, 1, 'Scorpion e Sub-Zero tem confronto violento em trecho de Mortal Kombat', 'scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat', 'scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210714124456_scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/scorpion-e-sub-zero-tem-confronto-violento-em-trecho-de-mortal-kombat/', NULL, NULL, 0, '2021-04-16', '2021-07-14 00:44:57', '2021-07-14 00:44:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(16, 1, 'Diretor do filme de Mortal Kombat quer expandir a franquia respeitando os fãs', 'diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas', 'diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas-jovemnerdsite', '/uploads/news/20210714124457_diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/diretor-do-filme-de-mortal-kombat-quer-expandir-a-franquia-respeitando-os-fas/', NULL, NULL, 0, '2021-04-12', '2021-07-14 00:44:57', '2021-07-14 00:44:57');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(17, 1, 'Filme de Mortal Kombat ganha nova versão do tema musical clássico; ouça', 'filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca', 'filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca-jovemnerdsite', '/uploads/news/20210714124458_filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-ganha-nova-versao-do-tema-musical-classico-ouca/', NULL, NULL, 0, '2021-04-09', '2021-07-14 00:44:59', '2021-07-14 00:44:59');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(18, 1, 'Filme de Mortal Kombat ganha pôster oficial feito por BossLogic', 'filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic', 'filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic-jovemnerdsite', '/uploads/news/20210714124459_filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-ganha-poster-oficial-feito-por-bosslogic/', NULL, NULL, 0, '2021-04-08', '2021-07-14 00:45:00', '2021-07-14 00:45:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(19, 1, 'Vídeo de bastidores de Mortal Kombat revela cenas inéditas; assista', 'video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista', 'video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista-jovemnerdsite', '/uploads/news/20210714124500_video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/video-de-bastidores-de-mortal-kombat-revela-cenas-ineditas-assista/', NULL, NULL, 0, '2021-04-05', '2021-07-14 00:45:00', '2021-07-14 00:45:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(20, 1, 'Mortal Kombat ganha novos teasers focados em Raiden, Jax, Kung Lao e Liu Kang', 'mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang', 'mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang-jovemnerdsite', '/uploads/news/20210714124500_mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-ganha-novos-teasers-focados-em-raiden-jax-kung-lao-e-liu-kang/', NULL, NULL, 0, '2021-04-02', '2021-07-14 00:45:00', '2021-07-14 00:45:00');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(21, 1, 'Nitara aparece em nova imagem do filme live-action de Mortal Kombat', 'nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat', 'nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210714124500_nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/nitara-aparece-em-nova-imagem-do-filme-live-action-de-mortal-kombat/', NULL, NULL, 0, '2021-03-25', '2021-07-14 00:45:01', '2021-07-14 00:45:01');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(22, 1, 'Diretor de Mortal Kombat fala sobre linha do tempo do filme live-action', 'diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action', 'diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action-jovemnerdsite', '/uploads/news/20210714124501_diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/diretor-de-mortal-kombat-fala-sobre-linha-do-tempo-do-filme-live-action/', NULL, NULL, 0, '2021-03-22', '2021-07-14 00:45:02', '2021-07-14 00:45:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(23, 1, 'Funko anuncia novos colecionáveis de Mortal Kombat', 'funko-anuncia-novos-colecionaveis-de-mortal-kombat', 'funko-anuncia-novos-colecionaveis-de-mortal-kombat-jovemnerdsite', '/uploads/news/20210714124502_funko-anuncia-novos-colecionaveis-de-mortal-kombat-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/funko-anuncia-novos-colecionaveis-de-mortal-kombat/', NULL, NULL, 0, '2021-03-19', '2021-07-14 00:45:02', '2021-07-14 00:45:02');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(24, 1, 'Filme de Mortal Kombat tem &8220;uma das cenas mais brutais do cinema&8221;, diz produtor', 'filme-de-mortal-kombat-tem-8220uma-das-cenas-mais-brutais-do-cinema8221-diz-produtor', 'filme-de-mortal-kombat-tem-8220uma-das-cenas-mais-brutais-do-cinema8221-diz-produtor-jovemnerdsite', '/uploads/news/20210714124502_filme-de-mortal-kombat-tem-8220uma-das-cenas-mais-brutais-do-cinema8221-diz-produtor-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-tem-uma-das-cenas-mais-brutais-do-cinema-diz-produtor/', NULL, NULL, 0, '2021-03-17', '2021-07-14 00:45:03', '2021-07-14 00:45:03');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(25, 1, 'Filme de Mortal Kombat não será tão violento quanto os jogos, explica produtor', 'filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos-explica-produtor', 'filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos-explica-produtor-jovemnerdsite', '/uploads/news/20210714124503_filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos-explica-produtor-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-nao-sera-tao-violento-quanto-os-jogos/', NULL, NULL, 0, '2021-03-17', '2021-07-14 00:45:03', '2021-07-14 00:45:03');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(26, 1, 'Filme de Mortal Kombat recebe novos teasers com foco nos personagens', 'filme-de-mortal-kombat-recebe-novos-teasers-com-foco-nos-personagens', 'filme-de-mortal-kombat-recebe-novos-teasers-com-foco-nos-personagens-jovemnerdsite', '/uploads/news/20210714124503_filme-de-mortal-kombat-recebe-novos-teasers-com-foco-nos-personagens-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-recebe-novos-teasers/', NULL, NULL, 0, '2021-03-12', '2021-07-14 00:45:04', '2021-07-14 00:45:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(27, 1, 'Filme de Mortal Kombat recebe classificação indicativa para maiores de idade', 'filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade', 'filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade-jovemnerdsite', '/uploads/news/20210714124504_filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-recebe-classificacao-indicativa-para-maiores-de-idade/', NULL, NULL, 0, '2021-03-11', '2021-07-14 00:45:04', '2021-07-14 00:45:04');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(28, 1, 'Pôster de Mortal Kombat confirma presença do Kabal no filme live-action', 'poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action', 'poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action-jovemnerdsite', '/uploads/news/20210714124504_poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/poster-de-mortal-kombat-confirma-presenca-do-kabal-no-filme-live-action/', NULL, NULL, 0, '2021-03-10', '2021-07-14 00:45:05', '2021-07-14 00:45:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(29, 1, 'Mortal Kombat | Diretor promete que filme terá as melhores cenas de luta do cinema', 'mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema', 'mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema-jovemnerdsite', '/uploads/news/20210714124505_mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-diretor-promete-que-filme-tera-as-melhores-cenas-de-luta-do-cinema/', NULL, NULL, 0, '2021-03-04', '2021-07-14 00:45:05', '2021-07-14 00:45:05');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(30, 1, 'Mortal Kombat | Fotos dos bastidores do live-action mostram Sub-Zero, Scorpion e mais', 'mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais', 'mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais-jovemnerdsite', '/uploads/news/20210714124505_mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-fotos-dos-bastidores-do-live-action-mostram-sub-zero-scorpion-e-mais/', NULL, NULL, 0, '2021-03-03', '2021-07-14 00:45:06', '2021-07-14 00:45:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(31, 1, 'Mortal Kombat &8211; AGORA VAI!', 'mortal-kombat-8211-agora-vai', 'mortal-kombat-8211-agora-vai-jovemnerdsite', '/uploads/news/20210714124506_mortal-kombat-8211-agora-vai-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdoffice/mortal-kombat-agora-vai/', NULL, NULL, 0, '2021-03-03', '2021-07-14 00:45:07', '2021-07-14 00:45:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(32, 1, 'Mortal Kombat | Trailer do live-action quebra recorde de visualizações no YouTube', 'mortal-kombat-trailer-do-live-action-quebra-recorde-de-visualizacoes-no-youtube', 'mortal-kombat-trailer-do-live-action-quebra-recorde-de-visualizacoes-no-youtube-jovemnerdsite', '/uploads/news/20210714124507_mortal-kombat-trailer-do-live-action-quebra-recorde-de-visualizacoes-no-youtube-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-trailer-do-live-action-quebra-recorde-de-visualizacoes-no-youtube/', NULL, NULL, 0, '2021-02-26', '2021-07-14 00:45:07', '2021-07-14 00:45:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(33, 1, 'Mortal Kombat | Scorpion promove o uso de máscara de um jeito sangrento em arte de fã', 'mortal-kombat-scorpion-promove-o-uso-de-mascara-de-um-jeito-sangrento-em-arte-de-fa', 'mortal-kombat-scorpion-promove-o-uso-de-mascara-de-um-jeito-sangrento-em-arte-de-fa-jovemnerdsite', '/uploads/news/20210714124507_mortal-kombat-scorpion-promove-o-uso-de-mascara-de-um-jeito-sangrento-em-arte-de-fa-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-scorpion-promove-o-uso-de-mascara-de-um-jeito-sangrento-em-arte/', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:45:08', '2021-07-14 00:45:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(34, 1, 'Mortal Kombat | Pôster do filme coloca rivais lado a lado', 'mortal-kombat-poster-do-filme-coloca-rivais-lado-a-lado', 'mortal-kombat-poster-do-filme-coloca-rivais-lado-a-lado-jovemnerdsite', '/uploads/news/20210714124508_mortal-kombat-poster-do-filme-coloca-rivais-lado-a-lado-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/mortal-kombat-poster-do-filme-coloca-rivais-lado-a-lado/', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:45:09', '2021-07-14 00:45:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(35, 1, 'Filme de Mortal Kombat ganha trailer com muita ação e sangue', 'filme-de-mortal-kombat-ganha-trailer-com-muita-acao-e-sangue', 'filme-de-mortal-kombat-ganha-trailer-com-muita-acao-e-sangue-jovemnerdsite', '/uploads/news/20210714124509_filme-de-mortal-kombat-ganha-trailer-com-muita-acao-e-sangue-jovemnerdsite.jpg', NULL, 'show', 'https://jovemnerd.com.br/nerdbunker/filme-de-mortal-kombat-ganha-trailer-com-muita-acao-e-sangue/', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:45:09', '2021-07-14 00:45:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(36, 8, 'MORTAL KOMBAT é bom? - Vale Crítica', 'mortal-kombat-e-bom-vale-critica', 'mortal-kombat-e-bom-vale-critica-superoitoyoutube', '/uploads/news/20210714124511_mortal-kombat-e-bom-vale-critica-superoitoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=5cYBwfEXpqs', NULL, NULL, 0, '2021-05-02', '2021-07-14 00:45:11', '2021-07-14 00:45:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(37, 2, 'Mortal Kombat 11 - Revanche pela honra', 'mortal-kombat-11-revanche-pela-honra', 'mortal-kombat-11-revanche-pela-honra-jovemnerdyoutube', '/uploads/news/20210714124521_mortal-kombat-11-revanche-pela-honra-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=GAo3EfwOAHE', NULL, NULL, 0, '2019-09-02', '2021-07-14 00:45:21', '2021-07-14 00:45:21');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(38, 2, 'Mortal Kombat 11 - Vitória moral', 'mortal-kombat-11-vitoria-moral', 'mortal-kombat-11-vitoria-moral-jovemnerdyoutube', '/uploads/news/20210714124521_mortal-kombat-11-vitoria-moral-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QRxrbK7E68I', NULL, NULL, 0, '2019-05-20', '2021-07-14 00:45:22', '2021-07-14 00:45:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(39, 2, 'Mortal Kombat - NO POWERS!', 'mortal-kombat-no-powers', 'mortal-kombat-no-powers-jovemnerdyoutube', '/uploads/news/20210714124522_mortal-kombat-no-powers-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=qPKIaBySF-A', NULL, NULL, 0, '2012-03-12', '2021-07-14 00:45:22', '2021-07-14 00:45:22');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(40, 2, 'Mortal Kombat 11 - Terminator vs Exterminador do Futuro', 'mortal-kombat-11-terminator-vs-exterminador-do-futuro', 'mortal-kombat-11-terminator-vs-exterminador-do-futuro-jovemnerdyoutube', '/uploads/news/20210714124522_mortal-kombat-11-terminator-vs-exterminador-do-futuro-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=V9l8wn3qRxE', NULL, NULL, 0, '2019-11-04', '2021-07-14 00:45:23', '2021-07-14 00:45:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(41, 2, 'Mortal Kombat 11 - É assim que nasce o Coronga', 'mortal-kombat-11-e-assim-que-nasce-o-coronga', 'mortal-kombat-11-e-assim-que-nasce-o-coronga-jovemnerdyoutube', '/uploads/news/20210714124523_mortal-kombat-11-e-assim-que-nasce-o-coronga-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=77unxv_lX7o', NULL, NULL, 0, '2020-04-27', '2021-07-14 00:45:23', '2021-07-14 00:45:23');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(42, 2, 'Mortal Kombat X - Chutinho, chutinho, chutinho!', 'mortal-kombat-x-chutinho-chutinho-chutinho', 'mortal-kombat-x-chutinho-chutinho-chutinho-jovemnerdyoutube', '/uploads/news/20210714124523_mortal-kombat-x-chutinho-chutinho-chutinho-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=q4EjoBHY2ew', NULL, NULL, 0, '2017-05-22', '2021-07-14 00:45:24', '2021-07-14 00:45:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(43, 2, 'Mortal Kombat X -  A Revanche', 'mortal-kombat-x-a-revanche', 'mortal-kombat-x-a-revanche-jovemnerdyoutube', '/uploads/news/20210714124524_mortal-kombat-x-a-revanche-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=dBAoJVL9yOQ', NULL, NULL, 0, '2015-07-13', '2021-07-14 00:45:24', '2021-07-14 00:45:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(44, 2, 'Mortal Kombat 11 - Rambo vs Terminator', 'mortal-kombat-11-rambo-vs-terminator', 'mortal-kombat-11-rambo-vs-terminator-jovemnerdyoutube', '/uploads/news/20210714124524_mortal-kombat-11-rambo-vs-terminator-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=R2jNL3y67AM', NULL, NULL, 0, '2021-01-04', '2021-07-14 00:45:24', '2021-07-14 00:45:24');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(45, 2, 'Trailer Mortal Kombat -  AGORA VAI!', 'trailer-mortal-kombat-agora-vai', 'trailer-mortal-kombat-agora-vai-jovemnerdyoutube', '/uploads/news/20210714124525_trailer-mortal-kombat-agora-vai-jovemnerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=sumnVAUvx_U', NULL, NULL, 0, '2021-03-03', '2021-07-14 00:45:25', '2021-07-14 00:45:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(46, 4, 'A HISTÓRIA DE MORTAL KOMBAT NOS CINEMAS | RETRATO OMELETE', 'a-historia-de-mortal-kombat-nos-cinemas-retrato-omelete', 'a-historia-de-mortal-kombat-nos-cinemas-retrato-omelete-omeleteyoutube', '/uploads/news/20210714124531_a-historia-de-mortal-kombat-nos-cinemas-retrato-omelete-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=JzUFnU4Kf-0', NULL, NULL, 0, '2021-04-12', '2021-07-14 00:45:31', '2021-07-14 00:45:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(47, 4, 'MORTAL KOMBAT | VEREDITO', 'mortal-kombat-veredito', 'mortal-kombat-veredito-omeleteyoutube', '/uploads/news/20210714124531_mortal-kombat-veredito-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=xepCOO4tLqk', NULL, NULL, 0, '2021-05-20', '2021-07-14 00:45:31', '2021-07-14 00:45:31');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(48, 4, 'FILME DE MORTAL KOMBAT QUEBRA RECORDES!', 'filme-de-mortal-kombat-quebra-recordes', 'filme-de-mortal-kombat-quebra-recordes-omeleteyoutube', '/uploads/news/20210714124532_filme-de-mortal-kombat-quebra-recordes-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=hME6LmqSfbI', NULL, NULL, 0, '2021-04-27', '2021-07-14 00:45:32', '2021-07-14 00:45:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(49, 4, 'HBO MAX EM 2021! ESQUADRÃO SUICIDA E MORTAL KOMBAT GANHAM CENAS INÉDITAS FiqueEmCasa Comigo', 'hbo-max-em-2021-esquadrao-suicida-e-mortal-kombat-ganham-cenas-ineditas-fiqueemcasa-comigo', 'hbo-max-em-2021-esquadrao-suicida-e-mortal-kombat-ganham-cenas-ineditas-fiqueemcasa-comigo-omeleteyoutube', '/uploads/news/20210714124532_hbo-max-em-2021-esquadrao-suicida-e-mortal-kombat-ganham-cenas-ineditas-fiqueemcasa-comigo-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ms_itmVL7M4', NULL, NULL, 0, '2021-01-27', '2021-07-14 00:45:32', '2021-07-14 00:45:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(50, 4, 'MORTAL KOMBAT VEM AÍ! O QUE ESPERAR DO NOVO FILME', 'mortal-kombat-vem-ai-o-que-esperar-do-novo-filme', 'mortal-kombat-vem-ai-o-que-esperar-do-novo-filme-omeleteyoutube', '/uploads/news/20210714124532_mortal-kombat-vem-ai-o-que-esperar-do-novo-filme-omeleteyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=EQfIXxhAyQc', NULL, NULL, 0, '2019-09-17', '2021-07-14 00:45:33', '2021-07-14 00:45:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(51, 5, 'ASSISTI MORTAL KOMBAT E FUI TAPEADO!', 'assisti-mortal-kombat-e-fui-tapeado', 'assisti-mortal-kombat-e-fui-tapeado-einerdyoutube', '/uploads/news/20210714124544_assisti-mortal-kombat-e-fui-tapeado-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Hsgusew52QQ', NULL, NULL, 0, '2021-05-01', '2021-07-14 00:45:44', '2021-07-14 00:45:44');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(52, 5, 'TRAILER MORTAL KOMBAT 2021 - ANÁLISE COMPLETA!', 'trailer-mortal-kombat-2021-analise-completa', 'trailer-mortal-kombat-2021-analise-completa-einerdyoutube', '/uploads/news/20210714124544_trailer-mortal-kombat-2021-analise-completa-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=hdc_RkracRg', NULL, NULL, 0, '2021-02-19', '2021-07-14 00:45:45', '2021-07-14 00:45:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(53, 5, 'MORTAL KOMBAT VS X-MEN | VÍDEO BOOK | ft. Voice Makers', 'mortal-kombat-vs-x-men-video-book-ft-voice-makers', 'mortal-kombat-vs-x-men-video-book-ft-voice-makers-einerdyoutube', '/uploads/news/20210714124545_mortal-kombat-vs-x-men-video-book-ft-voice-makers-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=4EsH4vSM8vA', NULL, NULL, 0, '2020-05-23', '2021-07-14 00:45:45', '2021-07-14 00:45:45');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(54, 5, 'MORTAL KOMBAT 11: ANÁLISE COMPLETA DO TRAILER', 'mortal-kombat-11-analise-completa-do-trailer', 'mortal-kombat-11-analise-completa-do-trailer-einerdyoutube', '/uploads/news/20210714124545_mortal-kombat-11-analise-completa-do-trailer-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=705jGu2xRjw', NULL, NULL, 0, '2020-05-07', '2021-07-14 00:45:46', '2021-07-14 00:45:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(55, 5, 'MOTOQUEIRO FANTASMA VS SCORPION | BATALHA MORTAL | Ei Nerd', 'motoqueiro-fantasma-vs-scorpion-batalha-mortal-ei-nerd', 'motoqueiro-fantasma-vs-scorpion-batalha-mortal-ei-nerd-einerdyoutube', '/uploads/news/20210714124546_motoqueiro-fantasma-vs-scorpion-batalha-mortal-ei-nerd-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=bgh0KkCBRz4', NULL, NULL, 0, '2014-11-08', '2021-07-14 00:45:46', '2021-07-14 00:45:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(56, 5, 'SHAO KAHN VS M. BISON | BATALHA MORTAL | Ei Nerd', 'shao-kahn-vs-m-bison-batalha-mortal-ei-nerd', 'shao-kahn-vs-m-bison-batalha-mortal-ei-nerd-einerdyoutube', '/uploads/news/20210714124546_shao-kahn-vs-m-bison-batalha-mortal-ei-nerd-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ZWZ_m9-nIzM', NULL, NULL, 0, '2015-02-07', '2021-07-14 00:45:46', '2021-07-14 00:45:46');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(57, 5, 'JASON VS MICHAEL MYERS | BATALHA MORTAL | Ei Nerd', 'jason-vs-michael-myers-batalha-mortal-ei-nerd', 'jason-vs-michael-myers-batalha-mortal-ei-nerd-einerdyoutube', '/uploads/news/20210714124547_jason-vs-michael-myers-batalha-mortal-ei-nerd-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=6wf4sE-F5_s', NULL, NULL, 0, '2014-12-27', '2021-07-14 00:45:47', '2021-07-14 00:45:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(58, 5, 'MOTOQUEIRO FANTASMA VS SPAWN | BATALHA MORTAL | Ei Nerd', 'motoqueiro-fantasma-vs-spawn-batalha-mortal-ei-nerd', 'motoqueiro-fantasma-vs-spawn-batalha-mortal-ei-nerd-einerdyoutube', '/uploads/news/20210714124547_motoqueiro-fantasma-vs-spawn-batalha-mortal-ei-nerd-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=qlOLHiWh0p8', NULL, NULL, 0, '2015-06-21', '2021-07-14 00:45:47', '2021-07-14 00:45:47');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(59, 5, 'ROBOCOP VS T-800 | BATALHA MORTAL | Ei Nerd', 'robocop-vs-t-800-batalha-mortal-ei-nerd', 'robocop-vs-t-800-batalha-mortal-ei-nerd-einerdyoutube', '/uploads/news/20210714124547_robocop-vs-t-800-batalha-mortal-ei-nerd-einerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QLqIAfS8at0', NULL, NULL, 0, '2015-12-12', '2021-07-14 00:45:48', '2021-07-14 00:45:48');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(60, 9, 'NOVO TRAILER DE MORTAL KOMBAT | Muitos fatalities e cenas extras!', 'novo-trailer-de-mortal-kombat-muitos-fatalities-e-cenas-extras', 'novo-trailer-de-mortal-kombat-muitos-fatalities-e-cenas-extras-cinemacomrapadurayoutube', '/uploads/news/20210714124551_novo-trailer-de-mortal-kombat-muitos-fatalities-e-cenas-extras-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=RB0z9plADEI', NULL, NULL, 0, '2021-04-06', '2021-07-14 00:45:52', '2021-07-14 00:45:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(61, 9, 'MORTAL KOMBAT | REACT E ANÁLISE DO TRAILER OFICIAL', 'mortal-kombat-react-e-analise-do-trailer-oficial', 'mortal-kombat-react-e-analise-do-trailer-oficial-cinemacomrapadurayoutube', '/uploads/news/20210714124552_mortal-kombat-react-e-analise-do-trailer-oficial-cinemacomrapadurayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=MmKL-W2Jcrc', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:45:52', '2021-07-14 00:45:52');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(62, 12, 'CRÍTICA: MORTAL KOMBAT ABUSA DO SANGUE E DA BOA VONTADE - (COM SPOIERS)', 'critica-mortal-kombat-abusa-do-sangue-e-da-boa-vontade-com-spoiers', 'critica-mortal-kombat-abusa-do-sangue-e-da-boa-vontade-com-spoiers-quatrocoisasyoutube', '/uploads/news/20210714124606_critica-mortal-kombat-abusa-do-sangue-e-da-boa-vontade-com-spoiers-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=SRnSxy9RST0', NULL, NULL, 0, '2021-04-24', '2021-07-14 00:46:06', '2021-07-14 00:46:06');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(63, 12, 'É RUIM, MAS É BOM! CRÍTICA MORTAL KOMBAT (SEM SPOILERS)', 'e-ruim-mas-e-bom-critica-mortal-kombat-sem-spoilers', 'e-ruim-mas-e-bom-critica-mortal-kombat-sem-spoilers-quatrocoisasyoutube', '/uploads/news/20210714124606_e-ruim-mas-e-bom-critica-mortal-kombat-sem-spoilers-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QHLjMTRtVBY', NULL, NULL, 0, '2021-04-23', '2021-07-14 00:46:07', '2021-07-14 00:46:07');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(64, 12, 'PÉSSIMA HISTÓRIA / ÓTIMO FAN SERVICE - O QUE OS CRÍTICOS ESTÃO FALANDO DE MORTAL KOMBAT?', 'pessima-historia-otimo-fan-service-o-que-os-criticos-estao-falando-de-mortal-kombat', 'pessima-historia-otimo-fan-service-o-que-os-criticos-estao-falando-de-mortal-kombat-quatrocoisasyoutube', '/uploads/news/20210714124607_pessima-historia-otimo-fan-service-o-que-os-criticos-estao-falando-de-mortal-kombat-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=fF-EkOL0ELM', NULL, NULL, 0, '2021-04-16', '2021-07-14 00:46:08', '2021-07-14 00:46:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(65, 12, 'VOCÊ SABE TUDO SOBRE MORTAL KOMBAT? - QU4TRO COISAS', 'voce-sabe-tudo-sobre-mortal-kombat-qu4tro-coisas', 'voce-sabe-tudo-sobre-mortal-kombat-qu4tro-coisas-quatrocoisasyoutube', '/uploads/news/20210714124608_voce-sabe-tudo-sobre-mortal-kombat-qu4tro-coisas-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=JIJbihpGYJQ', NULL, NULL, 0, '2013-08-08', '2021-07-14 00:46:08', '2021-07-14 00:46:08');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(66, 12, 'TUDO QUE VOCÊ NÃO VIU NO TRAILER DE MORTAL KOMBAT', 'tudo-que-voce-nao-viu-no-trailer-de-mortal-kombat', 'tudo-que-voce-nao-viu-no-trailer-de-mortal-kombat-quatrocoisasyoutube', '/uploads/news/20210714124608_tudo-que-voce-nao-viu-no-trailer-de-mortal-kombat-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=B1UfkDUIwks', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:46:09', '2021-07-14 00:46:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(67, 12, 'POR QUE JOHNNY CAGE NÃO ESTÁ EM MORTAL KOMBAT?', 'por-que-johnny-cage-nao-esta-em-mortal-kombat', 'por-que-johnny-cage-nao-esta-em-mortal-kombat-quatrocoisasyoutube', '/uploads/news/20210714124609_por-que-johnny-cage-nao-esta-em-mortal-kombat-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=hIOGIFG1AjI', NULL, NULL, 0, '2021-02-20', '2021-07-14 00:46:09', '2021-07-14 00:46:09');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(68, 12, 'PRODUTOR CONTOU TUDO - PORQUE JOHNNY CAGE ESTÁ FORA DO MORTAL KOMBAT?', 'produtor-contou-tudo-porque-johnny-cage-esta-fora-do-mortal-kombat', 'produtor-contou-tudo-porque-johnny-cage-esta-fora-do-mortal-kombat-quatrocoisasyoutube', '/uploads/news/20210714124609_produtor-contou-tudo-porque-johnny-cage-esta-fora-do-mortal-kombat-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=QyFCIXawohU', NULL, NULL, 0, '2021-04-12', '2021-07-14 00:46:10', '2021-07-14 00:46:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(69, 12, 'PITTY FALA SOBRE MORTAL KOMBAT X - QU4TROCOISAS ENTREVISTA', 'pitty-fala-sobre-mortal-kombat-x-qu4trocoisas-entrevista', 'pitty-fala-sobre-mortal-kombat-x-qu4trocoisas-entrevista-quatrocoisasyoutube', '/uploads/news/20210714124610_pitty-fala-sobre-mortal-kombat-x-qu4trocoisas-entrevista-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=lmzQXmRfhlQ', NULL, NULL, 0, '2015-04-15', '2021-07-14 00:46:10', '2021-07-14 00:46:10');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(70, 12, 'TRAILER DE MORTAL KOMBAT 2021 (REAÇÃO)', 'trailer-de-mortal-kombat-2021-reacao', 'trailer-de-mortal-kombat-2021-reacao-quatrocoisasyoutube', '/uploads/news/20210714124610_trailer-de-mortal-kombat-2021-reacao-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=KH1Bk0RXZoE', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:46:11', '2021-07-14 00:46:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(71, 12, 'SALSICHA E MORTAL KOMBAT 11', 'salsicha-e-mortal-kombat-11', 'salsicha-e-mortal-kombat-11-quatrocoisasyoutube', '/uploads/news/20210714124611_salsicha-e-mortal-kombat-11-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=ni2c_1zluuk', NULL, NULL, 0, '2019-02-06', '2021-07-14 00:46:11', '2021-07-14 00:46:11');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(72, 12, 'LIBERADOS OS 7 MINUTOS DE MORTAL KOMBAT E ESTOU PASSANDO MAL', 'liberados-os-7-minutos-de-mortal-kombat-e-estou-passando-mal', 'liberados-os-7-minutos-de-mortal-kombat-e-estou-passando-mal-quatrocoisasyoutube', '/uploads/news/20210714124611_liberados-os-7-minutos-de-mortal-kombat-e-estou-passando-mal-quatrocoisasyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=slkKTjjVVf4', NULL, NULL, 0, '2021-04-21', '2021-07-14 00:46:12', '2021-07-14 00:46:12');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(73, 13, 'NÃO ASSISTA ESSE FILME l MORTAL KOMBAT 2 -  A ANIQUILAÇÃO', 'nao-assista-esse-filme-l-mortal-kombat-2-a-aniquilacao', 'nao-assista-esse-filme-l-mortal-kombat-2-a-aniquilacao-operacaocinemayoutube', '/uploads/news/20210714124615_nao-assista-esse-filme-l-mortal-kombat-2-a-aniquilacao-operacaocinemayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=pZ46RNMX1EU', NULL, NULL, 0, '2021-06-13', '2021-07-14 00:46:15', '2021-07-14 00:46:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(74, 13, 'TRAILER MORTAL KOMBAT I Todos os SEGREDOS ESCONDIDOS que VOCÊ NÃO VIU', 'trailer-mortal-kombat-i-todos-os-segredos-escondidos-que-voce-nao-viu', 'trailer-mortal-kombat-i-todos-os-segredos-escondidos-que-voce-nao-viu-operacaocinemayoutube', '/uploads/news/20210714124615_trailer-mortal-kombat-i-todos-os-segredos-escondidos-que-voce-nao-viu-operacaocinemayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=YALm5yQFY2g', NULL, NULL, 0, '2021-02-19', '2021-07-14 00:46:15', '2021-07-14 00:46:15');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(75, 14, 'MORTAL KOMBAT VALE A PENA?  AO VIVO  NERD RABUGENTO', 'mortal-kombat-vale-a-pena-ao-vivo-nerd-rabugento', 'mortal-kombat-vale-a-pena-ao-vivo-nerd-rabugento-nerdrabugentoyoutube', '/uploads/news/20210714124618_mortal-kombat-vale-a-pena-ao-vivo-nerd-rabugento-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=nXRx8ZZgqWo', NULL, NULL, 0, '2021-04-24', '2021-07-14 00:46:19', '2021-07-14 00:46:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(76, 14, 'MORTAL KOMBAT  REAÇÃO AO TRAILER', 'mortal-kombat-reacao-ao-trailer', 'mortal-kombat-reacao-ao-trailer-nerdrabugentoyoutube', '/uploads/news/20210714124619_mortal-kombat-reacao-ao-trailer-nerdrabugentoyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=0ReSsSJi0aI', NULL, NULL, 0, '2021-02-19', '2021-07-14 00:46:19', '2021-07-14 00:46:19');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(77, 20, '53 DETALHES que você PERDEU em MORTAL KOMBAT (2021)', '53-detalhes-que-voce-perdeu-em-mortal-kombat-2021', '53-detalhes-que-voce-perdeu-em-mortal-kombat-2021-sessaonerdyoutube', '/uploads/news/20210714124625_53-detalhes-que-voce-perdeu-em-mortal-kombat-2021-sessaonerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-L4RsZ6ziLs', NULL, NULL, 0, '2021-05-04', '2021-07-14 00:46:25', '2021-07-14 00:46:25');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(78, 20, 'REVELADO ELENCO do novo FILME de MORTAL KOMBAT!', 'revelado-elenco-do-novo-filme-de-mortal-kombat', 'revelado-elenco-do-novo-filme-de-mortal-kombat-sessaonerdyoutube', '/uploads/news/20210714124625_revelado-elenco-do-novo-filme-de-mortal-kombat-sessaonerdyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=IzuXUAaaYN8', NULL, NULL, 0, '2019-09-02', '2021-07-14 00:46:26', '2021-07-14 00:46:26');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(79, 22, 'MORTAL KOMBAT é BOM ou PIOR FILME de 2021?', 'mortal-kombat-e-bom-ou-pior-filme-de-2021', 'mortal-kombat-e-bom-ou-pior-filme-de-2021-thiagoromarizyoutube', '/uploads/news/20210714124632_mortal-kombat-e-bom-ou-pior-filme-de-2021-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=4pGSWVubdNs', NULL, NULL, 0, '2021-05-20', '2021-07-14 00:46:32', '2021-07-14 00:46:32');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(80, 22, 'MORTAL KOMBAT (2021) - TRAILER | REAÇÃO E COMENTÁRIOS', 'mortal-kombat-2021-trailer-reacao-e-comentarios', 'mortal-kombat-2021-trailer-reacao-e-comentarios-thiagoromarizyoutube', '/uploads/news/20210714124632_mortal-kombat-2021-trailer-reacao-e-comentarios-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=Gvp3zZW0Cy8', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:46:33', '2021-07-14 00:46:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(81, 22, 'ASSISTI MORTAL KOMBAT (2021) | 7 MINUTOS | REACT E COMENTÁRIOS', 'assisti-mortal-kombat-2021-7-minutos-react-e-comentarios', 'assisti-mortal-kombat-2021-7-minutos-react-e-comentarios-thiagoromarizyoutube', '/uploads/news/20210714124633_assisti-mortal-kombat-2021-7-minutos-react-e-comentarios-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=PpBofMbZFEI', NULL, NULL, 0, '2021-04-21', '2021-07-14 00:46:33', '2021-07-14 00:46:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(82, 22, 'FINAL DE WANDAVISION E TRAILER DE MORTAL KOMBAT | Chippu Live Show 3', 'final-de-wandavision-e-trailer-de-mortal-kombat-chippu-live-show-3', 'final-de-wandavision-e-trailer-de-mortal-kombat-chippu-live-show-3-thiagoromarizyoutube', '/uploads/news/20210714124633_final-de-wandavision-e-trailer-de-mortal-kombat-chippu-live-show-3-thiagoromarizyoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=4q6ab8760m8', NULL, NULL, 0, '2021-02-22', '2021-07-14 00:46:33', '2021-07-14 00:46:33');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(83, 24, '[+13] NOVO SCORPION! TRAILER DE MORTAL KOMBAT (2021) ANÁLISE E TEORIAS', '13-novo-scorpion-trailer-de-mortal-kombat-2021-analise-e-teorias', '13-novo-scorpion-trailer-de-mortal-kombat-2021-analise-e-teorias-miguellokiayoutube', '/uploads/news/20210714124638_13-novo-scorpion-trailer-de-mortal-kombat-2021-analise-e-teorias-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=-LKsRIOOga4', NULL, NULL, 0, '2021-02-18', '2021-07-14 00:46:38', '2021-07-14 00:46:38');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(84, 24, 'ASSISTI MORTAL KOMBAT: A VINGANÇA DE SCORPION E TÁ LOUCO!', 'assisti-mortal-kombat-a-vinganca-de-scorpion-e-ta-louco', 'assisti-mortal-kombat-a-vinganca-de-scorpion-e-ta-louco-miguellokiayoutube', '/uploads/news/20210714124639_assisti-mortal-kombat-a-vinganca-de-scorpion-e-ta-louco-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=c7BxqSPXtL0', NULL, NULL, 0, '2020-04-21', '2021-07-14 00:46:39', '2021-07-14 00:46:39');
INSERT INTO `news` (`id`, `channels_id`, `title`, `slug`, `hash`, `image`, `keywords`, `status`, `link`, `description_short`, `description`, `order`, `data`, `created_at`, `updated_at`) VALUES
	(85, 24, 'ASSISTI LIGA DA JUSTIÇA SOMBRIA GUERRA APOKOLIPS E VIROU MORTAL KOMBAT', 'assisti-liga-da-justica-sombria-guerra-apokolips-e-virou-mortal-kombat', 'assisti-liga-da-justica-sombria-guerra-apokolips-e-virou-mortal-kombat-miguellokiayoutube', '/uploads/news/20210714124639_assisti-liga-da-justica-sombria-guerra-apokolips-e-virou-mortal-kombat-miguellokiayoutube.jpg', NULL, 'show', 'https://www.youtube.com/watch?v=teBrHxjNzjE', NULL, NULL, 0, '2020-05-13', '2021-07-14 00:46:39', '2021-07-14 00:46:39');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;

-- Copiando estrutura para tabela meuhype.news_tags
CREATE TABLE IF NOT EXISTS `news_tags` (
  `id` int NOT NULL AUTO_INCREMENT,
  `news_id` int NOT NULL,
  `tags_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.news_tags: ~85 rows (aproximadamente)
/*!40000 ALTER TABLE `news_tags` DISABLE KEYS */;
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(1, 1, 10, '2021-07-14 00:44:46', '2021-07-14 00:44:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(2, 2, 10, '2021-07-14 00:44:47', '2021-07-14 00:44:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(3, 3, 10, '2021-07-14 00:44:48', '2021-07-14 00:44:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(4, 4, 10, '2021-07-14 00:44:48', '2021-07-14 00:44:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(5, 5, 10, '2021-07-14 00:44:50', '2021-07-14 00:44:50');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(6, 6, 10, '2021-07-14 00:44:51', '2021-07-14 00:44:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(7, 7, 10, '2021-07-14 00:44:51', '2021-07-14 00:44:51');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(8, 8, 10, '2021-07-14 00:44:53', '2021-07-14 00:44:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(9, 9, 10, '2021-07-14 00:44:53', '2021-07-14 00:44:53');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(10, 10, 10, '2021-07-14 00:44:54', '2021-07-14 00:44:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(11, 11, 10, '2021-07-14 00:44:54', '2021-07-14 00:44:54');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(12, 12, 10, '2021-07-14 00:44:55', '2021-07-14 00:44:55');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(13, 13, 10, '2021-07-14 00:44:56', '2021-07-14 00:44:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(14, 14, 10, '2021-07-14 00:44:56', '2021-07-14 00:44:56');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(15, 15, 10, '2021-07-14 00:44:57', '2021-07-14 00:44:57');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(16, 16, 10, '2021-07-14 00:44:58', '2021-07-14 00:44:58');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(17, 17, 10, '2021-07-14 00:44:59', '2021-07-14 00:44:59');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(18, 18, 10, '2021-07-14 00:45:00', '2021-07-14 00:45:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(19, 19, 10, '2021-07-14 00:45:00', '2021-07-14 00:45:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(20, 20, 10, '2021-07-14 00:45:00', '2021-07-14 00:45:00');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(21, 21, 10, '2021-07-14 00:45:01', '2021-07-14 00:45:01');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(22, 22, 10, '2021-07-14 00:45:02', '2021-07-14 00:45:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(23, 23, 10, '2021-07-14 00:45:02', '2021-07-14 00:45:02');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(24, 24, 10, '2021-07-14 00:45:03', '2021-07-14 00:45:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(25, 25, 10, '2021-07-14 00:45:03', '2021-07-14 00:45:03');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(26, 26, 10, '2021-07-14 00:45:04', '2021-07-14 00:45:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(27, 27, 10, '2021-07-14 00:45:04', '2021-07-14 00:45:04');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(28, 28, 10, '2021-07-14 00:45:05', '2021-07-14 00:45:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(29, 29, 10, '2021-07-14 00:45:05', '2021-07-14 00:45:05');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(30, 30, 10, '2021-07-14 00:45:06', '2021-07-14 00:45:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(31, 31, 10, '2021-07-14 00:45:07', '2021-07-14 00:45:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(32, 32, 10, '2021-07-14 00:45:07', '2021-07-14 00:45:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(33, 33, 10, '2021-07-14 00:45:08', '2021-07-14 00:45:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(34, 34, 10, '2021-07-14 00:45:09', '2021-07-14 00:45:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(35, 35, 10, '2021-07-14 00:45:09', '2021-07-14 00:45:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(36, 36, 10, '2021-07-14 00:45:11', '2021-07-14 00:45:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(37, 37, 10, '2021-07-14 00:45:21', '2021-07-14 00:45:21');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(38, 38, 10, '2021-07-14 00:45:22', '2021-07-14 00:45:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(39, 39, 10, '2021-07-14 00:45:22', '2021-07-14 00:45:22');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(40, 40, 10, '2021-07-14 00:45:23', '2021-07-14 00:45:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(41, 41, 10, '2021-07-14 00:45:23', '2021-07-14 00:45:23');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(42, 42, 10, '2021-07-14 00:45:24', '2021-07-14 00:45:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(43, 43, 10, '2021-07-14 00:45:24', '2021-07-14 00:45:24');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(44, 44, 10, '2021-07-14 00:45:25', '2021-07-14 00:45:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(45, 45, 10, '2021-07-14 00:45:25', '2021-07-14 00:45:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(46, 46, 10, '2021-07-14 00:45:31', '2021-07-14 00:45:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(47, 47, 10, '2021-07-14 00:45:31', '2021-07-14 00:45:31');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(48, 48, 10, '2021-07-14 00:45:32', '2021-07-14 00:45:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(49, 49, 10, '2021-07-14 00:45:32', '2021-07-14 00:45:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(50, 50, 10, '2021-07-14 00:45:33', '2021-07-14 00:45:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(51, 51, 10, '2021-07-14 00:45:44', '2021-07-14 00:45:44');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(52, 52, 10, '2021-07-14 00:45:45', '2021-07-14 00:45:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(53, 53, 10, '2021-07-14 00:45:45', '2021-07-14 00:45:45');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(54, 54, 10, '2021-07-14 00:45:46', '2021-07-14 00:45:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(55, 55, 10, '2021-07-14 00:45:46', '2021-07-14 00:45:46');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(56, 56, 10, '2021-07-14 00:45:47', '2021-07-14 00:45:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(57, 57, 10, '2021-07-14 00:45:47', '2021-07-14 00:45:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(58, 58, 10, '2021-07-14 00:45:47', '2021-07-14 00:45:47');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(59, 59, 10, '2021-07-14 00:45:48', '2021-07-14 00:45:48');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(60, 60, 10, '2021-07-14 00:45:52', '2021-07-14 00:45:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(61, 61, 10, '2021-07-14 00:45:52', '2021-07-14 00:45:52');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(62, 62, 10, '2021-07-14 00:46:06', '2021-07-14 00:46:06');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(63, 63, 10, '2021-07-14 00:46:07', '2021-07-14 00:46:07');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(64, 64, 10, '2021-07-14 00:46:08', '2021-07-14 00:46:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(65, 65, 10, '2021-07-14 00:46:08', '2021-07-14 00:46:08');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(66, 66, 10, '2021-07-14 00:46:09', '2021-07-14 00:46:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(67, 67, 10, '2021-07-14 00:46:09', '2021-07-14 00:46:09');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(68, 68, 10, '2021-07-14 00:46:10', '2021-07-14 00:46:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(69, 69, 10, '2021-07-14 00:46:10', '2021-07-14 00:46:10');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(70, 70, 10, '2021-07-14 00:46:11', '2021-07-14 00:46:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(71, 71, 10, '2021-07-14 00:46:11', '2021-07-14 00:46:11');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(72, 72, 10, '2021-07-14 00:46:12', '2021-07-14 00:46:12');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(73, 73, 10, '2021-07-14 00:46:15', '2021-07-14 00:46:15');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(74, 74, 10, '2021-07-14 00:46:16', '2021-07-14 00:46:16');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(75, 75, 10, '2021-07-14 00:46:19', '2021-07-14 00:46:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(76, 76, 10, '2021-07-14 00:46:19', '2021-07-14 00:46:19');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(77, 77, 10, '2021-07-14 00:46:25', '2021-07-14 00:46:25');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(78, 78, 10, '2021-07-14 00:46:26', '2021-07-14 00:46:26');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(79, 79, 10, '2021-07-14 00:46:32', '2021-07-14 00:46:32');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(80, 80, 10, '2021-07-14 00:46:33', '2021-07-14 00:46:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(81, 81, 10, '2021-07-14 00:46:33', '2021-07-14 00:46:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(82, 82, 10, '2021-07-14 00:46:33', '2021-07-14 00:46:33');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(83, 83, 10, '2021-07-14 00:46:38', '2021-07-14 00:46:38');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(84, 84, 10, '2021-07-14 00:46:39', '2021-07-14 00:46:39');
INSERT INTO `news_tags` (`id`, `news_id`, `tags_id`, `created_at`, `updated_at`) VALUES
	(85, 85, 10, '2021-07-14 00:46:39', '2021-07-14 00:46:39');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copiando dados para a tabela meuhype.podcasts: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `podcasts` DISABLE KEYS */;
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
