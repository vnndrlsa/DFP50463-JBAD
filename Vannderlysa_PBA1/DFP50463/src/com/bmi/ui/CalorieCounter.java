package com.bmi.ui;

import javax.swing.*;
import java.awt.*;

public class CalorieCounter {

    public static void open() {
        JFrame frame = new JFrame("Calorie Counter");
        frame.setSize(380, 500);
        frame.setLayout(new BorderLayout(10, 10));
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        JLabel title = new JLabel("🍔 Calorie Counter", JLabel.CENTER);
        title.setFont(new Font("Arial", Font.BOLD, 22));
        title.setBorder(BorderFactory.createEmptyBorder(15, 0, 5, 0));
        frame.add(title, BorderLayout.NORTH);

        // Input panel
        JPanel inputPanel = new JPanel(new GridLayout(3, 2, 10, 10));
        inputPanel.setBorder(BorderFactory.createEmptyBorder(10, 20, 10, 20));

        JTextField foodInput = new JTextField("Food name");
        JTextField calInput = new JTextField("Calories");
        addPlaceholderBehavior(foodInput, "Food name");
        addPlaceholderBehavior(calInput, "Calories");

        JButton addBtn = new JButton("Add Food");
        addBtn.setBackground(new Color(255, 165, 0));
        addBtn.setForeground(Color.WHITE);
        addBtn.setFont(new Font("Arial", Font.BOLD, 13));
        addBtn.setFocusPainted(false);

        JButton resetBtn = new JButton("Reset All");
        resetBtn.setBackground(Color.LIGHT_GRAY);
        resetBtn.setFont(new Font("Arial", Font.BOLD, 13));
        resetBtn.setFocusPainted(false);

        inputPanel.add(foodInput);
        inputPanel.add(calInput);
        inputPanel.add(addBtn);
        inputPanel.add(resetBtn);
        frame.add(inputPanel, BorderLayout.NORTH);

        // Food log list
        DefaultListModel<String> listModel = new DefaultListModel<>();
        JList<String> foodList = new JList<>(listModel);
        foodList.setFont(new Font("Arial", Font.PLAIN, 13));
        JScrollPane scrollPane = new JScrollPane(foodList);
        scrollPane.setBorder(BorderFactory.createTitledBorder("Food Log"));
        frame.add(scrollPane, BorderLayout.CENTER);

        // Total label
        JLabel totalLabel = new JLabel("Total: 0 kcal", JLabel.CENTER);
        totalLabel.setFont(new Font("Arial", Font.BOLD, 18));
        totalLabel.setForeground(new Color(255, 165, 0));
        totalLabel.setBorder(BorderFactory.createEmptyBorder(10, 0, 10, 0));
        frame.add(totalLabel, BorderLayout.SOUTH);

        int[] total = {0};

        addBtn.addActionListener(e -> {
            try {
                String food = foodInput.getText().trim();
                int cal = Integer.parseInt(calInput.getText().trim());
                if (food.isEmpty() || food.equals("Food name")) throw new IllegalArgumentException();

                listModel.addElement(food + "  —  " + cal + " kcal");
                total[0] += cal;
                totalLabel.setText("Total: " + total[0] + " kcal");

                // Warn if over 2000 kcal
                if (total[0] > 2000) {
                    totalLabel.setForeground(Color.RED);
                    totalLabel.setText("Total: " + total[0] + " kcal ⚠ Over daily limit!");
                }

                foodInput.setText("Food name");
                foodInput.setForeground(Color.GRAY);
                calInput.setText("Calories");
                calInput.setForeground(Color.GRAY);

            } catch (Exception ex) {
                JOptionPane.showMessageDialog(frame, "Enter a valid food name and calorie number.", "Invalid Input", JOptionPane.ERROR_MESSAGE);
            }
        });

        resetBtn.addActionListener(e -> {
            listModel.clear();
            total[0] = 0;
            totalLabel.setText("Total: 0 kcal");
            totalLabel.setForeground(new Color(255, 165, 0));
        });

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