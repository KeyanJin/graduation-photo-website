package com.keyan.graduationphoto.dao;

import com.keyan.graduationphoto.util.DBUtil;

import java.sql.*;
import java.util.*;

public class LikeDao {

    /**
     * 切换点赞状态（点赞/取消），返回点赞后的总数和当前状态
     */
    public Map<String, Object> toggleLike(Integer userId, Integer photoId) {
        Map<String, Object> result = new HashMap<>();
        try (Connection conn = DBUtil.getConnection()) {
            // 查询是否已点赞
            String checkSql = "SELECT COUNT(*) FROM photo_likes WHERE user_id = ? AND photo_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(checkSql)) {
                ps.setInt(1, userId);
                ps.setInt(2, photoId);
                ResultSet rs = ps.executeQuery();
                rs.next();
                if (rs.getInt(1) > 0) {
                    // 已点赞 → 取消
                    String delSql = "DELETE FROM photo_likes WHERE user_id = ? AND photo_id = ?";
                    try (PreparedStatement dps = conn.prepareStatement(delSql)) {
                        dps.setInt(1, userId);
                        dps.setInt(2, photoId);
                        dps.executeUpdate();
                    }
                    result.put("liked", false);
                } else {
                    // 未点赞 → 点赞
                    String insSql = "INSERT INTO photo_likes (user_id, photo_id) VALUES (?, ?)";
                    try (PreparedStatement ips = conn.prepareStatement(insSql)) {
                        ips.setInt(1, userId);
                        ips.setInt(2, photoId);
                        ips.executeUpdate();
                    }
                    result.put("liked", true);
                }
            }
            // 获取最新点赞数
            String countSql = "SELECT COUNT(*) FROM photo_likes WHERE photo_id = ?";
            try (PreparedStatement ps = conn.prepareStatement(countSql)) {
                ps.setInt(1, photoId);
                ResultSet rs = ps.executeQuery();
                rs.next();
                result.put("count", rs.getInt(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            result.put("liked", false);
            result.put("count", 0);
        }
        return result;
    }

    public int getLikeCount(Integer photoId) {
        String sql = "SELECT COUNT(*) FROM photo_likes WHERE photo_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, photoId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<Integer, Integer> getLikeCounts(List<Integer> photoIds) {
        Map<Integer, Integer> map = new HashMap<>();
        if (photoIds == null || photoIds.isEmpty()) return map;
        StringBuilder sb = new StringBuilder("SELECT photo_id, COUNT(*) AS cnt FROM photo_likes WHERE photo_id IN (");
        for (int i = 0; i < photoIds.size(); i++) {
            if (i > 0) sb.append(",");
            sb.append("?");
        }
        sb.append(") GROUP BY photo_id");
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sb.toString())) {
            for (int i = 0; i < photoIds.size(); i++) {
                ps.setInt(i + 1, photoIds.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("photo_id"), rs.getInt("cnt"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return map;
    }

    public Set<Integer> getLikedPhotoIds(Integer userId) {
        Set<Integer> set = new HashSet<>();
        String sql = "SELECT photo_id FROM photo_likes WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                set.add(rs.getInt("photo_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return set;
    }

    public List<Integer> getLikedPhotoIdsList(Integer userId) {
        List<Integer> list = new ArrayList<>();
        String sql = "SELECT photo_id FROM photo_likes WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getInt("photo_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
