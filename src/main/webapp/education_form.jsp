<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Education" %>
<%
  String ctx = request.getContextPath();
  String formAction = (String) request.getAttribute("formAction");
  Education education = (Education) request.getAttribute("education");
  String error = (String) request.getAttribute("error");
  boolean isEdit = "edit".equals(formAction);
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= isEdit ? "编辑" : "新增" %>教育履历 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-campus mb-2">
          <li class="breadcrumb-item"><a href="<%= ctx %>/education?action=list">教育履历</a></li>
          <li class="breadcrumb-item active"><%= isEdit ? "编辑" : "新增" %></li>
        </ol>
      </nav>
      <h2><%= isEdit ? "&#9998; 编辑" : "&#43; 新增" %>教育履历</h2>
    </div>
  </div>

  <div class="container py-4">
    <div class="row justify-content-center">
      <div class="col-md-8">
        <div class="card card-campus">
          <div class="card-body p-4">
            <% if (error != null && !error.isEmpty()) { %>
            <div class="alert alert-campus-danger alert-campus" role="alert">
              <%= error %>
            </div>
            <% } %>

            <form action="<%= ctx %>/education" method="post" class="form-campus">
              <input type="hidden" name="action" value="<%= formAction != null ? formAction : "add" %>">
              <% if (isEdit && education != null) { %>
              <input type="hidden" name="id" value="<%= education.getId() %>">
              <% } %>

              <div class="mb-3">
                <label for="stage" class="form-label">教育阶段</label>
                <select class="form-select" id="stage" name="stage">
                  <option value="幼儿园" <%= (education != null && "幼儿园".equals(education.getStage())) ? "selected" : "" %>>幼儿园</option>
                  <option value="小学" <%= (education != null && "小学".equals(education.getStage())) ? "selected" : "" %>>小学</option>
                  <option value="初中" <%= (education != null && "初中".equals(education.getStage())) ? "selected" : "" %>>初中</option>
                  <option value="高中" <%= (education != null && "高中".equals(education.getStage())) ? "selected" : "" %>>高中</option>
                  <option value="大学" <%= (education != null && "大学".equals(education.getStage())) ? "selected" : "" %>>大学</option>
                  <option value="硕士研究生" <%= (education != null && "硕士研究生".equals(education.getStage())) ? "selected" : "" %>>硕士研究生</option>
                  <option value="博士研究生" <%= (education != null && "博士研究生".equals(education.getStage())) ? "selected" : "" %>>博士研究生</option>
                  <option value="其他" <%= (education != null && "其他".equals(education.getStage())) ? "selected" : "" %>>其他</option>
                </select>
              </div>

              <div class="mb-3">
                <label for="schoolName" class="form-label">学校名称 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="schoolName" name="schoolName"
                       value="<%= education != null && education.getSchoolName() != null ? education.getSchoolName() : "" %>"
                       required placeholder="请输入学校名称">
              </div>

              <div class="mb-3">
                <label for="entranceYear" class="form-label">入学年份</label>
                <input type="text" class="form-control" id="entranceYear" name="entranceYear"
                       value="<%= education != null && education.getEntranceYear() != null ? education.getEntranceYear() : "" %>"
                       placeholder="例如：2020">
              </div>

              <div class="mb-3">
                <label for="className" class="form-label">班级</label>
                <input type="text" class="form-control" id="className" name="className"
                       value="<%= education != null && education.getClassName() != null ? education.getClassName() : "" %>"
                       placeholder="例如：1班">
              </div>

              <div class="d-flex gap-2">
                <button type="submit" class="btn btn-campus-primary"><%= isEdit ? "保存修改" : "添加" %></button>
                <a href="<%= ctx %>/education?action=list" class="btn btn-campus-outline">返回列表</a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
</body>
</html>