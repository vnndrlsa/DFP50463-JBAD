<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PMIS | Login</title>
</head>
<body>
<%
String error = request.getParameter("ralat");
%>
<h2>User Login</h2>
<% if( (error) !=null && (error).equals("1")) {%>
 <p style="color:red;">Invalid Username or password</p>
<% }%>

  <form action="processLogin.jsp" method="post">
    <label>Username:</label>
    <input type="text" name="username" required />
    <br/>
    <label>Password:</label>
    <input type="password" name="password" required />
    <br/>
    <button type="submit">Login</button>
  </form>
</body>
</html>