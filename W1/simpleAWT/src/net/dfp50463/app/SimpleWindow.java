package net.dfp50463.app;

import java.awt.Button;
import java.awt.Frame;

public class SimpleWindow {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Frame frame = new Frame("My First AWT app");
		Button myButton = new Button("Click Me");
		myButton.setBounds(100, 80, 100, 30);
		
		frame.add(myButton);
		frame.setSize(300,300);
		
		frame.setVisible(true);
	}

}
