# tạo table
-- Tạo cơ sở dữ liệu
CREATE DATABASE IF NOT EXISTS restaurant_system;
USE restaurant_system;

-- Tạo bảng food_type
CREATE TABLE `food_type` (
  `type_id` INT NOT NULL AUTO_INCREMENT,
  `type_name` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`type_id`)
);

-- Insert dữ liệu vào bảng food_type
INSERT INTO `food_type` (`type_name`) VALUES
('Appetizer'),
('Main Course'),
('Dessert'),
('Beverage');

-- Tạo bảng user
CREATE TABLE `user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `full_name` VARCHAR(255) DEFAULT NULL,
  `email` VARCHAR(255) DEFAULT NULL,
  `pass_word` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
);

-- Tạo bảng restaurant
CREATE TABLE `restaurant` (
  `res_id` INT NOT NULL AUTO_INCREMENT,
  `res_name` VARCHAR(255) DEFAULT NULL,
  `image` VARCHAR(255) DEFAULT NULL,
  `desc` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`res_id`)
);

-- Tạo bảng food
CREATE TABLE `food` (
  `food_id` INT NOT NULL AUTO_INCREMENT,
  `food_name` VARCHAR(255) DEFAULT NULL,
  `image` VARCHAR(255) DEFAULT NULL,
  `price` INT DEFAULT NULL,
  `desc` VARCHAR(255) DEFAULT NULL,
  `type_id` INT DEFAULT NULL,
  PRIMARY KEY (`food_id`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `fk_food_food_type` FOREIGN KEY (`type_id`) REFERENCES `food_type` (`type_id`)
);

-- Tạo bảng sub_food
CREATE TABLE `sub_food` (
  `sub_id` INT NOT NULL AUTO_INCREMENT,
  `sub_name` VARCHAR(255) DEFAULT NULL,
  `sub_price` INT DEFAULT NULL,
  `food_id` INT DEFAULT NULL,
  PRIMARY KEY (`sub_id`),
  KEY `food_id` (`food_id`),
  CONSTRAINT `fk_sub_food_food` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);

-- Tạo bảng like_res
CREATE TABLE `like_res` (
  `user_id` INT NOT NULL,
  `res_id` INT NOT NULL,
  `date_like` DATETIME DEFAULT NULL,
  PRIMARY KEY (`user_id`, `res_id`),
  CONSTRAINT `fk_like_res_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_like_res_restaurant` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);

-- Tạo bảng `rate_res`
CREATE TABLE `rate_res` (
  `user_id` INT NOT NULL,
  `res_id` INT NOT NULL,
  `amount` INT DEFAULT NULL,
  `date_rate` DATETIME DEFAULT NULL,
  PRIMARY KEY (`user_id`, `res_id`),
  CONSTRAINT `fk_rate_res_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_rate_res_restaurant` FOREIGN KEY (`res_id`) REFERENCES `restaurant` (`res_id`)
);

-- Tạo bảng `order`
CREATE TABLE `order` (
  `user_id` INT NOT NULL,
  `food_id` INT NOT NULL,
  `amount` INT DEFAULT NULL,
  `code` VARCHAR(255) DEFAULT NULL,
  `arr_sub_id` VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (`user_id`, `food_id`),
  CONSTRAINT `fk_order_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_order_food` FOREIGN KEY (`food_id`) REFERENCES `food` (`food_id`)
);

-- Insert dữ liệu vào bảng user
INSERT INTO `user` (`full_name`, `email`, `pass_word`) VALUES
('John Doe', 'john@example.com', 'password123'),
('Alice Smith', 'alice@example.com', 'password456'),
('Bob Johnson', 'bob@example.com', 'password789'),
('Emma Brown', 'emma@example.com', 'password321'),
('Michael Wilson', 'michael@example.com', 'password654'),
('Sophia Lee', 'sophia@example.com', 'password987');


-- Insert dữ liệu vào bảng restaurant
INSERT INTO `restaurant` (`res_name`, `image`, `desc`) VALUES
('Restaurant A', 'restaurant_a.jpg', 'Description of Restaurant A'),
('Restaurant B', 'restaurant_b.jpg', 'Description of Restaurant B'),
('Restaurant C', 'restaurant_c.jpg', 'Description of Restaurant C');



-- Insert dữ liệu vào bảng like_res
INSERT INTO `like_res` (`user_id`, `res_id`, `date_like`) VALUES
(1, 1, '2024-04-01 10:00:00'),
(2, 1, '2024-04-02 11:00:00'),
(3, 2, '2024-04-03 12:00:00'),
(4, 2, '2024-04-04 13:00:00'),
(5, 2, '2024-04-05 14:00:00'),
(1, 3, '2024-04-06 15:00:00'),
(2, 3, '2024-04-07 16:00:00'),
(3, 3, '2024-04-08 17:00:00'),
(4, 3, '2024-04-09 18:00:00'),
(5, 3, '2024-04-10 19:00:00');


-- Insert dữ liệu vào bảng `order`
INSERT INTO `order` (`user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(1, 1, 2, 'ORDER123', NULL),
(1, 2, 1, 'ORDER456', NULL),
(2, 2, 3, 'ORDER789', NULL),
(3, 3, 1, 'ORDER321', NULL),
(4, 1, 2, 'ORDER654', NULL),
(4, 2, 1, 'ORDER987', NULL),
(5, 3, 2, 'ORDER654', NULL),
(6, 1, 1, 'ORDER321', NULL),
(6, 2, 2, 'ORDER987', NULL),
(6, 3, 1, 'ORDER654', NULL);


-- Insert dữ liệu vào bảng `rate_res`
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`) VALUES
(1, 1, 4, '2024-04-01 10:00:00'),
(2, 1, 5, '2024-04-02 11:00:00'),
(3, 2, 3, '2024-04-03 12:00:00'),
(4, 2, 4, '2024-04-04 13:00:00'),
(5, 3, 5, '2024-04-05 14:00:00'),
(1, 3, 4, '2024-04-06 15:00:00'),
(2, 3, 5, '2024-04-07 16:00:00'),
(3, 3, 3, '2024-04-08 17:00:00'),
(4, 3, 4, '2024-04-09 18:00:00'),
(5, 3, 5, '2024-04-10 19:00:00');

-- Insert dữ liệu vào bảng food
INSERT INTO `food` (`food_name`, `image`, `price`, `desc`, `type_id`) VALUES
('Food A', 'food_a.jpg', 10, 'Description of Food A', 1),
('Food B', 'food_b.jpg', 15, 'Description of Food B', 2),
('Food C', 'food_c.jpg', 20, 'Description of Food C', 3),
('Food D', 'food_d.jpg', 25, 'Description of Food D', 4),
('Food E', 'food_e.jpg', 30, 'Description of Food E', 1);

-- Insert dữ liệu vào bảng sub_food
INSERT INTO `sub_food` (`sub_name`, `sub_price`, `food_id`) VALUES
('Sub Food 1', 5, 1),
('Sub Food 2', 8, 1),
('Sub Food 3', 7, 2),
('Sub Food 4', 10, 2),
('Sub Food 5', 9, 3),
('Sub Food 6', 12, 3),
('Sub Food 7', 15, 4),
('Sub Food 8', 18, 5);

-- Insert dữ liệu vào bảng order
INSERT INTO `order` (`user_id`, `food_id`, `amount`, `code`, `arr_sub_id`) VALUES
(1, 1, 2, 'ORDER123', '1,2'),
(1, 2, 1, 'ORDER456', NULL),
(2, 2, 3, 'ORDER789', NULL),
(3, 3, 1, 'ORDER321', NULL),
(4, 1, 2, 'ORDER654', '3,4'),
(4, 2, 1, 'ORDER987', NULL),
(5, 3, 2, 'ORDER654', '5,6'),
(6, 1, 1, 'ORDER321', '7'),
(6, 2, 2, 'ORDER987', '8'),
(6, 3, 1, 'ORDER654', NULL);

-- Insert dữ liệu vào bảng rate_res
INSERT INTO `rate_res` (`user_id`, `res_id`, `amount`, `date_rate`) VALUES
(1, 1, 4, '2024-04-01 10:00:00'),
(2, 1, 5, '2024-04-02 11:00:00'),
(3, 2, 3, '2024-04-03 12:00:00'),
(4, 2, 4, '2024-04-04 13:00:00'),
(5, 3, 5, '2024-04-05 14:00:00'),
(1, 3, 4, '2024-04-06 15:00:00'),
(2, 3, 5, '2024-04-07 16:00:00'),
(3, 3, 3, '2024-04-08 17:00:00'),
(4, 3, 4, '2024-04-09 18:00:00'),
(5, 3, 5, '2024-04-10 19:00:00');


--Tìm 5 người đã like nhà hàng nhiều nhất
SELECT user_id, COUNT(*) AS like_count
FROM like_res
GROUP BY user_id
ORDER BY like_count DESC
LIMIT 5;

--Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT res_id, COUNT(*) AS like_count
FROM like_res
GROUP BY res_id
ORDER BY like_count DESC
LIMIT 2;


--Tìm người đã đặt hàng nhiều nhất
SELECT user_id, COUNT(*) AS order_count
FROM `order`
GROUP BY user_id
ORDER BY order_count DESC
LIMIT 1;


--Tìm người dùng không hoạt động trong hệ thống
SELECT user_id
FROM `user`
WHERE user_id NOT IN (
    SELECT DISTINCT user_id FROM `like_res`
    UNION
    SELECT DISTINCT user_id FROM `order`
    UNION
    SELECT DISTINCT user_id FROM `rate_res`
);
