-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 09, 2026 at 09:05 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `recruit_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `candidates`
--

CREATE TABLE `candidates` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `gender` enum('Male','Female','Other') DEFAULT NULL,
  `date_of_birth` varchar(20) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `education` varchar(150) DEFAULT NULL,
  `experience_years` varchar(20) DEFAULT NULL,
  `current_position` varchar(150) DEFAULT NULL,
  `expected_salary` varchar(50) DEFAULT NULL,
  `status_id` int(11) DEFAULT NULL,
  `college` varchar(100) NOT NULL,
  `university` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidates`
--

INSERT INTO `candidates` (`id`, `user_id`, `phone`, `gender`, `date_of_birth`, `address`, `city`, `state`, `education`, `experience_years`, `current_position`, `expected_salary`, `status_id`, `college`, `university`) VALUES
(1, 18, '5827338342', 'Female', '1987-11-29', '7528 Christina Extension', 'New Daveport', 'Rhode Island', 'MBA', '2', 'Backend Developer', '90047', 1, '', ''),
(2, 19, '3638932819', 'Female', '1981-10-10', '7895 Johnson Hills', 'Christinafort', 'South Carolina', 'MBA', '13', 'Project Manager', '98423', 1, '', ''),
(3, 20, '5407773798', 'Other', '1988-04-19', '78620 Michele Oval Apt. 680', 'Lake Jean', 'Alabama', 'MBA', '7', 'Backend Developer', '82197', 1, '', ''),
(4, 21, '4441292541', 'Male', '1980-06-22', '157 William Circles', 'Weisshaven', 'Minnesota', 'MBA', '10', 'Frontend Developer', '121465', 1, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `candidate_skills`
--

CREATE TABLE `candidate_skills` (
  `id` int(11) NOT NULL,
  `skill_id` int(11) NOT NULL,
  `candidate_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidate_skills`
--

INSERT INTO `candidate_skills` (`id`, `skill_id`, `candidate_id`) VALUES
(1, 5, 1),
(2, 6, 1),
(3, 7, 1),
(4, 8, 1),
(5, 9, 1),
(6, 10, 2),
(7, 11, 2),
(8, 12, 3),
(9, 7, 3),
(10, 13, 3),
(11, 9, 3),
(12, 14, 3),
(13, 11, 4),
(14, 7, 4);

-- --------------------------------------------------------

--
-- Table structure for table `candidate_status`
--

CREATE TABLE `candidate_status` (
  `id` int(11) NOT NULL,
  `status` enum('HOLD','ACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `candidate_status`
--

INSERT INTO `candidate_status` (`id`, `status`, `created_at`) VALUES
(1, 'ACTIVE', '2026-01-07 16:47:17'),
(2, 'HOLD', '2026-01-07 16:47:17');

-- --------------------------------------------------------

--
-- Table structure for table `degrees`
--

CREATE TABLE `degrees` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `degrees`
--

INSERT INTO `degrees` (`id`, `name`, `created_at`) VALUES
(1, 'MCA', '2026-01-07 20:15:41'),
(2, 'BCA', '2026-01-07 20:15:41'),
(3, 'BTECH', '2026-01-07 20:15:41'),
(4, 'BCOM', '2026-01-07 20:15:41'),
(5, 'BBA', '2026-01-07 20:15:41');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `status` enum('HOLD','OPEN','CLOSED') NOT NULL DEFAULT 'OPEN',
  `description` text DEFAULT NULL,
  `salary_range_start` varchar(50) DEFAULT NULL,
  `salary_range_end` varchar(50) DEFAULT NULL,
  `stipend` varchar(50) DEFAULT NULL,
  `job_type` varchar(50) DEFAULT NULL,
  `assigned_reviewer` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `name`, `status`, `description`, `salary_range_start`, `salary_range_end`, `stipend`, `job_type`, `assigned_reviewer`, `created_at`) VALUES
(1, 'Frontend Developer', 'HOLD', 'Test Description', '', '', '15000', 'INTERNSHIP', 15, '2026-01-07 17:28:34');

-- --------------------------------------------------------

--
-- Table structure for table `job_comments`
--

CREATE TABLE `job_comments` (
  `id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `job_id` int(11) NOT NULL,
  `status` enum('OPEN','HOLD','CLOSED') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_comments`
--

INSERT INTO `job_comments` (`id`, `comment`, `job_id`, `status`) VALUES
(1, 'Test comment', 1, 'HOLD');

-- --------------------------------------------------------

--
-- Table structure for table `job_eligible_degrees`
--

CREATE TABLE `job_eligible_degrees` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `degree_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_skills`
--

CREATE TABLE `job_skills` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `type` enum('REQUIRED','PREFERRED') NOT NULL,
  `skill_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_skills`
--

INSERT INTO `job_skills` (`id`, `job_id`, `type`, `skill_id`) VALUES
(4, 1, 'REQUIRED', 1),
(5, 1, 'PREFERRED', 2);

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `role_name`, `created_at`) VALUES
(1, 'admin', '2025-10-16 18:38:56'),
(2, 'recruiter', '2025-10-16 18:38:56'),
(3, 'hr', '2025-10-16 18:38:56'),
(4, 'interviewer', '2025-10-16 18:38:56'),
(5, 'reviewer', '2025-10-16 18:38:56'),
(6, 'candidate', '2025-10-16 18:38:56'),
(7, 'viewer', '2025-10-16 18:38:56');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `name`, `created_at`) VALUES
(1, 'Python', '2025-10-16 18:38:19'),
(2, 'Java', '2025-10-16 18:38:19'),
(3, 'DSA', '2025-10-16 18:38:19'),
(5, 'Node.js', '2026-01-07 16:47:38'),
(6, 'Flutter', '2026-01-07 16:47:38'),
(7, 'Next.js', '2026-01-07 16:47:38'),
(8, 'Kotlin', '2026-01-07 16:47:38'),
(9, 'MongoDB', '2026-01-07 16:47:38'),
(10, 'React', '2026-01-07 16:47:39'),
(11, 'AWS', '2026-01-07 16:47:39'),
(12, 'MySQL', '2026-01-07 16:47:39'),
(13, 'C#', '2026-01-07 16:47:39'),
(14, 'PHP', '2026-01-07 16:47:39');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `role_id`, `created_at`) VALUES
(1, 'Aayush Pathak', 'ayush@gmail.com', '$2a$11$h7/.7d7liiKlEcihpHoUmudVTpLMq3dH9ZZiePkGcuBZMA9uuwKw2', 1, '2025-10-14 14:15:55'),
(11, 'Viewer updated', 'viewer@gmail.com', '$2a$11$2VwHrnZP8tcohCdQdADB2u6E.h5RzW.R4ZJKRzfE9AnQyub0WYCc2', 7, '2025-10-16 11:46:09'),
(12, 'Recruiter', 'recruiter@gmail.com', '$2a$11$5m.bqZhMqP6GuGoAL54IK.Ida9vyuPGPyMBehMm1gQ5TH2t2.kfye', 2, '2025-10-16 12:10:04'),
(13, 'HR', 'hr@gmail.com', '$2a$11$N9FRldza4eeW3XZsOAu2cu9/nvd2SGwjeLtRmbXnAAjRZmdSOAx9e', 3, '2025-10-16 12:10:50'),
(14, 'Interviewer', 'interviewer@gmail.com', '$2a$11$XHTjzkoOIYfovjLd6um7W..x7GzeJ34IYeZRBbK4mPzPqpPVaAcAW', 4, '2025-10-16 12:13:03'),
(15, 'Reviewer', 'reviewer@gmail.com', '$2a$11$n76ju8za9bw94MkYgAA43usuXjCd8ZYQM6bK/MuQ6HXST5QgRh7UC', 5, '2025-10-16 12:13:30'),
(16, 'Candidate', 'candidate@gmail.com', '$2a$11$azWxNfolz3kapysGftsEqekwmIIJYnBHdH68lpPqSP89univbM5t.', 6, '2025-10-16 12:13:47'),
(17, 'Test', 'test@gmail.com', '$2a$11$rUWRPacJANXvndOmgRoI2eY/AHWdR9E2t/ntlWfHqbdE9vWmcUnzO', 7, '2025-10-16 12:14:16'),
(18, 'Michael Wang', 'michael.wang1@example.com', '$2a$11$SzA1DofUqp/xOOCMcNYO8ex8s8Bc4Y18qB5HpXPxVtqPvyvvgwrIO', 6, '2026-01-07 16:47:38'),
(19, 'Scott Terry', 'scott.terry3@example.com', '$2a$11$cx6CFtlu7e8L.AI6SA9U5O8a6uF0amRt.DxCIpB.8Pm4KVxHzYso.', 6, '2026-01-07 16:47:39'),
(20, 'Sarah Martin', 'sarah.martin4@example.com', '$2a$11$PMtKvZ5vPh7J0JQ3Bss5g.6LC2Ma3jurQpT3HZArblc4QmDFf1gHy', 6, '2026-01-07 16:47:39'),
(21, 'Christopher Wagner', 'christopher.wagner5@example.com', '$2a$11$xP0JUlhWvHOsuDWDtq3bVuOlBDf4fBQSxSczdxlq0COjnKJacwDZW', 6, '2026-01-07 16:47:39');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `candidates`
--
ALTER TABLE `candidates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `candidate_skills`
--
ALTER TABLE `candidate_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `skill_id` (`skill_id`),
  ADD KEY `candidate_id` (`candidate_id`);

--
-- Indexes for table `candidate_status`
--
ALTER TABLE `candidate_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `degrees`
--
ALTER TABLE `degrees`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_ibfk_1` (`assigned_reviewer`);

--
-- Indexes for table `job_comments`
--
ALTER TABLE `job_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_eligible_degrees`
--
ALTER TABLE `job_eligible_degrees`
  ADD PRIMARY KEY (`id`),
  ADD KEY `degree_id` (`degree_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `job_skills`
--
ALTER TABLE `job_skills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `skill_id` (`skill_id`),
  ADD KEY `job_id` (`job_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `role_id` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `candidates`
--
ALTER TABLE `candidates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `candidate_skills`
--
ALTER TABLE `candidate_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `candidate_status`
--
ALTER TABLE `candidate_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `degrees`
--
ALTER TABLE `degrees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job_comments`
--
ALTER TABLE `job_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `job_eligible_degrees`
--
ALTER TABLE `job_eligible_degrees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_skills`
--
ALTER TABLE `job_skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `candidates`
--
ALTER TABLE `candidates`
  ADD CONSTRAINT `candidates_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `jobs`
--
ALTER TABLE `jobs`
  ADD CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`assigned_reviewer`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Constraints for table `job_eligible_degrees`
--
ALTER TABLE `job_eligible_degrees`
  ADD CONSTRAINT `job_eligible_degrees_ibfk_1` FOREIGN KEY (`degree_id`) REFERENCES `degrees` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `job_eligible_degrees_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `job_skills`
--
ALTER TABLE `job_skills`
  ADD CONSTRAINT `job_skills_ibfk_1` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`),
  ADD CONSTRAINT `job_skills_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
