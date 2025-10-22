package controller;

import dal.DoctorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Doctor;

/**
 * Servlet hiển thị danh sách bác sĩ.
 * Lấy dữ liệu từ DoctorDAO và chuyển tiếp đến manage_doctors.jsp.
 * @author ASUS
 */
public class DoctorListServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     * * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Có thể để trống hoặc thêm logic chung nếu cần.
        // Hiện tại, logic chính đã nằm trong doGet.
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     * Lấy danh sách bác sĩ và hiển thị trên trang quản lý.
     * * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // 1. Khởi tạo Data Access Object
            DoctorDAO dao = new DoctorDAO();
            
            // 2. Lấy danh sách bác sĩ
            List<Doctor> doctorList = dao.getAllDoctor();
            
            // 3. Đặt danh sách vào request attribute
            request.setAttribute("doctorList", doctorList);

            // 4. Chuyển tiếp (Forward) request và response đến trang JSP để hiển thị
            request.getRequestDispatcher("manage_doctors.jsp").forward(request, response);

        } catch (Exception e) {
            // Xử lý lỗi: In lỗi ra console và có thể gửi thông báo lỗi đến người dùng
            e.printStackTrace(); 
            // Tùy chọn: Chuyển hướng đến trang lỗi
            // request.setAttribute("errorMessage", "Không thể tải danh sách bác sĩ.");
            // request.getRequestDispatcher("error.jsp").forward(request, response);
            throw new ServletException("Lỗi khi tải danh sách bác sĩ.", e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     * * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Trong trường hợp này, POST có thể dùng cho việc Thêm/Sửa/Xóa bác sĩ,
        // nhưng hiện tại ta giữ trống.
    }
// </editor-fold>
}