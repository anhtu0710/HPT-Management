<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Cập nhật thông tin bệnh nhân</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center mb-4">Cập nhật thông tin bệnh nhân</h2>

    <c:if test="${empty patient}">
        <div class="alert alert-danger">Không tìm thấy thông tin bệnh nhân!</div>
    </c:if>

    <c:if test="${not empty patient}">
        <form action="UpdatePatient" method="post" class="row g-3">

            <input type="hidden" name="id" value="${patient.id}">
            <input type="hidden" name="userId" value="${patient.userId}">

            <div class="col-md-6">
                <label for="fullname" class="form-label">Họ tên</label>
                <input type="text" class="form-control" name="fullname" id="fullname" value="${patient.fullname}" required>
            </div>

            <div class="col-md-6">
                <label for="username" class="form-label">Tên tài khoản</label>
                <input type="text" class="form-control" name="username" id="username" value="${patient.users.username}" required>
            </div>

            <div class="col-md-6">
                <label for="password" class="form-label">Mật khẩu</label>
                <input type="password" class="form-control" name="password" id="password" value="${patient.users.password}" required>
            </div>

            <div class="col-md-6">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" name="email" id="email" value="${patient.users.email}">
            </div>

            <div class="col-md-6">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" name="phone" id="phone" value="${patient.phone}">
            </div>

            <div class="col-md-6">
                <label for="gender" class="form-label">Giới tính</label>
                <select class="form-select" name="gender" id="gender">
                    <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Nam</option>
                    <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Nữ</option>
                </select>
            </div>

            <div class="col-md-6">
                <label for="dob" class="form-label">Ngày sinh</label>
                <input type="date" class="form-control" name="dob" id="dob" value="${patient.dob}">
            </div>

            <div class="col-md-6">
                <label for="address" class="form-label">Địa chỉ</label>
                <input type="text" class="form-control" name="address" id="address" value="${patient.address}">
            </div>

            <div class="col-12">
                <label for="emergencyContact" class="form-label">Người liên hệ khẩn cấp</label>
                <input type="text" class="form-control" name="emergencyContact" id="emergencyContact" value="${patient.emergencyContact}">
            </div>

            <div class="col-12 text-center mt-4">
                <button type="submit" class="btn btn-primary">Cập nhật</button>
                <a href="patientList" class="btn btn-secondary ms-2">Quay lại</a>
            </div>
        </form>
    </c:if>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
