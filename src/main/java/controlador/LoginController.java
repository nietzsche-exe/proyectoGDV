package controlador;

import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void procesarPeticion(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		response.setContentType("text/html;charset=UTF-8");
		
		String operacion = request.getParameter("opcion");
		if (operacion == null){
			operacion = "";
		}
		
		RequestDispatcher rd;
		
		
		switch(operacion){
		
		  case "registrarse": // es el servidor quien redirije internamente hacia la vista registrarse
		    rd = request.getRequestDispatcher("registro.jsp");
		    rd.forward(request, response);
		    break;
		 
		  case "perfil": // es el cliente quien deber� invocar a este recurso
			response.sendRedirect("perfilUsuario.jsp"); 
			break; 
		/* case "insertarActor": // es el servidor quien redirije internamente hacia la vista procNuevoActor.jsp
		 * rd = request.getRequestDispatcher("procNuevoActor.jsp"); 
		 * rd.forward(request,
		 * response); 
		 * break; 
		 * case "borrarActor": // es el servidor quien redirije
		 * internamente hacia la vista procNuevoActor.jsp rd =
		 * request.getRequestDispatcher("borrarActor.jsp"); rd.forward(request,
		 * response); break;
		 */
			default:
				// es el cliente quien deber� invocar a este recurso
				response.sendRedirect("login.jsp");
	
		}
		
	}
	
	/**
	 * Método controlador para las peticiones HTTP GET que delega al método `procesarPeticion`.
	 *
	 * @param request  Objeto de solicitud HTTP servlet.
	 * @param response Objeto de respuesta HTTP servlet.
	 * @throws IOException      si hay un error de entrada o salida mientras el servlet está manejando la solicitud.
	 * @throws ServletException si la solicitud GET no se pudo manejar.
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException  
	{
		procesarPeticion(request, response);
	}

	
	/**
	 * Método controlador para las peticiones HTTP POST que delega al método `procesarPeticion`.
	 *
	 * @param request  Objeto de solicitud HTTP servlet.
	 * @param response Objeto de respuesta HTTP servlet.
	 * @throws IOException      si hay un error de entrada o salida mientras el servlet está manejando la solicitud.
	 * @throws ServletException si la solicitud POST no se pudo manejar.
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException  
	{
		procesarPeticion(request, response);
	}

}