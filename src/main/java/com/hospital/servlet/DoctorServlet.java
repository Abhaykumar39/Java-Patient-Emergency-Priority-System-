
package com.hospital.servlet;

import com.hospital.dao.DoctorDAO;
import com.hospital.model.Doctor;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/doctors")
public class DoctorServlet extends HttpServlet {

    private DoctorDAO doctorDAO;

    @Override
    public void init() {
        doctorDAO = new DoctorDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Doctor> doctors = doctorDAO.getAllDoctors();

        request.setAttribute("doctors", doctors);

        request.getRequestDispatcher("/doctors.jsp")
               .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String phone = request.getParameter("phone");

        if (name == null || name.trim().isEmpty()
                || specialization == null
                || specialization.trim().isEmpty()
                || phone == null || phone.trim().isEmpty()) {

            response.sendRedirect(
                request.getContextPath()
                + "/doctors?error=required"
            );
            return;
        }

        name = name.trim();
        specialization = specialization.trim();
        phone = phone.trim();

        if (name.length() > 100
                || specialization.length() > 100
                || !phone.matches("[0-9+() -]{7,15}")) {

            response.sendRedirect(
                request.getContextPath()
                + "/doctors?error=invalid"
            );
            return;
        }

        Doctor doctor = new Doctor(name, specialization, phone);

        boolean saved = doctorDAO.addDoctor(doctor);

        if (saved) {
            response.sendRedirect(
                request.getContextPath()
                + "/doctors?success=added"
            );
        } else {
            response.sendRedirect(
                request.getContextPath()
                + "/doctors?error=save"
            );
        }
    }
}
