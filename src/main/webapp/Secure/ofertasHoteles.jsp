<%@page import="util.Coordenada"%>
<%@page import="com.amadeus.exceptions.ClientException"%>
<%@page import="com.amadeus.resources.HotelSentiment"%>
<%@page import="com.amadeus.resources.HotelOfferSearch"%>
<%@page import="com.amadeus.resources.HotelOfferSearch.Offer"%>
<%@page import="com.amadeus.referencedata.locations.Cities"%>
<%@page import="com.amadeus.referencedata.locations.Hotels"%>
<%@page import="com.amadeus.resources.Resource"%>
<%@page import="com.amadeus.resources.City"%>
<%@page import="com.amadeus.resources.Hotel"%>
<%@page import="com.amadeus.resources.Location"%>
<%@page import="com.amadeus.resources.Hotel.Address"%>
<%@page import="com.amadeus.Amadeus"%>
<%@page import="com.amadeus.Params"%>
<%@page import="com.amadeus.exceptions.ResponseException"%>

<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.ArrayList"%>
<%@page import="controlador.LoginController"%>

<%@page import="com.mysql.cj.x.protobuf.MysqlxExpr.Array"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
//Necesario transportar datos del usuario

//Get list of hotels by city code
//Cada vez que el usuario refresque se actualizara			
Amadeus amadeus = (Amadeus) request.getAttribute("sesionAmadeus");
Hotel[] hotels;
ArrayList<Coordenada> coords = new ArrayList<>();
ArrayList<Hotel> listaHoteles = new ArrayList<Hotel>();
String airportCode = (String) request.getAttribute("codIATA");
try {
	hotels = amadeus.referenceData.locations.hotels.byCity.get(Params.with("cityCode", airportCode));
	for (int a = 0; a < 10; a++) {
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
//Recojer VAloraciones de los hoteles que mostremos
request.setAttribute("listaHoteles", listaHoteles);
request.setAttribute("sesionAmadeus", amadeus);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resultado Hoteles</title>
</head>
<body>
	<h1>Ciudad: ${param.destino}</h1>
	<h2>Codigo IATA: ${codIATA}</h2>
	
	<div id="map" style="height: 500px; width: 100%;"></div>
	
	
	<%
	String fechaEntrada = (String) request.getAttribute("fechaEntrada");
	String fechaSalida = (String) request.getAttribute("fechaSalida");
	String numeroPersonas = (String) request.getAttribute("numeroPersonas");
	System.out.println("Fecha de Entrada: " + fechaEntrada + "\nFecha de Salida: " + fechaSalida + "\nNumero de personas: "
			+ numeroPersonas);

	if (!(listaHoteles.isEmpty())) {
		
		for (Hotel hotel : listaHoteles) {
			
			Coordenada coord = new Coordenada(hotel.getGeoCode().getLatitude(), hotel.getGeoCode().getLongitude());
			coords.add(coord);
			
		%>
	<table style="border: 2px; border-style: solid; border-color: black;">
		<thead><%=request.getAttribute("codIATA")%></thead>
		<tr style="border: 2px; border-style: solid; border-color: black;">
			<!--  <td>Media De Valoraciones</td>-->
			<td>Nombre Hotel</td>
			<td colspan="10">Direccion</td>
			<td colspan="2">Codigo Hotel</td>
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">

			<td style="border: 2px; border-style: solid; border-color: black;"><%=hotel.getName()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;" colspan="10"><%=hotel.getAddress()%> <br> Falta Implementar la
				Geolocalizacion inversa(Api de Google Maps,...?)</td>
			<td colspan="2" style="border: 2px; border-style: solid; border-color: black;"><%=hotel.getHotelId()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;">
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
					
					<input type="hidden" name="latitude" value="<% hotel.getGeoCode().getLatitude(); %>">
					<input type="hidden" name="longitude" value="<% hotel.getGeoCode().getLongitude(); %>">
					
				</form>
			</td>
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">
		<%
		try {

			HotelOfferSearch[] ofertasHotel = amadeus.shopping.hotelOffersSearch.get(Params
					.with("hotelIds", hotel.getHotelId())
					.and("adults", Integer.valueOf(numeroPersonas))
					.and("childs", 1).and("checkInDate", fechaEntrada)
					.and("checkOutDate", fechaSalida)
					.and("roomQuantity", 1).and("bestRateOnly", true));
			System.out.println("Consulta " + 1 + ": " + ofertasHotel.toString());
			System.out.println("Oferta " + 1 + ": " + ofertasHotel[0].toString());
			System.out.println("Id Oferta " + 1 + ": " + ofertasHotel[0].getOffers()[0].getId());
		%>
			<td style="border: 2px; border-style: solid; border-color: black;">Id Oferta</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Fecha de entrada</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Fecha de salida</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Valoracion</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Disponible</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Hab. Tipo</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Hab. Categoria</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Nº camas/Hab</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Tipo Camas</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Descripcion</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Acompañantes</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Precio por noche/</td>
			<td style="border: 2px; border-style: solid; border-color: black;">Precio Total(+ añadidos)</td>
			<%
			Offer[] ofer = ofertasHotel[0].getOffers();
			Offer infoOferta = ofer[0];
			%>
		
		<tr style="border: 2px; border-style: solid; border-color: black;">
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getId()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getCheckInDate()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getCheckOutDate()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getRateCode()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=ofertasHotel[0].isAvailable()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getRoom().getType()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getRoom().getTypeEstimated().getCategory()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getRoom().getTypeEstimated().getBeds()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getRoom().getTypeEstimated().getBedType()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getDescription()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;">Adultos: <%=infoOferta.getGuests().getAdults()%><br>Niño/as:
				<%
			if (infoOferta.getGuests().getChildAges() == null) {
			%>0<%
			} else {
			%><%=infoOferta.getGuests().getChildAges()%> <%
 }
 %>
			</td>
			<td style="border: 2px; border-style: solid; border-color: black;">
				<%
				LocalDate salida = LocalDate.parse(fechaSalida);
				LocalDate entrada = LocalDate.parse(fechaEntrada);
				Long noches = salida.toEpochDay() - entrada.toEpochDay();
				Double precioNoche =Math.ceil(Double.valueOf(infoOferta.getPrice().getBase()) / noches);
				%> <%=precioNoche+"/"+infoOferta.getPrice().getCurrency() %>
			</td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=infoOferta.getPrice().getTotal()%>/<%=infoOferta.getPrice().getCurrency()%></td>
			<td style="border: 2px; border-style: solid; border-color: black;">
				<form name="guardarOfertaHotel"
					action="LoginController?opcion=guardarOfertaHotel" method="post">
					<input type="hidden" name="hotelId" value="<%=infoOferta.getId()%>">
					<input type="hidden" name="fechaEntrada2" value="<%=fechaEntrada%>">
					<input type="hidden" name="fechaSalida2" value="<%=fechaSalida%>">
					<input type="hidden" name="numeroPersonas2" value="<%=numeroPersonas%>">
					<input type="hidden" name="codigoIATA2" value="<%=airportCode%>">
					<input type="hidden" name="codigoIATAOrigen" value="ES"><!-- Se cambiara por la ubicacion del usuario con la API de googleMaps -->
					<input type="hidden" name="codigoIATADestino" value="<%=hotel.getAddress().getCountryCode()%>">
					<input type="submit" value="Reservar(No funciona)">
				</form>
			</td>
		

		<%
		} catch (ClientException e) {
		%>
			<td colspan="11" style="border: 2px; border-style: solid; border-color: black;">No se han encontrado habitaciones para el hotel	</td>		
		<%
		}

		}
		%>
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

	<input type="hidden" name="arrayCoords" value="<%=10%>">
	
	<script src="JavaScript/map.js"></script>
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCmNYNcpFgAX0QLerv3_P3CJZoop9VnSSs&callback=iniciarMap"></script>

</body>
</html>