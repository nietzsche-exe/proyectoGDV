/*
* Funcion JavaScript que recibe coordenadas de una ubicacion 
* para conectar con la API de Google Maps y crear un Mapa.
*/

async function iniciarMap() {
    let latitudes = JSON.parse(document.querySelector('.latitude').value);
    let longitudes = JSON.parse(document.querySelector('.longitude').value);

    var primeraLatitud = Number(latitudes[0]);
    var primeraLongitud = Number(longitudes[0]);

    const { Map } = await google.maps.importLibrary("maps");
   //const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

    let coord = { lat: primeraLatitud, lng: primeraLongitud };
    let map = new Map(document.getElementById('map'), {
        zoom: 10,
        center: coord
    });

    for (let i = 0; i < latitudes.length; i++) {
        let marcador = { lat: Number(latitudes[i]), lng: Number(longitudes[i]) };
        let marker = new google.maps.Marker({
            position: marcador,
            map: map,
            title: 'Hotel ' + (i + 1)
        });
        obtenerDireccion(marker.position, i);
    }
}

function obtenerDireccion(latlng, index) {
    var geocoder = new google.maps.Geocoder();
    geocoder.geocode({ 'location': latlng }, function (results, status) {
        if (status === 'OK') {
            if (results[0]) {
                document.getElementById('direccion_' + index).textContent = results[0].formatted_address;
                
                document.getElementsByName('direccionHotel')[index].value = results[0].formatted_address;
            } else {
                console.log('No se han encontrado resultados');
            }
        } else {
            console.log('Fallo en la geocodificacion: ' + status);
        }
    });
}
