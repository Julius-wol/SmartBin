package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.LichSu;
import model.ThungRac;

public class ThungRacDAO {

    // --- PHẦN 1: NGHIỆP VỤ DASHBOARD (REAL-TIME) ---
    public void insertData(int day, double nhiet, boolean dongVat, boolean chanNo) {
        String query = "INSERT INTO DuLieuSensor (MucDoDay, NhietDo, CoDongVat, CoChanNo) VALUES (?, ?, ?, ?)";
        // Sử dụng try-with-resources để tự động đóng kết nối, tránh leak
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            ps.setInt(1, day);
            ps.setDouble(2, nhiet);
            ps.setBoolean(3, dongVat);
            ps.setBoolean(4, chanNo);
            ps.executeUpdate();

            // Tự động ghi log - Truyền Connection hiện tại vào để dùng chung
            if (dongVat) insertLog(conn, "Phát hiện động vật", "PIR_01", "Đóng nắp & Khóa", "Thành công");
            if (chanNo) insertLog(conn, "Nhiệt độ tăng cao", "DHT22", "Kích hoạt cảnh báo", "Đang xử lý");
            if (day >= 90) insertLog(conn, "Thùng rác đầy", "ULT_04", "Thông báo thu gom", "Thành công");

            System.out.println("Ghi dữ liệu Sensor thành công!");
        } catch (Exception e) {
            System.err.println("Lỗi insertData: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public ThungRac getLatestStatus() {
        String query = "SELECT TOP 1 MucDoDay, NhietDo, CoDongVat, CoChanNo FROM DuLieuSensor ORDER BY ThoiGianCapNhat DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                ThungRac t = new ThungRac();
                t.setMucDoDay(rs.getInt("MucDoDay"));
                t.setNhietDo(rs.getDouble("NhietDo"));
                t.setCoDongVat(rs.getBoolean("CoDongVat"));
                t.setCoChanNo(rs.getBoolean("CoChanNo"));
                return t;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // --- PHẦN 2: NGHIỆP VỤ LỊCH SỬ ---
    
    // Hàm lưu log (Dùng chung Connection từ hàm insertData để tối ưu)
    private void insertLog(Connection conn, String suKien, String sensor, String hanhDong, String trangThai) {
        String query = "INSERT INTO LichSuCanhBao (SuKien, MaSensor, HanhDong, TrangThai) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, suKien);
            ps.setString(2, sensor);
            ps.setString(3, hanhDong);
            ps.setString(4, trangThai);
            ps.executeUpdate();
            System.out.println("Ghi log thành công: " + suKien);
        } catch (Exception e) {
            System.err.println("Lỗi insertLog: " + e.getMessage());
        }
    }

    public List<LichSu> getHistory(String typeFilter) {
        List<LichSu> list = new ArrayList<>();
        String query = "SELECT ThoiGian, SuKien, MaSensor, HanhDong, TrangThai FROM LichSuCanhBao ";

        if (typeFilter != null && !typeFilter.equalsIgnoreCase("ALL")) {
            query += "WHERE SuKien LIKE ? ";
        }
        query += "ORDER BY ThoiGian DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query)) {
            
            if (typeFilter != null && !typeFilter.equalsIgnoreCase("ALL")) {
                ps.setString(1, "%" + typeFilter + "%");
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    LichSu ls = new LichSu();
                    ls.setThoiGian(rs.getTimestamp("ThoiGian"));
                    ls.setSuKien(rs.getString("SuKien"));
                    ls.setMaSensor(rs.getString("MaSensor"));
                    ls.setHanhDong(rs.getString("HanhDong"));
                    ls.setTrangThai(rs.getString("TrangThai"));
                    list.add(ls);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countAnimalDetectedToday() {
        String query = "SELECT COUNT(*) FROM LichSuCanhBao WHERE SuKien LIKE N'%động vật%' "
                + "AND CAST(ThoiGian AS DATE) = CAST(GETDATE() AS DATE)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}