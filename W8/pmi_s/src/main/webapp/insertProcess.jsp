<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
String username = request.getParameter("username");
String password = request.getParameter("password");
String role = request.getParameter("peranan");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pmis", "root", "");
String sql = "INSERT INTO users (username,password,role_id) VALUES(?,?,?)";

PreparedStatement ps = conn.prepareStatement(sql);
ps.setString(1, username);
ps.setString(2, password);
ps.setInt(3, Integer.parseInt(role));

ps.executeUpdate();
conn.close();
response.sendRedirect("insert.jsp?success=1");
%>
<body>

</body>
</html>