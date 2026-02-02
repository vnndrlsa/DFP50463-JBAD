package practical.work.vannder;

import java.awt.*;
import javax.swing.*;


public class BMI_calculator_GridLayout {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JFrame frame = new JFrame("BMI CALCULATOR - GridLayout");
		frame.setLayout(new GridLayout(4,2));
		
		JLabel weightLabel = new JLabel("Weight (kg)");
		frame.add(weightLabel);
		
		JTextField weightBox = new JTextField(10);
		frame.add(weightBox);
		
		JLabel heightLabel = new JLabel("Height (cm)");
		frame.add(heightLabel);
		
		JTextField heightBox = new JTextField(10);
		frame.add(heightBox);
		
		JLabel resultLabel = new JLabel("Your BMI Result: ");
		frame.add(resultLabel);
		
		JTextField resultBox = new JTextField(10);
		frame.add(resultBox);
		
		JButton button = new JButton("Calculate");
		frame.add(button);
		
		JButton button2 = new JButton("Clear");
		frame.add(button2);
		
		
		frame.setSize(350, 200);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);


	}

}
