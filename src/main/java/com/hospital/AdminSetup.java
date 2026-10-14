
package com.hospital;

import com.hospital.dao.UserDAO;

import java.io.Console;

public class AdminSetup {

    public static void main(String[] args) {

        Console console = System.console();

        if (console == null) {
            System.out.println(
                "Run this utility from a terminal that supports Console."
            );
            return;
        }

        String username = console.readLine("Admin username: ");
        char[] passwordChars = console.readPassword("Admin password: ");
        char[] confirmChars = console.readPassword("Confirm password: ");

        String password = new String(passwordChars);
        String confirmPassword = new String(confirmChars);

        java.util.Arrays.fill(passwordChars, '\0');
        java.util.Arrays.fill(confirmChars, '\0');

        if (!password.equals(confirmPassword)) {
            System.out.println("Passwords do not match.");
            return;
        }

        UserDAO dao = new UserDAO();

        boolean created = dao.createUser(username, password, "ADMIN");

        if (created) {
            System.out.println("Admin account created successfully.");
        } else {
            System.out.println(
                "Admin account could not be created. " +
                "Check username, password requirements, and database logs."
            );
        }
    }
}
