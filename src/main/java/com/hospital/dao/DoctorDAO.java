
package com.hospital.dao;

import com.hospital.model.Doctor;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    // Use the same database configuration as PatientDAO.java
    private static final String URL =
        "jdbc:mysql://localhost:3306/smart_hospital";
    private static final String USER = "root";

    // Replace this placeholder with your local MySQL password.
    private static final String PASSWORD = "abhaykumar39";

    public boolean addDoctor(Doctor doctor) {

        String sql = "INSERT INTO doctors (name, specialization, phone) "
                   + "VALUES (?, ?, ?)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, doctor.getName());
                ps.setString(2, doctor.getSpecialization());
                ps.setString(3, doctor.getPhone());

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Doctor> getAllDoctors() {

        List<Doctor> doctors = new ArrayList<>();

        String sql = "SELECT id, name, specialization, phone "
                   + "FROM doctors ORDER BY id DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con =
                     DriverManager.getConnection(URL, USER, PASSWORD);
                 PreparedStatement ps = con.prepareStatement(sql);
                 ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Doctor doctor = new Doctor(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("specialization"),
                        rs.getString("phone")
                    );

                    doctors.add(doctor);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doctors;
    }
}
