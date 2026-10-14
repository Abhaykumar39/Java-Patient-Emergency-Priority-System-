
package com.hospital.servlet;

import com.hospital.model.EmergencyCase;
import com.hospital.service.EmergencyService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.hospital.dao.PatientDAO;
import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {
        "/emergency-queue",
        "/emergency-register",
        "/register-emergency",
        "/treat-next",
        "/emergency-search",
        "/emergency-history"
})
public class EmergencyServlet extends HttpServlet {

    private EmergencyService service;

    @Override
    public void init() {
        service = new EmergencyService();
    }

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getServletPath();

        if ("/emergency-register".equals(path)) {
            request.getRequestDispatcher(
                    "/emergency-register.jsp").forward(request, response);

        } else if ("/emergency-history".equals(path)) {
            PatientDAO dao = new PatientDAO();

            request.setAttribute(
                    "history",
                    dao.getEmergencyHistory());

            request.getRequestDispatcher(
                    "/emergency-history.jsp").forward(request, response);
        }

        else if ("/emergency-search".equals(path)) {

            String query = request.getParameter("q");

            List<EmergencyCase> results = new java.util.ArrayList<>();

            if (query != null && !query.trim().isEmpty()) {
                PatientDAO dao = new PatientDAO();

                results = dao.searchEmergencyPatients(query.trim());
            }

            request.setAttribute("results", results);
            request.setAttribute(
                    "query",
                    query == null ? "" : query.trim());

            request.getRequestDispatcher(
                    "/emergency-search.jsp").forward(request, response);
        }

        else {
            List<EmergencyCase> patients = service.getEmergencyQueue();

            request.setAttribute("patients", patients);

            request.getRequestDispatcher(
                    "/emergency-queue.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String path = request.getServletPath();

        if ("/register-emergency".equals(path)) {

            String name = request.getParameter("name");
            String condition = request.getParameter("condition");
            String level = request.getParameter("emergencyLevel");
            String ageValue = request.getParameter("age");

            try {
                int age = Integer.parseInt(ageValue);

                boolean validLevel = "CRITICAL".equals(level)
                        || "HIGH".equals(level)
                        || "MEDIUM".equals(level)
                        || "LOW".equals(level);

                if (name == null || name.trim().isEmpty()
                        || condition == null
                        || condition.trim().isEmpty()
                        || age < 0 || age > 130
                        || !validLevel) {

                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid patient details");
                    return;
                }

                boolean registered = service.registerEmergency(
                        name.trim(), age, condition.trim(), level);

                if (registered) {
                    response.sendRedirect(
                            request.getContextPath()
                                    + "/emergency-queue?registered=true");
                } else {
                    response.sendError(
                            HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                            "Patient registration failed");
                }

            } catch (NumberFormatException e) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid age");
            }

        } else if ("/treat-next".equals(path)) {

            boolean treated = service.treatNextPatient();

            String result = treated ? "treated" : "empty";

            response.sendRedirect(
                    request.getContextPath()
                            + "/emergency-queue?result=" + result);

        } else {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND);
        }
    }
}
