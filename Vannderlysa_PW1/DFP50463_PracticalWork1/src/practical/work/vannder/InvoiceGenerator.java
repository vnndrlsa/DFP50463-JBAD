//Vannderlysa Liung Joseph
//20DIT23F2010
//Practical Work 1

package practical.work.vannder;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

public class InvoiceGenerator {
    public static void main(String[] args) {

        JFrame frame = new JFrame("Invoice Generator");
        frame.setLayout(new BorderLayout(5, 5));
        frame.setSize(480, 500);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        JPanel headerPanel = new JPanel();
        headerPanel.setLayout(new GridLayout(2, 3, 5, 2));

        JLabel lblName  = new JLabel("Client Name");
        JLabel lblRate  = new JLabel("Hourly Rate (RM)");
        JLabel lblHours = new JLabel("Hours Worked");

        JTextField txtName  = new JTextField(10);
        JTextField txtRate  = new JTextField(10);
        JTextField txtHours = new JTextField(10);

        headerPanel.add(lblName);
        headerPanel.add(lblRate);
        headerPanel.add(lblHours);
        headerPanel.add(txtName);
        headerPanel.add(txtRate);
        headerPanel.add(txtHours);

        JPanel taxPanel = new JPanel();
        taxPanel.setLayout(new GridLayout(2, 2, 5, 2));

        JLabel     lblTax    = new JLabel("Tax Rate");
        JTextField txtTax    = new JTextField(10);
        JLabel     lblEmpty  = new JLabel("");
        JCheckBox  chkDiscount = new JCheckBox("Apply 10% Discount");

        taxPanel.add(lblTax);
        taxPanel.add(txtTax);
        taxPanel.add(lblEmpty);
        taxPanel.add(chkDiscount);

        JPanel topPanel = new JPanel();
        topPanel.setLayout(new BorderLayout(5, 5));
        topPanel.setBorder(BorderFactory.createEmptyBorder(8, 8, 5, 8));
        topPanel.add(headerPanel, BorderLayout.NORTH);
        topPanel.add(taxPanel, BorderLayout.CENTER);

        frame.add(topPanel, BorderLayout.NORTH);

        JTextArea txtReport = new JTextArea();
        txtReport.setEditable(false);
        txtReport.setFont(new Font("Monospaced", Font.PLAIN, 12));
        txtReport.setText("[ Invoice report will appear here ]");

        JScrollPane scroll = new JScrollPane(txtReport);
        scroll.setBorder(BorderFactory.createEmptyBorder(0, 8, 0, 8));
        frame.add(scroll, BorderLayout.CENTER);

        JPanel buttonPanel = new JPanel();
        buttonPanel.setLayout(new FlowLayout(FlowLayout.CENTER, 15, 8));

        JButton btnGenerate = new JButton("Generate Report");
        JButton btnClear    = new JButton("Clear Form");

        buttonPanel.add(btnGenerate);
        buttonPanel.add(btnClear);

        frame.add(buttonPanel, BorderLayout.SOUTH);

        // BUTTON ACTIONS
        btnGenerate.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {

                // Data Validation — empty fields
                if (txtName.getText().trim().isEmpty() ||
                    txtRate.getText().trim().isEmpty() ||
                    txtHours.getText().trim().isEmpty() ||
                    txtTax.getText().trim().isEmpty()) {
                    JOptionPane.showMessageDialog(frame, "All fields are required!", "Error", JOptionPane.WARNING_MESSAGE);
                    return;
                }

                // 👇 Client Name must not contain numbers
                if (txtName.getText().trim().matches(".*\\d.*")) {
                    JOptionPane.showMessageDialog(frame, "Client Name must not contain numbers!", "Invalid Input", JOptionPane.ERROR_MESSAGE);
                    return;
                }

                // 👇 Parsing wrapped in try-catch
                try {
                    String name  = txtName.getText().trim();
                    double rate  = Double.parseDouble(txtRate.getText().trim());
                    double hours = Double.parseDouble(txtHours.getText().trim());
                    double tax   = Double.parseDouble(txtTax.getText().trim());

                    // 👇 Negative number validation
                    if (rate < 0 || hours < 0 || tax < 0) {
                        JOptionPane.showMessageDialog(frame, "Rate, Hours and Tax must be positive numbers!", "Invalid Input", JOptionPane.ERROR_MESSAGE);
                        return;
                    }

                    // Calculation
                    double subtotal = rate * hours;
                    double taxAmt   = subtotal * (tax / 100);
                    double discount = 0;

                    if (chkDiscount.isSelected()) {
                        discount = subtotal * 0.10;
                    }

                    double total = subtotal + taxAmt - discount;

                    // Build Report
                    String report =
                        "Client: " + name + "\n\n" +
                        "Invoice Generator\n" +
                        "Description: Software Development\n" +
                        String.format("Rate: RM%.2f/hr%n", rate) +
                        String.format("      %.0f hrs%n", hours) +
                        String.format("Subtotal: RM%.2f%n", subtotal) +
                        String.format("Tax (%s%%): RM%.2f%n", (int)tax, taxAmt) +
                        (chkDiscount.isSelected()
                            ? String.format("Discount (10%%): -RM%.2f%n", discount)
                            : "") +
                        "----------------------------\n" +
                        String.format("Total Due: RM%.2f%n", total) +
                        "\nThank you for your business!";

                    txtReport.setText(report);

                } catch (NumberFormatException ex) { 
                    JOptionPane.showMessageDialog(frame, "Hourly Rate, Hours Worked and Tax Rate must be numbers!", "Invalid Input", JOptionPane.ERROR_MESSAGE);
                }
            }
        });

        btnClear.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                txtName.setText("");
                txtRate.setText("");
                txtHours.setText("");
                txtTax.setText("");
                chkDiscount.setSelected(false);
                txtReport.setText("[ Invoice report will appear here ]");
            }
        });

        frame.setVisible(true);
    }
}