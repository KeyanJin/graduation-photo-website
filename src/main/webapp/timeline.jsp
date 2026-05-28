<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.keyan.graduationphoto.bean.Photo" %>
<%@ page import="com.keyan.graduationphoto.bean.User" %>
<%@ page import="com.keyan.graduationphoto.dao.PhotoDao" %>
<%@ page import="com.keyan.graduationphoto.dao.LikeDao" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.stream.Collectors" %>
<%!
  // 根据教育阶段获取学制年限
  private int getStageDuration(String stage) {
    if (stage == null) return -1;
    switch (stage) {
      case "幼儿园": return 3;
      case "小学":   return 6;
      case "初中":   return 3;
      case "高中":   return 3;
      case "大学":   return 4;
      case "硕士研究生": return 3;
      case "博士研究生": return 4;
      default: return -1; // "其他"等无法推算
    }
  }

  // 根据入学年份和教育阶段计算毕业年份
  private String calcGraduationYear(String entranceYear, String stage) {
    if (entranceYear == null || entranceYear.isEmpty()) return null;
    int duration = getStageDuration(stage);
    if (duration < 0) return null;
    try {
      int year = Integer.parseInt(entranceYear.trim());
      return String.valueOf(year + duration);
    } catch (NumberFormatException e) {
      return null;
    }
  }
%>
<%
  String ctx = request.getContextPath();
  PhotoDao photoDao = new PhotoDao();
  LikeDao likeDao = new LikeDao();
  User timelineUser = (User) session.getAttribute("user");

  // 获取所有照片并按毕业年份分组
  List<Photo> allPhotos = photoDao.findAll();
  Map<String, List<Photo>> photosByYear = new LinkedHashMap<>();

  // 计算每张照片的毕业年份并收集
  Set<String> years = new TreeSet<>(Collections.reverseOrder());
  Map<Integer, String> photoGradYear = new HashMap<>();
  for (Photo p : allPhotos) {
    String gradYear = calcGraduationYear(p.getEntranceYear(), p.getStage());
    if (gradYear != null) {
      photoGradYear.put(p.getId(), gradYear);
      years.add(gradYear);
    }
  }

  // 按毕业年份分组（每组最多12张）
  for (String year : years) {
    List<Photo> yearPhotos = new ArrayList<>();
    for (Photo p : allPhotos) {
      if (year.equals(photoGradYear.get(p.getId())) && yearPhotos.size() < 12) {
        yearPhotos.add(p);
      }
    }
    if (!yearPhotos.isEmpty()) {
      List<Integer> ids = yearPhotos.stream().map(Photo::getId).collect(Collectors.toList());
      Map<Integer, Integer> counts = likeDao.getLikeCounts(ids);
      for (Photo p : yearPhotos) {
        p.setLikeCount(counts.getOrDefault(p.getId(), 0));
      }
      photosByYear.put(year, yearPhotos);
    }
  }

  // 选中的年份（默认最新年份）
  String selectedYear = request.getParameter("year");
  if (selectedYear == null || !photosByYear.containsKey(selectedYear)) {
    if (!years.isEmpty()) selectedYear = years.iterator().next();
  }

  List<Photo> displayPhotos = selectedYear != null ? photosByYear.get(selectedYear) : new ArrayList<>();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>时光机 - 青春毕业照</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="<%= ctx %>/css/style.css" rel="stylesheet">
</head>
<body>
  <%@ include file="/WEB-INF/jspf/navbar.jsp" %>

  <section class="timeline-hero">
    <div class="container text-center" style="max-width:900px;">
      <h1 class="timeline-title animate-fade-in-up"><svg class="ai-icon" style="width:48px;height:48px;vertical-align:middle;margin-right:8px;" aria-hidden="true"><use href="#ai-icon-clock"/></svg>时光机</h1>
      <p class="timeline-subtitle animate-fade-in-up animate-delay-1">拖动年份，穿梭回那些年的毕业季</p>

      <div class="timeline-year-nav animate-fade-in-up animate-delay-2">
        <% for (String year : years) { %>
        <a href="?year=<%= year %>" class="timeline-year-btn <%= year.equals(selectedYear) ? "active" : "" %>">
          <%= year %>届
        </a>
        <% } %>
      </div>

      <% if (selectedYear != null) { %>
      <div class="timeline-year-label animate-fade-in-up"><%= selectedYear %> 届 · 共 <%= displayPhotos.size() %> 张回忆</div>
      <% } %>
    </div>
  </section>

  <div class="container py-4">
    <% if (displayPhotos != null && !displayPhotos.isEmpty()) { %>
    <div class="timeline-carousel" id="timelineCarousel">
      <button class="timeline-nav timeline-prev" onclick="slideCarousel(-1)">&lsaquo;</button>
      <div class="timeline-track" id="timelineTrack">
        <% for (Photo photo : displayPhotos) { %>
        <div class="timeline-slide">
          <a href="<%= ctx %>/photo/detail?id=<%= photo.getId() %>" style="text-decoration:none;color:inherit;">
            <div class="timeline-card">
              <div class="timeline-card-img">
                <img src="<%= ctx %>/<%= photo.getImagePath() %>" alt="<%= photo.getTitle() %>"
                     onerror="this.src='https://via.placeholder.com/300x400/f5f5f2/5c4a32?text=%E6%AF%95%E4%B8%9A%E7%85%A7'">
              </div>
              <div class="timeline-card-info">
                <div class="fw-bold"><%= photo.getTitle() %></div>
                <small class="text-muted"><%= photo.getSchoolName() != null ? photo.getSchoolName() : "" %></small>
                <small class="text-muted"><%= photo.getStage() != null ? photo.getStage() : "" %></small>
              </div>
            </div>
          </a>
        </div>
        <% } %>
      </div>
      <button class="timeline-nav timeline-next" onclick="slideCarousel(1)">&rsaquo;</button>
    </div>
    <% } else { %>
    <div class="empty-state">
      <div class="empty-icon">
        <svg class="ai-icon ai-icon-xl" aria-hidden="true"><use href="#ai-icon-search"/></svg>
      </div>
      <h4>这个年份还没有毕业照</h4>
      <p>去上传你的毕业照，丰富时光记忆吧！</p>
      <% if (timelineUser != null) { %>
      <a href="<%= ctx %>/photo/upload" class="btn btn-campus-primary">上传毕业照</a>
      <% } %>
    </div>
    <% } %>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <script src="<%= ctx %>/js/main.js"></script>
  <script>
    var track = document.getElementById('timelineTrack');
    var slideIndex = 0;
    var slides = track ? track.querySelectorAll('.timeline-slide') : [];
    var visibleSlides = 4;

    function updateVisibleSlides() {
      if (window.innerWidth < 576) visibleSlides = 1;
      else if (window.innerWidth < 992) visibleSlides = 2;
      else visibleSlides = 4;
    }

    function slideCarousel(dir) {
      updateVisibleSlides();
      var maxIndex = Math.max(0, slides.length - visibleSlides);
      slideIndex = Math.max(0, Math.min(slideIndex + dir, maxIndex));
      var offset = -slideIndex * (100 / visibleSlides);
      track.style.transform = 'translateX(' + (slideIndex === 0 ? 0 : offset + '%') + ')';
    }

    window.addEventListener('resize', function() {
      updateVisibleSlides();
      slideCarousel(0);
    });

    updateVisibleSlides();
  </script>
</body>
</html>
