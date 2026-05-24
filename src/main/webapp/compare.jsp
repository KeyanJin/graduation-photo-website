<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%@ page import="com.keyan.graduationphoto.dao.PhotoDao" %>
<%@ page import="java.util.List" %>
<%
  String ctx = request.getContextPath();
  PhotoDao photoDao = new PhotoDao();
  List<Photo> allPhotos = photoDao.findAll();

  // 已选择的两张照片
  String id1 = request.getParameter("id1");
  String id2 = request.getParameter("id2");
  Photo photo1 = null, photo2 = null;
  if (id1 != null) {
    try { photo1 = photoDao.findById(Integer.parseInt(id1)); } catch(Exception e) {}
  }
  if (id2 != null) {
    try { photo2 = photoDao.findById(Integer.parseInt(id2)); } catch(Exception e) {}
  }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>照片对比 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <div class="page-header-campus">
    <div class="container">
      <h2>照片对比</h2>
      <p>选择不同阶段的毕业照，看看时光如何变迁</p>
    </div>
  </div>

  <div class="container py-4">
    <div class="row g-3 mb-4">
      <div class="col-md-6">
        <select class="form-select form-campus" id="select1" onchange="selectPhoto(1)">
          <option value="">— 选择第一张照片 —</option>
          <% for (Photo p : allPhotos) { %>
          <option value="<%= p.getId() %>" <%= (photo1 != null && p.getId().equals(photo1.getId())) ? "selected" : "" %>>
            <%= p.getStage() %> — <%= p.getTitle() %> (<%= p.getSchoolName() %>)
          </option>
          <% } %>
        </select>
      </div>
      <div class="col-md-6">
        <select class="form-select form-campus" id="select2" onchange="selectPhoto(2)">
          <option value="">— 选择第二张照片 —</option>
          <% for (Photo p : allPhotos) { %>
          <option value="<%= p.getId() %>" <%= (photo2 != null && p.getId().equals(photo2.getId())) ? "selected" : "" %>>
            <%= p.getStage() %> — <%= p.getTitle() %> (<%= p.getSchoolName() %>)
          </option>
          <% } %>
        </select>
      </div>
    </div>

    <% if (photo1 != null && photo2 != null) { %>
    <div class="compare-container" id="compareContainer">
      <div class="compare-before">
        <img src="<%= ctx %>/<%= photo1.getImagePath() %>"
             onerror="this.src='https://via.placeholder.com/600x800/f5f5f2/5c4a32?text=Photo1'">
        <div class="compare-label compare-label-left">
          <span class="tag-campus"><%= photo1.getStage() %></span>
          <%= photo1.getTitle() %>
        </div>
      </div>
      <div class="compare-after" id="compareAfter">
        <img src="<%= ctx %>/<%= photo2.getImagePath() %>"
             onerror="this.src='https://via.placeholder.com/600x800/f5f5f2/5c4a32?text=Photo2'">
        <div class="compare-label compare-label-right">
          <span class="tag-campus"><%= photo2.getStage() %></span>
          <%= photo2.getTitle() %>
        </div>
      </div>
      <div class="compare-slider" id="compareSlider">
        <div class="compare-line"></div>
        <div class="compare-handle" id="compareHandle">
          <svg viewBox="0 0 24 24" width="24" height="24"><path d="M8 5L2 12L8 19 M16 5L22 12L16 19" stroke="currentColor" stroke-width="3" fill="none" stroke-linecap="round" stroke-linejoin="round"/></svg>
        </div>
      </div>
    </div>
    <% } else { %>
    <div class="empty-state">
      <div class="empty-icon">
        <svg class="ai-icon ai-icon-xl" aria-hidden="true"><use href="#ai-icon-compare"/></svg>
      </div>
      <h4>选择两张毕业照开始对比</h4>
      <p>比如选一张幼儿园的，再选一张大学的，看看时光如何变迁</p>
    </div>
    <% } %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
  <script>
    function selectPhoto(num) {
      var id1 = document.getElementById('select1').value;
      var id2 = document.getElementById('select2').value;
      var url = '<%= ctx %>/compare.jsp?';
      if (num === 1 && id1) { url += 'id1=' + id1; if (id2) url += '&id2=' + id2; }
      else if (num === 2 && id2) { if (id1) url += 'id1=' + id1; url += '&id2=' + id2; }
      window.location = url;
    }

    // Split slider logic
    var container = document.getElementById('compareContainer');
    var slider = document.getElementById('compareSlider');
    var after = document.getElementById('compareAfter');
    var handle = document.getElementById('compareHandle');
    if (container && slider) {
      var dragging = false;

      function setSplit(x) {
        var rect = container.getBoundingClientRect();
        var percent = Math.max(5, Math.min(95, ((x - rect.left) / rect.width) * 100));
        after.style.clipPath = 'inset(0 0 0 ' + percent + '%)';
        slider.style.left = percent + '%';
      }

      setSplit(50);

      slider.addEventListener('mousedown', function(e) {
        e.preventDefault();
        dragging = true;
        container.style.cursor = 'ew-resize';
      });

      container.addEventListener('mousemove', function(e) {
        if (!dragging) return;
        setSplit(e.clientX);
      });

      container.addEventListener('mouseup', function() {
        dragging = false;
        container.style.cursor = '';
      });

      container.addEventListener('mouseleave', function() {
        dragging = false;
        container.style.cursor = '';
      });

      // Touch support
      container.addEventListener('touchstart', function(e) {
        dragging = true;
      }, {passive: true});

      container.addEventListener('touchmove', function(e) {
        if (!dragging) return;
        setSplit(e.touches[0].clientX);
      });

      container.addEventListener('touchend', function() {
        dragging = false;
      });
    }
  </script>
</body>
</html>
