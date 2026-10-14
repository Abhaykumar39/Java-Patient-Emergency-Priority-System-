
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Smart Hospital</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f1f5f9;
            color: #1e293b;
        }

        header {
            background: linear-gradient(135deg, #0f766e, #115e59);
            color: white;
            padding: 25px 35px;
        }

        header h1 {
            margin: 0 0 8px;
        }

        header p {
            margin: 0;
            color: #ccfbf1;
        }

        .container {
            max-width: 1200px;
            margin: 30px auto;
            padding: 0 20px;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(210px, 1fr));
            gap: 20px;
        }

        .card {
            background: white;
            padding: 24px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.07);
            border-left: 5px solid #0f766e;
        }

        .card h3 {
            margin: 0 0 15px;
            font-size: 15px;
            color: #64748b;
        }

        .number {
            font-size: 34px;
            font-weight: bold;
            color: #0f766e;
        }

        .section {
            background: white;
            padding: 25px;
            margin-top: 25px;
            border-radius: 12px;
            box-shadow: 0 3px 12px rgba(0, 0, 0, 0.07);
        }

        .links {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 12px;
            margin-top: 15px;
        }

        .links a {
            display: block;
            background: #f0fdfa;
            color: #115e59;
            text-decoration: none;
            padding: 14px;
            border: 1px solid #99f6e4;
            border-radius: 7px;
            text-align: center;
            font-weight: bold;
        }

        .links a:hover {
            background: #ccfbf1;
        }

        footer {
            text-align: center;
            padding: 25px;
            color: #64748b;
        }
    </style>
</head>

<body>

<header>
    <h1>Smart Hospital Admin Dashboard</h1>
    <p>Emergency Management System Overview</p>
</header>

<%
    Map<String, Integer> stats =
        (Map<String, Integer>) request.getAttribute("stats");

    int totalPatients = stats == null ? 0 :
        stats.getOrDefault("totalPatients", 0);

    int totalHospitals = stats == null ? 0 :
        stats.getOrDefault("totalHospitals", 0);

    int totalDoctors = stats == null ? 0 :
        stats.getOrDefault("totalDoctors", 0);

    int availableBeds = stats == null ? 0 :
        stats.getOrDefault("availableBeds", 0);

    int waitingEmergencies = stats == null ? 0 :
        stats.getOrDefault("waitingEmergencies", 0);
%>

<div class="container">

    <div class="stats">

        <div class="card">
            <h3>Total Patients</h3>
            <div class="number"><%= totalPatients %></div>
        </div>

        <div class="card">
            <h3>Total Hospitals</h3>
            <div class="number"><%= totalHospitals %></div>
        </div>

        <div class="card">
            <h3>Total Doctors</h3>
            <div class="number"><%= totalDoctors %></div>
        </div>

        <div class="card">
            <h3>Available Beds</h3>
            <div class="number"><%= availableBeds %></div>
        </div>

        <div class="card">
            <h3>Waiting Emergencies</h3>
            <div class="number"><%= waitingEmergencies %></div>
        </div>

    </div>

    <div class="section">
        <h2>System Management</h2>
        <p>Choose a section to manage hospital operations.</p>

        <div class="links">
            <a href="<%= request.getContextPath() %>/patients">
                Patient Management
            </a>

            <a href="<%= request.getContextPath() %>/emergency-queue">
                Emergency Priority Queue
            </a>

            <a href="<%= request.getContextPath() %>/emergency-search">
                Emergency Patient Search
            </a>

            <a href="<%= request.getContextPath() %>/emergency-history">
                Emergency History
            </a>

            <a href="<%= request.getContextPath() %>/hospital-management">
                Hospital & Bed Management
            </a>

            <a href="<%= request.getContextPath() %>/doctors">
                Doctor Management
            </a>

            <a href="<%= request.getContextPath() %>/hospital-recommendation">
                Hospital Recommendation
            </a>
        </div>
    </div>

</div>

<footer>
    Smart Hospital Emergency Management System
</footer>

</body>
</html>
