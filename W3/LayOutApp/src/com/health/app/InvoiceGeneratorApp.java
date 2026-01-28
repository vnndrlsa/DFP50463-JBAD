package com.health.app;

import javax.swing.*;
import java.awt.*;

public class InvoiceGeneratorApp {

    public static void main(String[] args) {
        
        JFrame frame = new JFrame("Invoice Generator");
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setSize(500, 600);
        frame.setLayout(new BorderLayout());
        
        // Top Panel - Input Fields
        JPanel inputPanel = new JPanel(new GridLayout(5, 2, 5, 5));
        
        inputPanel.add(new JLabel("Client Name:"));
        JTextField txtClient = new JTextField();
        inputPanel.add(txtClient);
        
        inputPanel.add(new JLabel("Hourly Rate ($):"));
        JTextField txtRate = new JTextField();
        inputPanel.add(txtRate);
        
        inputPanel.add(new JLabel("Hours Worked:"));
        JSpinner spinHours = new JSpinner(new SpinnerNumberModel(10, 5, 100, 5));
        inputPanel.add(spinHours);
        
        inputPanel.add(new JLabel("Tax Rate (%):"));
        JTextField txtTax = new JTextField();
        inputPanel.add(txtTax);
        
        inputPanel.add(new JLabel(""));
        JCheckBox discountBox = new JCheckBox("Apply 10% Discount");
        inputPanel.add(discountBox);
        
        frame.add(inputPanel, BorderLayout.NORTH);
        
        // Center Panel - Invoice Display
        JTextArea invoiceArea = new JTextArea();
        invoiceArea.setEditable(false);
        JScrollPane scrollPane = new JScrollPane(invoiceArea);
        frame.add(scrollPane, BorderLayout.CENTER);
        
        // Bottom Panel - Buttons
        JPanel buttonPanel = new JPanel(new FlowLayout());
        
        JButton btnGenerate = new JButton("Generate Invoice");
        buttonPanel.add(btnGenerate);
        
        JButton btnClear = new JButton("Clear");
        buttonPanel.add(btnClear);
        
        JButton btnExport = new JButton("Export PDF");
        buttonPanel.add(btnExport);
        
        frame.add(buttonPanel, BorderLayout.SOUTH);
        
        frame.setVisible(true);
    }
}