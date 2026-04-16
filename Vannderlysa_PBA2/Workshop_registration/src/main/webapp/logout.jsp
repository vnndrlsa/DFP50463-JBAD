<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // ── Invalidate the entire session to log the user out ─────────────────────
    // This clears student_id, full_name, workshop, and role from the session
    session.invalidate();

    // Redirect to login page after logout
    response.sendRedirect("login.jsp");
%>
