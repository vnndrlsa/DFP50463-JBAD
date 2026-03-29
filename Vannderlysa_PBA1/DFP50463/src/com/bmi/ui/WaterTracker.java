package com.bmi.ui;

import javax.swing.*;
import java.awt.*;

public class WaterTracker {

    public static void open() {
        JFrame frame = new JFrame("Water Tracker");
        frame.setSize(350, 450);
        frame.setLayout(new BorderLayout(10, 10));
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

        // Title
        JLabel title = new JLabel("💧 Water Tracker", JLabel.CENTER);
        title.setFont(new Font("Arial", Font.BOLD, 22));
        title.setBorder(BorderFactory.createEmptyBorder(15, 0, 5, 0));
        frame.add(title, BorderLayout.NORTH);

        // Center panel
        JPanel center = new JPanel(new GridLayout(5, 1, 10, 10));
        center.setBorder(BorderFactory.createEmptyBorder(10, 30, 10, 30));

        JLabel goalLabel = new JLabel("Daily Goal: 8 glasses", JLabel.CENTER);
        goalLabel.setFont(new Font("Arial", Font.PLAIN, 14));

        JLabel countLabel = new JLabel("Glasses Drunk: 0", JLabel.CENTER);
        countLabel.setFont(new Font("Arial", Font.BOLD, 20));
        countLabel.setForeground(new Color(30, 144, 255));

        JProgressBar progressBar = new JProgressBar(0, 8);
        progressBar.setValue(0);
        progressBar.setStringPainted(true);
        progressBar.setForeground(new Color(30, 144, 255));
        progressBar.setFont(new Font("Arial", Font.BOLD, 12));

        JButton addBtn = new JButton("+ Add a Glass");
        addBtn.setBackground(new Color(30, 144, 255));
        addBtn.setForeground(Color.WHITE);
        addBtn.setFont(new Font("Arial", Font.BOLD, 14));
        addBtn.setFocusPainted(false);

        JButton resetBtn = new JButton("Reset");
        resetBtn.setBackground(Color.LIGHT_GRAY);
        resetBtn.setFont(new Font("Arial", Font.BOLD, 13));
        resetBtn.setFocusPainted(false);

        int[] count = {0}; // use array to modify inside lambda

        addBtn.addActionListener(e -> {
            if (count[0] < 8) {
                count[0]++;
                countLabel.setText("Glasses Drunk: " + count[0]);
                progressBar.setValue(count[0]);
            }
            if (count[0] >= 8) {
                countLabel.setText("🎉 Goal Reached!");
                countLabel.setForeground(new Color(34, 139, 34));
            }
        });

        resetBtn.addActionListener(e -> {
            count[0] = 0;
            countLabel.setText("Glasses Drunk: 0");
            countLabel.setForeground(new Color(30, 144, 255));
            progressBar.setValue(0);
        });

        center.add(goalLabel);
        center.add(countLabel);
        center.add(progressBar);
        center.add(addBtn);
        center.add(resetBtn);

        frame.add(center, BorderLayout.CENTER);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }
}