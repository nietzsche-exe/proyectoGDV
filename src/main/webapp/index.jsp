<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Página Principal</title>
<link rel="stylesheet" href="Styles/Pagina_Principal/cssIndex.css">
</head>
<body>


	<header class="Encabezado">
		<div class="Contenedor_Logo">
			<img id="logo" alt="Logo" src="Resources/logo_2.0.jpeg">
		</div>
		<div class="Contenedor_Botones">
			<button id="btnQuienSomos" class="Botones"><b>Quienes Somos</b></button>
	    	<button id="btnIniciarSesion" class="Botones"><b>Iniciar Sesión</b></button>
	    	<button id="btnRegistro" class="Botones"><b>Registrarse</b></button>
		</div>
	</header>


	<script>
        // Función para redirigir al usuario a la página de inicio de sesión
        function redirectToLoginPage() {
            window.location.href = "login.jsp"; // Cambia "pagina-de-inicio-de-sesion.jsp" por la ruta de tu página de inicio de sesión
        }

        // Función para redirigir al usuario a la página de registro
        function redirectToRegistroPage() {
            window.location.href = "registro.jsp"; // Cambia "pagina-de-registro.jsp" por la ruta de tu página de registro
        }
        
        function redirectToQuienSomos() {
            window.location.href = "quienSomos.jsp"; // Cambia "pagina-de-inicio-de-sesion.jsp" por la ruta de tu página de inicio de sesión
        }

        // Agregar un event listener al botón de inicio de sesión para que llame a la función redirectToLoginPage cuando se haga clic en él
        document.getElementById("btnIniciarSesion").addEventListener("click", redirectToLoginPage);

        // Agregar un event listener al botón de registro para que llame a la función redirectToRegistroPage cuando se haga clic en él
        document.getElementById("btnRegistro").addEventListener("click", redirectToRegistroPage);
        
        document.getElementById("btnQuienSomos").addEventListener("click", redirectToQuienSomos);
    </script>

</body>
</html>
