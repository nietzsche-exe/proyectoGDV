<%@page import="util.HotelData"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONArray"%>
<%@page import="modelo.Usuario" %>
<%@page import="java.util.stream.Collectors" %>
<%@page import="controlador.LoginController"%>
<%@page import="util.ConfigLoader"%>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hoteles</title>
<%
    ConfigLoader configLoader = new ConfigLoader();
    HttpSession sessionA = request.getSession();
    Usuario usuario = (Usuario) sessionA.getAttribute("usuario");

    List<HotelData> listaHoteles = (List<HotelData>) request.getAttribute("listaHoteles");

    JSONArray latitudesJson = new JSONArray();
    JSONArray longitudesJson = new JSONArray();

    for (HotelData hotel : listaHoteles) {
        latitudesJson.put(hotel.getLatitud());
        longitudesJson.put(hotel.getLongitud());
    }

    String latitudesJsonStr = latitudesJson.toString();
    String longitudesJsonStr = longitudesJson.toString();    
%>

<%

    if (usuario.getTema() == false) {
%>
	<style>
	    body {
	        background-color: #BDFFBC;
	        color: #333333;
	        font-family: Arial, sans-serif;
	        margin: 0%;
	        background-image: url("");
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
			background-color: #f7f7f7;
			border-radius: 10px;
		}
			
		#Tabla {
		  	display: inline-block;
			margin-top: 3%;
		  	width: 25%;
		  	margin-left: 6%;
		  	border-collapse: collapse;
			border-top-right-radius: 10px;
			border-top-left-radius: 10px;
		  	border-color: #888;
		  	margin-bottom: 3%;
		  	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
		}
		
		.Contenedor_Titulo {
			background-color: #f2f2f2;
			text-align: left;
			padding: 1.5%;
			border-top-right-radius: 10px;
			border-top-left-radius: 10px;
		}
		
		.Titulo {
			font-size: large;
			color: #353535;
			text-align: left;
		}
		
		.Texto {
			font-size: x-small;
			color: #444746;
		}
		
		.Filas:nth-child(even) {
		  	background-color: #ffffff;
		}
		
		.Filas:nth-child(odd) {
		  	background-color: #f9f9f9;
		}
		
		.Columna_1, .Columna_2 {
		  	padding: 2%;
			color: #444746;
		}
		.Columna_1 {
			font-size: small;
		}
		.Columna_2 {
			font-size: medium;
			padding-left: 2%;
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
		  	background-color: #CCCCCC;
		  	cursor: not-allowed;
		}
		.Botones:hover {
			opacity: 0.8;
		}
	
	    #map {
		    margin-top: 20px;
		    height: 500px; 
		    width: 90%;
		    margin-left: 5%;
		    border-radius: 10px;
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
		    background-image: url("");
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
		    background-color: #2c2c2c;
		    border-radius: 10px;
		}
		
		#Tabla {
		    display: inline-block;
		    margin-top: 3%;
		    width: 25%;
		    margin-left: 6%;
		    border-collapse: collapse;
		    border-top-right-radius: 10px;
		    border-top-left-radius: 10px;
		    border-color: #444;
		    margin-bottom: 3%;
		    box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.7);
		}
		
		.Contenedor_Titulo {
		    background-color: #3c3c3c;
		    text-align: left;
		    padding: 1.5%;
		    border-top-right-radius: 10px;
		    border-top-left-radius: 10px;
		}
		
		.Titulo {
		    font-size: large;
		    color: #e0e0e0;
			text-align: left;
		}
		
		.Texto {
		    font-size: x-small;
		    color: #c0c0c0;
		}
		
		.Filas:nth-child(even) {
		    background-color: #2c2c2c;
		}
		
		.Filas:nth-child(odd) {
		    background-color: #3c3c3c;
		}
		
		.Columna_1, .Columna_2 {
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
		
		#map {
		    margin-top: 20px;
		    height: 500px; 
		    width: 90%;
		    margin-left: 5%;
		    border-radius: 10px;
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
		
		<input type="hidden" class="latitude" value='<%= latitudesJsonStr %>'>
		<input type="hidden" class="longitude" value='<%= longitudesJsonStr %>'>
		<h1 class="Titulo">Ciudad: ${param.destino}</h1>
	</header>

	
	
<%
	if(!listaHoteles.isEmpty()){
%>
		<div id="map"></div>
		
		<div id="Ofertas">
<%
	for (int i = 0; i < listaHoteles.size(); i++) {
		HotelData hotel = listaHoteles.get(i);
		System.out.println(hotel.toString());
%>
			<table id="Tabla">
			<!--  -->
			
				<tr>
				    <th colspan="2" class="Contenedor_Titulo">
				    	<p class="Titulo"><%=hotel.getNombre() %><p>
				    </th>	
				</tr>
				
				<tr class="Filas">
					<td class="Columna_1">Dirección</td>
					<td class="Columna_2" id="direccion_<%=i%>" data-index="<%=i%>"><%= hotel.getDireccion() %></td>

				</tr>
				<tr class="Filas">
					<td class="Columna_1">Fecha de entrada</td>
					<td class="Columna_2"><%= hotel.getFechaEntrada() %></td>
				</tr>
				<tr class="Filas">
					<td class="Columna_1">Fecha de salida</td>
					<td class="Columna_2"><%= hotel.getFechaSalida() %></td>
				</tr>
				<tr class="Filas">
					<td class="Columna_1">Nº camas/Habitaciones</td>
					<td class="Columna_2"><%= hotel.getNumeroCamas() %></td>
				</tr>
				<tr class="Filas">
					<td class="Columna_1">Descripcion</td>
					<td class="Columna_2"><%= hotel.getDescripcion() %></td>
				</tr>
				<tr class="Filas">
					<td class="Columna_1">Precio por noche</td>
					<td class="Columna_2"><%= hotel.getPrecioNoche() %></td>
				</tr>
				<tr class="Filas">
					<td class="Columna_1">Precio Total</td>
					<td class="Columna_2"><%= hotel.getPrecioTotal() %></td>
				</tr>
				<tr class="Filas">
					
					<form name="guardarOfertaHotel" action="LoginController?opcion=guardarOfertaHotel" method="post">
						<input type="hidden" name="hotelId" value="<%= hotel.getCodigoHotel() %>">
						<input type="hidden" name="nombreHotel" value="<%= hotel.getNombre() %>">
						<input type="hidden" name="direccionHotel" value="">
						<input type="hidden" name="latitudHotel" value="<%= hotel.getLatitud() %>">
						<input type="hidden" name="longitudHotel" value="<%=hotel.getLongitud() %>">
			                    
						<input type="hidden" name="codigoIATAPaisDestino" value="<%= hotel.getCodPaisDestino()%>">
						<input type="hidden" name="nombrePaisDestino" value="<%= hotel.getNomPaisDestino() %>">
						<input type="hidden" name="codigoIATACiudadDestino" value="<%= request.getAttribute("codIATACiudadDestino") %>">
						<input type="hidden" name="nombreCiudadDestino" value="<%= request.getAttribute("nombreCiudadDestino") %>">
			                    
						<input type="hidden" name="idHabitacion" value="<%= hotel.getIdOferta() %>">
			            <input type="hidden" name="fechaEntrada2" value="<%= hotel.getFechaEntrada() %>">
			            <input type="hidden" name="fechaSalida2" value="<%= hotel.getFechaSalida() %>">
			            <input type="hidden" name="habitacionDisponible" value="<%= hotel.isDisponible() ? 1 : 0 %>">
			            <input type="hidden" name="numeroCamas" value="<%= hotel.getNumeroCamas() %>">
			            <input type="hidden" name="tipoDeCama" value="<%= hotel.getTipoCama() %>">
			            <input type="hidden" name="precioNoche" value="<%= hotel.getPrecioNoche() %>">
			           	<input type="hidden" name="precioTotal" value="<%= hotel.getPrecioTotal() %>">
			            <input type="hidden" name="numeroPersonas2" value="<%= request.getAttribute("numeroPersonas") %>">
			            <input type="hidden" name="codigoIATACiudadOrigen" value="<%= request.getAttribute("codCiudadOrigen") %>">
			            <input type="hidden" name="codigoIATAPaisOrigen" value="<%= request.getAttribute("codigoPaisOrigen") %>">
			            
			            <%sessionA.setAttribute("usuario", usuario); %>
					
						<td colspan="2" class="Columna_1"> <input class="Botones" type="submit" value="Reservar"> </td>
					</form>
			
				</tr>
				
			
			</table>
<%
			}
%>
		</div>
		<div id="direcciones"></div>
		<script src="JavaScript/map.js"></script>
		<script async defer src="https://maps.googleapis.com/maps/api/js?key=<%=configLoader.getProperty("util.apiKeyMap")%>&callback=iniciarMap&loading=async"></script>
		
<%
	}else{
		request.getSession().setAttribute("usuario", usuario);
		response.sendRedirect("perfilUsuario.jsp");
	}

%>

</body>
</html>