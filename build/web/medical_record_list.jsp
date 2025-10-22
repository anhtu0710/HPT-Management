<%-- 
    Document   : medical_record_list
    Created on : Jul 8, 2025, 2:14:44 AM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.MedicalRecord" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    List<MedicalRecord> records = (List<MedicalRecord>) request.getAttribute("records");
%>
<h2>Danh sách hồ sơ bệnh án</h2>
<table border="1">
    <tr>
        <th>ID</th><th>Appointment ID</th><th>Diagnosis</th><th>Notes</th><th>Prescription</th>
    </tr>
    <c:forEach var="r" items="${records}">
        <tr>
            <td>${r.id}</td>
            <td>${r.appointmentId}</td>
            <td>${r.diagnosis}</td>
            <td>${r.notes}</td>
            <td>
                <a href="Presciption?recordId=${r.id}">Xem thuốc</a>
                <a href="UpdateMedicalRecord?id=${r.id}" class="btn btn-warning btn-sm">Sửa</a>
                <a href="DeleteMedicalRecord?id=${r.id}" 
                   class="btn btn-danger btn-sm"
                   onclick="return confirm('Bạn có chắc chắn muốn xoá hồ sơ bệnh án này?');">
                    Xoá
                </a>
            </td>
        </tr>
    </c:forEach>
</table>