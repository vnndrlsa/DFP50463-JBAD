<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
String idParam = request.getParameter("id");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pmis", "root", "");

PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id=?");
ps.setInt(1,Integer.parseInt(idParam));
ps.executeUpdate();
conn.close();
response.sendRedirect("delete.jsp?msg=User+deleted+successfully");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>