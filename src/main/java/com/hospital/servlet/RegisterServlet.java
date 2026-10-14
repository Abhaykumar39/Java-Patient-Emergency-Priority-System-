
package com.hospital.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final String URL =
        "jdbc:mysql://localhost:3306/smart_hospital";
    private static final String USER = "root";

    // Use the same local MySQL password as PatientDAO.java.
    private static final String PASSWORD = "abhaykumar39";

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/register.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username == null || password == null
                || !username.trim().matches("[A-Za-z0-9_]{3,50}")
                || password.length() < 8
                || password.length() > 72) {

            request.setAttribute("error",
                "Username must be 3-50 letters/numbers/underscores. "
                + "Password must be 8-72 characters.");

            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
            return;
        }

        // Hash the password before storing it.
        String passwordHash = BCrypt.hashpw(
            password, BCrypt.gensalt(12)
        );

        String sql = "INSERT INTO app_users (username, password) "
                   + "VALUES (?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username.trim());
                ps.setString(2, passwordHash);

                ps.executeUpdate();

                response.sendRedirect(
                    request.getContextPath() + "/login?registered=1"
                );
            }

        } catch (SQLException e) {
            if ("23000".equals(e.getSQLState())) {
                request.setAttribute("error",
                    "Username already exists. Please choose another.");

                request.getRequestDispatcher("/register.jsp")
                       .forward(request, response);
            } else {
                throw new ServletException(
                    "Could not register user.", e
                );
            }

        } catch (ClassNotFoundException e) {
            throw new ServletException(
                "MySQL JDBC driver not found.", e
            );
        }
    }
}
