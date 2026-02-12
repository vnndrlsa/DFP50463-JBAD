package com.bmi.ui;

import javax.swing.*;
import java.awt.*;

public class HealthLauncher {

    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }

        JFrame frame = new JFrame("Health Suite Launcher");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 500);
        frame.setLayout(new BorderLayout());

        JLabel title = new JLabel("Health Suite Launcher", JLabel.CENTER);
        title.setFont(new Font("Arial", Font.BOLD, 24));
        frame.add(title, BorderLayout.NORTH);

        JPanel gridPanel = new JPanel(new GridLayout(2, 2, 20, 20));
        gridPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

        // BMI CARD
        gridPanel.add(createCard("bmi_icon.png", new Color(255, 165, 0)));

        // WATER CARD
        gridPanel.add(createCard("water_icon.png", new Color(30, 144, 255)));

        // SLEEP CARD
        gridPanel.add(createCard("sleep_icon.png", new Color(30, 144, 255)));

        // CALORIE CARD
        gridPanel.add(createCard("calorie_icon.png", new Color(255, 165, 0)));

        frame.add(gridPanel, BorderLayout.CENTER);
        frame.setLocationRelativeTo(null);
        frame.setVisible(true);
    }

    // Method to create card UI
    private static JPanel createCard(String imagePath, Color btnColor) {
        JPanel card = new JPanel(new BorderLayout());
        card.setBorder(BorderFactory.createLineBorder(Color.LIGHT_GRAY, 2));
        card.setBackground(Color.WHITE);

        ImageIcon icon = new ImageIcon(imagePath);
        Image img = icon.getImage().getScaledInstance(120, 120, Image.SCALE_SMOOTH);
        JLabel iconLabel = new JLabel(new ImageIcon(img), JLabel.CENTER);

        JButton btn = new JButton("Open App");
        btn.setBackground(btnColor);
        btn.setForeground(Color.WHITE);
        btn.setFont(new Font("Arial", Font.BOLD, 14));
        btn.setFocusPainted(false);

        card.add(iconLabel, BorderLayout.CENTER);
        card.add(btn, BorderLayout.SOUTH);

        return card;
    }
}
