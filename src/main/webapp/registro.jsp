<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Registro</title>
</head>
<body>
	<h1>Registro</h1>
	<form action="Register" action="Register" method="post">
		
        <label for="username">Nombre de Usuario:</label><br>
        <input type="text" id="username" name="username"><br>
        <label for="password">Contraseña:</label><br>
        <input type="password" id="password" name="password"><br><br>
        <label for="password">Confirmar contraseña:</label><br>
        <input type="password" id="passwordRe" name="passwordRe"><br><br>
        <label for="username">Correo Electrónico</label>
        <input type="email"  id="email" name="email">
       	
       	<input type="submit" value="Confirmar"> 
	</form>
</body>
</html>