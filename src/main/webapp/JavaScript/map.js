/*
* Funcion JavaScript que recibe coordenadas de una ubicacion 
* para conectar con la API de Google Maps y crear un Mapa,
* además crea un marcador en el mapa cono la latitud y longitud 
* de cada hotel que se encontro y que ofrece una habitación 
*/

async function iniciarMap() {
    let latitudes = JSON.parse(document.querySelector('.latitude').value);
    let longitudes = JSON.parse(document.querySelector('.longitude').value);

    var primeraLatitud = Number(latitudes[0]);
    var primeraLongitud = Number(longitudes[0]);
    
    const { Map } = await google.maps.importLibrary("maps");

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

/*
* Recoje la direccion del hotel que se obtuvo por geolocalizacion y la inserta en cada uno de los hoteles
* asi como en el valor hidden del form del hotel
*/
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
