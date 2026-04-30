package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/photo/detail")
public class PhotoDetailServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
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
        if (photo == null) {
            resp.sendRedirect(req.getContextPath() + "/photo/list");
            return;
        }

        req.setAttribute("photo", photo);
        req.getRequestDispatcher("/photo_detail.jsp").forward(req, resp);
    }
}
