-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 26-05-2020 a las 03:25:38
-- Versión del servidor: 10.1.37-MariaDB
-- Versión de PHP: 7.3.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `sistema_control_asistencias`
--
CREATE DATABASE IF NOT EXISTS `sistema_control_asistencias` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `sistema_control_asistencias`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asistencia`
--

CREATE TABLE `asistencia` (
  `id` int(11) NOT NULL,
  `cedula` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `fecha_hora` datetime NOT NULL,
  `tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `asistencia`
--

INSERT INTO `asistencia` (`id`, `cedula`, `fecha_hora`, `tipo`) VALUES
(28, '12372023', '2020-05-23 14:20:19', 1),
(29, '12372023', '2020-05-23 14:20:29', 0),
(30, '3381952', '2020-05-24 14:20:34', 1),
(31, '3381952', '2020-05-24 14:20:44', 0),
(32, '12372297', '2020-05-24 14:21:09', 1),
(33, '12372297', '2020-05-24 14:21:18', 0),
(34, '27485985', '2020-05-25 14:21:41', 1),
(35, '27485985', '2020-05-25 14:21:47', 0),
(36, '14448249', '2020-05-25 14:22:04', 1),
(37, '14448249', '2020-05-25 14:22:25', 0),
(38, '12372297', '2020-05-25 16:48:52', 1),
(39, '12372297', '2020-05-25 16:49:01', 0),
(40, '3381952', '2020-05-25 17:44:48', 1),
(41, '3381952', '2020-05-25 17:44:52', 0),
(42, '12372023', '2020-05-24 17:46:28', 1),
(43, '12372023', '2020-05-25 17:57:33', 1),
(44, '12372023', '2020-05-25 17:57:43', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `empleado`
--

CREATE TABLE `empleado` (
  `cedula` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `nombre` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `correo` varchar(60) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(11) COLLATE utf8_spanish_ci DEFAULT NULL,
  `n_carnet` varchar(5) COLLATE utf8_spanish_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `empleado`
--

INSERT INTO `empleado` (`cedula`, `nombre`, `correo`, `telefono`, `n_carnet`, `estado`) VALUES
('12372023', 'Glenda Martinez', '', '', '12345', 1),
('12372297', 'Brisaida Nava', 'bris@gmail.com', '04125896452', '48596', 1),
('14448249', 'Maglio Perez', '', '', '15432', 1),
('27485985', 'Jose Gomez', 'joseg@gmail.com', '', '85968', 1),
('29679562', 'Yorger Urdaneta', 'yorgerurdaneta@gmail.com', '04121274934', '25462', 0),
('3381952', 'Dilia Quintero', '', '04146589652', '54321', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `id` int(11) NOT NULL,
  `estado` varchar(11) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `estado`
--

INSERT INTO `estado` (`id`, `estado`) VALUES
(0, 'Desactivado'),
(1, 'Activado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `justificacion`
--

CREATE TABLE `justificacion` (
  `id` int(11) NOT NULL,
  `id_asistencia` int(11) NOT NULL,
  `texto` varchar(300) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `justificacion`
--

INSERT INTO `justificacion` (`id`, `id_asistencia`, `texto`) VALUES
(18, 28, 'No recuerdo.'),
(19, 29, 'No recuerdo.'),
(20, 30, 'No recuerdo.'),
(21, 31, 'No recuerdo.'),
(22, 32, 'No recuerdo.'),
(23, 33, 'No recuerdo.'),
(24, 34, 'No recuerdo.'),
(25, 35, 'No recuerdo.'),
(26, 36, 'No recuerdo.'),
(27, 37, 'No recuerdo.'),
(28, 38, 'No recuerdo.'),
(29, 39, 'No recuerdo.'),
(30, 40, 'No recuerdo.'),
(31, 42, 'No recuerdo.'),
(32, 43, 'No recuerdo.');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_asistencia`
--

CREATE TABLE `tipo_asistencia` (
  `id` int(11) NOT NULL,
  `nombre` varchar(7) COLLATE utf8_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `tipo_asistencia`
--

INSERT INTO `tipo_asistencia` (`id`, `nombre`) VALUES
(0, 'Salida'),
(1, 'Entrada');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL,
  `cedula` varchar(8) COLLATE utf8_spanish_ci NOT NULL,
  `user` varchar(15) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(30) COLLATE utf8_spanish_ci NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `usuario`
--

INSERT INTO `usuario` (`id`, `cedula`, `user`, `password`, `estado`) VALUES
(1, '12372023', 'admin', 'admin', 1),
(3, '29679562', 'admin1', 'admin1', 0);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cedula` (`cedula`),
  ADD KEY `tipo` (`tipo`);

--
-- Indices de la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD PRIMARY KEY (`cedula`),
  ADD UNIQUE KEY `n_carnet` (`n_carnet`),
  ADD KEY `estado` (`estado`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `justificacion`
--
ALTER TABLE `justificacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_asistencia` (`id_asistencia`);

--
-- Indices de la tabla `tipo_asistencia`
--
ALTER TABLE `tipo_asistencia`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user` (`user`),
  ADD KEY `cedula` (`cedula`),
  ADD KEY `estado` (`estado`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `asistencia`
--
ALTER TABLE `asistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `justificacion`
--
ALTER TABLE `justificacion`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT de la tabla `tipo_asistencia`
--
ALTER TABLE `tipo_asistencia`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `usuario`
--
ALTER TABLE `usuario`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `asistencia`
--
ALTER TABLE `asistencia`
  ADD CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`cedula`) REFERENCES `empleado` (`cedula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asistencia_ibfk_2` FOREIGN KEY (`tipo`) REFERENCES `tipo_asistencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `empleado`
--
ALTER TABLE `empleado`
  ADD CONSTRAINT `empleado_ibfk_1` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `justificacion`
--
ALTER TABLE `justificacion`
  ADD CONSTRAINT `justificacion_ibfk_1` FOREIGN KEY (`id_asistencia`) REFERENCES `asistencia` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `usuario`
--
ALTER TABLE `usuario`
  ADD CONSTRAINT `usuario_ibfk_1` FOREIGN KEY (`cedula`) REFERENCES `empleado` (`cedula`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `usuario_ibfk_2` FOREIGN KEY (`estado`) REFERENCES `estado` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
