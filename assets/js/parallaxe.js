const parallax = document.querySelector('.background-parallax');

let lastScrollY = 0;
let ticking = false;

function updateParallax() {

    if (window.innerWidth <= 768) {
        // Désactive le parallaxe sur mobile
        parallax.style.transform = 'none';
        return;
    }
    const docHeight = document.body.scrollHeight - window.innerHeight;
    const scrollPercent = lastScrollY / docHeight;
    const maxTranslate = 100;

    const translateY = -scrollPercent * maxTranslate;
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

window.addEventListener('resize', updateParallax);

updateParallax();