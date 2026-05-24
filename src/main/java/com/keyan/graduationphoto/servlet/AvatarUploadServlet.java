package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.UserDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/avatar/upload")
@MultipartConfig(maxFileSize = 5 * 1024 * 1024)
public class AvatarUploadServlet extends HttpServlet {

    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "graduation-photo-uploads" + File.separator + "avatars";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        try {
            Part filePart = req.getPart("avatarFile");
            if (filePart == null || filePart.getSize() == 0) {
                resp.sendRedirect(req.getContextPath() + "/profile.jsp?error=请选择文件");
                return;
            }

            String contentType = filePart.getContentType();
            if (!"image/jpeg".equals(contentType) && !"image/png".equals(contentType)) {
                resp.sendRedirect(req.getContextPath() + "/profile.jsp?error=仅支持JPG/PNG格式");
                return;
            }

            String submittedFileName = filePart.getSubmittedFileName();
            String ext = "";
            if (submittedFileName != null && submittedFileName.contains(".")) {
                ext = submittedFileName.substring(submittedFileName.lastIndexOf(".")).toLowerCase();
            }
            if (!".jpg".equals(ext) && !".jpeg".equals(ext) && !".png".equals(ext)) {
                resp.sendRedirect(req.getContextPath() + "/profile.jsp?error=仅支持jpg/jpeg/png格式");
                return;
            }

            File dir = new File(UPLOAD_DIR);
            if (!dir.exists()) dir.mkdirs();

            String newFileName = "avatar_" + user.getId() + "_" + UUID.randomUUID().toString().substring(0, 8) + ext;
            Path filePath = Paths.get(UPLOAD_DIR, newFileName);
            Files.copy(filePart.getInputStream(), filePath);

            // 删除旧头像文件
            if (user.getAvatarPath() != null) {
                try {
                    Path oldPath = Paths.get(UPLOAD_DIR, user.getAvatarPath());
                    Files.deleteIfExists(oldPath);
                } catch (IOException ignored) {}
            }

            String avatarPath = "avatars/" + newFileName;
            UserDao userDao = new UserDao();
            userDao.updateAvatar(user.getId(), avatarPath);
            user.setAvatarPath(avatarPath);
            session.setAttribute("user", user);

            resp.sendRedirect(req.getContextPath() + "/profile.jsp?msg=头像更新成功");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/profile.jsp?error=上传失败");
        }
    }
}
