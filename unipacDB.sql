-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 03, 2023 at 01:26 PM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `packma_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_class`
--

CREATE TABLE `app_gen_class` (
  `class_id` bigint(20) NOT NULL,
  `class_name` varchar(100) NOT NULL,
  `class_detail` varchar(1000) NOT NULL,
  `class_price` double NOT NULL,
  `max_gen_per_date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_class`
--

INSERT INTO `app_gen_class` (`class_id`, `class_name`, `class_detail`, `class_price`, `max_gen_per_date`) VALUES
(1, 'Starter', 'This plan for beginner or personal use', 0, 3),
(2, 'Designer', 'This plan for Designer who want to make a lot of design package', 100, 10),
(3, 'Bussiness', 'This plan for organization who have many team to use.', 1500, 300);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_collection`
--

CREATE TABLE `app_gen_collection` (
  `col_id` bigint(20) NOT NULL,
  `col_name` varchar(100) NOT NULL,
  `col_user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_collection`
--

INSERT INTO `app_gen_collection` (`col_id`, `col_name`, `col_user_id`) VALUES
(3, 'Equipment', 1),
(4, 'PackageO', 3),
(5, 'Fruits', 4),
(6, 'fruit', 5),
(7, 'fruit', 1),
(8, 'Geometric', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_commentimggen`
--

CREATE TABLE `app_gen_commentimggen` (
  `id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `commentator_id` bigint(20) NOT NULL,
  `gen_id` bigint(20) DEFAULT NULL,
  `date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_commentimggen`
--

INSERT INTO `app_gen_commentimggen` (`id`, `message`, `commentator_id`, `gen_id`, `date`) VALUES
(10, 'Hello bro that is Amazing.', 1, 4, '2023-09-13 18:33:51.000000'),
(13, 'test', 2, 4, '2023-09-21 20:07:38.000000'),
(16, 'Hello bro that is Amazing.', 2, 3, '2023-10-02 13:13:53.000000'),
(18, 'The color is the most beautiful!!', 5, 50, '2023-10-25 11:50:40.000000'),
(19, 'sdrsr', 5, 37, '2023-10-25 12:10:50.000000'),
(20, 'sdrsr', 5, 37, '2023-10-25 12:12:13.000000'),
(21, 'sdrsr', 5, 37, '2023-10-25 12:12:30.000000');

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_creditcard`
--

CREATE TABLE `app_gen_creditcard` (
  `id` bigint(20) NOT NULL,
  `creditNum` varchar(255) NOT NULL,
  `creditName` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `CVC` varchar(4) NOT NULL,
  `DDVV` varchar(5) NOT NULL,
  `acc_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_creditcard`
--

INSERT INTO `app_gen_creditcard` (`id`, `creditNum`, `creditName`, `address`, `CVC`, `DDVV`, `acc_id`) VALUES
(1, '123412349578285462', 'Anda La-ngu', '181/629 รูสะมิล เมือง ไทย 94000', '121', '11/22', 1),
(2, '1234123412341234', 'Anda La-ngu', '181/629 รูสะมิล เมือง ไทย 94000', '121', '11/22', 5),
(6, '5555555555585693', 'Anda La-ngu', '181/629 รูสะมิล เมือง ไทย 94000', '554', '12/05', 1),
(7, '4444444444444444', 'Anda La-ngu', '181/629 รูสะมิล เมือง ไทย 94000', '789', '12/12', 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_detailcollection`
--

CREATE TABLE `app_gen_detailcollection` (
  `col_detail_id` bigint(20) NOT NULL,
  `col_id_id` bigint(20) NOT NULL,
  `gen_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_detailcollection`
--

INSERT INTO `app_gen_detailcollection` (`col_detail_id`, `col_id_id`, `gen_id_id`) VALUES
(35, 5, 37),
(36, 6, 49),
(38, 7, 44),
(39, 7, 43),
(40, 7, 58),
(41, 7, 32),
(42, 7, 28),
(43, 3, 47),
(44, 3, 53),
(46, 8, 62),
(47, 8, 34),
(48, 8, 33),
(49, 8, 53),
(50, 8, 57);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_detailimggen`
--

CREATE TABLE `app_gen_detailimggen` (
  `genDetail_id` bigint(20) NOT NULL,
  `gen_isPublic` tinyint(1) NOT NULL,
  `gen_message` longtext NOT NULL,
  `gen_star` int(11) NOT NULL,
  `gen_id` bigint(20) DEFAULT NULL,
  `dueTime` datetime(6) DEFAULT NULL,
  `isRemove` tinyint(1) NOT NULL,
  `removeAt` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_detailimggen`
--

INSERT INTO `app_gen_detailimggen` (`genDetail_id`, `gen_isPublic`, `gen_message`, `gen_star`, `gen_id`, `dueTime`, `isRemove`, `removeAt`) VALUES
(4, 1, 'inkBox', 0, 3, NULL, 0, NULL),
(5, 0, '', 0, 4, NULL, 0, NULL),
(14, 1, 'my new Pakaging here!', 10, 6, NULL, 1, NULL),
(27, 0, 'orange juice and orange leaf with black background', 0, 28, NULL, 0, NULL),
(28, 0, 'ce and earth package for shower soap ', 0, 29, NULL, 0, NULL),
(29, 0, 'watches  and a number and there are the running women modern style ', 0, 30, NULL, 0, NULL),
(30, 1, ' the sea japanese style ', 0, 31, NULL, 0, NULL),
(31, 1, 'nd monkey on the top retro style ', 2, 32, NULL, 0, NULL),
(32, 1, 'geometric circle ,line , square , blue tone modern style ', 0, 33, NULL, 0, NULL),
(33, 1, 'ackground and there are 4 blue sentences in text on the top of black background ', 0, 34, NULL, 1, NULL),
(36, 1, 'ork with abstract background natural tone', 0, 37, NULL, 0, NULL),
(37, 1, ' and waterfall artworks ', 0, 38, NULL, 0, NULL),
(38, 1, 'n and there are \"TEAPOT\" word on the center ', 0, 39, NULL, 0, NULL),
(39, 1, ' ice moutain artwork ', 1, 40, NULL, 1, NULL),
(40, 1, 'background with lush coconut palms swaying in the breeze, set against the backdrop of pristine, crystal-clear tropical waters. This imagery transports the consumer to a paradisiacal, tropical setting, evoking feelings of relaxation and the natural source of the coconut milk. This soothing visual element establishes a strong connection to the product\'s origin while creating an attractive and refreshing packaging design. ', 0, 41, NULL, 0, NULL),
(41, 1, 'xurious, handcrafted rose shower soap: A delicate, pale pink bar with intricate rose petal patterns embedded on the surface. The soap exudes a gentle floral fragrance, and it\'s delicately placed on a pristine white marble surface, accompanied by a scattering of fresh rose petals and droplets of water, evoking a sense of elegance, freshness, and indulgent self-care. ', 0, 42, NULL, 1, NULL),
(42, 1, 'le juice with yellow tone ', 0, 43, NULL, 1, NULL),
(43, 1, 'juice and orange color background with split orange fruit in front of all realism', 0, 44, NULL, 0, NULL),
(44, 1, 'geometric green color shade and plain white backdrop ', 0, 45, NULL, 0, NULL),
(45, 1, ' black and white artworks retro style ', 1, 46, NULL, 0, NULL),
(46, 1, 'k and flower in front of the sea janpanese style ', 50, 47, NULL, 0, NULL),
(47, 1, 'reet artwork japanese style ', 0, 48, NULL, 0, NULL),
(48, 1, ' splash of red water  psu pattani', 1, 49, NULL, 0, NULL),
(49, 1, 'est artwork colorful minal style tree', 1, 50, NULL, 0, NULL),
(51, 1, 'he moon and astronaut eiffel tower', 0, 52, NULL, 0, NULL),
(52, 1, 'ue Pattern , for shirt & short ', 0, 53, NULL, 0, NULL),
(53, 1, 'eat and vegetables and tomato vector artwork 2d minimal style ', 0, 54, NULL, 1, NULL),
(56, 1, 'U\' text blue and black plain background ', 0, 57, NULL, 0, NULL),
(57, 1, 'and pinapple fruit with splash of yellow water and yellow plain background ', 0, 58, NULL, 0, NULL),
(59, 1, 'with plain blue background  ', 0, 60, NULL, 0, NULL),
(60, 1, 'with splash of red water and red plain background and \"apple\" text  ', 0, 61, NULL, 0, NULL),
(61, 0, 'tern of star and geometric line in the background ', 0, 62, NULL, 0, NULL),
(62, 1, 'fruit with splash of yellow water and yellow plain background ', 0, 63, NULL, 0, NULL),
(63, 1, ' black and rgb color , modern style , and put text \"NEO\" on it ', 0, 64, NULL, 1, NULL),
(64, 1, ' massage , retro style ', 0, 65, NULL, 1, NULL),
(65, 1, 'been and orage fruit , retro style , put text \"THUNG BLACK\"  ', 0, 66, NULL, 0, NULL),
(66, 0, 'and bamboo artwork on top ', 1, 67, NULL, 0, NULL),
(67, 1, '', 0, 68, NULL, 1, NULL),
(68, 0, 'ocolate with coco spread in the background retro Style', 0, 69, NULL, 0, NULL),
(69, 1, 'k and roses infront of the sea ', 0, 70, NULL, 0, NULL),
(71, 1, 'and dark chocolate with orange spread in the background retro Style', 0, 72, NULL, 0, NULL),
(72, 1, 'ric green with background write plain , minimal style ', 0, 73, NULL, 0, NULL),
(73, 1, 'black and white ', 0, 74, NULL, 0, NULL),
(75, 1, 'and apple fruit with splash of yellow water and yellow plain background ', 0, 76, NULL, 0, NULL),
(77, 1, 'with splash of red water and red geometric background Abstract style', 0, 78, NULL, 0, NULL),
(78, 1, ' with different angle and plain yellow background Abstract style', 1, 79, NULL, 0, NULL),
(79, 1, 'n and with the moon while sunset Minimalism Style', 0, 80, NULL, 0, NULL),
(80, 1, 'and splash of water behind Realistic Style', 0, 81, NULL, 0, NULL),
(81, 1, 'se style sea , with pattern of line circle Retro Style', 0, 82, NULL, 0, NULL),
(82, 1, 'xt into pattern of mango and its leaf with splash background Realistic Style', 0, 83, NULL, 0, NULL),
(83, 1, 'e moon artwork Retro Style', 0, 84, NULL, 0, NULL),
(84, 1, 'e moon artwork Realistic Style', 0, 85, NULL, 0, NULL),
(85, 1, 'ttern of the moon Abstract style', 0, 86, NULL, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_follow`
--

CREATE TABLE `app_gen_follow` (
  `follow_id` bigint(20) NOT NULL,
  `follow_date` datetime(6) DEFAULT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `target_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_illegal`
--

CREATE TABLE `app_gen_illegal` (
  `cop_id` bigint(20) NOT NULL,
  `cop_details` varchar(1000) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `gen_id_id` bigint(20) NOT NULL,
  `report_date` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_imggen`
--

CREATE TABLE `app_gen_imggen` (
  `gen_id` bigint(20) NOT NULL,
  `gen_source` varchar(1000) NOT NULL,
  `gen_CreateAt` datetime(6) NOT NULL,
  `acc_id_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_imggen`
--

INSERT INTO `app_gen_imggen` (`gen_id`, `gen_source`, `gen_CreateAt`, `acc_id_id`) VALUES
(3, 'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image.jpg', '2023-08-25 00:32:22.000000', 2),
(4, 'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-1.jpg', '2023-08-25 00:57:19.000000', 2),
(6, 'https://flowbite.s3.amazonaws.com/docs/gallery/masonry/image-3.jpg', '2023-08-25 22:11:49.000000', 1),
(28, '/static/app_gen/imgGen/1/191023/orangejui171724.png', '2023-10-19 17:18:04.000000', 1),
(29, '/static/app_gen/imgGen/1/191023/spaceand172016.png', '2023-10-19 17:20:49.000000', 1),
(30, '/static/app_gen/imgGen/1/191023/rewatches172854.png', '2023-10-19 17:29:25.000000', 1),
(31, '/static/app_gen/imgGen/1/191023/andthese173013.png', '2023-10-19 17:30:47.000000', 1),
(32, '/static/app_gen/imgGen/1/191023/nandmonk173355.png', '2023-10-19 17:34:36.000000', 1),
(33, '/static/app_gen/imgGen/1/191023/rngeometr173625.png', '2023-10-19 17:36:58.000000', 1),
(34, '/static/app_gen/imgGen/1/191023/ebackgrou190822.png', '2023-10-19 19:08:55.000000', 1),
(37, '/static/app_gen/imgGen/4/191023/rtworkwit200306.png', '2023-10-19 20:03:47.000000', 4),
(38, '/static/app_gen/imgGen/1/211023/torandwa213022.png', '2023-10-21 21:32:29.000000', 1),
(39, '/static/app_gen/imgGen/1/211023/tainandt213355.png', '2023-10-21 21:34:42.000000', 1),
(40, '/static/app_gen/imgGen/1/211023/theicemo213846.png', '2023-10-21 21:39:13.000000', 1),
(41, '/static/app_gen/imgGen/1/211023/nebackgro214412.png', '2023-10-21 21:44:42.000000', 1),
(42, '/static/app_gen/imgGen/1/211023/luxurious214703.png', '2023-10-21 21:47:34.000000', 1),
(43, '/static/app_gen/imgGen/1/211023/naplejuic225654.png', '2023-10-21 22:57:29.000000', 1),
(44, '/static/app_gen/imgGen/1/241023/gejuicea181249.png', '2023-10-24 18:13:31.000000', 1),
(45, '/static/app_gen/imgGen/1/241023/rngeometr181610.png', '2023-10-24 18:16:47.000000', 1),
(46, '/static/app_gen/imgGen/1/241023/ernblack182607.png', '2023-10-24 18:26:50.000000', 1),
(47, '/static/app_gen/imgGen/1/241023/workandf182910.png', '2023-10-24 18:30:37.000000', 1),
(48, '/static/app_gen/imgGen/1/241023/streetar183616.png', '2023-10-24 18:37:28.000000', 1),
(49, '/static/app_gen/imgGen/5/251023/andsplash114217.png', '2023-10-25 11:43:16.000000', 5),
(50, '/static/app_gen/imgGen/5/251023/forestart114851.png', '2023-10-25 11:49:33.000000', 5),
(52, '/static/app_gen/imgGen/5/251023/nthemoon120656.png', '2023-10-25 12:07:33.000000', 5),
(53, '/static/app_gen/imgGen/1/251023/BluePatt204847.png', '2023-10-25 20:49:29.000000', 1),
(54, '/static/app_gen/imgGen/1/251023/hmeatand205253.png', '2023-10-25 20:53:56.000000', 1),
(57, '/static/app_gen/imgGen/1/261023/PSUtext105156 3.png', '2023-10-26 10:57:57.000000', 1),
(58, '/static/app_gen/imgGen/1/261023/goandpin123832 3.png', '2023-10-26 12:43:37.000000', 1),
(60, '/static/app_gen/imgGen/1/281023/amwithpl140651 2.png', '2023-10-28 14:07:34.000000', 1),
(61, '/static/app_gen/imgGen/1/281023/lewithsp144307 2.png', '2023-10-28 14:54:21.000000', 1),
(62, '/static/app_gen/imgGen/1/281023/patternof151429 1.png', '2023-10-28 15:16:55.000000', 1),
(63, '/static/app_gen/imgGen/1/281023/pefruitw151747 2.png', '2023-10-28 15:21:30.000000', 1),
(64, '/static/app_gen/imgGen/1/281023/oneblack202349 4.png', '2023-10-28 20:26:01.000000', 1),
(65, '/static/app_gen/imgGen/1/281023/oilmassag202648 1.png', '2023-10-28 20:28:35.000000', 1),
(66, '/static/app_gen/imgGen/1/281023/febeenan203127 4.png', '2023-10-28 20:34:10.000000', 1),
(67, '/static/app_gen/imgGen/1/281023/ndandbam214123 2.png', '2023-10-28 21:43:12.000000', 1),
(68, '/static/app_gen/imgGen/1/281023/214407 4.png', '2023-10-28 21:48:41.000000', 1),
(69, '/static/app_gen/imgGen/2/291023/chocolate202456 1.png', '2023-10-29 20:27:08.000000', 2),
(70, '/static/app_gen/imgGen/2/291023/workandr214531 4.png', '2023-10-29 21:48:15.000000', 2),
(72, '/static/app_gen/imgGen/1/311023/feanddar230635 2.png', '2023-10-31 23:08:10.000000', 1),
(73, '/static/app_gen/imgGen/1/311023/metricgre232003 2.png', '2023-10-31 23:24:22.000000', 1),
(74, '/static/app_gen/imgGen/1/311023/icblacka232654 3.png', '2023-10-31 23:31:42.000000', 1),
(76, '/static/app_gen/imgGen/1/031123/goandapp145608 3.png', '2023-11-03 14:59:15.000000', 1),
(78, '/static/app_gen/imgGen/2/031123/lewithsp160220 4.png', '2023-11-03 16:51:17.000000', 2),
(79, '/static/app_gen/imgGen/2/031123/nutwithd171800 2.png', '2023-11-03 17:19:16.000000', 2),
(80, '/static/app_gen/imgGen/2/031123/tainandw181425 4.png', '2023-11-03 18:15:11.000000', 2),
(81, '/static/app_gen/imgGen/2/031123/veandspl181750 4.png', '2023-11-03 18:20:15.000000', 2),
(82, '/static/app_gen/imgGen/2/031123/anesestyl182355 4.png', '2023-11-03 18:27:05.000000', 2),
(83, '/static/app_gen/imgGen/2/031123/textinto184507 3.png', '2023-11-03 18:47:27.000000', 2),
(84, '/static/app_gen/imgGen/2/031123/themoon185942 1.png', '2023-11-03 19:02:05.000000', 2),
(85, '/static/app_gen/imgGen/2/031123/themoon190519 4.png', '2023-11-03 19:06:55.000000', 2),
(86, '/static/app_gen/imgGen/2/031123/patterno190914 4.png', '2023-11-03 19:11:20.000000', 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_notification`
--

CREATE TABLE `app_gen_notification` (
  `noti_id` bigint(20) NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `notice_title` varchar(255) NOT NULL,
  `notice_detail` longtext NOT NULL,
  `notice_date` datetime(6) DEFAULT NULL,
  `acc_id_id` bigint(20) DEFAULT NULL,
  `pic_source` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_notification`
--

INSERT INTO `app_gen_notification` (`noti_id`, `is_read`, `notice_title`, `notice_detail`, `notice_date`, `acc_id_id`, `pic_source`) VALUES
(6, 1, 'ยินดีต้อนรับสมาชิกใหม่', '\"ขอต้อนรับท่านเข้าสู่ครอบครัวของเรา! เราขอขอบคุณที่ท่านเลือกเป็นลูกค้าของเราและยินดีที่จะมีโอกาสที่จะบริการท่านทุกวันนี้และในอนาคตที่ยาวนาน\r\n\r\nเรามุ่งมั่นที่จะให้บริการท่านด้วยคุณภาพที่ดีที่สุด และทำให้ท่านรู้สึกพิเศษทุกครั้งที่ท่านมาถึงที่นี่. หากท่านมีคำถามหรือข้อเสนอแนะใด ๆ เกี่ยวกับผลิตภัณฑ์หรือบริการของเรา โปรดอย่าลังเลที่จะติดต่อเรา ทีมงานของเราพร้อมรับฟังและช่วยเสมอ\r\n\r\nขอขอบคุณอีกครั้งที่ท่านมาเป็นส่วนหนึ่งของครอบครัวของเรา และเราหวังว่าท่านจะมีประสบการณ์ที่ยอดเยี่ยมกับเราทุกครั้งที่ท่านมาถึงที่นี่\r\n\r\nขอให้ท่านมีวันที่สดใสและอิ่มอร่อยกับผลิตภัณฑ์และบริการของเรา! ขอบคุณอีกครั้งที่ท่านมาเป็นส่วนหนึ่งของทีมของเรา.\"', '2023-10-19 20:01:23.000000', 4, NULL),
(7, 0, 'ยินดีต้อนรับสมาชิกใหม่', '\n\"ขอต้อนรับท่านเข้าสู่ครอบครัวของเรา! เราขอขอบคุณที่ท่านเลือกเป็นลูกค้าของเราและยินดีที่จะมีโอกาสที่จะบริการท่านทุกวันนี้และในอนาคตที่ยาวนาน\n\nเรามุ่งมั่นที่จะให้บริการท่านด้วยคุณภาพที่ดีที่สุด และทำให้ท่านรู้สึกพิเศษทุกครั้งที่ท่านมาถึงที่นี่. หากท่านมีคำถามหรือข้อเสนอแนะใด ๆ เกี่ยวกับผลิตภัณฑ์หรือบริการของเรา โปรดอย่าลังเลที่จะติดต่อเรา ทีมงานของเราพร้อมรับฟังและช่วยเสมอ\n\nขอขอบคุณอีกครั้งที่ท่านมาเป็นส่วนหนึ่งของครอบครัวของเรา และเราหวังว่าท่านจะมีประสบการณ์ที่ยอดเยี่ยมกับเราทุกครั้งที่ท่านมาถึงที่นี่\n\nขอให้ท่านมีวันที่สดใสและอิ่มอร่อยกับผลิตภัณฑ์และบริการของเรา! ขอบคุณอีกครั้งที่ท่านมาเป็นส่วนหนึ่งของทีมของเรา.\"\n', '2023-10-25 11:34:31.000000', 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_star`
--

CREATE TABLE `app_gen_star` (
  `id` bigint(20) NOT NULL,
  `DetailImgGen_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_star`
--

INSERT INTO `app_gen_star` (`id`, `DetailImgGen_id`, `user_id`) VALUES
(24, 5, 2),
(27, 4, 2),
(32, 33, 1),
(33, 48, 5),
(35, 4, 1),
(42, 31, 1),
(43, 49, 1),
(44, 45, 1),
(45, 39, 1),
(46, 66, 1),
(47, 31, 2),
(48, 78, 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_transaction`
--

CREATE TABLE `app_gen_transaction` (
  `upgrade_id` bigint(20) NOT NULL,
  `start_date` datetime(6) DEFAULT NULL,
  `duedate` datetime(6) DEFAULT NULL,
  `status` tinyint(1) NOT NULL,
  `purchase_date` datetime DEFAULT NULL,
  `total_amount` int(11) NOT NULL,
  `acc_id_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_transaction`
--

INSERT INTO `app_gen_transaction` (`upgrade_id`, `start_date`, `duedate`, `status`, `purchase_date`, `total_amount`, `acc_id_id`) VALUES
(1, '2023-08-28 23:30:42.000000', '2023-09-28 23:30:42.000000', 1, '2023-08-28 00:00:00', 100, 1),
(2, '2023-08-29 20:50:03.000000', '2023-09-29 20:50:03.000000', 1, '2023-08-29 00:00:00', 1500, 1),
(4, '2023-08-30 11:54:56.000000', '2023-09-30 11:54:56.000000', 1, '2023-08-30 00:00:00', 100, 1),
(5, '2023-09-02 19:02:48.000000', '2023-10-02 19:02:48.000000', 1, '2023-09-02 00:00:00', 1500, 1),
(6, '2023-09-03 22:41:10.000000', '2023-10-03 22:41:10.000000', 1, '2023-09-03 00:00:00', 100, 2),
(7, '2023-10-02 14:26:17.000000', '2023-10-26 14:26:17.000000', 1, '2023-10-02 00:00:00', 1500, 2),
(10, '2023-10-09 23:14:03.000000', '2023-11-09 23:14:03.000000', 1, '2023-10-09 23:14:03', 100, 1),
(11, '2023-10-25 11:36:35.000000', '2023-11-25 11:36:35.000000', 1, '2023-10-25 11:36:35', 100, 5),
(12, '2023-10-25 11:37:22.000000', '2023-11-25 11:37:22.000000', 1, '2023-10-25 11:37:22', 1500, 5),
(13, '2023-10-25 11:37:52.000000', '2023-11-25 11:37:52.000000', 1, '2023-10-25 11:37:52', 0, 5),
(14, '2023-10-26 00:27:07.000000', '2023-11-26 00:27:07.000000', 1, '2023-10-26 00:27:07', 100, 1),
(15, '2023-11-03 18:16:15.000000', '2023-12-03 18:16:15.000000', 1, '2023-11-03 18:16:15', 100, 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_gen_user`
--

CREATE TABLE `app_gen_user` (
  `id` bigint(20) NOT NULL,
  `userEmail` varchar(255) NOT NULL,
  `hash_pass` varchar(255) NOT NULL,
  `pic` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL,
  `regAt` datetime(6) DEFAULT NULL,
  `lastLogin` datetime(6) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `note` longtext NOT NULL,
  `classUser_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `app_gen_user`
--

INSERT INTO `app_gen_user` (`id`, `userEmail`, `hash_pass`, `pic`, `status`, `regAt`, `lastLogin`, `name`, `note`, `classUser_id`) VALUES
(1, 'anda@gmail.com', '13e5ebb0fa112fe1b31a1067962d74a7', '/static/app_gen/imgGen/1/profile.png', 1, '2023-08-08 13:51:21.000000', '2023-10-31 21:50:59.000000', 'AndaL.', 'This is my packa profile', 2),
(2, 'johnsmith@email.com', '827ccb0eea8a706c4c34a16891f84e7b', '/static/app_gen/imgGen/2/profile.png', 0, '2023-09-03 22:26:50.000000', '2023-11-03 16:01:52.000000', 'John Couple', 'This is my packa profile', 2),
(3, 'popo1234@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', '/static/app_gen/imgGen/3/profile.png', 0, '2023-10-19 19:43:53.000000', '2023-10-19 19:43:53.000000', 'popo1234', 'This is my packa profile', 1),
(4, 'sulaiman@email.com', '827ccb0eea8a706c4c34a16891f84e7b', '/static/app_gen/imgGen/4/profile.png', 0, '2023-10-19 19:59:22.000000', '2023-10-19 19:59:22.000000', 'sulaiman', 'This is my packa profile', 1),
(5, 'user1234@gmail.com', '827ccb0eea8a706c4c34a16891f84e7b', 'https://images.unsplash.com/photo-1635614017406-7c192d832072?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80', 0, '2023-10-25 11:34:31.000000', '2023-10-25 12:05:56.000000', 'user1234', 'This is my packa profile', 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add class', 7, 'add_class'),
(26, 'Can change class', 7, 'change_class'),
(27, 'Can delete class', 7, 'delete_class'),
(28, 'Can view class', 7, 'view_class'),
(29, 'Can add collection', 8, 'add_collection'),
(30, 'Can change collection', 8, 'change_collection'),
(31, 'Can delete collection', 8, 'delete_collection'),
(32, 'Can view collection', 8, 'view_collection'),
(33, 'Can add detail img gen', 9, 'add_detailimggen'),
(34, 'Can change detail img gen', 9, 'change_detailimggen'),
(35, 'Can delete detail img gen', 9, 'delete_detailimggen'),
(36, 'Can view detail img gen', 9, 'view_detailimggen'),
(37, 'Can add user', 10, 'add_user'),
(38, 'Can change user', 10, 'change_user'),
(39, 'Can delete user', 10, 'delete_user'),
(40, 'Can view user', 10, 'view_user'),
(41, 'Can add transaction', 11, 'add_transaction'),
(42, 'Can change transaction', 11, 'change_transaction'),
(43, 'Can delete transaction', 11, 'delete_transaction'),
(44, 'Can view transaction', 11, 'view_transaction'),
(45, 'Can add notification', 12, 'add_notification'),
(46, 'Can change notification', 12, 'change_notification'),
(47, 'Can delete notification', 12, 'delete_notification'),
(48, 'Can view notification', 12, 'view_notification'),
(49, 'Can add img gen', 13, 'add_imggen'),
(50, 'Can change img gen', 13, 'change_imggen'),
(51, 'Can delete img gen', 13, 'delete_imggen'),
(52, 'Can view img gen', 13, 'view_imggen'),
(53, 'Can add illegal', 14, 'add_illegal'),
(54, 'Can change illegal', 14, 'change_illegal'),
(55, 'Can delete illegal', 14, 'delete_illegal'),
(56, 'Can view illegal', 14, 'view_illegal'),
(57, 'Can add follow', 15, 'add_follow'),
(58, 'Can change follow', 15, 'change_follow'),
(59, 'Can delete follow', 15, 'delete_follow'),
(60, 'Can view follow', 15, 'view_follow'),
(61, 'Can add detail collection', 16, 'add_detailcollection'),
(62, 'Can change detail collection', 16, 'change_detailcollection'),
(63, 'Can delete detail collection', 16, 'delete_detailcollection'),
(64, 'Can view detail collection', 16, 'view_detailcollection'),
(65, 'Can add credit card', 17, 'add_creditcard'),
(66, 'Can change credit card', 17, 'change_creditcard'),
(67, 'Can delete credit card', 17, 'delete_creditcard'),
(68, 'Can view credit card', 17, 'view_creditcard'),
(69, 'Can add bin', 18, 'add_bin'),
(70, 'Can change bin', 18, 'change_bin'),
(71, 'Can delete bin', 18, 'delete_bin'),
(72, 'Can view bin', 18, 'view_bin'),
(73, 'Can add comment img gen', 19, 'add_commentimggen'),
(74, 'Can change comment img gen', 19, 'change_commentimggen'),
(75, 'Can delete comment img gen', 19, 'delete_commentimggen'),
(76, 'Can view comment img gen', 19, 'view_commentimggen'),
(77, 'Can add star', 20, 'add_star'),
(78, 'Can change star', 20, 'change_star'),
(79, 'Can delete star', 20, 'delete_star'),
(80, 'Can view star', 20, 'view_star'),
(81, 'Can add test', 21, 'add_test'),
(82, 'Can change test', 21, 'change_test'),
(83, 'Can delete test', 21, 'delete_test'),
(84, 'Can view test', 21, 'view_test');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$0olMCsHfVhCM8yOx1bPbvo$SOqR9RCYqIg3szZhTPj3ov0aidGW7JfOkIhs4R6cpEw=', '2023-11-03 19:12:07.000000', 1, 'anda', '', '', '', 1, 1, '2023-08-28 23:22:22.000000');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-08-28 23:25:46.000000', '1', 'anda@gmail.com', 2, '[{\"changed\": {\"fields\": [\"ClassUser\"]}}]', 10, 1),
(2, '2023-08-28 23:28:27.000000', '3', 'Lorem IpSUM', 1, '[{\"added\": {}}]', 12, 1),
(3, '2023-08-29 13:22:11.000000', '12', 'ID #12', 2, '[]', 13, 1),
(4, '2023-08-29 13:23:06.000000', '13', 'ID #13', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(5, '2023-08-29 13:23:14.000000', '13', 'ID #13', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(6, '2023-08-29 13:23:38.000000', '12', 'ID #12', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(7, '2023-08-29 13:24:37.000000', '12', 'ID #12', 2, '[]', 13, 1),
(8, '2023-08-29 13:25:04.000000', '12', 'ID #12', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(9, '2023-08-29 13:28:24.000000', '12', 'ID #12', 3, '', 13, 1),
(10, '2023-08-29 13:28:36.000000', '13', '13my new Pakaging here!', 3, '', 9, 1),
(11, '2023-08-29 13:29:17.000000', '11', '11my new Pakaging here!', 3, '', 9, 1),
(12, '2023-08-29 13:39:00.000000', '4', '4', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(13, '2023-08-29 13:39:05.000000', '5', '5', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(14, '2023-08-29 13:39:10.000000', '6', '6', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(15, '2023-08-29 13:39:15.000000', '7', '7', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(16, '2023-08-29 13:39:19.000000', '7', '7', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(17, '2023-08-29 13:39:23.000000', '8', '8', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(18, '2023-08-29 13:39:27.000000', '9', '9', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(19, '2023-08-29 13:39:31.000000', '10', '10', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(20, '2023-08-29 13:39:40.000000', '12', '12my new Pakaging here!', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(21, '2023-08-29 13:40:05.000000', '14', '14my new Pakaging here!', 2, '[{\"changed\": {\"fields\": [\"Gen\"]}}]', 9, 1),
(22, '2023-08-29 14:36:09.000000', '15', '15mdjrny-v4%20style-box%20%20bottle%20with%20mango%20and%20orange%20minimal%20and%20blue-tone.png', 2, '[{\"changed\": {\"fields\": [\"Gen message\"]}}]', 9, 1),
(23, '2023-08-29 14:36:16.000000', '14', 'ID #14', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(24, '2023-08-29 14:38:02.000000', '14', 'ID #14', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(25, '2023-08-29 14:38:09.000000', '14', 'ID #14', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(26, '2023-08-29 14:49:46.000000', '15', 'ID #15', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(27, '2023-08-29 14:49:55.000000', '15', 'ID #15', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(28, '2023-08-29 14:50:34.000000', '15', 'ID #15', 3, '', 13, 1),
(29, '2023-08-29 15:09:05.000000', '16', 'ID #16', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(30, '2023-08-29 15:09:44.000000', '16', 'ID #16', 2, '[]', 13, 1),
(31, '2023-08-29 15:21:35.000000', '17', 'ID #17', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(32, '2023-08-29 15:23:54.000000', '16', 'ID #16', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(33, '2023-08-29 15:24:07.000000', '16', 'ID #16', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(34, '2023-08-29 15:24:19.000000', '17', 'ID #17', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(35, '2023-08-29 15:26:07.000000', '16', 'ID #16', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(36, '2023-08-29 15:26:38.000000', '16', 'ID #16', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(37, '2023-08-29 15:26:56.000000', '16', 'ID #16', 2, '[]', 13, 1),
(38, '2023-08-29 15:27:38.000000', '16', 'ID #16', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(39, '2023-08-29 15:28:18.000000', '17', 'ID #17', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(40, '2023-08-29 21:41:18.000000', '2', '2', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1),
(41, '2023-08-29 21:55:52.000000', '2', '2', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 11, 1),
(42, '2023-08-29 22:22:16.000000', '3', '3', 3, '', 11, 1),
(43, '2023-08-30 11:56:23.000000', '2', 'Welcome Beginner', 2, '[]', 12, 1),
(44, '2023-08-30 11:56:27.000000', '3', 'Lorem IpSUM', 3, '', 12, 1),
(45, '2023-09-03 21:23:27.000000', '1', 'look great , how to create this prompt', 1, '[{\"added\": {}}]', 19, 1),
(46, '2023-09-03 21:39:40.000000', '1', 'ID #3', 1, '[{\"added\": {}}]', 18, 1),
(47, '2023-09-03 21:58:31.000000', '2', 'ID #8', 1, '[{\"added\": {}}]', 18, 1),
(48, '2023-09-03 22:13:57.000000', '1', 'look great , how to create this prompt', 2, '[]', 19, 1),
(49, '2023-09-03 22:16:40.000000', '1', 'look great , how to create this prompt', 2, '[{\"changed\": {\"fields\": [\"Date\"]}}]', 19, 1),
(50, '2023-09-03 22:18:45.000000', '2', 'That is insane bro!!!', 1, '[{\"added\": {}}]', 19, 1),
(51, '2023-09-03 22:19:10.000000', '3', 'Good Idea , good prompt , good gen..', 1, '[{\"added\": {}}]', 19, 1),
(52, '2023-09-03 22:27:28.000000', '3', 'ID #3', 2, '[{\"changed\": {\"fields\": [\"Acc id\"]}}]', 13, 1),
(53, '2023-09-07 14:27:09.000000', '4', 'ID #4', 2, '[{\"changed\": {\"fields\": [\"Acc id\"]}}]', 13, 1),
(54, '2023-09-07 14:27:33.000000', '5', '5', 2, '[{\"changed\": {\"fields\": [\"Gen isPublic\"]}}]', 9, 1),
(55, '2023-09-07 14:37:24.000000', '5', '5', 2, '[{\"changed\": {\"fields\": [\"Gen isPublic\"]}}]', 9, 1),
(56, '2023-09-07 15:38:21.000000', '4', '4', 2, '[{\"changed\": {\"fields\": [\"IsRemove\"]}}]', 9, 1),
(57, '2023-09-07 15:38:37.000000', '15', '15mdjrny-v4%20style-box%20%20bottle%20with%20mango%20and%20orange%20minimal%20and%20blue-tone.png', 2, '[{\"changed\": {\"fields\": [\"IsRemove\"]}}]', 9, 1),
(58, '2023-09-13 12:55:33.000000', '4', 'Lorem IpSUM', 1, '[{\"added\": {}}]', 12, 1),
(59, '2023-09-13 12:59:18.000000', '5', 'Lorem IpSUM', 1, '[{\"added\": {}}]', 12, 1),
(60, '2023-09-13 16:28:45.000000', '1', 'Collection object (1)', 1, '[{\"added\": {}}]', 8, 1),
(61, '2023-09-13 16:30:00.000000', '1', 'DetailCollection object (1)', 1, '[{\"added\": {}}]', 16, 1),
(62, '2023-09-13 16:30:10.000000', '1', 'Collection object (1)', 2, '[]', 8, 1),
(63, '2023-09-13 16:30:38.000000', '2', 'DetailCollection object (2)', 1, '[{\"added\": {}}]', 16, 1),
(64, '2023-09-13 16:40:37.000000', '3', 'DetailCollection object (3)', 1, '[{\"added\": {}}]', 16, 1),
(65, '2023-09-13 16:42:16.000000', '2', 'DetailCollection object (2)', 3, '', 16, 1),
(66, '2023-09-13 16:42:16.000000', '1', 'DetailCollection object (1)', 3, '', 16, 1),
(67, '2023-09-13 16:42:26.000000', '3', 'DetailCollection object (3)', 2, '[]', 16, 1),
(68, '2023-09-13 16:42:32.000000', '4', 'DetailCollection object (4)', 1, '[{\"added\": {}}]', 16, 1),
(69, '2023-09-13 16:42:48.000000', '5', 'DetailCollection object (5)', 1, '[{\"added\": {}}]', 16, 1),
(70, '2023-09-13 16:43:04.000000', '5', 'DetailCollection object (5)', 2, '[]', 16, 1),
(71, '2023-09-13 16:43:07.000000', '4', 'DetailCollection object (4)', 2, '[]', 16, 1),
(72, '2023-09-13 16:43:08.000000', '3', 'DetailCollection object (3)', 2, '[]', 16, 1),
(73, '2023-09-13 16:43:18.000000', '1', 'Collection object (1)', 2, '[]', 8, 1),
(74, '2023-09-13 16:43:27.000000', '6', 'DetailCollection object (6)', 1, '[{\"added\": {}}]', 16, 1),
(75, '2023-09-13 16:43:32.000000', '1', 'Collection object (1)', 2, '[]', 8, 1),
(76, '2023-09-13 16:43:44.000000', '6', 'DetailCollection object (6)', 2, '[]', 16, 1),
(77, '2023-09-13 16:43:53.000000', '1', 'Collection object (1)', 2, '[]', 8, 1),
(78, '2023-09-13 16:44:11.000000', '7', 'DetailCollection object (7)', 1, '[{\"added\": {}}]', 16, 1),
(79, '2023-09-13 16:44:24.000000', '6', 'DetailCollection object (6)', 2, '[]', 16, 1),
(80, '2023-09-13 16:49:00.000000', '8', 'DetailCollection object (8)', 1, '[{\"added\": {}}]', 16, 1),
(81, '2023-09-13 17:05:52.000000', '3', 'DetailCollection object (3)', 3, '', 16, 1),
(82, '2023-09-13 17:06:10.000000', '8', 'DetailCollection object (8)', 3, '', 16, 1),
(83, '2023-09-13 17:06:21.000000', '7', 'DetailCollection object (7)', 2, '[]', 16, 1),
(84, '2023-09-13 17:06:29.000000', '1', 'Collection object (1)', 2, '[]', 8, 1),
(85, '2023-09-13 17:37:57.000000', '1', 'Star object (1)', 1, '[{\"added\": {}}]', 20, 1),
(86, '2023-09-13 17:38:35.000000', '2', 'Star object (2)', 1, '[{\"added\": {}}]', 20, 1),
(87, '2023-09-13 17:56:27.000000', '2', 'johnsmith', 2, '[]', 20, 1),
(88, '2023-09-13 18:01:00.000000', '3', 'anda', 1, '[{\"added\": {}}]', 20, 1),
(89, '2023-09-13 18:01:41.000000', '4', 'johnsmith', 1, '[{\"added\": {}}]', 20, 1),
(90, '2023-09-21 22:09:07.000000', '1', 'test object (1)', 1, '[{\"added\": {}}]', 21, 1),
(91, '2023-09-21 22:09:44.000000', '1', 'test object (1)', 3, '', 21, 1),
(92, '2023-09-21 22:28:32.000000', '16', 'ID #16', 3, '', 13, 1),
(93, '2023-09-21 22:31:32.000000', '22', 'ID #22', 1, '[{\"added\": {}}]', 13, 1),
(94, '2023-09-21 22:31:57.000000', '22', 'ID #22', 3, '', 13, 1),
(95, '2023-09-21 22:33:16.000000', '23', 'ID #23', 1, '[{\"added\": {}}]', 13, 1),
(97, '2023-09-21 22:44:59.000000', '23', 'ID #23', 2, '[]', 13, 1),
(98, '2023-09-21 22:45:06.000000', '23', 'ID #23', 3, '', 13, 1),
(99, '2023-09-21 22:48:44.000000', '23', 'ID #23', 2, '[]', 13, 1),
(100, '2023-09-21 22:49:26.000000', '11', 'ID #11', 2, '[]', 13, 1),
(101, '2023-09-21 22:51:45.000000', '6', 'ID #6', 2, '[]', 13, 1),
(102, '2023-09-21 22:52:06.000000', '3', 'ID #3', 2, '[]', 13, 1),
(103, '2023-09-21 22:52:11.000000', '3', 'ID #3', 2, '[]', 13, 1),
(104, '2023-09-21 22:52:17.000000', '11', 'ID #11', 2, '[]', 13, 1),
(105, '2023-09-21 22:52:45.000000', '16', 'ID #16', 3, '', 13, 1),
(106, '2023-09-21 22:52:55.000000', '23', 'ID #23', 3, '', 13, 1),
(107, '2023-09-21 22:53:09.000000', '23', 'ID #23', 2, '[]', 13, 1),
(108, '2023-09-21 22:54:39.000000', '14', 'ID #14', 3, '', 13, 1),
(110, '2023-09-21 22:55:47.000000', '14', 'ID #14', 3, '', 13, 1),
(111, '2023-09-21 22:56:57.000000', '14', 'ID #14', 3, '', 13, 1),
(112, '2023-09-21 22:57:02.000000', '23', 'ID #23', 3, '', 13, 1),
(113, '2023-09-21 22:57:08.000000', '11', 'ID #11', 3, '', 13, 1),
(114, '2023-09-21 22:57:14.000000', '22', 'ID #22', 3, '', 13, 1),
(115, '2023-09-21 22:57:18.000000', '16', 'ID #16', 3, '', 13, 1),
(116, '2023-09-21 23:00:34.000000', '9', 'ID #9', 3, '', 13, 1),
(117, '2023-09-21 23:00:38.000000', '13', 'ID #13', 3, '', 13, 1),
(118, '2023-09-21 23:00:43.000000', '17', 'ID #17', 3, '', 13, 1),
(119, '2023-09-21 23:00:46.000000', '19', 'ID #19', 3, '', 13, 1),
(120, '2023-09-21 23:00:49.000000', '20', 'ID #20', 3, '', 13, 1),
(121, '2023-09-21 23:00:52.000000', '21', 'ID #21', 3, '', 13, 1),
(122, '2023-09-21 23:08:06.000000', '3', 'ID #3', 2, '[]', 13, 1),
(123, '2023-09-21 23:09:25.000000', '6', 'ID #6', 2, '[]', 13, 1),
(124, '2023-09-21 23:09:56.000000', '6', 'ID #6', 2, '[]', 13, 1),
(125, '2023-09-21 23:14:17.000000', '6', 'ID #6', 2, '[]', 13, 1),
(126, '2023-09-25 13:54:41.000000', '4', 'John Couple', 3, '', 20, 1),
(127, '2023-09-25 13:54:41.000000', '3', 'AndaL.', 3, '', 20, 1),
(128, '2023-09-25 13:55:47.000000', '5', 'AndaL.', 1, '[{\"added\": {}}]', 20, 1),
(129, '2023-09-25 13:56:13.000000', '5', 'AndaL.', 2, '[]', 20, 1),
(130, '2023-09-25 13:57:34.000000', '5', 'AndaL.', 2, '[]', 20, 1),
(131, '2023-09-25 13:57:57.000000', '5', 'AndaL.', 2, '[]', 20, 1),
(132, '2023-09-25 13:59:18.000000', '5', 'AndaL.', 2, '[]', 20, 1),
(133, '2023-09-25 13:59:29.000000', '5', 'AndaL.', 3, '', 20, 1),
(134, '2023-09-25 13:59:40.000000', '6', 'AndaL.', 1, '[{\"added\": {}}]', 20, 1),
(135, '2023-09-25 14:01:50.000000', '6', 'AndaL.', 2, '[]', 20, 1),
(136, '2023-09-25 14:15:47.000000', '6', 'ID #6', 2, '[]', 13, 1),
(137, '2023-09-25 14:18:36.000000', '8', 'ID : 8 , ', 2, '[{\"changed\": {\"fields\": [\"Gen star\"]}}]', 9, 1),
(138, '2023-09-25 14:18:42.000000', '8', 'ID #8', 2, '[]', 13, 1),
(139, '2023-10-02 12:38:42.000000', '6', 'AndaL.', 2, '[]', 20, 1),
(140, '2023-10-02 12:49:58.000000', '8', 'John Couple', 3, '', 20, 1),
(141, '2023-10-02 12:50:27.000000', '8', 'John Couple', 3, '', 20, 1),
(142, '2023-10-02 12:51:05.000000', '7', 'John Couple', 2, '[]', 20, 1),
(143, '2023-10-02 13:01:42.000000', '9', 'John Couple', 3, '', 20, 1),
(144, '2023-10-02 13:01:42.000000', '7', 'John Couple', 3, '', 20, 1),
(145, '2023-10-02 13:04:26.000000', '11', 'John Couple', 3, '', 20, 1),
(146, '2023-10-02 13:07:44.000000', '10', 'John Couple', 3, '', 20, 1),
(147, '2023-10-02 13:10:11.000000', '12', 'John Couple', 3, '', 20, 1),
(148, '2023-10-02 13:11:19.000000', '13', 'John Couple', 3, '', 20, 1),
(149, '2023-10-02 13:13:30.000000', '14', 'John Couple', 3, '', 20, 1),
(150, '2023-10-02 13:56:17.000000', '15', 'John Couple', 3, '', 20, 1),
(151, '2023-10-02 13:56:48.000000', '16', 'John Couple', 3, '', 20, 1),
(152, '2023-10-02 15:31:58.000000', '1', 'Illegal object (1)', 3, '', 14, 1),
(153, '2023-10-02 16:01:16.000000', '3', 'Illegal object (3)', 3, '', 14, 1),
(154, '2023-10-02 16:01:16.000000', '4', 'Illegal object (4)', 3, '', 14, 1),
(155, '2023-10-02 16:09:37.000000', '2', 'Illegal object (2)', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(156, '2023-10-06 12:05:21.000000', '8', '8', 1, '[{\"added\": {}}]', 11, 1),
(157, '2023-10-06 12:05:32.000000', '9', '9', 1, '[{\"added\": {}}]', 11, 1),
(158, '2023-10-19 17:59:23.000000', '27', 'ID : 27 , nge juice and orange leaf with black background', 2, '[{\"changed\": {\"fields\": [\"Gen isPublic\", \"Gen message\"]}}]', 9, 1),
(159, '2023-10-19 20:01:23.000000', '6', 'ยินดีต้อนรับสมาชิกใหม่', 2, '[{\"changed\": {\"fields\": [\"Pic source\", \"Notice detail\", \"Notice date\"]}}]', 12, 1),
(160, '2023-10-19 20:12:40.000000', '37', 'ID #37', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(161, '2023-10-19 22:03:05.000000', '37', 'ID #37', 2, '[{\"changed\": {\"fields\": [\"Gen source\"]}}]', 13, 1),
(162, '2023-10-23 19:10:34.000000', '9', '9', 3, '', 11, 1),
(163, '2023-10-23 19:10:37.000000', '8', '8', 3, '', 11, 1),
(164, '2023-10-25 11:55:23.000000', '6', 'Illegal object (6)', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(165, '2023-10-25 11:55:39.000000', '5', 'Illegal object (5)', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 14, 1),
(166, '2023-10-25 11:57:06.000000', '7', 'Illegal object (7)', 1, '[{\"added\": {}}]', 14, 1),
(168, '2023-10-26 11:11:42.000000', '36', 'ID #36', 3, '', 13, 1),
(175, '2023-10-26 11:18:14.000000', '36', 'ID #36', 3, '', 13, 1),
(176, '2023-10-26 11:18:33.000000', '36', 'ID #36', 3, '', 13, 1),
(177, '2023-10-26 11:19:08.000000', '35', 'ID #35', 3, '', 13, 1),
(179, '2023-10-26 11:20:38.000000', '27', 'ID #27', 3, '', 13, 1),
(180, '2023-10-26 11:21:18.000000', '6', 'ID #6', 3, '', 13, 1),
(183, '2023-10-26 11:24:10.000000', '3', 'ID #3', 3, '', 13, 1),
(184, '2023-10-26 11:30:41.000000', '27', 'ID #27', 3, '', 13, 1),
(185, '2023-10-26 11:32:26.000000', '3', 'ID #3', 3, '', 13, 1),
(186, '2023-10-26 11:32:58.000000', '6', 'ID #6', 3, '', 13, 1),
(187, '2023-10-26 11:33:16.000000', '6', 'ID #6', 3, '', 13, 1),
(188, '2023-10-26 11:33:31.000000', '6', 'ID #6', 3, '', 13, 1),
(189, '2023-10-26 11:34:55.000000', '6', 'ID #6', 3, '', 13, 1),
(190, '2023-10-26 11:35:18.000000', '6', 'ID #6', 3, '', 13, 1),
(191, '2023-10-26 11:36:28.000000', '6', 'ID #6', 3, '', 13, 1),
(192, '2023-10-26 11:36:58.000000', '6', 'ID #6', 3, '', 13, 1),
(193, '2023-10-26 11:37:58.000000', '6', 'ID #6', 3, '', 13, 1),
(194, '2023-10-26 11:44:16.000000', '36', 'ID #36', 3, '', 13, 1),
(195, '2023-10-26 11:50:22.000000', '27', 'ID #27', 3, '', 13, 1),
(196, '2023-10-26 11:52:14.000000', '35', 'ID #35', 3, '', 13, 1),
(197, '2023-10-26 11:52:58.000000', '35', 'ID #35', 3, '', 13, 1),
(198, '2023-10-26 11:54:57.000000', '35', 'ID #35', 3, '', 13, 1),
(199, '2023-10-26 11:56:05.000000', '35', 'ID #35', 3, '', 13, 1),
(200, '2023-10-26 12:03:43.000000', '35', 'ID #35', 3, '', 13, 1),
(201, '2023-10-26 12:04:48.000000', '35', 'ID #35', 3, '', 13, 1),
(202, '2023-10-26 12:05:34.000000', '35', 'ID #35', 3, '', 13, 1),
(203, '2023-10-26 13:07:10.000000', '35', 'ID #35', 3, '', 13, 1),
(204, '2023-10-28 20:03:14.000000', '1', 'anda@gmail.com', 2, '[{\"changed\": {\"fields\": [\"Status\"]}}]', 10, 1),
(205, '2023-10-31 12:21:20.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(206, '2023-10-31 12:23:38.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(207, '2023-10-31 12:24:53.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(208, '2023-10-31 12:27:08.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(209, '2023-10-31 15:23:30.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(210, '2023-10-31 15:25:33.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(211, '2023-10-31 15:29:19.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(212, '2023-10-31 15:29:47.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(213, '2023-10-31 15:35:00.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(214, '2023-10-31 15:36:36.000000', '2', 'Welcome Beginner', 2, '[{\"changed\": {\"fields\": [\"Pic source\"]}}]', 12, 1),
(215, '2023-10-31 21:50:17.000000', '2', 'Illegal object (2)', 3, '', 14, 1),
(216, '2023-10-31 21:50:17.000000', '5', 'Illegal object (5)', 3, '', 14, 1),
(217, '2023-10-31 21:50:17.000000', '6', 'Illegal object (6)', 3, '', 14, 1),
(218, '2023-10-31 21:50:17.000000', '7', 'Illegal object (7)', 3, '', 14, 1),
(219, '2023-10-31 21:50:17.000000', '8', 'Illegal object (8)', 3, '', 14, 1),
(220, '2023-10-31 21:50:17.000000', '9', 'Illegal object (9)', 3, '', 14, 1),
(221, '2023-10-31 21:50:17.000000', '10', 'Illegal object (10)', 3, '', 14, 1),
(222, '2023-10-31 21:50:17.000000', '11', 'Illegal object (11)', 3, '', 14, 1),
(223, '2023-10-31 21:50:17.000000', '12', 'Illegal object (12)', 3, '', 14, 1),
(224, '2023-10-31 21:50:17.000000', '13', 'Illegal object (13)', 3, '', 14, 1),
(225, '2023-10-31 21:50:17.000000', '14', 'Illegal object (14)', 3, '', 14, 1),
(226, '2023-10-31 21:50:17.000000', '15', 'Illegal object (15)', 3, '', 14, 1),
(227, '2023-10-31 21:50:17.000000', '16', 'Illegal object (16)', 3, '', 14, 1),
(228, '2023-10-31 21:50:17.000000', '17', 'Illegal object (17)', 3, '', 14, 1),
(229, '2023-10-31 21:50:17.000000', '18', 'Illegal object (18)', 3, '', 14, 1),
(230, '2023-10-31 21:50:17.000000', '19', 'Illegal object (19)', 3, '', 14, 1),
(231, '2023-10-31 21:50:17.000000', '20', 'Illegal object (20)', 3, '', 14, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(18, 'app_gen', 'bin'),
(7, 'app_gen', 'class'),
(8, 'app_gen', 'collection'),
(19, 'app_gen', 'commentimggen'),
(17, 'app_gen', 'creditcard'),
(16, 'app_gen', 'detailcollection'),
(9, 'app_gen', 'detailimggen'),
(15, 'app_gen', 'follow'),
(14, 'app_gen', 'illegal'),
(13, 'app_gen', 'imggen'),
(12, 'app_gen', 'notification'),
(20, 'app_gen', 'star'),
(21, 'app_gen', 'test'),
(11, 'app_gen', 'transaction'),
(10, 'app_gen', 'user'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-08-28 23:19:58.000000'),
(2, 'auth', '0001_initial', '2023-08-28 23:19:58.000000'),
(3, 'admin', '0001_initial', '2023-08-28 23:19:58.000000'),
(4, 'admin', '0002_logentry_remove_auto_add', '2023-08-28 23:19:59.000000'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2023-08-28 23:19:59.000000'),
(6, 'app_gen', '0001_initial', '2023-08-28 23:20:00.000000'),
(7, 'contenttypes', '0002_remove_content_type_name', '2023-08-28 23:20:00.000000'),
(8, 'auth', '0002_alter_permission_name_max_length', '2023-08-28 23:20:00.000000'),
(9, 'auth', '0003_alter_user_email_max_length', '2023-08-28 23:20:00.000000'),
(10, 'auth', '0004_alter_user_username_opts', '2023-08-28 23:20:00.000000'),
(11, 'auth', '0005_alter_user_last_login_null', '2023-08-28 23:20:00.000000'),
(12, 'auth', '0006_require_contenttypes_0002', '2023-08-28 23:20:00.000000'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2023-08-28 23:20:00.000000'),
(14, 'auth', '0008_alter_user_username_max_length', '2023-08-28 23:20:00.000000'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2023-08-28 23:20:00.000000'),
(16, 'auth', '0010_alter_group_name_max_length', '2023-08-28 23:20:00.000000'),
(17, 'auth', '0011_update_proxy_permissions', '2023-08-28 23:20:00.000000'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2023-08-28 23:20:00.000000'),
(19, 'sessions', '0001_initial', '2023-08-28 23:20:00.000000'),
(20, 'app_gen', '0002_remove_imggen_gendetail_id_detailimggen_gen_and_more', '2023-08-29 13:38:29.000000'),
(21, 'app_gen', '0003_alter_imggen_gen_source', '2023-08-29 15:25:49.000000'),
(22, 'app_gen', '0004_commentimggen', '2023-09-03 21:22:25.000000'),
(23, 'app_gen', '0005_rename_gen_star_commentimggen_like_and_more', '2023-09-03 21:22:25.000000'),
(24, 'app_gen', '0006_remove_commentimggen_like_commentimggen_date', '2023-09-03 22:16:29.000000'),
(25, 'app_gen', '0007_alter_commentimggen_gen', '2023-09-03 22:18:19.000000'),
(26, 'app_gen', '0008_detailimggen_duetime_detailimggen_isremove_and_more', '2023-09-07 15:20:47.000000'),
(27, 'app_gen', '0009_collection_total_alter_detailimggen_duetime_and_more', '2023-09-13 16:27:17.000000'),
(28, 'app_gen', '0010_detailcollection_total_amount', '2023-09-13 16:40:21.000000'),
(29, 'app_gen', '0011_remove_collection_total_and_more', '2023-09-13 17:25:06.000000'),
(30, 'app_gen', '0012_test', '2023-09-21 22:08:26.000000'),
(31, 'app_gen', '0013_delete_test', '2023-09-21 22:10:48.000000'),
(32, 'app_gen', '0014_illegal_report_date_alter_star_detailimggen', '2023-10-02 15:21:18.000000'),
(33, 'app_gen', '0015_collection_col_user', '2023-10-13 21:41:34.000000'),
(34, 'app_gen', '0016_remove_follow_source_id_remove_follow_target_id_and_more', '2023-10-13 21:41:34.000000'),
(35, 'app_gen', '0017_notification_notice_test', '2023-10-31 15:20:05.000000'),
(36, 'app_gen', '0018_notification_pic_source_upload', '2023-10-31 15:20:23.000000'),
(37, 'app_gen', '0019_remove_notification_pic_source', '2023-10-31 15:21:03.000000'),
(38, 'app_gen', '0020_rename_pic_source_upload_notification_pic_source', '2023-10-31 15:22:49.000000'),
(39, 'app_gen', '0021_remove_notification_notice_test', '2023-10-31 15:23:26.000000');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('4a41jit9k4ijgr62zmitf8fz07lvgduf', '.eJwVjr0KwzAMhF-laE7jBjp5aqHQpVsfoIhEMSq2bPxTCCHvXnk66dPdoR18dCy0gK250QCNdZxUC2XBQGDhLgu-RhiAArJXgApuri_jHIMeEs-KTalYeTaY0seRGA7uqTKZlOPKnsYkTs05-t76oMJOKCvpuVbAruiLvqDZd6WknkvvzjGkCnbXzUJYvlm28-96KnXTnuP4A11MQCY:1qsj2B:QqA49g_MX5jGu1E4DAMO6rmaewiFesiJCHjjNqqN7Cg', '2023-10-31 19:18:51.000000'),
('dbgamxlxem98u4p630t1miasgz6sq020', '.eJxVT8lqwzAQ_RWhc-pFdrydSkMJFAKFnHoysj22lcqSGckNIeTfOyq59DQzb2PenQOiRd7wL7she1-k0swi-5TOXS0O7Codu6I1U8R3XNtJGRh443GDHd8UrYKmAzRyAUr5sLNhB7utGkgPIY7QC6FuUX5-_UOi3i7ErqonLnZeetXHcl3bCUyslulIQ8Qr2lFpiFYzkRitDvlnL9EDEhBsm-PNKLWjX8h69rCSJAnRaJfV8-ZOV8OX4YLm9vKTM-dvFPPYhdan85G4gwaJTGrNjPVqVD09Y40LbVu5-bkN5dpQlKf_sU7232ACMVykmSy1Mh5VFwVJ9GRddLID6Len9l_ALN1M7kqURZKWWZlllai7Ia2KAVIBfVJXYp9IyPou7fpc1GNel1UlOyHIMxRllXfFXvDHL97hlVY:1qyXK5:Vhrq_IPzDPdGaBtOf3DFN2YPo_JQ2YLtFcTkLjHAG80', '2023-11-16 20:01:21.000000'),
('oqfc23zh4wrtm8garbckymmi4ogdjtjp', '.eJxVjEEOwiAQRe_C2hAYKAwu3XsGMgMoVUOT0q6Md7dNutDtf-_9t4i0LjWuvcxxzOIstDj9bkzpWdoO8oPafZJpass8stwVedAur1Mur8vh_h1U6nWrEbxT2htvDELgrNHloqEkFRAGRcUk1pwshJsNHpEYYGuy82jZDSA-X63cNpE:1qnBPC:0RTjCVjQuvP0-lOLvu9ebSLvGCykKZ-s6GEugAFh7b8', '2023-10-16 12:23:42.000000'),
('ppnpssxwvs2izlv2czrh0itu24ayu7gw', '.eJxVjEEOwiAQRe_C2hAYKAwu3XsGMgMoVUOT0q6Md7dNutDtf-_9t4i0LjWuvcxxzOIstDj9bkzpWdoO8oPafZJpass8stwVedAur1Mur8vh_h1U6nWrEbxT2htvDELgrNHloqEkFRAGRcUk1pwshJsNHpEYYGuy82jZDSA-X63cNpE:1qsjRi:3-qH4uzaD5ju0Hc8TMm2Z7Xdfx65WRtkr6STVpgcieU', '2023-10-31 19:45:14.000000'),
('qjbdmy8opc2cckxc62hu4r23lws20z8q', '.eJw1jr0OwjAMhN_Fc9VQxkxQIVjY-gAoSk1kKXGs_ExV3x1nYDr7893JB8QciHEH20rHCTrpuKhWLOwSgoU77-49wwSYHEUFTsEtjGX2OelByCs2tblG3jiRT0A2lMJLZTFS8pcizsJBzSXH0frASoGxKBm5Xv8faHRrKGq5jOqSkzSwh24WnquiBSz3GCe4KtlWOM8fPSI-8g:1qwlM6:I3KDq7gK5QE8OFAgop0X_eWi6stUry6Dl9yxzWKHsGg', '2023-11-11 22:36:06.000000');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_gen_class`
--
ALTER TABLE `app_gen_class`
  ADD PRIMARY KEY (`class_id`);

--
-- Indexes for table `app_gen_collection`
--
ALTER TABLE `app_gen_collection`
  ADD PRIMARY KEY (`col_id`),
  ADD KEY `app_gen_collection_col_user_id_5429e83f_fk_app_gen_user_id` (`col_user_id`);

--
-- Indexes for table `app_gen_commentimggen`
--
ALTER TABLE `app_gen_commentimggen`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_gen_commentimggen_commentator_id_be0145be_fk_app_gen_user_id` (`commentator_id`),
  ADD KEY `app_gen_commentimggen_gen_id_56b88b96` (`gen_id`);

--
-- Indexes for table `app_gen_creditcard`
--
ALTER TABLE `app_gen_creditcard`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_gen_creditcard_acc_id_5ed0582a_fk_app_gen_user_id` (`acc_id`);

--
-- Indexes for table `app_gen_detailcollection`
--
ALTER TABLE `app_gen_detailcollection`
  ADD PRIMARY KEY (`col_detail_id`),
  ADD KEY `app_gen_detailcollec_col_id_id_468f72b6_fk_app_gen_c` (`col_id_id`),
  ADD KEY `app_gen_detailcollec_gen_id_id_2850fc72_fk_app_gen_i` (`gen_id_id`);

--
-- Indexes for table `app_gen_detailimggen`
--
ALTER TABLE `app_gen_detailimggen`
  ADD PRIMARY KEY (`genDetail_id`),
  ADD UNIQUE KEY `gen_id` (`gen_id`);

--
-- Indexes for table `app_gen_follow`
--
ALTER TABLE `app_gen_follow`
  ADD PRIMARY KEY (`follow_id`);

--
-- Indexes for table `app_gen_illegal`
--
ALTER TABLE `app_gen_illegal`
  ADD PRIMARY KEY (`cop_id`),
  ADD KEY `app_gen_illegal_gen_id_id_cc95962f_fk_app_gen_imggen_gen_id` (`gen_id_id`);

--
-- Indexes for table `app_gen_imggen`
--
ALTER TABLE `app_gen_imggen`
  ADD PRIMARY KEY (`gen_id`),
  ADD KEY `app_gen_imggen_acc_id_id_dc569e57_fk_app_gen_user_id` (`acc_id_id`);

--
-- Indexes for table `app_gen_notification`
--
ALTER TABLE `app_gen_notification`
  ADD PRIMARY KEY (`noti_id`),
  ADD KEY `app_gen_notification_acc_id_id_51e745b3_fk_app_gen_user_id` (`acc_id_id`);

--
-- Indexes for table `app_gen_star`
--
ALTER TABLE `app_gen_star`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_gen_star_user_id_bc14acb5_fk_app_gen_user_id` (`user_id`),
  ADD KEY `app_gen_star_DetailImgGen_id_45c4afc1_fk_app_gen_d` (`DetailImgGen_id`);

--
-- Indexes for table `app_gen_transaction`
--
ALTER TABLE `app_gen_transaction`
  ADD PRIMARY KEY (`upgrade_id`),
  ADD KEY `app_gen_transaction_acc_id_id_7d3df34e_fk_app_gen_user_id` (`acc_id_id`);

--
-- Indexes for table `app_gen_user`
--
ALTER TABLE `app_gen_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `userEmail` (`userEmail`),
  ADD KEY `app_gen_user_classUser_id_b27a7763_fk_app_gen_class_class_id` (`classUser_id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_gen_class`
--
ALTER TABLE `app_gen_class`
  MODIFY `class_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `app_gen_collection`
--
ALTER TABLE `app_gen_collection`
  MODIFY `col_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `app_gen_commentimggen`
--
ALTER TABLE `app_gen_commentimggen`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `app_gen_creditcard`
--
ALTER TABLE `app_gen_creditcard`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `app_gen_detailcollection`
--
ALTER TABLE `app_gen_detailcollection`
  MODIFY `col_detail_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `app_gen_detailimggen`
--
ALTER TABLE `app_gen_detailimggen`
  MODIFY `genDetail_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `app_gen_follow`
--
ALTER TABLE `app_gen_follow`
  MODIFY `follow_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_gen_illegal`
--
ALTER TABLE `app_gen_illegal`
  MODIFY `cop_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `app_gen_imggen`
--
ALTER TABLE `app_gen_imggen`
  MODIFY `gen_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `app_gen_notification`
--
ALTER TABLE `app_gen_notification`
  MODIFY `noti_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `app_gen_star`
--
ALTER TABLE `app_gen_star`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `app_gen_transaction`
--
ALTER TABLE `app_gen_transaction`
  MODIFY `upgrade_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `app_gen_user`
--
ALTER TABLE `app_gen_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=232;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_gen_collection`
--
ALTER TABLE `app_gen_collection`
  ADD CONSTRAINT `app_gen_collection_col_user_id_5429e83f_fk_app_gen_user_id` FOREIGN KEY (`col_user_id`) REFERENCES `app_gen_user` (`id`);

--
-- Constraints for table `app_gen_commentimggen`
--
ALTER TABLE `app_gen_commentimggen`
  ADD CONSTRAINT `app_gen_commentimggen_commentator_id_be0145be_fk_app_gen_user_id` FOREIGN KEY (`commentator_id`) REFERENCES `app_gen_user` (`id`),
  ADD CONSTRAINT `app_gen_commentimggen_gen_id_56b88b96_fk_app_gen_imggen_gen_id` FOREIGN KEY (`gen_id`) REFERENCES `app_gen_imggen` (`gen_id`);

--
-- Constraints for table `app_gen_creditcard`
--
ALTER TABLE `app_gen_creditcard`
  ADD CONSTRAINT `app_gen_creditcard_acc_id_5ed0582a_fk_app_gen_user_id` FOREIGN KEY (`acc_id`) REFERENCES `app_gen_user` (`id`);

--
-- Constraints for table `app_gen_detailcollection`
--
ALTER TABLE `app_gen_detailcollection`
  ADD CONSTRAINT `app_gen_detailcollec_col_id_id_468f72b6_fk_app_gen_c` FOREIGN KEY (`col_id_id`) REFERENCES `app_gen_collection` (`col_id`),
  ADD CONSTRAINT `app_gen_detailcollec_gen_id_id_2850fc72_fk_app_gen_i` FOREIGN KEY (`gen_id_id`) REFERENCES `app_gen_imggen` (`gen_id`);

--
-- Constraints for table `app_gen_detailimggen`
--
ALTER TABLE `app_gen_detailimggen`
  ADD CONSTRAINT `app_gen_detailimggen_gen_id_6b483485_fk_app_gen_imggen_gen_id` FOREIGN KEY (`gen_id`) REFERENCES `app_gen_imggen` (`gen_id`);

--
-- Constraints for table `app_gen_illegal`
--
ALTER TABLE `app_gen_illegal`
  ADD CONSTRAINT `app_gen_illegal_gen_id_id_cc95962f_fk_app_gen_imggen_gen_id` FOREIGN KEY (`gen_id_id`) REFERENCES `app_gen_imggen` (`gen_id`);

--
-- Constraints for table `app_gen_imggen`
--
ALTER TABLE `app_gen_imggen`
  ADD CONSTRAINT `app_gen_imggen_acc_id_id_dc569e57_fk_app_gen_user_id` FOREIGN KEY (`acc_id_id`) REFERENCES `app_gen_user` (`id`);

--
-- Constraints for table `app_gen_notification`
--
ALTER TABLE `app_gen_notification`
  ADD CONSTRAINT `app_gen_notification_acc_id_id_51e745b3_fk_app_gen_user_id` FOREIGN KEY (`acc_id_id`) REFERENCES `app_gen_user` (`id`);

--
-- Constraints for table `app_gen_star`
--
ALTER TABLE `app_gen_star`
  ADD CONSTRAINT `app_gen_star_DetailImgGen_id_45c4afc1_fk_app_gen_d` FOREIGN KEY (`DetailImgGen_id`) REFERENCES `app_gen_detailimggen` (`genDetail_id`),
  ADD CONSTRAINT `app_gen_star_user_id_bc14acb5_fk_app_gen_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_gen_user` (`id`);

--
-- Constraints for table `app_gen_transaction`
--
ALTER TABLE `app_gen_transaction`
  ADD CONSTRAINT `app_gen_transaction_acc_id_id_7d3df34e_fk_app_gen_user_id` FOREIGN KEY (`acc_id_id`) REFERENCES `app_gen_user` (`id`);

--
-- Constraints for table `app_gen_user`
--
ALTER TABLE `app_gen_user`
  ADD CONSTRAINT `app_gen_user_classUser_id_b27a7763_fk_app_gen_class_class_id` FOREIGN KEY (`classUser_id`) REFERENCES `app_gen_class` (`class_id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
