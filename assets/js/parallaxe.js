const parallax = document.querySelector('.background-parallax');

let lastScrollY = 0;
let ticking = false;

function updateParallax() {
  const docHeight = document.body.scrollHeight - window.innerHeight;
  const scrollPercent = lastScrollY / docHeight;
  const maxTranslate = 100;

  const translateY = -scrollPercent * maxTranslate;
  parallax.style.transform = `translateY(${translateY}px) scale(1.2)`;

  ticking = false;
}

window.addEventListener('scroll', () => {
  lastScrollY = window.scrollY;

  if (!ticking) {
    requestAnimationFrame(updateParallax);
    ticking = true;
  }
});
