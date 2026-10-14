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

    <title>Emergency Patient Search | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --surface: #faf9f6;
            --text: #24312f;
            --muted: #697572;
            --border: #d8d9d0;
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
            width: min(1080px, 88%);
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
            max-width: 650px;
            font-size: 14px;
        }

        .search-panel {
            background: var(--surface);
            border: 1px solid var(--border);
            padding: 26px;
            margin-top: 30px;
        }

        .search-panel label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .search-row {
            display: flex;
            gap: 12px;
        }

        input[type="text"] {
            flex: 1;
            min-width: 0;
            padding: 13px 14px;
            background: #fff;
            border: 1px solid var(--border);
            color: var(--text);
            font-size: 14px;
            outline-color: var(--teal);
        }

        button {
            padding: 13px 23px;
            background: var(--teal);
            border: 1px solid var(--teal);
            color: white;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
        }

        button:hover {
            background: #063936;
        }

        .quick-links {
            display: flex;
            gap: 22px;
            flex-wrap: wrap;
            margin-top: 20px;
        }

        .quick-links a {
            color: var(--teal);
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
        }

        .quick-links a:hover {
            text-decoration: underline;
        }

        .results-section {
            margin-top: 42px;
        }

        .results-heading {
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
            font-weight: 400;
            font-size: 27px;
            margin: 0;
        }

        .results-label {
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

        .empty {
            padding: 28px;
            color: var(--muted);
            text-align: center;
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

            .search-panel {
                padding: 18px;
            }

            .search-row {
                flex-direction: column;
            }

            button {
                width: 100%;
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
    <div class="eyebrow">Patient Records / Emergency Unit</div>

    <h1>Emergency Patient Search</h1>

    <p class="intro">
        Search emergency patient records by patient ID or name.
        Review the patient's medical condition, emergency level and current status.
    </p>

    <section class="search-panel">
        <form action="emergency-search" method="get">
            <label for="q">Patient ID or full name</label>

            <div class="search-row">
                <input
                    type="text"
                    id="q"
                    name="q"
                    value="<%= escapeHtml(
                        request.getAttribute("query") == null
                            ? ""
                            : String.valueOf(request.getAttribute("query"))
                    ) %>"
                    placeholder="Enter patient ID or name..."
                    maxlength="100"
                    required>

                <button type="submit">Search Records</button>
            </div>
        </form>

        <nav class="quick-links">
            <a href="emergency-queue">View Priority Queue →</a>
            <a href="emergency-register">+ Register Emergency Patient</a>
        </nav>
    </section>

    <%
        String query = (String) request.getAttribute("query");

        List<EmergencyCase> results =
            (List<EmergencyCase>) request.getAttribute("results");

        if (query != null && !query.trim().isEmpty()) {
    %>

    <section class="results-section">
        <div class="results-heading">
            <h2>Search Results</h2>

            <span class="results-label">
                Search: <%= escapeHtml(query) %>
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
                    if (results != null && !results.isEmpty()) {
                        for (EmergencyCase p : results) {
                %>
                    <tr>
                        <td><%= p.getId() %></td>

                        <td><%= escapeHtml(
                            String.valueOf(p.getName())) %></td>

                        <td><%= p.getAge() %></td>

                        <td><%= escapeHtml(
                            String.valueOf(p.getCondition())) %></td>

                        <td><%= escapeHtml(
                            String.valueOf(p.getEmergencyLevel())) %></td>

                        <td><%= escapeHtml(
                            String.valueOf(p.getStatus())) %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="6" class="empty">
                            No emergency patient found for this search.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>
    </section>

    <%
        }
    %>
</main>

<footer>
    Smart Hospital Emergency Management System
</footer>

</body>
</html>
