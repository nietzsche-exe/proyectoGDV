/*
* Funcion JavaScript que recibe coordenadas de una ubicacion 
* para conectar con la API de Google Maps y crear un Mapa.
*/

let arrayCoordenadas = document.getElementById('arrayCoords');

function iniciarMap(){
   
   console.log(arrayCoordenadas);
   
    var coord = {lat: 0 ,lng: 0};
    var map = new google.maps.Map(document.getElementById('map'),{
      zoom: 10,
      center: coord
    });
  
	var marker = new google.maps.Marker({
      position: coord,
      map: map
    });	
    	
}
    
   
