document.addEventListener('DOMContentLoaded', function () {
    if (typeof google === 'undefined' || !google.maps) {
        console.warn('Google Maps API non chargée');
        return;
    }

    window.initMap = function () {
        const mapElement = document.getElementById('map');
        if (!mapElement) {
            console.warn('Map element not found');
            return;
        }

        const pos = { lat: 43.56730328908945, lng: 7.074508188584845 };

        const map = new google.maps.Map(mapElement, {
            center: pos,
            zoom: 17,
            mapId: '613b2c5b037d794c74796c29',
            disableDefaultUI: true,
            gestureHandling: 'greedy'
        });

        // Création du marqueur avec la nouvelle API
        const markerContent = document.createElement('div');
        markerContent.className = 'custom-marker';

        const markerImage = document.createElement('img');
        markerImage.src = '/build/images/ui/leaf-icon.png'; // Chemin correct
        markerImage.alt = 'Relax CBD Shop';
        markerImage.style.width = '60px';
        markerImage.style.height = '60px';

        markerContent.appendChild(markerImage);

        const marker = new google.maps.marker.AdvancedMarkerElement({
            map: map,
            position: pos,
            content: markerContent
        });

        marker.addListener('gmp-click', () => {
            window.open('https://maps.app.goo.gl/nJDtQuqtjZV2x9CQA', '_blank');
        });
    };

    // Charger la carte après le DOM
    const script = document.createElement('script');
    script.src = `https://maps.googleapis.com/maps/api/js?key=AIzaSyAb4uYhJvp77lHUK5-u_oATgxXLZe_WOK4&libraries=marker&v=beta&callback=initMap`;
    script.async = true;
    script.defer = true;
    document.head.appendChild(script);
});
