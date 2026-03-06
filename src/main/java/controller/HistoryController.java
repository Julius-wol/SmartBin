package controller;

import dao.ThungRacDAO;
import model.LichSu;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "HistoryController", urlPatterns = {"/lich-su-hoat-dong"})
public class HistoryController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Nhận tham số lọc từ UI (ví dụ: type=DONG_VAT)
        String typeFilter = request.getParameter("type");
        if (typeFilter == null) typeFilter = "ALL";

        ThungRacDAO dao = new ThungRacDAO();
        
        // 2. Lấy danh sách lịch sử theo bộ lọc
        List<LichSu> historyList = dao.getHistory(typeFilter);
        
        // 3. Lấy các số liệu thống kê cho các thẻ Card trên đầu trang
        int animalCount = dao.countAnimalDetectedToday();
        // Bạn có thể bổ sung thêm các hàm lấy nhiệt độ TB, tỷ lệ đầy TB vào DAO
        
        // 4. Đẩy dữ liệu sang trang JSP
        request.setAttribute("historyList", historyList);
        request.setAttribute("animalToday", animalCount);
        request.setAttribute("currentFilter", typeFilter);
        
        request.getRequestDispatcher("history.jsp").forward(request, response);
    }
}