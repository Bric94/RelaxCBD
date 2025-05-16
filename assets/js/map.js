// map.js

// Chargement dynamique optimisé de l'API Maps JavaScript
(function loadGoogleMapsAPI() {
    const API_KEY = "AIzaSyAb4uYhJvp77lHUK5-u_oATgxXLZe_WOK4";
    const MAP_ID = "613b2c5b037d794c74796c29";
    const CALLBACK_NAME = "initMap";

    const script = document.createElement('script');
    script.async = true;
    script.defer = true;
    script.src = `https://maps.googleapis.com/maps/api/js?key=${API_KEY}&map_ids=${MAP_ID}&callback=${CALLBACK_NAME}&v=weekly`;
    script.onerror = () => console.error('Erreur de chargement Google Maps API.');

    document.head.appendChild(script);
})();

// Initialisation de la carte avec async/await (fonction globale)
window.initMap = async function () {
    const { Map } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

    const shopPosition = { lat: 43.56730328908945, lng: 7.074508188584845 };

    const map = new Map(document.getElementById('map'), {
        center: shopPosition,
        zoom: 16,
        disableDefaultUI: true,
        mapId: '613b2c5b037d794c74796c29',
        styles: [{ featureType: 'poi', stylers: [{ visibility: 'off' }] }]
    });

    const marker = new AdvancedMarkerElement({
        position: shopPosition,
        map,
        title: 'Relax CBD Shop',
        content: createCustomMarker()
    });

    marker.addListener('click', () => {
        openMapsApp(shopPosition);
    });
};

// Création d'un marqueur personnalisé (icône cannabis)
function createCustomMarker() {
    const img = document.createElement('img');
    img.src = '../images/icons/leaf-icon.png';
    img.style.width = '40px';
    img.style.height = '40px';
    img.alt = 'Relax CBD Shop';
    return img;
}

// Gestion du clic pour ouvrir la carte native
function openMapsApp(shopPosition) {
    const ua = navigator.userAgent.toLowerCase();
    let url;

    if (/iphone|ipad|ipod/.test(ua)) {
        url = `http://maps.apple.com/?q=${shopPosition.lat},${shopPosition.lng}`;
    } else if (/android/.test(ua)) {
        url = `geo:${shopPosition.lat},${shopPosition.lng}?q=${shopPosition.lat},${shopPosition.lng}`;
    } else {
        url = `https://www.google.com/maps?q=${shopPosition.lat},${shopPosition.lng}`;
    }

    window.open(url, '_blank');
}
