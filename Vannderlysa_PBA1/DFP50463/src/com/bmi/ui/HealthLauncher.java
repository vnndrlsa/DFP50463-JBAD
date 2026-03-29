//Vannderlysa Liung Joseph
//20DIT23F2010
//Problem Based Assignment 1

package com.bmi.ui;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;


public class HealthLauncher {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			UIManager.setLookAndFeel(UIManager.getCrossPlatformLookAndFeelClassName());
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		JFrame frame = new JFrame("Health Suite Launcher");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setSize(400,400);
		frame.setLayout(new BorderLayout());

		JLabel title = new JLabel("Health Suite Launcher", JLabel.CENTER);
		title.setFont(new Font("Arial", Font.BOLD, 24));
		frame.add(title, BorderLayout.NORTH);

		JPanel gridPanel = new JPanel(new GridLayout(0, 2, 20, 20));
		gridPanel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));

		JPanel bmiCard = new JPanel(new BorderLayout());
		JLabel bmiIcon = new JLabel(new ImageIcon(new ImageIcon("bmi_icon.png").getImage().getScaledInstance(100, 100, Image.SCALE_SMOOTH)), JLabel.CENTER); // 👈
		JButton bmiBtn = new JButton("Open App");
		bmiBtn.setBackground(new Color(30, 144, 255));

		bmiCard.add(bmiIcon, BorderLayout.CENTER);
		bmiCard.add(bmiBtn, BorderLayout.SOUTH);

		gridPanel.add(bmiCard);

		//WATER APP
		JPanel waterCard = new JPanel(new BorderLayout());
		JLabel waterIcon = new JLabel(new ImageIcon(new ImageIcon("water_icon.png").getImage().getScaledInstance(100, 100, Image.SCALE_SMOOTH)), JLabel.CENTER); // 👈
		JButton waterBtn = new JButton("Open App");
		waterBtn.setBackground(new Color(30, 144, 255));

		waterCard.add(waterIcon, BorderLayout.CENTER);
		waterCard.add(waterBtn, BorderLayout.SOUTH);

		gridPanel.add(waterCard);


		frame.add(gridPanel, BorderLayout.CENTER);
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);

		//CALORIE APP
		JPanel calorieCard = new JPanel(new BorderLayout());
		JLabel calorieIcon = new JLabel(new ImageIcon(new ImageIcon("calorie_icon.png").getImage().getScaledInstance(100, 100, Image.SCALE_SMOOTH)), JLabel.CENTER); // 👈
		JButton calorieBtn = new JButton("Open App");
		calorieBtn.setBackground(new Color(30, 144, 255));

		calorieCard.add(calorieIcon, BorderLayout.CENTER);
		calorieCard.add(calorieBtn, BorderLayout.SOUTH);

		gridPanel.add(calorieCard);


		frame.add(gridPanel, BorderLayout.CENTER);
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);

		//SLEEP APP
		JPanel sleepCard = new JPanel(new BorderLayout());
		JLabel sleepIcon = new JLabel(new ImageIcon(new ImageIcon("sleep_icon.png").getImage().getScaledInstance(100, 100, Image.SCALE_SMOOTH)), JLabel.CENTER); // 👈
		JButton sleepBtn = new JButton("Open App");
		sleepBtn.setBackground(new Color(30, 144, 255));

		sleepCard.add(sleepIcon, BorderLayout.CENTER);
		sleepCard.add(sleepBtn, BorderLayout.SOUTH);

		gridPanel.add(sleepCard);

		bmiBtn.addActionListener(new ActionListener() {

			@Override
			public void actionPerformed(ActionEvent e) {
				// TODO Auto-generated method stub
				BMI_Calculator.main(null);
			}
		});

		frame.add(gridPanel, BorderLayout.CENTER);
		frame.setLocationRelativeTo(null);
		frame.setVisible(true);


	}

}