
package com.hospital.servlet;

import com.hospital.dao.PatientDAO;
import com.hospital.model.Hospital;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/hospital-recommendation")
public class HospitalRecommendationServlet extends HttpServlet {

    private PatientDAO patientDAO;

    @Override
    public void init() {
        patientDAO = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
            "/hospital-recommendation.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String specialty = request.getParameter("specialty");

        if (specialty == null || specialty.trim().isEmpty()
                || specialty.trim().length() > 100) {

            request.setAttribute("error", "Please enter a valid specialty.");
            request.getRequestDispatcher(
                "/hospital-recommendation.jsp"
            ).forward(request, response);
            return;
        }

        List<Hospital> hospitals =
            patientDAO.recommendHospitals(specialty.trim());

        request.setAttribute("specialty", specialty.trim());
        request.setAttribute("hospitals", hospitals);
        request.setAttribute("searched", true);

        request.getRequestDispatcher(
            "/hospital-recommendation.jsp"
        ).forward(request, response);
    }
}
