
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.Hospital" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hospital Recommendations | Smart Hospital</title>

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
            max-width: 640px;
            margin: 14px 0 32px;
            color: var(--muted);
            line-height: 1.8;
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

        .description {
            margin: 0 0 24px;
            color: var(--muted);
            line-height: 1.8;
        }

        label {
            display: block;
            margin-bottom: 9px;
            color: #405d56;
            font-size: 12px;
            font-weight: 700;
        }

        select {
            width: 100%;
            max-width: 520px;
            min-height: 46px;
            padding: 12px;
            border: 1px solid #c8cec5;
            border-radius: 0;
            background: #fffefa;
            color: #183e38;
            font: inherit;
        }

        select:focus {
            outline: 2px solid #7b9b8c;
            outline-offset: 1px;
        }

        button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            min-height: 43px;
            margin-top: 20px;
            padding: 12px 18px;
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

        .notice {
            margin-top: 20px;
            padding: 14px 16px;
            border: 1px solid transparent;
            line-height: 1.6;
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

        .result-heading {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 14px;
        }

        .result-heading h2 {
            margin: 0;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 27px;
            font-weight: 400;
        }

        .specialty-label {
            display: inline-block;
            padding: 7px 10px;
            background: #e6e9df;
            color: var(--teal);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: .5px;
        }

        .table-wrap {
            width: 100%;
            overflow-x: auto;
            margin-top: 22px;
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
            padding: 15px 17px;
            color: #405d56;
            font-size: 10px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        td {
            padding: 17px;
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

        .hospital-name {
            color: var(--teal);
            font-weight: 700;
        }

        .available {
            color: var(--teal);
            font-weight: 700;
            font-variant-numeric: tabular-nums;
        }

        .empty {
            padding: 24px 0;
            color: var(--muted);
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
    <div class="topbar-note">Care Coordination / Recommendations</div>
</header>

<main>
    <div class="eyebrow">Operations / Care Coordination</div>
    <h1>Hospital Recommendations</h1>

    <p class="intro">
        Find hospitals matching the required medical specialty
        and compare their current bed availability.
    </p>

    <%
        String error = (String) request.getAttribute("error");
        String specialty = (String) request.getAttribute("specialty");
        boolean searched =
            Boolean.TRUE.equals(request.getAttribute("searched"));
    %>

    <section class="section">
        <div class="section-heading">
            <span class="section-number">01</span>
            <h2>Find a Suitable Hospital</h2>
        </div>

        <div class="section-body">
            <p class="description">
                Choose the required specialty. Results are based on
                matching hospital specialties and available beds.
            </p>

            <% if (error != null) { %>
                <div class="notice error" role="alert">
                    <%= error %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/hospital-recommendation"
                  method="post">

                <label for="specialty">Medical Specialty</label>

                <select id="specialty" name="specialty" required>
                    <option value="">-- Select Specialty --</option>

                    <option value="Cardiology"
                        <%= "Cardiology".equalsIgnoreCase(specialty)
                            ? "selected" : "" %>>
                        Cardiology
                    </option>

                    <option value="Neurology"
                        <%= "Neurology".equalsIgnoreCase(specialty)
                            ? "selected" : "" %>>
                        Neurology
                    </option>

                    <option value="Orthopedics"
                        <%= "Orthopedics".equalsIgnoreCase(specialty)
                            ? "selected" : "" %>>
                        Orthopedics
                    </option>

                    <option value="Pediatrics"
                        <%= "Pediatrics".equalsIgnoreCase(specialty)
                            ? "selected" : "" %>>
                        Pediatrics
                    </option>

                    <option value="General"
                        <%= "General".equalsIgnoreCase(specialty)
                            ? "selected" : "" %>>
                        General
                    </option>

                    <option value="Emergency"
                        <%= "Emergency".equalsIgnoreCase(specialty)
                            ? "selected" : "" %>>
                        Emergency
                    </option>
                </select>

                <br>

                <button type="submit">
                    Find Hospitals <span>→</span>
                </button>
            </form>
        </div>
    </section>

    <% if (searched) { %>
        <section class="section">
            <div class="section-heading">
                <span class="section-number">02</span>
                <h2>Recommendation Results</h2>
            </div>

            <div class="section-body">
                <div class="result-heading">
                    <h2>Matching Hospitals</h2>
                    <% if (specialty != null) { %>
                        <span class="specialty-label">
                            <%= specialty %>
                        </span>
                    <% } %>
                </div>

                <%
                    List<Hospital> hospitals =
                        (List<Hospital>) request.getAttribute("hospitals");
                %>

                <% if (hospitals != null && !hospitals.isEmpty()) { %>

                    <div class="table-wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>Hospital ID</th>
                                    <th>Hospital Name</th>
                                    <th>Location</th>
                                    <th>Specialty</th>
                                    <th>Total Beds</th>
                                    <th>Available Beds</th>
                                </tr>
                            </thead>

                            <tbody>
                            <% for (Hospital hospital : hospitals) { %>
                                <tr>
                                    <td><%= hospital.getId() %></td>
                                    <td class="hospital-name">
                                        <%= hospital.getName() %>
                                    </td>
                                    <td><%= hospital.getLocation() %></td>
                                    <td><%= hospital.getSpecialty() %></td>
                                    <td><%= hospital.getTotalBeds() %></td>
                                    <td class="available">
                                        <%= hospital.getAvailableBeds() %>
                                    </td>
                                </tr>
                            <% } %>
                            </tbody>
                        </table>
                    </div>

                    <div class="notice success" role="status">
                        <strong><%= hospitals.size() %></strong>
                        matching hospital(s) found.
                    </div>

                <% } else { %>

                    <div class="notice error" role="status">
                        No matching hospital with available beds was found.
                        Try another specialty or check hospital bed availability.
                    </div>

                <% } %>
            </div>
        </section>
    <% } %>

    <nav class="navigation">
        <a href="<%= request.getContextPath() %>/">
            Home
        </a>
        <a href="<%= request.getContextPath() %>/hospital-management">
            Hospital Management
        </a>
        <a href="<%= request.getContextPath() %>/patient-list">
            Patient Registry
        </a>
        <a href="<%= request.getContextPath() %>/doctors">
            Doctor Directory
        </a>
    </nav>
</main>

<footer>
    <span>SMART HOSPITAL</span>
    <span>Care Coordination / Recommendations</span>
</footer>

</body>
</html>
