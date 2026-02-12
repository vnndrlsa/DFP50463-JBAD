import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class CoffeeShop_OrderSystem {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		JFrame frame = new JFrame("Coffee Shop Order System");
		frame.setLayout(new GridLayout(5,2));
		
		//choose coffee type
		JLabel selectLabel = new JLabel("Select Coffee Type");
		frame.add(selectLabel);
		
		JComboBox coffee = new JComboBox();
		coffee.addItem("Latte");
		coffee.addItem("Cuppucino");
		coffee.addItem("Americano");
		coffee.addItem("Espresso");
		coffee.addItem("Mocha");

		
		frame.add(coffee);
		
		//choose quantity
		JLabel quantitiyLabel = new JLabel("Quantitiy");
		frame.add(quantitiyLabel);
        
        JSpinner quantity = new JSpinner(new SpinnerNumberModel(1, 1, 10, 1));
        frame.add(quantity);
		
		//choose sugar level
		JLabel sugarLabel = new JLabel("Sugar Level");
		frame.add(sugarLabel);
		
		JComboBox sugar = new JComboBox();
		sugar.addItem("Low");
		sugar.addItem("Medium");
		sugar.addItem("High");
		
		frame.add(sugar);
		
		//Customer name
		JLabel custNameLabel = new JLabel("Customer Name");
		frame.add(custNameLabel);
		
		JTextField name = new JTextField();
		frame.add(name);
		
		//Place Order Button
		JLabel spaceJLabel = new JLabel();
		
		JButton button = new JButton("Place Order");
		frame.add(button);
		
		//Display after order (di bawah)
		JLabel display = new JLabel();
        frame.add(display);
		
		
		//action listener to paparkan the order yang telah dibuat
		button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                String customerName = name.getText();
                String coffeeType = (String) coffee.getSelectedItem();
                int qty = (Integer) quantity.getValue();
                
                display.setText("Order for " + customerName + ": " + qty + " " + coffeeType + "s coming up!");
            }
        });
		
		frame.setSize(500, 300);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
		

	}

}
