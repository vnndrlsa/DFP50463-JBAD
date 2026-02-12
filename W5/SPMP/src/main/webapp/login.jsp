<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SPMP| login</title>
</head>
<body>
<h2>User Login</h2>
    <form action="authentication.jsp" method="POST">
        <p>Username: <input type="text" name="nama" required/></p>
        <p>Password: <input type="password" name="katalaluan" required/></p>
        <p><input type="submit" value="Login"/></p>
    </form>
</body>
</html>