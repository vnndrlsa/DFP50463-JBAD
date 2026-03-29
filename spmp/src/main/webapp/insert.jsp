<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Insert User</title>
</head>
<body>
<%
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");

    Statement stmt = conn.createStatement();
    ResultSet rsRoles = stmt.executeQuery("SELECT id, name FROM roles");
    
    String success = request.getParameter("success");
%>
<%
    if("1".equals(success)){
%>
    <script>alert("User inserted successfully");</script>
<% } %>
    <h2>Add New User</h2>
    <form action="insertProcess.jsp">
        username <input type="text" name="username"> 
        password <input type="password" name="password"> 
        Role <select name="role-id">
        <%
            while (rsRoles.next()) {
        %>
            <option value="<%= rsRoles.getInt("id") %>">
                <%= rsRoles.getString("name") %>
            </option>
        <%
            }
        %>
        </select> <br> <input type="submit" value="Add user">
    </form>
<%
    rsRoles.close();
    stmt.close();
    conn.close();
%>
</body>
</html>