package com.hospital.model;

public class Patient {
    private int id;
    private String name;
    private int age;
    private String condition;

    public Patient() {
    }

    public Patient(int id, String name, int age, String condition) {
        this.id = id;
        this.name = name;
        this.age = age;
        this.condition = condition;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getCondition() {
        return condition;
    }

    public void setCondition(String condition) {
        this.condition = condition;
    }
}