<%@page import="modelo.HotelData"%>
<%@page import="java.util.List"%>
<%@page import="org.json.JSONArray"%>
<%@page import="modelo.Usuario" %>
<%@ page import="java.util.stream.Collectors" %>
<%@page import="controlador.LoginController"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Resultado Hoteles</title>
<%
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
	        background-color: #f5f5f5;
	        color: #333333;
	        font-family: Arial, sans-serif;
	        
	    }
	
	    h1, h2 {
	        color: #333333;
	    }
	
	    table {
	    	margin-top: 1%;
			margin-bottom: 1%;
	        width: 100%;
	        border-collapse: collapse;
	        background-color: #ffffff;
	    }
	
	    th, td {
	        font-size: 80%;
	        border: 2px solid #dddddd;
	        padding: 8px;
	        text-align: left;
	    }
	
	    th {
	        background-color: #f2f2f2;
	        color: #333333;
	    }
	
	    td {
	        background-color: #ffffff;
	        color: #333333;
	    }
	
	    input[type="submit"] {
	        background-color: #4CAF50;
	        color: white;
	        border: none;
	        padding: 10px 20px;
	        text-align: center;
	        text-decoration: none;
	        display: inline-block;
	        font-size: 16px;
	        margin: 4px 2px;
	        cursor: pointer;
	        border-radius: 4px;
		    font-size: 80%;
	    }
	
	    input[type="submit"]:hover {
	        background-color: #45a049;
	    }
	
	    #map {
	        margin-top: 20px;
	        height: 500px; 
	        width: 100%;
	    }
	
	    p {
	        color: #333333;
	    }
	
	    form {
	        margin: 0;
	    }
	
	    input[type="hidden"] {
	        display: none;
	    }
	</style>
<%
    } else {
%>
	<style>
		body {
		    background-color: #121212;
		    color: #e0e0e0;
		    font-family: Arial, sans-serif;
		}
		
		h1, h2 {
		    color: #e0e0e0;
		}
		
		table {
		    margin-top: 1%;
		    margin-bottom: 1%;
		    width: 100%;
		    border-collapse: collapse;
		    background-color: #1e1e1e;
		}
		
		th, td {
		    font-size: 80%;
		    border: 2px solid #333333;
		    padding: 8px;
		    text-align: left;
		}
		
		th {
		    background-color: #333333;
		    color: #e0e0e0;
		}
		
		td {
		    background-color: #1e1e1e;
		    color: #e0e0e0;
		}
		
		input[type="submit"] {
		    background-color: #4CAF50;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    text-align: center;
		    text-decoration: none;
		    display: inline-block;
		    font-size: 16px;
		    margin: 4px 2px;
		    cursor: pointer;
		    border-radius: 4px;
		    font-size: 80%;
		}
		
		input[type="submit"]:hover {
		    background-color: #45a049;
		}
		
		#map {
		    margin-top: 20px;
		}
		
		p {
		    color: #e0e0e0;
		}
		
		form {
		    margin: 0;
		}
		
		input[type="hidden"] {
		    display: none;
		}
	</style>

<%
    }
%>
	
</head>

<body>

	<header>
		<form action="LoginController?opcion=perfil" method="post">
			<%sessionA.setAttribute("usuario", usuario); %>
			<input class="Botones" type="submit" value="cancelar">
		
		</form>
	</header>

	<input type="hidden" class="latitude" value='<%= latitudesJsonStr %>'>
	<input type="hidden" class="longitude" value='<%= longitudesJsonStr %>'>
	<h1 class="Titulo">Ciudad: ${param.destino}</h1>
	
<%
	if(!listaHoteles.isEmpty()){
%>
		<div id="map"></div>
		
		<div id="Ofertas">
<%
			for (HotelData hotel : listaHoteles) {
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
					<td class="Columna_2" ><%= hotel.getDireccion() %></td>
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
						<input type="hidden" name="nombreCiudadDestino" value="<%= request.getAttribute("nomCiudadDestino") %>">
			                    
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
					
						<td colspan="2" class="Columna_1"> <input class="" type="submit" value="Reservar"> </td>
					</form>
			
				</tr>
				
			
			</table>
<%
			}
%>
		</div>
		
<%
	}else{
		request.getSession().setAttribute("usuario", usuario);
		response.sendRedirect("perfilUsuario.jsp");
	}
%>

<div id="direcciones"></div>
<script src="JavaScript/map.js"></script>
<script src="JavaScript/geolocalizacion.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBm0vNj92eB8yjWcFe8ieb9doiwDVf2jO0&callback=iniciarMap"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCZuB7bki3m-dvgWkWfcclEjfwSDxVAlXo&callback=obtenerTodasLasDirecciones"></script>
</body>
</html>