package net.dfp50463.app;

import java.awt.*;
public class BMICalculator {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Frame frame = new Frame("BMI Calculator");
		frame.setLayout(new FlowLayout());
		
		Label weightLabel = new Label("Weight (kg)");
		frame.add(weightLabel);
		
		TextField weightfield = new TextField("0.0",10);
		frame.add(weightfield);
		
		Label heightLabel = new Label("Height (cm)");
		frame.add(heightLabel);
		
		TextField heightfield = new TextField("0.0",10);
		frame.add(heightfield);
		
		Button calculateButton = new Button("Calculate BMI");
		frame.add(calculateButton);
		
		frame.setSize(350, 150);
		frame.setVisible(true);
	}

}
