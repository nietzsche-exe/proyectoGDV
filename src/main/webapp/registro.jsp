<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Registro de usuario</title>

</head>
<body>

<h1>Registro</h1>

	<c:if test="${not empty error}">
		    <p style="color: red;">${error}</p>
	</c:if>
	
	<form  action="LoginController" method="post">
		<input type="hidden" name="opcion" value="registrarNuevoUsuario">
		
        <label for="nombreUsuario">Nombre de Usuario</label><br>
        <small>(superior a 3 caracteres)</small><br>
        <input type="text" id="nombreUsuario" name="nombreUsuario" min="3"><br>

        <label for="contrasenia">Contraseña</label><br>
        <small>(Debe incluir(mínimo un número, un símbolo especial(!?*%) y una mayúscula) y ser superior a 8 caracteres e inferior a 20 caracteres)</small><br>
        <input type="password" id="contrasenia" name="contrasenia"><br><br>
        
        <label for="contraseniaRe">Confirmar contraseña</label><br>
        <input type="password" id="contraseniaRe" name="contraseniaRe"><br><br>
        
        <label for="correoUsuario">Correo Electrónico</label><br>
        <small>Solo se permiten correos del dominio (@gmail.com)</small><br>
        <input type="email"  id="correoUsuario" name="correoUsuario" >
       	
       	<input id="registrarme" type="submit" value="Confirmar">
 	</form>
 	<a href="login.jsp">Volver al inicio</a>
</body>
</html>