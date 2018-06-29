-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-06-2018 a las 02:00:10
-- Versión del servidor: 10.1.30-MariaDB
-- Versión de PHP: 5.6.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `examweb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_alumnos`
--

CREATE TABLE `tbl_alumnos` (
  `id_alumno` varchar(15) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_alumnos`
--

INSERT INTO `tbl_alumnos` (`id_alumno`, `nombre`, `estado`) VALUES
('10001', 'LILIAN BANEGAS', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_asignaturas`
--

CREATE TABLE `tbl_asignaturas` (
  `id_asignatura` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_asignaturas`
--

INSERT INTO `tbl_asignaturas` (`id_asignatura`, `nombre`, `estado`) VALUES
('GES001', 'GESTION DE LA TECNOLOGIA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_catedraticos`
--

CREATE TABLE `tbl_catedraticos` (
  `id_catedratico` varchar(15) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_catedraticos`
--

INSERT INTO `tbl_catedraticos` (`id_catedratico`, `nombre`, `estado`) VALUES
('0703198801762', 'ARODI MORGA', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_examenes`
--

CREATE TABLE `tbl_examenes` (
  `id` varchar(50) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `catedratico` varchar(15) NOT NULL,
  `asignatura` varchar(50) NOT NULL,
  `fecha` date NOT NULL,
  `tiempo` int(11) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_examenes`
--

INSERT INTO `tbl_examenes` (`id`, `titulo`, `catedratico`, `asignatura`, `fecha`, `tiempo`, `estado`) VALUES
('REP001', 'EXAMEN DE REPOSICION', '0703198801762', 'GES001', '2018-06-27', 45, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_examen_alumnos`
--

CREATE TABLE `tbl_examen_alumnos` (
  `id_alumno` varchar(30) NOT NULL,
  `id_examen` varchar(50) NOT NULL,
  `nota` int(11) NOT NULL,
  `udt_dt` date NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_examen_alumnos`
--

INSERT INTO `tbl_examen_alumnos` (`id_alumno`, `id_examen`, `nota`, `udt_dt`, `estado`) VALUES
('10001', 'REP001', 0, '0000-00-00', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_preguntas_examen`
--

CREATE TABLE `tbl_preguntas_examen` (
  `id_pregunta` int(11) NOT NULL,
  `id_examen` varchar(50) NOT NULL,
  `texto_pregunta` varchar(200) NOT NULL,
  `txt_respuesta` varchar(300) NOT NULL,
  `op1` varchar(300) NOT NULL,
  `op2` varchar(300) NOT NULL,
  `op3` varchar(300) NOT NULL,
  `op4` varchar(300) NOT NULL,
  `estado` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_preguntas_examen`
--

INSERT INTO `tbl_preguntas_examen` (`id_pregunta`, `id_examen`, `texto_pregunta`, `txt_respuesta`, `op1`, `op2`, `op3`, `op4`, `estado`) VALUES
(1, 'REP001', 'Cual es el concepto de organizacion.', 'ES UN CONJUTON DE PROCESOS Y RECURSOS CON UN OBJETIVO', 'SON EMPRESAS PRIVADAS', 'ES UN CONJUTON DE PROCESOS Y RECURSOS CON UN OBJETIVO', 'ES UN GRUPO DE PERSONAS QUE SE ORGANIZA PARA CUMPLIR OBJETIVOS', 'NINGUNA DE LAS ANTERIORES', 1),
(2, 'REP001', 'Son formas de hacer negocios', 'no existen', 'b2b', 'b2c', 'no existen', 'na', 1),
(3, 'REP001', 'Que son los sistemas inteligentes', 'son sistemas capaces de generar informacion valiosa', 'son sistemas erp', 'son sistemas capaces de generar informacion valiosa', 'son aplicaciones de empresas', 'todas son correctas', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tbl_respuestas_examen`
--

CREATE TABLE `tbl_respuestas_examen` (
  `id_examen` varchar(50) NOT NULL,
  `id_alumno` varchar(50) NOT NULL,
  `id_pregunta` int(11) NOT NULL,
  `respuesta_alumno` varchar(300) NOT NULL,
  `correcta` int(11) NOT NULL,
  `fecha` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `tbl_respuestas_examen`
--

INSERT INTO `tbl_respuestas_examen` (`id_examen`, `id_alumno`, `id_pregunta`, `respuesta_alumno`, `correcta`, `fecha`) VALUES
('REP001', '10001', 1, 'son empresas privadas', 0, 2147483647),
('REP001', '10001', 2, 'no existen', 1, 2147483647),
('REP001', '10001', 3, 'son aplicaciones de empresas', 0, 2147483647);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `tbl_examenes`
--
ALTER TABLE `tbl_examenes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tbl_examen_alumnos`
--
ALTER TABLE `tbl_examen_alumnos`
  ADD PRIMARY KEY (`id_alumno`,`id_examen`);

--
-- Indices de la tabla `tbl_preguntas_examen`
--
ALTER TABLE `tbl_preguntas_examen`
  ADD PRIMARY KEY (`id_pregunta`);

--
-- Indices de la tabla `tbl_respuestas_examen`
--
ALTER TABLE `tbl_respuestas_examen`
  ADD PRIMARY KEY (`id_examen`,`id_alumno`,`id_pregunta`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `tbl_preguntas_examen`
--
ALTER TABLE `tbl_preguntas_examen`
  MODIFY `id_pregunta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
