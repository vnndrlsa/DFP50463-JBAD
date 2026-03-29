<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
    String error = request.getParameter("error");
%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Login</title>
</head>
<body>
    <% if("1".equals(error)){ %>
        <p style="color:red">Invalid username or password. Please try again</p>
    <% } %>

    <form action="loginProcess.jsp" method="post">
        name <input type="text" name="username">
        password <input type="password" name="password">
        <input type="submit" value="Submit">
    </form>
</body>
</html>