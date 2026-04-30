<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.User" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%@ page import="com.keyan.graduationphoto.bean.Education" %>
<%@ page import="com.keyan.graduationphoto.dao.PhotoDao" %>
<%@ page import="com.keyan.graduationphoto.dao.EducationDao" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  User user = (User) session.getAttribute("user");
  PhotoDao photoDao = new PhotoDao();
  EducationDao educationDao = new EducationDao();
  List<Photo> myPhotos = photoDao.findByUserId(user.getId());
  List<Education> myEducations = educationDao.findByUserId(user.getId());
  int photoCount = myPhotos != null ? myPhotos.size() : 0;
  int eduCount = myEducations != null ? myEducations.size() : 0;
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>个人中心 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <h2>&#128100; 个人中心</h2>
      <p>欢迎回来，<%= user.getUsername() %></p>
    </div>
  </div>

  <div class="container py-4">
    <div class="row g-4">
      <div class="col-md-4">
        <div class="card card-campus text-center p-4">
          <div class="user-avatar mx-auto mb-3" style="width:64px;height:64px;font-size:1.5rem;">
            <%= user.getUsername().substring(0, 1).toUpperCase() %>
          </div>
          <h5><%= user.getUsername() %></h5>
          <p class="text-muted-campus mb-0">毕业照会员</p>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card card-campus p-4">
          <div class="d-flex align-items-center gap-3 mb-3">
            <span style="font-size:2rem;">&#127891;</span>
            <div>
              <h5 class="mb-0">教育履历</h5>
              <small class="text-muted-campus">共 <%= eduCount %> 条记录</small>
            </div>
          </div>
          <a href="<%= ctx %>/education?action=list" class="btn btn-campus-secondary w-100">管理教育履历</a>
        </div>
      </div>
      <div class="col-md-4">
        <div class="card card-campus p-4">
          <div class="d-flex align-items-center gap-3 mb-3">
            <span style="font-size:2rem;">&#128247;</span>
            <div>
              <h5 class="mb-0">我的照片</h5>
              <small class="text-muted-campus">共 <%= photoCount %> 张照片</small>
            </div>
          </div>
          <a href="<%= ctx %>/photo/list" class="btn btn-campus-primary w-100">查看我的照片</a>
        </div>
      </div>
    </div>

    <div class="mt-4">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h5>最近照片</h5>
        <a href="<%= ctx %>/photo/upload" class="btn btn-campus-accent btn-sm">&#43; 上传照片</a>
      </div>
      <% if (myPhotos != null && !myPhotos.isEmpty()) { %>
      <div class="photo-grid">
        <% int limit = 6; int i = 0; %>
        <% for (Photo photo : myPhotos) { %>
          <% if (i >= limit) break; %>
          <a href="<%= ctx %>/photo/detail?id=<%= photo.getId() %>" style="text-decoration:none;color:inherit;">
            <div class="photo-card">
              <div class="photo-img-wrapper">
                <img src="<%= ctx %>/<%= photo.getImagePath() %>" alt="<%= photo.getTitle() %>"
                     onerror="this.src='https://via.placeholder.com/400x300/7EC8E3/FFFFFF?text=毕业照'">
              </div>
              <div class="photo-info">
                <div class="photo-title"><%= photo.getTitle() %></div>
                <div class="photo-meta">
                  <span class="badge-campus"><%= photo.getStage() != null ? photo.getStage() : "" %></span>
                  <span><%= photo.getSchoolName() != null ? photo.getSchoolName() : "" %></span>
                </div>
              </div>
            </div>
          </a>
          <% i++; %>
        <% } %>
      </div>
      <% } else { %>
      <div class="empty-state">
        <div class="empty-icon">&#128247;</div>
        <h4>还没有照片</h4>
        <p>上传你的第一张毕业照吧！</p>
        <a href="<%= ctx %>/photo/upload" class="btn btn-campus-primary">上传照片</a>
      </div>
      <% } %>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>