document.addEventListener('DOMContentLoaded', () => {
    const forms = document.querySelectorAll('.js-add-to-cart');

    if (!forms.length) return;

    const popup = document.getElementById('js-cart-popup');
    if (!popup) return;

    const msgEl = document.getElementById('js-cart-popup-message');
    const btnView = document.getElementById('js-cart-popup-view');
    const btnCont = document.getElementById('js-cart-popup-continue');

    forms.forEach((form) => {
        form.addEventListener('submit', async (e) => {
            e.preventDefault();

            const selectedWeight = form.querySelector('select[name="selectedWeight"]');
            if (selectedWeight && !selectedWeight.value) {
                console.warn('Veuillez sélectionner un poids.');
                return;
            }

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

            setTimeout(() => {
                popup.classList.remove('open');
            }, 10000);
        });
    });
});
