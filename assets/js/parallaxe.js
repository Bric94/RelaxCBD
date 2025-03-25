const parallax = document.querySelector('.background-parallax');

let lastScrollY = 0;
let ticking = false;

function updateParallax() {
    const docHeight = document.body.scrollHeight - window.innerHeight;
    const scrollPercent = lastScrollY / docHeight;
    const maxTranslate = 100;

    // 🔁 Inversion ici
    const translateY = -scrollPercent * maxTranslate;

    // 🔍 Zoom qui se réduit doucement au scroll
    const scale = 1.2 - scrollPercent * 0.1;

    parallax.style.transform = `translateY(${translateY}px) scale(${scale})`;

    ticking = false;
}

window.addEventListener('scroll', () => {
    lastScrollY = window.scrollY;

    if (!ticking) {
        requestAnimationFrame(updateParallax);
        ticking = true;
    }
});
