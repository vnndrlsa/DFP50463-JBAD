<%@page import="com.mysql.cj.util.Util"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Dashboard</title>
</head>
<%
    if(session.getAttribute("user")==null){
        response.sendRedirect("login.jsp");
        return;
    }
    String role = (String) session.getAttribute("role");
%>
<body>
    <h2>Welcome, <%= session.getAttribute("user") %> -- <%=role %></h2>
    <p>This is your protected dashboard</p>
    <p>Today's date: <%= new SimpleDateFormat("dd MMMM yyyy").format(new Date()) %></p>

    <h3>Announcements</h3>
    <p>Welcome to the systems. Please check your schedule</p>

    <% if("admin".equals(role) || "staff".equals(role) ){ %>
        <h3>Admin and staff</h3>
    <% } %>

    <% if("admin".equals(role)){ %>
        <h3>Admin menu only</h3>
        <a href="insert.jsp">Insert</a>
        <a href="manageUsers.jsp">Delete</a>
        <a href="manageUsers.jsp">Update</a>
    <% } %>

    <br><br>
    <a href="logout.jsp">Logout</a>
</body>
</html>