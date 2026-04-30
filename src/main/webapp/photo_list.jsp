<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  List<Photo> photos = (List<Photo>) request.getAttribute("photos");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>我的照片 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <h2>&#128247; 我的照片</h2>
      <p>管理你的毕业照</p>
    </div>
  </div>

  <div class="container py-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
      <span class="text-muted-campus">共 <%= photos != null ? photos.size() : 0 %> 张照片</span>
      <a href="<%= ctx %>/photo/upload" class="btn btn-campus-primary">&#43; 上传照片</a>
    </div>

    <% if (photos != null && !photos.isEmpty()) { %>
    <div class="photo-grid">
      <% for (Photo photo : photos) { %>
        <div class="photo-card">
          <a href="<%= ctx %>/photo/detail?id=<%= photo.getId() %>" style="text-decoration:none;color:inherit;display:block;">
            <div class="photo-img-wrapper">
              <img src="<%= ctx %>/<%= photo.getImagePath() %>" alt="<%= photo.getTitle() %>"
                   onerror="this.src='https://via.placeholder.com/400x300/7EC8E3/FFFFFF?text=毕业照'">
            </div>
          </a>
          <form action="<%= ctx %>/photo/delete" method="post" class="photo-delete-form"
                onsubmit="return confirm('确定要删除这张毕业照吗？此操作不可恢复。');">
            <input type="hidden" name="id" value="<%= photo.getId() %>">
            <button type="submit" class="btn-delete" title="删除">&#10005;</button>
          </form>
          <div class="photo-info">
            <div class="photo-title"><%= photo.getTitle() %></div>
            <div class="photo-meta">
              <span class="badge-campus"><%= photo.getStage() != null ? photo.getStage() : "" %></span>
              <span><%= photo.getSchoolName() != null ? photo.getSchoolName() : "" %></span>
            </div>
          </div>
        </div>
      <% } %>
    </div>
    <% } else { %>
    <div class="empty-state">
      <div class="empty-icon">&#128247;</div>
      <h4>还没有上传毕业照</h4>
      <p>点击上方按钮上传你的第一张毕业照吧！</p>
      <a href="<%= ctx %>/photo/upload" class="btn btn-campus-primary">上传照片</a>
    </div>
    <% } %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>