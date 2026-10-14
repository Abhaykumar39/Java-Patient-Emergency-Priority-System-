<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Patient Registration</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        background: #f3f0ff;
        padding: 30px;
      }
      .card {
        max-width: 450px;
        margin: auto;
        background: white;
        padding: 25px;
        border-radius: 12px;
      }
      h2 {
        color: #6546a5;
      }
      input,
      textarea,
      button {
        width: 100%;
        padding: 12px;
        margin-top: 12px;
        box-sizing: border-box;
      }
      button {
        background: #6546a5;
        color: white;
        border: none;
        border-radius: 6px;
      }
    </style>
  </head>
  <body>
    <div class="card">
      <h2>Patient Registration</h2>

      <form action="register-patient" method="post">
        <input type="text" name="name" placeholder="Patient Name" required />

        <input type="number" name="age" placeholder="Age" min="0" required />

        <textarea
          name="condition"
          placeholder="Medical Condition"
          required
        ></textarea>

        <button type="submit">Register Patient</button>
      </form>
    </div>
  </body>
</html>
