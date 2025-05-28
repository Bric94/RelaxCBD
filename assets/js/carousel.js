function isMobile() {
    return window.innerWidth <= 768;
}

function cleanupCarousel(slider) {
    slider.querySelectorAll('.clone').forEach(c => c.remove());
    slider.style.transition = '';
    slider.style.transform = '';
    delete slider.dataset.carouselInitialized;
}

function initCarousel(containerSelector) {
    const container = document.querySelector(containerSelector);
    if (!container) return;
    const slider = container.querySelector('.carousel-wrapper');
    if (!slider) return;
    if (!isMobile()) {
        if (slider.dataset.carouselInitialized) {
            cleanupCarousel(slider);
        }
        return;
    }
    if (slider.dataset.carouselInitialized) return;
    let slides = Array.from(slider.children);
    if (slides.length < 2) return;
    const firstClone = slides[0].cloneNode(true);
    const lastClone = slides[slides.length - 1].cloneNode(true);
    firstClone.classList.add('clone');
    lastClone.classList.add('clone');
    slider.appendChild(firstClone);
    slider.insertBefore(lastClone, slides[0]);
    slider.dataset.carouselInitialized = 'true';
    let currentIndex = 1;
    function updateCarousel(instant = false) {
        const slideWidth = slider.children[0].getBoundingClientRect().width;
        slider.style.transition = instant ? 'none' : 'transform 0.4s ease-in-out';
        slider.style.transform = `translateX(-${currentIndex * slideWidth}px)`;
    }
    function moveSlide(step) {
        currentIndex += step;
        updateCarousel();
        setTimeout(() => {
            const total = slider.children.length;
            if (currentIndex >= total - 1) {
                currentIndex = 1;
                updateCarousel(true);
            }
            if (currentIndex <= 0) {
                currentIndex = total - 2;
                updateCarousel(true);
            }
        }, 400);
    }
    container.querySelector('.prev').addEventListener('click', () => moveSlide(-1));
    container.querySelector('.next').addEventListener('click', () => moveSlide(1));
    let startX = 0;
    slider.addEventListener('touchstart', e => startX = e.touches[0].clientX);
    slider.addEventListener('touchend', e => {
        const diffX = e.changedTouches[0].clientX - startX;
        if (Math.abs(diffX) > 50) {
            diffX > 0 ? moveSlide(-1) : moveSlide(1);
        }
    });
    updateCarousel(true);
}

function refreshCarousels() {
    initCarousel('.product-slider-container');
    initCarousel('.cart-slider-container');
}

window.addEventListener('DOMContentLoaded', refreshCarousels);
window.addEventListener('resize', refreshCarousels);
