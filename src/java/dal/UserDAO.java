/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ASUS
 */
public class UserDAO extends DBContext {

    public Users login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                return new Users(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getInt("phone"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);
        }
        return null;
    }

    public Users checkUserExist(String username) {
        String sql = "select * from Users where username = ? ";
        try {

            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                return new Users(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getInt("phone"),
                        rs.getString("role")
                );
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);

        }
        return null;
    }

    public int signup(String username, String password, String fullname, String email, int phone, String gender, String dob, String address) {
        String sqlUser = "INSERT INTO Users (username, password, fullname, email, phone, role) VALUES (?, ?, ?, ?, ?, 'patient')";
        String sqlPatient = "INSERT INTO Patients (user_id, gender, dob, address, phone) VALUES (?, ?, ?, ?, ?)";

        try {
            // Insert vào bảng Users
            PreparedStatement stmtUser = connection.prepareStatement(sqlUser, PreparedStatement.RETURN_GENERATED_KEYS);
            stmtUser.setString(1, username);
            stmtUser.setString(2, password);
            stmtUser.setString(3, fullname);
            stmtUser.setString(4, email);
            stmtUser.setInt(5, phone);
            stmtUser.executeUpdate();

            // Lấy ID vừa tạo
            ResultSet rs = stmtUser.getGeneratedKeys();
            if (rs.next()) {
                int userId = rs.getInt(1);

                // Tiếp tục insert vào bảng Patients
                PreparedStatement stmtPatient = connection.prepareStatement(sqlPatient);
                stmtPatient.setInt(1, userId);
                stmtPatient.setString(2, gender);
                stmtPatient.setString(3, dob);
                stmtPatient.setString(4, address);
                stmtPatient.setInt(5, phone);
                stmtPatient.executeUpdate();

                return userId; // Trả lại userId nếu thành công
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Ghi log lỗi để dễ debug
        }

        return -1; // Trả -1 nếu có lỗi
    }

    public boolean checkUser(String username, String password) {
        String sql = "select * from Users where username = ? and password = ? ";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);

        }
        return false;
    }

    public List<Users> findById(int id) {
        List<Users> list = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE id = ?";
        try (
                PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Users u = new Users();
                u.setId(rs.getInt("id"));
                u.setFullname(rs.getString("fullname"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getInt("phone"));
                list.add(u);
                return list;
            }

        } catch (Exception e) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, e);

        }
        return null;
    }

    public void updateUser(Users u) {
        String sql = "UPDATE Users SET fullname=?, username=?, password=?, email=?, phone=? WHERE id=?";
        try {
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, u.getFullname());
            stmt.setString(2, u.getUsername());
            stmt.setString(3, u.getPassword());
            stmt.setString(4, u.getEmail());
            stmt.setInt(5, u.getPhone());
            stmt.setInt(6, u.getId());
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public Users getUserById(int userId) {
        String sql = "SELECT * FROM Users WHERE id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Users u = new Users();
                    u.setId(rs.getInt("id"));
                    u.setUsername(rs.getString("username"));
                    u.setPassword(rs.getString("password"));
                    u.setEmail(rs.getString("email"));
                    u.setPhone(rs.getInt("phone"));
                    return u;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        List<Users> u = new ArrayList<>();
        UserDAO dao = new UserDAO();
        u = dao.findById(3);
        for (Users users : u) {
            System.out.println(users.getFullname());
        }
    }

}
