package practical.work.vannder;

import java.awt.*;
import javax.swing.*;

public class TemperatureConverter_GridLayout {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JFrame frame = new JFrame("Temperature Converter - GridLayout ");
		frame.setLayout(new GridLayout(4,2));

		
        frame.add(new JLabel("Celcius(°C): "));
        JTextField input = new JTextField(10);
        frame.add(input);


		JLabel unitLabel = new JLabel("Temperature unit: ");
		frame.add(unitLabel);
		
		JComboBox units = new JComboBox();
		units.addItem("Kelvin(K)");
		units.addItem("Fahrenheit(°F)");
		frame.add(units);
		
		frame.add(new JLabel("Result: "));
        JTextField result = new JTextField(10);
        frame.add(result);
				
		JButton calculateButton = new JButton("Convert");
		frame.add(calculateButton);
		JButton resetButton = new JButton("Reset");
		frame.add(resetButton);
		
		
		frame.setSize(350, 200);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setVisible(true);

	}

}
