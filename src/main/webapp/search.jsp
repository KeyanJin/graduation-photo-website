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
          <div class="ai-stage-icon" style="background:#f8a6b2; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-kindergarten"/></svg>
          </div>
          <h5>幼儿园</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=小学" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#f7cd67; color:#725d42;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-primary"/></svg>
          </div>
          <h5>小学</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=初中" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#82d5bb; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-middle"/></svg>
          </div>
          <h5>初中</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=高中" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#889df0; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-high"/></svg>
          </div>
          <h5>高中</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=大学" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#b77dee; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-university"/></svg>
          </div>
          <h5>大学</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=硕士研究生" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#e59266; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-master"/></svg>
          </div>
          <h5>硕士研究生</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=博士研究生" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#fc736d; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-phd"/></svg>
          </div>
          <h5>博士研究生</h5>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a href="<%= ctx %>/search/result?stage=其他" class="feature-card d-block text-decoration-none" style="color:inherit;">
          <div class="ai-stage-icon" style="background:#8ac68a; color:#fff;">
            <svg class="ai-icon" aria-hidden="true"><use href="#ai-icon-stage-other"/></svg>
          </div>
          <h5>其他</h5>
        </a>
      </div>
    </div>

    <div class="text-center mt-4">
      <a href="<%= ctx %>/search/result" class="btn btn-campus-outline btn-lg">
        <svg class="ai-icon ai-icon-md" aria-hidden="true"><use href="#ai-icon-search"/></svg> 查看全部毕业照
      </a>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>