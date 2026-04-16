<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // ── Redirect to login if session has no user ───────────────────────────────
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ── Redirect lecturer to their own page (list.jsp) ─────────────────────────
    String role = (String) session.getAttribute("role");
    if ("lecturer".equals(role)) {
        response.sendRedirect("list.jsp");
        return;
    }

    // ── Get student info from session ──────────────────────────────────────────
    String fullName = (String) session.getAttribute("full_name");
    String workshop = (String) session.getAttribute("workshop");

    // Extract first name only for a friendlier greeting (e.g. "Vannderlysa" from full name)
    String firstName = fullName;
    if (fullName != null && fullName.contains(" ")) {
        firstName = fullName.substring(0, fullName.indexOf(" "));
    }

    // ── Build a friendly workshop message based on the workshop enrolled ────────
    String workshopMsg = "";
    String workshopEmoji = "";
    if ("Python Programming".equals(workshop)) {
        workshopEmoji = "&#128013;"; // snake emoji
        workshopMsg = "Get ready to dive into the world of Python — one of the most powerful and beginner-friendly programming languages!";
    } else if ("Java Based Application Development".equals(workshop)) {
        workshopEmoji = "&#9749;"; // coffee cup emoji
        workshopMsg = "You're on your way to building amazing Java applications. Write once, run anywhere!";
    } else if ("Fullstack Web Development".equals(workshop)) {
        workshopEmoji = "&#127758;"; // globe emoji
        workshopMsg = "From frontend to backend, you'll be building the web of tomorrow. Exciting things ahead!";
    } else {
        workshopEmoji = "&#127891;";
        workshopMsg = "Your workshop journey is about to begin. Make the most of it!";
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Workshop Registration System</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .navbar {
            background-color: #2c3e50;
            padding: 12px 20px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .navbar-title { color: white; font-size: 16px; font-weight: bold; }
        .navbar a {
            color: #ccc;
            text-decoration: none;
            font-size: 14px;
            margin-left: 16px;
        }
        .navbar a:hover { color: white; }
        .navbar .user-info { color: #aaa; font-size: 13px; }

        .wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        /* Main greeting card for the student */
        .card {
            background: white;
            border-radius: 10px;
            padding: 40px 36px;
            width: 100%;
            max-width: 480px;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.12);
        }

        /* Big emoji at the top of the card */
        .card .emoji {
            font-size: 48px;
            margin-bottom: 12px;
        }

        /* Greeting: "Hello, Vannderlysa!" */
        .card .greeting {
            font-size: 24px;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 6px;
        }

        /* Workshop badge pill */
        .workshop-badge {
            display: inline-block;
            background-color: #eaf4fb;
            color: #2980b9;
            border: 1px solid #b3d7f0;
            border-radius: 20px;
            padding: 5px 16px;
            font-size: 13px;
            font-weight: bold;
            margin: 12px 0 16px;
        }

        /* Friendly description about their workshop */
        .card .workshop-msg {
            font-size: 13px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 28px;
        }

        /* Divider line */
        .divider {
            border: none;
            border-top: 1px solid #eee;
            margin-bottom: 24px;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            text-decoration: none;
            margin-bottom: 10px;
            text-align: center;
        }
        .btn-logout { background-color: #e74c3c; }
        .btn-logout:hover { background-color: #c0392b; }

        footer {
            background-color: #2c3e50;
            color: #aaa;
            text-align: center;
            padding: 12px;
            font-size: 12px;
        }
    </style>
</head>
<body>

<div class="navbar">
    <span class="navbar-title">Workshop Registration System</span>
    <div>
        <%-- Students only see Home and Logout; they cannot access the full list --%>
        <span class="user-info">Hi, <%= firstName %></span>
        <a href="index.jsp">Home</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="wrapper">
    <div class="card">

        <%-- Personalised greeting using first name --%>
        <div class="greeting">Hello, <%= firstName %>!</div>

        <%-- Workshop they are enrolled in, displayed as a badge --%>
        <p style="font-size:12px; color:#999; margin-bottom:4px;">You are enrolled in</p>
        <div class="workshop-badge"><%= workshop %></div>

        <%-- Motivating message tailored to the workshop --%>
        <p class="workshop-msg"><%= workshopMsg %></p>

        <hr class="divider">

        <%-- Logout button --%>
        <a href="logout.jsp" class="btn btn-logout">Logout</a>
    </div>
</div>

<footer>
    DFP50463 - Java Based Application Development | Politeknik Mukah Sarawak
</footer>

</body>
</html>
