
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Search Patient</title>
</head>
<body>
    <h2>Search Patient by ID</h2>

    <form action="search-patient" method="post">
        <label>Enter Patient ID:</label>
        <input type="number" name="id" min="1" required>
        <button type="submit">Search Patient</button>
    </form>

    <p><a href="patient-list">View All Patients</a></p>
</body>
</html>
