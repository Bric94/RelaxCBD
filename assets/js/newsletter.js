document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('newsletter-modal');
    if (!modal) return;

    const storageKey = 'relaxCBD-newsletter';
    const state = JSON.parse(localStorage.getItem(storageKey)) || {};

    const closeModal = () => {
        modal.classList.remove('open');
        localStorage.setItem(storageKey, JSON.stringify({ ...state, dismissed: true }));
    };

    if (!state.dismissed && !state.subscribed) {
        setTimeout(() => modal.classList.add('open'), 2000);
    }

    modal.querySelectorAll('[data-close]').forEach(el => {
        el.addEventListener('click', closeModal);
    });

    modal.querySelector('form')?.addEventListener('submit', (e) => {
        e.preventDefault();
        localStorage.setItem(storageKey, JSON.stringify({ ...state, subscribed: true }));
        closeModal();
    });
});
