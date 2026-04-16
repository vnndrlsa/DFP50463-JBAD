<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pmis", "root", "");

String idParam = request.getParameter("userId");
String userString = request.getParameter("username");
String roleId = request.getParameter("role_id");
String password = request.getParameter("password");

String sql = "UPDATE users SET username=?,role_id=?,password=? WHERE id=?";
PreparedStatement ps = conn.prepareStatement(sql);

ps.setString(1, userString);
ps.setInt(2, Integer.parseInt(roleId));
ps.setString(3, password);
ps.setInt(4, Integer.parseInt(idParam));


ps.executeUpdate();
conn.close();
response.sendRedirect("manageUsers.jsp");

%>

<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>