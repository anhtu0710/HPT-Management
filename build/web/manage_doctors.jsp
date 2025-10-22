<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Doctors</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h2 class="mt-4 mb-4 text-center">Danh sách Bác sĩ</h2>

            <table class="table table-bordered table-hover">
                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>Họ tên</th>
                        <th>Tên tài khoản</th>
                        <th>Mật khẩu</th>
                        <th>Mail</th>
                        <th>Số điện thoại</th>
                        <th>Chuyên ngành</th>
                        <th>Học vị</th>
                        <th>Kinh nghiệm</th>
                        <th>Giới thiệu</th>


                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="d" items="${doctorList}">
                        <tr>
                            <td>${d.id}</td>
                            <td>${d.fullname}</td>
                            <td>${d.getUsers().getUsername()}</td>
                            <td>${d.getUsers().getPassword()}</td>
                            <td>${d.getUsers().getEmail()}</td>
                            <td>${d.getUsers().getPhone()}</td>
                            <td>${d.specialty}</td>
                            <td>${d.degree}</td>
                            <td>${d.experienceYears} năm</td>
                            <td>${d.bio}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
