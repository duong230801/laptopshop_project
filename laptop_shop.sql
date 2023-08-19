-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2021 at 02:05 PM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 8.0.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laptop_shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `cart_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `total_amount` int(20) NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `product_image` text COLLATE utf8_unicode_ci NOT NULL,
  `product_name` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `carts`
--

INSERT INTO `carts` (`cart_id`, `product_id`, `price`, `quantity`, `total_amount`, `username`, `status`, `product_image`, `product_name`) VALUES
('1637561801892', 1, 20990000, 2, 41980000, 'nhut', 'ordered', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-asus-tuf-gaming-f15-fx506lh_4_.jpg', 'Laptop ASUS TUF Gaming F15 FX506LH HN002T'),
('1637561837736', 2, 25990000, 2, 51980000, 'nhut', 'ordered', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/_/0/_0003_60790_laptop_acer_gaming_nitro_5.jpg', 'Laptop gaming Acer Nitro 5 Eagle AN515 57 54MV');

-- --------------------------------------------------------

--
-- Table structure for table `laptops`
--

CREATE TABLE `laptops` (
  `product_id` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `image` text COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `CPU` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `RAM` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `pin` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `hard_drive` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `graphic_card` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `screen` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `operating_system` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `weight` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `color` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `size` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `warranty` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `brand` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `laptops`
--

INSERT INTO `laptops` (`product_id`, `name`, `image`, `price`, `CPU`, `RAM`, `pin`, `hard_drive`, `graphic_card`, `screen`, `operating_system`, `weight`, `color`, `size`, `warranty`, `brand`, `status`) VALUES
(1, 'Laptop ASUS TUF Gaming F15 FX506LH HN002T', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-asus-tuf-gaming-f15-fx506lh_4_.jpg', 20999000, 'Intel Core i5-10300H 2.5GHz up to 4.5GHz 8MB', '8GB DDR4 2933MHz (2 khe ram , nâng cấp tối đa 32GB RAM)', '3 Cell 48WHr', '512GB SSD M.2 PCIE G3X2, 1 khe  SATA3 2.5\"', 'NVIDIA GeForce GTX 1650 4GB GDDR6 + Đồ họa Intel® UHD', '15,6 \"FHD (1920 x 1080) IPS, 144Hz, góc nhìn rộng, 250nits, viền mỏng chống lóa với 45% NTSC, 63% sRGB', 'Windows 10 Home', '2.2 kg', 'Gun Metal', '360 x 262 x 25,8 ~ 26,9 cm', '24 Tháng', 'Asus', 'new, hot, popular'),
(2, 'Laptop gaming Acer Nitro 5 Eagle AN515 57 54MV', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/_/0/_0003_60790_laptop_acer_gaming_nitro_5.jpg', 25990000, 'Intel® Core i5-11400H upto 4.50 GHz, 6 nhân 12 luồng', '8GB DDR4 3200MHz (2 slot SO-DIMM socket, nâng cấp tối đa 32GB SDRAM)', '4 Cell 57.5WHr', '512GB SSD M.2 PCIE (nâng cấp tối đa 1TB SSD PCIe Gen3, 8 Gb/s, NVMe và 2TB HDD 2.5-inch 5400 RPM) (Còn trống 1 khe SSD M.2 PCIE và 1 khe 2.5\" SATA)', 'NVIDIA® GeForce RTX™ 3050 4GB GDDR6', '15.6 inch FHD(1920 x 1080) IPS 144Hz SlimBezel', 'Windows 11 Home', '2.20 kg', 'Đen', '363.4 x 255 x 23.9 mm', '12 Tháng', 'Acer', 'new, hot, popular'),
(3, 'Laptop MSI Creator Z16 A11UET 218VN', 'https://hanoicomputercdn.com/media/product/60598_laptop_msi_creator_z16_a11uet_218vn_xam_2021_4.png', 66990000, 'Intel® Core™ i9-11900H 8 nhân 16 luồng', '32GB (2 x 16 GB) DDR4 3200MHz (2x SO-DIMM socket, up to 64GB SDRAM)', '90 Whr', '1TB M.2 NVMe PCIe Gen4x4 ', 'NVIDIA® GeForce RTX™ 3060, 6GB GDDR6', '16 inch QHD+ (2560*1600), 120Hz DCI-P3 100% typical, Finger Touch panel', 'Windows 10 Home', '2.2 kg', 'Xám', '359 x 256 x 15.9 mm', '24 Tháng', 'MSI', 'new, hot, popular'),
(4, 'Laptop Lenovo IdeaPad 5 Pro 16ACH6 82L50095VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/9df78eab33525d08d6e5fb8d27136e95/_/0/_0004_61610_laptop_lenovo_ideapad_slim.jpg', 23990000, 'AMD Ryzen™ R5-5600H Processor', '8GB', '4 Cell 75WHr', '512Gb SSD', 'AMD Radeon Graphics + NVIDIA GeForce RTX 1650', '16 inch IPS WQXGA (2K 2560x1600) 120Hz, 100% sRGB, 350 nits', 'Windows 10 Home', '1.9 kg', 'Xám', '356 x 251 x 16.9-18.4 (mm)', '24 Tháng', 'Lenovo', 'new'),
(5, 'Laptop Gaming HP Omen 16 b0123TX 4Y0W6PA', 'https://hanoicomputercdn.com/media/product/60581_laptop_hp_gaming_omen_16_4.png', 61990000, 'Intel Core i7-11800H (8 nhân, 16 luồng)', '32GB (2x16GB) DDR4 3200Mhz (2 khe, max 64GB RAM)', '4 Cell 70WHr Li-ion polymer', '1TB SSD M.2 PCIE (gồm 512GB + 512GB RAID0)', 'NVIDIA® GeForce RTX 3070 (8GB GDDR4)', '16.1\"  QHD (2560 x 1440), 165 Hz 3 ms, IPS, 300 nits, 100% sRGB', 'Windows 10 Home', '2.3 kg', 'Shadow Black', '36.92 x 24.8 x 2.3 cm', '12 Tháng', 'HP', 'new'),
(6, 'Laptop Dell Inspiron 15 3505 Y1N1T1', 'https://hanoicomputercdn.com/media/product/56760_inspiron3505__4_.png', 12990000, 'AMD Ryzen 3 3250U (2.6Ghz/4MB cache)', '8GB DDR4 2400Mhz (2x4GB Sodimm)', '3 cell 42Wh', '256GB  SSD M.2 PCIe NVMe (Có khe cắm HDD)', 'AMD® Radeon™ Graphics', '15.6-inch FHD (1920 x 1080) Anti-glare LED Backlight', 'Win 10 Home SL 64', '1.83 kg', 'Xám', '36.92 x 24.8 x 2.3 cm', '12 Tháng', 'Dell', 'popular'),
(7, 'Laptop ASUS TUF Gaming F15 FX506HCB HN139T', 'https://anphat.com.vn/media/product/38976_60549_laptop_asus_gaming_tuf_fx506hcb_hn139t_xam_10.png', 24990000, 'Intel® Core™ i5-11400H Processor 2.7 GHz (12M Cache, up to 4.5 GHz, 6 Cores)', '8GB DDR4 2933MHz (2x SO-DIMM socket, up to 32GB SDRAM)', '3 Cell 48WHr', '512GB SSD M.2 PCIE G3X2, 1x slot M.2', 'NVIDIA® GeForce RTX™ 3050 Laptop GPU + Intel® UHD Graphics', '15.6\" FHD (1920 x 1080) IPS, 144Hz, Wide View, 250nits, Narrow Bezel, Non-Glare with 45% NTSC, 62.5% sRGB', 'Windows 10 Home', '2.3 kg', 'Gun Metal', '35.9 x 25.6 x 2.28 ~ 2.43 cm', '24 Tháng', 'Asus', 'new, hot'),
(8, 'Laptop Gaming Asus ROG Strix G17 G713QM K4183T', 'https://cdn.cellphones.com.vn/media/catalog/product/l/a/laptop-asus-rog-zephyrus-g14-g713qm-k4183t-4.jpg', 40490000, 'AMD Ryzen™ R9-5900HX (3.3GHz up to 4.6GHz, 16MB Cache)', '16GB(8GBx2) DDR4-3200MHz', '4-cell Li-ion 90WHrs, 4S1P', '512GB M.2 NVMe™ PCIe® 3.0 SSD', 'NVIDIA® GeForce RTX™ 3060 6GB GDDR6', '17.3inch WQHD(2560 x 1440) WV, 300NITS,DCI-P3:100%, 165Hz AdaptiveSync, Nanoedge', 'Windows 10 Home', '2.83 kg', 'Đen', '36.92 x 24.8 x 2.3 cm', '24 Tháng', 'Asus', 'new, hot, popular'),
(9, 'Laptop Asus ROG Strix SCAR 15 G533QM HQ074T', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-gaming-asus-rog-strix-scar-15-g533qm-hq074t-02_1.jpg', 49990000, 'AMD Ryzen 9 5900HX 3.3GHz up to 4.6GHz 16MB', '16GB (8GBx2) DDR4 3200MHz (2x SO-DIMM socket, up to 64GB SDRAM)', '4 Cell 90WHrs', '1TB SSD PCIE G3X4 (3 slot)', 'NVIDIA GeForce RTX 3060 6GB GDDR6 + AMD Radeon™ Graphics', '15.6\" WQHD 2K IPS, 165Hz, Wide View, 300nits, Narrow Bezel, Anti-Glare with 72% NTSC, 100% sRGB, 75% Adobe RGB', 'Windows 10 Home', '2.5 kg', 'Scar Gunmetal', '35.4(W) x 25.9(D) x 2.26 ~ 2.72(H) cm', '24 Tháng', 'Asus', 'new, hot, popular'),
(10, 'Laptop Gaming Asus ROG Zephyrus G14 GA401QH HZ035T', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-asus-rog-zephyrus-g14-ga401qh-hz035t-4.jpg', 28490000, 'AMD Ryzen™ 7-5800HS 2.8GHz up to 4.4GHz, 8 cores 16 threads', '8GB [On board] DDR4 3200MHz ', '4 Cell 76WHr', '512GB SSD M.2 NVMe PCIe 3.0', 'NVIDIA® GeForce® GTX 1650 4GB GDDR6', '14.0 inch FHD (1920 x 1080) IPS, 100% sRGB, 300nits, 144Hz  Nanoedge, Pantone Validated Display', 'Windows 10 Home', '1.7 kg', 'Eclipse Gray', '32.4 x 22.0 x 1.79 ~ 1.79 cm', '24 Tháng', 'Asus', 'new'),
(11, 'Laptop Gaming Asus ROG Flow X13 GV301QC K6029T', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/3/9/39118_38809_60524_laptop_asus_gaming_rog_flow_13_gv301_10.png', 79990000, 'AMD Ryzen™ 9 5980HS Processor 3.1 GHz (16M cache, up to 4.8GHz)', '32GB(16GB + 16GB On board) DDR4 3200MHz ', '62WHrs, 4S1P, 4-cell Li-ion', '1TB M.2 2230 NVMe™ PCIe® 3.0 SSD', 'NVIDIA® GeForce® RTX 3050 4GB GDDR6\r\nVGA rời cắm ngoài eGPU ROG XG Mobile: NVIDIA GeForce RTX 3080 (1810MHz at 150W)', '13.4 inch 16:10 , FHD (1920 x 1200) IPS 120Hz, 100% sRGB, Pantone Validated, Gorilla Glass', 'Windows 10 Home', '1.3 kg', 'Off Black', '29.9 x 22.2 x 1.58 ~ 1.58 cm', '24 Tháng', 'Asus', 'new'),
(12, 'Laptop gaming Acer Nitro 5 AN515 45 R9SC', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-acer-nitro-5-an515-45-r9sc-1.jpg', 36990000, 'AMD Ryzen™ 7 5800H ( 3.2GHz up to 4.4GHz , 16Mb) Cores 8 , 16 Threads', '8GB DDR4 3200MHz (2x SO-DIMM socket, up to 32GB SDRAM)', '3 Cell 57.5WHr', '512GB SSD M.2 PCIE (Còn trống 1 khe SSD M.2 PCIE và 1 khe 2.5\" SATA)', 'NVIDIA GeForce RTX 3070 6GB GDDR6 + AMD Radeon™ Graphics', '15.6\" FHD (1920 x 1080) IPS, 144Hz, Anti-Glare', 'Windows 10 Home', '2.20 kg', 'Đen', '363.4 x 255 x 23.9 mm', '12 Tháng', 'Acer', 'new, hot, popular'),
(13, 'Laptop Acer Predator Triton 300 PT315-53-75LQ', 'https://laptopworld.vn/media/product/9119_acer_predator_triton_300.jpg', 40990000, 'Intel Core i7 11800H', 'DDR4 16GB (2 x 8GB) Bus 3200MHz; 2 slots up to 64GB', '', '512GB SSD NVMe M.2 PCIe Gen 3 x 4', 'Geforce RTX 3060 6GB', '15.6\" 2K (2560 x1440) IPS 165Hz, 100% sRGB', 'Windows 10 Home', '2.1 kg', 'Đen', '(WxDxH) 358.5 x 255 x 17.9 mm', '24 Tháng', 'Acer', 'new'),
(14, 'Laptop Gaming Acer Nitro 5 Eagle AN515 57 74NU', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-gaming-acer-nitro-5-an515-57-74nu-1.jpg', 28390000, 'Intel® Core™ i7-11800H upto 4.60GHz, 8 cores 16 threads', '8GB DDR4 3200MHz (2x SO-DIMM socket, up to 32GB SDRAM)', '4 Cell 57.5WHr', '512GB SSD M.2 PCIE (nâng cấp tối đa 1TB SSD PCIe Gen3, 8 Gb/s, NVMe và 2TB HDD 2.5-inch 5400 RPM) (Còn trống 1 khe SSD M.2 PCIE và 1 khe 2.5\" SATA)', 'NVIDIA® GeForce RTX™ 3050Ti 4GB GDDR6', '15.6 inch FHD(1920 x 1080) IPS 144Hz SlimBezel', 'Windows 10 Home', '2.20 kg', 'Đen', '363.4 x 255 x 23.9 mm', '12 Tháng', 'Acer', 'new, hot'),
(15, 'Laptop Gaming Acer Nitro 5 Eagle AN515 57 77KU', 'https://product.hstatic.net/1000233206/product/acer-nitro-5-an515-57-77ku-i7-11800h_0bcc2a32080b4be2be0f45486964c79b_grande.png', 37990000, 'Intel® Core™ i7-11800H 2.3GHz up to 4.60GHz, 8 nhân 16 luồng', '16GB DDR4 3200MHz khe rời (2 khe, tối đa 32GB)', '4 Cell 57.5WHr', '512GB SSD M.2 PCIE (nâng cấp tối đa 2TB SSD PCIe Gen3, 8 Gb/s, NVMe và 2TB HDD 2.5-inch 5400 RPM) (Còn trống 1 khe SSD M.2 PCIE và 1 khe 2.5\" SATA)', 'NVIDIA® GeForce® RTX 3060 6GB GDDR6', '15.6 inch QHD (2560 x 1440) IPS 165Hz SlimBezel', 'Windows 10 Home', '2.2 kg', 'Đen', '363.4 x 255 x 23.9 mm', '12 Tháng', 'Acer', 'new, popular'),
(16, 'Laptop Acer Predator Helios 300 PH315-54-78W5', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-acer-gaming-predator-helios-300-ph315-54-78w5-1.jpg', 30990000, 'Intel Core i7 11800H', 'DDR4 8GB (1 x 8GB) 3200MHz; 2 slots, up to 64GB', '', '1 slot SSD NVMe M.2 PCIe Gen3 X4 hoặc M.2 SATA III, 512GB SSD NVMe M.2 PCIe Gen 3 x 4', 'Geforce RTX 3050Ti 4GB', '15.6\" FHD (1920×1080), 144Hz 94% NTSC color Anti-glare', 'Windows 10 Home', '2.4 kg', 'Đen', '361.4 (W) x 254.15 (D) x 22.9 (H) mm', '24 Tháng', 'Acer', 'new'),
(17, 'Laptop Gaming MSI GF63 Thin 10SC 020VN', 'https://hanoicomputercdn.com/media/product/58261_laptop_msi_gaming_gf63_10sc_020vn_12.jpg', 21490000, 'Intel core i7-10750H 2.6GHz up to 5.0GHz 12MB', '8GB DDR4 (2x SO-DIMM socket, up to 32GB SDRAM)', '3 Cell 51WHr', '512GB SSD M.2 PCIE', 'NVIDIA GeForce GTX 1650 4GB GDDR6 with Max-Q Design + Intel UHD Graphics 630', '15.6\" FHD (1920 x 1080) IPS, 144Hz, Thin Bezel', 'Windows 10 Home', '1.86 kg', 'Đen', '359 x 254 x 21.7 mm', '12 Tháng', 'MSI', 'new'),
(18, 'Laptop Gaming MSI Katana GF76 11UC 096VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/u/n/untitled-1_0002_19636_laptop_msi_katana_gf76_11uc_096vn_1.jpg', 27290000, 'Intel Core i7-11800H', '8GB (8GB x 1) DDR4 3200MHz (2 khe, tối đa 64GB)', '3 cell, 53.5Whr', '512GB NVMe PCIe Gen3x4 SSD', 'NVIDIA GeForce RTX 3050 4GB GDDR6 + Intel UHD Graphics', '17.3 inch FHD (1920*1080), 144Hz 45% NTSC', 'Windows 10 Home', '2.2 kg', 'Đen', '397 x 260 x 22~23.1 (mm)', '12 Tháng', 'MSI', 'new'),
(19, 'Laptop Gaming MSI Katana GF66 11UE 477VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/u/n/untitled-1_0002_19636_laptop_msi_katana_gf76_11uc_096vn_1.jpg', 42990000, 'Intel Core i7-11800H', '16GB (8GB x 2) DDR4 3200MHz (2 khe, tối đa 64GB)', '3 cell, 53.5Whr', '1TB NVMe PCIe Gen3x4 SSD', 'NVIDIA GeForce RTX 3060 4GB GDDR6 + Intel UHD Graphics', '15.6 inch FHD (1920*1080), 144Hz 100% sRGB', 'Windows 10 Home', '2.1 kg', 'Đen', '359 x 259 x 24.9 (mm)', '12 Tháng', 'MSI', 'new'),
(20, 'Laptop MSI Modern 15 A5M 048VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-msi-modern-15-a5m-048vn-1.jpg', 17490000, 'AMD R5 5500U 6 nhân 12 luồng', '8GB DDR4 3200Mhz (1*8GB) , ( 2 Khe Ram nâng cấp tối đa 64GB )', '3C 52Wh', '512GB NVMe PCIe Gen3x4 SSD (2 Khe M2 PCIe G3x4)', 'AMD Radeon Graphics', '15.6\" FHD 300nits IPS , 45% NTSC ', 'Windows 10 Home', '1,6Kg', 'Xám (Carbon Gray)', '356.8(W) x 233.7 (D) x 18.9(H) mm', '12 Tháng', 'MSI', 'new, hot, popular'),
(21, 'Laptop MSI Summit E13 Flip Evo A11MT 211VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-msi-summit-e13-flip-evo-a11mt-211vn-4.jpg', 37990000, 'Intel® Core™ i7-1185G7 upto 4.80GHz, 4 cores 8 threads', '16GB LPDDR4X onboard', '4 Cell, 70Wh', '1TB SSD NVMe PCIe Gen4', 'Intel Iris X Graphics', '13.4 inch FHD+ (1920x1200), 16:10, IPS-Level, Support MSI Pen - Cảm ứng', 'Windows 10 Home', '1.35 kg', 'Đen', '300.2 x 222.25 x 14.9 mm', '24 Tháng', 'MSI', 'new'),
(22, 'Laptop gaming Lenovo Legion 5 Pro 16ITH6H 82JD0046VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-lenovo-legion-5-pro-16ith6h-82jd0046vn-1.jpg', 44990000, 'AMD Ryzen i7-11800H 2.3GHz upto 4.6GHz, 8 cores 16 threads', '16GB(2x 8GB) SO-DIMM DDR4-3200Mhz (2 khe, tối đa 32GB)', '4 Cell 80 WHr', '512GB SSD M.2 2280 PCIe 3.0x4 NVMe', 'NVIDIA GeForce RTX 3060 6GB GDDR6, 130W TGP', '16.0 inch WQXGA (2560x1600) IPS 500nits Anti-glare, 165Hz, 100% sRGB, Dolby Vision, HDR 400, Free-Sync, G-Sync, DC dimmer.', 'Windows 10 Home', '2.45 kg', 'Trắng', '356 x 260.4-264.4 x 21.7-26.85 mm', '24 Tháng', 'Lenovo', 'new'),
(23, 'Laptop Lenovo IdeaPad 3 15ITL6 82H800M4VN', 'https://cdn.techzones.vn/Data/Sites/1/Product/29914/techzones-lenovo-ideapad-3-15itl6-i3-1115g4-8gb-256gb-ssd-xanh-den.jpg', 13490000, 'Intel Core i3-1115G4 ', '8GB DDR4 3200MHz', '2 Cells 38WHrs', '256GB SSD M.2 PCIe', 'Intel UHD Graphics', '15.6\" FHD (1920 x 1080) TN, 220nits, Anti-glare', 'Windows 10 Home', '1.65 kg', 'Sand', '359.2 x 236.5 x 19.9 (mm)', '12 Tháng', 'Lenovo', 'new, hot, popular'),
(24, 'Laptop Lenovo IdeaPad Slim 3 14ITL6 82H700G1VN', 'https://product.hstatic.net/1000026716/product/gearvn.com-products-laptop-lenovo-ideapad-slim-3-14itl6-82h700g1vn_5_5e81266cb04e4c6c9fe1c803edd4e6e6.jpg', 16190000, 'Core I5 1135G7 2.4 Ghz up to 4.2Ghz', '8Gb (Up to 12GB (4GB soldered + 8GB SO-DIMM) DDR4-3200 offering)', '2 cell', '512Gb SSD, 1x 2.5\" HDD + 1x M.2 2242/2280 SSD', 'Intel Iris Xe Graphics', '14.0Inch Full HD', 'Windows 10 Home', '1.41 kg', 'Xanh ', '324.2 x 215.7 x 19.9 mm', '12 Tháng', 'Lenovo', 'new, popular'),
(25, 'Laptop IdeaPad 5 14ALC05 82LM00D5VN', 'https://hanoicomputercdn.com/media/product/60474_laptop_lenovo_ideapad_5_14alc05_82lm00d5vn_xam_16.jpeg', 17890000, 'AMD Ryzen™ R7-5700U Processor', '8Gb soldered', '3 cell 44.5Whrs', '512Gb SSD', 'AMD Radeon Graphics', '14.0 Inch Full HD', 'Windows 10 Home', '1.39 kg', 'Xám', '324.2 x 215.7 x 19.9 mm', '12 Tháng', 'Lenovo', 'popular'),
(26, 'Laptop Lenovo IdeaPad 5 15ITL05 82FG00M5VN', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/l/a/laptop-lenovo-ideapad-5-15itl05-3.jpg', 18490000, 'Intel Core i5-1135G7 ', '8GB DDR4 3200MHz', '3 Cell 45WHr', '512GB SSD M.2 PCIe', 'Intel Iris® Xe Graphics', '15.6\" FHD IPS (1920 x 1080), 45% NTSC, 300 nits', 'Windows 10 Home', '1.66 kg', 'Graphite Grey (Xám)', '356.67 x 233.13 x 17.9-19.9 mm', '12 Tháng', 'Lenovo', 'popular'),
(27, 'Laptop Gaming HP VICTUS 16 e0177AX 4R0U9PA', 'https://cdn.cellphones.com.vn/media/catalog/product/cache/7/image/1000x/040ec09b1e35df139433887a97daa66f/_/0/_0004_hp_victus_16-e0175ax__4r0u8pa__b_2.jpg', 22490000, 'AMD Ryzen 5 5600H', '8GB (2x4GB) DDR4 3200Mhz (2 khe, max 64GB RAM)', '4 Cell 70WHr Li-ion polymer', '512GB SSD M.2 PCIE (2x M.2 SATA/NVMe)', 'NVIDIA® GeForce GTX™ 1650 Laptop GPU', '16.1\" FHD (1920 x 1080) IPS, 144Hz', 'Windows 10 Home', '2.46 kg', 'Mica Silver', '37 x 26 x 23.5 cm', '12 Tháng', 'HP', 'new, popular'),
(28, 'Laptop Gaming HP VICTUS 16 e0179AX 4R0V0PA', 'https://product.hstatic.net/1000233206/product/hp-victus-16-e0179ax-4r0v0pa-r5-5600h_443e3098d642465ab0bab4ef86a51444_grande.png', 26940000, 'AMD Ryzen 5 5600H', '8GB (2x4GB) DDR4 3200Mhz (2 khe, max 64GB RAM)', '4 Cell 70WHr Li-ion polymer', '512GB SSD M.2 PCIE (2x M.2 SATA/NVMe)', 'NVIDIA® GeForce RTX 3050Ti (4GB GDDR4)', '16.1\" FHD (1920 x 1080) IPS, 144Hz', 'Windows 10 Home', '2.46 kg', 'Mica Silver', '37 x 26 x 23.5 cm', '12 Tháng', 'HP', 'new'),
(29, 'Laptop Gaming HP VICTUS 16 d0197TX 4R0T9PA', 'https://hanoicomputercdn.com/media/product/60588_victus_performance_blue_1.jpg', 36990000, 'Intel Core i7-11800H', '16GB (2x8GB) DDR4 2933Mhz (2 khe, max 64GB RAM)', '4 Cell 70WHr Li-ion polymer', '512GB SSD M.2 PCIE + 32GB Intel Optane memory (2x M.2 SATA/NVMe)', 'NVIDIA® GeForce RTX™ 3060 Laptop GPU + Intel® UHD Graphics', '16.1\" FHD (1920 x 1080) IPS, 144Hz', 'Windows 10 Home', '2.46 kg', 'Performance Blue', '37 x 26 x 2,35 cm', '12 Tháng', 'HP', 'new'),
(30, 'Laptop Gaming HP Omen 16 b0127TX 4Y0W7PA', 'https://hanoicomputercdn.com/media/product/60580_laptop_hp_gaming_omen_16_4.png', 48990000, 'Intel Core i7-11800H (8 nhân, 16 luồng)', '16GB (2x8GB) DDR4 3200Mhz (2 khe, max 64GB RAM)', '4 Cell 70WHr Li-ion polymer', '1TB SSD M.2 PCIE + 32GB Intel Optane memory', 'NVIDIA® GeForce RTX 3060 (6GB GDDR4)', '16.1\"  QHD (2560 x 1440), 165 Hz 3 ms, IPS, 300 nits, 100% sRGB', 'Windows 10 Home', '2.3 kg', 'Shadow Black', '36.92 x 24.8 x 2.3 cm', '12 Tháng', 'HP', 'new'),
(31, 'Laptop Gaming HP Omen 16 b0123TX 4Y0W6PA', 'https://hanoicomputercdn.com/media/product/60581_laptop_hp_gaming_omen_16_4.png', 61990000, 'Intel Core i7-11800H (8 nhân, 16 luồng)', '32GB (2x16GB) DDR4 3200Mhz (2 khe, max 64GB RAM)', '4 Cell 70WHr Li-ion polymer', '1TB SSD M.2 PCIE (gồm 512GB + 512GB RAID0)', 'NVIDIA® GeForce RTX 3070 (8GB GDDR4)', '16.1\"  QHD (2560 x 1440), 165 Hz 3 ms, IPS, 300 nits, 100% sRGB', 'Windows 10 Home', '2.3 kg', 'Shadow Black', '36.92 x 24.8 x 2.3 cm', '24 Tháng', 'HP', 'new, popular'),
(32, 'Laptop Dell Inspiron 15 3505 Y1N1T2', 'https://hanoicomputercdn.com/media/product/57903_inspiron3505__4_.png', 17790000, 'AMD Ryzen 5 3500U (2.6Ghz/4MB cache)', '8GB DDR4 2400Mhz (2x4GB Sodimm)', '3 cell 42Wh', '512GB  SSD M.2 PCIe NVMe (Có khe cắm HDD)', 'AMD® Radeon™ Graphics', '15.6-inch FHD (1920 x 1080) Anti-glare LED Backlight', 'Win 10 Home SL 64', '1.83 kg', 'Đen', '36.92 x 24.8 x 2.3 cm', '24 Tháng', 'Dell', 'popular'),
(33, 'Laptop Dell Vostro 3400 70234073', 'https://hanoicomputercdn.com/media/product/57843_vostro3400__3_.png', 18290000, 'Intel Core i5 Tiger Lake (2.40 GHz up to  4.2 GHz)', '8GB DDR4 (2 khe)', '42Wh Li-ion', 'SSD 256GB NVMe PCIe', 'Intel® Iris® Xe Graphics', 'Full HD (1920 x 1080) 60Hz, WVA', 'Windows 10 Home SL', '1.64 kg', 'Đen', '328.7 x 239.5 x 19.9 mm', '24 Tháng', 'Dell', 'popular'),
(34, 'Laptop Dell Inspiron 3511 P112F001BBL (Black)', 'https://product.hstatic.net/200000019898/product/dell-inspiron-3511-p112f001abl-i3_2_482d7e36f4724d45850bc8ee17f40f33_master.jpg', 19290000, 'Intel Core i5-1135G7 4.20GHz, 4 cores 8 threads', '4GB (4GBX1) DDR4 2666MHz ', '41WHrs', '512GB M.2 PCIe Gen3 x4 NVMe ', 'Intel UHD Graphics', '15.6 Inch FHD (1920 x 1080) Wide View Angle, Anti-Glare ', 'Windows 10 Home + Office Home & Student 2019', '1.85 kg', 'Đen', '358.5 x235.56x 18.9 mm', '12 Tháng', 'Dell', 'popular'),
(35, 'Laptop Dell Vostro 14 3400 YX51W2', 'https://hanoicomputercdn.com/media/product/57902_vostro_3400__5_.png', 20990000, 'Intel Core i5 Tiger Lake (2.40 GHz up to  4.2 GHz)', '8 GB DDR4 (2 khe)', '42Wh Li-ion', 'SSD 256GB NVMe PCIe', 'Intel® UHD Graphics + NVIDIA GeForce MX330 2GB', 'Full HD (1920 x 1080) 60Hz, WVA', 'Windows 10 Home SL', '1.64 kg', 'Đen', '328.7 x 239.5 x 19.9 mm', '12 Tháng', 'Dell', 'popular'),
(36, 'Laptop Dell Vostro 3510 (P112F002ABL)', 'https://hanoicomputercdn.com/media/product/60643_laptop_dell_vostro_3510_p112f002abl_den_6.png', 22790000, 'Intel Core i5-1135G7 Tiger Lake (2.40GHz up to 4.2 GHz)', '8GB DDR4 (2 khe)', '3-cell Li-ion, 41 Wh', 'SSD 512 GB M.2 PCIe', 'NVIDIA GeForce MX350, 2GB', 'Full HD (1920 x 1080) 60Hz, chống chói Anti Glare, WVA,LED Backlit', 'Windows 10 Home SL', '1.69 kg', 'Đen', '358 x 235 x 18.9 mm', '24 Tháng', 'Dell', 'popular');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `cart_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `cart_id`) VALUES
('1637561915739', '1637561801892,1637561837736');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `order_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `address` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `note` text COLLATE utf8_unicode_ci NOT NULL,
  `order_date` date NOT NULL,
  `delivery_date` date NOT NULL,
  `receiving_date` date NOT NULL,
  `phone` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `order_status` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`order_id`, `price`, `name`, `address`, `note`, `order_date`, `delivery_date`, `receiving_date`, `phone`, `order_status`, `username`) VALUES
('1637561915739', 135940000, 'Nhựt', 'UIT', 'Gọi điện trước khi giao nha', '2021-11-22', '2021-11-22', '2021-11-22', '0123455678', 'done', 'nhut');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `session_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `expires` int(11) UNSIGNED NOT NULL,
  `data` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`session_id`, `expires`, `data`) VALUES
('0mBznTo4ss3WmHlRoXbSP8ikUQeDa7Ju', 1638795755, '{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"httpOnly\":true,\"path\":\"/\"},\"isAuth\":true,\"name\":\"Hoàng Đức Minh\",\"username\":\"minhhd\",\"email\":\"18521097@gm.uit.edu.vn\",\"role\":\"admin\"}');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `username` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `phone` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `role` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `doB` date NOT NULL,
  `gender` varchar(6) COLLATE utf8_unicode_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`name`, `username`, `password`, `email`, `phone`, `role`, `address`, `doB`, `gender`, `avatar`) VALUES
('Hoàng Đức Minh', 'minhhd', '1', '18521097@gm.uit.edu.vn', '0123456789', 'admin', 'LaptopShop', '2000-11-12', 'male', 'Minh.png'),
('Nhựt', 'nhut', '123', 'nhut@gmail.com', '0222341569', 'client', 'Đại học Công nghệ Thông tin', '2001-11-01', 'male', 'logo-uit.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`cart_id`),
  ADD KEY `product_id` (`product_id`) USING BTREE;

--
-- Indexes for table `laptops`
--
ALTER TABLE `laptops`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `brand` (`brand`) USING BTREE;

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `cart_id` (`cart_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`session_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `laptops`
--
ALTER TABLE `laptops`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `carts`
--
ALTER TABLE `carts`
  ADD CONSTRAINT `product_id` FOREIGN KEY (`product_id`) REFERENCES `laptops` (`product_id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `username` FOREIGN KEY (`username`) REFERENCES `users` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
