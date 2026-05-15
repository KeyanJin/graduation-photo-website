<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
  String iconCtx = request.getContextPath();
%>
<!-- ============================================
     Animal Island UI 风格 SVG 图标库
     使用方式: <svg class="ai-icon ai-icon-{name}"><use href="#ai-icon-{name}"/></svg>
     ============================================ -->
<svg style="position:absolute;width:0;height:0;" aria-hidden="true">
  <defs>

    <!-- 1. 毕业帽 -->
    <symbol id="ai-icon-graduation-cap" viewBox="0 0 48 48">
      <!-- 帽檐 -->
      <ellipse cx="24" cy="30" rx="16" ry="5" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      <!-- 帽顶 -->
      <path d="M8 30 L24 14 L40 30" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      <!-- 帽顶平面 -->
      <ellipse cx="24" cy="14" rx="16" ry="4" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <!-- 流苏 -->
      <path d="M38 18 L38 26" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <circle cx="38" cy="28" r="2.5" fill="currentColor"/>
    </symbol>

    <!-- 2. 相机 -->
    <symbol id="ai-icon-camera" viewBox="0 0 48 48">
      <!-- 机身 -->
      <rect x="6" y="14" width="36" height="26" rx="8" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 顶部凸起 -->
      <path d="M16 14 L18 10 L30 10 L32 14" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 镜头外圈 -->
      <circle cx="24" cy="27" r="10" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 镜头内圈 -->
      <circle cx="24" cy="27" r="6" fill="none" stroke="currentColor" stroke-width="2"/>
      <!-- 镜头中心 -->
      <circle cx="24" cy="27" r="2.5" fill="#19c8b9"/>
      <!-- 闪光灯 -->
      <rect x="32" y="16" width="6" height="4" rx="2" fill="currentColor"/>
      <!-- 按钮 -->
      <circle cx="36" cy="12" r="2" fill="currentColor"/>
    </symbol>

    <!-- 3. 放大镜 -->
    <symbol id="ai-icon-search" viewBox="0 0 48 48">
      <!-- 镜片 -->
      <circle cx="20" cy="20" r="13" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 手柄 -->
      <line x1="30" y1="30" x2="40" y2="40" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/>
      <!-- 镜片高光 -->
      <path d="M12 14 Q14 11 18 11" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" opacity="0.4"/>
    </symbol>

    <!-- 4. 地图标记 -->
    <symbol id="ai-icon-map-pin" viewBox="0 0 48 48">
      <!-- 水滴主体 -->
      <path d="M24 6 C32 6 38 12 38 20 C38 28 24 42 24 42 C24 42 10 28 10 20 C10 12 16 6 24 6 Z" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 中心圆点 -->
      <circle cx="24" cy="20" r="6" fill="#19c8b9"/>
    </symbol>

    <!-- 5. 教育/书本 -->
    <symbol id="ai-icon-education" viewBox="0 0 48 48">
      <!-- 书脊 -->
      <line x1="24" y1="10" x2="24" y2="38" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <!-- 左页 -->
      <path d="M24 10 C16 10 8 14 8 20 L8 32 C8 36 14 36 24 36" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      <!-- 右页 -->
      <path d="M24 10 C32 10 40 14 40 20 L40 32 C40 36 34 36 24 36" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
      <!-- 左页内页线 -->
      <path d="M12 20 C12 16 18 14 24 14" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" opacity="0.4"/>
      <!-- 右页内页线 -->
      <path d="M36 20 C36 16 30 14 24 14" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" opacity="0.4"/>
    </symbol>

    <!-- 6. 用户 (小动物头像) -->
    <symbol id="ai-icon-user" viewBox="0 0 48 48">
      <!-- 左耳 -->
      <circle cx="12" cy="14" r="8" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 右耳 -->
      <circle cx="36" cy="14" r="8" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 头部 -->
      <ellipse cx="24" cy="28" rx="14" ry="12" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 左眼 -->
      <circle cx="18" cy="26" r="2.5" fill="currentColor"/>
      <!-- 右眼 -->
      <circle cx="30" cy="26" r="2.5" fill="currentColor"/>
      <!-- 鼻子 -->
      <ellipse cx="24" cy="32" rx="3" ry="2" fill="currentColor"/>
      <!-- 左耳内 -->
      <circle cx="12" cy="14" r="4" fill="currentColor" opacity="0.15"/>
      <!-- 右耳内 -->
      <circle cx="36" cy="14" r="4" fill="currentColor" opacity="0.15"/>
    </symbol>

    <!-- 7. 上传 -->
    <symbol id="ai-icon-upload" viewBox="0 0 48 48">
      <!-- 底座 -->
      <path d="M6 36 L42 36 L38 42 L10 42 Z" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 箭头杆 -->
      <line x1="24" y1="32" x2="24" y2="10" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
      <!-- 箭头头部 -->
      <path d="M16 18 L24 10 L32 18" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
    </symbol>

    <!-- 8. 删除 -->
    <symbol id="ai-icon-delete" viewBox="0 0 48 48">
      <!-- 外圆 -->
      <circle cx="24" cy="24" r="16" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- X 左斜线 -->
      <line x1="16" y1="16" x2="32" y2="32" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
      <!-- X 右斜线 -->
      <line x1="32" y1="16" x2="16" y2="32" stroke="currentColor" stroke-width="3" stroke-linecap="round"/>
    </symbol>

    <!-- 9. 添加 -->
    <symbol id="ai-icon-add" viewBox="0 0 48 48">
      <!-- 横线 -->
      <line x1="10" y1="24" x2="38" y2="24" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/>
      <!-- 竖线 -->
      <line x1="24" y1="10" x2="24" y2="38" stroke="currentColor" stroke-width="3.5" stroke-linecap="round"/>
    </symbol>

    <!-- 10. 编辑 -->
    <symbol id="ai-icon-edit" viewBox="0 0 48 48">
      <!-- 铅笔主体 -->
      <path d="M34 8 L40 14 L18 36 L10 38 L12 30 Z" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 笔尖 -->
      <path d="M10 38 L14 34 L18 36" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 橡皮 -->
      <path d="M34 8 L38 4 L44 10 L40 14" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
    </symbol>

    <!-- 11. 树叶 -->
    <symbol id="ai-icon-leaf" viewBox="0 0 24 24">
      <!-- 叶片 -->
      <path d="M12 2 C18 6 20 12 12 22 C4 12 6 6 12 2 Z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/>
      <!-- 叶脉 -->
      <line x1="12" y1="6" x2="12" y2="18" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      <!-- 侧脉 -->
      <path d="M12 10 L9 8 M12 12 L15 10 M12 14 L9 13" stroke="currentColor" stroke-width="1" stroke-linecap="round"/>
    </symbol>

    <!-- 12. 小花 -->
    <symbol id="ai-icon-flower" viewBox="0 0 24 24">
      <!-- 花瓣1 -->
      <ellipse cx="12" cy="5" rx="3" ry="4" fill="currentColor"/>
      <!-- 花瓣2 -->
      <ellipse cx="19" cy="12" rx="4" ry="3" fill="currentColor"/>
      <!-- 花瓣3 -->
      <ellipse cx="12" cy="19" rx="3" ry="4" fill="currentColor"/>
      <!-- 花瓣4 -->
      <ellipse cx="5" cy="12" rx="4" ry="3" fill="currentColor"/>
      <!-- 花瓣5（右上） -->
      <ellipse cx="17" cy="7" rx="3" ry="3" fill="currentColor"/>
      <!-- 花瓣6（左下） -->
      <ellipse cx="7" cy="17" rx="3" ry="3" fill="currentColor"/>
      <!-- 花心 -->
      <circle cx="12" cy="12" r="3.5" fill="#ffcc00"/>
    </symbol>

    <!-- 13. 星星 -->
    <symbol id="ai-icon-star" viewBox="0 0 24 24">
      <!-- 胖四角星 -->
      <path d="M12 2 C13 8 16 11 22 12 C16 13 13 16 12 22 C11 16 8 13 2 12 C8 11 11 8 12 2 Z" fill="currentColor"/>
    </symbol>

    <!-- 14. 爱心 -->
    <symbol id="ai-icon-heart" viewBox="0 0 24 24">
      <!-- 胖爱心 -->
      <path d="M12 21 C12 21 2 14 2 8.5 C2 5.5 4.5 3 7.5 3 C9.5 3 11 4.2 12 5.8 C13 4.2 14.5 3 16.5 3 C19.5 3 22 5.5 22 8.5 C22 14 12 21 12 21 Z" fill="currentColor"/>
    </symbol>

    <!-- 15-22. 教育阶段图标 (64x64) -->

    <!-- 幼儿园 -->
    <symbol id="ai-icon-stage-kindergarten" viewBox="0 0 64 64">
      <!-- 小房子 -->
      <rect x="18" y="24" width="28" height="24" rx="4" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 屋顶 -->
      <path d="M14 24 L32 10 L50 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 门 -->
      <rect x="26" y="36" width="12" height="12" rx="2" fill="none" stroke="currentColor" stroke-width="2"/>
      <!-- 太阳 -->
      <circle cx="48" cy="16" r="5" fill="#f8a6b2"/>
      <path d="M48 8 L48 6 M48 26 L48 24 M40 16 L38 16 M58 16 L56 16 M42 10 L40 8 M56 24 L54 22 M42 22 L40 24 M56 10 L54 12" stroke="#f8a6b2" stroke-width="1.5" stroke-linecap="round"/>
    </symbol>

    <!-- 小学 -->
    <symbol id="ai-icon-stage-primary" viewBox="0 0 64 64">
      <!-- 书包主体 -->
      <rect x="16" y="22" width="32" height="26" rx="6" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 书包盖 -->
      <path d="M16 28 C16 20 24 16 32 16 C40 16 48 20 48 28" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 书包扣 -->
      <circle cx="28" cy="32" r="3" fill="currentColor" opacity="0.3"/>
      <circle cx="36" cy="32" r="3" fill="currentColor" opacity="0.3"/>
      <!-- 铅笔 -->
      <line x1="52" y1="12" x2="52" y2="28" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <path d="M52 12 L50 8 L54 8 Z" fill="currentColor"/>
    </symbol>

    <!-- 初中 -->
    <symbol id="ai-icon-stage-middle" viewBox="0 0 64 64">
      <!-- 黑板 -->
      <rect x="12" y="12" width="40" height="28" rx="4" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 黑板支架 -->
      <line x1="18" y1="40" x2="14" y2="52" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <line x1="46" y1="40" x2="50" y2="52" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <!-- 三角尺 -->
      <path d="M44 20 L54 34 L44 34 Z" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/>
      <!-- 粉笔字 -->
      <path d="M20 22 L32 22 M20 28 L36 28 M20 34 L28 34" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" opacity="0.4"/>
    </symbol>

    <!-- 高中 -->
    <symbol id="ai-icon-stage-high" viewBox="0 0 64 64">
      <!-- 毕业帽 -->
      <ellipse cx="32" cy="38" rx="14" ry="4" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <path d="M18 38 L32 20 L46 38" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <path d="M44 26 L44 34" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <!-- 奖杯 -->
      <path d="M14 16 C14 24 18 28 24 28 L24 34 L18 38 L30 38 L24 34 L24 28 C30 28 34 24 34 16" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <line x1="12" y1="16" x2="36" y2="16" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
    </symbol>

    <!-- 大学 -->
    <symbol id="ai-icon-stage-university" viewBox="0 0 64 64">
      <!-- 建筑主体 -->
      <rect x="16" y="28" width="32" height="22" rx="3" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 圆顶 -->
      <path d="M16 28 C16 16 24 12 32 12 C40 12 48 16 48 28" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 柱子 -->
      <line x1="22" y1="28" x2="22" y2="50" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
      <line x1="32" y1="28" x2="32" y2="50" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
      <line x1="42" y1="28" x2="42" y2="50" stroke="currentColor" stroke-width="2" stroke-linecap="round"/>
      <!-- 门 -->
      <path d="M28 50 L28 40 C28 36 36 36 36 40 L36 50" fill="none" stroke="currentColor" stroke-width="2"/>
      <!-- 橄榄枝左 -->
      <path d="M8 32 Q4 28 8 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      <path d="M8 36 Q4 32 8 28" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      <!-- 橄榄枝右 -->
      <path d="M56 32 Q60 28 56 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
      <path d="M56 36 Q60 32 56 28" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/>
    </symbol>

    <!-- 硕士 -->
    <symbol id="ai-icon-stage-master" viewBox="0 0 64 64">
      <!-- 学位袍 -->
      <path d="M24 12 L40 12 L44 22 L44 50 L20 50 L20 22 Z" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 领口 -->
      <path d="M24 12 L32 22 L40 12" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/>
      <!-- 卷轴 -->
      <rect x="10" y="26" width="8" height="20" rx="2" fill="none" stroke="currentColor" stroke-width="2" transform="rotate(-15 14 36)"/>
      <path d="M10 30 L18 28 M10 42 L18 40" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" transform="rotate(-15 14 36)"/>
    </symbol>

    <!-- 博士 -->
    <symbol id="ai-icon-stage-phd" viewBox="0 0 64 64">
      <!-- 显微镜底座 -->
      <rect x="20" y="42" width="24" height="8" rx="3" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 显微镜臂 -->
      <path d="M26 42 L26 24 L38 24 L38 36" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 显微镜筒 -->
      <rect x="34" y="14" width="8" height="16" rx="2" fill="none" stroke="currentColor" stroke-width="2.5"/>
      <!-- 目镜 -->
      <circle cx="38" cy="12" r="4" fill="none" stroke="currentColor" stroke-width="2"/>
      <!-- 物镜 -->
      <path d="M36 30 L40 30 L38 36" fill="none" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/>
      <!-- 书本 -->
      <rect x="10" y="34" width="14" height="10" rx="2" fill="none" stroke="currentColor" stroke-width="2"/>
      <line x1="10" y1="39" x2="24" y2="39" stroke="currentColor" stroke-width="1.5"/>
    </symbol>

    <!-- 其他 -->
    <symbol id="ai-icon-stage-other" viewBox="0 0 64 64">
      <!-- 文件夹 -->
      <path d="M12 18 L12 48 L52 48 L52 22 L32 22 L28 18 Z" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linejoin="round"/>
      <!-- 星星 -->
      <path d="M38 12 L40 18 L46 18 L41 22 L43 28 L38 24 L33 28 L35 22 L30 18 L36 18 Z" fill="currentColor"/>
      <!-- 问号 -->
      <path d="M26 14 C22 14 20 17 20 20 C20 23 24 25 24 28 L24 32" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round"/>
      <circle cx="24" cy="36" r="2" fill="currentColor"/>
    </symbol>

    <!-- 23. 首页主视觉 — 毕业庆祝场景 -->
    <symbol id="ai-hero-graduation" viewBox="0 0 400 400">
      <!-- 草地 -->
      <ellipse cx="200" cy="360" rx="160" ry="30" fill="#7DC395"/>
      <!-- 左侧小动物 -->
      <ellipse cx="120" cy="300" rx="30" ry="28" fill="#f8a6b2"/>
      <circle cx="110" cy="290" r="4" fill="#794f27"/>
      <circle cx="130" cy="290" r="4" fill="#794f27"/>
      <ellipse cx="120" cy="300" rx="4" ry="3" fill="#794f27"/>
      <circle cx="105" cy="278" r="14" fill="#f8a6b2"/>
      <circle cx="135" cy="278" r="14" fill="#f8a6b2"/>
      <!-- 右侧小动物 -->
      <ellipse cx="280" cy="300" rx="30" ry="28" fill="#889df0"/>
      <circle cx="270" cy="290" r="4" fill="#794f27"/>
      <circle cx="290" cy="290" r="4" fill="#794f27"/>
      <ellipse cx="280" cy="300" rx="4" ry="3" fill="#794f27"/>
      <circle cx="265" cy="278" r="14" fill="#889df0"/>
      <circle cx="295" cy="278" r="14" fill="#889df0"/>
      <!-- 中间小动物（扔帽子） -->
      <ellipse cx="200" cy="310" rx="32" ry="30" fill="#f7cd67"/>
      <circle cx="190" cy="298" r="4" fill="#794f27"/>
      <circle cx="210" cy="298" r="4" fill="#794f27"/>
      <ellipse cx="200" cy="310" rx="4" ry="3" fill="#794f27"/>
      <circle cx="185" cy="285" r="15" fill="#f7cd67"/>
      <circle cx="215" cy="285" r="15" fill="#f7cd67"/>
      <!-- 毕业帽（在空中） -->
      <ellipse cx="200" cy="210" rx="20" ry="6" fill="#794f27"/>
      <path d="M180 210 L200 180 L220 210" fill="none" stroke="#794f27" stroke-width="4" stroke-linejoin="round"/>
      <path d="M218 190 L218 205" stroke="#794f27" stroke-width="3" stroke-linecap="round"/>
      <circle cx="218" cy="208" r="3" fill="#794f27"/>
      <!-- 彩带 -->
      <path d="M150 200 Q140 180 160 170" fill="none" stroke="#f8a6b2" stroke-width="3" stroke-linecap="round"/>
      <path d="M250 200 Q260 180 240 170" fill="none" stroke="#82d5bb" stroke-width="3" stroke-linecap="round"/>
      <path d="M200 160 Q220 140 200 130" fill="none" stroke="#ffcc00" stroke-width="3" stroke-linecap="round"/>
      <!-- 花朵装饰 -->
      <circle cx="100" cy="360" r="4" fill="#f8a6b2"/>
      <circle cx="96" cy="356" r="4" fill="#f8a6b2"/>
      <circle cx="104" cy="356" r="4" fill="#f8a6b2"/>
      <circle cx="96" cy="364" r="4" fill="#f8a6b2"/>
      <circle cx="104" cy="364" r="4" fill="#f8a6b2"/>
      <circle cx="100" cy="360" r="2" fill="#ffcc00"/>
      <circle cx="300" cy="360" r="4" fill="#82d5bb"/>
      <circle cx="296" cy="356" r="4" fill="#82d5bb"/>
      <circle cx="304" cy="356" r="4" fill="#82d5bb"/>
      <circle cx="296" cy="364" r="4" fill="#82d5bb"/>
      <circle cx="304" cy="364" r="4" fill="#82d5bb"/>
      <circle cx="300" cy="360" r="2" fill="#ffcc00"/>
    </symbol>

  </defs>
</svg>
