<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Update Data</title>
</head>
<body>
<%

String idParam = request.getParameter("id");
String username = request.getParameter("username");
String password = request.getParameter("password");
String roleId = request.getParameter("role_id");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");

PreparedStatement ps = conn.prepareStatement("UPDATE users SET username=?,password=?,role_id=? WHERE id=?");
ps.setString(1, username);
ps.setString(2, password);
ps.setInt(3, Integer.parseInt(roleId));
ps.setInt(4, Integer.parseInt(idParam));

ps.executeUpdate();
conn.close();
response.sendRedirect("manageUsers.jsp");
%>
</body>
</html>