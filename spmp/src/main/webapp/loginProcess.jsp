<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Driver"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%
        String userString = request.getParameter("username");
        String passString = request.getParameter("password");

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");
     // 1. Update the SQL to join the roles table
        String sql = "SELECT users.*, roles.name AS role_name FROM users " +
                     "JOIN roles ON users.role_id = roles.id " +
                     "WHERE username=? AND password=?";

        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, userString);
        ps.setString(2, passString);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            session.setAttribute("user", userString);
            // 2. This will now work because 'role_name' is in the query result!
            session.setAttribute("role", rs.getString("role_name")); 
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    %>
</body>
</html>