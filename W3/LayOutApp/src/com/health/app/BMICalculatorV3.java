package com.health.app;

import java.awt.*;

import javax.swing.*;

public class BMICalculatorV3 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JFrame frame = new JFrame("BMI Calculator 2.2 - BorderLayout");
		frame.setLayout(new BorderLayout());
		
		JPanel inputPanel = new JPanel(new GridLayout(2,2));
		
		
		JLabel weightLabel = new JLabel("Weight (kg)");
		inputPanel.add(weightLabel);
		
		JTextField weightBox = new JTextField(10);
		inputPanel.add(weightBox);
		
		JLabel heightLabel = new JLabel("Height (cm)");
		inputPanel.add(heightLabel);
		
		JTextField heightBox = new JTextField(10);
		inputPanel.add(heightBox);
		
		frame.add(inputPanel, BorderLayout.NORTH);
		
		JButton button = new JButton("Calculate");
		frame.add(button, BorderLayout.CENTER);
		
		
		
		
		JPanel resultPanel = new JPanel(new GridLayout(1,2));
		
		JLabel resultLabel = new JLabel("Your BMI Result: ");
		resultPanel.add(resultLabel);
		
		JTextField resultBox = new JTextField(10);
		resultPanel.add(resultBox);
		
		frame.add(resultPanel,BorderLayout.SOUTH);
		
		frame.setSize(350, 200);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);

	}

}
