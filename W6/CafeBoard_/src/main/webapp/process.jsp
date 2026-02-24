<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cafe Board | Process </title>
</head>
<body>
<%

String username = request.getParameter("username");
String password = request.getParameter("password");
String role = request.getParameter("role");

if(username.equals("root") && password.equals("pass")){
	session.setAttribute("name", username);
	session.setAttribute("role", role);
	response.sendRedirect("index.jsp");
}
else if(username.equals("student") && password.equals("katalaluan")){
	session.setAttribute("name", username);
	session.setAttribute("role", role);
	response.sendRedirect("index.jsp");

}
else {
	response.sendRedirect("error.jsp");
}
%>

<br>
<a href="login.jsp">Back to Login</a>
</body>
</html>