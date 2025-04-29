document.addEventListener('DOMContentLoaded', () => {
    const popup = document.querySelector('.floating-popup');
    if (popup) {
        setTimeout(() => {
            popup.style.display = 'none';
        }, 7000);
    }
});
