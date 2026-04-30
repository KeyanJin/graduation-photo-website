package com.keyan.graduationphoto.dao;

import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhotoDao {

    public boolean addPhoto(Photo photo) {
        String sql = "INSERT INTO photos (user_id, education_id, title, description, image_path, location_name, longitude, latitude) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, photo.getUserId());
            ps.setInt(2, photo.getEducationId());
            ps.setString(3, photo.getTitle());
            ps.setString(4, photo.getDescription());
            ps.setString(5, photo.getImagePath());
            ps.setString(6, photo.getLocationName());
            ps.setObject(7, photo.getLongitude());
            ps.setObject(8, photo.getLatitude());
            int affected = ps.executeUpdate();
            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    photo.setId(rs.getInt(1));
                }
                rs.close();
            }
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePhoto(Integer id, Integer userId) {
        String sql = "DELETE FROM photos WHERE id = ? AND user_id = ?";
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

    public Photo findById(Integer id) {
        String sql = "SELECT p.*, u.username, e.stage, e.school_name, e.entrance_year, e.class_name " +
                     "FROM photos p JOIN users u ON p.user_id = u.id JOIN educations e ON p.education_id = e.id " +
                     "WHERE p.id = ?";
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

    public List<Photo> findByUserId(Integer userId) {
        List<Photo> list = new ArrayList<>();
        String sql = "SELECT p.*, u.username, e.stage, e.school_name, e.entrance_year, e.class_name " +
                     "FROM photos p JOIN users u ON p.user_id = u.id JOIN educations e ON p.education_id = e.id " +
                     "WHERE p.user_id = ? ORDER BY p.upload_time DESC";
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

    public List<Photo> findByEducationId(Integer educationId) {
        List<Photo> list = new ArrayList<>();
        String sql = "SELECT p.*, u.username, e.stage, e.school_name, e.entrance_year, e.class_name " +
                     "FROM photos p JOIN users u ON p.user_id = u.id JOIN educations e ON p.education_id = e.id " +
                     "WHERE p.education_id = ? ORDER BY p.upload_time DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, educationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Photo> findAll() {
        List<Photo> list = new ArrayList<>();
        String sql = "SELECT p.*, u.username, e.stage, e.school_name, e.entrance_year, e.class_name " +
                     "FROM photos p JOIN users u ON p.user_id = u.id JOIN educations e ON p.education_id = e.id " +
                     "ORDER BY p.upload_time DESC";
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

    public List<Photo> searchPhotos(String stage, String schoolName, String entranceYear, String className) {
        List<Photo> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, u.username, e.stage, e.school_name, e.entrance_year, e.class_name " +
            "FROM photos p JOIN users u ON p.user_id = u.id JOIN educations e ON p.education_id = e.id WHERE 1=1"
        );
        List<Object> params = new ArrayList<>();

        if (stage != null && !stage.isEmpty()) {
            sql.append(" AND e.stage = ?");
            params.add(stage);
        }
        if (schoolName != null && !schoolName.isEmpty()) {
            sql.append(" AND e.school_name LIKE ?");
            params.add("%" + schoolName + "%");
        }
        if (entranceYear != null && !entranceYear.isEmpty()) {
            sql.append(" AND e.entrance_year LIKE ?");
            params.add("%" + entranceYear + "%");
        }
        if (className != null && !className.isEmpty()) {
            sql.append(" AND e.class_name LIKE ?");
            params.add("%" + className + "%");
        }
        sql.append(" ORDER BY p.upload_time DESC");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Photo mapResultSet(ResultSet rs) throws SQLException {
        Photo photo = new Photo();
        photo.setId(rs.getInt("id"));
        photo.setUserId(rs.getInt("user_id"));
        photo.setEducationId(rs.getInt("education_id"));
        photo.setTitle(rs.getString("title"));
        photo.setDescription(rs.getString("description"));
        photo.setImagePath(rs.getString("image_path"));
        photo.setLocationName(rs.getString("location_name"));
        photo.setLongitude(rs.getObject("longitude") != null ? rs.getDouble("longitude") : null);
        photo.setLatitude(rs.getObject("latitude") != null ? rs.getDouble("latitude") : null);
        photo.setUploadTime(rs.getString("upload_time"));
        photo.setUsername(rs.getString("username"));
        photo.setStage(rs.getString("stage"));
        photo.setSchoolName(rs.getString("school_name"));
        photo.setEntranceYear(rs.getString("entrance_year"));
        photo.setClassName(rs.getString("class_name"));
        return photo;
    }
}
