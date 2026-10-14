
package com.hospital.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final String URL =
        "jdbc:mysql://localhost:3306/smart_hospital";

    private static final String USER = "root";

    // Use the same MySQL password as PatientDAO.java.
    private static final String PASSWORD = "abhaykumar39";

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session != null && session.getAttribute("userId") != null) {
            response.sendRedirect(
                request.getContextPath() + "/index.jsp"
            );
            return;
        }

        request.getRequestDispatcher("/login.jsp")
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
                || username.trim().isEmpty()
                || password.isEmpty()) {

            request.setAttribute("error",
                "Please enter username and password.");

            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
            return;
        }

        String sql =
            "SELECT id, username, password FROM app_users WHERE username = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username.trim());

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()
                            && BCrypt.checkpw(
                                password, rs.getString("password"))) {

                        HttpSession session = request.getSession(true);
                        request.changeSessionId();

                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute(
                            "username", rs.getString("username")
                        );

                        response.sendRedirect(
                            request.getContextPath() + "/index.jsp"
                        );

                    } else {
                        request.setAttribute("error",
                            "Invalid username or password.");

                        request.getRequestDispatcher("/login.jsp")
                               .forward(request, response);
                    }
                }
            }

        } catch (Exception e) {
            throw new ServletException("Login failed.", e);
        }
    }
}
