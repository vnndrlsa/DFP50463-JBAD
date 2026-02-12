package com.bmi.ui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

public class BMI_Calculator {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JFrame frame = new JFrame("WOW BMI CALCULATOR");
		frame.setLayout(new GridLayout(6,1,10,10));
		frame.setSize(350,450);
		
		JLabel instructionLabel = new JLabel("Choose Unit and Enter Details",JLabel.CENTER);
		
		String[] unitStrings = {"Metrics (kg/m)", "Imperial (lb/in)"};
		JComboBox<String> unitComboBox = new JComboBox<>(unitStrings);
		
		JTextField weightInput = new JTextField("Enter Weight: ");
		JTextField heightInput = new JTextField("Enter Height: ");
		JButton calculateButton = new JButton("Calculate BMI");
		JLabel resultLabel = new JLabel("Result: ---" , JLabel.CENTER);
		
		calculateButton.addActionListener(new ActionListener() {
			
			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
			try {
				double weight = Double.parseDouble(weightInput.getText());
				double height = Double.parseDouble(heightInput.getText());
				
				double bmi;
				
				if(unitComboBox.getSelectedIndex()==0) {
					bmi = weight/(height*height);
				}else {
					bmi = 703 * (weight/(height*height));
					
				}
				resultLabel.setText(String.format("Result: %.2f" , bmi));
				resultLabel.setForeground(Color.BLACK);
			} catch(NumberFormatException ex) {
				// TODO: handle exception
				resultLabel.setText("Invalid Input");
				resultLabel.setForeground(Color.RED);
			}
				
			}
				
		});

		frame.add(instructionLabel);
		frame.add(unitComboBox);
		frame.add(weightInput);
		frame.add(heightInput);
		frame.add(resultLabel);
		frame.add(calculateButton);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
		

	}

}
