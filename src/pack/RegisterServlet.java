package pack;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;

public class RegisterServlet extends HttpServlet{

	/**
	 * ceva
	 */
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/pages/register.jsp");
		dispatcher.include(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{	
		User user = (User) request.getAttribute("user");
		
		if(user == null){
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/WEB-INF/pages/register.jsp");
			dispatcher.include(request, response);
		} else {
			System.out.println("1 : " + user.getUsername());
		}
		
		User userBean = (User) request.getAttribute("user");
		if(request.getParameter("username") != null){
			System.out.println("2 : " + request.getParameter("username"));
			System.out.println(userBean.getUsername());
			response.getWriter().println(request.getParameter("username"));
		}
		
	}
}
