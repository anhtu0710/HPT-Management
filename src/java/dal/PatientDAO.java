/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Patients;
import java.sql.PreparedStatement;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Users;

/**
 *
 * @author LENOVO
 */
public class PatientDAO extends DBContext {

    public void createPatient(int userId, String gender, String dob, String phone, String address) {
        try {
            String sql = "INSERT INTO Patients (user_id, gender, dob, phone, address, emergency_contact) VALUES (?, ?, ?, ?, ?, NULL)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, gender);
            ps.setString(3, dob);
            ps.setString(4, phone);
            ps.setString(5, address);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ArrayList<Patients> getFullPatients() {
        ArrayList<Patients> patientList = new ArrayList<Patients>();
        String sql = """
                     select p.id, p.user_id,u.fullname, u.username, u.password, u.email, 
                     u.phone, p.gender, p.dob , p.address, p.emergency_contact 
                     from Patients p 
                     join Users u on p.user_id=u.id""";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Patients patient = new Patients();
                patient.setId(rs.getInt("id"));
                patient.setUserId(rs.getInt("user_id"));
                patient.setFullname(rs.getString("fullname"));
                patient.setGender(rs.getString("gender"));
                patient.setDob(rs.getString("dob"));
                patient.setPhone(rs.getString("phone"));
                patient.setAddress(rs.getString("address"));
                patient.setEmergencyContact(rs.getString("emergency_contact"));
                Users users = new Users();
                users.setUsername(rs.getString("username"));
                users.setPassword(rs.getString("password"));
                users.setEmail(rs.getString("email"));
                patient.setUsers(users);
                patientList.add(patient);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PatientDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return patientList;
    }

    public List<Patients> getAllPatient() {
        List<Patients> list = new ArrayList<>();
        String sql = "SELECT p.id AS id, u.fullname, p.gender, p.dob "
                + "FROM Patients p "
                + "JOIN Users u ON p.user_id = u.id";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Patients p = new Patients();
                p.setId(rs.getInt("id"));
                p.setFullname(rs.getString("fullname"));
                p.setGender(rs.getString("gender"));
                p.setDob(rs.getString("dob"));

                list.add(p);
            }
        } catch (Exception e) {

        }
        return list;
    }

    public List<Patients> getPatientsByDoctorId(int doctorId) {
        String sql = """
            SELECT DISTINCT p.id              AS p_id,
                            p.gender, p.dob, p.phone           AS p_phone,
                            p.address, p.emergency_contact,
                            u.id               AS u_id,
                            u.fullname, u.email, u.phone       AS u_phone
            FROM   Patients p
                   JOIN Users u        ON p.user_id = u.id
                   JOIN Appointments a ON a.patient_id = p.id
            WHERE  a.doctor_id = ?
        """;

        List<Patients> list = new ArrayList<>();

        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, doctorId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    /* Map Users (phone int) */
                    Users user = new Users();
                    user.setId(rs.getInt("u_id"));
                    user.setFullname(rs.getString("fullname"));
                    user.setEmail(rs.getString("email"));
                    user.setPhone(rs.getInt("u_phone"));   // phone int
                    user.setRole("PATIENT");

                    /* Map Patient */
                    Patients p = new Patients();
                    p.setId(rs.getInt("p_id"));
                    p.setUserId(user.getId());
                    p.setGender(rs.getString("gender"));
                    p.setDob(rs.getString("dob"));
                    p.setPhone(rs.getString("p_phone"));   // cột này đang VARCHAR
                    p.setAddress(rs.getString("address"));
                    p.setEmergencyContact(rs.getString("emergency_contact"));

                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Patients getPatientsById(int id) {
        String sql = "select p.*, u.fullname from Patients p Join Users u On p.user_id = u.id where p.user_id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Patients p = new Patients();
                p.setId(rs.getInt("id"));
                p.setUserId(rs.getInt("user_id"));
                p.setFullname(rs.getString("fullname"));
                p.setGender(rs.getString("gender"));
                return p;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public boolean deletePatient(int id) {
        String getUserId = "SELECT user_id FROM Patients WHERE id = ?";

        String deletePrescriptions = """
        DELETE FROM Prescriptions
        WHERE medical_record_id IN (
            SELECT id FROM MedicalRecord
            WHERE appointment_id IN (
                SELECT id FROM Appointments
                WHERE patient_id = ?
            )
        );
    """;

        String deleteMedicalRecords = """
        DELETE FROM MedicalRecord
        WHERE appointment_id IN (
            SELECT id FROM Appointments
            WHERE patient_id = ?
        );
    """;

        String deleteAppointments = "DELETE FROM Appointments WHERE patient_id = ?;";
        String deleteHospitalizations = "DELETE FROM Hospitalizations WHERE patient_id = ?;";
        String deletePatient = "DELETE FROM Patients WHERE id = ?;";
        String deleteUser = "DELETE FROM Users WHERE id = ?;";

        try {
            int userId = -1;

            // Lấy user_id từ bảng Patients
            try (PreparedStatement stmt = connection.prepareStatement(getUserId)) {
                stmt.setInt(1, id);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    userId = rs.getInt("user_id");
                } else {
                    return false; // Không tìm thấy bệnh nhân
                }
            }

            // Xóa các bản ghi liên quan
            try (PreparedStatement stmt = connection.prepareStatement(deletePrescriptions)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }

            try (PreparedStatement stmt = connection.prepareStatement(deleteMedicalRecords)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }

            try (PreparedStatement stmt = connection.prepareStatement(deleteAppointments)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }

            try (PreparedStatement stmt = connection.prepareStatement(deleteHospitalizations)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }

            // Xóa bệnh nhân khỏi bảng Patients
            try (PreparedStatement stmt = connection.prepareStatement(deletePatient)) {
                stmt.setInt(1, id);
                stmt.executeUpdate();
            }

            // Cuối cùng, xóa user khỏi bảng Users
            try (PreparedStatement stmt = connection.prepareStatement(deleteUser)) {
                stmt.setInt(1, userId);
                stmt.executeUpdate();
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Patients getPatientById(int id) {
        String sql = """
        SELECT p.id, p.user_id, u.fullname, u.username, u.password, u.email,
               u.phone, p.gender, p.dob, p.address, p.emergency_contact
        FROM Patients p
        JOIN Users u ON p.user_id = u.id
        WHERE p.id = ?
    """;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Patients patient = new Patients();
                patient.setId(rs.getInt("id"));
                patient.setUserId(rs.getInt("user_id"));
                patient.setFullname(rs.getString("fullname"));
                patient.setGender(rs.getString("gender"));
                patient.setDob(rs.getString("dob"));
                patient.setPhone(rs.getString("phone"));
                patient.setAddress(rs.getString("address"));
                patient.setEmergencyContact(rs.getString("emergency_contact"));

                Users user = new Users();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getInt("phone"));
                patient.setUsers(user);

                return patient;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePatient(Patients p) {
        String sql = "UPDATE Patients SET gender=?, dob=?, phone=?, address=?, emergency_contact=? WHERE id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, p.getGender());
            stmt.setString(2, p.getDob());
            stmt.setString(3, p.getPhone());
            stmt.setString(4, p.getAddress());
            stmt.setString(5, p.getEmergencyContact());
            stmt.setInt(6, p.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        PatientDAO dao = new PatientDAO();
        List<Patients> list = dao.getAllPatient();
        for (Patients patients : list) {
            System.out.println(patients.getFullname());
        }
    }

}
