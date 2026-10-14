
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.hospital.model.Patient" %>
<%
    Patient patient = (Patient) request.getAttribute("patient");

    if (patient == null) {
        response.sendError(404, "Patient not found");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Patient</title>
</head>
<body>
    <h2>Edit Patient Details</h2>

    <form action="update-patient" method="post">
        <input type="hidden" name="id"
               value="<%= patient.getId() %>">

        <label>Name:</label>
        <input type="text" name="name"
               value="<%= patient.getName() %>" required>
        <br><br>

        <label>Age:</label>
        <input type="number" name="age"
               min="0" value="<%= patient.getAge() %>" required>
        <br><br>

        <label>Medical Condition:</label>
        <input type="text" name="condition"
               value="<%= patient.getCondition() %>" required>
        <br><br>

        <button type="submit">Update Patient</button>
    </form>
</body>
</html>
