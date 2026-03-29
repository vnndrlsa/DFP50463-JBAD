package com.bmi.ui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class BMI_Calculator {

    public static void main(String[] args) {
        JFrame frame = new JFrame("BMI Calculator");
        frame.setLayout(new GridLayout(7, 1, 10, 10));
        frame.setSize(350, 480);

        JLabel instructionLabel = new JLabel("Choose Unit and Enter Details", JLabel.CENTER);

        String[] unitStrings = {"Metric (kg / m)", "Imperial (lb / in)"};
        JComboBox<String> unitComboBox = new JComboBox<>(unitStrings);

        // 👇 Placeholder text that clears on focus
        JTextField weightInput = new JTextField("Enter Weight");
        JTextField heightInput = new JTextField("Enter Height");
        addPlaceholderBehavior(weightInput, "Enter Weight");
        addPlaceholderBehavior(heightInput, "Enter Height");

        JButton calculateButton = new JButton("Calculate BMI");
        calculateButton.setBackground(new Color(255, 165, 0));
        calculateButton.setForeground(Color.WHITE);
        calculateButton.setFont(new Font("Arial", Font.BOLD, 14));

        JLabel resultLabel = new JLabel("Result: ---", JLabel.CENTER);
        resultLabel.setFont(new Font("Arial", Font.BOLD, 16));

        JLabel categoryLabel = new JLabel("", JLabel.CENTER); // 👈 BMI category
        categoryLabel.setFont(new Font("Arial", Font.ITALIC, 14));

        calculateButton.addActionListener(e -> {
            try {
                double weight = Double.parseDouble(weightInput.getText());
                double height = Double.parseDouble(heightInput.getText());

                double bmi;
                if (unitComboBox.getSelectedIndex() == 0) {
                    bmi = weight / (height * height);
                } else {
                    bmi = 703 * (weight / (height * height));
                }

                resultLabel.setText(String.format("BMI: %.2f", bmi));
                resultLabel.setForeground(Color.BLACK);

                if (bmi < 18.5) {
                    categoryLabel.setText("Underweight");
                    categoryLabel.setForeground(Color.BLUE);
                } else if (bmi < 25.0) {
                    categoryLabel.setText("Normal weight");
                    categoryLabel.setForeground(Color.GREEN);
                } else if (bmi < 30.0) {
                    categoryLabel.setText("Overweight");
                    categoryLabel.setForeground(Color.ORANGE);
                } else {
                    categoryLabel.setText("Obese");
                    categoryLabel.setForeground(Color.RED);
                }

            } catch (NumberFormatException ex) {
                resultLabel.setText("Invalid input — numbers only");
                resultLabel.setForeground(Color.RED);
                categoryLabel.setText("");
            }
        });

        frame.add(instructionLabel);
        frame.add(unitComboBox);
        frame.add(weightInput);
        frame.add(heightInput);
        frame.add(calculateButton); 
        frame.add(resultLabel);
        frame.add(categoryLabel);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    
    private static void addPlaceholderBehavior(JTextField field, String placeholder) {
        field.setForeground(Color.GRAY);
        field.addFocusListener(new FocusAdapter() {
            @Override
            public void focusGained(FocusEvent e) {
                if (field.getText().equals(placeholder)) {
                    field.setText("");
                    field.setForeground(Color.BLACK);
                }
            }

            @Override
            public void focusLost(FocusEvent e) {
                if (field.getText().isBlank()) {
                    field.setText(placeholder);
                    field.setForeground(Color.GRAY);
                }
            }
        });
    }
}