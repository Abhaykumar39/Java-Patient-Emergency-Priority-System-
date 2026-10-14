
package com.hospital.model;

public class EmergencyCase {

    private int id;
    private String name;
    private int age;
    private String condition;
    private String emergencyLevel;
    private String status;

    public EmergencyCase(int id, String name, int age,
                         String condition, String emergencyLevel,
                         String status) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.condition = condition;
        this.emergencyLevel = emergencyLevel;
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getAge() {
        return age;
    }

    public String getCondition() {
        return condition;
    }

    public String getEmergencyLevel() {
        return emergencyLevel;
    }

    public String getStatus() {
        return status;
    }
}
