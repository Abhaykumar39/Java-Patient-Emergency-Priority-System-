
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Patient" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Records | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --paper: #faf8f2;
            --muted: #697773;
            --line: #d9d9cf;
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

        .topbar {
            min-height: 76px;
            padding: 0 6%;
            display: flex;
            align-items: center;
            justify-content: space-between;
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

        main {
            width: min(1150px, 90%);
            margin: 48px auto 60px;
        }

        .eyebrow {
            margin-bottom: 14px;
            color: var(--muted);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        h1 {
            margin: 0;
            font-family: Georgia, "Times New Roman", serif;
            font-size: clamp(36px, 5vw, 50px);
            font-weight: 400;
            letter-spacing: -1px;
        }

        .intro {
            margin: 14px 0 30px;
            color: var(--muted);
            line-height: 1.7;
        }

        .notice {
            margin: 20px 0;
            padding: 14px 16px;
            background: #e2eee5;
            border: 1px solid #c6d9c9;
            color: var(--teal);
            line-height: 1.5;
        }

        .panel {
            border: 1px solid var(--line);
            background: var(--paper);
        }

        .panel-header {
            padding: 22px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            border-bottom: 1px solid var(--line);
        }

        .panel-header h2 {
            margin: 0;
            font-size: 16px;
        }

        .record-label {
            color: var(--muted);
            font-size: 11px;
            letter-spacing: 1px;
            text-transform: uppercase;
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
            padding: 15px 18px;
            color: #405d56;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        td {
            padding: 17px 18px;
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

        .patient-id {
            font-weight: 700;
            font-variant-numeric: tabular-nums;
        }

        .patient-name {
            color: var(--teal);
            font-weight: 700;
        }

        .condition {
            white-space: normal;
            min-width: 150px;
            max-width: 280px;
        }

        .actions {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .action-link,
        .action-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-height: 34px;
            padding: 8px 12px;
            border: 1px solid var(--teal);
            background: transparent;
            color: var(--teal);
            text-decoration: none;
            font: inherit;
            font-size: 11px;
            font-weight: 700;
            cursor: pointer;
            transition: background .18s, color .18s;
        }

        .action-link:hover {
            background: var(--teal);
            color: var(--ivory);
        }

        .delete-button {
            border-color: #d7aaa3;
            color: var(--red);
        }

        .delete-button:hover {
            background: var(--red);
            border-color: var(--red);
            color: white;
        }

        .delete-form {
            margin: 0;
        }

        .empty {
            padding: 42px 20px;
            text-align: center;
            white-space: normal;
            color: var(--muted);
            line-height: 1.8;
        }

        .page-actions {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 24px;
        }

        .primary-link,
        .secondary-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 16px;
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
            transition: background .18s;
        }

        .primary-link {
            background: var(--teal);
            color: var(--ivory);
            border: 1px solid var(--teal);
        }

        .primary-link:hover {
            background: #075d56;
        }

        .secondary-link {
            border: 1px solid #bdc9c0;
            color: var(--teal);
        }

        .secondary-link:hover {
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

            main {
                width: 92%;
                margin-top: 32px;
            }

            .panel-header {
                padding: 18px;
                align-items: flex-start;
                flex-direction: column;
            }

            th, td {
                padding: 13px;
            }

            .actions {
                align-items: stretch;
                flex-direction: column;
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
    <div class="topbar-note">Patient Records / Registry</div>
</header>

<main>
    <div class="eyebrow">Records / 02</div>
    <h1>Patient Registry</h1>

    <p class="intro">
        View registered patients, review medical conditions,
        and maintain patient records.
    </p>

    <%
        if ("true".equals(request.getParameter("deleted"))) {
    %>
        <div class="notice" role="status">
            Patient deleted successfully.
        </div>
    <%
        }
    %>

    <section class="panel">
        <div class="panel-header">
            <h2>Registered Patients</h2>
            <span class="record-label">Patient Directory</span>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Patient ID</th>
                        <th>Patient Name</th>
                        <th>Age</th>
                        <th>Medical Condition</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    List<Patient> patients =
                        (List<Patient>) request.getAttribute("patients");

                    if (patients != null && !patients.isEmpty()) {
                        for (Patient p : patients) {
                %>
                    <tr>
                        <td class="patient-id"><%= p.getId() %></td>
                        <td class="patient-name"><%= p.getName() %></td>
                        <td><%= p.getAge() %></td>
                        <td class="condition"><%= p.getCondition() %></td>

                        <td>
                            <div class="actions">
                                <a class="action-link"
                                   href="<%= request.getContextPath() %>/edit-patient?id=<%= p.getId() %>">
                                    Edit
                                </a>

                                <form class="delete-form"
                                      action="<%= request.getContextPath() %>/delete-patient"
                                      method="post"
                                      onsubmit="return confirm('Are you sure you want to delete this patient?');">

                                    <input type="hidden" name="id"
                                           value="<%= p.getId() %>">

                                    <button class="action-button delete-button"
                                            type="submit">
                                        Delete
                                    </button>
                                </form>
                            </div>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="5" class="empty">
                            <strong>No patients registered yet.</strong><br>
                            Register a patient to see their details here.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <nav class="page-actions">
        <a class="primary-link"
           href="<%= request.getContextPath() %>/patients.jsp">
            + Register Patient
        </a>

        <a class="secondary-link"
           href="<%= request.getContextPath() %>/hospital-management">
            Hospital Management
        </a>

        <a class="secondary-link"
           href="<%= request.getContextPath() %>/emergency-queue">
            Emergency Queue
        </a>

        <a class="secondary-link"
           href="<%= request.getContextPath() %>/">
            Home
        </a>
    </nav>
</main>

<footer>
    <span>SMART HOSPITAL</span>
    <span>Patient Records / Registry</span>
</footer>

</body>
</html>
