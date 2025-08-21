-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2025 at 07:22 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `computer_asset_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `assets`
--

CREATE TABLE `assets` (
  `asset_id` int(11) NOT NULL,
  `asset_code` varchar(50) NOT NULL,
  `model_id` int(11) NOT NULL,
  `comname` varchar(20) DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `adminowner_id` int(11) NOT NULL,
  `status_id` int(11) NOT NULL,
  `purchase_date` date DEFAULT NULL,
  `warranty_end` date DEFAULT NULL,
  `po_number` int(11) DEFAULT NULL,
  `os` varchar(30) DEFAULT NULL,
  `paper` varchar(100) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `assets`
--

INSERT INTO `assets` (`asset_id`, `asset_code`, `model_id`, `comname`, `department_id`, `user_id`, `adminowner_id`, `status_id`, `purchase_date`, `warranty_end`, `po_number`, `os`, `paper`, `notes`, `created_at`, `updated_at`) VALUES
(1, '105000002236', 1, 'BCH_ACC_WS01', 72, 4, 2, 1, '2020-07-01', '2025-07-01', 430000234, 'Ms.Windows 11 64bit', NULL, NULL, '2025-07-21 11:27:18', '2025-07-22 13:49:10'),
(2, '105000002237', 2, 'BCH_ACC_LT01', 72, 4, 2, 1, '2020-07-01', '2025-07-01', 430000234, 'Ms.Windows 11 64bit', NULL, NULL, '2025-07-21 11:27:18', '2025-07-22 13:49:06'),
(3, '105000002238', 2, 'BCH_QM_LT01', 44, 3, 2, 1, '2020-07-01', '2025-07-01', 430000234, 'Ms.Windows 11 64bit', NULL, NULL, '2025-07-21 11:27:18', '2025-07-22 13:44:55'),
(4, '105000002239', 2, 'BCH_QM_LT02', 44, 3, 2, 3, '2020-07-01', '2025-07-01', 430000234, 'Ms.Windows 11 64bit', NULL, NULL, '2025-07-21 11:27:18', '2025-07-22 13:44:59'),
(5, '105000002240', 2, 'BCH_ACC_LT02', 72, 4, 2, 5, '2020-07-01', '2025-07-01', 430000234, 'Ms.Windows 10 64bit', NULL, NULL, '2025-07-21 11:27:18', '2025-07-22 13:49:02'),
(6, '105000002241', 3, 'BCH_ACC_WS01', 72, 4, 2, 1, '2024-07-01', '2029-07-01', 430000234, '-', NULL, NULL, '2025-07-21 11:27:18', '2025-07-22 13:49:57');

-- --------------------------------------------------------

--
-- Table structure for table `asset_status`
--

CREATE TABLE `asset_status` (
  `status_id` int(11) NOT NULL,
  `status_code` varchar(20) NOT NULL,
  `status_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `color_code` varchar(7) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_status`
--

INSERT INTO `asset_status` (`status_id`, `status_code`, `status_name`, `description`, `color_code`, `created_at`, `updated_at`) VALUES
(1, 'normal', 'ใช้งานปกติ', 'อุปกรณ์ที่ใช้งานได้ปกติ', '#4CAF50', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(2, 'maintenance', 'ซ่อมบำรุง', 'อุปกรณ์ที่อยู่ระหว่างการซ่อมบำรุง', '#FFC107', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(3, 'broken', 'ชำรุด', 'อุปกรณ์ที่ชำรุดไม่สามารถใช้งานได้', '#F44336', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(4, 'spare', 'สำรอง', 'อุปกรณ์ที่สำรองไว้ใช้งาน', '#2196F3', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(5, 'disposed', 'จำหน่ายแล้ว', 'อุปกรณ์ที่จำหน่ายออกจากระบบแล้ว', '#9E9E9E', '2025-07-21 08:11:31', '2025-07-21 08:11:31');

-- --------------------------------------------------------

--
-- Table structure for table `asset_types`
--

CREATE TABLE `asset_types` (
  `type_id` int(11) NOT NULL,
  `type_code` varchar(10) NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `asset_types`
--

INSERT INTO `asset_types` (`type_id`, `type_code`, `type_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'DT', 'Desktop', 'เครื่องคอมพิวเตอร์ตั้งโต๊ะ', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(2, 'LT', 'Laptop', 'เครื่องคอมพิวเตอร์พกพา', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(3, 'MN', 'Monitor', 'จอภาพ', '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(4, 'TB', 'Tablet', 'แท็บเล็ต', '2025-07-21 08:11:31', '2025-07-21 08:11:31');

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL,
  `cost_center` varchar(20) NOT NULL,
  `department_name_en` varchar(100) NOT NULL,
  `department_name_th` varchar(100) NOT NULL,
  `manager_name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`department_id`, `cost_center`, `department_name_en`, `department_name_th`, `manager_name`, `created_at`, `updated_at`) VALUES
(1, '9002', 'Hospital Director Office', 'สำนักผู้บริหาร', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(2, '1147', 'Hospitality', 'Hospitality', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(3, '1212', 'Screening & Registration', 'แผนกคัดกรองและลงทะเบียน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(4, '1015', 'Patient Escort', 'แผนกเคลื่อนย้ายผู้ป่วย', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(5, '1043', 'Customer Services', 'แผนก customer service', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(6, '6118', 'General Support Department', 'แผนกบริการห้องพักและธุรการ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(7, '6011', 'Transportation', 'แผนกรถธุรการ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(8, '6002', 'Dietary Service & Banquet', 'แผนกโภชนาการ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(9, '8016', 'PCG 1 OPD', 'PCG 1 OPD', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(10, '3054', 'GI & Liver', 'แผนกศูนย์ทางเดินอาหารและตับ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(11, '1013', 'International Medical Services', 'แผนกบริการผู้ป่วยต่างประเทศ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(12, '1238', 'Medical Coordinator Center / OlD SUP', 'Medical Coordinator Center / SUP เดิม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(13, '3005', 'Beauty', 'แผนกศูนย์ส่งเสริมความงาม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(14, '3015', 'Medicine Unit', 'แผนกอายุรกรรม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(15, '3018', 'Obstetrics & Gynecology', 'แผนกสูตินรีเวช', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(16, '3019', 'Pediatrics', 'แผนกกุมารเวช', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(17, '3131', 'Eye Ear Nose Throat', 'แผนกตา หู คอ จมูก', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(18, '8017', 'PCG 2 COE Surgery & Orthopedic', 'PCG 2 COE ศัลยกรรมและกระดูก', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(19, '3020', 'Surgery Unit', 'แผนกศัลยกรรม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(20, '3023', 'Orthopedic', 'แผนกศัลยกรรมกระดูกและข้อ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(21, '8018', 'PCG 3 Critical care', 'PCG 3  Critical care', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(22, '5001', 'Intensive Care Unit (A)', 'แผนกหอผู้ป่วยวิกฤต', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(23, '5004', 'Operating Room', 'แผนกห้องผ่าตัด', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(24, '4010', 'Ward A3', 'แผนกหอผู้ป่วย A3', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(25, '2001', 'Emergency', 'แผนกอุบัติเหตุฉุกเฉิน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(26, '5005', 'Labour Room', 'แผนกห้องคลอด', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(27, '5006', 'Nursery', 'ทารกแรกเกิด', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(28, '8019', 'PCG 4 COE Heart', 'PCG 4 COE Heart', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(29, '3883', 'Interventional Radiology / 04IRY', 'แผนกรังสีร่วมรักษา', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(30, '3006', 'Heart Clinic', 'แผนกหัวใจ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(31, '8020', 'PCG 5 COE Cancer', 'PCG 5 COE Cancer', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(32, '3027', 'Health Promotion', 'แผนกส่งเสริมสุขภาพ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(33, '3012', 'Dental', 'แผนกทันตกรรม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(34, '3066', 'Cancer Center', 'แผนกมะเร็ง', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(35, '8021', 'PCG 6 IPD', 'PCG 6 IPD', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(36, '4024', 'Ward B8', 'แผนกหอผู้ป่วย B8', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(37, '4027', 'Ward A4', 'แผนกหอผู้ป่วย A4', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(38, '4040', 'Ward B6', 'แผนกหอผู้ป่วย B6', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(39, '4015', 'Ward B7', 'แผนกหอผู้ป่วย B7', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(40, '4030', 'Ward A5', 'แผนกหอผู้ป่วย A5', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(41, '4081', 'Ward A7', 'แผนกหอผู้ป่วย A7', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(42, '4036', 'Ward B5', 'แผนกหอผู้ป่วย B5', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(43, '4069', 'Ward A6', 'แผนกหอผู้ป่วย A6', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(44, '7084', 'Strategy & Quality Management', 'ฝ่ายบริหารคุณภาพ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(45, '1021', 'Medical Record', 'แผนกบริหารสารสนเทศและเวชระเบียน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(46, '7032', 'Quality Management', 'แผนกบริหารคุณภาพ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(47, '7033', 'Infection Control', 'แผนกควบคุมการติดเชื้อ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(48, '7112', 'Medical Affair Office', 'แผนกสำนักงานด้านการแพทย์', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(49, '7703', 'Risk Management', 'แผนกบริหารความเสี่ยง', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(50, '7729', 'Strategy Management', 'แผนกบริหารยุทธศาสตร์', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(51, '9004', 'Nursing Staff Organization', 'ฝ่ายการพยาบาล', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(52, '7981', 'Nursing Development', 'แผนกวิชาการพยาบาล', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(53, '3028', 'Medical Support', 'ฝ่ายสนับสนุนทางการแพทย์', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(54, '3013', 'Rehabilitation', 'แผนกกายภาพบำบัด', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(55, '3031', 'Imaging', 'แผนกรังสีวิทยา', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(56, '3034', 'Pharmacy', 'แผนกเภสัชกรรม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(57, '7024', 'Human Resources Division', 'ฝ่ายบริหารทรัพยากรบุคคล', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(58, '7025', 'Human Resources Management', 'แผนกบริหารทรัพยากรบุคคล', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(59, '7027', 'Human Resources Development', 'แผนกพัฒนาทรัพยากรบุคคล', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(60, '7822', 'Healthy Workplace Management', 'แผนกบริหารสุขภาวะบุคลากร', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(61, '7002', 'Business Development', 'ฝ่ายพัฒนาธุรกิจ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(62, '1007', 'Contact Center', 'แผนกบริการโทรศัพท์', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(63, '7029', 'Marketing', 'แผนกการตลาด', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(64, '7030', 'Marketing Communication', 'แผนกสื่อสารการตลาด', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(65, '7043', 'International Marketing', 'แผนกการตลาดต่างประเทศ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(66, '8252', 'Digital Business Development', 'แผนกพัฒนาธุรกิจดิจิตอล', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(67, '1239', 'Healthcare Benefits', 'ฝ่ายสิทธิประโยชน์', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(68, '1014', 'Admission', 'แผนกรับผู้ป่วยใน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(69, '1026', 'Utilization Management', 'แผนกบริหารสิทธิผู้รับบริการ', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(70, '7009', 'Cashier', 'แผนกการเงิน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(71, '7004', 'Accounting and Finance', 'ฝ่ายบัญชีและการเงิน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(72, '7005', 'Accounting', 'แผนกบัญชี', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(73, '7006', 'Collection', 'แผนกจัดเก็บหนี้', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(74, '7132', 'Cost Management', 'แผนกบริหารต้นทุน', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(75, '6030', 'Project Engineering Services', 'วิศวกรรมอาคาร', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(76, '6022', 'Repair & Maintenance', 'แผนกซ่อมบำรุง', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(77, '6064', 'Environment Management', 'แผนกบริหารสิ่งแวดล้อม', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(78, '6008', 'Property & Premises Services', 'แผนกวิศวกรรมอาคาร', NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31');

-- --------------------------------------------------------

--
-- Table structure for table `import_details`
--

CREATE TABLE `import_details` (
  `detail_id` int(11) NOT NULL,
  `import_id` int(11) NOT NULL,
  `row_number` int(11) NOT NULL,
  `record_id` int(11) DEFAULT NULL,
  `record_code` varchar(50) DEFAULT NULL,
  `status` enum('new','updated','deleted','error') NOT NULL,
  `error_message` text DEFAULT NULL,
  `raw_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_data`)),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `import_history`
--

CREATE TABLE `import_history` (
  `import_id` int(11) NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `import_type` enum('computers','models','transfers') NOT NULL,
  `total_records` int(11) NOT NULL,
  `successful_records` int(11) NOT NULL,
  `failed_records` int(11) NOT NULL,
  `new_records` int(11) NOT NULL,
  `updated_records` int(11) NOT NULL,
  `deleted_records` int(11) NOT NULL,
  `status` enum('success','partial','failed') NOT NULL,
  `imported_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `models`
--

CREATE TABLE `models` (
  `model_id` int(11) NOT NULL,
  `model_code` varchar(50) NOT NULL,
  `type_id` int(11) NOT NULL,
  `brand` varchar(100) NOT NULL,
  `model_name` varchar(100) NOT NULL,
  `cpu` varchar(100) DEFAULT NULL,
  `ram` varchar(50) DEFAULT NULL,
  `storage` varchar(100) DEFAULT NULL,
  `graphics` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `models`
--

INSERT INTO `models` (`model_id`, `model_code`, `type_id`, `brand`, `model_name`, `cpu`, `ram`, `storage`, `graphics`, `created_at`, `updated_at`) VALUES
(1, 'Dell Optiplex 5080', 1, 'Dell', 'Optiplex 5080', 'i5-10500T', '8GB DDR4', 'M.2 Nvme 512GB', 'Intel UHD Graphics 630\n', '2025-07-21 11:21:47', '2025-07-22 13:42:35'),
(2, 'Dell Latitude 3490', 2, 'Dell', 'Latitude 3490', 'i5-8400', '8GB DDR4', 'SSD SATA 512GB', 'Intel UHD Graphics 630\r\n', '2025-07-21 11:21:47', '2025-07-22 13:41:37'),
(3, 'Dell P2425H', 3, 'Dell', 'P2425H', NULL, NULL, NULL, NULL, '2025-07-21 11:21:47', '2025-07-22 13:41:37');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'ผู้ดูแลระบบ', '2025-07-21 08:11:31', '2025-07-21 08:15:54'),
(2, 'manager', 'ผู้จัดการ', '2025-07-21 08:11:31', '2025-07-21 08:15:58'),
(3, 'user', 'ผู้ใช้งานทั่วไป', '2025-07-21 08:11:31', '2025-07-21 08:16:02');

-- --------------------------------------------------------

--
-- Table structure for table `transfers`
--

CREATE TABLE `transfers` (
  `transfer_id` int(11) NOT NULL,
  `asset_id` int(11) NOT NULL,
  `source_department_id` int(11) NOT NULL,
  `destination_department_id` int(11) NOT NULL,
  `source_user_id` int(11) DEFAULT NULL,
  `destination_user_id` int(11) DEFAULT NULL,
  `transfer_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `department_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `last_login` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `position`, `department_id`, `role_id`, `is_active`, `last_login`, `created_at`, `updated_at`) VALUES
(1, 'bch.itsupport', 'Ict@123456', 'ผู้ดูแล', 'ระบบ', 'bch.itsupport@bdms.co.th', '0646282730', 'IT-Support', 1, 1, 1, NULL, '2025-07-21 08:11:31', '2025-07-21 08:11:31'),
(2, 'tadapong.su', 'Ict@123456', 'Tadapong', 'Sutthikitrungroj', 'tadapong.su@glsict.co.th', '0646282730', 'IT Operation & Support', 51, 1, 1, NULL, '2025-07-21 11:35:04', '2025-07-21 11:35:04'),
(3, 'JIRAPA.SE', 'Ict@123456', 'JIRAPA', 'SEENSUNGWORN', 'JIRAPA.SE@bch.co.th', '-', 'ผู้จัดการฝ่ายบริหารคุณภาพ', 44, 3, 1, NULL, '2025-07-21 11:35:04', '2025-07-21 11:35:04'),
(4, 'bchaccounting', 'Ict@123456', 'bch', 'accounting', 'bchaccounting@bch.co.th', NULL, NULL, 72, 3, 1, NULL, '2025-07-21 11:35:04', '2025-07-21 11:35:04');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assets`
--
ALTER TABLE `assets`
  ADD PRIMARY KEY (`asset_id`),
  ADD UNIQUE KEY `asset_code` (`asset_code`),
  ADD KEY `idx_assets_model_id` (`model_id`),
  ADD KEY `idx_assets_department_id` (`department_id`),
  ADD KEY `idx_assets_user_id` (`user_id`),
  ADD KEY `idx_assets_status_id` (`status_id`),
  ADD KEY `idx_assets_owner_admin_id` (`adminowner_id`) USING BTREE;

--
-- Indexes for table `asset_status`
--
ALTER TABLE `asset_status`
  ADD PRIMARY KEY (`status_id`),
  ADD UNIQUE KEY `status_code` (`status_code`);

--
-- Indexes for table `asset_types`
--
ALTER TABLE `asset_types`
  ADD PRIMARY KEY (`type_id`),
  ADD UNIQUE KEY `type_code` (`type_code`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`department_id`),
  ADD UNIQUE KEY `cost_center` (`cost_center`);

--
-- Indexes for table `import_details`
--
ALTER TABLE `import_details`
  ADD PRIMARY KEY (`detail_id`),
  ADD KEY `idx_import_details_import_id` (`import_id`),
  ADD KEY `idx_import_details_status` (`status`);

--
-- Indexes for table `import_history`
--
ALTER TABLE `import_history`
  ADD PRIMARY KEY (`import_id`),
  ADD KEY `idx_import_history_import_type` (`import_type`),
  ADD KEY `idx_import_history_status` (`status`),
  ADD KEY `idx_import_history_imported_by` (`imported_by`);

--
-- Indexes for table `models`
--
ALTER TABLE `models`
  ADD PRIMARY KEY (`model_id`),
  ADD UNIQUE KEY `model_code` (`model_code`),
  ADD KEY `idx_models_type_id` (`type_id`),
  ADD KEY `idx_models_brand` (`brand`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `transfers`
--
ALTER TABLE `transfers`
  ADD PRIMARY KEY (`transfer_id`),
  ADD KEY `source_user_id` (`source_user_id`),
  ADD KEY `destination_user_id` (`destination_user_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_transfers_asset_id` (`asset_id`),
  ADD KEY `idx_transfers_source_department_id` (`source_department_id`),
  ADD KEY `idx_transfers_destination_department_id` (`destination_department_id`),
  ADD KEY `idx_transfers_transfer_date` (`transfer_date`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_users_department_id` (`department_id`),
  ADD KEY `idx_users_role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assets`
--
ALTER TABLE `assets`
  MODIFY `asset_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `asset_status`
--
ALTER TABLE `asset_status`
  MODIFY `status_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `asset_types`
--
ALTER TABLE `asset_types`
  MODIFY `type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `import_details`
--
ALTER TABLE `import_details`
  MODIFY `detail_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `import_history`
--
ALTER TABLE `import_history`
  MODIFY `import_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `models`
--
ALTER TABLE `models`
  MODIFY `model_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transfers`
--
ALTER TABLE `transfers`
  MODIFY `transfer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assets`
--
ALTER TABLE `assets`
  ADD CONSTRAINT `assets_ibfk_1` FOREIGN KEY (`model_id`) REFERENCES `models` (`model_id`),
  ADD CONSTRAINT `assets_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `assets_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `assets_ibfk_4` FOREIGN KEY (`status_id`) REFERENCES `asset_status` (`status_id`),
  ADD CONSTRAINT `assets_ibfk_5` FOREIGN KEY (`adminowner_id`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `import_details`
--
ALTER TABLE `import_details`
  ADD CONSTRAINT `import_details_ibfk_1` FOREIGN KEY (`import_id`) REFERENCES `import_history` (`import_id`);

--
-- Constraints for table `import_history`
--
ALTER TABLE `import_history`
  ADD CONSTRAINT `import_history_ibfk_1` FOREIGN KEY (`imported_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `models`
--
ALTER TABLE `models`
  ADD CONSTRAINT `models_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `asset_types` (`type_id`);

--
-- Constraints for table `transfers`
--
ALTER TABLE `transfers`
  ADD CONSTRAINT `transfers_ibfk_1` FOREIGN KEY (`asset_id`) REFERENCES `assets` (`asset_id`),
  ADD CONSTRAINT `transfers_ibfk_2` FOREIGN KEY (`source_department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `transfers_ibfk_3` FOREIGN KEY (`destination_department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `transfers_ibfk_4` FOREIGN KEY (`source_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `transfers_ibfk_5` FOREIGN KEY (`destination_user_id`) REFERENCES `users` (`user_id`),
  ADD CONSTRAINT `transfers_ibfk_6` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
