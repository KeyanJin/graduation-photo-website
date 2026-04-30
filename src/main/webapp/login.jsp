<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String ctx = request.getContextPath();
  String error = (String) request.getAttribute("error");
  String username = (String) request.getAttribute("username");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>登录 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="auth-card">
    <div class="card card-campus">
      <div class="card-body">
        <h3>&#128274; 用户登录</h3>

        <% if (error != null && !error.isEmpty()) { %>
        <div class="alert alert-campus-danger alert-campus" role="alert">
          <%= error %>
        </div>
        <% } %>

        <form method="post" action="${pageContext.request.contextPath}/login" class="form-campus">
          <div class="mb-3">
            <label for="username" class="form-label">用户名</label>
            <input type="text" class="form-control" id="username" name="username"
                   value="<%= username != null ? username : "" %>"
                   placeholder="请输入用户名" required>
          </div>
          <div class="mb-3">
            <label for="password" class="form-label">密码</label>
            <input type="password" class="form-control" id="password" name="password"
                   placeholder="请输入密码" required>
          </div>
          <div class="d-grid mb-3">
            <button type="submit" class="btn btn-campus-primary">登录</button>
          </div>
        </form>

        <div class="text-center">
          <span class="text-muted-campus">还没有账号？</span>
          <a href="<%= ctx %>/register">立即注册</a>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>