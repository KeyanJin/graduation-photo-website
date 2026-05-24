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

@WebServlet("/photo/list")
public class PhotoListServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();
    private final LikeDao likeDao = new LikeDao();

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

        List<Photo> photos = photoDao.findByUserId(user.getId());

        // 批量加载点赞数据
        if (!photos.isEmpty()) {
            List<Integer> ids = photos.stream().map(Photo::getId).collect(Collectors.toList());
            Map<Integer, Integer> counts = likeDao.getLikeCounts(ids);
            Set<Integer> likedIds = likeDao.getLikedPhotoIds(user.getId());
            for (Photo p : photos) {
                p.setLikeCount(counts.getOrDefault(p.getId(), 0));
                p.setLiked(likedIds.contains(p.getId()));
            }
        }

        req.setAttribute("photos", photos);
        req.getRequestDispatcher("/photo_list.jsp").forward(req, resp);
    }
}
