document.addEventListener('DOMContentLoaded', function () {
  initNavbar();
  initAnimations();
  initConfirmDialogs();
  initLightbox();
  initLikeButtons();
});

function initNavbar() {
  var navbar = document.querySelector('.navbar-campus');
  if (!navbar) return;

  window.addEventListener('scroll', function () {
    if (window.scrollY > 10) {
      navbar.classList.add('scrolled');
    } else {
      navbar.classList.remove('scrolled');
    }
  });
}

function initAnimations() {
  var elements = document.querySelectorAll('.animate-on-scroll');
  if (elements.length === 0) return;

  var observer = new IntersectionObserver(function (entries) {
    entries.forEach(function (entry) {
      if (entry.isIntersecting) {
        entry.target.classList.add('animate-fade-in-up');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1 });

  elements.forEach(function (el) {
    observer.observe(el);
  });
}

function initConfirmDialogs() {
  document.querySelectorAll('[data-confirm]').forEach(function (el) {
    el.addEventListener('click', function (e) {
      var message = el.getAttribute('data-confirm');
      if (!confirm(message)) {
        e.preventDefault();
      }
    });
  });
}

function previewImage(input, previewId) {
  var preview = document.getElementById(previewId);
  if (!preview || !input.files || !input.files[0]) return;

  var reader = new FileReader();
  reader.onload = function (e) {
    preview.src = e.target.result;
    preview.style.display = 'block';
  };
  reader.readAsDataURL(input.files[0]);
}

/* ========== Lightbox ========== */
function initLightbox() {
  var lightbox = document.getElementById('aiLightbox');
  if (!lightbox) {
    lightbox = createLightbox();
  }

  var photos = document.querySelectorAll('.photo-card .photo-img-wrapper img');
  if (photos.length === 0) return;

  var images = [];
  var currentIndex = 0;

  photos.forEach(function (img) {
    images.push({ src: img.src, title: img.alt || '' });
    img.parentElement.style.cursor = 'pointer';
    img.parentElement.addEventListener('click', function (e) {
      // 如果点击的是删除按钮，不打开灯箱
      if (e.target.closest('.photo-delete-form') || e.target.closest('.btn-delete')) return;
      e.preventDefault();
      e.stopPropagation();
      var index = Array.from(photos).indexOf(img);
      if (index >= 0) openLightbox(index);
    });
  });

  function openLightbox(index) {
    currentIndex = index;
    showImage();
    lightbox.classList.add('active');
    document.body.style.overflow = 'hidden';
  }

  function closeLightbox() {
    lightbox.classList.remove('active');
    document.body.style.overflow = '';
  }

  function showImage() {
    var img = lightbox.querySelector('.ai-lightbox-img');
    var counter = lightbox.querySelector('.ai-lightbox-counter');
    img.src = images[currentIndex].src;
    counter.textContent = (currentIndex + 1) + ' / ' + images.length;
  }

  function nextImage() {
    currentIndex = (currentIndex + 1) % images.length;
    showImage();
  }

  function prevImage() {
    currentIndex = (currentIndex - 1 + images.length) % images.length;
    showImage();
  }

  lightbox.addEventListener('click', function (e) {
    if (e.target === lightbox) closeLightbox();
  });

  lightbox.querySelector('.ai-lightbox-close').addEventListener('click', closeLightbox);
  lightbox.querySelector('.ai-lightbox-next').addEventListener('click', nextImage);
  lightbox.querySelector('.ai-lightbox-prev').addEventListener('click', prevImage);

  document.addEventListener('keydown', function (e) {
    if (!lightbox.classList.contains('active')) return;
    if (e.key === 'Escape') closeLightbox();
    if (e.key === 'ArrowRight') nextImage();
    if (e.key === 'ArrowLeft') prevImage();
  });
}

function createLightbox() {
  var lightbox = document.createElement('div');
  lightbox.id = 'aiLightbox';
  lightbox.className = 'ai-lightbox';
  lightbox.innerHTML =
    '<button class="ai-lightbox-close">&times;</button>' +
    '<img class="ai-lightbox-img" src="" alt="">' +
    '<button class="ai-lightbox-prev">&lsaquo;</button>' +
    '<button class="ai-lightbox-next">&rsaquo;</button>' +
    '<div class="ai-lightbox-counter"></div>';
  document.body.appendChild(lightbox);
  return lightbox;
}

/* ========== Like Buttons ========== */
function initLikeButtons() {
  document.querySelectorAll('.ai-like-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
      var photoId = btn.getAttribute('data-photo-id');
      if (!photoId) return;

      var ctxPath = btn.getAttribute('data-ctx') || '';

      fetch(ctxPath + '/photo/like', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'photoId=' + photoId
      })
      .then(function (r) { return r.json(); })
      .then(function (data) {
        if (data.liked) {
          btn.classList.add('liked');
        } else {
          btn.classList.remove('liked');
        }
        var countEl = btn.querySelector('#likeCount') || btn.querySelector('.like-count');
        if (countEl) {
          countEl.textContent = data.count > 0 ? data.count : '点赞';
        }
        // 更新同一照片在页面上的所有计数
        document.querySelectorAll('.like-count-' + photoId).forEach(function (el) {
          el.textContent = data.count;
        });
      })
      .catch(function () {});
    });
  });
}
