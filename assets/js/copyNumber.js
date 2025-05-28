document.addEventListener('DOMContentLoaded', () => {
    const phoneLinks = document.querySelectorAll('.js-copy-phone');

    phoneLinks.forEach(link => {
        const tooltip = link.querySelector('.tooltip');
        const phone = link.dataset.phone;

        link.addEventListener('click', (e) => {
            e.preventDefault();

            navigator.clipboard.writeText(phone).then(() => {
                if (tooltip) {
                    tooltip.textContent = 'Copié !';
                    tooltip.style.opacity = 1;
                    tooltip.style.transform = 'translateY(-1.5rem)';
                    setTimeout(() => {
                        tooltip.textContent = 'Copier';
                        tooltip.style.opacity = 0;
                        tooltip.style.transform = 'translateY(0)';
                    }, 1500);
                }
                if (window.innerWidth <= 768) {
                    window.location.href = `tel:${phone}`;
                }
            }).catch(() => { });
        });
    });
});
