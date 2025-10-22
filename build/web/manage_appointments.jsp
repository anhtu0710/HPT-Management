<%-- 
    Document   : manage_appointments
    Created on : Jul 21, 2025, 12:52:01 PM
    Author     : LENOVO
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lý lịch hẹn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Lịch hẹn </h2>
            <a href="addAppointment" class="btn btn-success">Thêm lịch hẹn</a>
            <table class="table table-bordered table-hover">
                <thead class="table-primary">
                    <tr>
                        <th>#</th>
                        <th>Tên bệnh nhân</th>
                        <th>Ngày hẹn</th>
                        <th>Lý do</th>
                        <th>Bác sĩ phụ trách</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="a" items="${appointments}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${a.patient.fullname}</td>
                            <td>${a.appointmentDate}</td>
                            <td>${a.reason}</td>
                            <td>${a.doctor.fullname}</td>
                            <td>
                                <a href="UpdateServlet?id=${a.id}" class="btn btn-sm btn-warning">Sửa</a>
                                <a href="deleteAppointment?id=${a.id}" class="btn btn-sm btn-danger"
                                   onclick="return confirm('Xác nhận xóa lịch hẹn này?');">Xóa</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
