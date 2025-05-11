/* Javascript AJAX */
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

document.querySelectorAll('.filter-select').forEach(select => {
    // Au clic, on ajoute .open juste avant l'ouverture native du menu
    select.addEventListener('mousedown', () => {
        select.classList.add('open');
    });
    // Dès qu'on perd le focus (le menu se ferme), on retire .open
    select.addEventListener('blur', () => {
        select.classList.remove('open');
    });
});

