-- ============================================
-- DB Migration: 新增点赞和头像功能
-- 在 MySQL 命令行中执行:
--   mysql -u graduation_user -p graduation_photo < migration.sql
-- ============================================

-- 1. 用户表：新增头像路径字段
ALTER TABLE users ADD COLUMN avatar_path VARCHAR(255) DEFAULT NULL AFTER password;

-- 2. 点赞表
CREATE TABLE IF NOT EXISTS photo_likes (
    user_id    INT NOT NULL,
    photo_id   INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, photo_id),
    FOREIGN KEY (user_id)  REFERENCES users(id)  ON DELETE CASCADE,
    FOREIGN KEY (photo_id) REFERENCES photos(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
