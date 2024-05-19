<%@page import="org.apache.tomcat.util.json.JSONParser"%>
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
	
	System.out.println("Pagina ofertasTransporte.jsp");
	System.out.println("Direccion del Hotel elegido:\n"+direccion.toString());
	System.out.println("Datos del Hotel elegido:\n"+hotel.toString());
	System.out.println("Datos de la Habitacion del Hotel elegido:\n"+habitacion.toString());
	
	System.out.println(codigoCiudadDestino+" "+fechaEntrada+" "+fechaSalida+" "+numeroPersonas);
	
	//Obtiene la sesión actual
	//Obtiene los datos del usuario almacenados en la sesión
	Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
	System.out.println("Informacion usuario actual: "+usuario.toString());
	
	Location[] locations= amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", "MAD")
				.and("countryCode", codigoPaisOrigen));
	    		//De momento trabajo con MAD=Aeropuert Adolfo Suarez Barajas,LHR=UK,TXL=BER(Berlin)
	    			//La API busca en ingles
	   System.out.println(locations[0].toString());
	    		
   Location[] locationsDestino = amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", codigoCiudadDestino)
				.and("countryCode", codigoPaisDestino));
	   System.out.println(locationsDestino[0].toString());
   	
	   FlightOfferSearch[] flightOffers = amadeus.shopping.flightOffersSearch.get(
            Params.with("originLocationCode", "MAD")
                    .and("destinationLocationCode", codigoCiudadDestino)
                    .and("departureDate", fechaEntrada)
                    .and("returnDate", fechaSalida)
                    .and("adults", numeroPersonas)
                    .and("nonStop", true));
   	System.out.println(flightOffers.length); 
   	//for(int i=0;i<10;i++){
   		//System.out.println(flightOffers[i].toString());
   	//}
   	//Data(general para todos)x->itinerarios->precio->airlineCode->Datos para el viajero(Detalles)
   	%>
                   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Viajes: avion</title>
</head>
<body>
	<%if(flightOffers!=null){%>
	
		<% 
		for(int j=0;j<flightOffers.length;j++){
			Itinerary[]itineraries=flightOffers[j].getItineraries();
			TravelerPricing[]pricings=flightOffers[j].getTravelerPricings();
			FareDetailsBySegment[]bySegments=pricings[0].getFareDetailsBySegment();

		%>
		<table>
		<tr style="border: 2px; border-style: solid; border-color: black;">
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">Id vuelo</th>				<!-- No incluir en bd -->
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">Ultima fecha para comprar</th>	<!-- No incluir en bd -->
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">NºAsientos disponibles</th>	<!-- No incluir en bd -->					
			<th rowspan="1" colspan="10" style="border: 2px; border-style: solid; border-color: black;">Ida</th>
			<th rowspan="1" colspan="10" style="border: 2px; border-style: solid; border-color: black;">Vuelta</th>					<!-- Puede no haber vuelta-->
			<th rowspan="3" style="border: 2px; border-style: solid; border-color: black;">Precio</th>
			<!-- incluir Datos del asiento por cada viajero o unico viajero(pensarlo) -->
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">

			<th colspan="6" style="border: 2px; border-style: solid; border-color: black;">Salida</th>
			<th colspan="4" style="border: 2px; border-style: solid; border-color: black;">Llegada</th>
			<th colspan="6" style="border: 2px; border-style: solid; border-color: black;">Salida</th>
			<th colspan="4" style="border: 2px; border-style: solid; border-color: black;">Llegada</th>
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">

			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Duracion</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Origen</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Salida</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Compañia Aerea</th>
			
			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Destino</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Llegada</th>
			
			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Duracion</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Origen</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Salida</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Compañia Aerea</th>
			
			<th style="border: 2px; border-style: solid; border-color: black;">Aeropuerto</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Ciudad Destino</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Terminal</th>
			<th style="border: 2px; border-style: solid; border-color: black;">Hora Llegada</th>
		</tr>
		<tr style="border: 2px; border-style: solid; border-color: black;">
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[j].getId() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[j].getLastTicketingDate() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[j].getNumberOfBookableSeats() %></td>
			<%for(int x=0;x<2;x++){
				SearchSegment[]searchSegments=itineraries[x].getSegments();
				
				//System.out.println("Itinerario "+x +": "+itineraries[x].toString());
				//System.out.println("segmento "+x +": "+searchSegments[0].toString());
				if(x==0){
					%>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locations[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=itineraries[x].getDuration() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;">MAD</td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getAt() %></td>					
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getCarrierCode() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locationsDestino[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=codigoCiudadDestino %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getAt() %></td>
					<% 
				}else if(x>0){
				%>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locationsDestino[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=itineraries[x].getDuration() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=codigoCiudadDestino %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getDeparture().getAt() %></td>		
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getCarrierCode() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=locations[0].getName() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;">MAD</td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getTerminal() %></td>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=searchSegments[0].getArrival().getAt() %></td>
			<%}
			} %>
			<td style="border: 2px; border-style: solid; border-color: black;"><%=flightOffers[0].getPrice().getTotal()+"/"+flightOffers[0].getPrice().getCurrency()%></td>
		</tr>
		<tr>
			<th rowspan="3" colspan="4" style="border: 2px; border-style: solid; border-color: black;">Info Asiento</th>
		</tr>
		
			<tr>
				<th style="border: 2px; border-style: solid; border-color: black;">id viajero</th>
				<th style="border: 2px; border-style: solid; border-color: black;">tipo Viajero</th>
				<th style="border: 2px; border-style: solid; border-color: black;">Precio billete</th>
				<th style="border: 2px; border-style: solid; border-color: black;">Clase</th>
			</tr>
			<tr>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=pricings[0].getTravelerId() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=pricings[0].getTravelerType() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=pricings[0].getPrice().getTotal()+"/ "+pricings[0].getPrice().getCurrency() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;"><%=bySegments[0].getCabin() %></td>
				<td style="border: 2px; border-style: solid; border-color: black;">
					<form name="guardarOfertaViaje"
						action="LoginController?opcion=guardarOfertaViaje" method="post">
						<input type="hidden" name="Direccion1" value="<%=direccion%>">
						<input type="hidden" name="Habitacion1" value="<%=habitacion%>">
						<input type="hidden" name="Hotel1" value="<%=hotel%>">
						<input type="hidden" name="Usuario1" value="<%=usuario%>">
						<input type="submit" value="Guardar">
					</form>
				</td>
			</tr>
		<% 
		}	
	}
		%>
	</table>
</body>
</html>