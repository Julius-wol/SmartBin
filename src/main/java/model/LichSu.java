package model;

import java.sql.Timestamp;

public class LichSu {
    private int id;
    private Timestamp thoiGian;
    private String suKien;
    private String maSensor;
    private String hanhDong;
    private String trangThai; // Thành công, Đang xử lý, Thất bại

    public LichSu() {}

    public LichSu(Timestamp thoiGian, String suKien, String maSensor, String hanhDong, String trangThai) {
        this.thoiGian = thoiGian;
        this.suKien = suKien;
        this.maSensor = maSensor;
        this.hanhDong = hanhDong;
        this.trangThai = trangThai;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public Timestamp getThoiGian() { return thoiGian; }
    public void setThoiGian(Timestamp thoiGian) { this.thoiGian = thoiGian; }

    public String getSuKien() { return suKien; }
    public void setSuKien(String suKien) { this.suKien = suKien; }

    public String getMaSensor() { return maSensor; }
    public void setMaSensor(String maSensor) { this.maSensor = maSensor; }

    public String getHanhDong() { return hanhDong; }
    public void setHanhDong(String hanhDong) { this.hanhDong = hanhDong; }

    public String getTrangThai() { return trangThai; }
    public void setTrangThai(String trangThai) { this.trangThai = trangThai; }
}