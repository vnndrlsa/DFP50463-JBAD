import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Load JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection
            conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/company_db", "root", ""
            );

            // JOIN Users and Roles table
            String sql = "SELECT u.username, r.role_name " +
                         "FROM Users u JOIN Roles r ON u.role_id = r.role_id " +
                         "WHERE u.username = ? AND u.password = ?";

            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Valid - create session
                HttpSession session = request.getSession();
                session.setAttribute("user", username);
                session.setAttribute("role", rs.getString("role_name"));
                session.setAttribute("userDisplayName", username);

                // Redirect to welcome page
                response.sendRedirect("welcome.jsp");
            } else {
                // Invalid - redirect to error page
                response.sendRedirect("error.jsp");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            // Close all resources
            try { if (rs != null) rs.close(); } catch (SQLException e) {}
            try { if (stmt != null) stmt.close(); } catch (SQLException e) {}
            try { if (conn != null) conn.close(); } catch (SQLException e) {}
        }
    }
}