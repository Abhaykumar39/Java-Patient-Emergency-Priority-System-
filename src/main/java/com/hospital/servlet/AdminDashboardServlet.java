
package com.hospital.servlet;

import com.hospital.dao.PatientDAO;

import java.io.IOException;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private PatientDAO patientDAO;

    @Override
    public void init() {
        patientDAO = new PatientDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, Integer> stats =
            patientDAO.getDashboardStatistics();

        request.setAttribute("stats", stats);

        request.getRequestDispatcher("/admin-dashboard.jsp")
               .forward(request, response);
    }
}
