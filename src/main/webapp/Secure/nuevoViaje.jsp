<%@page import="java.time.LocalDate"%>
<%@page import="modelo.Usuario"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%
// Obtiene la sesión actual
HttpSession a = request.getSession();
// Obtiene los datos del usuario almacenados en la sesión
Usuario usuario = (Usuario) a.getAttribute("usuario");

System.out.println("Informacion usuario actual: "+usuario.toString());

if (usuario.getTema()==true) {
%>
    <link rel="stylesheet" href="../Styles/Busqueda_Viaje/cssBusquedaViaje_Oscuro.css">
<%
} else {
%>
    <link rel="stylesheet" href="../Styles/Busqueda_Viaje/cssBusquedaViaje_Claro.css">
<%    
}
%>
<script src="../JavaScript/nuevoViaje.js"></script>

<script>
        window.onload = function() {
            const urlParams = new URLSearchParams(window.location.search);
            const errorParam = urlParams.get('error');
            if (errorParam === 'ciudades') {
                alert('No se han encontrado datos para las ciudades ingresadas.');
            } else if (errorParam === 'hoteles') {
                alert('No se han encontrado hoteles u ofertas de hotel para el destino ingresado.');
            }
        }
    </script>
</head>
<body>

	<header id="Cabecero">
		<form id="form_cabecero" action="../LoginController" method="post">
			<input type="hidden" name="opcion" value="perfil">
			<%a.setAttribute("usuario", usuario); %>
			<input id="Cancelar" type="submit" value="cancelar">
		
		</form>
	</header>
	
	<div id="Contenedor_Principal">
	
	    <div class="Contenedor_Titulo">
	        <h1 class="Titulo">Buscar un hotel</h1>
	        <h3 class="Titulo">(El nombre de las ciudades deben ser en inglés)</h3>
	    </div> 
	     
	    <div class="Contenedor_Busqueda">
	        <form name="buscar" action="../LoginController" method="post" onsubmit="return validateDates()">
	            <input type="hidden" name="opcion" value="buscarHotel">
	            
	            <label class="Textos" for="origen">Origen</label>
	            <input class="Botones" type="text" name="origen" id="origen" required="required">
	            
	            <label class="Textos" for="destino">¿A dónde quieres viajar?</label>
	            <input class="Botones" type="text" name="destino" id="destino" required="required">
	            
	            <label class="Textos" >Filtros de búsqueda:</label>
	            <label class="Textos" for="fechaEntrada">Fecha de entrada</label>
	            <input class="Botones" type="date" name="fechaEntrada" id="fechaEntrada" required="required" min="<%= LocalDate.now()%>" value="<%=LocalDate.now()%>">
	            
	            <label class="Textos" for="fechaSalida">Fecha de salida</label>
	            <input class="Botones" type="date" name="fechaSalida" id="fechaSalida" required="required" min="<%= LocalDate.now()%>" >
	            
	            <label class="Textos" for="numeroPersonas">Número de personas (1 Habitacion)</label>
	            <input class="Botones" type="number" name="numeroPersonas" id="numeroPersonas" min="1" max="5" required="required" value="1">
	            
<%
				a.setAttribute("usuario", usuario); 
%>
	            <input id="busca" type="submit" value="Buscar">
	            
	        </form>
	    </div>
	</div>

	<%

%>
</body>
</html>
