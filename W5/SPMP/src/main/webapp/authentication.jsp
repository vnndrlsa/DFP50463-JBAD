<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String username;
String password;
String errorMessage = "";
username = request.getParameter("nama");
password = request.getParameter("katalaluan");

if ("vannder".equals(username) && "vannderpmu".equals(password)) {
	HttpSession sesi = request.getSession();
	sesi.setAttribute("pengguna", username);
	sesi.setAttribute("sudahLogin", true);
	response.sendRedirect("index.jsp");

} else {
	errorMessage = "Invalid Username or Password";
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SPMP | Authentication</title>
</head>
<body>
	<%
	if (errorMessage != "") {
	%>
	<p><%=errorMessage%></p>
	<%
	}
	%>
	<a href="login.jsp">Try login again</a>
</body>
</html>