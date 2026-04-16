<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>

<%
String uName = "", uEmail = "";
int uId = 0, uRoleID = 0;
String password = "";

String idParam = request.getParameter("id");

Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pmis", "root", "");

String sql = "SELECT * FROM pmis.users WHERE id=?";
PreparedStatement ps = conn.prepareStatement(sql);
ps.setInt(1, Integer.parseInt(idParam));

ResultSet rs = ps.executeQuery();

if (rs.next()) {
 uId = rs.getInt("id");
 uName = rs.getString("username");
 uRoleID = rs.getInt("role_id");
 uEmail = rs.getString("email");
 password = rs.getString("password");
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PMIS | EDIT USER</title>
</head>

<body>

 <h2>Edit User</h2>
 <form action="update.jsp" method="post">
 
 <input type="hidden" value="<%=uId%>" name="userId">
 <label>Username</label><input type="text" value="<%=uName%>" name = "username">
 <label>Email</label><input type="text" value="<%=uEmail%>">
 <label>Role</label><input type="text" value="<%=uRoleID%>">
 <label>CHANGE NEW PASSWORD</label> <input type ="text" value="<%=password %>" name= "password">
 <%
 String roleSQL = "SELECT * FROM roles";
 PreparedStatement rolesPs = conn.prepareStatement(roleSQL);
 ResultSet rolesRS = rolesPs.executeQuery();
 %>
 
 <select name="role_id">
 <%
 while(rolesRS.next()){
  int roleId = rolesRS.getInt("id");
  String roleName = rolesRS.getString("role_name");
  String isSelected = (roleId == uRoleID) ? "selected" : "";
 %>
 <option value="<%= roleId%>" <%=isSelected %>>
 <%= roleName %> 
 </option>
 <%} %>
 </select>
 <br><br>
 <input type="submit" value="UPDATE">
 
 </form>

</body>
</html>