<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String username = request.getParameter("username");
    String password = request.getParameter("password");
    String roleId = request.getParameter("role-id");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");

    String sql = "INSERT INTO users(username,password,role_id) VALUES(?,?,?)";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, username);
    ps.setString(2, password);
    ps.setInt(3, Integer.parseInt(roleId));
    
    ps.executeUpdate();
    
    conn.close();
    response.sendRedirect("insert.jsp?success=1");
%>
<body>

</body>
</html>