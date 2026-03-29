<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Manage Users</title>
<style>
    table { width: 60%; border-collapse: collapse; }
    th, td { padding: 8px; text-align: left; border: 1px solid #ddd; }
    th { background-color: #f2f2f2; }
</style>
</head>
<body>
<%
    // Security check: Hanya admin boleh masuk sini
    if (session.getAttribute("user") == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect("login.jsp");
        return;
    }

    String messageString = request.getParameter("msg");

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");
    
    // Query untuk ambil senarai user beserta nama role mereka
    String sql = "SELECT users.id, username, roles.name as role_name " +
                 "FROM users JOIN roles ON users.role_id = roles.id";
    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery(sql);
%>

    <h2>Manage Users</h2>
    
    <% if(messageString != null) { %>
        <p style="color:green;"><%= messageString %></p>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Role</th>
            <th colspan="2">Action</th>
        </tr>
        <%
        while (rs.next()) {
            int id = rs.getInt("id");
        %>
        <tr>
            <td><%= id %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("role_name") %></td>
            <td>
                <a href="editUser.jsp?id=<%= id %>">Edit</a>
            </td>
            <td>
                <a href="deleteUser.jsp?id=<%= id %>" 
                   onclick="return confirm('Adakah anda pasti mahu padam user ini?')">Delete</a>
            </td>
        </tr>
        <%
        }
        // Tutup connection
        rs.close();
        stmt.close();
        conn.close();
        %>
    </table>
    
    <br>
    <a href="dashboard.jsp">Back to Dashboard</a>
</body>
</html>