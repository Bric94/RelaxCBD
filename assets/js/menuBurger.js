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