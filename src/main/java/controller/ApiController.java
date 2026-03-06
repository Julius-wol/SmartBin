package controller;

import dao.ThungRacDAO;
import model.ThungRac;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ApiController", urlPatterns = {"/api-thung-rac"})
public class ApiController extends HttpServlet {

    // GET: Trả về JSON cho trang Dashboard (AJAX gọi mỗi 3 giây)
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        ThungRacDAO dao = new ThungRacDAO();
        ThungRac status = dao.getLatestStatus();

        PrintWriter out = response.getWriter();
        if (status != null) {
            // Trả về JSON khớp với các ID trong file index.jsp
            out.print("{"
                + "\"mucDoDay\":" + status.getMucDoDay() + ","
                + "\"nhietDo\":" + status.getNhietDo() + ","
                + "\"coDongVat\":" + status.isCoDongVat() + ","
                + "\"coChanNo\":" + status.isCoChanNo()
                + "}");
        } else {
            out.print("{}");
        }
        out.flush();
    }

    // POST: Tiếp nhận dữ liệu từ ESP8266/ESP32 gửi lên
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int day = Integer.parseInt(request.getParameter("day"));
            double temp = Double.parseDouble(request.getParameter("temp"));
            boolean animal = Boolean.parseBoolean(request.getParameter("animal"));
            
            // Ngưỡng vật nóng (ví dụ > 50 độ C)
            boolean hot = (temp > 50.0);

            ThungRacDAO dao = new ThungRacDAO();
            dao.insertData(day, temp, animal, hot);

            response.setStatus(HttpServletResponse.SC_OK);
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
        }
    }
}