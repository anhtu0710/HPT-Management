<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm lịch hẹn</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
            }

            .form-container {
                max-width: 600px;
                margin: 0 auto;
                background-color: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
            }
        </style>
    </head>
    <body>
        <div class="container mt-5">
            <div class="form-container">
                <h2>Thêm lịch hẹn mới</h2>
                <form action="addAppointment" method="post">
                    <div class="mb-3">
                        <label class="form-label">Tên bệnh nhân:</label>
                        <input type="text" name="namePatient" class="form-control" placeholder="Nhập tên bệnh nhân" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Bác sĩ phụ trách:</label>
                        <select name="doctorId" class="form-select" required>
                            <option disabled selected>-- Chọn bác sĩ --</option>
                            <c:forEach var="doctor" items="${doctorList}">
                                <option value="${doctor.id}">${doctor.fullname}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Ngày & giờ hẹn:</label>
                        <input type="datetime-local" name="appointmentDate" class="form-control" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Lý do khám:</label>
                        <textarea name="reason" class="form-control" rows="3" placeholder="Mô tả lý do..." required></textarea>
                    </div>

                    <div class="d-flex justify-content-between">
                        <button type="submit" class="btn btn-primary">Thêm</button>
                        <a href="admin-appointments" class="btn btn-secondary">Quay lại</a>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
