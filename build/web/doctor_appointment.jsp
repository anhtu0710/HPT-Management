<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Lịch hẹn của bác sĩ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="mb-4">Lịch hẹn của bạn</h2>
            <c:if test="${empty appointments}">
                <div class="alert alert-info">Hiện không có lịch hẹn nào.</div>
            </c:if>
            <a href="addServlet" class="btn btn-sm btn-warning">Thêm</a>
            <c:if test="${not empty appointments}">


                <table class="table table-bordered table-hover">
                    <thead class="table-primary">
                        <tr>
                            <th>#</th>
                            <th>Bệnh nhân</th>
                            <th>Giới tính</th>
                            <th>Ngày sinh</th>
                            <th>Ngày hẹn</th>
                            <th>Lý do</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="a" items="${appointments}" varStatus="loop">
                            <tr>
                                <td>${loop.index + 1}</td>
                                <td>${a.patient.fullname}</td>
                                <td>${a.patient.gender}</td>
                                <td>${a.patient.dob}</td>
                                <td>${a.appointmentDate}</td>
                                <td>${a.reason}</td>
                                <td>
                                    <a href="UpdateServlet?id=${a.id}" class="btn btn-sm btn-warning">Sửa</a>
                                    <a href="deleteAppointment?id=${a.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Xác nhận xóa lịch hẹn này?');">Xóa</a>
                                    <a href="AddMedicalRecord?appointmentId=${a.id}" class="btn btn-info">Thêm hồ sơ bệnh án</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

            </c:if>
        </div>
    </body>
</html>
