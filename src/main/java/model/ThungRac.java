package model;

import java.sql.Timestamp;

public class ThungRac {
    private int id;
    private int mucDoDay;
    private double nhietDo;
    private boolean coDongVat;
    private boolean coChanNo;
    private Timestamp thoiGian;

    // Constructor không tham số và có tham số
    public ThungRac() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getMucDoDay() {
        return mucDoDay;
    }

    public void setMucDoDay(int mucDoDay) {
        this.mucDoDay = mucDoDay;
    }

    public double getNhietDo() {
        return nhietDo;
    }

    public void setNhietDo(double nhietDo) {
        this.nhietDo = nhietDo;
    }

    public boolean isCoDongVat() {
        return coDongVat;
    }

    public void setCoDongVat(boolean coDongVat) {
        this.coDongVat = coDongVat;
    }

    public boolean isCoChanNo() {
        return coChanNo;
    }

    public void setCoChanNo(boolean coChanNo) {
        this.coChanNo = coChanNo;
    }

    public Timestamp getThoiGian() {
        return thoiGian;
    }

    public void setThoiGian(Timestamp thoiGian) {
        this.thoiGian = thoiGian;
    }
}
