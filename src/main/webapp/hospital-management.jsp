
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Hospital" %>
<%@ page import="com.hospital.model.Patient" %>
<%@ page import="com.hospital.model.Admission" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Operations | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --paper: #faf8f2;
            --muted: #697773;
            --line: #d9d9cf;
            --green-bg: #e2eee5;
            --red-bg: #f6e5e0;
            --red: #a33b30;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--ivory);
            color: var(--teal);
            font-family: Arial, Helvetica, sans-serif;
            font-size: 14px;
        }

        a {
            color: inherit;
        }

        .topbar {
            min-height: 76px;
            padding: 0 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 20px;
            border-bottom: 1px solid var(--line);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-weight: 700;
            letter-spacing: .5px;
        }

        .brand-mark {
            width: 35px;
            height: 35px;
            display: grid;
            place-items: center;
            background: var(--teal);
            color: var(--ivory);
            font-size: 24px;
            font-weight: 400;
        }

        .topbar-note {
            color: var(--muted);
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
        }

        .container {
            width: min(1200px, 90%);
            margin: 42px auto 60px;
        }

        .eyebrow {
            margin-bottom: 14px;
            color: var(--muted);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        h1, h2, h3, p {
            margin-top: 0;
        }

        h1 {
            margin-bottom: 12px;
            font-family: Georgia, "Times New Roman", serif;
            font-size: clamp(34px, 4vw, 48px);
            font-weight: 400;
            letter-spacing: -1px;
        }

        .page-intro {
            margin-bottom: 32px;
            color: var(--muted);
            line-height: 1.7;
        }

        .notice {
            margin: 18px 0;
            padding: 14px 16px;
            border: 1px solid transparent;
            line-height: 1.5;
        }

        .notice.success {
            background: var(--green-bg);
            color: var(--teal);
            border-color: #c6d9c9;
        }

        .notice.error {
            background: var(--red-bg);
            color: var(--red);
            border-color: #e8c7c0;
        }

        .section {
            margin-top: 24px;
            border: 1px solid var(--line);
            background: var(--paper);
        }

        .section-heading {
            padding: 22px 25px;
            border-bottom: 1px solid var(--line);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .section-number {
            color: #71827a;
            font-size: 11px;
            letter-spacing: 1px;
        }

        .section-heading h2 {
            margin: 0;
            font-size: 17px;
            font-weight: 700;
        }

        .section-body {
            padding: 25px;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 22px;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 9px;
        }

        .field.full {
            grid-column: 1 / -1;
        }

        label {
            color: #405d56;
            font-size: 12px;
            font-weight: 700;
        }

        input, select {
            width: 100%;
            min-height: 44px;
            padding: 11px 12px;
            border: 1px solid #c8cec5;
            border-radius: 0;
            background: #fffefa;
            color: #183e38;
            font: inherit;
        }

        input:focus, select:focus {
            outline: 2px solid #7b9b8c;
            outline-offset: 1px;
        }

        button, .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 42px;
            padding: 11px 17px;
            border: 1px solid var(--teal);
            background: var(--teal);
            color: var(--ivory);
            font: inherit;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: background .18s, color .18s;
        }

        button:hover, .button:hover {
            background: #075d56;
        }

        .form-actions {
            margin-top: 24px;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            white-space: nowrap;
        }

        thead {
            background: #e9e8de;
        }

        th {
            padding: 14px 16px;
            color: #405d56;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        td {
            padding: 15px 16px;
            border-bottom: 1px solid #e4e3d9;
            color: #314d46;
            font-size: 13px;
        }

        tbody tr:last-child td {
            border-bottom: 0;
        }

        tbody tr:hover {
            background: #f1f0e7;
        }

        .number {
            font-variant-numeric: tabular-nums;
        }

        .bed-count {
            font-weight: 700;
            color: var(--teal);
        }

        .status {
            display: inline-block;
            padding: 6px 9px;
            background: #e2eee5;
            color: var(--teal);
            font-size: 10px;
            font-weight: 700;
            letter-spacing: .5px;
        }

        .status.completed {
            background: #e9e8de;
            color: #68736c;
        }

        .empty {
            padding: 28px 16px;
            text-align: center;
            color: var(--muted);
            white-space: normal;
        }

        .small-button {
            min-height: 34px;
            padding: 8px 12px;
            font-size: 11px;
        }

        .discharge-button {
            border-color: #a33b30;
            background: transparent;
            color: #a33b30;
        }

        .discharge-button:hover {
            background: #a33b30;
            color: white;
        }

        .table-form {
            margin: 0;
        }

        .navigation {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 28px;
        }

        .navigation a {
            padding: 11px 14px;
            border: 1px solid #c8cec5;
            color: var(--teal);
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            transition: background .18s;
        }

        .navigation a:hover {
            background: #e1e4d9;
        }

        footer {
            padding: 22px 5%;
            border-top: 1px solid var(--line);
            color: var(--muted);
            font-size: 11px;
            letter-spacing: .5px;
            display: flex;
            justify-content: space-between;
            gap: 15px;
        }

        @media (max-width: 650px) {
            .topbar {
                padding: 16px 5%;
            }

            .topbar-note {
                display: none;
            }

            .container {
                width: 92%;
                margin-top: 30px;
            }

            .section-heading,
            .section-body {
                padding: 18px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 18px;
            }

            .field.full {
                grid-column: auto;
            }

            footer {
                flex-direction: column;
            }
        }
    </style>
</head>

<body>

<header class="topbar">
    <div class="brand">
        <div class="brand-mark">+</div>
        <span>SMART HOSPITAL</span>
    </div>
    <div class="topbar-note">Hospital Operations / Bed Management</div>
</header>

<main class="container">

    <div class="eyebrow">Operations / 01</div>
    <h1>Hospital &amp; Bed Management</h1>
    <p class="page-intro">
        Manage hospital capacity, coordinate patient admissions,
        and track bed availability from one workspace.
    </p>

    <%
        String result = request.getParameter("result");

        if ("hospital-added".equals(result)) {
    %>
        <div class="notice success">Hospital added successfully.</div>
    <%
        } else if ("SUCCESS".equals(result)) {
    %>
        <div class="notice success">Patient admitted successfully.</div>
    <%
        } else if ("ALREADY_ADMITTED".equals(result)) {
    %>
        <div class="notice error">
            This patient already has an active admission.
        </div>
    <%
        } else if ("NO_BED".equals(result)) {
    %>
        <div class="notice error">
            Hospital not found or no beds available.
        </div>
    <%
        } else if ("PATIENT_NOT_FOUND".equals(result)) {
    %>
        <div class="notice error">Patient not found.</div>
    <%
        } else if ("discharged".equals(result)) {
    %>
        <div class="notice success">
            Patient discharged. Bed released successfully.
        </div>
    <%
        } else if ("discharge-error".equals(result)
                || "error".equals(result)) {
    %>
        <div class="notice error">
            Operation failed. Check server logs.
        </div>
    <%
        }
    %>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">01</span>
            <h2>Add Hospital</h2>
        </div>

        <div class="section-body">
            <form action="<%= request.getContextPath() %>/add-hospital"
                  method="post">

                <div class="form-grid">
                    <div class="field">
                        <label for="name">Hospital Name</label>
                        <input type="text" id="name" name="name"
                               maxlength="150" required>
                    </div>

                    <div class="field">
                        <label for="location">Location</label>
                        <input type="text" id="location" name="location"
                               maxlength="255" required>
                    </div>

                    <div class="field">
                        <label for="specialty">Medical Specialty</label>
                        <select id="specialty" name="specialty" required>
                            <option value="General">General</option>
                            <option value="Emergency">Emergency</option>
                            <option value="Cardiology">Cardiology</option>
                            <option value="Orthopedics">Orthopedics</option>
                            <option value="Neurology">Neurology</option>
                            <option value="Pediatrics">Pediatrics</option>
                            <option value="Trauma">Trauma</option>
                        </select>
                    </div>

                    <div class="field">
                        <label for="totalBeds">Total Bed Capacity</label>
                        <input type="number" id="totalBeds"
                               name="totalBeds" min="1"
                               max="100000" required>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit">Add Hospital <span>→</span></button>
                </div>
            </form>
        </div>
    </section>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">02</span>
            <h2>Hospital Bed Availability</h2>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hospital</th>
                        <th>Location</th>
                        <th>Specialty</th>
                        <th>Total Beds</th>
                        <th>Occupied</th>
                        <th>Available</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Hospital> hospitals =
                        (List<Hospital>) request.getAttribute("hospitals");

                    if (hospitals != null && !hospitals.isEmpty()) {
                        for (Hospital h : hospitals) {
                %>
                    <tr>
                        <td class="number"><%= h.getId() %></td>
                        <td><strong><%= h.getName() %></strong></td>
                        <td><%= h.getLocation() %></td>
                        <td><%= h.getSpecialty() %></td>
                        <td class="number"><%= h.getTotalBeds() %></td>
                        <td class="number"><%= h.getOccupiedBeds() %></td>
                        <td class="number bed-count">
                            <%= h.getAvailableBeds() %>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="empty">
                            No hospitals added yet. Add a hospital above to
                            start managing bed capacity.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">03</span>
            <h2>Admit Patient</h2>
        </div>

        <div class="section-body">
            <form action="<%= request.getContextPath() %>/admit-patient"
                  method="post">

                <div class="form-grid">
                    <div class="field">
                        <label for="patientId">Select Patient</label>
                        <select id="patientId" name="patientId" required>
                            <option value="">-- Select Patient --</option>

                            <%
                                List<Patient> patients =
                                    (List<Patient>) request.getAttribute("patients");

                                if (patients != null) {
                                    for (Patient p : patients) {
                            %>
                                <option value="<%= p.getId() %>">
                                    ID <%= p.getId() %> — <%= p.getName() %>
                                    — <%= p.getCondition() %>
                                </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="field">
                        <label for="hospitalId">Select Hospital</label>
                        <select id="hospitalId" name="hospitalId" required>
                            <option value="">-- Select Hospital --</option>

                            <%
                                if (hospitals != null) {
                                    for (Hospital h : hospitals) {
                                        if (h.getAvailableBeds() > 0) {
                            %>
                                <option value="<%= h.getId() %>">
                                    <%= h.getName() %> — <%= h.getSpecialty() %>
                                    — Available: <%= h.getAvailableBeds() %>
                                </option>
                            <%
                                        }
                                    }
                                }
                            %>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit">Admit Patient <span>→</span></button>
                </div>
            </form>
        </div>
    </section>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">04</span>
            <h2>Admission Records</h2>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Admission ID</th>
                        <th>Patient ID</th>
                        <th>Patient Name</th>
                        <th>Hospital</th>
                        <th>Admitted At</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    List<Admission> admissions =
                        (List<Admission>) request.getAttribute("admissions");

                    if (admissions != null && !admissions.isEmpty()) {
                        for (Admission a : admissions) {
                %>
                    <tr>
                        <td class="number"><%= a.getId() %></td>
                        <td class="number"><%= a.getPatientId() %></td>
                        <td><strong><%= a.getPatientName() %></strong></td>
                        <td><%= a.getHospitalName() %></td>
                        <td><%= a.getAdmittedAt() %></td>
                        <td>
                            <% if ("ADMITTED".equals(a.getStatus())) { %>
                                <span class="status">ADMITTED</span>
                            <% } else { %>
                                <span class="status completed">
                                    <%= a.getStatus() %>
                                </span>
                            <% } %>
                        </td>
                        <td>
                            <% if ("ADMITTED".equals(a.getStatus())) { %>
                                <form class="table-form"
                                      action="<%= request.getContextPath() %>/discharge-patient"
                                      method="post"
                                      onsubmit="return confirm('Discharge this patient and release the bed?');">

                                    <input type="hidden" name="admissionId"
                                           value="<%= a.getId() %>">

                                    <button class="small-button discharge-button"
                                            type="submit">
                                        Discharge
                                    </button>
                                </form>
                            <% } else { %>
                                <span class="section-number">Completed</span>
                            <% } %>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="7" class="empty">
                            No admission records yet.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <nav class="navigation">
        <a href="<%= request.getContextPath() %>/admin-dashboard">
            Admin Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/emergency-queue">
            Emergency Priority Queue
        </a>
        <a href="<%= request.getContextPath() %>/patient-list">
            Patient List
        </a>
        <a href="<%= request.getContextPath() %>/patients.jsp">
            Register Patient
        </a>
        <a href="<%= request.getContextPath() %>/">
            Home
        </a>
    </nav>

</main>

<footer>
    <span>SMART HOSPITAL</span>
    <span>Hospital Operations / Bed Management</span>
</footer>

</body>
</html>
