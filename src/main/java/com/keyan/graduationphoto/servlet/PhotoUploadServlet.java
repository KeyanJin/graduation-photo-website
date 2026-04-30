package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Education;
import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.EducationDao;
import com.keyan.graduationphoto.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@WebServlet("/photo/upload")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 30,
    maxRequestSize = 1024 * 1024 * 100
)
public class PhotoUploadServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();
    private final EducationDao educationDao = new EducationDao();

    private static final List<String> ALLOWED_CONTENT_TYPES = List.of(
        "image/jpeg", "image/png"
    );
    private static final List<String> ALLOWED_EXTENSIONS = List.of(
        ".jpg", ".jpeg", ".png"
    );

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

        List<Education> educations = educationDao.findByUserId(user.getId());
        req.setAttribute("educations", educations);

        req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
    }

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

        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String locationName = req.getParameter("locationName");
        String longitudeStr = req.getParameter("longitude");
        String latitudeStr = req.getParameter("latitude");
        String educationIdStr = req.getParameter("educationId");

        if (title == null || title.trim().isEmpty()) {
            req.setAttribute("error", "标题不能为空");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
            return;
        }

        if (educationIdStr == null || educationIdStr.trim().isEmpty()) {
            req.setAttribute("error", "请选择教育履历");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
            return;
        }

        Part filePart = req.getPart("photoFile");
        if (filePart == null || filePart.getSize() == 0) {
            req.setAttribute("error", "请选择照片文件");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
            return;
        }

        String contentType = filePart.getContentType();
        if (contentType == null || !ALLOWED_CONTENT_TYPES.contains(contentType.toLowerCase())) {
            req.setAttribute("error", "仅支持jpg、jpeg、png格式的照片");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
            return;
        }

        String submittedFileName = filePart.getSubmittedFileName();
        if (submittedFileName == null || submittedFileName.isEmpty()) {
            req.setAttribute("error", "文件名无效");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
            return;
        }

        String lowerFileName = submittedFileName.toLowerCase();
        boolean hasValidExtension = ALLOWED_EXTENSIONS.stream()
                .anyMatch(lowerFileName::endsWith);
        if (!hasValidExtension) {
            req.setAttribute("error", "仅支持jpg、jpeg、png格式的照片");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
            return;
        }

        String extension = lowerFileName.substring(lowerFileName.lastIndexOf('.'));
        String uniqueFileName = UUID.randomUUID().toString() + extension;

        String uploadDir = getServletContext().getRealPath("/uploads");
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        String filePath = uploadDir + File.separator + uniqueFileName;
        filePart.write(filePath);

        Photo photo = new Photo();
        photo.setUserId(user.getId());
        photo.setEducationId(Integer.parseInt(educationIdStr));
        photo.setTitle(title.trim());
        photo.setDescription(description != null ? description.trim() : "");
        photo.setImagePath("uploads/" + uniqueFileName);
        photo.setLocationName(locationName != null ? locationName.trim() : "");

        if (longitudeStr != null && !longitudeStr.trim().isEmpty()) {
            try {
                photo.setLongitude(Double.parseDouble(longitudeStr));
            } catch (NumberFormatException ignored) {
            }
        }
        if (latitudeStr != null && !latitudeStr.trim().isEmpty()) {
            try {
                photo.setLatitude(Double.parseDouble(latitudeStr));
            } catch (NumberFormatException ignored) {
            }
        }

        boolean success = photoDao.addPhoto(photo);
        if (success) {
            resp.sendRedirect(req.getContextPath() + "/photo/list");
        } else {
            req.setAttribute("error", "上传失败，请稍后重试");
            reloadForm(req, user);
            req.getRequestDispatcher("/photo_upload.jsp").forward(req, resp);
        }
    }

    private void reloadForm(HttpServletRequest req, User user) {
        List<Education> educations = educationDao.findByUserId(user.getId());
        req.setAttribute("educations", educations);
        req.setAttribute("title", req.getParameter("title"));
        req.setAttribute("description", req.getParameter("description"));
        req.setAttribute("locationName", req.getParameter("locationName"));
        req.setAttribute("longitude", req.getParameter("longitude"));
        req.setAttribute("latitude", req.getParameter("latitude"));
        req.setAttribute("educationId", req.getParameter("educationId"));
    }
}
