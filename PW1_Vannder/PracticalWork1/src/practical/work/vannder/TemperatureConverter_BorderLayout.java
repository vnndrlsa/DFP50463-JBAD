package practical.work.vannder;

import java.awt.*;
import javax.swing.*;

public class TemperatureConverter_BorderLayout {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		JFrame frame = new JFrame("Temperature Converter - BorderLayout ");
		frame.setLayout(new BorderLayout());
		
		JPanel inputPanel = new JPanel();
		inputPanel.add(new JLabel("Celsius(°C): "));
		JTextField input = new JTextField(15);
		inputPanel.add(input);
		frame.add(inputPanel, BorderLayout.NORTH);
		
		JPanel centerPanel = new JPanel(new BorderLayout());
		
		JPanel unitPanel = new JPanel();
		unitPanel.add(new JLabel("Temperature unit: "));
		JComboBox units = new JComboBox();
		units.addItem("Kelvin(K)");
		units.addItem("Fahrenheit(°F)");
		unitPanel.add(units);
		centerPanel.add(unitPanel, BorderLayout.NORTH);
		
		JPanel resultPanel = new JPanel();
		resultPanel.add(new JLabel("Result: "));
		JTextField result = new JTextField(15);
		resultPanel.add(result);
		centerPanel.add(resultPanel, BorderLayout.CENTER);
		
		frame.add(centerPanel, BorderLayout.CENTER);
		
		JPanel bottomPanel = new JPanel();
		JButton calculateButton = new JButton("Convert");
		bottomPanel.add(calculateButton);
		JButton resetButton = new JButton("Reset");
		bottomPanel.add(resetButton);
		frame.add(bottomPanel, BorderLayout.SOUTH);
		
		frame.setSize(400, 200);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);
	}
}