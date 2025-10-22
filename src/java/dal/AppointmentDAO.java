package dal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Appointment;
import model.Doctor;
import model.Patients;

public class AppointmentDAO extends DBContext {

    // Lấy tất cả lịch hẹn của một bác sĩ
    public List<Appointment> getAppointmentsByDoctorId(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String sql = "SELECT a.id, a.appointment_date, a.reason, "
                + "p.id as patient_id, u.fullname as patient_name, p.gender, p.dob "
                + "FROM Appointments a "
                + "JOIN Patients p ON a.patient_id = p.id "
                + "JOIN Users u ON p.user_id = u.id "
                + "WHERE a.doctor_id = ? "
                + "ORDER BY a.appointment_date DESC";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Appointment app = new Appointment();
                app.setId(rs.getInt("id"));
                app.setAppointmentDate(rs.getTimestamp("appointment_date"));
                app.setReason(rs.getString("reason"));

                Patients p = new Patients();
                p.setId(rs.getInt("patient_id"));
                p.setFullname(rs.getString("patient_name"));
                p.setGender(rs.getString("gender"));
                p.setDob(rs.getString("dob"));

                app.setPatient(p);
                list.add(app);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Lấy chi tiết lịch hẹn theo ID
    public Appointment getAppointmentById(int appointmentId) {
        String sql = "SELECT a.*, u.fullname as patient_name "
                + "FROM Appointments a "
                + "JOIN Patients p ON a.patient_id = p.id "
                + "JOIN Users u ON p.user_id = u.id "
                + "WHERE a.id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Appointment a = new Appointment();
                a.setId(rs.getInt("id"));
                a.setAppointmentDate(rs.getTimestamp("appointment_date"));
                a.setReason(rs.getString("reason"));

                Patients p = new Patients();
                p.setId(rs.getInt("patient_id"));
                p.setFullname(rs.getString("patient_name"));

                a.setPatient(p);

                Doctor d = new Doctor();
                d.setId(rs.getInt("doctor_id"));
                a.setDoctor(d);

                return a;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật lý do hoặc ngày khám nếu cần (ví dụ xử lý)
    public boolean updateAppointment(Appointment a) {
        String sql = "UPDATE Appointments SET appointment_date = ?, reason = ? WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setTimestamp(1, new Timestamp(a.getAppointmentDate().getTime()));
            stmt.setString(2, a.getReason());
            stmt.setInt(3, a.getId());
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xóa lịch hẹn (tuỳ chọn)
    public boolean deleteAppointment(int id) {
        String sql = "DELETE FROM Appointments WHERE id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Appointment> getAllAppointmentsForAdmin() {
        List<Appointment> list = new ArrayList<>();

        String sql = """
        SELECT 
            a.appointment_date,
            a.reason,
            pu.fullname AS patient_name,
            du.fullname AS doctor_name
        FROM Appointments a
        JOIN Patients p ON a.patient_id = p.id
        JOIN Users pu ON p.user_id = pu.id
        JOIN Doctor d ON a.doctor_id = d.id
        JOIN Users du ON d.user_id = du.id
        ORDER BY a.appointment_date DESC
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                // Tạo Patients
                Patients patient = new Patients();
                patient.setFullname(rs.getString("patient_name"));

                // Tạo Doctor
                Doctor doctor = new Doctor();
                doctor.setFullname(rs.getString("doctor_name"));

                // Tạo Appointment
                Appointment appointment = new Appointment();
                appointment.setAppointmentDate(rs.getTimestamp("appointment_date"));
                appointment.setReason(rs.getString("reason"));
                appointment.setPatient(patient);
                appointment.setDoctor(doctor);

                list.add(appointment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    // Thêm mới lịch hẹn (nếu cần)
    public boolean addAppointment(Appointment a) {
        String sql = "INSERT INTO Appointments (patient_id, doctor_id, appointment_date, reason) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, a.getPatient().getId());
            stmt.setInt(2, a.getDoctor().getId());
            stmt.setTimestamp(3, new Timestamp(a.getAppointmentDate().getTime()));
            stmt.setString(4, a.getReason());
            stmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    

    public static void main(String[] args) {
        AppointmentDAO dao = new AppointmentDAO();

//    // Test lấy lịch hẹn theo doctorId
//    int testDoctorId = 13;  // Đảm bảo tồn tại doctor có id này
//    List<Appointment> appointments = dao.getAppointmentsByDoctorId(testDoctorId);
//    System.out.println("Lịch hẹn của bác sĩ có ID = " + testDoctorId);
//    for (Appointment a : appointments) {
//        System.out.println("ID: " + a.getId() +
//                ", Patient: " + a.getPatient().getFullname() +
//                ", Date: " + a.getAppointmentDate() +
//                ", Reason: " + a.getReason());
//    }
//
//    // Test thêm lịch hẹn mới
//    Appointment newApp = new Appointment();
//    Patients p = new Patients();
//    p.setId(2); // Đảm bảo tồn tại patient có id này
//
//    Doctor d = new Doctor();
//    d.setId(testDoctorId); // Đảm bảo doctor id đúng
//
//    newApp.setPatient(p);
//    newApp.setDoctor(d);
//    newApp.setAppointmentDate(new java.util.Date()); // ❗ QUAN TRỌNG
//    newApp.setReason("Khám tổng quát");
//
//    boolean added = dao.addAppointment(newApp);
//    System.out.println("Thêm mới lịch hẹn: " + (added ? "Thành công" : "Thất bại"));
//
//    // Test cập nhật lịch hẹn
//    if (!appointments.isEmpty()) {
//        Appointment first = appointments.get(0);
//        first.setReason("Cập nhật lý do mới");
//        boolean updated = dao.updateAppointment(first);
//        System.out.println("Cập nhật lịch hẹn: " + (updated ? "Thành công" : "Thất bại"));
//    }
        // Test xóa lịch hẹn nếu muốn
        /*
    boolean deleted = dao.deleteAppointment(5); // Nhập ID cần xóa
    System.out.println("Xóa lịch hẹn: " + (deleted ? "Thành công" : "Thất bại"));
         */
        Appointment a = dao.getAppointmentById(13);
        System.out.println(a.getReason());

    }

}
