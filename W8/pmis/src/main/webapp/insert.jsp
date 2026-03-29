<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pmis | insert</title>
</head>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pmis", "azlan", "");
Statement stmt = conn.createStatement();
ResultSet rsResultSet = stmt.executeQuery("SELECT * FROM roles");
%>
<body>
	<form action="insertProcess.jsp" method="post">
		<label>Username:</label> <input type="text" name="username" required />
		<br /> <label>Password:</label> <input type="password"
			name="password" required /> <br /> <select>
			<%
			while (rsResultSet.next()) {
			%>
			<option value=" <%= rsResultSet.getInt("id") %> "> 
			      <%= rsResultSet.getString("rolename") %>
			</option>
			<%
			}
			%>
		</select> <input type="submit" value="Insert data">
	</form>
</body>
</html>