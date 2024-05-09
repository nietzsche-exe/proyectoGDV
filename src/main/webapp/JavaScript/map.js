/*
* Funcion JavaScript que recibe coordenadas de una ubicacion 
* para conectar con la API de Google Maps y crear un Mapa.
*/
//let latitude = document.getElementById("latitude");
//let longitude = document.getElementById("longitude");


function iniciarMap(){
    var coord = {lat: 49.01278 ,lng: 2.55};
    var map = new google.maps.Map(document.getElementById('map'),{
      zoom: 10,
      center: coord
    });
    var marker = new google.maps.Marker({
      position: coord,
      map: map
    });
}