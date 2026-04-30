package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Photo;
import com.keyan.graduationphoto.dao.PhotoDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/map")
public class MapServlet extends HttpServlet {

    private final PhotoDao photoDao = new PhotoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if ("data".equals(action)) {
            resp.setContentType("application/json;charset=UTF-8");
            resp.setCharacterEncoding("UTF-8");
            PrintWriter out = resp.getWriter();
            out.print(buildPhotoJson());
            out.flush();
        } else {
            req.getRequestDispatcher("/map.jsp").forward(req, resp);
        }
    }

    private String buildPhotoJson() {
        List<Photo> photos = photoDao.findAll();
        StringBuilder sb = new StringBuilder();
        sb.append("[");

        boolean first = true;
        for (Photo p : photos) {
            if (p.getLongitude() == null || p.getLatitude() == null) {
                continue;
            }
            if (!first) {
                sb.append(",");
            }
            first = false;

            sb.append("{");
            sb.append("\"id\":").append(p.getId());
            sb.append(",\"title\":").append(jsonStr(p.getTitle()));
            sb.append(",\"imagePath\":").append(jsonStr(p.getImagePath()));
            sb.append(",\"locationName\":").append(jsonStr(p.getLocationName()));
            sb.append(",\"longitude\":").append(p.getLongitude());
            sb.append(",\"latitude\":").append(p.getLatitude());
            sb.append(",\"stage\":").append(jsonStr(p.getStage()));
            sb.append(",\"schoolName\":").append(jsonStr(p.getSchoolName()));
            sb.append(",\"entranceYear\":").append(jsonStr(p.getEntranceYear()));
            sb.append(",\"className\":").append(jsonStr(p.getClassName()));
            sb.append("}");
        }

        sb.append("]");
        return sb.toString();
    }

    private String jsonStr(String value) {
        if (value == null) {
            return "null";
        }
        String escaped = value
                .replace("\\", "\\\\")
                .replace("\"", "\\\"")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t");
        return "\"" + escaped + "\"";
    }
}
