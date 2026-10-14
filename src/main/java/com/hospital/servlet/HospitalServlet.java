package com.hospital.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.hospital.dao.PatientDAO;
import com.hospital.model.Patient;
import java.util.List;

@WebServlet(urlPatterns = { "/hospital", "/register-patient", "/patient-list", "/search-patient", "/update-patient",
        "/edit-patient","/delete-patient"})
public class HospitalServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/patient-list".equals(path)) {
            showPatients(request, response);

        } else if ("/search-patient".equals(path)) {
            request.getRequestDispatcher("/search-patient.jsp")
                    .forward(request, response);

        } else if ("/edit-patient".equals(path)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));

                PatientDAO dao = new PatientDAO();
                Patient patient = dao.getPatientById(id);

                if (patient == null) {
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Patient not found");
                    return;
                }

                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/edit-patient.jsp")
                        .forward(request, response);

            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid patient ID");
            }
        } else {
            request.setAttribute("message",
                    "Welcome to Smart Hospital Emergency Management System");

            request.getRequestDispatcher("/index.jsp")
                    .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();

        if ("/search-patient".equals(path)) {

            try {
                int id = Integer.parseInt(request.getParameter("id"));

                PatientDAO dao = new PatientDAO();
                Patient patient = dao.getPatientById(id);

                request.setAttribute("patient", patient);
                request.getRequestDispatcher("/search-result.jsp")
                        .forward(request, response);

            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid patient ID");
            }

        }

        else if ("/delete-patient".equals(path)) {
    try {
        int id = Integer.parseInt(request.getParameter("id"));

        PatientDAO dao = new PatientDAO();
        boolean deleted = dao.deletePatient(id);

        if (deleted) {
            response.sendRedirect(
                request.getContextPath() + "/patient-list?deleted=true"
            );
        } else {
            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Patient not found"
            );
        }

    } catch (NumberFormatException e) {
        response.sendError(
            HttpServletResponse.SC_BAD_REQUEST,
            "Invalid patient ID"
        );
    }
}

        else if ("/update-patient".equals(path)) {

            try {
                int id = Integer.parseInt(request.getParameter("id"));
                String name = request.getParameter("name");
                int age = Integer.parseInt(request.getParameter("age"));
                String condition = request.getParameter("condition");

                PatientDAO dao = new PatientDAO();

                boolean updated = dao.updatePatient(
                        id, name, age, condition);

                if (updated) {
                    response.sendRedirect(
                            request.getContextPath() + "/patient-list");
                } else {
                    response.sendError(
                            HttpServletResponse.SC_NOT_FOUND,
                            "Patient not found or no changes made");
                }

            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid patient ID or age");
            }
        }

        else {

            String name = request.getParameter("name");
            String ageValue = request.getParameter("age");
            String condition = request.getParameter("condition");

            try {
                int age = Integer.parseInt(ageValue);

                PatientDAO dao = new PatientDAO();
                boolean saved = dao.savePatient(name, age, condition);

                if (saved) {
                    response.sendRedirect(
                            request.getContextPath() + "/patient-list");
                } else {
                    response.sendError(
                            HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                            "Patient registration failed");
                }

            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid patient age");
            }
        }
    }

    private void showPatients(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        PatientDAO dao = new PatientDAO();
        List<Patient> patients = dao.getAllPatients();

        request.setAttribute("patients", patients);

        request.getRequestDispatcher("/patient-list.jsp")
                .forward(request, response);
    }

}