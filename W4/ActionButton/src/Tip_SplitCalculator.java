import java.awt.GridLayout;

import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JTextField;

public class Tip_SplitCalculator {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		JFrame frame = new JFrame("Tip & Split Calculator");
		frame.setLayout(new GridLayout(5,2));
		
		JLabel total = new JLabel("Total Bill");
		frame.add(total);
		
		JTextField totalInput = new JTextField();
		frame.add(totalInput);
		
		
		frame.setSize(500, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
	}

}
