package controlador;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import jakarta.persistence.Query;
import jakarta.servlet.RequestDispatcher;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import modelo.HibernateUtils;
import modelo.Usuario;

import java.io.IOException;

/**
 * Servlet implementation class LoginController
 */
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	protected void procesarPeticion(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		response.setContentType("text/html;charset=UTF-8");
		String nombreUsuario,password,passwordRe,email;
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
		case "registrarNuevoUsuario"://Se realiza el insert de un nuevo usuario en la base de datos 
			nombreUsuario= request.getParameter("nombreUsuario");
			password= request.getParameter("contrasenia");
			passwordRe= request.getParameter("contraseniaRe");
			email= request.getParameter("correoUsuario");
			Usuario nuevoUsuario=new Usuario(nombreUsuario,password,email);
			EntityManager em1= HibernateUtils.getEmf().createEntityManager();
			EntityTransaction transacion=em1.getTransaction();
			try {
				transacion.begin();
				em1.persist(nuevoUsuario);
				transacion.commit();
			}catch(Exception e) {
				System.err.println(e.getMessage());
				transacion.rollback();
			}finally{
				em1.close();
			}
			response.sendRedirect("login.jsp");
			break;
		case "perfil": // es el cliente quien deber� invocar a este recurso
			response.sendRedirect("perfilUsuario.jsp"); 
			break;
		case "NuevoViaje": // es el cliente quien invoca este recurso al presionar el oton de Crear Viaje
			response.sendRedirect("nuevoViaje.jsp"); 
			break; 
		case "iniciarSesion":
		    // Obtén los valores de los campos de nombre de usuario y contraseña del formulario
	            email = request.getParameter("correoUsuario");
	            password = request.getParameter("contrasenia");
	   
	            // Realiza la verificación con la base de datos
	            EntityManager em = HibernateUtils.getEmf().createEntityManager();
	            Query consulta = em.createQuery("SELECT u FROM Usuario u WHERE u.email = :correo");
	            consulta.setParameter("correo", email);
	            try {
	            	Usuario usuario = (Usuario) consulta.getSingleResult();
	            	
	            	if (usuario != null && usuario.getContrasenia().equals(password)) {
	            	    // Almacena los datos del usuario en la sesión
	            	    HttpSession session = request.getSession();
	            	    session.setAttribute("usuario", usuario);
	            	    // Redirige a la página de perfil
	            	    response.sendRedirect("perfilUsuario.jsp");
	            	} else {
	            	    // Si las credenciales no son válidas, redirige de nuevo al formulario de inicio de sesión con un mensaje de error
	            	    request.setAttribute("error", "Nombre de usuario o contraseña incorrectos");
	            	    request.getRequestDispatcher("login.jsp").forward(request, response);
	            	}
	            	
	            }catch(NoResultException e) {
	            	request.setAttribute("error", "Nombre de usuario o contraseña incorrectas");
	            	request.getRequestDispatcher("login.jsp").forward(request, response);
	            }finally{
	            	em.close();
	            }
            break;
         
		 /* case "borrarActor": // es el servidor quien redirije
		 * internamente hacia la vista procNuevoActor.jsp rd =
		 * request.getRequestDispatcher("borrarActor.jsp"); rd.forward(request,
		 * response); break;
		 */
        
        
		case "Loger":
			response.sendRedirect("login.jsp");
			
			break;
			
		default:
			// es el cliente quien deber� invocar a este recurso
			response.sendRedirect("index.jsp");
	
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
