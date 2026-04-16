<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // ── Redirect if user is already logged in ──────────────────────────────────
    if (session.getAttribute("student_id") != null) {
        String role = (String) session.getAttribute("role");
        // Send lecturer to list page, student to their dashboard
        if ("lecturer".equals(role)) {
            response.sendRedirect("list.jsp");
        } else {
            response.sendRedirect("index.jsp");
        }
        return;
    }

    String errorMsg = "";

    // ── Handle POST (login form submission) ────────────────────────────────────
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String studentId   = request.getParameter("student_id");
        String password    = request.getParameter("password");
        String selectedRole = request.getParameter("role"); // "student" or "lecturer"

        // Basic validation: all fields must be filled
        if (studentId == null || studentId.trim().isEmpty() ||
            password  == null || password.trim().isEmpty()  ||
            selectedRole == null || selectedRole.trim().isEmpty()) {
            errorMsg = "Please fill in all fields and select a role.";
        } else {
            Connection conn = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pba2_db", "root", "");

                // Query: match student_id, password AND role — prevents a student logging in as lecturer
                ps = conn.prepareStatement(
                    "SELECT student_id, full_name, workshop, role " +
                    "FROM registration WHERE student_id=? AND password=? AND role=?"
                );
                ps.setInt(1, Integer.parseInt(studentId.trim()));
                ps.setString(2, password.trim());
                ps.setString(3, selectedRole.trim());
                rs = ps.executeQuery();

                if (rs.next()) {
                    // Save user info in session
                    session.setAttribute("student_id", rs.getInt("student_id"));
                    session.setAttribute("full_name",  rs.getString("full_name"));
                    session.setAttribute("workshop",   rs.getString("workshop"));
                    session.setAttribute("role",       rs.getString("role"));

                    // Route based on role
                    if ("lecturer".equals(rs.getString("role"))) {
                        response.sendRedirect("list.jsp");
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                    return;
                } else {
                    errorMsg = "Invalid ID, Password, or Role. Please try again.";
                }
            } catch (NumberFormatException e) {
                errorMsg = "ID must be a number.";
            } catch (Exception e) {
                errorMsg = "Error: " + e.getMessage();
            } finally {
                if (rs   != null) try { rs.close();   } catch (Exception e) {}
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
    <title>Login - Workshop Registration System</title>
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

        .wrapper {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        .card {
            background: white;
            border-radius: 10px;
            padding: 36px 32px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.12);
        }

        .card h2 { font-size: 22px; color: #2c3e50; margin-bottom: 6px; text-align: center; }
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

        /* Role toggle buttons */
        .role-toggle {
            display: flex;
            gap: 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            overflow: hidden;
        }
        .role-toggle input[type="radio"] { display: none; }
        .role-toggle label {
            flex: 1;
            text-align: center;
            padding: 10px;
            cursor: pointer;
            font-size: 13px;
            font-weight: bold;
            color: #555;
            background: #f9f9f9;
            border: none;
            margin: 0;
            transition: background 0.2s, color 0.2s;
        }
        .role-toggle input[type="radio"]:checked + label {
            background: #2980b9;
            color: white;
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
            margin-top: 20px;
            background-color: #2980b9;
        }
        .btn:hover { background-color: #2471a3; }

        /* Only show "Register" link for students, not lecturers */
        .register-link {
            text-align: center;
            margin-top: 14px;
            font-size: 12px;
            color: #888;
        }
        .register-link a { color: #2980b9; text-decoration: none; }
        .register-link a:hover { text-decoration: underline; }

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
</div>

<div class="wrapper">
    <div class="card">
        <h2>Login</h2>
        <p class="subtitle">Select your role and enter your credentials to continue.</p>

        <%-- Show error message if login failed --%>
        <% if (!errorMsg.isEmpty()) { %>
        <div class="alert-error"><%= errorMsg %></div>
        <% } %>

        <form method="POST" action="login.jsp">

            <%-- Role selector: Student or Lecturer --%>
            <div class="form-group">
                <label>Login As</label>
                <div class="role-toggle">
                    <input type="radio" id="role_student" name="role" value="student" checked>
                    <label for="role_student">Student</label>
                    <input type="radio" id="role_lecturer" name="role" value="lecturer">
                    <label for="role_lecturer">Lecturer</label>
                </div>
            </div>

            <%-- ID field: used as both student_id and lecturer_id (same column) --%>
            <div class="form-group">
                <label for="student_id">ID</label>
                <input type="number" id="student_id" name="student_id" placeholder="eg. 01" required>
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" placeholder="Enter your password" required>
            </div>

            <button type="submit" class="btn">Login</button>
        </form>

        <%-- Only students need to self-register; lecturers are added manually by admin --%>
        <p class="register-link">New student? <a href="register.jsp">Register here</a></p>
    </div>
</div>

<footer>
    DFP50463 - Java Based Application Development | Politeknik Mukah Sarawak
</footer>

</body>
</html>
