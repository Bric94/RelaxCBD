(function loadGoogleMapsAPI() {

    const mapElement = document.getElementById('map');
    if (!mapElement) return;

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

window.initMap = async function () {
    const { Map } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

    const shopPosition = { lat: 43.56730328908945, lng: 7.074508188584845 };

    const map = new Map(document.getElementById('map'), {
        center: shopPosition,
        zoom: 18,
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

function createCustomMarker() {
    const img = document.createElement('img');
    img.src = '../images/icons/leaf-icon.png';
    img.style.width = '60px';
    img.style.height = '60px';
    img.style.background = 'transparent';
    img.style.border = 'none';
    img.alt = 'Relax CBD Shop';
    return img;
}

// Gestion du clic pour ouvrir la carte native
function openMapsApp(shopPosition) {
    const ua = navigator.userAgent.toLowerCase();
    let url;

    if (/iphone|ipad|ipod/.test(ua)) {
        url = `https://maps.app.goo.gl/yimMDdtT8deH2BRR8`;
    } else if (/android/.test(ua)) {
        url = `https://maps.app.goo.gl/yimMDdtT8deH2BRR8`;
    } else {
        url = `https://maps.app.goo.gl/yimMDdtT8deH2BRR8`;
    }

    window.open(url, '_blank');
}
