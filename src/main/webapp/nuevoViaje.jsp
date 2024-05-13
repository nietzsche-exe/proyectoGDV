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
%>
</head>
<body>

<h1>Buscar un hotel</h1>


<h3>(El nombre de las ciudades deben ser en ingles)</h3>
	<form name="buscar" action="LoginController" method="post">
		<input type="hidden" name="opcion" value="buscarHotel">
		
		<label>Buscar hoteles de un Ciudad</label><br>
		<input type="text" name="destino"id="destino" required="required"><br>
		
		<label>Filtros de busqueda:</label><br>
		<label>Fecha de entrada</label><br>
		<input type="date" name="fechaEntrada" required="required" min="<%= LocalDate.now()%>"><br>
		<label>Fecha de salida</label><br>
		<input type="date" name="fechaSalida" required="required" min="<%= LocalDate.now()%>" ><br>
		<label>Numero de personas</label><br>
		<input type="number" name="numeroPersonas" min="1" max="5" required="required" value="1"><br>
		<input id="busca" type="submit"  value="Buscar"> <br>
		
	</form>
	
	
</body>
</html>