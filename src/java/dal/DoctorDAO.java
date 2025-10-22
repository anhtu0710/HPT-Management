/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.util.ArrayList;
import java.util.List;
import model.Doctor;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Users;

/**
 *
 * @author ASUS
 */
public class DoctorDAO extends DBContext {

    public List<Doctor> getAllDoctor() {
        List<Doctor> doctors = new ArrayList<>();
        String sql = """
                     select d.id, d.user_id, u.fullname, u.username, u.password, u.email, u.phone, 
                     d.specialty, d.degree, d.experience_years, d.bio
                     from Doctor d join Users u on d.user_id = u.id""";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Doctor doctor = new Doctor();
                doctor.setId(rs.getInt("id"));
                doctor.setUserId(rs.getInt("user_id"));
                doctor.setFullname(rs.getString("fullname"));
                doctor.setSpecialty(rs.getString("specialty"));
                doctor.setDegree(rs.getString("degree"));
                doctor.setExperienceYears(rs.getInt("experience_years"));
                doctor.setBio(rs.getString("bio"));
                Users users = new Users();
                users.setUsername(rs.getString("username"));
                users.setPassword(rs.getString("password"));
                users.setEmail(rs.getString("email"));
                users.setPhone(rs.getInt("phone"));
                doctor.setUsers(users);
                doctors.add(doctor);
            }
        } catch (Exception e) {
        }
        return doctors;
    }

    public int getDoctorIdByUserId(int userId) {
        String sql = "SELECT id FROM Doctor WHERE user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1; // Không tìm thấy
    }

    public Doctor getDoctorByDoctorId(int doctor_id) {
        String sql = "select * from Doctor where id = ?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setInt(1, doctor_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setUserId(rs.getInt("user_id"));
                d.setFullname(rs.getString("fullname"));
                d.setDegree(rs.getString("degree"));
                d.setBio(rs.getString("bio"));
                d.setExperienceYears(rs.getInt("experience_years"));
                d.setSpecialty(rs.getString("specialty"));
                return d;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static void main(String[] args) {
        List<Doctor> list = new ArrayList<>();
        DoctorDAO d = new DoctorDAO();
        list = d.getAllDoctor();
        for (Doctor doctor : list) {
            System.out.println(doctor);
        }
    }
}
