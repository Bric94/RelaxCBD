import './styles/app.scss';

import './js/carousel.js';
import './js/flashMessage.js';
import './js/home.js';
import './js/map.js';
import './js/menuBurger.js';
import './js/navOverflow.js';
import './js/newsletter.js';
import './js/parallaxe.js';
import './js/searchProduct.js';
import './js/selectFoldBack.js';

import { initNavOverflow } from './js/navOverflow.js';
console.log("JavaScript chargé");

// Attendre que le DOM soit prêt
document.addEventListener("DOMContentLoaded", () => {
    console.log("DOMContentLoaded déclenché depuis app.js");
    initNavOverflow();
});
