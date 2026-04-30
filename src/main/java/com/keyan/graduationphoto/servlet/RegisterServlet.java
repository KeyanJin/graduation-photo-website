package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");

        if (username == null || username.trim().isEmpty()) {
            req.setAttribute("error", "用户名不能为空");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        if (password == null || password.isEmpty()) {
            req.setAttribute("error", "密码不能为空");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        if (confirmPassword == null || confirmPassword.isEmpty()) {
            req.setAttribute("error", "请确认密码");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "两次输入的密码不一致");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        username = username.trim();
        if (username.length() < 2 || username.length() > 20) {
            req.setAttribute("error", "用户名长度需在2-20个字符之间");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (password.length() < 6 || password.length() > 20) {
            req.setAttribute("error", "密码长度需在6-20个字符之间");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        if (userDao.usernameExists(username)) {
            req.setAttribute("error", "该用户名已被注册");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);

        boolean success = userDao.addUser(user);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("error", "注册失败，请稍后重试");
            req.setAttribute("username", username);
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
