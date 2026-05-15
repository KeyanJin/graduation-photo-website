<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Education" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  String error = (String) request.getAttribute("error");
  List<Education> educations = (List<Education>) request.getAttribute("educations");
  String titleVal = (String) request.getAttribute("title");
  String descriptionVal = (String) request.getAttribute("description");
  String locationNameVal = (String) request.getAttribute("locationName");
  String longitudeVal = (String) request.getAttribute("longitude");
  String latitudeVal = (String) request.getAttribute("latitude");
  String educationIdVal = (String) request.getAttribute("educationId");
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>上传毕业照 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
  <style>
    #mapContainer { width: 100%; height: 400px; border-radius: 20px; overflow: hidden; border: 2px solid #c4b89e; }
    .map-info { background: rgb(247, 243, 223); padding: 8px 12px; border-radius: 12px; margin-top: 8px; font-size: 0.875rem; color: #725d42; border: 1px solid #c4b89e; }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <nav aria-label="breadcrumb">
        <ol class="breadcrumb breadcrumb-campus mb-2">
          <li class="breadcrumb-item"><a href="<%= ctx %>/photo/list">我的照片</a></li>
          <li class="breadcrumb-item active">上传照片</li>
        </ol>
      </nav>
      <h2>上传毕业照</h2>
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

            <form action="<%= ctx %>/photo/upload" method="post" enctype="multipart/form-data" class="form-campus">
              <div class="mb-3">
                <label for="title" class="form-label">标题 <span class="text-danger">*</span></label>
                <input type="text" class="form-control" id="title" name="title"
                       value="<%= titleVal != null ? titleVal : "" %>" required maxlength="100" placeholder="给照片起个名字">
              </div>

              <div class="mb-3">
                <label for="description" class="form-label">描述</label>
                <textarea class="form-control" id="description" name="description"
                          rows="3" maxlength="500" placeholder="记录这一刻的故事..."><%= descriptionVal != null ? descriptionVal : "" %></textarea>
              </div>

              <div class="mb-3">
                <label for="photoFile" class="form-label">照片文件 <span class="text-danger">*</span></label>
                <input type="file" class="form-control" id="photoFile" name="photoFile"
                       accept=".jpg,.jpeg,.png" required onchange="previewImage(this, 'imagePreview')">
                <div class="form-text">支持jpg、jpeg、png格式，最大10MB</div>
                <img id="imagePreview" src="" alt="预览" style="display:none; max-width:100%; margin-top:8px; border-radius:var(--radius-md);">
              </div>

              <div class="mb-3">
                <label for="educationId" class="form-label">教育履历 <span class="text-danger">*</span></label>
                <select class="form-select" id="educationId" name="educationId" required>
                  <option value="">请选择教育履历</option>
                  <% if (educations != null) { %>
                    <% for (Education edu : educations) { %>
                    <option value="<%= edu.getId() %>" <%= educationIdVal != null && educationIdVal.equals(String.valueOf(edu.getId())) ? "selected" : "" %>>
                      <%= edu.getStage() %> - <%= edu.getSchoolName() %> (<%= edu.getEntranceYear() %>级 <%= edu.getClassName() != null ? edu.getClassName() : "" %>)
                    </option>
                    <% } %>
                  <% } %>
                </select>
              </div>

              <div class="mb-3">
                <label for="locationName" class="form-label">拍摄位置名称</label>
                <input type="text" class="form-control" id="locationName" name="locationName"
                       value="<%= locationNameVal != null ? locationNameVal : "" %>" maxlength="200"
                       placeholder="例如：北京大学未名湖畔">
              </div>

              <div class="mb-3">
                <label class="form-label">地图选点</label>
                <div id="mapContainer"></div>
                <div class="map-info" id="mapInfo">点击地图选择拍摄位置</div>
              </div>

              <input type="hidden" id="longitude" name="longitude" value="<%= longitudeVal != null ? longitudeVal : "" %>">
              <input type="hidden" id="latitude" name="latitude" value="<%= latitudeVal != null ? latitudeVal : "" %>">

              <div class="d-grid gap-2">
                <button type="submit" class="btn btn-campus-primary">上传照片</button>
                <a href="<%= ctx %>/photo/list" class="btn btn-campus-outline">返回列表</a>
              </div>
            </form>
          </div>
        </div>
      </div>
    </div>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
  <script type="text/javascript" src="https://api.map.baidu.com/api?v=3.0&ak=OxJqLaGSS0To9StANDsFInyvn8cA0Ckm"></script>
  <script>
    var map = new BMap.Map("mapContainer");
    var defaultPoint = new BMap.Point(116.404, 39.915);
    map.centerAndZoom(defaultPoint, 12);
    map.enableScrollWheelZoom(true);
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());

    var currentMarker = null;

    var savedLng = document.getElementById("longitude").value;
    var savedLat = document.getElementById("latitude").value;
    if (savedLng && savedLat) {
      var savedPoint = new BMap.Point(parseFloat(savedLng), parseFloat(savedLat));
      currentMarker = new BMap.Marker(savedPoint);
      map.addOverlay(currentMarker);
      map.panTo(savedPoint);
      document.getElementById("mapInfo").textContent = "已选位置: 经度 " + savedLng + ", 纬度 " + savedLat;
    }

    map.addEventListener("click", function(e) {
      if (currentMarker) {
        map.removeOverlay(currentMarker);
      }
      currentMarker = new BMap.Marker(e.point);
      map.addOverlay(currentMarker);

      document.getElementById("longitude").value = e.point.lng.toFixed(6);
      document.getElementById("latitude").value = e.point.lat.toFixed(6);
      document.getElementById("mapInfo").textContent = "已选位置: 经度 " + e.point.lng.toFixed(6) + ", 纬度 " + e.point.lat.toFixed(6);

      var gc = new BMap.Geocoder();
      gc.getLocation(e.point, function(rs) {
        var addComp = rs.addressComponents;
        var addr = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
        var nameInput = document.getElementById("locationName");
        if (!nameInput.value) {
          nameInput.value = addr;
        }
      });
    });
  </script>
</body>
</html>