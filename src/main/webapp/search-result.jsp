
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.hospital.model.Patient" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Patient Search Result</title>
</head>
<body>
    <h2>Patient Search Result</h2>

    <%
        Patient patient =
            (Patient) request.getAttribute("patient");

        if (patient != null) {
    %>

    <p><b>Patient ID:</b> <%= patient.getId() %></p>
    <p><b>Name:</b> <%= patient.getName() %></p>
    <p><b>Age:</b> <%= patient.getAge() %></p>
    <p><b>Medical Condition:</b>
        <%= patient.getCondition() %></p>

    <%
        } else {
    %>

    <p>No patient found with this ID.</p>

    <%
        }
    %>

    <p><a href="search-patient">Search Another Patient</a></p>
    <p><a href="patient-list">View All Patients</a></p>
</body>
</html>
