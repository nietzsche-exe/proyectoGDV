
<%@page import="modelo.Habitacion"%>
<%@page import="modelo.HotelBD"%>
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
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
//Sustituir Atributos por getters de objetos
    Amadeus amadeus=(Amadeus)request.getAttribute("sesionAmadeus");
	String fechaEntrada=(String)request.getAttribute("fechaEntrada3");
	String fechaSalida=(String)request.getAttribute("fechaSalida3");
	String numeroPersonas=(String)request.getAttribute("numeroPersonas3");
	
	String codigoPaisOrigen=(String)request.getAttribute("codigoIATAPaisOrigen2");
	String codigoCiudadOrigen= (String) request.getAttribute("codigoIATACiudadOrigen2");
	String codigoPaisDestino=(String)request.getAttribute("codigoIATAPaisDestino2");
    String codigoCiudadDestino=(String)request.getAttribute("codigoIATACiudadDestino2");
	
	
	Direccion direccion=(Direccion)request.getAttribute("direccion_Creada");
	HotelBD hotel=(HotelBD)request.getAttribute("hotel_Creada");
	Habitacion habitacion=(Habitacion)request.getAttribute("habitacion_Creada");
	
	request.getSession().setAttribute("direccion_Final",direccion);
	request.getSession().setAttribute("hotel_Final",hotel);
	request.getSession().setAttribute("habitacion_Final",habitacion);
	
	
	//Obtiene la sesión actual
	HttpSession sessionA=request.getSession();
	//Obtiene los datos del usuario almacenados en la sesión
	Usuario usuario = (Usuario) sessionA.getAttribute("usuario");

	Location[] locations= amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", codigoCiudadOrigen)
				.and("countryCode", codigoPaisOrigen));
	    		
   Location[] locationsDestino = amadeus.referenceData.locations.get(
			Params.with("subType", "AIRPORT")
				.and("keyword", codigoCiudadDestino)
				.and("countryCode", codigoPaisDestino));
   	
	   FlightOfferSearch[] flightOffers = amadeus.shopping.flightOffersSearch.get(
            Params.with("originLocationCode", codigoCiudadOrigen)
                    .and("destinationLocationCode", codigoCiudadDestino)
                    .and("departureDate", fechaEntrada)
                    .and("returnDate", fechaSalida)
                    .and("adults", numeroPersonas)
                    .and("nonStop", true)
                    .and("currencyCode", "EUR")
                    .and("max", 10));
	%>
                   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Vuelos</title>
<link rel="icon" type="image/jpeg" href="Resources/logo_03.png">
<%
try{

    if (usuario.getTema() == false) {
%>
		<link rel="stylesheet" href="Styles/Ofertas_Vuelos/cssOfertas_Vuelos_Claro.css">
<%
    } else {
%>
		<link rel="stylesheet" href="Styles/Ofertas_Vuelos/cssOfertas_Vuelos_Oscuro.css">
<%
    }
%>
	
</head>	
	

<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada ofertasTransporte");
%>	
	<header id="Cabecero">
		<form id="form_cabecero" action="LoginController?opcion=perfil" method="post">
			<%sessionA.setAttribute("usuario", usuario); %>
			<input id="Cancelar" type="submit" value="cancelar">
		
		</form>
	</header>
<%
	try{
		if(flightOffers[0].getId()!=null){%>
			<div id="Ofertas">
<% 
				for(int j=0;j<flightOffers.length;j++){
					try{
					
				
						Itinerary[]itineraries=flightOffers[j].getItineraries();
						TravelerPricing[]pricings=flightOffers[j].getTravelerPricings();
						FareDetailsBySegment[]bySegments=pricings[0].getFareDetailsBySegment();
						int a = j + 1;
%>	
					
						<table id="Tabla">
						
							<tr>
							    <th colspan="4" class="Contenedor_Titulo">
							    	<p class="Titulo">Vuelo <%=a%><p>
							    </th>	
							</tr>
							<tr>
							    <th colspan="2" class="Contenedor_Subtitulo">
							    	<p class="Subtitulo">Ida<p>
							    </th>
							    <th colspan="2" class="Contenedor_Subtitulo">
							    	<p class="Subtitulo">Vuelta<p>
							    </th>	
							</tr>
							<tr class="Filas">
<%
								for(int x=0;x<2;x++){
									SearchSegment[]searchSegments=itineraries[x].getSegments();
								
									if(x==0){
%>
										<td class="Columna_1">Compañía aérea</td>
										<td class="Columna_2"><%= searchSegments[0].getCarrierCode() %></td>
<% 
									}
									else if(x>0){
%>
										<td class="Columna_3">Compañía aérea</td>
										<td class="Columna_4"><%= searchSegments[0].getCarrierCode() %></td>
<%				
									}
								} 
%>			
							</tr>
							<tr class="Filas">
<%
								for(int x=0;x<2;x++){
									SearchSegment[]searchSegments=itineraries[x].getSegments();
								
									if(x==0){
%>
										<td class="Columna_1">Aeropuerto</td>
										<td class="Columna_2"><%= locations[0].getName() %></td>
<% 
									}
									else if(x>0){
%>
										<td class="Columna_3">Aeropuerto</td>
										<td class="Columna_4"><%= locationsDestino[0].getName() %></td>
<%				
									}
								} 
%>			
							</tr>
							<tr class="Filas">
<%
								for(int x=0;x<2;x++){
									SearchSegment[]searchSegments=itineraries[x].getSegments();
								
									if(x==0){
%>
										<td class="Columna_1">Terminal</td>
<%
										if (searchSegments[0].getDeparture().getTerminal() == null){
%>							
											<td class="Columna_2">Única terminal que hay</td>
<%							
										}
										else {
%>							
											<td class="Columna_2"><%= searchSegments[0].getDeparture().getTerminal() %></td>
<%	
										}
				
									}
									else if(x>0){
%>
										<td class="Columna_3">Terminal</td>
<%
										if (searchSegments[0].getDeparture().getTerminal() == null){
%>							
											<td class="Columna_4">Única terminal que hay</td>
<%							
										}
										else {
%>							
											<td class="Columna_4"><%= searchSegments[0].getDeparture().getTerminal() %></td>
<%	
										}				
									}
								} 
%>			
							</tr>
							<tr class="Filas">
<%
								for(int x=0;x<2;x++){
									SearchSegment[]searchSegments=itineraries[x].getSegments();
								
									if(x==0){
%>
										<td class="Columna_1">Hora de salida</td>
										<td class="Columna_2"><%= searchSegments[0].getDeparture().getAt() %></td>
<% 
									}
									else if(x>0){
%>
										<td class="Columna_3">Hora de salida</td>
										<td class="Columna_4"><%= searchSegments[0].getDeparture().getAt() %></td>
<%				
									}
								} 
%>			
							</tr>
							<tr class="Filas">
<%
								for(int x=0;x<2;x++){
									SearchSegment[]searchSegments=itineraries[x].getSegments();
								
									if(x==0){
%>
										<td class="Columna_1">Hora de llegada</td>
										<td class="Columna_2"><%= searchSegments[0].getArrival().getAt() %></td>
<% 
									}
									else if(x>0){
%>
										<td class="Columna_3">Hora de llegada</td>
										<td class="Columna_4"><%= searchSegments[0].getArrival().getAt() %></td>
<%				
									}
								} 
%>			
							</tr>			
							<tr class="Filas">
				
								<td colspan="2" class="Columna_1">Precio por Billete</td>
								<td colspan="2" class="Columna_2"><%=pricings[0].getPrice().getTotal()+"/ "+pricings[0].getPrice().getCurrency() %></td>
							</tr>
							<tr class="Filas">
				
								<td colspan="2" class="Columna_1">Precio Total</td>
								<td colspan="2" class="Columna_2"><%=flightOffers[j].getPrice().getTotal()+"/"+flightOffers[j].getPrice().getCurrency()%></td>
							</tr>
							
							<tr class="Filas">
								<td colspan="4" class="Columna_1">
									<form name="guardarOfertaViaje"
										action="LoginController?opcion=guardarOfertaViaje" method="post">
										<input type="hidden" name="aeropuertoOrigen" value="<%=locations[0].getName()%>">
										<input type="hidden" name="ciudadOrigen" value="<%=locations[0].getAddress().getCityName()%>">
										<input type="hidden" name="companiaAerea" value="<%=locations[0].getName()%>">
										<input type="hidden" name="ciudadDestino" value="<%=locationsDestino[0].getAddress().getCityName()%>">
										<input type="hidden" name="aeropuertoDestino" value="<%=locationsDestino[0].getName()%>">
										<input type="hidden" name="tipoViajero" value="<%=pricings[0].getTravelerType()%>">
										<input type="hidden" name="precioMedio" value="<%=flightOffers[j].getPrice().getTotal()%>">
										<input type="hidden" name="claseCabina" value="<%=bySegments[0].getCabin()%>">
										<input type="hidden" name="numeroPersonasViaje" value="<%=numeroPersonas %>">
										
										<input class="Botones" type="submit" value="Guardar">
									</form>
								</td>
							</tr>
						</table>
					
<% 
					}catch(ArrayIndexOutOfBoundsException e){
						System.out.println("No hay mas viajes");
						break;
					}
				}
%>
			</div>
<%

		}
	}catch(ArrayIndexOutOfBoundsException e){
%>

	<script>
		window.onload= function(){
			alert('Redirigiendo a la busqueda de hotel \n'+
				'NO HAY VUELOS DISPONIBLES PARA LA CIUDAD\n '<%=direccion.getNombre_ciudad()%>', '<%= direccion.getCodigo_pais()%>'.'));
		}
		
	</script>
<%
		sessionA.setAttribute("usuario",usuario);
		response.sendRedirect("Secure/nuevoViaje.jsp");		
	}
	
	}catch(NullPointerException e){
%>
<head>
	<link rel="stylesheet" href="Styles/Ofertas_Vuelos/cssOfertas_Vuelos_Oscuro.css">
</head>
<body>
	<form name="tema" action="LoginController" method="POST">
			<input type="hidden" name="opcion" value="Loger">
	
			<div class="Contenedor_SesionCerrada">
				<p id="Titulo">UPS</p>
				<p id="Texto">
					<img id="imgAdvertencia" src="Resources/advertencia.png">
					Tu sesión está cerrada 
					<img id="imgAdvertencia" src="Resources/advertencia.png">
				</p>
				<p id="Texto">Inicia sesión otra vez.</p>
				<input id="Boton_Loger" type="submit" value="Volver a iniciar sesion">
			</div>
		</form>
<%
}
%>
</body>
</html>