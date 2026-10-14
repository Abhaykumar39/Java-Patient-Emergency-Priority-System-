
package com.hospital.service;

import com.hospital.dao.PatientDAO;
import com.hospital.model.EmergencyCase;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.PriorityQueue;

public class EmergencyService {

    private final PatientDAO dao = new PatientDAO();

    private int getPriority(String level) {
        switch (level) {
            case "CRITICAL":
                return 1;
            case "HIGH":
                return 2;
            case "MEDIUM":
                return 3;
            case "LOW":
                return 4;
            default:
                return 5;
        }
    }

    private PriorityQueue<EmergencyCase> createQueue() {

        Comparator<EmergencyCase> comparator =
            Comparator.comparingInt(
                (EmergencyCase p) ->
                    getPriority(p.getEmergencyLevel().toUpperCase())
            ).thenComparingInt(EmergencyCase::getId);

        PriorityQueue<EmergencyCase> queue =
            new PriorityQueue<>(comparator);

        queue.addAll(dao.getWaitingEmergencyPatients());

        return queue;
    }

    public List<EmergencyCase> getEmergencyQueue() {

        PriorityQueue<EmergencyCase> queue = createQueue();
        List<EmergencyCase> sortedPatients = new ArrayList<>();

        while (!queue.isEmpty()) {
            sortedPatients.add(queue.poll());
        }

        return sortedPatients;
    }

    public boolean registerEmergency(
            String name, int age, String condition, String level) {

        return dao.registerEmergencyPatient(
            name, age, condition, level
        );
    }

    public boolean treatNextPatient() {

        PriorityQueue<EmergencyCase> queue = createQueue();

        EmergencyCase nextPatient = queue.poll();

        if (nextPatient == null) {
            return false;
        }

        return dao.markEmergencyPatientTreated(nextPatient.getId());
    }
}
