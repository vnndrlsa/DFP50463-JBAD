<%@page import="java.util.Random" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cafe Board | Menu</title>
</head>
<body>
<%
String[] drinks = {"Latte" , "Mathca" , "Americano" , "Espresso" , "Mocha" , "Cappuccino"};
Random rand = new Random();
String drink = drinks[rand.nextInt(drinks.length)];
%>

<%= drink %>

<%for(int i=0 ; i<=5; i++){ %>
 <p><%= (i+1) %>. <%= drinks[i] %></p>
<%}%>
</body>
</html>