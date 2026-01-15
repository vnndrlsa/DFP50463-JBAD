package net.dfp50463.app;

import java.awt.Button;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.Label;
import java.awt.TextField;

public class PhytogorasCalculator {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		Frame frame = new Frame("Phytogoras Calculator");
		frame.setLayout(new FlowLayout());
		
		Label aLabel = new Label("a =");
		frame.add(aLabel);

		TextField afield = new TextField("",10);
		frame.add(afield);
		
		Label bLabel = new Label("b = ");
		frame.add(bLabel);
		
		TextField bfield = new TextField("",10);
		frame.add(bfield);
		
		Label cLabel = new Label("c = ");
		frame.add(cLabel);
		

		TextField cfield = new TextField("",10);
		frame.add(cfield);
		
		Button calculateButton = new Button("Calculate");
		frame.add(calculateButton);
		
		frame.setSize(350, 150);
		frame.setVisible(true);
	}

}
