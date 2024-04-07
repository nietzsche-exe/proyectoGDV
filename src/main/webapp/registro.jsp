<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registro de usuario</title>
	
	<script>
	/*Comprueba que todos los campos esten rellenados, cuando todos esten completos
		comprobara que ambas contraseñas sean iguales,
		entonces habilitara el boton "Confirmar"
		*/
		function validarInputs(){
			var nombreUsuario = document.getElementById("nombreUsuario").value;
			var contrasenia = document.getElementById("contrasenia").value;
			var contraseniaRe = document.getElementById("contraseniaRe").value;
			//debe comprobarse que el mail exista y que el dominio exista
			var correoUsuario = document.getElementById("correoUsuario").value;
			var btnRegistrarme=document.getElementById("registrarme");
			if ((nombreUsuario === "" || contrasenia === "" || contraseniaRe===""|| correoUsuario==="") || 
					(contrasenia.localeCompare(contraseniaRe)!==0)) {
				btnRegistrarme.disabled = true;                	
            } else {
                btnRegistrarme.disabled = false;
            }
		}
	</script>
</head>
<body>
	<h1>Registro</h1>
	<form  action="LoginController" method="post" onsubmit="return validarInputs()">
		<input type="hidden" name="opcion" value="registrarNuevoUsuario">
		
        <label for="nombreUsuario">Nombre de Usuario:</label><br>
        <input type="text" id="nombreUsuario" name="nombreUsuario" oninput="validarInputs()"><br>
        
        <label for="contrasenia">Contraseña:</label><br>
        <input type="password" id="contrasenia" name="contrasenia" oninput="validarInputs()"><br><br>
        
        <label for="contraseniaRe">Confirmar contraseña:</label><br>
        <input type="password" id="contraseniaRe" name="contraseniaRe" oninput="validarInputs()"><br><br>
        
        <label for="correoUsuario">Correo Electrónico:</label>
        <input type="email"  id="correoUsuario" name="correoUsuario" oninput="validarInputs()">
       	
       	<input id="registrarme" type="submit" value="Confirmar" disabled> 
       	<a href="login.jsp">Volver al inicio</a>
       	
	</form>
</body>
</html>