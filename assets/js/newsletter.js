document.addEventListener('DOMContentLoaded', () => {
    const modal = document.getElementById('newsletter-modal');
    if (!modal) return;

    const userEmail = modal.dataset.userEmail || '';
    const form = document.getElementById('newsletter-form');
    const emailInput = document.getElementById('newsletter-email');
    const emailDisp = document.getElementById('newsletter-user-email');
    const closeBtn = modal.querySelector('.newsletter-modal__close');
    const remindBtn = modal.querySelector('.btn-remind');
    const neverBtn = modal.querySelector('.btn-never');
    const msgBox = document.createElement('div'); // Ajouté pour feedback

    msgBox.style.marginTop = "0.75rem";
    msgBox.style.minHeight = "1.2em";
    msgBox.style.fontWeight = "bold";
    msgBox.style.fontSize = "1rem";
    msgBox.style.color = "#bd2a2a";
    msgBox.style.display = "none";

    // Place le message juste avant le bloc d'actions
    const actions = modal.querySelector('.newsletter-modal__actions');
    if (actions) {
        actions.parentNode.insertBefore(msgBox, actions);
    }

    const KEY = 'relaxCBD-newsletter';
    const SIX_MONTHS = 1000 * 60 * 60 * 24 * 180;
    const state = JSON.parse(localStorage.getItem(KEY)) || {};

    const open = () => modal.classList.add('open');
    const close = () => {
        modal.classList.remove('open');
        msgBox.style.display = "none";
    }

    const save = () => localStorage.setItem(KEY, JSON.stringify(state));

    const shouldShow = () => {
        const now = Date.now();
        if (state.subscribed || state.dismissForever) return false;
        if (state.dismissedUntil && state.dismissedUntil > now) return false;
        return true;
    };

    if (shouldShow()) {
        setTimeout(() => {
            if (userEmail) {
                emailDisp.textContent = `Votre e-mail : ${userEmail}`;
                emailDisp.style.display = 'block';
            }
            open();
        }, 2000);
    }

    const dismiss6 = () => {
        state.dismissedUntil = Date.now() + SIX_MONTHS;
        save();
        close();
    };
    const dismissForever = () => {
        state.dismissForever = true;
        save();
        close();
    };

    form.addEventListener('submit', function (e) {
        e.preventDefault();

        msgBox.textContent = "";
        msgBox.style.display = "none";
        form.querySelector('[type="submit"]').disabled = true;

        fetch(form.action, {
            method: 'POST',
            headers: {
                'X-Requested-With': 'XMLHttpRequest',
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: `email=${encodeURIComponent(emailInput.value)}`
        })
            .then(async res => {
                form.querySelector('[type="submit"]').disabled = false;
                const data = await res.json();
                msgBox.style.display = "";
                if (res.ok) {
                    msgBox.style.color = "#28a745"; // vert $success
                    msgBox.textContent = data.message || "Inscription réussie !";
                    state.subscribed = true;
                    save();
                    setTimeout(close, 1500);
                } else {
                    msgBox.style.color = "#bd2a2a"; // rouge $danger
                    msgBox.textContent = data.message || "Erreur.";
                }
            })
            .catch(() => {
                form.querySelector('[type="submit"]').disabled = false;
                msgBox.style.display = "";
                msgBox.style.color = "#bd2a2a"; // rouge $danger
                msgBox.textContent = "Erreur lors de l'inscription. Réessayez.";
            });
    });

    closeBtn.addEventListener('click', dismiss6);
    remindBtn.addEventListener('click', dismiss6);
    neverBtn.addEventListener('click', dismissForever);
});
