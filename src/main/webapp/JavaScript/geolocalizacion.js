/**
 * 
 */


var latitudes = JSON.parse(document.querySelector('.latitude').value);
var longitudes = JSON.parse(document.querySelector('.longitude').value);

// Función para obtener la dirección a partir de las coordenadas
function obtenerDireccion(latitud, longitud) {
  return new Promise((resolve, reject) => {
    var geocoder = new google.maps.Geocoder();
    var latLng = new google.maps.LatLng(latitud, longitud);

    geocoder.geocode({'latLng': latLng}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (results[0]) {
          resolve(results[0].formatted_address);
        } else {
          reject("No se encontraron resultados para estas coordenadas.");
        }
      } else {
        reject("Error al obtener la dirección: " + status);
      }
    });
  });
}

async function obtenerTodasLasDirecciones() {
  var direcciones = [];
  
  for (var i = 0; i < latitudes.length; i++) {
    try {
      var direccion = await obtenerDireccion(latitudes[i], longitudes[i]);
      direcciones.push(direccion);
    } catch (error) {
      console.log(error);
    }
  }
  console.log(direcciones)
  
  const fs = require('fs');
  
  const jsonString = JSON.stringify(direcciones, null, 2);
  
  fs.writeFile('data.json', jsonString, (err) => {
    if (err) {
        console.log('Error escribiendo el fichero', err);
    } else {
        console.log('Fichero JSON escrito correctamente');
    }
});
  
}

