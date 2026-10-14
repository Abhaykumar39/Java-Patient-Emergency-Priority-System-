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

    <title>Register Emergency Patient | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --paper: #faf9f6;
            --text: #24312f;
            --muted: #697572;
            --border: #d8d9d0;
            --danger: #a33b32;
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

        main {
            width: min(900px, 88%);
            margin: 46px auto;
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
            margin-bottom: 30px;
        }

        .form-panel {
            background: var(--paper);
            border: 1px solid var(--border);
            padding: 30px;
        }

        .form-heading {
            color: var(--teal);
            font-family: Georgia, "Times New Roman", serif;
            font-size: 24px;
            font-weight: 400;
            margin: 0 0 8px;
        }

        .form-note {
            color: var(--muted);
            font-size: 12px;
            line-height: 1.7;
            margin: 0 0 26px;
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
            color: var(--text);
            font-size: 13px;
            font-weight: 700;
        }

        .required {
            color: var(--danger);
        }

        input,
        select {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid var(--border);
            background: #fff;
            color: var(--text);
            font-family: inherit;
            font-size: 14px;
            border-radius: 0;
        }

        input:focus,
        select:focus {
            outline: 2px solid var(--teal);
            outline-offset: 1px;
        }

        .hint {
            color: var(--muted);
            font-size: 11px;
        }

        .form-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 28px;
            padding-top: 24px;
            border-top: 1px solid var(--border);
        }

        .submit-button {
            padding: 14px 22px;
            background: var(--teal);
            color: white;
            border: 1px solid var(--teal);
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
        }

        .submit-button:hover {
            background: #063936;
        }

        .cancel-link {
            padding: 13px 18px;
            color: var(--teal);
            border: 1px solid var(--border);
            font-size: 13px;
            font-weight: 700;
            text-decoration: none;
        }

        .quick-links {
            display: flex;
            flex-wrap: wrap;
            gap: 22px;
            margin-top: 24px;
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

        footer {
            border-top: 1px solid var(--border);
            padding: 20px 7%;
            color: var(--muted);
            font-size: 12px;
            margin-top: 65px;
        }

        @media (max-width: 600px) {
            main {
                margin: 30px auto;
            }

            .form-panel {
                padding: 20px;
            }

            .form-grid {
                grid-template-columns: 1fr;
                gap: 19px;
            }

            .field.full {
                grid-column: auto;
            }

            .submit-button,
            .cancel-link {
                width: 100%;
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
    <div class="eyebrow">Emergency Unit / Patient Intake</div>

    <h1>Register Emergency Patient</h1>

    <p class="intro">
        Record the patient's details and emergency level to add a new
        case to the emergency management system.
    </p>

    <section class="form-panel">
        <h2 class="form-heading">Patient Information</h2>

        <p class="form-note">
            Complete all required fields before submitting the registration.
        </p>

        <form action="register-emergency" method="post">
            <div class="form-grid">

                <div class="field full">
                    <label for="name">
                        Patient Name <span class="required">*</span>
                    </label>

                    <input
                        type="text"
                        id="name"
                        name="name"
                        maxlength="100"
                        placeholder="Enter patient's full name"
                        autocomplete="name"
                        required>
                </div>

                <div class="field">
                    <label for="age">
                        Age <span class="required">*</span>
                    </label>

                    <input
                        type="number"
                        id="age"
                        name="age"
                        min="0"
                        max="130"
                        placeholder="Enter age"
                        required>

                    <span class="hint">Accepted range: 0–130 years</span>
                </div>

                <div class="field">
                    <label for="emergencyLevel">
                        Emergency Level <span class="required">*</span>
                    </label>

                    <select id="emergencyLevel"
                            name="emergencyLevel"
                            required>
                        <option value="CRITICAL">Critical</option>
                        <option value="HIGH">High</option>
                        <option value="MEDIUM" selected>Medium</option>
                        <option value="LOW">Low</option>
                    </select>
                </div>

                <div class="field full">
                    <label for="condition">
                        Medical Condition <span class="required">*</span>
                    </label>

                    <input
                        type="text"
                        id="condition"
                        name="condition"
                        maxlength="255"
                        placeholder="Describe the medical condition"
                        required>
                </div>

            </div>

            <div class="form-actions">
                <button class="submit-button" type="submit">
                    Register Emergency Patient →
                </button>

                <a class="cancel-link" href="index.jsp">
                    Cancel
                </a>
            </div>
        </form>
    </section>

    <nav class="quick-links">
        <a href="emergency-queue">View Emergency Priority Queue →</a>
        <a href="emergency-search">Search Existing Patients →</a>
    </nav>
</main>

<footer>
    Smart Hospital Emergency Management System
</footer>

</body>
</html>
