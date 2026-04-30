package com.keyan.graduationphoto.dao;

import com.keyan.graduationphoto.bean.Education;
import com.keyan.graduationphoto.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EducationDao {

    public boolean addEducation(Education education) {
        String sql = "INSERT INTO educations (user_id, stage, school_name, entrance_year, class_name) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, education.getUserId());
            ps.setString(2, education.getStage());
            ps.setString(3, education.getSchoolName());
            ps.setString(4, education.getEntranceYear());
            ps.setString(5, education.getClassName());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    education.setId(rs.getInt(1));
                }
                rs.close();
            }
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateEducation(Education education) {
        String sql = "UPDATE educations SET stage = ?, school_name = ?, entrance_year = ?, class_name = ? WHERE id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, education.getStage());
            ps.setString(2, education.getSchoolName());
            ps.setString(3, education.getEntranceYear());
            ps.setString(4, education.getClassName());
            ps.setInt(5, education.getId());
            ps.setInt(6, education.getUserId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteEducation(Integer id, Integer userId) {
        String sql = "DELETE FROM educations WHERE id = ? AND user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Education findById(Integer id) {
        String sql = "SELECT e.*, u.username FROM educations e JOIN users u ON e.user_id = u.id WHERE e.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Education> findByUserId(Integer userId) {
        List<Education> list = new ArrayList<>();
        String sql = "SELECT e.*, u.username FROM educations e JOIN users u ON e.user_id = u.id WHERE e.user_id = ? ORDER BY e.id DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Education> findAll() {
        List<Education> list = new ArrayList<>();
        String sql = "SELECT e.*, u.username FROM educations e JOIN users u ON e.user_id = u.id ORDER BY e.id DESC";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Education mapResultSet(ResultSet rs) throws SQLException {
        Education education = new Education();
        education.setId(rs.getInt("id"));
        education.setUserId(rs.getInt("user_id"));
        education.setStage(rs.getString("stage"));
        education.setSchoolName(rs.getString("school_name"));
        education.setEntranceYear(rs.getString("entrance_year"));
        education.setClassName(rs.getString("class_name"));
        education.setUsername(rs.getString("username"));
        return education;
    }
}
