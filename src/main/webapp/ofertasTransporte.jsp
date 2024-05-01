<%@page import="com.amadeus.Shopping"%>
<%@page import="com.amadeus.Params"%>
<%@page import="com.amadeus.Amadeus"%>
<%@page import="com.amadeus.resources.FlightOfferSearch"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   	
    Amadeus amadeus=(Amadeus)request.getAttribute("sesionAmadeus");
    
    String codigo=(String)request.getAttribute("codigoIATA3");
	String fechaEntrada=(String)request.getAttribute("fechaEntrada3");
	String fechaSalida=(String)request.getAttribute("fechaSalida3");
	String numeroPersonas=(String)request.getAttribute("numeroPersonas3");
	
	System.out.println(codigo+" "+fechaEntrada+" "+fechaSalida+" "+numeroPersonas);
   	FlightOfferSearch[] flightOffers = amadeus.shopping.flightOffersSearch.get(
            Params.with("originLocationCode", "MAD")
                    .and("destinationLocationCode", codigo)
                    .and("departureDate", fechaEntrada)
                    .and("returnDate", fechaSalida)
                    .and("adults", numeroPersonas));   
   	%>
                   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Viajes: avion</title>
</head>
<body>
	<%if(flightOffers!=null){%>
	<table>
		<thead>Ofertas de viaje</thead>
		<tr>
			<td>Ultima fecha para comprar</td>
			<td>Asientos disponibles</td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>
	<%} %>
</body>
</html>