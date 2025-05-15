document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('newsletter-modal');
    if (!modal) return;

    const storageKey = 'relaxCBD-newsletter';
    const state = JSON.parse(localStorage.getItem(storageKey)) || {};
    const SIX_MONTHS = 1000 * 60 * 60 * 24 * 180;

    const backdrop = modal.querySelector('.modal-backdrop');
    const closeBtn = modal.querySelector('.modal-close');
    const form = modal.querySelector('form');
    const actionsContainer = modal.querySelector('.newsletter-actions');

    const openModal = () => modal.classList.add('open');
    const closeModal = () => modal.classList.remove('open');
    const saveState = () => localStorage.setItem(storageKey, JSON.stringify(state));

    const shouldShowModal = () => {
        const now = Date.now();
        if (state.subscribed || state.dismissForever) return false;
        if (state.dismissedUntil && state.dismissedUntil > now) return false;
        return !state.shownOnce;
    };

    if (shouldShowModal()) {
        setTimeout(openModal, 2000);
        state.shownOnce = true;
        saveState();
    }

    const dismissForSixMonths = () => {
        state.dismissedUntil = Date.now() + SIX_MONTHS;
        saveState();
        closeModal();
    };

    const dismissForever = () => {
        state.dismissForever = true;
        saveState();
        closeModal();
    };

    const subscribeNewsletter = (e) => {
        e.preventDefault();
        state.subscribed = true;
        saveState();
        closeModal();
    };

    backdrop.addEventListener('click', dismissForSixMonths);
    closeBtn.addEventListener('click', dismissForSixMonths);
    form?.addEventListener('submit', subscribeNewsletter);

    if (actionsContainer) {
        actionsContainer.querySelector('.btn-subscribe')?.addEventListener('click', () => form.requestSubmit());
        actionsContainer.querySelector('.btn-remind-later')?.addEventListener('click', dismissForSixMonths);
        actionsContainer.querySelector('.btn-dismiss-forever')?.addEventListener('click', dismissForever);
    }
});
