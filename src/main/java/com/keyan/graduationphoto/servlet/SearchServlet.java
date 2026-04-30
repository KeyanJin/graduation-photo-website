package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/search/*")
public class SearchServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            // /search -> 展示教育阶段选择页面
            req.getRequestDispatcher("/search.jsp").forward(req, resp);
        } else if ("/result".equals(pathInfo)) {
            // /search/result -> 执行搜索并展示结果
            String stage = req.getParameter("stage");
            String schoolName = req.getParameter("schoolName");
            String entranceYear = req.getParameter("entranceYear");
            String className = req.getParameter("className");

            List<Photo> photos = photoDao.searchPhotos(stage, schoolName, entranceYear, className);

            req.setAttribute("photos", photos);
            req.setAttribute("stage", stage);
            req.setAttribute("schoolName", schoolName);
            req.setAttribute("entranceYear", entranceYear);
            req.setAttribute("className", className);
            req.getRequestDispatcher("/search_result.jsp").forward(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
