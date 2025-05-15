document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('newsletter-modal');
    if (!modal) return;

    const userEmail = modal.dataset.userEmail || '';
    const form = document.getElementById('newsletter-form');
    const emailInput = document.getElementById('newsletter-email');
    const emailDisplay = document.getElementById('newsletter-user-email');
    const backdrop = modal.querySelector('.modal-backdrop');
    const closeBtn = modal.querySelector('.close-btn');
    const remindBtn = modal.querySelector('.btn-remind');
    const neverBtn = modal.querySelector('.btn-never');

    const storageKey = 'relaxCBD-newsletter';
    const state = JSON.parse(localStorage.getItem(storageKey)) || {};
    const SIX_MONTHS = 1000 * 60 * 60 * 24 * 180;

    const openModal = () => modal.classList.add('open');
    const closeModal = () => modal.classList.remove('open');
    const saveState = () => localStorage.setItem(storageKey, JSON.stringify(state));

    // Décide si on affiche la popup
    const shouldShow = () => {
        const now = Date.now();
        if (state.subscribed || state.dismissForever) return false;
        if (state.dismissedUntil && state.dismissedUntil > now) return false;
        return !state.shownOnce;
    };

    if (shouldShow()) {
        setTimeout(() => {
            if (userEmail) {
                form.style.display = 'none';
                emailDisplay.textContent = `Votre e-mail : ${userEmail}`;
                emailDisplay.style.display = 'block';
            }
            openModal();
            state.shownOnce = true;
            saveState();
        }, 2000);
    }

    const dismissSixMonths = () => {
        state.dismissedUntil = Date.now() + SIX_MONTHS;
        saveState();
        closeModal();
    };
    const dismissForever = () => {
        state.dismissForever = true;
        saveState();
        closeModal();
    };

    backdrop.addEventListener('click', dismissSixMonths);
    closeBtn.addEventListener('click', dismissSixMonths);
    remindBtn.addEventListener('click', dismissSixMonths);
    neverBtn.addEventListener('click', dismissForever);

    form.addEventListener('submit', e => {
        e.preventDefault();
        state.subscribed = true;
        saveState();
        form.submit();
    });
});
