<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // ── Auth check ─────────────────────────────────────────────────────────────
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ── Role check: only lecturers can edit records ────────────────────────────
    String role = (String) session.getAttribute("role");
    if (!"lecturer".equals(role)) {
        response.sendRedirect("index.jsp");
        return;
    }

    String paramId  = request.getParameter("id");
    String errorMsg = "";
    String dbId = "", dbName = "", dbEmail = "", dbWorkshop = "";

    // Must have an id param to know which record to edit
    if (paramId == null || paramId.trim().isEmpty()) {
        response.sendRedirect("list.jsp");
        return;
    }

    // ── Handle POST (lecturer submits the update form) ─────────────────────────
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String fullName = request.getParameter("full_name");
        String email    = request.getParameter("email");
        String workshop = request.getParameter("workshop");

        if (fullName == null || fullName.trim().isEmpty() ||
            email    == null || email.trim().isEmpty()    ||
            workshop == null || workshop.trim().isEmpty()) {
            errorMsg = "Please fill in all information.";
        } else {
            Connection conn = null; PreparedStatement ps = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pba2_db", "root", "");

                // Update name, email, and workshop — student_id stays unchanged
                ps = conn.prepareStatement(
                    "UPDATE registration SET full_name=?, email=?, workshop=? WHERE student_id=?"
                );
                ps.setString(1, fullName.trim());
                ps.setString(2, email.trim());
                ps.setString(3, workshop.trim());
                ps.setInt(4, Integer.parseInt(paramId));
                ps.executeUpdate();

                response.sendRedirect("list.jsp?success=Record+successfully+updated.");
                return;
            } catch (Exception ex) {
                errorMsg = "Update failed: " + ex.getMessage();
            } finally {
                if (ps   != null) try { ps.close();   } catch (Exception e) {}
                if (conn != null) try { conn.close();  } catch (Exception e) {}
            }
        }
    }

    // ── Load existing record from DB to pre-fill the form ─────────────────────
    Connection conn2 = null; PreparedStatement ps2 = null; ResultSet rs2 = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn2 = DriverManager.getConnection("jdbc:mysql://localhost:3306/pba2_db", "root", "");
        ps2 = conn2.prepareStatement("SELECT * FROM registration WHERE student_id=?");
        ps2.setInt(1, Integer.parseInt(paramId));
        rs2 = ps2.executeQuery();
        if (rs2.next()) {
            dbId       = String.valueOf(rs2.getInt("student_id"));
            dbName     = rs2.getString("full_name");
            dbEmail    = rs2.getString("email");
            dbWorkshop = rs2.getString("workshop");
        } else {
            // Record not found, go back to list
            response.sendRedirect("list.jsp");
            return;
        }
    } catch (Exception ex) {
        errorMsg = "Error: " + ex.getMessage();
    } finally {
        if (rs2   != null) try { rs2.close();   } catch (Exception e) {}
        if (ps2   != null) try { ps2.close();   } catch (Exception e) {}
        if (conn2 != null) try { conn2.close();  } catch (Exception e) {}
    }

    // If POST had a validation error, restore the values the user typed
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        if (request.getParameter("full_name") != null) dbName     = request.getParameter("full_name");
        if (request.getParameter("email")     != null) dbEmail    = request.getParameter("email");
        if (request.getParameter("workshop")  != null) dbWorkshop = request.getParameter("workshop");
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Registration</title>
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
            max-width: 460px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.12);
        }

        .card h2 { font-size: 20px; color: #2c3e50; margin-bottom: 6px; text-align: center; }
        .card .subtitle { font-size: 12px; color: #888; text-align: center; margin-bottom: 20px; }

        .info-box {
            background: #fff8e1;
            border: 1px solid #ffe082;
            border-radius: 6px;
            padding: 9px 14px;
            font-size: 12px;
            color: #7c5300;
            margin-bottom: 18px;
        }

        .alert-error {
            background: #fdecea;
            border: 1px solid #f5c6cb;
            color: #c0392b;
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 16px;
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
        input[readonly] { background: #ecf0f1; color: #888; cursor: not-allowed; }

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
        .btn-update { background-color: #f39c12; }
        .btn-update:hover { background-color: #d68910; }
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
        <a href="register_by_lecturer.jsp">Register Student</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="wrapper">
    <div class="card">
        <h2>Edit Registration</h2>
        <p class="subtitle">Update student registration information</p>

        <div class="info-box">
            Student ID cannot be changed. Only name, email and workshop can be updated.
        </div>

        <%-- Validation error from POST --%>
        <% if (!errorMsg.isEmpty()) { %>
        <div class="alert-error"><%= errorMsg %></div>
        <% } %>

        <form method="POST" action="edit.jsp?id=<%= dbId %>">
            <input type="hidden" name="student_id" value="<%= dbId %>">

            <%-- Read-only field to show the student ID --%>
            <div class="form-group">
                <label>Student ID</label>
                <input type="text" value="<%= dbId %>" readonly>
            </div>

            <div class="form-group">
                <label for="full_name">Full Name</label>
                <input type="text" id="full_name" name="full_name" value="<%= dbName %>" required maxlength="50">
            </div>

            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" value="<%= dbEmail %>" required maxlength="50">
            </div>

            <div class="form-group">
                <label for="workshop">Workshop</label>
                <select id="workshop" name="workshop" required>
                    <option value="Python Programming"                 <%= "Python Programming".equals(dbWorkshop)                 ? "selected" : "" %>>Python Programming</option>
                    <option value="Java Based Application Development" <%= "Java Based Application Development".equals(dbWorkshop) ? "selected" : "" %>>Java Based Application Development</option>
                    <option value="Fullstack Web Development"          <%= "Fullstack Web Development".equals(dbWorkshop)          ? "selected" : "" %>>Fullstack Web Development</option>
                </select>
            </div>

            <div class="btn-row">
                <a href="list.jsp" class="btn btn-back">Cancel</a>
                <button type="submit" class="btn btn-update">Update</button>
            </div>
        </form>
    </div>
</div>

<footer>
    DFP50463 - Java Based Application Development | Politeknik Mukah Sarawak
</footer>

</body>
</html>
