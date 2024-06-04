
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
	<%
	try{
    if (usuario.getTema() == false) {
%>
	<style>
		body {
		    background-color: #f0f0f0;
		    color: #333333;
		    font-family: Arial, sans-serif;
		    margin: 0;
		}
		
		#Cabecero {
		    background-color: #ffffff;
		    padding: 10px;
		    text-align: right;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		#form_cabecero {
		    display: inline;
		}
		
		#Cancelar {
		    background-color: #4CAF50;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    text-align: center;
		    text-decoration: none;
		    font-size: 16px;
		    cursor: pointer;
		    border-radius: 4px;
		}
		
		#Cancelar:hover {
		    background-color: #45a049;
		}
		
		#Ofertas {
		    margin-top: 2%;
		    margin-left: 5%;
		    margin-bottom: 1%;
		    width: 90%;
		    background-color: #ffffff;
		    border-radius: 10px;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
		}
		
		#Tabla {
		    display: inline-block;
		    margin-top: 3%;
		    width: 30%;
		    margin-left: 13%;
		    border-collapse: collapse;
		    border-top-right-radius: 10px;
		    border-top-left-radius: 10px;
		    margin-bottom: 3%;
		    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
		}
		
		.Contenedor_Titulo {
		    background-color: #f8f8f8;
		    text-align: center;
		    padding: 1.5%;
		    border-top-right-radius: 10px;
		    border-top-left-radius: 10px;
		}
		
		.Contenedor_Subtitulo {
		    background-color: #f8f8f8;
		    text-align: center;
		    padding: 1.5%;
		    border-bottom: solid 1px #ddd;
		}
		
		.Titulo {
		    font-size: x-large;
		    color: #333333;
		}
		
		.Subtitulo {
		    font-size: large;
		    color: #333333;
		}
		
		.Texto {
		    font-size: x-small;
		    color: #666666;
		}
		
		.Filas:nth-child(even) {
		    background-color: #f9f9f9;
		}
		
		.Filas:nth-child(odd) {
		    background-color: #ffffff;
		}
		
		.Columna_1, .Columna_2, .Columna_3, .Columna_4 {
		    padding: 2%;
		    color: #666666;
		}
		
		.Columna_1 {
		    font-size: small;
		}
		
		.Columna_2 {
		    font-size: medium;
		    padding-left: 2%;
		}
		
		.Columna_3 {
		    font-size: small;
		    padding-left: 2%;
		    border-left: solid 1px #ddd;
		}
		
		.Botones {
		    background-color: #4CAF50;
		    border: none;
		    color: white;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: small;
		    margin: 1.5%;
		    cursor: pointer;
		    border-radius: 5px;
		    padding: 2%;
		}
		
		.Botones:disabled {
		    background-color: #aaa;
		    cursor: not-allowed;
		}
		
		.Botones:hover {
		    opacity: 0.8;
		}


	</style>
<%
    } else {
%>
	<style>
		body {
			background-color: #1e1e1e;
		    color: #e0e0e0;
		    font-family: Arial, sans-serif;
		    margin: 0;
		}
		
		#Cabecero {
		    background-color: #2c2c2c;
		    padding: 10px;
		    text-align: right;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.5);
		}
		
		#form_cabecero {
		    display: inline;
		}
		
		#Cancelar {
		    background-color: #4CAF50;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    text-align: center;
		    text-decoration: none;
		    font-size: 16px;
		    cursor: pointer;
		    border-radius: 4px;
		}
		
		#Cancelar:hover {
		    background-color: #45a049;
		}
		
		#Ofertas {
		    margin-top: 2%;
		    margin-left: 5%;
		    margin-bottom: 1%;
		    width: 90%;
		    background-color: #4c4c4c;
		    border-radius: 10px;
		}
		
		#Tabla {
		    display: inline-block;
		    margin-top: 3%;
		    width: 30%;
		    margin-left: 13%;
		    border-collapse: collapse;
		    border-top-right-radius: 10px;
		    border-top-left-radius: 10px;
		    margin-bottom: 3%;
		    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.7);
		}
		
		.Contenedor_Titulo {
		    background-color: #3c3c3c;
		    text-align: center;
		    padding: 1.5%;
		    border-top-right-radius: 10px;
		    border-top-left-radius: 10px;
		}
		.Contenedor_Subtitulo {
			background-color: #3c3c3c;
			text-align: center;
			padding: 1.5%;
			border-bottom: solid;
			border-bottom-color: gray;
		}
		
		.Titulo {
		    font-size: x-large;
		    color: #e0e0e0;
		}
		
		.Subtitulo {
		    font-size: large;
		    color: #e0e0e0;
		}
		
		.Texto {
		    font-size: x-small;
		    color: #c0c0c0;
		}
		
		.Filas:nth-child(even) {
		    background-color: #3c3c3c;
		}
		
		.Filas:nth-child(odd) {
		    background-color: #2c2c2c;
		}
		
		.Columna_1, .Columna_2, .Columna_3, .Columna_4{
		    padding: 2%;
		    color: #c0c0c0;
		}
		
		.Columna_1 {
		    font-size: small;
		}
		
		.Columna_2 {
		    font-size: medium;
		    padding-left: 2%;
		}
		
		.Columna_3 {
		    font-size: small;
		    padding-left: 2%;
		    border-left: solid;
		    border-left-color: gray;
		}
		.Botones {
		    background-color: #4CAF50;
		    border: none;
		    color: white;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: small;
		    margin: 1.5%;
		    cursor: pointer;
		    border-radius: 5px;
		    padding: 2%;
		}
		
		.Botones:disabled {
		    background-color: #555;
		    cursor: not-allowed;
		}
		
		.Botones:hover {
		    opacity: 0.8;
		}
				
	</style>

<%
    }
%>
	
</head>	
	

<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada");
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
	}catch( ArrayIndexOutOfBoundsException e){
%>

	<script>alert("Redirigiendo a la busqueda destinos \n"+
			"NO HAY VUELOS DISPONIBLES PARA LA CIUDAD\n "<%=direccion.getNombre_ciudad()%>", "<%= direccion.getCodigo_pais()%>)</script>
	
<%
		sessionA.setAttribute("usuario",usuario);
		response.sendRedirect("Secure/nuevoViaje.jsp");		
	}
	
	}catch(NullPointerException e){
%>
<form name="tema" action="../LoginController" method="POST">
			<input type="hidden" name="opcion" value="Loger">
	
			<div class="Contenedor_SesionCerrada">
				<p id="Titulo">UPS</p>
				<p id="Texto">
					<img id="imgAdvertencia" src="../Resources/advertencia.png">
					Tu sesión está cerrada 
					<img id="imgAdvertencia" src="../Resources/advertencia.png">
				</p>
				<p id="Texto">Inicia sesión otra vez.</p>
				<input type="submit" value="Volver a iniciar sesion">
			</div>
		</form>
<%
}
%>
</body>
</html>