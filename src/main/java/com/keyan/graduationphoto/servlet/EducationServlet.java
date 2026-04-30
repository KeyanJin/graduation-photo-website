package com.keyan.graduationphoto.servlet;

import com.keyan.graduationphoto.bean.Education;
import com.keyan.graduationphoto.bean.User;
import com.keyan.graduationphoto.dao.EducationDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/education")
public class EducationServlet extends HttpServlet {

    private final EducationDao educationDao = new EducationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        User user = getLoginUser(request);
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                showAddForm(request, response);
                break;
            case "edit":
                showEditForm(request, response, user);
                break;
            case "delete":
                deleteEducation(request, response, user);
                break;
            case "list":
            default:
                listEducation(request, response, user);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        User user = getLoginUser(request);
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addEducation(request, response, user);
                break;
            case "edit":
                updateEducation(request, response, user);
                break;
            default:
                listEducation(request, response, user);
                break;
        }
    }

    private User getLoginUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) {
            return null;
        }
        Object obj = session.getAttribute("user");
        if (obj instanceof User) {
            return (User) obj;
        }
        return null;
    }

    private void listEducation(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        List<Education> educationList = educationDao.findByUserId(user.getId());
        request.setAttribute("educationList", educationList);
        request.getRequestDispatcher("education_list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setAttribute("education", null);
        request.setAttribute("formAction", "add");
        request.getRequestDispatcher("education_form.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect("education?action=list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("education?action=list");
            return;
        }

        Education education = educationDao.findById(id);
        if (education == null || !education.getUserId().equals(user.getId())) {
            response.sendRedirect("education?action=list");
            return;
        }

        request.setAttribute("education", education);
        request.setAttribute("formAction", "edit");
        request.getRequestDispatcher("education_form.jsp").forward(request, response);
    }

    private void addEducation(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String stage = request.getParameter("stage");
        String schoolName = request.getParameter("schoolName");
        String entranceYear = request.getParameter("entranceYear");
        String className = request.getParameter("className");

        if (schoolName == null || schoolName.trim().isEmpty()) {
            request.setAttribute("error", "学校名称不能为空");
            request.setAttribute("formAction", "add");
            request.getRequestDispatcher("education_form.jsp").forward(request, response);
            return;
        }

        Education education = new Education();
        education.setUserId(user.getId());
        education.setStage(stage);
        education.setSchoolName(schoolName.trim());
        education.setEntranceYear(entranceYear);
        education.setClassName(className);

        boolean success = educationDao.addEducation(education);
        if (success) {
            response.sendRedirect("education?action=list");
        } else {
            request.setAttribute("error", "添加失败，请重试");
            request.setAttribute("formAction", "add");
            request.getRequestDispatcher("education_form.jsp").forward(request, response);
        }
    }

    private void updateEducation(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String stage = request.getParameter("stage");
        String schoolName = request.getParameter("schoolName");
        String entranceYear = request.getParameter("entranceYear");
        String className = request.getParameter("className");

        if (idStr == null) {
            response.sendRedirect("education?action=list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("education?action=list");
            return;
        }

        if (schoolName == null || schoolName.trim().isEmpty()) {
            Education education = new Education();
            education.setId(id);
            education.setUserId(user.getId());
            education.setStage(stage);
            education.setSchoolName(schoolName);
            education.setEntranceYear(entranceYear);
            education.setClassName(className);
            request.setAttribute("education", education);
            request.setAttribute("formAction", "edit");
            request.setAttribute("error", "学校名称不能为空");
            request.getRequestDispatcher("education_form.jsp").forward(request, response);
            return;
        }

        Education education = new Education();
        education.setId(id);
        education.setUserId(user.getId());
        education.setStage(stage);
        education.setSchoolName(schoolName.trim());
        education.setEntranceYear(entranceYear);
        education.setClassName(className);

        boolean success = educationDao.updateEducation(education);
        if (success) {
            response.sendRedirect("education?action=list");
        } else {
            request.setAttribute("education", education);
            request.setAttribute("formAction", "edit");
            request.setAttribute("error", "更新失败，请重试");
            request.getRequestDispatcher("education_form.jsp").forward(request, response);
        }
    }

    private void deleteEducation(HttpServletRequest request, HttpServletResponse response, User user)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect("education?action=list");
            return;
        }

        int id;
        try {
            id = Integer.parseInt(idStr);
        } catch (NumberFormatException e) {
            response.sendRedirect("education?action=list");
            return;
        }

        educationDao.deleteEducation(id, user.getId());
        response.sendRedirect("education?action=list");
    }
}
