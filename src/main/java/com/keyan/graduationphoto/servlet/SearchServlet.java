package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.LikeDao;
import com.keyan.graduationphoto.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

@WebServlet("/search/*")
public class SearchServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();
    private final LikeDao likeDao = new LikeDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String pathInfo = req.getPathInfo();

        if (pathInfo == null || "/".equals(pathInfo)) {
            req.getRequestDispatcher("/search.jsp").forward(req, resp);
        } else if ("/result".equals(pathInfo)) {
            String stage = req.getParameter("stage");
            String schoolName = req.getParameter("schoolName");
            String entranceYear = req.getParameter("entranceYear");
            String className = req.getParameter("className");

            List<Photo> photos = photoDao.searchPhotos(stage, schoolName, entranceYear, className);

            // 批量加载点赞数据
            if (!photos.isEmpty()) {
                List<Integer> ids = photos.stream().map(Photo::getId).collect(Collectors.toList());
                Map<Integer, Integer> counts = likeDao.getLikeCounts(ids);
                User user = (User) req.getSession().getAttribute("user");
                Set<Integer> likedIds = user != null ? likeDao.getLikedPhotoIds(user.getId()) : Collections.emptySet();
                for (Photo p : photos) {
                    p.setLikeCount(counts.getOrDefault(p.getId(), 0));
                    p.setLiked(likedIds.contains(p.getId()));
                }
            }

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
