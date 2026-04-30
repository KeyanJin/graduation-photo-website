document.addEventListener('DOMContentLoaded', function () {
  initNavbar();
  initAnimations();
  initConfirmDialogs();
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