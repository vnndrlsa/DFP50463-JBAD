<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String user = (String) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Welcome</title>
</head>
<body>
    <h2>Welcome back, ${sessionScope.userDisplayName}!</h2>

    <p>Your role is: ${sessionScope.role}</p>

    <% if (role != null && role.trim().equalsIgnoreCase("admin")) { %>
        <hr>
        <p>You have successfully authenticated against the database.</p>
    <% } %>

    <a href="LogoutServlet">Logout</a>
</body>
</html>