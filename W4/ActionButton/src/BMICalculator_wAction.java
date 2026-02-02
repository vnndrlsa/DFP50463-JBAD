
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.*;

public class BMICalculator_wAction {
 
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
			
			JFrame frame = new JFrame("BMI CALCULATOR - GridLayout");
			frame.setLayout(new GridLayout(4,2));
			
			JMenuBar menuBar = new JMenuBar();
			JMenu helpMenu = new JMenu("Help");
			JMenuItem aboutItem = new JMenuItem("About");
			JMenuItem helpItem = new JMenuItem("Help");

			helpMenu.add(aboutItem);
			helpMenu.add(helpItem);
			
			menuBar.add(helpMenu);
			
			JLabel weightLabel = new JLabel("Weight (kg)");
			frame.add(weightLabel);
			
			JTextField weightBox = new JTextField(10);
			frame.add(weightBox);
			
			JLabel heightLabel = new JLabel("Height (cm)");
			frame.add(heightLabel);
			
			JTextField heightBox = new JTextField(10);
			
			frame.add(heightBox);JLabel resultLabel = new JLabel("Your BMI Result: ");
			frame.add(resultLabel);
			
			JTextField resultBox = new JTextField(10);
			frame.add(resultBox);
			
			JButton button = new JButton("Calculate");
			frame.add(button);
			
			JButton button2 = new JButton("Clear");
			frame.add(button2);
			
			button.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					// TODO Auto-generated method stub
					try {
						double weight = Double.parseDouble(weightBox.getText());
						double height = Double.parseDouble(heightBox.getText());
						
						//BMI = weight/(height)^2
						double bmi;
						bmi = weight / (height*height);
						resultBox.setText(String.format("Result: %.2f", bmi));
					} 
					catch (NumberFormatException ex) {
						// TODO: handle exception
						resultLabel.setText("INVALID INPUT");
						resultLabel.setForeground(Color.RED);
					}
					
					
				}
			});
			
			frame.setSize(350, 200);
			frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			frame.setJMenuBar(menuBar);
			frame.setVisible(true);

	}
}


