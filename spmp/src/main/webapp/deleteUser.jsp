<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Delete User</title>
</head>
<body>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String idParam = request.getParameter("id");

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");
        String sql = "DELETE FROM users WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, Integer.parseInt(idParam));
        ps.executeUpdate();
        conn.close();
        response.sendRedirect("manageUsers.jsp");

    }catch(Exception e){
        out.println("Error " + e.getMessage());
    } finally {

    }
%>
</body>
</html>