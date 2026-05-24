package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.LikeDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Map;

@WebServlet("/photo/like")
public class LikeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendError(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        User user = (User) session.getAttribute("user");
        String photoIdStr = req.getParameter("photoId");
        if (photoIdStr == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        int photoId = Integer.parseInt(photoIdStr);
        LikeDao likeDao = new LikeDao();
        Map<String, Object> result = likeDao.toggleLike(user.getId(), photoId);

        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write(String.format(
            "{\"liked\":%b,\"count\":%d}",
            result.get("liked"), result.get("count")
        ));
    }
}
