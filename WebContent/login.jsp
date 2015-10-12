<%@page import="model.Users"%>
<%@page import="model.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>
<body>

<h2>Login</h2>
	<jsp:useBean id="user" class="model.User" scope="request" />
	<jsp:setProperty name="user" property="*"/>
	
	<% Cookie cookies[] = request.getCookies();
		User userFromCookie = null;
		//daca sunt cookie
		if (cookies != null) {
			boolean isUsernameCookie = false;
			boolean isPasswordCookie = false;
			String username = "";
			String password = "";
			for (int i=0; i<cookies.length; i++) {
				if (cookies[i].getName().equals("username")) {
					username = cookies[i].getValue();
					isUsernameCookie = true;
				}
				if (cookies[i].getName().equals("password")){
					password = cookies[i].getValue();
					isPasswordCookie = true;
				}
			}
			//si daca nu sunt parametri
			if(isUsernameCookie && isPasswordCookie){
				userFromCookie = new User(username, password);
			}
		} 
	 
		if ( request.getParameter("username") == null ) { 
			if(userFromCookie != null && Users.exists(userFromCookie)) {
				request.getSession(true).setAttribute("logedUser", userFromCookie);
				response.sendRedirect("products.jsp");
			} else {	
		%>	
			<form method="POST" action="">
				<p>Username: <input type="text" name="username" value="" /></p>
				<p>Password: <input type="password" name="password" value="" /></p>
				<p><input type="checkbox" name="rememberme" value="">Remember me<br></p>
				<p><input type="submit" value="Login" /></p>
			</form>
		<% }
		} else {
			if( Users.exists( (User) request.getAttribute("user")) ){
				//Cooki ca sa tina minte browserul user-ul si parola celui logat
				if(request.getParameter("rememberme") != null && userFromCookie == null){
					Cookie usernameCookie = new Cookie("username", request.getParameter("username"));
					Cookie passwordCookie = new Cookie("password", request.getParameter("password"));
					
					usernameCookie.setMaxAge(14*24*60*60); //in seconds --> 14 zile
					response.addCookie(usernameCookie);
					passwordCookie.setMaxAge(14*24*60*60); 
					response.addCookie(passwordCookie);
				}
				
				//Inainte de a face sendRedirect, trebuie sa pun "user" pe session, si din pagina de products.jsp sa verific daca exista user-ul pe session, ca sa nu pot accesa direct pagina de produce, chiar nefiind logat.
				request.getSession(true).setAttribute("logedUser", request.getAttribute("user"));
				//getServletContext().getRequestDispatcher("/products.jsp").forward(request, response); // nu am facut cu forward pentru ca ramaneam in pagina curenta, de login.jsp, si doar continutul paginii era modificat. SendRedirect, redirecteaza intr-o alta pagina .jsp
				response.sendRedirect("products.jsp");
				return;
			}
		
			response.sendRedirect("error.jsp");
	 	} %>
	<form method="GET" action="register.jsp">
		<input type="submit" value="Register" />
	</form>

</body>
</html>