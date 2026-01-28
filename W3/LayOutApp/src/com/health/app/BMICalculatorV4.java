package com.health.app;

import java.awt.*;

import javax.swing.*;


public class BMICalculatorV4 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		
		JFrame frame = new JFrame("BMI Calculator 3.0 - BoxLayout");
		
		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel,BoxLayout.Y_AXIS));
		
		Dimension boxSizeDimension = new Dimension(200,30);
		
		JLabel weightLabel = new JLabel("Weight (kg)");
		panel.add(weightLabel);
		
		JTextField weightBox = new JTextField(10);
		panel.add(weightBox);
		panel.add(Box.createVerticalStrut(20));
		
		JLabel heightLabel = new JLabel("Height (cm)");
		panel.add(heightLabel);
		
		JTextField heightBox = new JTextField(10);
		panel.add(heightBox);
		panel.add(Box.createVerticalStrut(20));
		
		JButton button = new JButton("Calculate");
		panel.add(button);
		
		
		JLabel resultLabel = new JLabel("Your BMI Result: ");
		panel.add(resultLabel);
		
		JTextField resultBox = new JTextField(10);
		panel.add(resultBox);
		panel.add(Box.createVerticalStrut(20));

		frame.add(panel);
		frame.setSize(350, 200);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
		

	}

}
