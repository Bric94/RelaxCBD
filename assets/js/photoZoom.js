document.addEventListener('DOMContentLoaded', () => {
    console.log('photoZoom.js chargé');
    const image = document.querySelector('.product-detail__image');
    const modal = document.getElementById('image-modal');

    if (!image || !modal) {
        return;
    }

    const modalImg = modal.querySelector('.image-modal__img');
    const closeBtn = modal.querySelector('.image-modal__close');

    if (image && modal && modalImg && closeBtn) {
        image.style.cursor = 'zoom-in';

        image.addEventListener('click', () => {
            modal.classList.add('open');
            modalImg.src = image.src;
        });

        closeBtn.addEventListener('click', () => {
            modal.classList.remove('open');
            modalImg.src = '';
        });

        modal.addEventListener('click', (e) => {
            if (e.target === modal) {
                modal.classList.remove('open');
                modalImg.src = '';
            }
        });

        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                modal.classList.remove('open');
                modalImg.src = '';
            }
        });
    }
});
