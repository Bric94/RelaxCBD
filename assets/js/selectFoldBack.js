document.addEventListener('DOMContentLoaded', () => {
    document.querySelectorAll('.weight-select').forEach(select => {
        let opened = false;
        select.addEventListener('mousedown', e => {
            if (opened) {
                e.preventDefault();
                select.blur();
                opened = false;
            }
        });
        select.addEventListener('focus', () => { opened = true; });
        select.addEventListener('blur', () => { opened = false; });
    });

    document.addEventListener('scroll', function () {
        // On vérifie si un .weight-select est focus, et on blur si besoin
        const active = document.activeElement;
        if (active && active.classList && active.classList.contains('weight-select')) {
            active.blur();
        }
    }, true);
});
