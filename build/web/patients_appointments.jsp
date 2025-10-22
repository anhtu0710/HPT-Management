<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đặt lịch khám</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </head>
    <body class="bg-light">
        
        <div class="container mt-5">
            <!-- Thông báo thành công -->
            <c:if test="${not empty successMessage}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill"></i>
                    <strong>Thành công!</strong> ${successMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <!-- Thông báo lỗi -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    <strong>Lỗi!</strong> ${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h4>📅 Đặt lịch khám</h4>
                </div>
                <div class="card-body">
                    <form action="patientApppoimentServlet" method="post">
                        <div class="mb-3">
                            <label for="doctor_id" class="form-label">Chọn bác sĩ</label>
                            <select class="form-select" name="doctor_id" required>
                                <option value="">-- Chọn bác sĩ --</option>
                                <c:forEach var="doctor" items="${doctorList}">
                                    <option value="${doctor.id}">${doctor.fullname}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="mb-3">
                            <label for="appointment_date" class="form-label">Ngày khám</label>
                            <input type="date" class="form-control" name="appointment_date" required>
                        </div>
                        <div class="mb-3">
                            <label for="reason" class="form-label">Triệu chứng</label>
                            <input type="text" class="form-control" name="reason" required>
                        </div>
                        <button type="submit" class="btn btn-success">
                            <i class="bi bi-calendar-check"></i> Xác nhận đặt lịch
                        </button>
                    </form>
                </div>
            </div>
        </div>

        <script>
            // Tự động ẩn thông báo sau 5 giây
            setTimeout(function() {
                const alerts = document.querySelectorAll('.alert');
                alerts.forEach(function(alert) {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                });
            }, 5000);
        </script>
    </body>
</html>