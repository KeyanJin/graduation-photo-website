<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%@ page import="com.keyan.graduationphoto.dao.PhotoDao" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  PhotoDao photoDao = new PhotoDao();
  List<Photo> latestPhotos = photoDao.findAll();
  int displayLimit = 6;
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>青春毕业照 - 记录校园最美时光</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <section class="hero-section">
    <div class="container position-relative" style="z-index:1;">
      <div class="row align-items-center">
        <div class="col-lg-6">
          <h1 class="hero-title animate-fade-in-up">
            定格<span class="highlight">青春</span>，<br>留住校园最美时光
          </h1>
          <p class="hero-subtitle animate-fade-in-up animate-delay-1">
            在这里，每一张毕业照都承载着一段难忘的校园记忆。<br>
            上传你的毕业照，与同窗好友一起重温那些年。
          </p>
          <div class="hero-actions animate-fade-in-up animate-delay-2">
            <a href="<%= ctx %>/register" class="btn btn-campus-primary btn-lg">立即加入</a>
            <a href="<%= ctx %>/search" class="btn btn-campus-outline btn-lg">探索照片</a>
          </div>
        </div>
        <div class="col-lg-6 d-none d-lg-block text-center">
          <div class="animate-fade-in-up animate-delay-3" style="font-size: 8rem; line-height: 1.2;">
            &#127891;&#127878;&#128247;
          </div>
        </div>
      </div>
    </div>
  </section>

  <section class="section-campus">
    <div class="container">
      <h2 class="section-title">功能介绍</h2>
      <p class="section-subtitle">用科技留住青春，让回忆永不褪色</p>
      <div class="row g-4">
        <div class="col-md-6 col-lg-3">
          <div class="feature-card animate-on-scroll">
            <div class="feature-icon feature-icon-primary">&#128247;</div>
            <h5>上传毕业照</h5>
            <p>上传你的毕业照，关联教育履历，记录每一个重要时刻</p>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="feature-card animate-on-scroll">
            <div class="feature-icon feature-icon-secondary">&#128269;</div>
            <h5>搜索同学</h5>
            <p>按学校、年级、班级搜索，找到你的同窗好友</p>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="feature-card animate-on-scroll">
            <div class="feature-icon feature-icon-accent">&#127758;</div>
            <h5>地图标记</h5>
            <p>在地图上标记拍摄地点，发现身边的毕业照</p>
          </div>
        </div>
        <div class="col-md-6 col-lg-3">
          <div class="feature-card animate-on-scroll">
            <div class="feature-icon feature-icon-primary">&#127891;</div>
            <h5>教育履历</h5>
            <p>记录你的求学经历，从幼儿园到大学一目了然</p>
          </div>
        </div>
      </div>
    </div>
  </section>

  <% if (latestPhotos != null && !latestPhotos.isEmpty()) { %>
  <section class="section-campus" style="background: var(--color-card);">
    <div class="container">
      <h2 class="section-title">最新毕业照</h2>
      <p class="section-subtitle">来自同学们的精彩瞬间</p>
      <div class="photo-grid">
        <% int count = 0; %>
        <% for (Photo photo : latestPhotos) { %>
          <% if (count >= displayLimit) break; %>
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
          <% count++; %>
        <% } %>
      </div>
      <% if (latestPhotos.size() > displayLimit) { %>
      <div class="text-center mt-4">
        <a href="<%= ctx %>/search" class="btn btn-campus-outline">查看更多</a>
      </div>
      <% } %>
    </div>
  </section>
  <% } %>

  <footer class="footer-campus">
    <div class="container">
      <p>&copy; 2026 青春毕业照 - 记录校园最美时光</p>
    </div>
  </footer>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>