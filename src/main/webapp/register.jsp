<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account | Smart Hospital</title>

    <style>
        :root {
            --teal: #004643;
            --ivory: #f0ede5;
            --paper: #faf9f6;
            --text: #24312f;
            --muted: #697572;
            --border: #d8d9d0;
            --error: #a33b32;
            --error-bg: #f8e8e5;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            min-height: 100vh;
            background: var(--ivory);
            color: var(--text);
            font-family: Arial, Helvetica, sans-serif;
            display: flex;
            flex-direction: column;
        }

        header {
            min-height: 76px;
            padding: 15px 7%;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 15px;
            border-bottom: 1px solid var(--border);
        }

        .brand {
            display: flex;
            align-items: center;
            gap: 12px;
            color: var(--teal);
            font-size: 16px;
            font-weight: 700;
            letter-spacing: -0.3px;
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

        .header-label {
            color: var(--muted);
            font-size: 11px;
            letter-spacing: 1.3px;
            text-transform: uppercase;
        }

        main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 45px 20px;
        }

        .register-layout {
            width: min(900px, 100%);
            display: grid;
            grid-template-columns: 1fr 0.9fr;
            border: 1px solid #c9cec2;
            background: var(--paper);
        }

        .welcome-panel {
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            padding: 38px;
            background: var(--teal);
            color: var(--ivory);
        }

        .eyebrow {
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            opacity: 0.8;
        }

        .welcome-panel h1 {
            margin: 35px 0 16px;
            font-family: Georgia, "Times New Roman", serif;
            font-size: clamp(32px, 4vw, 46px);
            font-weight: 400;
            line-height: 1.12;
        }

        .welcome-panel p {
            max-width: 320px;
            color: #d0dcd5;
            font-size: 13px;
            line-height: 1.9;
        }

        .panel-footer {
            margin-top: 45px;
            padding-top: 18px;
            border-top: 1px solid rgba(240, 237, 229, 0.25);
            color: #d0dcd5;
            font-size: 11px;
            letter-spacing: 0.6px;
        }

        .form-panel {
            padding: 38px 32px;
        }

        .form-eyebrow {
            color: var(--muted);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1.8px;
            text-transform: uppercase;
        }

        h2 {
            margin: 12px 0 8px;
            color: var(--teal);
            font-family: Georgia, "Times New Roman", serif;
            font-size: 31px;
            font-weight: 400;
        }

        .form-intro {
            margin: 0 0 25px;
            color: var(--muted);
            font-size: 13px;
            line-height: 1.7;
        }

        .error {
            margin-bottom: 18px;
            padding: 12px;
            color: var(--error);
            background: var(--error-bg);
            border-left: 3px solid var(--error);
            font-size: 12px;
            line-height: 1.6;
            overflow-wrap: anywhere;
        }

        .field {
            margin-top: 19px;
        }

        label {
            display: block;
            margin-bottom: 9px;
            color: var(--text);
            font-size: 12px;
            font-weight: 700;
        }

        input {
            width: 100%;
            padding: 13px 14px;
            border: 1px solid var(--border);
            border-radius: 0;
            background: #fff;
            color: var(--text);
            font-family: inherit;
            font-size: 14px;
        }

        input:focus {
            outline: 2px solid var(--teal);
            outline-offset: 1px;
        }

        .hint {
            display: block;
            margin-top: 8px;
            color: var(--muted);
            font-size: 11px;
            line-height: 1.6;
        }

        .register-button {
            width: 100%;
            margin-top: 25px;
            padding: 14px;
            border: 1px solid var(--teal);
            background: var(--teal);
            color: white;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.2s;
        }

        .register-button:hover {
            background: #063936;
        }

        .login-prompt {
            margin: 23px 0 0;
            color: var(--muted);
            font-size: 12px;
            line-height: 1.8;
            text-align: center;
        }

        .login-prompt a {
            color: var(--teal);
            font-weight: 700;
            text-decoration: underline;
            text-underline-offset: 3px;
        }

        footer {
            padding: 19px 7%;
            border-top: 1px solid var(--border);
            color: var(--muted);
            font-size: 11px;
            letter-spacing: 0.5px;
            display: flex;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }

        @media (max-width: 650px) {
            header {
                padding: 15px 6%;
            }

            .header-label {
                display: none;
            }

            main {
                padding: 28px 16px;
            }

            .register-layout {
                grid-template-columns: 1fr;
            }

            .welcome-panel {
                padding: 25px;
            }

            .welcome-panel h1 {
                margin: 22px 0 10px;
                font-size: 34px;
            }

            .welcome-panel p {
                margin-bottom: 0;
            }

            .panel-footer {
                margin-top: 25px;
            }

            .form-panel {
                padding: 28px 24px;
            }

            footer {
                padding: 18px 6%;
            }
        }
    </style>
</head>

<body>

<header>
    <div class="brand">
        <div class="brand-mark">+</div>
        <span>SMART HOSPITAL</span>
    </div>

    <div class="header-label">Emergency Management System</div>
</header>

<main>
    <section class="register-layout">

        <div class="welcome-panel">
            <div class="eyebrow">Join / Hospital Administration</div>

            <div>
                <h1>Better coordination.<br>Better care.</h1>

                <p>
                    Create your account to access the hospital management
                    workspace and coordinate emergency operations.
                </p>
            </div>

            <div class="panel-footer">
                SMART HOSPITAL · EMERGENCY MANAGEMENT
            </div>
        </div>

        <div class="form-panel">
            <div class="form-eyebrow">New Account</div>

            <h2>Create account.</h2>

            <p class="form-intro">
                Enter your details to get started.
            </p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="error" role="alert">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/register"
                  method="post">

                <div class="field">
                    <label for="username">Username</label>

                    <input
                        type="text"
                        id="username"
                        name="username"
                        minlength="3"
                        maxlength="50"
                        pattern="[A-Za-z0-9_]{3,50}"
                        autocomplete="username"
                        placeholder="Choose a username"
                        title="Use 3–50 letters, numbers or underscores."
                        required>

                    <span class="hint">
                        Use 3–50 letters, numbers or underscores.
                    </span>
                </div>

                <div class="field">
                    <label for="password">Password</label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        minlength="8"
                        maxlength="72"
                        autocomplete="new-password"
                        placeholder="Create a password"
                        required>

                    <span class="hint">
                        Password must contain 8–72 characters.
                    </span>
                </div>

                <button class="register-button" type="submit">
                    Create account →
                </button>
            </form>

            <p class="login-prompt">
                Already have an account?
                <a href="<%= request.getContextPath() %>/login">
                    Sign in
                </a>
            </p>
        </div>

    </section>
</main>

<footer>
    <span>SMART HOSPITAL</span>
    <span>Emergency Management System</span>
</footer>

</body>
</html>
