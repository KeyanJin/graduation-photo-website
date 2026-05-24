<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String navCtx = request.getContextPath();
  com.keyan.graduationphoto.bean.User loginUser = null;
  boolean isLoggedIn = false;
  if (session != null && session.getAttribute("user") != null) {
    loginUser = (com.keyan.graduationphoto.bean.User) session.getAttribute("user");
    isLoggedIn = true;
  }
%>
<%@ include file="/WEB-INF/jspf/icons.jsp" %>
<nav class="navbar navbar-expand-lg navbar-campus sticky-top">
  <div class="container">
    <a class="navbar-brand" href="<%= navCtx %>/index.jsp">
      <span class="brand-icon">
        <svg class="ai-icon ai-brand-icon" aria-hidden="true"><use href="#ai-icon-graduation-cap"/></svg>
      </span>
      毕业照
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCampus" aria-controls="navbarCampus" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarCampus">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item">
          <a class="nav-link" href="<%= navCtx %>/index.jsp">首页</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= navCtx %>/search">搜索</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="<%= navCtx %>/map">地图</a>
        </li>
      </ul>
      <% if (isLoggedIn) { %>
      <div class="dropdown">
        <a class="nav-link dropdown-toggle d-flex align-items-center gap-2" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false" style="cursor:pointer;">
          <% if (loginUser.getAvatarPath() != null && !loginUser.getAvatarPath().isEmpty()) { %>
          <img src="<%= navCtx %>/uploads/<%= loginUser.getAvatarPath() %>" class="ai-avatar-nav" alt="avatar">
          <% } else { %>
          <span class="user-avatar"><%= loginUser.getUsername().substring(0, 1).toUpperCase() %></span>
          <% } %>
          <span><%= loginUser.getUsername() %></span>
        </a>
        <ul class="dropdown-menu dropdown-menu-end">
          <li><a class="dropdown-item d-flex align-items-center gap-2" href="<%= navCtx %>/profile.jsp"><svg class="ai-icon ai-icon-sm" aria-hidden="true"><use href="#ai-icon-user"/></svg> 个人中心</a></li>
          <li><a class="dropdown-item d-flex align-items-center gap-2" href="<%= navCtx %>/education?action=list"><svg class="ai-icon ai-icon-sm" aria-hidden="true"><use href="#ai-icon-education"/></svg> 教育履历</a></li>
          <li><a class="dropdown-item d-flex align-items-center gap-2" href="<%= navCtx %>/photo/list"><svg class="ai-icon ai-icon-sm" aria-hidden="true"><use href="#ai-icon-camera"/></svg> 我的照片</a></li>
          <li><hr class="dropdown-divider"></li>
          <li><a class="dropdown-item text-danger d-flex align-items-center gap-2" href="<%= navCtx %>/logout"><svg class="ai-icon ai-icon-sm" aria-hidden="true"><use href="#ai-icon-delete"/></svg> 退出登录</a></li>
        </ul>
      </div>
      <% } else { %>
      <div class="d-flex gap-2">
        <a href="<%= navCtx %>/login" class="btn btn-campus-outline btn-sm">登录</a>
        <a href="<%= navCtx %>/register" class="btn btn-campus-primary btn-sm">注册</a>
      </div>
      <% } %>
    </div>
  </div>
</nav>