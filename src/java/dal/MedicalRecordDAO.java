package dal;

import model.MedicalRecord;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MedicalRecordDAO extends DBContext{

     public List<MedicalRecord> getAllRecords() throws SQLException {
        List<MedicalRecord> list = new ArrayList<>();
        String sql = "SELECT * FROM MedicalRecord";
        PreparedStatement ps = connection.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while (rs.next()) {
            MedicalRecord r = new MedicalRecord();
            r.setId(rs.getInt("id"));
            r.setAppointmentId(rs.getInt("appointment_id"));
            r.setDiagnosis(rs.getString("diagnosis"));
            r.setNotes(rs.getString("notes"));
            list.add(r);
        }
        return list;
    }
      

    public MedicalRecord getById(int id) throws SQLException {
        String sql = "SELECT * FROM MedicalRecord WHERE id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            MedicalRecord r = new MedicalRecord();
            r.setId(rs.getInt("id"));
            r.setAppointmentId(rs.getInt("appointment_id"));
            r.setDiagnosis(rs.getString("diagnosis"));
            r.setNotes(rs.getString("notes"));
            return r;
        }
        return null;
    }

    public boolean add(MedicalRecord r) throws SQLException {
        String sql = "INSERT INTO MedicalRecord (appointment_id, diagnosis, notes) VALUES (?, ?, ?)";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, r.getAppointmentId());
        ps.setString(2, r.getDiagnosis());
        ps.setString(3, r.getNotes());
        ps.executeUpdate();
        return true;
    }
    
    public boolean updateRecord(MedicalRecord record) {
    String sql = "UPDATE MedicalRecord SET diagnosis = ?, notes = ? WHERE id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, record.getDiagnosis());
        ps.setString(2, record.getNotes());
        ps.setInt(3, record.getId());
        ps.executeUpdate();
        return true;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    
    public boolean deleteRecord(int id) {
    String sql1 = "DELETE FROM Prescriptions WHERE medical_record_id = ?";
    String sql2 = "DELETE FROM MedicalRecord WHERE id = ?";

    try {
        connection.setAutoCommit(false);

        try (PreparedStatement ps1 = connection.prepareStatement(sql1)) {
            ps1.setInt(1, id);
            ps1.executeUpdate();
        }

        try (PreparedStatement ps2 = connection.prepareStatement(sql2)) {
            ps2.setInt(1, id);
            ps2.executeUpdate();
        }

        connection.commit();
        return true;
    } catch (SQLException e) {
        try { connection.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
        e.printStackTrace();
    } finally {
        try { connection.setAutoCommit(true); } catch (SQLException ex) { ex.printStackTrace(); }
    }
    return false;
}
    
    
}
