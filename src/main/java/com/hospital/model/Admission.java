
package com.hospital.model;

public class Admission {

    private int id;
    private int patientId;
    private String patientName;
    private int hospitalId;
    private String hospitalName;
    private String admittedAt;
    private String status;

    public Admission(int id, int patientId, String patientName,
                     int hospitalId, String hospitalName,
                     String admittedAt, String status) {
        this.id = id;
        this.patientId = patientId;
        this.patientName = patientName;
        this.hospitalId = hospitalId;
        this.hospitalName = hospitalName;
        this.admittedAt = admittedAt;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public int getPatientId() {
        return patientId;
    }

    public String getPatientName() {
        return patientName;
    }

    public int getHospitalId() {
        return hospitalId;
    }

    public String getHospitalName() {
        return hospitalName;
    }

    public String getAdmittedAt() {
        return admittedAt;
    }

    public String getStatus() {
        return status;
    }
}
