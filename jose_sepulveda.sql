-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 12-07-2024 a las 22:17:39
-- Versión del servidor: 11.3.2-MariaDB
-- Versión de PHP: 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `jose_sepulveda`
--

DELIMITER $$
--
-- Procedimientos
--
DROP PROCEDURE IF EXISTS `activarcliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `activarcliente` (IN `idcliente` INT)   BEGIN

UPDATE cliente SET estado_cliente='Activo' WHERE id=idcliente;

END$$

DROP PROCEDURE IF EXISTS `activarprenda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `activarprenda` (IN `idropa` INT)   BEGIN

UPDATE ropa SET estado='Activa' WHERE id=idropa;

END$$

DROP PROCEDURE IF EXISTS `actualizarprenda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `actualizarprenda` (IN `idropa` INT, IN `nombre_prenda` VARCHAR(255), IN `tipo_prenda` VARCHAR(255), IN `talla` VARCHAR(10), IN `color` VARCHAR(255), IN `descripcion` VARCHAR(255), IN `foto` VARCHAR(255), IN `precio` DOUBLE, IN `material` VARCHAR(255), IN `marca` VARCHAR(255), IN `recomendaciones` VARCHAR(255), IN `unidades` VARCHAR(255), IN `proveedor` VARCHAR(255), IN `instrucciones` VARCHAR(255), IN `pais_origen` VARCHAR(255), IN `empaque` VARCHAR(255), IN `sku` VARCHAR(255), IN `descuento` VARCHAR(255))   BEGIN

UPDATE ropa SET nombre_prenda=nombre_prenda, tipo_prenda=tipo_prenda, talla=talla, color=color, descripcion=descripcion, foto=foto, precio=precio, material=material, marca=marca, recomendaciones=recomendaciones, unidades=unidades, proveedor=proveedor, instrucciones=instrucciones, pais_origen=pais_origen, empaque=empaque, sku=sku, descuento=descuento WHERE id=idropa;

END$$

DROP PROCEDURE IF EXISTS `consultarultimafactura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `consultarultimafactura` ()   BEGIN

SELECT MAX(id) FROM factura;

END$$

DROP PROCEDURE IF EXISTS `detallefactura`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `detallefactura` (IN `idfactura` INT(11))   BEGIN

SELECT fhr.factura_id, fhr.ropa_id,r.nombre_prenda as nombreprenda,r.precio,factura.cliente_id,factura.fecha,fhr.cantidad,factura.total,factura.metodo_pago,factura.estado,cliente.cedula,cliente.telefono,cliente.nombre_cliente,cliente.apellido_cliente FROM facturahasropa as fhr 
INNER JOIN ropa as r ON r.id = fhr.ropa_id
INNER JOIN factura ON factura.id = fhr.factura_id
INNER JOIN cliente ON cliente.id = factura.cliente_id
WHERE factura.id = idfactura;

END$$

DROP PROCEDURE IF EXISTS `inactivarcliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inactivarcliente` (IN `idcliente` INT)   BEGIN

UPDATE cliente SET estado_cliente='Inactivo' WHERE id=idcliente;

END$$

DROP PROCEDURE IF EXISTS `inactivarprenda`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `inactivarprenda` (IN `idropa` INT)   BEGIN

UPDATE ropa SET estado='Inactiva' WHERE id=idropa;

END$$

DROP PROCEDURE IF EXISTS `insertarropa`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `insertarropa` (IN `nombre_prenda` VARCHAR(255), IN `tipo_prenda` VARCHAR(255), IN `talla` VARCHAR(10), IN `color` VARCHAR(255), IN `descripcion` VARCHAR(255), IN `foto` VARCHAR(255), IN `precio` DOUBLE, IN `material` VARCHAR(255), IN `marca` VARCHAR(255), IN `recomendaciones` VARCHAR(255), IN `unidades` VARCHAR(255), IN `proveedor` VARCHAR(255), IN `instrucciones` VARCHAR(255), IN `pais_origen` VARCHAR(255), IN `empaque` VARCHAR(255), IN `sku` VARCHAR(255), IN `descuento` VARCHAR(255))   BEGIN

INSERT INTO ropa (nombre_prenda,tipo_prenda,talla,color,descripcion,foto,precio,estado,material,marca,recomendaciones,unidades,fecha_ingreso,proveedor,instrucciones,pais_origen,empaque,sku,descuento) VALUES (nombre_prenda,tipo_prenda,talla,color,descripcion,foto,precio,'Activa',material,marca,recomendaciones,unidades,now(),proveedor,instrucciones,pais_origen,empaque,sku,descuento);

END$$

DROP PROCEDURE IF EXISTS `listadocliente`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listadocliente` ()   BEGIN

SELECT * FROM cliente WHERE estado_cliente='Activo';

END$$

DROP PROCEDURE IF EXISTS `listadoclientei`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `listadoclientei` ()   BEGIN

SELECT * FROM cliente WHERE estado_cliente='Inactivo';

END$$

DROP PROCEDURE IF EXISTS `prendasactivas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prendasactivas` ()   BEGIN

SELECT * FROM ropa WHERE estado='Activa';

END$$

DROP PROCEDURE IF EXISTS `prendasinactivas`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `prendasinactivas` ()   BEGIN

SELECT * FROM ropa WHERE estado='Inactiva';

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
CREATE TABLE IF NOT EXISTS `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
CREATE TABLE IF NOT EXISTS `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_group_id_b120cbf9` (`group_id`),
  KEY `auth_group_permissions_permission_id_84c5c92e` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
CREATE TABLE IF NOT EXISTS `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id_2f476e4b` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add cliente', 1, 'add_cliente'),
(2, 'Can change cliente', 1, 'change_cliente'),
(3, 'Can delete cliente', 1, 'delete_cliente'),
(4, 'Can view cliente', 1, 'view_cliente'),
(5, 'Can add ropa', 2, 'add_ropa'),
(6, 'Can change ropa', 2, 'change_ropa'),
(7, 'Can delete ropa', 2, 'delete_ropa'),
(8, 'Can view ropa', 2, 'view_ropa'),
(9, 'Can add factura', 3, 'add_factura'),
(10, 'Can change factura', 3, 'change_factura'),
(11, 'Can delete factura', 3, 'delete_factura'),
(12, 'Can view factura', 3, 'view_factura'),
(13, 'Can add facturahasropa', 4, 'add_facturahasropa'),
(14, 'Can change facturahasropa', 4, 'change_facturahasropa'),
(15, 'Can delete facturahasropa', 4, 'delete_facturahasropa'),
(16, 'Can view facturahasropa', 4, 'view_facturahasropa'),
(17, 'Can add log entry', 5, 'add_logentry'),
(18, 'Can change log entry', 5, 'change_logentry'),
(19, 'Can delete log entry', 5, 'delete_logentry'),
(20, 'Can view log entry', 5, 'view_logentry'),
(21, 'Can add permission', 6, 'add_permission'),
(22, 'Can change permission', 6, 'change_permission'),
(23, 'Can delete permission', 6, 'delete_permission'),
(24, 'Can view permission', 6, 'view_permission'),
(25, 'Can add group', 7, 'add_group'),
(26, 'Can change group', 7, 'change_group'),
(27, 'Can delete group', 7, 'delete_group'),
(28, 'Can view group', 7, 'view_group'),
(29, 'Can add user', 8, 'add_user'),
(30, 'Can change user', 8, 'change_user'),
(31, 'Can delete user', 8, 'delete_user'),
(32, 'Can view user', 8, 'view_user'),
(33, 'Can add content type', 9, 'add_contenttype'),
(34, 'Can change content type', 9, 'change_contenttype'),
(35, 'Can delete content type', 9, 'delete_contenttype'),
(36, 'Can view content type', 9, 'view_contenttype'),
(37, 'Can add session', 10, 'add_session'),
(38, 'Can change session', 10, 'change_session'),
(39, 'Can delete session', 10, 'delete_session'),
(40, 'Can view session', 10, 'view_session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
CREATE TABLE IF NOT EXISTS `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$720000$4M6SA7UGTYpgzcuOO4N1fI$cEuTqaei/wHso5QupGXDgaUAJhOQM+KN5DWa+yRb1O0=', '2024-06-18 14:58:54.637494', 0, 'tibulindo', 'Jose ', 'Sepulveda', 'aprendiz@gmail.com', 0, 1, '2024-06-11 13:31:33.442948'),
(2, 'pbkdf2_sha256$720000$1KLlEgeoFCLoBFNFLKqM2V$DdITAGgwav6YN824G6LnMCcxag1TNX/LB0grzsX0ES8=', '2024-06-11 14:00:38.266756', 0, 'pedritoMST', 'Pedro', 'Monastery', 'martha@gmail.com', 0, 1, '2024-06-11 13:32:50.505450');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
CREATE TABLE IF NOT EXISTS `auth_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_user_id_6a12ed8b` (`user_id`),
  KEY `auth_user_groups_group_id_97559544` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
CREATE TABLE IF NOT EXISTS `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_user_id_a95ead1b` (`user_id`),
  KEY `auth_user_user_permissions_permission_id_1fbb5f2c` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cliente`
--

DROP TABLE IF EXISTS `cliente`;
CREATE TABLE IF NOT EXISTS `cliente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_cliente` varchar(255) NOT NULL,
  `apellido_cliente` varchar(255) NOT NULL,
  `cedula` varchar(25) NOT NULL,
  `telefono` varchar(255) NOT NULL,
  `correo` varchar(255) NOT NULL,
  `direccion` varchar(255) NOT NULL,
  `estado_cliente` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cliente`
--

INSERT INTO `cliente` (`id`, `nombre_cliente`, `apellido_cliente`, `cedula`, `telefono`, `correo`, `direccion`, `estado_cliente`) VALUES
(1, 'Papi', 'Juancho', '56789', '98765', 'jejejej@gmail.com', 'Cr 39 B # 44 - 181', 'Activo'),
(2, 'Jose', 'Elmaslindo', '12345', '54321', 'jajajja@gmail.com', 'Cr 39 B # 44 - 181', 'Inactivo'),
(3, 'Pedro', 'Monastery', '11111', '22222', 'ferxxo@gmail.com', 'ola', 'Activo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
CREATE TABLE IF NOT EXISTS `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
CREATE TABLE IF NOT EXISTS `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'jose_sepulveda', 'cliente'),
(2, 'jose_sepulveda', 'ropa'),
(3, 'jose_sepulveda', 'factura'),
(4, 'jose_sepulveda', 'facturahasropa'),
(5, 'admin', 'logentry'),
(6, 'auth', 'permission'),
(7, 'auth', 'group'),
(8, 'auth', 'user'),
(9, 'contenttypes', 'contenttype'),
(10, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
CREATE TABLE IF NOT EXISTS `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-06-11 12:43:08.732791'),
(2, 'auth', '0001_initial', '2024-06-11 12:43:11.562625'),
(3, 'admin', '0001_initial', '2024-06-11 12:43:13.382528'),
(4, 'admin', '0002_logentry_remove_auto_add', '2024-06-11 12:43:13.392317'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2024-06-11 12:43:13.414150'),
(6, 'contenttypes', '0002_remove_content_type_name', '2024-06-11 12:43:13.674845'),
(7, 'auth', '0002_alter_permission_name_max_length', '2024-06-11 12:43:13.800160'),
(8, 'auth', '0003_alter_user_email_max_length', '2024-06-11 12:43:13.927687'),
(9, 'auth', '0004_alter_user_username_opts', '2024-06-11 12:43:13.937723'),
(10, 'auth', '0005_alter_user_last_login_null', '2024-06-11 12:43:14.082759'),
(11, 'auth', '0006_require_contenttypes_0002', '2024-06-11 12:43:14.082759'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2024-06-11 12:43:14.098479'),
(13, 'auth', '0008_alter_user_username_max_length', '2024-06-11 12:43:14.219991'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2024-06-11 12:43:14.442449'),
(15, 'auth', '0010_alter_group_name_max_length', '2024-06-11 12:43:14.661587'),
(16, 'auth', '0011_update_proxy_permissions', '2024-06-11 12:43:14.680934'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2024-06-11 12:43:14.809024'),
(18, 'sessions', '0001_initial', '2024-06-11 12:43:15.002520');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

DROP TABLE IF EXISTS `django_session`;
CREATE TABLE IF NOT EXISTS `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('58ncwfv7z5ok18zbvi8e4r1lekcqcd0t', '.eJxVjMsOwiAQRf-FtSE8hocu3fcbCAyDVA0kpV0Z_12bdKHbe865LxbittawDVrCnNmFSXb63VLEB7Ud5Htst86xt3WZE98VftDBp57peT3cv4MaR_3WzhSroyNnIJJwvhj0-iyyQmmJqCgLGjIAFBRJKrK5JJTGpOTQowb2_gDlAjg3:1sJaIQ:mh0GlSrBqeCvsRGfWkTm_81c6qkQCEADri8MmSYy4O8', '2024-07-02 14:58:54.643634');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `factura`
--

DROP TABLE IF EXISTS `factura`;
CREATE TABLE IF NOT EXISTS `factura` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` varchar(255) NOT NULL,
  `total` varchar(255) NOT NULL,
  `estado` varchar(255) NOT NULL,
  `metodo_pago` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cliente_id` (`cliente_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `factura`
--

INSERT INTO `factura` (`id`, `fecha`, `total`, `estado`, `metodo_pago`, `descripcion`, `cliente_id`) VALUES
(1, '2024-06-06', '772006', 'Pendiente', 'efectivo', 'Emacarenatusou', 2),
(2, '2024-06-06', '386001', 'Pendiente', 'tarjeta de credito', 'Lomasgrasudo de diluso', 1),
(3, '2024-06-11', '1166000', 'Pendiente', 'tarjeta de credito', 'Eldueño', 3),
(4, '2024-06-06', '3', 'Pendiente', 'efectivo', '11', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturahasropa`
--

DROP TABLE IF EXISTS `facturahasropa`;
CREATE TABLE IF NOT EXISTS `facturahasropa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `factura_id` int(11) NOT NULL,
  `ropa_id` int(11) NOT NULL,
  `cantidad` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ropa_id` (`ropa_id`),
  KEY `factura_id` (`factura_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturahasropa`
--

INSERT INTO `facturahasropa` (`id`, `factura_id`, `ropa_id`, `cantidad`) VALUES
(1, 1, 2, 2),
(2, 1, 1, 6),
(3, 2, 2, 1),
(4, 2, 1, 1),
(5, 3, 3, 2),
(6, 3, 2, 1),
(7, 4, 5, 2),
(8, 4, 4, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ropa`
--

DROP TABLE IF EXISTS `ropa`;
CREATE TABLE IF NOT EXISTS `ropa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_prenda` varchar(255) NOT NULL,
  `tipo_prenda` varchar(255) NOT NULL,
  `talla` varchar(10) NOT NULL,
  `color` varchar(255) NOT NULL,
  `descripcion` varchar(255) NOT NULL,
  `foto` varchar(255) NOT NULL,
  `precio` double NOT NULL,
  `material` varchar(255) NOT NULL,
  `marca` varchar(255) NOT NULL,
  `recomendaciones` varchar(255) NOT NULL,
  `unidades` varchar(255) NOT NULL,
  `fecha_ingreso` date NOT NULL,
  `proveedor` varchar(255) NOT NULL,
  `pais_origen` varchar(255) NOT NULL,
  `instrucciones` varchar(255) NOT NULL,
  `estado` varchar(255) NOT NULL,
  `empaque` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `descuento` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `ropa`
--

INSERT INTO `ropa` (`id`, `nombre_prenda`, `tipo_prenda`, `talla`, `color`, `descripcion`, `foto`, `precio`, `material`, `marca`, `recomendaciones`, `unidades`, `fecha_ingreso`, `proveedor`, `pais_origen`, `instrucciones`, `estado`, `empaque`, `sku`, `descuento`) VALUES
(1, 'ALPINE T-SHIRT FADED DENIM', 'Camisa', 'S', 'Blanco', 'Confeccionada en algodón peruano exclusivo para Monastery, esta prenda presenta una silueta regular y un llamativo estampado en el pecho que se extiende de sisa a sisa.', 'T-SHIRT_white.jpg', 390000, '100% Algodón Monastery', 'MST', 'Lavar por el revés. Lavar separadamente o con colores similares. No planchar marquillas, estampados o placas. No planchar con vapor. No remojar', '10', '2024-06-11', 'PedroMonastery', 'Lima-Peru', 'Lavar a máquina a temperatura máxima de 30°. No usar blanqueador. No retorcer. Secar a la sombra. No secar en máquina. Planchar a temperatura máxima de 110°. No lavar en seco', 'Inactiva', 'Caja de lujo, certificado de autenticidad, papel seda y stickers', '100120124010\r\nFREE SHIPPING & RETURNS\r\nDUTIES & TAXES INCLUDED', 'Negativo'),
(2, 'MonasteryPack', 'Camisa', 'M', 'Negro', 'Emacarenatusou', 'T-SHIRT.jpg', 386000, '', '', '', '', '0000-00-00', '', '', '', 'Activa', '', '', ''),
(3, 'ORYTHIA T-SHIRT BLACK', 'Camisa', 'M', 'Negro', 'Camiseta de hombre en 100% algodón, elaborada en silueta con cuello de sesgo de 3 cm y puño de 2.5 cm. En el frente, lado izquierdo, luce un bordado en 3D en dos tonos', 'T-SHIRTORITHYANEGRAFRENTE.jpg', 390000, '100% Algodón', 'MST', 'Lavar por el revés. Lavar separadamente o con colores similares. No planchar marquillas, estampados o placas. No planchar con vapor. No remojar', '2', '2024-06-11', 'Pedrito', 'Lima-Peru', ' Lavar a máquina a temperatura máxima de 30°. No usar blanqueador. No retorcer. Secar a la sombra', 'Activa', 'Caja de lujo, certificado de autenticidad, papel seda y stickers', '1005900240201 FREE SHIPPING & RETURNS DUTIES & TAXES INCLUDED', 'DAD.RULES'),
(4, '1', '1', '1', '1', '1', 'T-SHIRTORITHYANEGRAFRENTE.jpg', 1, '1', '1', '1', '1', '2024-06-18', '1', '1', '1', 'Activa', '1', '1', '1'),
(5, '1', '1', '1', '1', '1', 'T-SHIRT_white.jpg', 1, '1', '1', '1', '1', '2024-06-18', '1', '1', '1', 'Activa', '1', '1', '1');

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `factura`
--
ALTER TABLE `factura`
  ADD CONSTRAINT `factura_ibfk_1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `facturahasropa`
--
ALTER TABLE `facturahasropa`
  ADD CONSTRAINT `facturahasropa_ibfk_1` FOREIGN KEY (`ropa_id`) REFERENCES `ropa` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `facturahasropa_ibfk_2` FOREIGN KEY (`factura_id`) REFERENCES `factura` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
