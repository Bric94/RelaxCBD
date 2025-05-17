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
});
