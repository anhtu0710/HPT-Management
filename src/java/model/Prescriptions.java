/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Prescriptions {
    private int id; // mã đơn thuốc
    private int medicalRecordId; // gắn với hồ sơ bệnh án 
    private String medicineName; // tên thuốc
    private String instructions; // cách dùng

    public Prescriptions() {
    }

    public Prescriptions(int id, int medicalRecordId, String medicineName, String instructions) {
        this.id = id;
        this.medicalRecordId = medicalRecordId;
        this.medicineName = medicineName;
        this.instructions = instructions;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMedicalRecordId() {
        return medicalRecordId;
    }

    public void setMedicalRecordId(int medicalRecordId) {
        this.medicalRecordId = medicalRecordId;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName;
    }

    public String getInstructions() {
        return instructions;
    }

    public void setInstructions(String instructions) {
        this.instructions = instructions;
    }
    
    
}
