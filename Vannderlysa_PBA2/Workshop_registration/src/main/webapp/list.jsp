<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    // ── Auth check: must be logged in ─────────────────────────────────────────
    if (session.getAttribute("student_id") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // ── Role check: only lecturers can access this page ────────────────────────
    String role = (String) session.getAttribute("role");
    if (!"lecturer".equals(role)) {
        // Students should not be on this page; redirect to their dashboard
        response.sendRedirect("index.jsp");
        return;
    }

    String lecturerName = (String) session.getAttribute("full_name");
    String successMsg   = request.getParameter("success") != null ? request.getParameter("success") : "";
    String errorMsg     = "";

    // ── Read filter / search values from query string ─────────────────────────
    String filterWorkshop = request.getParameter("filterWorkshop") != null ? request.getParameter("filterWorkshop").trim() : "";
    String searchKeyword  = request.getParameter("search")         != null ? request.getParameter("search").trim()         : "";

    // List to hold each row: [student_id, full_name, workshop, registered_at]
    java.util.List<String[]> dataList = new java.util.ArrayList<>();
    int totalCount = 0;

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pba2_db", "root", "");

        // Only fetch students (not lecturer accounts) in the list
        String sql = "SELECT student_id, full_name, workshop, registered_at " +
                     "FROM registration WHERE role = 'student'";
        if (!filterWorkshop.isEmpty()) sql += " AND workshop = ?";
        if (!searchKeyword.isEmpty())  sql += " AND (full_name LIKE ? OR workshop LIKE ?)";
        sql += " ORDER BY registered_at DESC";

        ps = conn.prepareStatement(sql);
        int idx = 1;
        if (!filterWorkshop.isEmpty()) ps.setString(idx++, filterWorkshop);
        if (!searchKeyword.isEmpty()) {
            ps.setString(idx++, "%" + searchKeyword + "%");
            ps.setString(idx++, "%" + searchKeyword + "%");
        }

        rs = ps.executeQuery();
        while (rs.next()) {
            totalCount++;
            String[] row = {
                String.valueOf(rs.getInt("student_id")),   // [0] ID (needed for edit/delete links)
                rs.getString("full_name"),                  // [1] name
                rs.getString("workshop"),                   // [2] workshop
                rs.getString("registered_at")               // [3] date
            };
            dataList.add(row);
        }
    } catch (Exception ex) {
        errorMsg = "Failed to connect to database: " + ex.getMessage();
    } finally {
        if (rs   != null) try { rs.close();   } catch (Exception e) {}
        if (ps   != null) try { ps.close();   } catch (Exception e) {}
        if (conn != null) try { conn.close();  } catch (Exception e) {}
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Registrations - Workshop Registration System</title>
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

        .content {
            flex: 1;
            padding: 30px 24px;
            max-width: 960px;
            margin: 0 auto;
            width: 100%;
        }

        .top-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 14px;
        }
        .top-bar h2 { font-size: 18px; color: #2c3e50; }
        .top-bar span { font-size: 13px; color: #777; }

        .btn-add {
            background-color: #27ae60;
            color: white;
            font-size: 13px;
            font-weight: bold;
            padding: 9px 18px;
            border-radius: 6px;
            border: none;
            text-decoration: none;
            cursor: pointer;
        }
        .btn-add:hover { background-color: #1e8449; }

        /* Filter / search bar */
        .filter-bar {
            display: flex;
            gap: 10px;
            margin-bottom: 16px;
            flex-wrap: wrap;
        }
        .filter-bar input[type="text"] {
            flex: 1;
            min-width: 160px;
            padding: 9px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 13px;
            font-family: Arial, sans-serif;
            outline: none;
        }
        .filter-bar input:focus { border-color: #2980b9; }
        .filter-bar select {
            padding: 9px 12px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 13px;
            font-family: Arial, sans-serif;
            outline: none;
            color: #333;
        }
        .filter-bar select:focus { border-color: #2980b9; }
        .btn-search {
            padding: 9px 18px;
            background-color: #2980b9;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
        }
        .btn-search:hover { background-color: #2471a3; }
        .btn-reset {
            padding: 9px 14px;
            background-color: #7f8c8d;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: bold;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-reset:hover { background-color: #6c7a7d; }

        .alert {
            padding: 10px 14px;
            border-radius: 6px;
            font-size: 13px;
            margin-bottom: 16px;
        }
        .alert-success { background: #d4edda; border: 1px solid #c3e6cb; color: #155724; }
        .alert-error   { background: #fdecea; border: 1px solid #f5c6cb; color: #c0392b; }

        .table-wrap {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.10);
            overflow: hidden;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            font-size: 13px;
        }

        thead { background-color: #2c3e50; color: white; }
        thead th { padding: 12px 14px; text-align: left; font-size: 13px; }

        tbody tr { border-bottom: 1px solid #eee; }
        tbody tr:last-child { border-bottom: none; }
        tbody tr:hover { background-color: #f9f9f9; }
        tbody td { padding: 11px 14px; color: #333; vertical-align: middle; }

        /* Action buttons inside table rows */
        .btn-edit {
            background-color: #f39c12;
            color: white;
            padding: 5px 12px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: bold;
            text-decoration: none;
            margin-right: 4px;
        }
        .btn-edit:hover { background-color: #d68910; }

        .btn-delete {
            background-color: #e74c3c;
            color: white;
            padding: 5px 12px;
            border-radius: 5px;
            font-size: 12px;
            font-weight: bold;
            text-decoration: none;
        }
        .btn-delete:hover { background-color: #c0392b; }

        .empty-msg {
            text-align: center;
            padding: 48px;
            color: #999;
            font-size: 14px;
        }

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
        <%-- Lecturers see: Home (list), Register New Student, Logout --%>
        <span class="user-info">&#128203; <%= lecturerName %></span>
        <a href="list.jsp" class="active">Home</a>
        <a href="register_by_lecturer.jsp">Register Student</a>
        <a href="logout.jsp">Logout</a>
    </div>
</div>

<div class="content">

    <%-- Success / error flash messages --%>
    <% if (!successMsg.isEmpty()) { %>
    <div class="alert alert-success"><%= successMsg %></div>
    <% } %>
    <% if (!errorMsg.isEmpty()) { %>
    <div class="alert alert-error"><%= errorMsg %></div>
    <% } %>

    <div class="top-bar">
        <div>
            <h2>All Registrations</h2>
            <span>Total: <%= totalCount %> record</span>
        </div>
        <%-- "+ Add New" button only visible to lecturers --%>
        <a href="register_by_lecturer.jsp" class="btn-add">+ Add New</a>
    </div>

    <%-- Filter and search form (GET so filters appear in URL) --%>
    <form method="GET" action="list.jsp">
        <div class="filter-bar">
            <input type="text" name="search" placeholder="Search by name or workshop..."
                   value="<%= searchKeyword %>">
            <select name="filterWorkshop">
                <option value="">-- All Workshops --</option>
                <option value="Python Programming"                 <%= "Python Programming".equals(filterWorkshop)                 ? "selected" : "" %>>Python Programming</option>
                <option value="Java Based Application Development" <%= "Java Based Application Development".equals(filterWorkshop) ? "selected" : "" %>>Java Based Application Development</option>
                <option value="Fullstack Web Development"          <%= "Fullstack Web Development".equals(filterWorkshop)          ? "selected" : "" %>>Fullstack Web Development</option>
            </select>
            <button type="submit" class="btn-search">Search</button>
            <a href="list.jsp" class="btn-reset">Reset</a>
        </div>
    </form>

    <div class="table-wrap">
        <% if (dataList.isEmpty()) { %>
        <div class="empty-msg">No registration records found.</div>
        <% } else { %>
        <table>
            <thead>
                <tr>
                    <th>Full Name</th>
                    <th>Workshop</th>
                    <th>Registered At</th>
                    <%-- Action column only shown to lecturers --%>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <% for (String[] row : dataList) { %>
                <tr>
                    <td><%= row[1] %></td>   <%-- Full Name --%>
                    <td><%= row[2] %></td>   <%-- Workshop --%>
                    <td><%= row[3] %></td>   <%-- Registered At --%>
                    <td>
                        <%-- Edit and Delete links use student_id (row[0]) as the record key --%>
                        <a href="edit.jsp?id=<%= row[0] %>" class="btn-edit">Edit</a>
                        <a href="delete.jsp?id=<%= row[0] %>"
                           class="btn-delete"
                           onclick="return confirm('Are you sure you want to delete this record?');">Delete</a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>
    </div>

</div>

<footer>
    DFP50463 - Java Based Application Development | Politeknik Mukah Sarawak
</footer>

</body>
</html>
