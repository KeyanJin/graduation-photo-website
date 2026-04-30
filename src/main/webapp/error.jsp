<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page isErrorPage="true" %>
<%
  String ctx = request.getContextPath();
  Integer statusCode = (Integer) request.getAttribute("jakarta.servlet.error.status_code");
  String errorMsg = (String) request.getAttribute("jakarta.servlet.error.message");
  if (statusCode == null) statusCode = 500;
  if (errorMsg == null || errorMsg.isEmpty()) {
    if (statusCode == 404) errorMsg = "抱歉，您访问的页面不存在";
    else if (statusCode == 500) errorMsg = "服务器开小差了，请稍后再试";
    else errorMsg = "发生了未知错误";
  }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>出错了 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body class="error-page">
  <div class="error-content">
    <div class="error-code"><%= statusCode %></div>
    <div class="error-message"><%= errorMsg %></div>
    <a href="<%= ctx %>/index.jsp" class="btn btn-campus-primary btn-lg">返回首页</a>
  </div>
</body>
</html>