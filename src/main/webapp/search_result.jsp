<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  List<Photo> photos = (List<Photo>) request.getAttribute("photos");
  String stage = (String) request.getAttribute("stage");
  String schoolName = (String) request.getAttribute("schoolName");
  String entranceYear = (String) request.getAttribute("entranceYear");
  String className = (String) request.getAttribute("className");
  Integer total = (Integer) request.getAttribute("total");
  Integer currentPage = (Integer) request.getAttribute("currentPage");
  Integer totalPages = (Integer) request.getAttribute("totalPages");
  if (total == null) total = photos != null ? photos.size() : 0;
  if (currentPage == null) currentPage = 1;
  if (totalPages == null) totalPages = 1;

  // 构建分页 URL
  String pageBaseUrl = ctx + "/search/result?";
  if (stage != null && !stage.isEmpty()) pageBaseUrl += "stage=" + java.net.URLEncoder.encode(stage, "UTF-8") + "&";
  if (schoolName != null && !schoolName.isEmpty()) pageBaseUrl += "schoolName=" + java.net.URLEncoder.encode(schoolName, "UTF-8") + "&";
  if (entranceYear != null && !entranceYear.isEmpty()) pageBaseUrl += "entranceYear=" + java.net.URLEncoder.encode(entranceYear, "UTF-8") + "&";
  if (className != null && !className.isEmpty()) pageBaseUrl += "className=" + java.net.URLEncoder.encode(className, "UTF-8") + "&";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>搜索结果 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-campus mb-2">
          <li class="breadcrumb-item"><a href="<%= ctx %>/search">搜索</a></li>
          <li class="breadcrumb-item active">搜索结果</li>
        </ol>
      </nav>
      <h2>搜索毕业照</h2>
    </div>
  </div>

  <div class="container py-4">
    <div class="card card-campus mb-4 p-3">
      <form action="<%= ctx %>/search/result" method="get" class="row g-2 align-items-end">
        <div class="col-md-3">
          <label class="form-label form-campus">教育阶段</label>
          <select name="stage" class="form-select form-campus">
            <option value="">全部阶段</option>
            <option value="幼儿园" <%= "幼儿园".equals(stage) ? "selected" : "" %>>幼儿园</option>
            <option value="小学" <%= "小学".equals(stage) ? "selected" : "" %>>小学</option>
            <option value="初中" <%= "初中".equals(stage) ? "selected" : "" %>>初中</option>
            <option value="高中" <%= "高中".equals(stage) ? "selected" : "" %>>高中</option>
            <option value="大学" <%= "大学".equals(stage) ? "selected" : "" %>>大学</option>
            <option value="硕士研究生" <%= "硕士研究生".equals(stage) ? "selected" : "" %>>硕士研究生</option>
            <option value="博士研究生" <%= "博士研究生".equals(stage) ? "selected" : "" %>>博士研究生</option>
            <option value="其他" <%= "其他".equals(stage) ? "selected" : "" %>>其他</option>
          </select>
        </div>
        <div class="col-md-3">
          <label class="form-label form-campus">学校名称</label>
          <input type="text" name="schoolName" class="form-control form-campus" placeholder="输入学校名称" value="<%= schoolName != null ? schoolName : "" %>">
        </div>
        <div class="col-md-2">
          <label class="form-label form-campus">入学年份</label>
          <input type="text" name="entranceYear" class="form-control form-campus" placeholder="如: 2020" value="<%= entranceYear != null ? entranceYear : "" %>">
        </div>
        <div class="col-md-2">
          <label class="form-label form-campus">班级</label>
          <input type="text" name="className" class="form-control form-campus" placeholder="如: 1班" value="<%= className != null ? className : "" %>">
        </div>
        <div class="col-md-2">
          <button type="submit" class="btn btn-campus-primary w-100">搜索</button>
        </div>
        <input type="hidden" name="page" value="1">
      </form>
    </div>

    <% if (photos != null && !photos.isEmpty()) { %>
    <p class="text-muted-campus mb-3">共找到 <strong><%= total %></strong> 张毕业照 · 第 <strong><%= currentPage %></strong>/<%= totalPages %> 页</p>
    <div class="photo-grid">
      <% for (Photo photo : photos) { %>
      <a href="<%= ctx %>/photo/detail?id=<%= photo.getId() %>" style="text-decoration:none;color:inherit;">
        <div class="photo-card">
          <div class="photo-img-wrapper">
            <img src="<%= ctx %>/<%= photo.getImagePath() %>" alt="<%= photo.getTitle() %>"
                 onerror="this.src='https://via.placeholder.com/400x300/f8f8f0/794f27?text=%E6%AF%95%E4%B8%9A%E7%85%A7'">
          </div>
          <div class="photo-info">
            <div class="photo-title"><%= photo.getTitle() %></div>
            <div class="photo-meta">
              <span class="badge-campus"><%= photo.getStage() != null ? photo.getStage() : "" %></span>
              <span><%= photo.getSchoolName() != null ? photo.getSchoolName() : "" %></span>
              <% if (photo.getLikeCount() > 0) { %>
              <span class="ai-like-count">
                <svg class="ai-icon" style="width:12px;height:12px;" aria-hidden="true"><use href="#ai-icon-heart"/></svg>
                <%= photo.getLikeCount() %>
              </span>
              <% } %>
            </div>
          </div>
        </div>
      </a>
      <% } %>
    </div>

    <%-- 分页控件 --%>
    <% if (totalPages > 1) { %>
    <div class="ai-pagination">
      <% if (currentPage > 1) { %>
      <a href="<%= pageBaseUrl %>page=<%= currentPage - 1 %>" class="ai-page-btn">&lsaquo; 上一页</a>
      <% } else { %>
      <span class="ai-page-btn disabled">&lsaquo; 上一页</span>
      <% } %>

      <% for (int i = 1; i <= totalPages; i++) {
        if (i == currentPage) { %>
      <span class="ai-page-btn active"><%= i %></span>
      <% } else if (i <= 3 || i > totalPages - 3 || Math.abs(i - currentPage) <= 1) { %>
      <a href="<%= pageBaseUrl %>page=<%= i %>" class="ai-page-btn"><%= i %></a>
      <% } else if (i == 4 || i == totalPages - 3) { %>
      <span class="ai-page-ellipsis">...</span>
      <% } %>
      <% } %>

      <% if (currentPage < totalPages) { %>
      <a href="<%= pageBaseUrl %>page=<%= currentPage + 1 %>" class="ai-page-btn">下一页 &rsaquo;</a>
      <% } else { %>
      <span class="ai-page-btn disabled">下一页 &rsaquo;</span>
      <% } %>
    </div>
    <% } %>
    <% } else { %>
    <div class="empty-state">
      <div class="empty-icon">
        <svg class="ai-icon ai-icon-xl" aria-hidden="true"><use href="#ai-icon-search"/></svg>
      </div>
      <h4>暂无搜索结果</h4>
      <p>尝试调整搜索条件，或<a href="<%= ctx %>/search">选择其他教育阶段</a></p>
    </div>
    <% } %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>