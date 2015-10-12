<%@page import="model.Users"%>
<%@ page import="nl.captcha.Captcha" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>
</head>



<body>
	<h2>Register</h2>
	<jsp:useBean id="user" class="model.User" scope="request" />
	<jsp:setProperty name="user" property="*"/>
		
	<% if ( request.getParameter("username") == null ) { %>	
		<form method="POST" action="">
			<p>Username: <input type="text" name="username" value="" /></p>
			<p>Password: <input type="password" name="password" value="" /></p>
			<p>Pass the CAPTCHA test! Enter the letters:</p>
			<img src="simpleCaptcha.jpg" border="1"/>
			<p><input type="text" name="inCaptchaChars"/></p>
			<p><input type="submit" value="Register" /></p>
		</form>
	<% } else { 
		Captcha captcha = (Captcha) session.getAttribute(Captcha.NAME);
		request.setCharacterEncoding("UTF-8");
		String answer = request.getParameter("inCaptchaChars");
	    if (captcha.isCorrect(answer)) {
	    	Users.register((model.User) request.getAttribute("user") );
			
			//getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
			response.sendRedirect("login.jsp");
	    } else {
	    	response.getWriter().print("Captcha is incorrect!");
	    }
	 } %>
</body>
</html>