/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.MedicalRecordDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.MedicalRecord;

/**
 *
 * @author ASUS
 */
public class UpdateMedicalRecordServlet extends HttpServlet {

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
            out.println("<title>Servlet UpdateMedicalRecordServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateMedicalRecordServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        MedicalRecordDAO dao = new MedicalRecordDAO();
        MedicalRecord record;
        try {
            record = dao.getById(id);
            if (record != null) {
                req.setAttribute("record", record);
                req.getRequestDispatcher("update_medicalRecord.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Không tìm thấy hồ sơ.");
                req.getRequestDispatcher("home.jsp").forward(req, resp);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UpdateMedicalRecordServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String diagnosis = req.getParameter("diagnosis");
            String notes = req.getParameter("notes");

            MedicalRecord record = new MedicalRecord();
            record.setId(id);
            record.setDiagnosis(diagnosis);
            record.setNotes(notes);

            MedicalRecordDAO dao = new MedicalRecordDAO();
            boolean updated = dao.updateRecord(record);

            if (updated) {
                req.setAttribute("message", "✅ Cập nhật hồ sơ thành công!");
                req.getRequestDispatcher("home.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "❌ Không cập nhật được hồ sơ.");
                doGet(req, resp);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi cập nhật: " + e.getMessage());
            doGet(req, resp);
        }
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
