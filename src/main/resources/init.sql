-- 创建数据库
CREATE DATABASE IF NOT EXISTS graduation_photo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE graduation_photo;

-- 用户表
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 教育履历表
CREATE TABLE IF NOT EXISTS educations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    stage VARCHAR(30) NOT NULL,
    school_name VARCHAR(100) NOT NULL,
    entrance_year VARCHAR(20),
    class_name VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 毕业照表
CREATE TABLE IF NOT EXISTS photos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    education_id INT NOT NULL,
    title VARCHAR(100),
    description TEXT,
    image_path VARCHAR(255) NOT NULL,
    location_name VARCHAR(100),
    longitude DOUBLE,
    latitude DOUBLE,
    upload_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (education_id) REFERENCES educations(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 创建数据库用户（如果尚未创建）
-- CREATE USER IF NOT EXISTS 'graduation_user'@'localhost' IDENTIFIED BY 'jinkeyan2005';
-- GRANT ALL PRIVILEGES ON graduation_photo.* TO 'graduation_user'@'localhost';
-- FLUSH PRIVILEGES;
