<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thông tin bác sĩ</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Thông tin Bác sĩ</h2>
            <table class="table table-bordered">
                <tr><th>Họ và tên</th><td>${doctor.fullname}</td></tr>
                <tr><th>Chuyên ngành</th><td>${doctor.specialty}</td></tr>
                <tr><th>Học vị</th><td>${doctor.degree}</td></tr>
                <tr><th>Kinh nghiệm</th><td>${doctor.experienceYears} năm</td></tr>
                <tr><th>Tiểu sử</th><td>${doctor.bio}</td></tr>
                <tr><th>Email</th><td>${user.email}</td></tr>
                <tr><th>Số điện thoại</th><td>${user.phone}</td></tr>
            </table>
            <div class="text-center mt-3">
                <a href="doctorListForPatient" class="btn btn-secondary">Quay lại danh sách</a>
            </div>
        </div>
    </body>
</html>
