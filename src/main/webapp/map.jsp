<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>毕业照地图 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
  <style>
    #map-container { width: 100%; height: calc(100vh - 56px); }
    .photo-info-window { padding: 8px; max-width: 320px; }
    .photo-info-window .photo-thumb { width: 100%; max-height: 180px; object-fit: cover; border-radius: 6px; margin-bottom: 8px; }
    .photo-info-window .photo-title { font-size: 15px; font-weight: 600; color: #725d42; margin-bottom: 6px; }
    .photo-info-window .photo-meta { font-size: 12px; color: #8a7b66; line-height: 1.8; }
    .photo-info-window .photo-meta span { display: inline-block; background: rgb(247, 243, 223); padding: 1px 8px; border-radius: 8px; margin: 2px 2px 2px 0; }
    .photo-info-window .photo-link { display: inline-block; margin-top: 8px; color: #19c8b9; font-size: 13px; text-decoration: none; font-weight: 600; }
    .photo-info-window .photo-link:hover { text-decoration: underline; }
    .loading-overlay {
      position: absolute; top: 56px; left: 0; right: 0; bottom: 0; z-index: 2000;
      background: rgba(248, 248, 240, 0.95); display: flex; align-items: center; justify-content: center;
      font-size: 16px; color: #19c8b9; font-weight: 600;
    }
    .loading-overlay.hidden { display: none; }
  </style>
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div style="position: relative;">
    <div id="loading" class="loading-overlay">正在加载地图数据...</div>
    <div id="map-container"></div>
  </div>

  <script type="text/javascript" src="https://api.map.baidu.com/api?v=3.0&ak=OxJqLaGSS0To9StANDsFInyvn8cA0Ckm"></script>
  <script src="<%= ctx %>/js/main.js"></script>
  <script>
    var map = new BMap.Map("map-container");
    map.centerAndZoom(new BMap.Point(116.404, 39.915), 6);
    map.enableScrollWheelZoom(true);
    map.addControl(new BMap.NavigationControl());
    map.addControl(new BMap.ScaleControl());
    map.addControl(new BMap.MapTypeControl());

    var contextPath = '<%= ctx %>';
    var loadingEl = document.getElementById('loading');

    var xhr = new XMLHttpRequest();
    xhr.open('GET', contextPath + '/map?action=data', true);
    xhr.onreadystatechange = function() {
      if (xhr.readyState !== 4) return;
      loadingEl.classList.add('hidden');
      if (xhr.status !== 200) {
        return;
      }
      var photos;
      try {
        photos = JSON.parse(xhr.responseText);
      } catch(e) {
        return;
      }
      if (!photos || photos.length === 0) return;
      renderMarkers(photos);
    };
    xhr.send();

    function renderMarkers(photos) {
      var points = [];
      for (var i = 0; i < photos.length; i++) {
        var p = photos[i];
        var point = new BMap.Point(p.longitude, p.latitude);
        points.push(point);

        (function(photo, pt) {
          var marker = new BMap.Marker(pt);
          map.addOverlay(marker);

          marker.addEventListener('click', function() {
            var content = buildInfoContent(photo);
            var infoWindow = new BMap.InfoWindow(content, {
              width: 320,
              height: 0,
              enableMessage: false
            });
            map.openInfoWindow(infoWindow, pt);
          });
        })(p, point);
      }

      if (points.length > 0) {
        map.setViewport(points);
      }
    }

    function buildInfoContent(photo) {
      var imgHtml = '';
      if (photo.imagePath) {
        imgHtml = '<img class="photo-thumb" src="' + contextPath + '/' + photo.imagePath + '" alt="' + escapeHtml(photo.title) + '" onerror="this.style.display=\'none\'">';
      }
      var meta = '';
      if (photo.schoolName) meta += '<span>' + escapeHtml(photo.schoolName) + '</span>';
      if (photo.stage) meta += '<span>' + escapeHtml(photo.stage) + '</span>';
      if (photo.entranceYear) meta += '<span>' + escapeHtml(photo.entranceYear) + '级</span>';
      if (photo.className) meta += '<span>' + escapeHtml(photo.className) + '</span>';
      if (photo.locationName) meta += '<span>' + escapeHtml(photo.locationName) + '</span>';

      return '<div class="photo-info-window">' +
        imgHtml +
        '<div class="photo-title">' + escapeHtml(photo.title || '未命名') + '</div>' +
        '<div class="photo-meta">' + meta + '</div>' +
        '<a class="photo-link" href="' + contextPath + '/photo/detail?id=' + photo.id + '">查看详情 &raquo;</a>' +
        '</div>';
    }

    function escapeHtml(str) {
      if (!str) return '';
      return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
    }
  </script>
</body>
</html>