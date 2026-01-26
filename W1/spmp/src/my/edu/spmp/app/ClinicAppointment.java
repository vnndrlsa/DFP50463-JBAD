package my.edu.spmp.app;

import java.awt.FlowLayout;
import javax.swing.*;

public class ClinicAppointment {

    public static JFrame createBookingFrame() {
        
        JFrame frame = new JFrame("Patient Booking");
        
        JLabel titleLabel = new JLabel("Patient Booking");
        JTextField nameTextField = new JTextField(20);
        JLabel nameLabel = new JLabel("Name");
        
        JTextField phoneTextField = new JTextField(20);
        JLabel phoneLabel = new JLabel("Appointmtalls");
        
        String[] appointments = {"Appointment", "General Checkup", "Dental", "Cardiology"};
        JComboBox<String> appointmentComboBox = new JComboBox<>(appointments);
        
        frame.setSize(400, 250);
        JPanel panel = new JPanel(new FlowLayout(FlowLayout.CENTER, 10, 10));
        
        panel.add(titleLabel);
        panel.add(nameLabel);
        panel.add(nameTextField);
        panel.add(phoneLabel);
        panel.add(phoneTextField);
        panel.add(appointmentComboBox);
        
        frame.add(panel);
        return frame;
    }

    public static void main(String[] args) {
        JFrame frame = createBookingFrame();
        frame.setVisible(true);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
}