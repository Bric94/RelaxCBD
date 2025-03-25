import './styles/app.scss';
import './js/parallaxe.js'

console.log("JavaScript chargé");

// Attendre que le DOM soit prêt
document.addEventListener("DOMContentLoaded", () => {
    console.log("DOMContentLoaded déclenché depuis app.js");

    /*** 🔍 FONCTIONNALITÉ DE RECHERCHE AJAX ***/
    const searchInput = document.getElementById("search-input");
    const searchResults = document.getElementById("search-results");

    if (searchInput) {
        searchInput.addEventListener("keyup", function () {
            let query = searchInput.value.trim();

            if (query.length < 2) {
                searchResults.innerHTML = "";
                searchResults.style.display = "none";
                return;
            }

            fetch(`/search?q=${encodeURIComponent(query)}`, {
                headers: { "X-Requested-With": "XMLHttpRequest" }
            })
                .then(response => response.json())
                .then(data => {
                    searchResults.innerHTML = "";
                    searchResults.style.display = data.length ? "block" : "none";

                    data.forEach(product => {
                        let div = document.createElement("div");
                        div.innerHTML = `
                            <img src="${product.image}" width="50" height="50" style="margin-right: 10px;">
                            <strong>${product.name}</strong> - ${product.price}€
                        `;
                        div.classList.add("search-item");
                        div.onclick = () => window.location.href = `/products/${product.id}`;
                        searchResults.appendChild(div);
                    });
                });
        });

        document.addEventListener("click", function (event) {
            if (!searchInput.contains(event.target) && !searchResults.contains(event.target)) {
                searchResults.style.display = "none";
            }
        });
    }

    /*** 🍔 MENU BURGER ***/
    const sidenav = document.getElementById("mySidenav");
    const burgerMenu = document.querySelector(".burger-menu");
    const closeButton = document.querySelector(".closebtn");

    function toggleNav() {
        sidenav.classList.toggle('open');
    }

    function closeNav() {
        /* document.body.classList.remove('sidenav-open'); */
        sidenav.classList.remove('open');
    }

    if (burgerMenu && sidenav && closeButton) {
        burgerMenu.addEventListener("click", function (event) {
            event.stopPropagation();
            toggleNav();
        });

        closeButton.addEventListener("click", closeNav);

        document.addEventListener("click", function (event) {
            if (!sidenav.contains(event.target) && !burgerMenu.contains(event.target)) {
                closeNav();
            }
        });

        document.querySelectorAll("#mySidenav a").forEach(link => {
            link.addEventListener("click", closeNav);
        });
    }

    /*** 🖼️ CARROUSELS PRODUITS ET PANIER ***/
    function setupCarousel(containerSelector) {
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
    }

    setupCarousel(".product-slider-container");
    setupCarousel(".cart-slider-container");
});
