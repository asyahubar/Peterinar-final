-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 09, 2018 at 08:32 PM
-- Server version: 5.7.19
-- PHP Version: 7.2.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `petomatic`
--

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `phone` bigint(25) NOT NULL,
  `email` varchar(45) NOT NULL,
  `image` varchar(2000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `phone`, `email`, `image`) VALUES
(1, 'Millie White', 3815544333, 'milliewhat@gmail.com', NULL),
(2, 'Jeremija Boom', 3812233444, 'jer@gmail.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `email`, `password`) VALUES
(1, 'doctor@doc.co', '$1$yammy$0Pm9gxtj/F7yQgUgTDmVj/'),
(2, 'surgeon@doc.co', '$1$yammy$B4mfyOMQFRHax3dWQL8r7.'),
(3, 'assistant@doc.co', '$1$yammy$vl3WLfe7sZdw/GTi9Ujht1'),
(4, 'clinician@doc.co', '$1$yammy$uUa84AEYm4nXGSTArZz2J/'),
(5, 'veterinarian@doc.co', '$1$yammy$9aH4ngte92o1UiFSi2IO71');

-- --------------------------------------------------------

--
-- Table structure for table `pets`
--

CREATE TABLE `pets` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(45) NOT NULL,
  `image` varchar(2000) DEFAULT NULL,
  `owner_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `pets`
--

INSERT INTO `pets` (`id`, `name`, `image`, `owner_id`) VALUES
(1, 'Snowball', NULL, 1),
(2, 'Grumpy', NULL, 1),
(3, 'Zeus', NULL, 2);

-- --------------------------------------------------------

--
-- Table structure for table `visits`
--

CREATE TABLE `visits` (
  `id` int(10) UNSIGNED NOT NULL,
  `date` bigint(25) DEFAULT NULL,
  `overview` text,
  `customer_id` int(10) UNSIGNED NOT NULL,
  `pet_id` int(10) UNSIGNED NOT NULL,
  `visit_type_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visits`
--

INSERT INTO `visits` (`id`, `date`, `overview`, `customer_id`, `pet_id`, `visit_type_id`) VALUES
(1, 44444444, 'haha', 1, 2, 3),
(2, 1533837508, 'haha', 1, 2, 3),
(3, 1533837508, 'else', 1, 2, 3);

-- --------------------------------------------------------

--
-- Table structure for table `visit_types`
--

CREATE TABLE `visit_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `visit_types`
--

INSERT INTO `visit_types` (`id`, `title`) VALUES
(1, 'surgery'),
(2, 'check up'),
(3, 'flu'),
(4, 'broken limb');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`id`,`owner_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_pets_customers1_idx` (`owner_id`);

--
-- Indexes for table `visits`
--
ALTER TABLE `visits`
  ADD PRIMARY KEY (`id`,`customer_id`,`pet_id`,`visit_type_id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `fk_visits_customers1_idx` (`customer_id`),
  ADD KEY `fk_visits_pets1_idx` (`pet_id`),
  ADD KEY `fk_visits_visit_types1_idx` (`visit_type_id`);

--
-- Indexes for table `visit_types`
--
ALTER TABLE `visit_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `pets`
--
ALTER TABLE `pets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `visits`
--
ALTER TABLE `visits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `visit_types`
--
ALTER TABLE `visit_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pets`
--
ALTER TABLE `pets`
  ADD CONSTRAINT `fk_pets_customers1` FOREIGN KEY (`owner_id`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `visits`
--
ALTER TABLE `visits`
  ADD CONSTRAINT `fk_visits_customers1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visits_pets1` FOREIGN KEY (`pet_id`) REFERENCES `pets` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_visits_visit_types1` FOREIGN KEY (`visit_type_id`) REFERENCES `visit_types` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
