
package com.hospital.servlet;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Admission;
import com.hospital.model.Hospital;
import com.hospital.model.Patient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
    "/hospital-management",
    "/add-hospital",
    "/admit-patient",
    "/discharge-patient"
})
public class HospitalManagementServlet extends HttpServlet {

    private PatientDAO dao;

    @Override
    public void init() {
        dao = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Hospital> hospitals = dao.getAllHospitals();
        List<Patient> patients = dao.getAllPatients();
        List<Admission> admissions = dao.getAllAdmissions();

        request.setAttribute("hospitals", hospitals);
        request.setAttribute("patients", patients);
        request.setAttribute("admissions", admissions);

        request.getRequestDispatcher(
            "/hospital-management.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();
        String context = request.getContextPath();

        if ("/add-hospital".equals(path)) {

            String name = request.getParameter("name");
            String location = request.getParameter("location");
            String specialty = request.getParameter("specialty");
            String bedsValue = request.getParameter("totalBeds");

            try {
                int totalBeds = Integer.parseInt(bedsValue);

                if (name == null || name.trim().isEmpty()
                        || location == null || location.trim().isEmpty()
                        || specialty == null || specialty.trim().isEmpty()
                        || totalBeds < 1 || totalBeds > 100000) {

                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid hospital details"
                    );
                    return;
                }

                boolean added = dao.addHospital(
                    name.trim(),
                    location.trim(),
                    specialty.trim(),
                    totalBeds
                );

                if (added) {
                    response.sendRedirect(
                        context + "/hospital-management?result=hospital-added"
                    );
                } else {
                    response.sendRedirect(
                        context + "/hospital-management?result=error"
                    );
                }

            } catch (NumberFormatException e) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid bed count"
                );
            }

        } else if ("/admit-patient".equals(path)) {

            try {
                int patientId = Integer.parseInt(
                    request.getParameter("patientId")
                );

                int hospitalId = Integer.parseInt(
                    request.getParameter("hospitalId")
                );

                if (patientId <= 0 || hospitalId <= 0) {
                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid patient or hospital ID"
                    );
                    return;
                }

                String result = dao.admitPatient(patientId, hospitalId);

                response.sendRedirect(
                    context + "/hospital-management?result=" + result
                );

            } catch (NumberFormatException e) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid patient or hospital ID"
                );
            }

        } else if ("/discharge-patient".equals(path)) {

            try {
                int admissionId = Integer.parseInt(
                    request.getParameter("admissionId")
                );

                if (admissionId <= 0) {
                    response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid admission ID"
                    );
                    return;
                }

                boolean discharged = dao.dischargePatient(admissionId);

                response.sendRedirect(
                    context + "/hospital-management?result="
                    + (discharged ? "discharged" : "discharge-error")
                );

            } catch (NumberFormatException e) {
                response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid admission ID"
                );
            }

        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
