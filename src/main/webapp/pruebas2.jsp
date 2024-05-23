<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="jakarta.servlet.http.*" %>
<!DOCTYPE html>

<%
    Cookie[] cookies = request.getCookies();
    String username = "";
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("username")) {
                username = cookie.getValue();
                break;
            }
        }
    }
%>
<html>
    <head>
        <title>Welcome, <%= username %></title>
    </head>
    <body>
        <h1>Welcome, <%= username %></h1>
    </body>
</html>