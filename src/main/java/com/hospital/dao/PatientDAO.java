
package com.hospital.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import com.hospital.model.EmergencyCase;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.hospital.model.Hospital;
import com.hospital.model.Admission;
import java.sql.Timestamp;

public class PatientDAO {

    private static final String URL = "jdbc:mysql://localhost:3306/smart_hospital";

    private static final String USER = "root";

    private static final String PASSWORD = "abhaykumar39";

    public boolean savePatient(String name, int age, String condition) {

        String sql = "INSERT INTO patients "
                + "(name, age, medical_condition) "
                + "VALUES (?, ?, ?)";

        try {
            // Step 1: Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Step 2: Connect to MySQL
            try (
                    Connection con = DriverManager.getConnection(
                            URL, USER, PASSWORD);

                    PreparedStatement ps = con.prepareStatement(sql)) {

                // Step 3: Set patient details
                ps.setString(1, name);
                ps.setInt(2, age);
                ps.setString(3, condition);

                // Step 4: Insert patient into database
                int rows = ps.executeUpdate();

                return rows > 0;
            }

        } catch (ClassNotFoundException e) {
            throw new RuntimeException(
                    "MySQL JDBC Driver not found", e);

        } catch (SQLException e) {
            throw new RuntimeException(
                    "Database connection/insert failed", e);
        }
    }

    public java.util.List<com.hospital.model.Patient> getAllPatients() {

        java.util.List<com.hospital.model.Patient> patients = new java.util.ArrayList<>();

        String sql = "SELECT * FROM patients";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (
                    Connection con = DriverManager.getConnection(
                            URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql);
                    java.sql.ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    com.hospital.model.Patient p = new com.hospital.model.Patient();

                    p.setId(rs.getInt("id"));
                    p.setName(rs.getString("name"));
                    p.setAge(rs.getInt("age"));
                    p.setCondition(
                            rs.getString("medical_condition"));

                    patients.add(p);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return patients;
    }

    public com.hospital.model.Patient getPatientById(int id) {

        String sql = "SELECT * FROM patients WHERE id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (
                    Connection con = DriverManager.getConnection(
                            URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, id);

                try (java.sql.ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        com.hospital.model.Patient patient = new com.hospital.model.Patient();

                        patient.setId(rs.getInt("id"));
                        patient.setName(rs.getString("name"));
                        patient.setAge(rs.getInt("age"));
                        patient.setCondition(
                                rs.getString("medical_condition"));

                        return patient;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updatePatient(int id, String name, int age,
            String condition) {

        String sql = "UPDATE patients SET name = ?, age = ?, "
                + "medical_condition = ? WHERE id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (
                    Connection con = DriverManager.getConnection(
                            URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setString(1, name);
                ps.setInt(2, age);
                ps.setString(3, condition);
                ps.setInt(4, id);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deletePatient(int id) {
        String sql = "DELETE FROM patients WHERE id = ?";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean registerEmergencyPatient(
            String name, int age, String condition,
            String emergencyLevel) {

        String sql = "INSERT INTO patients " +
                "(name, age, medical_condition, emergency_level, status) " +
                "VALUES (?, ?, ?, ?, 'WAITING')";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setInt(2, age);
                ps.setString(3, condition);
                ps.setString(4, emergencyLevel);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EmergencyCase> getWaitingEmergencyPatients() {

        List<EmergencyCase> patients = new ArrayList<>();

        String sql = "SELECT id, name, age, medical_condition, " +
                "emergency_level, status FROM patients WHERE status = 'WAITING'";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    EmergencyCase patient = new EmergencyCase(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getInt("age"),
                            rs.getString("medical_condition"),
                            rs.getString("emergency_level"),
                            rs.getString("status"));

                    patients.add(patient);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return patients;
    }

    public boolean markEmergencyPatientTreated(int id) {

        String sql = "UPDATE patients SET status = 'TREATED' " +
                "WHERE id = ? AND status = 'WAITING'";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setInt(1, id);
                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Hospital> getAllHospitals() {

        List<Hospital> hospitals = new ArrayList<>();

        String sql = "SELECT * FROM hospitals ORDER BY name";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    hospitals.add(new Hospital(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("location"),
                            rs.getString("specialty"),
                            rs.getInt("total_beds"),
                            rs.getInt("occupied_beds")));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return hospitals;
    }

    public boolean addHospital(String name, String location,
            String specialty, int totalBeds) {

        String sql = "INSERT INTO hospitals " +
                "(name, location, specialty, total_beds, occupied_beds) " +
                "VALUES (?, ?, ?, ?, 0)";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, name);
                ps.setString(2, location);
                ps.setString(3, specialty);
                ps.setInt(4, totalBeds);

                return ps.executeUpdate() > 0;
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Admission> getAllAdmissions() {

        List<Admission> admissions = new ArrayList<>();

        String sql = "SELECT a.id, a.patient_id, p.name AS patient_name, " +
                "a.hospital_id, h.name AS hospital_name, " +
                "a.admitted_at, a.status " +
                "FROM admissions a " +
                "JOIN patients p ON a.patient_id = p.id " +
                "JOIN hospitals h ON a.hospital_id = h.id " +
                "ORDER BY CASE WHEN a.status = 'ADMITTED' THEN 0 ELSE 1 END, " +
                "a.admitted_at DESC";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql);
                    ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    Timestamp timestamp = rs.getTimestamp("admitted_at");

                    admissions.add(new Admission(
                            rs.getInt("id"),
                            rs.getInt("patient_id"),
                            rs.getString("patient_name"),
                            rs.getInt("hospital_id"),
                            rs.getString("hospital_name"),
                            timestamp == null ? "" : timestamp.toString(),
                            rs.getString("status")));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return admissions;
    }

    public String admitPatient(int patientId, int hospitalId) {

        String result = "ERROR";
        String checkPatient = "SELECT id FROM patients WHERE id = ?";
        String checkAdmission = "SELECT id FROM admissions WHERE patient_id = ? AND status = 'ADMITTED'";
        String occupyBed = "UPDATE hospitals SET occupied_beds = occupied_beds + 1 " +
                "WHERE id = ? AND occupied_beds < total_beds";
        String insertAdmission = "INSERT INTO admissions (patient_id, hospital_id, status) " +
                "VALUES (?, ?, 'ADMITTED')";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

                con.setAutoCommit(false);

                try {
                    try (PreparedStatement ps = con.prepareStatement(checkPatient)) {
                        ps.setInt(1, patientId);

                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next()) {
                                con.rollback();
                                return "PATIENT_NOT_FOUND";
                            }
                        }
                    }

                    try (PreparedStatement ps = con.prepareStatement(checkAdmission)) {
                        ps.setInt(1, patientId);

                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next()) {
                                con.rollback();
                                return "ALREADY_ADMITTED";
                            }
                        }
                    }

                    try (PreparedStatement ps = con.prepareStatement(occupyBed)) {
                        ps.setInt(1, hospitalId);

                        if (ps.executeUpdate() == 0) {
                            con.rollback();
                            return "NO_BED";
                        }
                    }

                    try (PreparedStatement ps = con.prepareStatement(insertAdmission)) {
                        ps.setInt(1, patientId);
                        ps.setInt(2, hospitalId);
                        ps.executeUpdate();
                    }

                    con.commit();
                    result = "SUCCESS";

                } catch (Exception e) {
                    con.rollback();
                    throw e;
                } finally {
                    con.setAutoCommit(true);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public boolean dischargePatient(int admissionId) {

        String resultStatus = "ADMITTED";

        String findAdmission = "SELECT hospital_id FROM admissions " +
                "WHERE id = ? AND status = ? FOR UPDATE";

        String discharge = "UPDATE admissions SET status = 'DISCHARGED', " +
                "discharged_at = CURRENT_TIMESTAMP " +
                "WHERE id = ? AND status = 'ADMITTED'";

        String releaseBed = "UPDATE hospitals SET occupied_beds = occupied_beds - 1 " +
                "WHERE id = ? AND occupied_beds > 0";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD)) {

                con.setAutoCommit(false);

                try {
                    int hospitalId;

                    try (PreparedStatement ps = con.prepareStatement(findAdmission)) {
                        ps.setInt(1, admissionId);
                        ps.setString(2, resultStatus);

                        try (ResultSet rs = ps.executeQuery()) {
                            if (!rs.next()) {
                                con.rollback();
                                return false;
                            }

                            hospitalId = rs.getInt("hospital_id");
                        }
                    }

                    try (PreparedStatement ps = con.prepareStatement(discharge)) {
                        ps.setInt(1, admissionId);

                        if (ps.executeUpdate() != 1) {
                            con.rollback();
                            return false;
                        }
                    }

                    try (PreparedStatement ps = con.prepareStatement(releaseBed)) {
                        ps.setInt(1, hospitalId);

                        if (ps.executeUpdate() != 1) {
                            con.rollback();
                            return false;
                        }
                    }

                    con.commit();
                    return true;

                } catch (Exception e) {
                    con.rollback();
                    throw e;
                } finally {
                    con.setAutoCommit(true);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<EmergencyCase> searchEmergencyPatients(String query) {

        List<EmergencyCase> patients = new ArrayList<>();

        String sql = "SELECT id, name, age, medical_condition, emergency_level, status " +
                "FROM patients " +
                "WHERE status IN ('WAITING', 'TREATED') " +
                "AND (CAST(id AS CHAR) = ? OR LOWER(name) LIKE ?) " +
                "ORDER BY CASE UPPER(emergency_level) " +
                "WHEN 'CRITICAL' THEN 1 " +
                "WHEN 'HIGH' THEN 2 " +
                "WHEN 'MEDIUM' THEN 3 " +
                "WHEN 'LOW' THEN 4 ELSE 5 END, id";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASSWORD);
                    PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, query);
                ps.setString(2, "%" + query.toLowerCase() + "%");

                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        patients.add(new EmergencyCase(
                                rs.getInt("id"),
                                rs.getString("name"),
                                rs.getInt("age"),
                                rs.getString("medical_condition"),
                                rs.getString("emergency_level"),
                                rs.getString("status")));
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return patients;
    }

    
public List<EmergencyCase> getEmergencyHistory() {
    List<EmergencyCase> history = new ArrayList<>();

    String sql = "SELECT id, name, age, medical_condition, " +
                 "emergency_level, status " +
                 "FROM patients " +
                 "WHERE status = 'TREATED' " +
                 "ORDER BY created_at DESC, id DESC";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection con =
                 DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                EmergencyCase patient = new EmergencyCase(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getInt("age"),
                    rs.getString("medical_condition"),
                    rs.getString("emergency_level"),
                    rs.getString("status")
                );

                history.add(patient);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return history;
}


public List<Hospital> recommendHospitals(String requiredSpecialty) {

    List<Hospital> hospitals = new ArrayList<>();

    String sql =
        "SELECT id, name, location, specialty, total_beds, occupied_beds " +
        "FROM hospitals " +
        "WHERE occupied_beds < total_beds " +
        "AND LOWER(specialty) = LOWER(?) " +
        "ORDER BY (total_beds - occupied_beds) DESC, name";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection con =
                 DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, requiredSpecialty.trim());

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {
                    hospitals.add(new Hospital(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("location"),
                        rs.getString("specialty"),
                        rs.getInt("total_beds"),
                        rs.getInt("occupied_beds")
                    ));
                }
            }

        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return hospitals;
}



public java.util.Map<String, Integer> getDashboardStatistics() {

    java.util.Map<String, Integer> stats = new java.util.LinkedHashMap<>();

    String sql =
        "SELECT " +
        "(SELECT COUNT(*) FROM patients) AS total_patients, " +
        "(SELECT COUNT(*) FROM hospitals) AS total_hospitals, " +
        "(SELECT COUNT(*) FROM doctors) AS total_doctors, " +
        "(SELECT COALESCE(SUM(total_beds - occupied_beds), 0) " +
        " FROM hospitals) AS available_beds, " +
        "(SELECT COUNT(*) FROM patients " +
        " WHERE status = 'WAITING') AS waiting_emergencies";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection con =
                 DriverManager.getConnection(URL, USER, PASSWORD);
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                stats.put("totalPatients", rs.getInt("total_patients"));
                stats.put("totalHospitals", rs.getInt("total_hospitals"));
                stats.put("totalDoctors", rs.getInt("total_doctors"));
                stats.put("availableBeds", rs.getInt("available_beds"));
                stats.put("waitingEmergencies",
                          rs.getInt("waiting_emergencies"));
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
    }

    return stats;
}

}
