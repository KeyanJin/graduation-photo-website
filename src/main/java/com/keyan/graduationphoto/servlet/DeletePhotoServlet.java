package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;

@WebServlet("/photo/delete")
public class DeletePhotoServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();
    private static final String UPLOAD_DIR = System.getProperty("user.home")
            + File.separator + "graduation-photo-uploads";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/photo/list");
            return;
        }

        int photoId;
        try {
            photoId = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/photo/list");
            return;
        }

        Photo photo = photoDao.findById(photoId);
        if (photo != null && photo.getUserId().equals(user.getId())) {
            boolean deleted = photoDao.deletePhoto(photoId, user.getId());
            if (deleted && photo.getImagePath() != null) {
                String filename = photo.getImagePath();
                if (filename.startsWith("uploads/")) {
                    filename = filename.substring("uploads/".length());
                }
                File file = new File(UPLOAD_DIR, filename);
                if (file.exists()) {
                    file.delete();
                }
            }
        }

        resp.sendRedirect(req.getContextPath() + "/photo/list");
    }
}
