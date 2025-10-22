/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ASUS
 */
public class Rooms {
    private int id;
    private String roomNumber; // số phòng
    private String typeRoom; // loại phòng: vip hay thường
    private String priceRoom; // giá phòng

    public Rooms() {
    }

    public Rooms(int id, String roomNumber, String typeRoom, String priceRoom) {
        this.id = id;
        this.roomNumber = roomNumber;
        this.typeRoom = typeRoom;
        this.priceRoom = priceRoom;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getTypeRoom() {
        return typeRoom;
    }

    public void setTypeRoom(String typeRoom) {
        this.typeRoom = typeRoom;
    }

    public String getPriceRoom() {
        return priceRoom;
    }

    public void setPriceRoom(String priceRoom) {
        this.priceRoom = priceRoom;
    }
    
    
}
