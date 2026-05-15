<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>搜索毕业照 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <h2>搜索毕业照</h2>
      <p>选择教育阶段，寻找珍贵的毕业回忆</p>
    </div>
  </div>

  <div class="container py-4">
    <div class="row g-4 justify-content-center" style="max-width: 900px; margin: 0 auto;">
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=幼儿园" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-primary">&#127979;</div>
          <h5>幼儿园</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=小学" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-secondary">&#128218;</div>
          <h5>小学</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=初中" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-accent">&#127890;</div>
          <h5>初中</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=高中" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-primary">&#127891;</div>
          <h5>高中</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=大学" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-secondary">&#127963;&#65039;</div>
          <h5>大学</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=硕士研究生" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-accent">&#128220;</div>
          <h5>硕士研究生</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=博士研究生" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-primary">&#128300;</div>
          <h5>博士研究生</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=其他" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="feature-icon feature-icon-secondary">&#128193;</div>
          <h5>其他</h5>
        </a>
      </div>
    </div>

    <div class="text-center mt-4">
      <a href="<%= ctx %>/search/result" class="btn btn-campus-outline btn-lg">查看全部毕业照</a>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>