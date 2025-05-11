// assets/app.js (or wherever)
document.addEventListener('DOMContentLoaded', () => {
    const form = document.querySelector('.js-add-to-cart');
    if (!form) return;

    const popup = document.getElementById('js-cart-popup');
    const msgEl = document.getElementById('js-cart-popup-message');
    const btnView = document.getElementById('js-cart-popup-view');
    const btnCont = document.getElementById('js-cart-popup-continue');

    form.addEventListener('submit', async e => {
        e.preventDefault();
        const res = await fetch(form.action, {
            method: 'POST',
            headers: { 'X-Requested-With': 'XMLHttpRequest' },
            body: new FormData(form),
        });
        if (!res.ok) {
            return window.location = form.action;
        }
        const data = await res.json();
        msgEl.textContent = data.message;
        btnView.onclick = () => window.location = data.cartUrl;
        btnCont.onclick = () => popup.classList.remove('open');
        popup.classList.add('open');
    });
});
