<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // ── Auth check: must be logged in ─────────────────────────────────────────
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ── Role check: only lecturers can register students through this page ─────
    String role = (String) session.getAttribute("role");
    if (!"lecturer".equals(role)) {
        response.sendRedirect("index.jsp");
        return;
    }

    String errorMsg = "";

    // ── Handle POST (lecturer submits registration form for a student) ─────────
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String studentId = request.getParameter("student_id");
        String fullName  = request.getParameter("full_name");
        String email     = request.getParameter("email");
        String password  = request.getParameter("password");
        String workshop  = request.getParameter("workshop");

        // Validate all fields
        if (studentId == null || studentId.trim().isEmpty() ||
            fullName  == null || fullName.trim().isEmpty()  ||
            email     == null || email.trim().isEmpty()     ||
            password  == null || password.trim().isEmpty()  ||
            workshop  == null || workshop.trim().isEmpty()) {

            errorMsg = "Please fill in every field.";

        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pba2_db", "root", "");

                // Insert with role = 'student'; lecturer never assigns lecturer role here
                String sql = "INSERT INTO registration (student_id, full_name, email, password, workshop, role) " +
                             "VALUES (?, ?, ?, ?, ?, 'student')";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, Integer.parseInt(studentId.trim()));
                ps.setString(2, fullName.trim());
                ps.setString(3, email.trim());
                ps.setString(4, password.trim());
                ps.setString(5, workshop.trim());
                ps.executeUpdate();

                // Redirect back to list with a success message
                response.sendRedirect("list.jsp?success=Student+" +
                    java.net.URLEncoder.encode(fullName.trim(), "UTF-8") + "+has+been+registered+successfully.");
                return;

            } catch (NumberFormatException e) {
                errorMsg = "Student ID must be a number.";
            } catch (SQLIntegrityConstraintViolationException e) {
                // Duplicate primary key
                errorMsg = "Student ID " + studentId + " is already registered.";
            } catch (Exception e) {
                errorMsg = "Error: " + e.getMessage();
            } finally {
                if (ps   != null) try { ps.close();   } catch (Exception e) {}
                if (conn != null) try { conn.close();  } catch (Exception e) {}
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Student - Workshop Registration System</title>
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
        .navbar a:hover, .navbar a.active { color: white; }
        .navbar .user-info { color: #aaa; font-size: 13px; }

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
            max-width: 480px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.12);
        }

        .card h2 { font-size: 20px; color: #2c3e50; margin-bottom: 6px; text-align: center; }
        .card .subtitle { font-size: 12px; color: #888; text-align: center; margin-bottom: 24px; }

        .alert-error {
            background: #fdecea;
            border: 1px solid #f5c6cb;
            color: #c0392b;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 18px;
        }

        .form-group { margin-bottom: 16px; }

        label {
            display: block;
            font-size: 13px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="password"],
        select {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 13px;
            font-family: Arial, sans-serif;
            color: #333;
            outline: none;
        }
        input:focus, select:focus { border-color: #2980b9; }

        .btn-row { display: flex; gap: 10px; margin-top: 20px; }
        .btn {
            flex: 1;
            padding: 11px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            font-weight: bold;
            color: white;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        .btn-submit { background-color: #2980b9; }
        .btn-submit:hover { background-color: #2471a3; }
        .btn-back   { background-color: #7f8c8d; }
        .btn-back:hover { background-color: #6c7a7d; }

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
        <span class="user-info">&#128203; <%= session.getAttribute("full_name") %></span>
        <a href="list.jsp">Home</a>
        <a href="register_by_lecturer.jsp" class="active">Register Student</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="wrapper">
    <div class="card">
        <h2>Register Student</h2>
        <p class="subtitle">Fill in the student's details to register them into a workshop.</p>

        <%-- Show error if any field fails validation --%>
        <% if (!errorMsg.isEmpty()) { %>
        <div class="alert-error"><%= errorMsg %></div>
        <% } %>

        <form method="POST" action="register_by_lecturer.jsp">

            <div class="form-group">
                <label for="student_id">Student ID</label>
                <input type="number" id="student_id" name="student_id" placeholder="eg. 01"
                       value="<%= request.getParameter("student_id") != null ? request.getParameter("student_id") : "" %>" required>
            </div>

            <div class="form-group">
                <label for="full_name">Full Name</label>
                <input type="text" id="full_name" name="full_name" placeholder="Student's Full Name"
                       value="<%= request.getParameter("full_name") != null ? request.getParameter("full_name") : "" %>" required maxlength="50">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" placeholder="email@gmail.com"
                       value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" required maxlength="50">
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <%-- Lecturer sets an initial password for the student --%>
                <input type="password" id="password" name="password" placeholder="Set a password for the student" required maxlength="255">
            </div>

            <div class="form-group">
                <label for="workshop">Workshop</label>
                <select id="workshop" name="workshop" required>
                    <option value="" disabled selected>-- Choose Workshop --</option>
                    <option value="Python Programming"
                        <%= "Python Programming".equals(request.getParameter("workshop")) ? "selected" : "" %>>
                        Python Programming
                    </option>
                    <option value="Java Based Application Development"
                        <%= "Java Based Application Development".equals(request.getParameter("workshop")) ? "selected" : "" %>>
                        Java Based Application Development
                    </option>
                    <option value="Fullstack Web Development"
                        <%= "Fullstack Web Development".equals(request.getParameter("workshop")) ? "selected" : "" %>>
                        Fullstack Web Development
                    </option>
                </select>
            </div>

            <div class="btn-row">
                <a href="list.jsp" class="btn btn-back">Cancel</a>
                <button type="submit" class="btn btn-submit">Register</button>
            </div>

        </form>
    </div>
</div>

<footer>
    DFP50463 - Java Based Application Development | Politeknik Mukah Sarawak
</footer>

</body>
</html>
