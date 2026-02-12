
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
			JMenu fileMenu = new JMenu("File");
			JMenu editMenu = new JMenu("Edit");
			JMenu sourceMenu = new JMenu("Source");
			JMenu refractorMenu = new JMenu("Refreactor");
			JMenu navigateMenu = new JMenu("Navigate");
			JMenu searchMenu = new JMenu("Search");
			JMenu projectMenu = new JMenu("Project");
			JMenu runMenu = new JMenu("Run");
			JMenu windowMenu = new JMenu("Window");
			JMenu helpMenu = new JMenu("Help");
			
			
			JMenuItem aboutItem = new JMenuItem("About");
			JMenuItem helpItem = new JMenuItem("Help");

			helpMenu.add(aboutItem);
			helpMenu.add(helpItem);
			
			menuBar.add(fileMenu);
			menuBar.add(editMenu);
			menuBar.add(sourceMenu);
			menuBar.add(refractorMenu);
			menuBar.add(navigateMenu);
			menuBar.add(searchMenu);
			menuBar.add(projectMenu);
			menuBar.add(runMenu);
			menuBar.add(windowMenu);
			menuBar.add(helpMenu);
			
			JLabel weightLabel = new JLabel("Weight (kg)");
			frame.add(weightLabel);
			
			JTextField weightBox = new JTextField(10);
			frame.add(weightBox);
			
			JLabel heightLabel = new JLabel("Height (m)");
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
			
			
			//HELP MENU ACTIONS
			helpItem.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					// TODO Auto-generated method stub
					JOptionPane.showMessageDialog(frame, 
							"BMI Calculator V1" ,
							"About BMI Calculator",
							JOptionPane.INFORMATION_MESSAGE);
				}
			});
			
			//ABOUT MENU ACTIONS
			aboutItem.addActionListener(new ActionListener() {
				
				@Override
				public void actionPerformed(ActionEvent e) {
					// TODO Auto-generated method stub
					JOptionPane.showMessageDialog(frame, 
							"How to use:\n" +
							 "1. Select your unit system (Metric or Imperial)\n" +
							 "2. Enter your weight and height\n" +
							 "3. Click Calculate BMI button\n" +
							 "4. View your BMI result",
							 "Help - BMI Calculator",
							 JOptionPane.INFORMATION_MESSAGE);
				}
			});
			
			
			
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


