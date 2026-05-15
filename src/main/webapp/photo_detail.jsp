<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%
  String ctx = request.getContextPath();
  Photo photo = (Photo) request.getAttribute("photo");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><%= photo != null ? photo.getTitle() : "照片详情" %> - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
  <style>
    #mapContainer { width: 100%; height: 300px; border-radius: 20px; overflow: hidden; border: 2px solid #c4b89e; }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="container py-4">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb breadcrumb-campus">
        <li class="breadcrumb-item"><a href="<%= ctx %>/photo/list">我的照片</a></li>
        <li class="breadcrumb-item active"><%= photo != null ? photo.getTitle() : "照片详情" %></li>
      </ol>
    </nav>

    <% if (photo != null) { %>
    <div class="row">
      <div class="col-lg-8">
        <div class="photo-detail-img">
          <img src="<%= ctx %>/<%= photo.getImagePath() %>" alt="<%= photo.getTitle() %>"
               onerror="this.src='https://via.placeholder.com/800x600/7EC8E3/FFFFFF?text=毕业照'">
        </div>
      </div>

      <div class="col-lg-4">
        <div class="card card-campus mb-4">
          <div class="card-body">
            <h4 class="mb-3"><%= photo.getTitle() %></h4>

            <% if (photo.getDescription() != null && !photo.getDescription().isEmpty()) { %>
            <p class="text-muted-campus mb-3"><%= photo.getDescription() %></p>
            <% } %>

            <hr>

            <div class="mb-2">
              <span class="fw-bold me-2">教育阶段</span>
              <span class="tag-campus"><%= photo.getStage() != null ? photo.getStage() : "" %></span>
            </div>
            <div class="mb-2">
              <span class="fw-bold me-2">学校</span>
              <span><%= photo.getSchoolName() != null ? photo.getSchoolName() : "" %></span>
            </div>
            <div class="mb-2">
              <span class="fw-bold me-2">年级班级</span>
              <span><%= photo.getEntranceYear() != null ? photo.getEntranceYear() + "级" : "" %> <%= photo.getClassName() != null ? photo.getClassName() : "" %></span>
            </div>

            <% if (photo.getLocationName() != null && !photo.getLocationName().isEmpty()) { %>
            <div class="mb-2">
              <span class="fw-bold me-2">拍摄位置</span>
              <span><%= photo.getLocationName() %></span>
            </div>
            <% } %>

            <div class="mb-2">
              <span class="fw-bold me-2">上传时间</span>
              <span class="text-muted-campus"><%= photo.getUploadTime() != null ? photo.getUploadTime() : "" %></span>
            </div>
          </div>
        </div>

        <% if (photo.getLongitude() != null && photo.getLatitude() != null) { %>
        <div class="card card-campus mb-4">
          <div class="card-body p-0">
            <div id="mapContainer"></div>
          </div>
        </div>
        <% } %>

        <a href="<%= ctx %>/photo/list" class="btn btn-campus-outline w-100">返回列表</a>
      </div>
    </div>
    <% } else { %>
    <div class="empty-state">
      <div class="empty-icon">&#128247;</div>
      <h4>照片不存在</h4>
      <p>该照片可能已被删除</p>
      <a href="<%= ctx %>/photo/list" class="btn btn-campus-primary">返回列表</a>
    </div>
    <% } %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
  <% if (photo != null && photo.getLongitude() != null && photo.getLatitude() != null) { %>
  <script type="text/javascript" src="https://api.map.baidu.com/api?v=3.0&ak=OxJqLaGSS0To9StANDsFInyvn8cA0Ckm"></script>
  <script>
    var map = new BMap.Map("mapContainer");
    var point = new BMap.Point(<%= photo.getLongitude() %>, <%= photo.getLatitude() %>);
    map.centerAndZoom(point, 15);
    map.enableScrollWheelZoom(true);
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());

    var marker = new BMap.Marker(point);
    map.addOverlay(marker);

    <% if (photo.getLocationName() != null && !photo.getLocationName().isEmpty()) { %>
    var infoWindow = new BMap.InfoWindow("<%= photo.getLocationName() %>");
    marker.addEventListener("click", function() {
      map.openInfoWindow(infoWindow, point);
    });
    <% } %>
  </script>
  <% } %>
</body>
</html>