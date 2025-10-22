/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.AppointmentDAO;
import dal.DoctorDAO;
import dal.PatientDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.Appointment;
import model.Doctor;
import model.Patients;

/**
 *
 * @author ASUS
 */
public class PatientAppointmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DoctorListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DoctorListServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            DoctorDAO dao = new DoctorDAO();
            List<Doctor> doctorList = dao.getAllDoctor();
            request.setAttribute("doctorList", doctorList);
            request.getRequestDispatcher("patients_appointments.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String doctorId_raw = request.getParameter("doctor_id");
        String dateString = request.getParameter("appointment_date");
        String reason_raw = request.getParameter("reason");

        HttpSession session = request.getSession();

        try {
            int userId = (Integer) session.getAttribute("userId");
            PatientDAO dao1 = new PatientDAO();
            Patients p = dao1.getPatientsById(userId);
            int doctorId = Integer.parseInt(doctorId_raw);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date date = sdf.parse(dateString);
            Appointment a = new Appointment();
            a.setPatient(p);
            a.setAppointmentDate(date);
            a.setReason(reason_raw);
            DoctorDAO dao2 = new DoctorDAO();
            a.setDoctor(dao2.getDoctorByDoctorId(doctorId));
            AppointmentDAO dao3 = new AppointmentDAO();
            boolean isSuccess = dao3.addAppointment(a);

            if (isSuccess) {
                // Đặt lịch thành công
                request.setAttribute("successMessage", "Đặt lịch khám thành công! Chúng tôi sẽ liên hệ với bạn sớm nhất.");
            } else {
                // Đặt lịch thất bại
                request.setAttribute("errorMessage", "Đặt lịch khám thất bại. Vui lòng thử lại!");
            }
        } catch (Exception e) {
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("patients_appointments.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
