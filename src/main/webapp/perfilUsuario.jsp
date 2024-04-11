<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Perfil de Usuario</title>
<link rel="stylesheet" href="Styles/cssA.css">
</head>
<body>
	
	
	
	<div id="content-container">
	<button id="btnCreacionViaje">Creacion de viaje</button>
	<button id="btnEliminacionViaje">Eliminacion de Viaje</button>
	    <div id="menu-container">
	        <img src="Resources/perfil.jpg" alt="Menú" id="menu-icon">
	
	        <ul id="menu">
	        	<li id="nada">&nbsp;</li>
	            <li id="usuario">USUARIO</li>
	            <li id="correo">CORREO@CORREO.COM</li>
	            <li>&nbsp;</li>
	            <li><a href="#salir"><img id="imgSalir" src="Resources/salir.jpg"> Cerrar Sesion</a></li>
	            <li><a href="#config"><img id="imgConfig" src="Resources/config.png">Configuración</a></li>
	        </ul>
	    </div>
	</div>
	
	<!-- Script JavaScript para mostrar/ocultar el menú -->
	<script src="JavaScript/script.js"></script>	
</body>
</html>