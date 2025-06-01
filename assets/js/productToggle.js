document.addEventListener('DOMContentLoaded', function () {
    const checkbox = document.querySelector('#product_isWeightBased');
    const priceField = document.querySelector('.field-price').closest('.form-group');
    const priceByWeightField = document.querySelector('.field-priceByWeight').closest('.form-group');

    function toggleFields() {
        const isWeightBased = checkbox.checked;
        if (isWeightBased) {
            priceField.style.display = 'none';
            priceByWeightField.style.display = '';
        } else {
            priceField.style.display = '';
            priceByWeightField.style.display = 'none';
        }
    }

    if (checkbox && priceField && priceByWeightField) {
        checkbox.addEventListener('change', toggleFields);
        toggleFields(); 
    }
});
