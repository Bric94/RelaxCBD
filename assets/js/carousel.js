/*** 🖼️ CARROUSELS PRODUITS ET PANIER ***/
function isMobile() {
    return window.innerWidth <= 768;
}

function setupCarousel(containerSelector) {
    if (!isMobile()) return; 

    const container = document.querySelector(containerSelector);
    if (!container) return;

    const slider = container.querySelector(".carousel-wrapper");
    let slides = Array.from(slider.children);
    const totalSlides = slides.length;
    if (totalSlides < 2) return;

    const firstClone = slides[0].cloneNode(true);
    const lastClone = slides[slides.length - 1].cloneNode(true);
    firstClone.classList.add("clone");
    lastClone.classList.add("clone");
    slider.appendChild(firstClone);
    slider.insertBefore(lastClone, slides[0]);

    slides = Array.from(slider.children);
    const slideWidth = slides[0].getBoundingClientRect().width;
    let currentIndex = 1;

    function updateCarousel(instant = false) {
        slider.style.transition = instant ? "none" : "transform 0.4s ease-in-out";
        slider.style.transform = `translateX(-${currentIndex * slideWidth}px)`;
    }

    function moveSlide(step) {
        currentIndex += step;
        updateCarousel();

        setTimeout(() => {
            if (currentIndex >= slides.length - 1) {
                currentIndex = 1;
                updateCarousel(true);
            }
            if (currentIndex <= 0) {
                currentIndex = slides.length - 2;
                updateCarousel(true);
            }
        }, 400);
    }

    container.querySelector(".prev").addEventListener("click", () => moveSlide(-1));
    container.querySelector(".next").addEventListener("click", () => moveSlide(1));

    updateCarousel(true);

    let startX = 0;
    let endX = 0;

    slider.addEventListener("touchstart", (e) => {
        startX = e.touches[0].clientX;
    });

    slider.addEventListener("touchend", (e) => {
        endX = e.changedTouches[0].clientX;
        const diffX = endX - startX;

        if (Math.abs(diffX) > 50) {
            diffX > 0 ? moveSlide(-1) : moveSlide(1);
        }
    });
}

// Mobile
window.addEventListener("DOMContentLoaded", () => {
    if (window.innerWidth <= 768) {
        setupCarousel(".product-slider-container");
        setupCarousel(".cart-slider-container");
    }
});