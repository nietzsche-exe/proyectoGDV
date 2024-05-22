/*
* Funcion JavaScript que recibe coordenadas de una ubicacion 
* para conectar con la API de Google Maps y crear un Mapa.
*/

	
	var latitudes = JSON.parse(document.querySelector('.latitude').value);
	var longitudes = JSON.parse(document.querySelector('.longitude').value);
	
	var primeraLatitud = latitudes[1];
	var primeraLongitud = longitudes[1];

function iniciarMap(){
   
    var coord = {lat: Number(primeraLatitud) ,lng: Number(primeraLongitud)};
    var map = new google.maps.Map(document.getElementById('map'),{
      zoom: 10,
      center: coord
    });
  
  for(i = 0; i < latitudes.length; i++){
  
	var marker = new google.maps.Marker({
     position: {lat: Number(latitudes[i]) ,lng: Number(longitudes[i])},
     map: map
    });	
    
  }
    	
}
    