package com.bmi.ui;

import javax.swing.*;
import java.awt.*;

public class SleepTracker {

    public static void open() {
        JFrame frame = new JFrame("Sleep Tracker");
        frame.setSize(350, 430);
        frame.setLayout(new GridLayout(8, 1, 10, 10));
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        JLabel title = new JLabel("🌙 Sleep Tracker", JLabel.CENTER);
        title.setFont(new Font("Arial", Font.BOLD, 22));

        JLabel bedLabel = new JLabel("Bedtime Hour (0–23):", JLabel.CENTER);
        JTextField bedInput = new JTextField("e.g. 22");
        addPlaceholderBehavior(bedInput, "e.g. 22");

        JLabel wakeLabel = new JLabel("Wake-up Hour (0–23):", JLabel.CENTER);
        JTextField wakeInput = new JTextField("e.g. 6");
        addPlaceholderBehavior(wakeInput, "e.g. 6");

        JButton calcBtn = new JButton("Calculate Sleep");
        calcBtn.setBackground(new Color(106, 90, 205));
        calcBtn.setForeground(Color.WHITE);
        calcBtn.setFont(new Font("Arial", Font.BOLD, 14));
        calcBtn.setFocusPainted(false);

        JLabel resultLabel = new JLabel("Result: ---", JLabel.CENTER);
        resultLabel.setFont(new Font("Arial", Font.BOLD, 16));

        JLabel adviceLabel = new JLabel("", JLabel.CENTER);
        adviceLabel.setFont(new Font("Arial", Font.ITALIC, 13));

        calcBtn.addActionListener(e -> {
            try {
                int bed = Integer.parseInt(bedInput.getText());
                int wake = Integer.parseInt(wakeInput.getText());

                if (bed < 0 || bed > 23 || wake < 0 || wake > 23) {
                    resultLabel.setText("Enter hours between 0–23");
                    resultLabel.setForeground(Color.RED);
                    adviceLabel.setText("");
                    return;
                }

                int hours = (wake - bed + 24) % 24; // handles overnight sleep
                resultLabel.setText("Sleep Duration: " + hours + " hours");
                resultLabel.setForeground(Color.BLACK);

                if (hours < 6) {
                    adviceLabel.setText("⚠ Too little sleep!");
                    adviceLabel.setForeground(Color.RED);
                } else if (hours <= 9) {
                    adviceLabel.setText("✓ Great sleep duration!");
                    adviceLabel.setForeground(new Color(34, 139, 34));
                } else {
                    adviceLabel.setText("⚠ Oversleeping detected");
                    adviceLabel.setForeground(new Color(255, 140, 0));
                }

            } catch (NumberFormatException ex) {
                resultLabel.setText("Invalid input — numbers only");
                resultLabel.setForeground(Color.RED);
                adviceLabel.setText("");
            }
        });

        frame.add(title);
        frame.add(bedLabel);
        frame.add(bedInput);
        frame.add(wakeLabel);
        frame.add(wakeInput);
        frame.add(calcBtn);
        frame.add(resultLabel);
        frame.add(adviceLabel);

        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    private static void addPlaceholderBehavior(JTextField field, String placeholder) {
        field.setForeground(Color.GRAY);
        field.addFocusListener(new java.awt.event.FocusAdapter() {
            public void focusGained(java.awt.event.FocusEvent e) {
                if (field.getText().equals(placeholder)) { field.setText(""); field.setForeground(Color.BLACK); }
            }
            public void focusLost(java.awt.event.FocusEvent e) {
                if (field.getText().isBlank()) { field.setText(placeholder); field.setForeground(Color.GRAY); }
            }
        });
    }
}