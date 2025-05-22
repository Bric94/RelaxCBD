document.querySelectorAll('.quantity-wrapper').forEach(wrapper => {
    const input = wrapper.querySelector('input[type="number"]');
    wrapper.querySelector('.decrement').addEventListener('click', () => input.stepDown());
    wrapper.querySelector('.increment').addEventListener('click', () => input.stepUp());
});
