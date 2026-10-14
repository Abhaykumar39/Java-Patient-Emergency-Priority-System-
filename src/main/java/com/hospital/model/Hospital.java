
package com.hospital.model;

public class Hospital {

    private int id;
    private String name;
    private String location;
    private String specialty;
    private int totalBeds;
    private int occupiedBeds;

    public Hospital(int id, String name, String location,
                    String specialty, int totalBeds,
                    int occupiedBeds) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.specialty = specialty;
        this.totalBeds = totalBeds;
        this.occupiedBeds = occupiedBeds;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getLocation() {
        return location;
    }

    public String getSpecialty() {
        return specialty;
    }

    public int getTotalBeds() {
        return totalBeds;
    }

    public int getOccupiedBeds() {
        return occupiedBeds;
    }

    public int getAvailableBeds() {
        return totalBeds - occupiedBeds;
    }
}
