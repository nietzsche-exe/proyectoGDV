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
		    color: #E0E0E0;
		    font-family: Arial, sans-serif;
		}
		
		h1 {
		    color: #FFFFFF;
		}
		
		table {
			margin-top: 1%;
			margin-bottom: 1%;
		    width: 100%;
		    border-collapse: collapse;
		    background-color: #1E1E1E;
		}
		
		th, td {
	        font-size: 30%;
		    border: 2px solid #333333;
		    padding: 8px;
		    text-align: left;
		}
		
		th {
		    background-color: #333333;
		    color: #FFFFFF;
		}
		
		td {
		    background-color: #1E1E1E;
		    color: #E0E0E0;
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
		    font-size: 30%;
		}
		
		input[type="submit"]:hover {
		    background-color: #45a049;
		}
		
		#map {
		    margin-top: 20px;
		}
		
		p {
		    color: #E0E0E0;
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
			<input type="submit" value="cancelar">
		
		</form>
	</header>

<input type="hidden" class="latitude" value='<%= latitudesJsonStr %>'>
<input type="hidden" class="longitude" value='<%= longitudesJsonStr %>'>
<h1>Ciudad: ${param.destino}</h1>

<%if(!listaHoteles.isEmpty()){
	%>
<div id="map" style="height: 500px; width: 100%;"></div>

<table>
    <thead>
        <tr>
            <th>Nombre Hotel</th>
            <th>Direccion</th>
            <th>Codigo Hotel</th>
            <th>Id Oferta</th>
            <th>Fecha de entrada</th>
            <th>Fecha de salida</th>
            <th>Valoracion</th>
            <th>Disponible</th>
            <th>Hab. Tipo</th>
            <th>Hab. Categoria</th>
            <th>Nº camas/Hab</th>
            <th>Tipo Camas</th>
            <th>Descripcion</th>
            <th>Acompañantes</th>
            <th>Precio por noche/Total</th>
            <th>Accion</th>
        </tr>
    </thead>
    <tbody>
    <%
        for (HotelData hotel : listaHoteles) {
    %>
        <tr>
            <td><%= hotel.getNombre() %></td>
            <td ><%= hotel.getDireccion() %></td>
            <td><%= hotel.getCodigoHotel() %></td>
            <td><%= hotel.getIdOferta() %></td>
            <td><%= hotel.getFechaEntrada() %></td>
            <td><%= hotel.getFechaSalida() %></td>
            <td><%= hotel.getValoracion() %></td>
            <td><%= hotel.isDisponible() ? "Sí" : "No" %></td>
            <td><%= hotel.getTipoHabitacion() %></td>
            <td><%= hotel.getCategoriaHabitacion() %></td>
            <td><%= hotel.getNumeroCamas() %></td>
            <td><%= hotel.getTipoCama() %></td>
            <td><%= hotel.getDescripcion() %></td>
            <td>Adultos: <%= hotel.getNumeroAdultos() %> <br> Niños: <%= hotel.getNumeroNinos() %></td>
            <td><%= hotel.getPrecioNoche() %> / <%= hotel.getPrecioTotal() %></td>
            <td>
                <form name="guardarOfertaHotel" action="LoginController?opcion=guardarOfertaHotel" method="post">
                    <input type="hidden" name="hotelId" value="<%= hotel.getCodigoHotel() %>">
                    <input type="hidden" name="nombreHotel" value="<%= hotel.getNombre() %>">
                    <input type="hidden" name="direccionHotel" value="">
                    
                    <input type="hidden" name="codigoIATAPaisDestino" value="<%= hotel.getCodPaisDestino()%>">
                    <input type="hidden" name="nombrePaisDestino" value="<%= hotel.getNomPaisDestino() %>">
                    <input type="hidden" name="codigoIATACiudadDestino" value="<%= request.getAttribute("codIATA") %>">
                    <input type="hidden" name="nombreCiudadDestino" value="<%= request.getAttribute("nombreCiudad") %>">
                    
                    <input type="hidden" name="idHabitacion" value="<%= hotel.getIdOferta() %>">
                    <input type="hidden" name="fechaEntrada2" value="<%= hotel.getFechaEntrada() %>">
                    <input type="hidden" name="fechaSalida2" value="<%= hotel.getFechaSalida() %>">
                    <input type="hidden" name="habitacionDisponible" value="<%= hotel.isDisponible() ? 1 : 0 %>">
                    <input type="hidden" name="numeroCamas" value="<%= hotel.getNumeroCamas() %>">
                    <input type="hidden" name="tipoDeCama" value="<%= hotel.getTipoCama() %>">
                    <input type="hidden" name="precioNoche" value="<%= hotel.getPrecioNoche() %>">
                    <input type="hidden" name="precioTotal" value="<%= hotel.getPrecioTotal() %>">
                    <input type="hidden" name="numeroPersonas2" value="<%= request.getAttribute("numeroPersonas") %>">
                    <input type="hidden" name="codigoIATA2" value="<%= request.getAttribute("codIATA") %>">
                    <input type="hidden" name="codigoIATAPaisOrigen" value="ES">
                    <%sessionA.setAttribute("usuario", usuario); %>
                    <input type="submit" value="Reservar">
                </form>
            </td>
        </tr>
    <%
        }
    %>
    </tbody>
</table>
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