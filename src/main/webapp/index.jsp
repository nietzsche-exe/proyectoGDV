<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.slf4j.Logger" %>
<%@ page import="org.slf4j.LoggerFactory" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Apsoca</title>
<link rel="icon" type="image/jpeg" href="Resources/logo_03.png">
<link rel="stylesheet" href="Styles/Pagina_Principal/cssIndex.css">
</head>
<body>
<%
    Logger logger = LoggerFactory.getLogger("MiLogger");
    logger.info("Página JSP cargada index.jsp");
%>
    <header class="Encabezado">
        <div class="Contenedor_Logo">
            <img id="logo" alt="Logo" src="Resources/logo_2.0.jpeg">
        </div>
        <div class="Contenedor_Botones">
            <button id="btnQuienSomos" class="Botones"><b>Quienes Somos</b></button>
            <button id="btnManualUsuario" class="Botones"><b>Manual Usuario</b></button>
            <button id="btnIniciarSesion" class="Botones"><b>Iniciar Sesión</b></button>
            <button id="btnRegistro" class="Botones"><b>Registrarse</b></button>
        </div>
    </header>
    
	<div id="Contenedor_cuerpo">
		<div class="Contenedor_titulo">
			<p id="Titulo">En caso de incidencias contacte con uno de los siguientes correo explicandoles su incidencia</p>
		</div>
		<div class="Contenedor_texto">
			<label class="Nombre">Jose Julian</label>
			<label class="Gmail">soy.jjulian@gmail.com</label>
			<label class="Nombre">Álvaro Aparicio</label>
			<label class="Gmail">alvaro.04apa@gmail.com</label>
			<label class="Nombre">Carlos Vlelasco</label>
			<label class="Gmail">caaarlosvelasco@gmail.com</label>
		</div>
	</div>
    <script>
        // Función para redirigir al usuario a la página de inicio de sesión
        function redirectToLoginPage() {
            window.location.href = "login.jsp"; // Cambia "login.jsp" por la ruta de tu página de inicio de sesión
        }

        // Función para redirigir al usuario a la página de registro
        function redirectToRegistroPage() {
            window.location.href = "registro.jsp"; // Cambia "registro.jsp" por la ruta de tu página de registro
        }
        
        function redirectToQuienSomos() {
            window.location.href = "quienSomos.jsp"; // Cambia "quienSomos.jsp" por la ruta de tu página de inicio de sesión
        }

        // Función para descargar el PDF
        function redirectToManualUsuario() {
            window.location.href = "Manual/Manual_de_uso_aplicacion_GDV.pdf"; // Cambia "Resources/tu_archivo.pdf" por la ruta de tu archivo PDF
        }

        // Agregar event listeners a los botones
        document.getElementById("btnIniciarSesion").addEventListener("click", redirectToLoginPage);
        document.getElementById("btnRegistro").addEventListener("click", redirectToRegistroPage);
        document.getElementById("btnQuienSomos").addEventListener("click", redirectToQuienSomos);
        document.getElementById("btnManualUsuario").addEventListener("click", redirectToManualUsuario);
    </script>

</body>
</html>
