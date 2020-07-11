-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 11, 2020 at 04:33 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_penjualan`
--

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id` int(11) NOT NULL,
  `nama` varchar(45) DEFAULT NULL,
  `keterangan` varchar(45) DEFAULT NULL,
  `jumlah` decimal(10,0) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `idUsers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id`, `nama`, `keterangan`, `jumlah`, `tanggal`, `idUsers`) VALUES
(106, 'Setrika Maspion', 'swastini@gmail.com', '100000', '2020-04-20', 3),
(107, 'Speaker', 'santi@gmail.com', '700000', '2020-04-20', 3),
(108, 'Lenovo', 'rara@gmail.com', '4000000', '2020-04-21', 2),
(110, 'Galaxy S20', 'siska@gmail.com', '4000000', '2020-04-29', 2),
(111, 'ACER', 'doni@yahoo.com', '3500000', '2020-04-29', 4);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id_produk` int(11) NOT NULL,
  `nama_produk` varchar(50) NOT NULL,
  `deskripsi` text NOT NULL,
  `quantity` int(11) NOT NULL,
  `harga` int(11) NOT NULL,
  `image` text NOT NULL,
  `createdDate` datetime NOT NULL,
  `idUsers` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id_produk`, `nama_produk`, `deskripsi`, `quantity`, `harga`, `image`, `createdDate`, `idUsers`) VALUES
(1, 'Maspion', 'Setrika Maspion 220 volt AC', 30, 100000, 'maspion.png', '2020-07-11 04:07:44', 1),
(3, 'Samsung S20', 'Samsung GalaxyS20 RAM 4GB ROM 128GB', 20, 6000000, 'galaxys20.jpg', '2020-07-02 07:07:07', 1),
(4, 'Macbook Air', 'Macbook RAM 8 GB ROM 128GB', 20, 10000000, 'macbook_air.jpg', '2020-07-02 07:07:48', 1),
(5, 'Samsung', 'Samsung RAM 8 GB ROM 128GB', 12, 7000000, 'samsung.jpg', '2020-07-11 01:07:45', 1),
(6, 'Asus A30', 'Asus RAM 8 GB SSD 500 GB', 15, 7000000, 'asus.jpg', '2020-07-11 03:07:07', 1),
(7, 'Asus', 'Asus RAM 8 GB SSD 500 GB', 20, 8000000, 'asus.jpg', '2020-07-11 02:07:53', 1),
(8, 'Hp all On One', 'Hp All Ini One ram 8 GB LED HDD 1t ', 11, 6000000, 'hp.jpg', '2020-07-11 04:07:45', 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` text NOT NULL,
  `password` text NOT NULL,
  `level` int(11) NOT NULL,
  `nama` text NOT NULL,
  `status` int(11) NOT NULL,
  `createdDate` datetime NOT NULL,
  `username` varchar(45) DEFAULT NULL,
  `photo` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `level`, `nama`, `status`, `createdDate`, `username`, `photo`) VALUES
(1, 'swastini@undiksha.ac.id', 'a1d823ef9b950e3ce25f4f1914ddd4ee', 1, 'Putu Swastini', 1, '2020-05-14 09:14:00', 'swastini', 'swastini.jpg'),
(2, 'rara@undiksha.ac.id', 'f3acfa4dabdf4b550db34c23241b2198', 2, 'Rara Rahmawati', 2, '2020-06-09 12:56:00', 'rara', 'rara.jpg'),
(3, 'cintia@gmail.com', '8b86caf97021bd0ebf8796e1564b7dfc', 1, 'Cintia Putri', 1, '2020-06-29 10:06:14', 'koming', 'cintia.jpg'),
(4, 'Bunga@gmail.com', '067a64198ef6b6b274aebbecf66d61bc', 1, 'Bunga Zahra', 1, '2020-06-29 10:06:52', 'bunga021', 'bunga.jpg'),
(5, 'sandi@gmail.com', '0260062a9d43066012606df2c88f23c4', 1, 'sandi', 1, '2020-06-29 10:06:27', 'sandiaga', 'bunga.jpg'),
(9, 'sandi@gmail.com', '0260062a9d43066012606df2c88f23c4', 1, 'sandiaga', 1, '2020-06-29 11:06:51', 'risa', 'bunga.jpg'),
(10, 'diana@gmail.com', 'b2b884421b356f79bb80a03fbdc8c0df', 1, 'Diana Citra', 1, '2020-06-29 11:06:14', 'diana021', 'bunga.jpg'),
(12, 'guntur@gmail.com', '30d8692c0d2ac50d082f20cfc4648206', 1, 'guntur', 1, '2020-06-29 07:06:06', 'guntur', 'swastini.jpg'),
(16, 'sinta@undiksha.ac.id', '08ca451b5ef1a7c86763d31e7711a522', 2, 'Rara Sinta', 1, '2020-07-11 01:07:14', 'sinta', 'bunga.jpg'),
(17, 'sinta021@undiksha.ac.id', 'bef8178e1fb6771901048980ea319024', 2, 'rara sinta', 1, '2020-07-11 02:07:52', 'sinta0', 'bunga.jpg'),
(21, 'surya021@undiksha.ac.id', 'f1ca5f2144fdad73cffeca9b305872f6', 2, 'Suyadi Rara', 1, '2020-07-11 04:07:18', 'suryarara', 'bunga.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id_produk`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id_produk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
