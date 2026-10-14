<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hospital.model.EmergencyCase" %>

<%!
    public String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#x27;");
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Emergency History | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --surface: #faf9f6;
            --text: #24312f;
            --muted: #697572;
            --border: #d8d9d0;
            --success: #246747;
            --success-bg: #e6efe7;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--ivory);
            color: var(--text);
            font-family: Arial, Helvetica, sans-serif;
        }

        header {
            background: var(--teal);
            color: var(--ivory);
            padding: 20px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
        }

        .brand {
            font-size: 17px;
            font-weight: 700;
            letter-spacing: 0.4px;
        }

        .brand span {
            display: block;
            margin-top: 5px;
            font-size: 11px;
            font-weight: 400;
            letter-spacing: 1.5px;
            opacity: 0.8;
            text-transform: uppercase;
        }

        .header-link {
            color: var(--ivory);
            text-decoration: none;
            font-size: 13px;
            border: 1px solid rgba(240, 237, 229, 0.45);
            padding: 10px 14px;
        }

        .header-link:hover {
            background: rgba(240, 237, 229, 0.1);
        }

        main {
            width: min(1100px, 88%);
            margin: 46px auto;
            min-height: 55vh;
        }

        .eyebrow {
            color: var(--teal);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        h1 {
            color: var(--teal);
            font-family: Georgia, "Times New Roman", serif;
            font-size: clamp(32px, 5vw, 46px);
            font-weight: 400;
            margin: 12px 0;
        }

        .intro {
            color: var(--muted);
            line-height: 1.7;
            max-width: 680px;
            font-size: 14px;
            margin-bottom: 30px;
        }

        .summary {
            display: flex;
            align-items: center;
            gap: 22px;
            flex-wrap: wrap;
            background: var(--teal);
            color: var(--ivory);
            padding: 23px 26px;
            margin-bottom: 32px;
        }

        .summary-number {
            font-family: Georgia, "Times New Roman", serif;
            font-size: 38px;
            line-height: 1.1;
        }

        .summary-label {
            font-size: 12px;
            letter-spacing: 1px;
            text-transform: uppercase;
            opacity: 0.85;
            margin-top: 6px;
        }

        .section-heading {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 17px;
        }

        h2 {
            color: var(--teal);
            font-family: Georgia, "Times New Roman", serif;
            font-size: 27px;
            font-weight: 400;
            margin: 0;
        }

        .record-count {
            color: var(--muted);
            font-size: 12px;
        }

        .table-wrap {
            overflow-x: auto;
            background: var(--surface);
            border: 1px solid var(--border);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            text-align: left;
            font-size: 13px;
        }

        th {
            background: #e5e5db;
            color: var(--teal);
            padding: 15px 14px;
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            white-space: nowrap;
        }

        td {
            padding: 15px 14px;
            border-top: 1px solid #e4e3dc;
            vertical-align: top;
        }

        tbody tr:hover {
            background: #f2f1e9;
        }

        .status {
            display: inline-block;
            padding: 6px 10px;
            background: var(--success-bg);
            color: var(--success);
            font-size: 11px;
            font-weight: 700;
            white-space: nowrap;
        }

        .empty {
            padding: 32px 20px;
            text-align: center;
            color: var(--muted);
            line-height: 1.7;
        }

        .links {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 28px;
        }

        .links a {
            display: inline-block;
            padding: 12px 16px;
            background: var(--teal);
            color: white;
            border: 1px solid var(--teal);
            text-decoration: none;
            font-size: 12px;
            font-weight: 700;
        }

        .links a.secondary {
            background: transparent;
            color: var(--teal);
        }

        .links a:hover {
            opacity: 0.85;
        }

        footer {
            border-top: 1px solid var(--border);
            padding: 20px 7%;
            color: var(--muted);
            font-size: 12px;
            margin-top: 70px;
        }

        @media (max-width: 600px) {
            main {
                margin: 30px auto;
            }

            .summary {
                padding: 20px;
            }

            .links {
                flex-direction: column;
            }

            .links a {
                text-align: center;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="brand">
        SMART HOSPITAL
        <span>Emergency Management System</span>
    </div>

    <a class="header-link" href="index.jsp">Dashboard</a>
</header>

<main>
    <div class="eyebrow">Emergency Unit / Records Archive</div>

    <h1>Emergency Patient History</h1>

    <p class="intro">
        Review previously treated emergency patients and their recorded
        medical conditions, emergency levels and treatment statuses.
    </p>

    <%
        List<EmergencyCase> history =
            (List<EmergencyCase>) request.getAttribute("history");

        int totalTreated = history == null ? 0 : history.size();
    %>

    <section class="summary">
        <div class="summary-number"><%= totalTreated %></div>

        <div>
            <div class="summary-label">Total Treated Patients</div>
            <div style="font-size:13px; margin-top:7px;">
                Recorded emergency cases
            </div>
        </div>
    </section>

    <section>
        <div class="section-heading">
            <h2>Treatment Records</h2>
            <span class="record-count">
                <%= totalTreated %> record(s)
            </span>
        </div>

        <div class="table-wrap">
            <table>
                <thead>
                    <tr>
                        <th>Patient ID</th>
                        <th>Name</th>
                        <th>Age</th>
                        <th>Medical Condition</th>
                        <th>Emergency Level</th>
                        <th>Status</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (history != null && !history.isEmpty()) {
                        for (EmergencyCase patient : history) {
                %>
                    <tr>
                        <td><%= patient.getId() %></td>

                        <td><%= escapeHtml(
                            String.valueOf(patient.getName())) %></td>

                        <td><%= patient.getAge() %></td>

                        <td><%= escapeHtml(
                            String.valueOf(patient.getCondition())) %></td>

                        <td><%= escapeHtml(
                            String.valueOf(patient.getEmergencyLevel())) %></td>

                        <td>
                            <span class="status">
                                <%= escapeHtml(
                                    String.valueOf(patient.getStatus())) %>
                            </span>
                        </td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" class="empty">
                            <strong>No treated emergency patients found.</strong>
                            <br>
                            Treatment records will appear here when available.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <nav class="links">
        <a href="emergency-queue">Emergency Priority Queue →</a>
        <a href="emergency-search" class="secondary">Search Patients</a>
        <a href="index.jsp" class="secondary">Back to Dashboard</a>
    </nav>
</main>

<footer>
    Smart Hospital Emergency Management System
</footer>

</body>
</html>
```