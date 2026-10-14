
package com.hospital.dao;

import com.hospital.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    private static final String URL =
        "jdbc:mysql://localhost:3306/smart_hospital";
    private static final String USER = "root";

    // Use the same local MySQL password as PatientDAO.java.
    private static final String PASSWORD = "abhaykumar39";

    public boolean createUser(String username,
                              String password,
                              String role) {

        if (username == null || password == null || role == null) {
            return false;
        }

        username = username.trim();

        if (!username.matches("[A-Za-z0-9_]{3,50}")
                || password.length() < 8
                || password.length() > 72
                || !role.matches("ADMIN|DOCTOR")) {
            return false;
        }

        String passwordHash = BCrypt.hashpw(
            password, BCrypt.gensalt(12)
        );

        String sql = "INSERT INTO users "
                   + "(username, password_hash, role) "
                   + "VALUES (?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username);
                ps.setString(2, passwordHash);
                ps.setString(3, role);

                return ps.executeUpdate() == 1;
            }

        } catch (SQLException e) {
            // Duplicate username or database error.
            e.printStackTrace();
            return false;

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                "MySQL JDBC driver not found", e
            );
        }
    }

    public User authenticate(String username, String password) {

        if (username == null || password == null
                || username.trim().isEmpty()
                || password.length() > 72) {
            return null;
        }

        String sql = "SELECT id, username, password_hash, role "
                   + "FROM users WHERE username = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, username.trim());

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        String storedHash =
                            rs.getString("password_hash");

                        if (BCrypt.checkpw(password, storedHash)) {
                            return new User(
                                rs.getInt("id"),
                                rs.getString("username"),
                                storedHash,
                                rs.getString("role")
                            );
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
