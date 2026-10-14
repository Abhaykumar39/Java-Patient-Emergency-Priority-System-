<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
    public String escapeHtml(String value) {
        if (value == null) return "";

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

    <title>Admin Dashboard | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --paper: #faf8f2;
            --muted: #687572;
            --line: #d8d8cc;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: var(--ivory);
            color: var(--teal);
            font-family: Arial, Helvetica, sans-serif;
            min-height: 100vh;
        }

        .topbar {
            min-height: 76px;
            padding: 15px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 18px;
            flex-wrap: wrap;
            border-bottom: 1px solid var(--line);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 17px;
            font-weight: 700;
            letter-spacing: -0.4px;
        }

        .brand-mark {
            width: 34px;
            height: 34px;
            display: grid;
            place-items: center;
            background: var(--teal);
            color: var(--ivory);
            font-size: 23px;
            font-weight: 400;
        }

        .topbar-label {
            font-size: 11px;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            color: var(--muted);
        }

        main {
            width: min(1080px, 86%);
            margin: 55px auto 65px;
        }

        .eyebrow {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            color: var(--muted);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .status-dot {
            width: 8px;
            height: 8px;
            background: var(--teal);
            border-radius: 50%;
        }

        h1 {
            max-width: 760px;
            margin: 0;
            font-family: Georgia, "Times New Roman", serif;
            font-size: clamp(40px, 6vw, 66px);
            font-weight: 400;
            line-height: 1.08;
            letter-spacing: -1.8px;
        }

        h1 span {
            color: #58716a;
        }

        .intro {
            max-width: 620px;
            margin: 20px 0 0;
            color: #586661;
            font-size: 15px;
            line-height: 1.8;
        }

        .section-title {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            gap: 12px;
            flex-wrap: wrap;
            margin: 48px 0 18px;
        }

        h2 {
            margin: 0;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 28px;
            font-weight: 400;
        }

        .section-note {
            color: var(--muted);
            font-size: 12px;
        }

        .workspace {
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            border-top: 1px solid #c9cec2;
            border-left: 1px solid #c9cec2;
        }

        .module {
            min-height: 205px;
            padding: 24px;
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            background: var(--paper);
            border-right: 1px solid #c9cec2;
            border-bottom: 1px solid #c9cec2;
            text-decoration: none;
            color: var(--teal);
            transition: background 0.18s;
        }

        .module:hover {
            background: #e6e7dc;
        }

        .module-number {
            color: var(--muted);
            font-size: 11px;
            letter-spacing: 1.5px;
        }

        .module h3 {
            margin: 27px 0 9px;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 22px;
            font-weight: 400;
        }

        .module p {
            margin: 0;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.7;
        }

        .module-arrow {
            margin-top: auto;
            padding-top: 20px;
            font-size: 18px;
        }

        .account-panel {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 22px;
            margin-top: 32px;
            padding: 25px 28px;
            border: 1px solid #c9cec2;
            background: var(--paper);
        }

        .section-label {
            color: var(--muted);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.6px;
            text-transform: uppercase;
        }

        .account-name {
            margin-top: 9px;
            overflow-wrap: anywhere;
            font-family: Georgia, "Times New Roman", serif;
            font-size: 24px;
        }

        .account-description {
            margin: 7px 0 0;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.6;
        }

        .logout-form {
            flex-shrink: 0;
        }

        .logout-button {
            padding: 13px 18px;
            border: 1px solid #b9c5bd;
            background: transparent;
            color: var(--teal);
            font: inherit;
            font-size: 12px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.18s, color 0.18s;
        }

        .logout-button:hover {
            background: var(--teal);
            color: var(--ivory);
        }

        footer {
            width: min(1080px, 86%);
            margin: 0 auto;
            padding: 22px 0 28px;
            display: flex;
            justify-content: space-between;
            gap: 15px;
            border-top: 1px solid var(--line);
            color: var(--muted);
            font-size: 11px;
            letter-spacing: 0.5px;
        }

        @media (max-width: 800px) {
            .workspace {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 560px) {
            .topbar {
                padding: 15px 6%;
            }

            .topbar-label {
                display: none;
            }

            main {
                width: 88%;
                margin: 40px auto;
            }

            h1 {
                letter-spacing: -1px;
            }

            .workspace {
                grid-template-columns: 1fr;
            }

            .module {
                min-height: 175px;
            }

            .account-panel {
                align-items: flex-start;
                flex-direction: column;
                padding: 23px;
            }

            .logout-form,
            .logout-button {
                width: 100%;
            }

            footer {
                width: 88%;
                flex-wrap: wrap;
            }
        }
    </style>
</head>

<body>

<%
    String username = (String) session.getAttribute("username");
%>

<header class="topbar">
    <div class="brand">
        <div class="brand-mark">+</div>
        <span>SMART HOSPITAL</span>
    </div>

    <div class="topbar-label">Emergency Management System</div>
</header>

<main>
    <div class="eyebrow">
        <span class="status-dot"></span>
        Hospital Operations / Administration
    </div>

    <h1>
        Clarity in care.<br>
        <span>Control in emergencies.</span>
    </h1>

    <p class="intro">
        Manage patient records, coordinate emergency response,
        review treatment history and organize hospital resources
        from one central workspace.
    </p>

    <div class="section-title">
        <h2>Management Workspace</h2>
        <span class="section-note">Select a module to continue →</span>
    </div>

    <section class="workspace">

        <a class="module" href="patient-list">
            <div class="module-number">01 / RECORDS</div>
            <h3>Patient Management</h3>
            <p>Review patient records, update information and manage registrations.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="emergency-queue">
            <div class="module-number">02 / PRIORITY</div>
            <h3>Emergency Queue</h3>
            <p>Review emergency cases in priority order and process the next patient.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="emergency-search">
            <div class="module-number">03 / SEARCH</div>
            <h3>Emergency Search</h3>
            <p>Find emergency patients by their ID or name.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="emergency-history">
            <div class="module-number">04 / ARCHIVE</div>
            <h3>Emergency History</h3>
            <p>Review previously treated emergency patients and their recorded status.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="doctors">
            <div class="module-number">05 / CLINICAL TEAM</div>
            <h3>Doctor Management</h3>
            <p>Maintain the doctor directory and clinical team information.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="hospital-management">
            <div class="module-number">06 / RESOURCES</div>
            <h3>Hospital Management</h3>
            <p>Manage hospital records, bed availability, admissions and discharges.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="hospital-recommendation">
            <div class="module-number">07 / REFERRALS</div>
            <h3>Hospital Recommendation</h3>
            <p>Find suitable hospitals using specialty and available-bed information.</p>
            <span class="module-arrow">↗</span>
        </a>

        <a class="module" href="emergency-register">
            <div class="module-number">08 / INTAKE</div>
            <h3>Register Emergency</h3>
            <p>Open the emergency registration form to record a new case.</p>
            <span class="module-arrow">↗</span>
        </a>

    </section>

    <section class="account-panel">
        <div>
            <div class="section-label">Current Session</div>

            <div class="account-name">
                <%= escapeHtml(username != null ? username : "Guest") %>
            </div>

            <p class="account-description">
                Smart Hospital Emergency Management System
            </p>
        </div>

        <form class="logout-form"
              action="<%= request.getContextPath() %>/logout"
              method="post">

            <button class="logout-button" type="submit">
                Sign out &nbsp; →
            </button>
        </form>
    </section>
</main>

<footer>
    <span>SMART HOSPITAL</span>
    <span>Emergency Management System</span>
</footer>

</body>
</html>
```