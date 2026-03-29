<%@ page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SPMP | Edit User</title>
</head>
<body>
<%
    String idParam = request.getParameter("id");
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spmp", "root", "");

    String sql = "SELECT id,username, role_id FROM users WHERE id=?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(idParam));

    ResultSet rs = ps.executeQuery();
    int uID, uRole = 0;
    String uName = "";
    if (rs.next()) {
        uID = rs.getInt("id");
        uName = rs.getString("username"); // Data ini diambil dari database
        uRole = rs.getInt("role_id");
    }

    String roleSQL = "SELECT id,name FROM roles";
    PreparedStatement rolesPs = conn.prepareStatement(roleSQL);
    ResultSet roleRS = rolesPs.executeQuery();
%>

    <h2>Edit User</h2>
    <form action="updateData.jsp" method="post">
        <input type="hidden" name="id" value="<%=idParam%>">
        
        <label>Username</label>
        <input type="text" name="username" value="<%=uName%>"> <label>Password</label>
        <input type="text" name="password" value="">
        
        <label>Role</label>
        <select name="role_id">
            <%
            while (roleRS.next()) {
                int roleId = roleRS.getInt("id");
                String roleName = roleRS.getString("name");
                String isSelectedRole = (roleId == uRole) ? "selected" : "";
            %>
            <option value="<%=roleId%>" <%=isSelectedRole%>>
                <%=roleName%>
            </option>
            <%
            }
            %>
        </select>
        <br><br>
        <input type="submit" value="Update" name="updateUser"> </form>

    <%
    // Jangan lupa tutup connection untuk elakkan error
    roleRS.close();
    rolesPs.close();
    rs.close();
    ps.close();
    conn.close();
    %>
</body>
</html>