<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registro de usuario</title>
<link rel="stylesheet" href="Styles/Registrarse/cssRegistrarse.css"> 
</head>
<body>
	<div class="Contenedor_Registrarse">
		<div id="Contenedor_Cabecero">
			<img id="imgPerfil" alt="Logo_Empresa" src="Resources/logo.png">
			<h1>Registro de Sesión</h1>
		</div>
		
		<div id="Contenedor_Cuerpo">
			<c:if test="${not empty error}">
				    <p style="color: red;">${error}</p><br>
			</c:if>
			
			<form  action="LoginController" method="post">	
				<input type="hidden" name="opcion" value="registrarNuevoUsuario">
				
		        <label for="nombreUsuario"><b>Nombre de Usuario</b></label><br>
		        <label class="Texto_Ayuda">(superior a 3 caracteres)</label><br>
		        <input class="Boton_Escribir" type="text" id="nombreUsuario" name="nombreUsuario" min="3"><br><br>
		
		        <label for="contrasenia"><b>Contraseña</b></label><br>
		        <label class="Texto_Ayuda">(Debe incluir un número, un símbolo especial(!?*%) y una mayúscula y ser superior a 8 e inferior a 20 caracteres)</label><br>
		        <input class="Boton_Escribir" type="password" id="contrasenia" name="contrasenia"><br><br>
		        
		        <label for="contraseniaRe"><b>Confirmar contraseña</b></label><br>
		        <input class="Boton_Escribir" type="password" id="contraseniaRe" name="contraseniaRe"><br><br>
		        
		        <label for="correoUsuario"><b>Correo Electrónico</b></label><br>
		        <label class="Texto_Ayuda">Solo se permiten correos del dominio (@gmail.com)</label><br>
		        <input class="Boton_Escribir" type="email"  id="correoUsuario" name="correoUsuario" ><br>
		       	
		      	<input class="Botones" id="registrarme" type="submit" value="Confirmar"> <a class="Botones" href="login.jsp">Volver al inicio de sesion</a>
		 	</form>
		 </div>
	</div>
	
</body>
</html>