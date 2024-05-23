<%@page import="com.amadeus.referencedata.Locations"%>
<%@page import="util.Coordenada"%>
<%@ page import="org.json.JSONArray" %>
<%@page import="com.amadeus.exceptions.ClientException"%>
<%@page import="com.amadeus.resources.HotelSentiment"%>
<%@page import="com.amadeus.resources.HotelOfferSearch"%>
<%@page import="com.amadeus.resources.HotelOfferSearch.Offer"%>
<%@page import="com.amadeus.referencedata.locations.Cities"%>
<%@page import="com.amadeus.referencedata.locations.Hotels"%>
<%@page import="com.amadeus.resources.Location"%>
<%@page import="com.amadeus.resources.Resource"%>
<%@page import="com.amadeus.resources.City"%>
<%@page import="com.amadeus.resources.Hotel"%>
<%@page import="com.amadeus.resources.Hotel.Address"%>
<%@page import="com.amadeus.Amadeus"%>
<%@page import="com.amadeus.Params"%>
<%@page import="com.amadeus.exceptions.ResponseException"%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.LoginController"%>
<%@page import="modelo.Usuario"%>

<%@page import="com.mysql.cj.x.protobuf.MysqlxExpr.Array"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//Necesario transportar datos del usuario

//Get list of hotels by city code
//Cada vez que el usuario refresque se actualizara			
Amadeus amadeus = (Amadeus) request.getAttribute("sesionAmadeus");

//Obtiene la sesión actual
HttpSession b = request.getSession();
//Obtiene los datos del usuario almacenados en la sesión
Usuario usuario = (Usuario) b.getAttribute("usuario");
System.out.println("Informacion usuario actual: "+usuario.toString());
usuario.getTema();
Hotel[] hotels;

//Revisar Coordenada
ArrayList<Hotel> listaHoteles = new ArrayList<Hotel>();
ArrayList<String> latitudes = new ArrayList<String>();
ArrayList<String> longitudes = new ArrayList<String>();

String airportCode = (String) request.getAttribute("codIATA");


Location[] locations= amadeus.referenceData.locations.get(Params.with("subType", "CITY")
		.and("keyword", (String)request.getAttribute("nombreCiudad"))
		.and("countryCode",(String)request.getAttribute("codigoIATAPaisDestino")));
try {
	 
	hotels = amadeus.referenceData.locations.hotels.byCity.get(Params.with("cityCode", airportCode));
	for (int a = 0; a < hotels.length; a++) {
		System.out.println(hotels[a].toString());
		listaHoteles.add(hotels[a]);
	}
	/*
	Hotel[] hotels = amadeus.referenceData.locations.hotels.byGeocode.get(Params
	.with("longitude", 2.160873)
	.and("latitude", 41.397158));
	*/
	
} catch (ResponseException e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
//Recojer Valoraciones de los hoteles que mostremos
request.setAttribute("listaHoteles", listaHoteles);
request.setAttribute("sesionAmadeus", amadeus);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resultado Hoteles</title>
<%
if (usuario.getTema()==true) {
%>
	<link rel="stylesheet" href="../Styles/Ofertas_Hoteles/cssOfertasHoteles_Oscuro.css">
<%
}
else {
%>
	<link rel="stylesheet" href="../Styles/Ofertas_Hoteles/cssOfertasHoteles_Claro.css">
<%	
}
%>

</head>
<body>
	<h1>Ciudad: ${param.destino}</h1>
	<h2>Codigo IATA: ${codIATA}</h2>
	
	<div id="map" style="height: 500px; width: 100%;"></div>
	
	
	<%
	String fechaEntrada = (String) request.getAttribute("fechaEntrada");
	String fechaSalida = (String) request.getAttribute("fechaSalida");
	String numeroPersonas = (String) request.getAttribute("numeroPersonas");
	String nombreCiudadDestino=(String) request.getAttribute("nombreCiudad");
	Double precioNoche=0.0;
	System.out.println("Fecha de Entrada: " + fechaEntrada + "\nFecha de Salida: " + fechaSalida + "\nNumero de personas: "
			+ numeroPersonas);

	if (!(listaHoteles.isEmpty())) {
		
		for (Hotel hotel : listaHoteles) {
			try {

				HotelOfferSearch[] ofertasHotel = amadeus.shopping.hotelOffersSearch.get(Params
						.with("hotelIds", hotel.getHotelId())
						.and("adults", Integer.valueOf(numeroPersonas))
						.and("childs", 0)
						.and("checkInDate", fechaEntrada)
						.and("checkOutDate", fechaSalida)
						.and("roomQuantity", 1).and("bestRateOnly", true));
				System.out.println("Consulta " + 1 + ": " + ofertasHotel.toString());
				System.out.println("Oferta " + 1 + ": " + ofertasHotel[0].toString());
				System.out.println("Id Oferta " + 1 + ": " + ofertasHotel[0].getOffers()[0].getId());
			
			latitudes.add(String.valueOf(hotel.getGeoCode().getLatitude()));
			longitudes.add(String.valueOf(hotel.getGeoCode().getLongitude()));
		%>
	<table>
		<thead><%=request.getAttribute("codIATA")%></thead>
		<tr>
			<!--  <td>Media De Valoraciones</td>-->
			<td>Nombre Hotel</td>
			<td colspan="10">Direccion</td>
			<td colspan="2">Codigo Hotel</td>
		</tr>
		<tr>
			
			<td><%=hotel.getName()%></td>
			<td colspan="10"><%=hotel.getAddress()%> <br> Falta Implementar la
				Geolocalizacion inversa(Api de Google Maps,...?)</td>
			<td colspan="2"><%=hotel.getHotelId()%></td>
			<td>
				<form name="verOfertasHotel"
					action="LoginController?opcion=verOfertasHotel" method="post">
					<input type="hidden" name="hotelId" value="<%=hotel.getHotelId()%>">
					<input type="hidden" name="hotelNombre"
						value="<%=hotel.getName()%>"> <input type="hidden"
						name="fechaEntrada" value="<%=fechaEntrada%>"> <input
						type="hidden" name="fechaSalida" value="<%=fechaSalida%>">
					<input type="hidden" name="numeroPersonas"
						value="<%=numeroPersonas%>"> <input type="submit"
						value="Ver detalles">
					
					<input type="hidden" id="latitude" value="<%=latitudes%>">
					<input type="hidden" id="longitude" value="<%=longitudes%>">
				</form>
			</td>
		</tr>
		<tr>
		<%
		
		%>
			<td>Id Oferta</td>
			<td>Fecha de entrada</td>
			<td>Fecha de salida</td>
			<td>Valoracion</td>
			<td>Disponible</td>
			<td>Hab. Tipo</td>
			<td>Hab. Categoria</td>
			<td>Nº camas/Hab</td>
			<td>Tipo Camas</td>
			<td>Descripcion</td>
			<td>Acompañantes</td>
			<td>Precio por noche/</td>
			<td>Precio Total(+ añadidos)</td>
			<%
			Offer[] ofer = ofertasHotel[0].getOffers();
			Offer infoOferta = ofer[0];
			%>
		
		<tr>
			<td><%=infoOferta.getId()%></td>
			<td><%=infoOferta.getCheckInDate()%></td>
			<td><%=infoOferta.getCheckOutDate()%></td>
			<td><%=infoOferta.getRateCode()%></td>
			<td><%=ofertasHotel[0].isAvailable()%></td>
			<td><%=infoOferta.getRoom().getType()%></td>
			<td><%=infoOferta.getRoom().getTypeEstimated().getCategory()%></td>
			
			<%if(infoOferta.getRoom().getTypeEstimated().getBeds()!=null && infoOferta.getRoom().getTypeEstimated().getBedType()!=null){
			%>		
			<td><%=infoOferta.getRoom().getTypeEstimated().getBeds() %></td>
			<td><%=infoOferta.getRoom().getTypeEstimated().getBedType()%></td>
			<%}else{ %>
			<td><%=0%></td>
			<td>Desconocido</td>
			<%} %>
			
			<td><%=infoOferta.getDescription()%></td>
			<td>Adultos: <%=infoOferta.getGuests().getAdults()%><br>Niño/as:
				<%
			if (infoOferta.getGuests().getChildAges() == null) {
			%>0<%
			} else {
			%><%=infoOferta.getGuests().getChildAges()%> <%
 }
 %>
			</td>
			<td>
				<%
				LocalDate salida = LocalDate.parse(fechaSalida);
				LocalDate entrada = LocalDate.parse(fechaEntrada);
				Long noches = salida.toEpochDay() - entrada.toEpochDay();
				precioNoche =Math.ceil(Double.valueOf(infoOferta.getPrice().getBase()) / noches);
				%> <%=precioNoche+"/"+infoOferta.getPrice().getCurrency() %>
			</td>
			<td><%=infoOferta.getPrice().getTotal()%>/<%=infoOferta.getPrice().getCurrency()%></td>
			<td>
				<form name="guardarOfertaHotel"
					action="LoginController?opcion=guardarOfertaHotel" method="post">
					<!-- Datos Entidad Hotel -->
					<input type="hidden" name="hotelId" value="<%=hotel.getHotelId()%>">
					<input type="hidden" name="nombreHotel" value="<%=hotel.getName()%>">
					<!-- Datos Entidad Direccion 
						Falta por obtener: Codigo_Postal y nombre_de_la_calle del Hotel -->
					<input type="hidden" name="codigoIATAPaisDestino" value="<%=hotel.getAddress().getCountryCode()%>">
					<input type="hidden" name="nombrePaisDestino" value="<%=locations[0].getAddress().getCountryName()%>">
					<input type="hidden" name="codigoIATACiudadDestino" value="<%=request.getAttribute("codIATA") %>">
					<input type="hidden" name="nombreCiudadDestino" value="<%=nombreCiudadDestino %>">
					
					<!-- Datos Entidad Habitacion -->
					<input type="hidden" name="idHabitacion" value="<%=infoOferta.getId()%>">
					<input type="hidden" name="fechaEntrada2" value="<%=fechaEntrada%>">
					<input type="hidden" name="fechaSalida2" value="<%=fechaSalida%>">
					<input type="hidden" name="habitacionDisponible" value="<%=ofertasHotel[0].isAvailable()==true? 1:0%>">
					
					<%if((infoOferta.getRoom().getTypeEstimated().getBeds()!=null) && (infoOferta.getRoom().getTypeEstimated().getBedType()!=null)){
					%>		
					<input type="hidden" name="numeroCamas" value="<%=infoOferta.getRoom().getTypeEstimated().getBeds()%>">
					<input type="hidden" name="tipoDeCama" value="<%=infoOferta.getRoom().getTypeEstimated().getBedType()%>">
					
					<%}else{ %>
					<input type="hidden" name="numeroCamas" value="0">
					<input type="hidden" name="tipoDeCama" value="Desconocido">
					<%}%>
					
					
					<input type="hidden" name="precioNoche" value="<%=precioNoche%>">
					<input type="hidden" name="precioTotal" value="<%=infoOferta.getPrice().getTotal()%>">
					<input type="hidden" name="numeroPersonas2" value="<%=numeroPersonas%>">
					<input type="hidden" name="codigoIATA2" value="<%=airportCode%>">
					<input type="hidden" name="codigoIATAPaisOrigen" value="ES"><!-- Se cambiara por la ubicacion del usuario con la API de googleMaps -->
					<input type="submit" value="Reservar">
				</form>
			</td>
		

		<%
		} catch (ClientException e) {
			System.out.println("El hotel no dispone de habitaciones");
		}catch(NullPointerException e){
			System.out.println("Valor nulo en el hotel");
			
			break;
			
		}

		}
		
		JSONArray latitudesJson = new JSONArray(latitudes);
	    JSONArray longitudesJson = new JSONArray(longitudes);
	    
	    String latitudesJsonStr = latitudesJson.toString();
	    String longitudesJsonStr = longitudesJson.toString();
	    
        
	    %>

		<td>
			<input type="hidden" class="latitude" value='<%= latitudesJsonStr %>'>
			<input type="hidden" class="longitude" value='<%= longitudesJsonStr %>'>
		</td>
		
		</tr>
	</table>
	
	
	<%
	} else {
	%>
	<p>No se encontraron hoteles para la ciudad especificada.</p>
	<%
	}
	%>
	<c:if test="${not empty errorMessage}">
		<p>${errorMessage}</p>
	</c:if>

	
	<script src="JavaScript/map.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCmNYNcpFgAX0QLerv3_P3CJZoop9VnSSs&callback=iniciarMap"></script>

</body>
</html>