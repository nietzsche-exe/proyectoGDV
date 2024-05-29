
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.Hotel"%>
<%@page import="modelo.Direccion"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.FareDetailsBySegment"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.TravelerPricing"%>
<%@page import="org.hibernate.internal.build.AllowSysOut"%>
<%@page import="com.amadeus.referencedata.Locations"%>
<%@page import="com.amadeus.resources.Location"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.SearchSegment"%>
<%@page import="com.amadeus.resources.FlightOfferSearch.Itinerary"%>
<%@page import="com.amadeus.Shopping"%>
<%@page import="com.amadeus.Params"%>
<%@page import="com.amadeus.Amadeus"%>
<%@page import="com.amadeus.resources.FlightOfferSearch"%>
<%@page import="modelo.Usuario"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
//Sustituir Atributos por getters de objetos
    Amadeus amadeus=(Amadeus)request.getAttribute("sesionAmadeus");
    String codigoCiudadDestino=(String)request.getAttribute("codigoIATA3");
	String fechaEntrada=(String)request.getAttribute("fechaEntrada3");
	String fechaSalida=(String)request.getAttribute("fechaSalida3");
	String numeroPersonas=(String)request.getAttribute("numeroPersonas3");
	String codigoPaisOrigen=(String)request.getAttribute("codigoIATAOrigen2");
	String codigoPaisDestino=(String)request.getAttribute("codigoIATADestino2");
	
	
	Direccion direccion=(Direccion)request.getAttribute("direccion");
	Hotel hotel=(Hotel)request.getAttribute("hotel2");
	Habitacion habitacion=(Habitacion)request.getAttribute("habitacion01");
	
	request.getSession().setAttribute("direccion1",direccion);
	request.getSession().setAttribute("hotel1",hotel);
	request.getSession().setAttribute("habitacion1",habitacion);
	
	
	//Obtiene la sesión actual
	HttpSession sessionA=request.getSession();
	//Obtiene los datos del usuario almacenados en la sesión
	Usuario usuario = (Usuario) sessionA.getAttribute("usuario");
	System.out.println("Informacion usuario actual: "+usuario.toString());
	
	Location[] locations= amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", "MAD")
				.and("countryCode", codigoPaisOrigen));
	    		//De momento trabajo con MAD=Aeropuert Adolfo Suarez Barajas,LHR=UK,TXL=BER(Berlin)
	    		//La API busca en ingles
	   //System.out.println(locations[0].toString());
	    		
   Location[] locationsDestino = amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", codigoCiudadDestino)
				.and("countryCode", codigoPaisDestino));
	   //System.out.println(locationsDestino[0].toString());
   	
	   FlightOfferSearch[] flightOffers = amadeus.shopping.flightOffersSearch.get(
            Params.with("originLocationCode", "MAD")
                    .and("destinationLocationCode", codigoCiudadDestino)
                    .and("departureDate", fechaEntrada)
                    .and("returnDate", fechaSalida)
                    .and("adults", numeroPersonas)
                    .and("nonStop", true)
                    .and("max", 10));
   		//System.out.println(flightOffers.length); 
	%>
                   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Viajes: avion</title>
	
	<style>
		/* Estilos generales */
		body {
		    background-color: #f9f9f9; /* Fondo claro */
		    color: #333; /* Texto oscuro */
		    font-family: Arial, sans-serif;
		    margin: 0;
		    padding: 0;
		}
		
		header {
		    background-color: #fff; /* Fondo claro para el encabezado */
		    padding: 20px;
		    border-bottom: 1px solid #ddd; /* Línea sutil debajo del encabezado */
		}
		
		header form {
		    display: inline-block;
		}
		
		header input[type="submit"] {
		    background-color: #4CAF50; /* Color verde */
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    cursor: pointer;
		    font-size: 16px;
		    border-radius: 5px;
		}
		
		header input[type="submit"]:hover {
		    background-color: #45a049; /* Verde más oscuro al pasar el ratón */
		}
		
		table {
		    width: 100%;
		    border-collapse: collapse;
		    margin: 20px 0;
		}
		
		table, th, td {
		    border: 1px solid #ddd; /* Borde claro */
		    padding: 10px;
		    text-align: left;
		}
		
		th {
		    background-color: #f2f2f2; /* Fondo claro para encabezados de tabla */
		}
		
		form input[type="submit"] {
		    background-color: #4CAF50; /* Color verde */
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    cursor: pointer;
		    font-size: 16px;
		    border-radius: 5px;
		}
		
		form input[type="submit"]:hover {
		    background-color: #45a049; /* Verde más oscuro al pasar el ratón */
		}
				
	</style>
	
	
</head>
	<header>
		<form action="LoginController?opcion=perfil" method="post">
			<%sessionA.setAttribute("usuario", usuario); %>
			<input type="submit" value="cancelar">
		
		</form>
	</header>	
<body>
	<%
	try{
		
	
	if(flightOffers[0].getId()!=null){%>
		
		<% 
		for(int j=0;j<flightOffers.length;j++){
			Itinerary[]itineraries=flightOffers[j].getItineraries();
			TravelerPricing[]pricings=flightOffers[j].getTravelerPricings();
			FareDetailsBySegment[]bySegments=pricings[0].getFareDetailsBySegment();

		%>
		<table>
		<tr>
			<th rowspan="3">Id vuelo</th>				<!-- No incluir en bd -->
			<th rowspan="3">Ultima fecha para comprar</th>	<!-- No incluir en bd -->
			<th rowspan="3">NºAsientos disponibles</th>	<!-- No incluir en bd -->					
			<th rowspan="1" colspan="10">Ida</th>
			<th rowspan="1" colspan="10">Vuelta</th>					<!-- Puede no haber vuelta-->
			<th rowspan="3">Precio</th>
			<!-- incluir Datos del asiento por cada viajero o unico viajero(pensarlo) -->
		</tr>
		<tr>

			<th colspan="6">Salida</th>
			<th colspan="4">Llegada</th>
			<th colspan="6">Salida</th>
			<th colspan="4">Llegada</th>
		</tr>
		<tr>

			<th>Aeropuerto</th>
			<th>Duracion</th>
			<th>Ciudad Origen</th>
			<th>Terminal</th>
			<th>Hora Salida</th>
			<th>Compañia Aerea</th>
			
			<th>Aeropuerto</th>
			<th>Ciudad Destino</th>
			<th>Terminal</th>
			<th>Hora Llegada</th>
			
			<th>Aeropuerto</th>
			<th>Duracion</th>
			<th>Ciudad Origen</th>
			<th>Terminal</th>
			<th>Hora Salida</th>
			<th>Compañia Aerea</th>
			
			<th>Aeropuerto</th>
			<th>Ciudad Destino</th>
			<th>Terminal</th>
			<th>Hora Llegada</th>
		</tr>
		<tr>
			<td><%=flightOffers[j].getId() %></td>
			<td><%=flightOffers[j].getLastTicketingDate() %></td>
			<td><%=flightOffers[j].getNumberOfBookableSeats() %></td>
			<%for(int x=0;x<2;x++){
				SearchSegment[]searchSegments=itineraries[x].getSegments();
				
				//System.out.println("Itinerario "+x +": "+itineraries[x].toString());
				//System.out.println("segmento "+x +": "+searchSegments[0].toString());
				if(x==0){
					%>
			<td><%=locations[0].getName() %></td>
			<td><%=itineraries[x].getDuration() %></td>
			<td><%=locations[0].getAddress().getCityName() %> </td>
			<td><%=searchSegments[0].getDeparture().getTerminal() %></td>
			<td><%=searchSegments[0].getDeparture().getAt() %></td>					
			<td><%=searchSegments[0].getCarrierCode() %></td>
			<td><%=locationsDestino[0].getName() %></td>
			<td><%=codigoCiudadDestino %></td>
			<td><%=searchSegments[0].getArrival().getTerminal() %></td>
			<td><%=searchSegments[0].getArrival().getAt() %></td>
					<% 
				}else if(x>0){
				%>
			<td><%=locationsDestino[0].getName() %></td>
			<td><%=itineraries[x].getDuration() %></td>
			<td><%=locationsDestino[0].getAddress().getCityName() %></td>
			<td><%=searchSegments[0].getDeparture().getTerminal() %></td>
			<td><%=searchSegments[0].getDeparture().getAt() %></td>		
			<td><%=searchSegments[0].getCarrierCode() %></td>
			<td><%=locations[0].getName() %></td>
			<td><%=locations[0].getAddress().getCityCode() %></td>
			<td><%=searchSegments[0].getArrival().getTerminal() %></td>
			<td><%=searchSegments[0].getArrival().getAt() %></td>
			<%}
			} %>
			<td><%=flightOffers[0].getPrice().getTotal()+"/"+flightOffers[0].getPrice().getCurrency()%></td>
		</tr>
		<tr>
			<th rowspan="3" colspan="4">Info Asiento</th>
		</tr>
		
			<tr>
				<th>id viajero</th>
				<th>tipo Viajero</th>
				<th>Precio billete</th>
				<th>Clase</th>
			</tr>
			<tr>
				<td><%=pricings[0].getTravelerId() %></td>
				<td><%=pricings[0].getTravelerType() %></td>
				<td><%=pricings[0].getPrice().getTotal()+"/ "+pricings[0].getPrice().getCurrency() %></td>
				<td><%=bySegments[0].getCabin() %></td>
				<td>
					<form name="guardarOfertaViaje"
						action="LoginController?opcion=guardarOfertaViaje" method="post">
						<input type="hidden" name="aeropuertoOrigen" value="<%=locations[0].getName()%>">
						<input type="hidden" name="ciudadOrigen" value="<%=locations[0].getAddress().getCityName()%>">
						<input type="hidden" name="companiaAerea" value="<%=locations[0].getName()%>">
						<input type="hidden" name="ciudadDestino" value="<%=locationsDestino[0].getAddress().getCityName()%>">
						<input type="hidden" name="aeropuertoDestino" value="<%=locationsDestino[0].getName()%>">
						<input type="hidden" name="tipoViajero" value="<%=pricings[0].getTravelerType()%>">
						<input type="hidden" name="precioMedio" value="<%=pricings[0].getPrice().getTotal()%>">
						<input type="hidden" name="claseCabina" value="<%=bySegments[0].getCabin()%>">
						
						<input type="submit" value="Guardar">
					</form>
				</td>
			</tr>
		</table>
		<% 
		}	
		}
	}catch( ArrayIndexOutOfBoundsException e){
	System.out.println("NO HAY VUELOS DISPONIBLES");
	response.sendRedirect("Secure/nuevoViaje.jsp");
	%>
	
	<h2>¿Quieres guardar el viaje sin vuelos?</h2>
	<form action="LoginController?opcion=guardarOfertaViaje" method="post">
		<input type="submit" value="Guardar Viaje">
	</form>
	<form action="LoginController?opcion=perfil" method="post">
		<%
		sessionA.setAttribute("usuario",usuario);
		%>
		<input type="submit" value="volver">
	</form>
	
	<script>alert('NO HAY VUELOS DISPONIBLES PARA LA CIUDAD\n ${param.destino}')</script>
	<%
	}
		%>
	
</body>
</html>