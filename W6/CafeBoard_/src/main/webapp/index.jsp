<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cafe Board | Home</title>
</head>
<body>
<%
String name = (String) session.getAttribute("name");
String role;
if(name.equals("root")){
	role = "Administrator";
}
else {
	 role = "Guest";
}
 //1.print nama anda
 //2.print guess atau admin
%>

<p><h2>Welcome, <%=name %> ! </h2></p>
<p><h3>You are a <%=role %>.</h3></p>
</body>
</html>