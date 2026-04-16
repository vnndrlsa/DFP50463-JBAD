<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ── Confirmation page is accessible WITHOUT login (student just registered) ─
    // We only need the URL params passed from register.jsp
    String name      = request.getParameter("name")      != null ? request.getParameter("name")      : "-";
    String workshop  = request.getParameter("workshop")  != null ? request.getParameter("workshop")  : "-";
    String studentId = request.getParameter("studentId") != null ? request.getParameter("studentId") : "-";
    String email     = request.getParameter("email")     != null ? request.getParameter("email")     : "-";

    // Format current date/time for display
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd-MM-yyyy hh:mm a");
    String regDate = sdf.format(new java.util.Date());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration Confirmed</title>
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
        .navbar a { color: #ccc; text-decoration: none; font-size: 14px; margin-left: 16px; }
        .navbar a:hover { color: white; }

        .wrapper {
            flex: 1;
            display: flex;
            align-items: flex-start;
            justify-content: center;
            padding: 36px 20px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 32px;
            width: 100%;
            max-width: 460px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.12);
            text-align: center;
        }

        /* Green checkmark circle at the top */
        .success-icon {
            width: 56px; height: 56px;
            background-color: #27ae60;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 16px;
            font-size: 26px;
            color: white;
            font-weight: bold;
        }

        .card h2 { font-size: 20px; color: #27ae60; margin-bottom: 6px; }
        .card .subtitle { font-size: 13px; color: #888; margin-bottom: 24px; }

        /* Summary table showing registration details */
        .detail-table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            margin-bottom: 24px;
        }
        .detail-table tr { border-bottom: 1px solid #eee; }
        .detail-table tr:last-child { border-bottom: none; }
        .detail-table td { padding: 10px 8px; font-size: 13px; color: #333; }
        .detail-table td:first-child { font-weight: bold; color: #555; width: 38%; }

        .btn-row { display: flex; gap: 10px; }
        .btn {
            flex: 1;
            padding: 11px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        /* Go to Login button */
        .btn-login { background-color: #2980b9; }
        .btn-login:hover { background-color: #2471a3; }

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
        <%-- After registration, the student is not yet logged in --%>
        <a href="login.jsp">Login</a>
    </div>
</div>

<div class="wrapper">
    <div class="card">
        <div class="success-icon">&#10003;</div>
        <h2>Registration Successful!</h2>
        <p class="subtitle">Your information has been saved. You can now log in with your Student ID and password.</p>

        <%-- Display the details that were just registered --%>
        <table class="detail-table">
            <tr>
                <td>Student ID</td>
                <td><%= studentId %></td>
            </tr>
            <tr>
                <td>Full Name</td>
                <td><%= name %></td>
            </tr>
            <tr>
                <td>Email</td>
                <td><%= email %></td>
            </tr>
            <tr>
                <td>Workshop</td>
                <td><%= workshop %></td>
            </tr>
            <tr>
                <td>Registered At</td>
                <td><%= regDate %></td>
            </tr>
        </table>

        <%-- Direct student to login now that they have an account --%>
        <div class="btn-row">
            <a href="login.jsp" class="btn btn-login">Go to Login</a>
        </div>
    </div>
</div>

<footer>
    DFP50463 - Java Based Application Development | Politeknik Mukah Sarawak
</footer>

</body>
</html>
