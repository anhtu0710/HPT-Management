package dal;

import model.Prescriptions;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDAO extends DBContext{

    public List<Prescriptions> getByMedicalRecordId(int recordId) throws SQLException {
        List<Prescriptions> list = new ArrayList<>();
        String sql = "SELECT * FROM Prescriptions WHERE medical_record_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, recordId);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            Prescriptions p = new Prescriptions();
            p.setId(rs.getInt("id"));
            p.setMedicalRecordId(rs.getInt("medical_record_id"));
            p.setMedicineName(rs.getString("medicine_name"));
            p.setInstructions(rs.getString("instructions"));
            list.add(p);
        }
        return list;
    }

    public void add(Prescriptions p) throws SQLException {
        String sql = "INSERT INTO Prescriptions (medical_record_id, medicine_name, instructions) VALUES (?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, p.getMedicalRecordId());
        ps.setString(2, p.getMedicineName());
        ps.setString(3, p.getInstructions());
        ps.executeUpdate();
    }
    
     public void update(Prescriptions p) throws SQLException {
        String sql = "UPDATE Prescriptions SET medical_record_id = ?, medicine_name = ?, instructions = ? WHERE id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, p.getMedicalRecordId());
        ps.setString(2, p.getMedicineName());
        ps.setString(3, p.getInstructions());
        ps.setInt(4, p.getId());
        ps.executeUpdate();
    }
     
      public void delete(int id) throws SQLException {
        String sql = "DELETE FROM Prescriptions WHERE id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
    }
      
        public Prescriptions getById(int id) throws SQLException {
        String sql = "SELECT * FROM Prescriptions WHERE id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Prescriptions p = new Prescriptions();
            p.setId(rs.getInt("id"));
            p.setMedicalRecordId(rs.getInt("medical_record_id"));
            p.setMedicineName(rs.getString("medicine_name"));
            p.setInstructions(rs.getString("instructions"));
            return p;
        }
        return null;
    }
}
