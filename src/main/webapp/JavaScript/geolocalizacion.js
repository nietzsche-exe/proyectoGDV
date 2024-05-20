/**
 * 
 */

 // Función para obtener la dirección a partir de las coordenadas
function obtenerDireccion(latitud, longitud) {
  // Crear una instancia del objeto Geocoder
  var geocoder = new google.maps.Geocoder();

  // Crear un objeto LatLng con las coordenadas proporcionadas
  var latLng = new google.maps.LatLng(latitud, longitud);

  // Realizar la solicitud de geocodificación inversa
  geocoder.geocode({'latLng': latLng}, function(results, status) {
    if (status == google.maps.GeocoderStatus.OK) {
      if (results[0]) {
        // Obtener la dirección formateada desde los resultados
        var direccion = results[0].formatted_address;
        console.log("Dirección encontrada: " + direccion);
        // Aquí puedes hacer lo que necesites con la dirección obtenida
      } else {
        console.log("No se encontraron resultados para estas coordenadas.");
      }
    } else {
      console.log("Error al obtener la dirección: " + status);
    }
  });
}

var latitud = 40.7128; // Latitud de ejemplo (Nueva York)
var longitud = -74.0060; // Longitud de ejemplo (Nueva York)

obtenerDireccion(latitud, longitud);