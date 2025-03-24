import './styles/app.scss';

console.log("JavaScriipt chargé"); // utile pour vérifier dans la console
/*
* Welcome to your app's main JavaScript file!
*
* This file will be included onto the page via the importmap() Twig function,
* which should already be in your base.html.twig.
*/
document.querySelectorAll("*").forEach((el) => {
    if (el.id === "search-input" || el.id === "search-results") {
        console.log("Element trouvé :", el);
    }
});

document.addEventListener("DOMContentLoaded", function () {
    const searchInput = document.getElementById("search-input");
    const searchResults = document.getElementById("search-results");


    if (!searchInput) return; // Vérifie que l'élément existe

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
});

document.addEventListener("DOMContentLoaded", function () {
    const sidenav = document.getElementById("mySidenav");
    const burgerMenu = document.querySelector(".burger-menu");
    const closeButton = document.querySelector(".closebtn");

    function toggleNav() {
        document.body.classList.toggle('sidenav-open');
    }

    function closeNav() {
        document.body.classList.remove('sidenav-open');
    }

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
});
console.log("Twig JS direct");

document.addEventListener("DOMContentLoaded", () => {
    console.log("DOMContentLoaded dans app.js fonctionne bien !");
});

