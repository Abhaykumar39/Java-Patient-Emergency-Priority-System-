
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.EmergencyCase" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Emergency Priority Queue</title>
</head>
<body>

<h2>Smart Hospital — Emergency Priority Queue</h2>

<%
    String registered = request.getParameter("registered");
    String result = request.getParameter("result");

    if ("true".equals(registered)) {
%>
    <p style="color:green;">Emergency patient registered successfully!</p>
<%
    }

    if ("treated".equals(result)) {
%>
    <p style="color:green;">Highest-priority patient marked as treated.</p>
<%
    } else if ("empty".equals(result)) {
%>
    <p style="color:red;">No waiting emergency patients in the queue.</p>
<%
    }
%>

<p>
    <a href="emergency-register">Register Emergency Patient</a>
</p>

<form action="treat-next" method="post"
      onsubmit="return confirm('Mark the highest-priority patient as treated?');">
    <button type="submit">Treat Next Patient</button>
</form>

<br>

<table border="1" cellpadding="10">
    <tr>
        <th>Queue Position</th>
        <th>Patient ID</th>
        <th>Name</th>
        <th>Age</th>
        <th>Medical Condition</th>
        <th>Emergency Level</th>
        <th>Status</th>
    </tr>

    <%
        List<EmergencyCase> patients =
            (List<EmergencyCase>) request.getAttribute("patients");

        if (patients != null && !patients.isEmpty()) {
            int position = 1;

            for (EmergencyCase p : patients) {
    %>
    <tr>
        <td><%= position++ %></td>
        <td><%= p.getId() %></td>
        <td><%= p.getName() %></td>
        <td><%= p.getAge() %></td>
        <td><%= p.getCondition() %></td>
        <td><%= p.getEmergencyLevel() %></td>
        <td><%= p.getStatus() %></td>
    </tr>
    <%
            }
        } else {
    %>
    <tr>
        <td colspan="7">No waiting emergency patients.</td>
    </tr>
    <%
        }
    %>

</table>

<p>
    <a href="patient-list">View All Registered Patients</a>
    |
    <a href="patients.jsp">Normal Patient Registration</a>
</p>

</body>
</html>
