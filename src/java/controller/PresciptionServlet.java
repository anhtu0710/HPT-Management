/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.PrescriptionDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Prescriptions;
import java.sql.SQLException;

/**
 *
 * @author ASUS
 */
public class PresciptionServlet extends HttpServlet {
   
      private PrescriptionDAO dao;

    @Override
    public void init() {
        dao = new PrescriptionDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null || action.equals("list")) {
                listPrescriptions(request, response);
            } else if (action.equals("edit")) {
                showEditForm(request, response);
            } else if (action.equals("delete")) {
                deletePrescription(request, response);
            } else {
                response.sendRedirect("error.jsp"); // fallback
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addPrescription(request, response);
            } else if ("update".equals(action)) {
                updatePrescription(request, response);
            } else {
                response.sendRedirect("error.jsp");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void listPrescriptions(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        String recordIdParam = request.getParameter("recordId");

        if (recordIdParam == null || recordIdParam.isEmpty()) {
            response.sendRedirect("error.jsp");
            return;
        }

        int recordId = Integer.parseInt(recordIdParam);
        List<Prescriptions> list = dao.getByMedicalRecordId(recordId);
        request.setAttribute("prescriptionList", list);
        request.setAttribute("recordId", recordId); // để giữ lại id khi thêm/sửa
        request.getRequestDispatcher("presciption_list.jsp").forward(request, response);
    }

    private void addPrescription(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int medicalRecordId = Integer.parseInt(request.getParameter("medicalRecordId"));
        String medicineName = request.getParameter("medicineName");
        String instructions = request.getParameter("instructions");

        Prescriptions p = new Prescriptions();
        p.setMedicalRecordId(medicalRecordId);
        p.setMedicineName(medicineName);
        p.setInstructions(instructions);

        dao.add(p);
        response.sendRedirect("prescription?action=list&recordId=" + medicalRecordId);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Prescriptions p = dao.getById(id);
        request.setAttribute("prescription", p);
        request.getRequestDispatcher("prescriptionEdit.jsp").forward(request, response);
    }

    private void updatePrescription(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int medicalRecordId = Integer.parseInt(request.getParameter("medicalRecordId"));
        String medicineName = request.getParameter("medicineName");
        String instructions = request.getParameter("instructions");

        Prescriptions p = new Prescriptions();
        p.setId(id);
        p.setMedicalRecordId(medicalRecordId);
        p.setMedicineName(medicineName);
        p.setInstructions(instructions);

        dao.update(p);
        response.sendRedirect("prescription?action=list&recordId=" + medicalRecordId);
    }

    private void deletePrescription(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        int recordId = Integer.parseInt(request.getParameter("recordId"));
        dao.delete(id);
        response.sendRedirect("prescription?action=list&recordId=" + recordId);
    }

}
