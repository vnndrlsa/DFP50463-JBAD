package my.edu.spmp.app;

import java.awt.FlowLayout;

import javax.swing.*;

public class KelvinCelciusConverter {

	public static JFrame createKelvinFrame() {
		
		JFrame frame = new JFrame();
				
		JTextField kelvinTextField = new JTextField(5);
		
		JLabel kelvinJLabel = new JLabel("K");
				
		JButton calculateJButton = new JButton("Calculate");
		JButton resetJButton = new JButton("Reset");

		frame.setSize(350, 200);
		JPanel panel = new JPanel(new FlowLayout(FlowLayout.CENTER,10,10));
	
		panel.add(kelvinTextField);
		panel.add(kelvinJLabel);
		panel.add(calculateJButton);
		panel.add(resetJButton);
				
		frame.add(panel);
		return frame;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JFrame frame = createKelvinFrame();
		frame.setVisible(true);

	}

}
