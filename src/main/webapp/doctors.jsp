
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Doctor" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Directory | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --paper: #faf8f2;
            --muted: #697773;
            --line: #d9d9cf;
            --success-bg: #e2eee5;
            --error-bg: #f6e5e0;
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

        main {
            width: min(1100px, 90%);
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
            max-width: 600px;
            margin: 14px 0 32px;
            color: var(--muted);
            line-height: 1.8;
        }

        .notice {
            margin: 18px 0;
            padding: 14px 16px;
            border: 1px solid transparent;
            line-height: 1.5;
        }

        .success {
            background: var(--success-bg);
            border-color: #c6d9c9;
            color: var(--teal);
        }

        .error {
            background: var(--error-bg);
            border-color: #e8c7c0;
            color: var(--red);
        }

        .section {
            margin-top: 24px;
            border: 1px solid var(--line);
            background: var(--paper);
        }

        .section-heading {
            padding: 22px 25px;
            display: flex;
            align-items: center;
            gap: 15px;
            border-bottom: 1px solid var(--line);
        }

        .section-number {
            color: #71827a;
            font-size: 11px;
            letter-spacing: 1px;
        }

        .section-heading h2 {
            margin: 0;
            font-size: 16px;
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

        input {
            width: 100%;
            min-height: 44px;
            padding: 11px 12px;
            border: 1px solid #c8cec5;
            border-radius: 0;
            background: #fffefa;
            color: #183e38;
            font: inherit;
        }

        input:focus {
            outline: 2px solid #7b9b8c;
            outline-offset: 1px;
        }

        button {
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
            cursor: pointer;
            transition: background .18s;
        }

        button:hover {
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

        .doctor-id {
            font-variant-numeric: tabular-nums;
            font-weight: 700;
        }

        .doctor-name {
            color: var(--teal);
            font-weight: 700;
        }

        .specialization {
            white-space: normal;
            min-width: 160px;
        }

        .phone {
            font-variant-numeric: tabular-nums;
        }

        .empty {
            padding: 38px 20px;
            color: var(--muted);
            text-align: center;
            white-space: normal;
            line-height: 1.8;
        }

        .navigation {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 26px;
        }

        .navigation a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 15px;
            border: 1px solid #bdc9c0;
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

            main {
                width: 92%;
                margin-top: 32px;
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

            th, td {
                padding: 13px;
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
    <div class="topbar-note">Medical Staff / Directory</div>
</header>

<main>
    <div class="eyebrow">Operations / Medical Staff</div>
    <h1>Doctor Directory</h1>

    <p class="intro">
        Maintain the hospital's medical staff records and keep
        doctor contact information and specializations organized.
    </p>

    <%
        String error = request.getParameter("error");
        String success = request.getParameter("success");

        if ("added".equals(success)) {
    %>
        <div class="notice success" role="status">
            Doctor registered successfully.
        </div>
    <%
        } else if ("required".equals(error)) {
    %>
        <div class="notice error">
            Please fill in all required fields.
        </div>
    <%
        } else if ("invalid".equals(error)) {
    %>
        <div class="notice error">
            Please enter valid details and a valid phone number.
        </div>
    <%
        } else if ("save".equals(error)) {
    %>
        <div class="notice error">
            Doctor could not be saved. Check the server logs.
        </div>
    <%
        }
    %>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">01</span>
            <h2>Register New Doctor</h2>
        </div>

        <div class="section-body">
            <form action="<%= request.getContextPath() %>/doctors"
                  method="post">

                <div class="form-grid">
                    <div class="field">
                        <label for="name">Doctor Name</label>
                        <input type="text"
                               id="name"
                               name="name"
                               maxlength="100"
                               required>
                    </div>

                    <div class="field">
                        <label for="specialization">Specialization</label>
                        <input type="text"
                               id="specialization"
                               name="specialization"
                               maxlength="100"
                               required>
                    </div>

                    <div class="field full">
                        <label for="phone">Phone Number</label>
                        <input type="tel"
                               id="phone"
                               name="phone"
                               maxlength="15"
                               pattern="[0-9+() -]{7,15}"
                               required>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit">
                        Add Doctor <span>→</span>
                    </button>
                </div>
            </form>
        </div>
    </section>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">02</span>
            <h2>Registered Doctors</h2>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Doctor ID</th>
                        <th>Doctor Name</th>
                        <th>Specialization</th>
                        <th>Phone Number</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    List<Doctor> doctors =
                        (List<Doctor>) request.getAttribute("doctors");

                    if (doctors != null && !doctors.isEmpty()) {
                        for (Doctor doctor : doctors) {
                %>
                    <tr>
                        <td class="doctor-id"><%= doctor.getId() %></td>
                        <td class="doctor-name"><%= doctor.getName() %></td>
                        <td class="specialization">
                            <%= doctor.getSpecialization() %>
                        </td>
                        <td class="phone"><%= doctor.getPhone() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="4" class="empty">
                            <strong>No doctors registered yet.</strong><br>
                            Add a doctor using the registration form above.
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
        <a href="<%= request.getContextPath() %>/">
            Home
        </a>
        <a href="<%= request.getContextPath() %>/admin-dashboard">
            Admin Dashboard
        </a>
        <a href="<%= request.getContextPath() %>/hospital-management">
            Hospital Management
        </a>
        <a href="<%= request.getContextPath() %>/patient-list">
            Patient Registry
        </a>
    </nav>
</main>

<footer>
    <span>SMART HOSPITAL</span>
    <span>Medical Staff / Directory</span>
</footer>

</body>
</html>
