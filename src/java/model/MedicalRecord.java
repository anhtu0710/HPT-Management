/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDateTime;
import java.util.List;

/**
 *
 * @author ASUS
 */
public class MedicalRecord {
    private int id;
    private int appointmentId;
    private String diagnosis;
    private String notes;
    private LocalDateTime createdAt;   // gợi ý thêm cột trong DB (DEFAULT GETDATE())
    private List<Prescriptions> prescriptions; 

    public MedicalRecord(int id, int appointmentId, String diagnosis, String notes, LocalDateTime createdAt, List<Prescriptions> prescriptions) {
        this.id = id;
        this.appointmentId = appointmentId;
        this.diagnosis = diagnosis;
        this.notes = notes;
        this.createdAt = createdAt;
        this.prescriptions = prescriptions;
    }

    public MedicalRecord() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public List<Prescriptions> getPrescriptions() {
        return prescriptions;
    }

    public void setPrescriptions(List<Prescriptions> prescriptions) {
        this.prescriptions = prescriptions;
    }

    @Override
    public String toString() {
        return "MedicalRecord{" + "id=" + id + ", appointmentId=" + appointmentId + ", diagnosis=" + diagnosis + ", notes=" + notes + ", createdAt=" + createdAt + ", prescriptions=" + prescriptions + '}';
    }
    
    
    
    
}
