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
<link rel="icon" type="image/jpeg" href="Resources/logo_03.png">
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
try{
    if (usuario.getTema() == false) {
%>
	<link rel="stylesheet" href="Styles/Ofertas_Hoteles/cssOfertasHoteles_Claro.css">
<%
    } else {
%>
		<link rel="stylesheet" href="Styles/Ofertas_Hoteles/cssOfertasHoteles_Oscuro.css">
<%
    }
%>
	
</head>

<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada ofertasHoteles");
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
<%
}catch(NullPointerException e){
	%>
<head>
	<link rel="stylesheet" href="Styles/Ofertas_Hoteles/cssOfertasHoteles_Oscuro.css">
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