<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Education" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  List<Education> educationList = (List<Education>) request.getAttribute("educationList");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>教育履历 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <h2>教育履历</h2>
      <p>管理你的求学经历</p>
    </div>
  </div>

  <div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <span class="text-muted-campus">共 <%= educationList != null ? educationList.size() : 0 %> 条记录</span>
      <a href="<%= ctx %>/education?action=add" class="btn btn-campus-primary">
        <svg class="ai-icon ai-icon-sm" aria-hidden="true"><use href="#ai-icon-add"/></svg> 添加履历
      </a>
    </div>

    <% if (educationList != null && !educationList.isEmpty()) { %>
    <div class="card card-campus">
      <div class="table-responsive">
        <table class="table table-campus mb-0">
          <thead>
            <tr>
              <th>教育阶段</th>
              <th>学校名称</th>
              <th>入学年份</th>
              <th>班级</th>
              <th>操作</th>
            </tr>
          </thead>
          <tbody>
            <% for (Education edu : educationList) { %>
            <tr>
              <td><span class="tag-campus"><%= edu.getStage() != null ? edu.getStage() : "" %></span></td>
              <td><%= edu.getSchoolName() != null ? edu.getSchoolName() : "" %></td>
              <td><%= edu.getEntranceYear() != null ? edu.getEntranceYear() : "" %></td>
              <td><%= edu.getClassName() != null ? edu.getClassName() : "" %></td>
              <td>
                <a href="<%= ctx %>/education?action=edit&id=<%= edu.getId() %>" class="btn btn-sm btn-campus-outline">编辑</a>
                <a href="<%= ctx %>/education?action=delete&id=<%= edu.getId() %>" class="btn btn-sm btn-campus-danger"
                   data-confirm="确定要删除这条教育履历吗？">删除</a>
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
      </div>
    </div>
    <% } else { %>
    <div class="empty-state">
      <div class="empty-icon">&#127891;</div>
      <h4>还没有教育履历</h4>
      <p>添加你的求学经历，关联你的毕业照</p>
      <a href="<%= ctx %>/education?action=add" class="btn btn-campus-primary">添加教育履历</a>
    </div>
    <% } %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>