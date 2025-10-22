<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Patients</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">
            <h2 class="mt-4 mb-4 text-center">Danh sách bệnh nhân</h2>            

                <table class="table table-bordered table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Họ tên</th>
                            <th>Tên tài khoản</th>
                            <th>Mật khẩu</th>
                            <th>Email</th>
                            <th>Điện thoại</th>
                            <th>Giới tính</th>
                            <th>Ngày sinh</th>                            
                            <th>Địa chỉ</th>
                            <th>Người liên hệ khẩn cấp</th>
                            <th>Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${patientList}" var="p">
                            <tr>
                                <td>${p.id}</td>
                                <td>${p.fullname}</td> 
                                <td>${p.getUsers().getUsername()}</td>
                                <td>${p.getUsers().getPassword()}</td>
                                <td>${p.getUsers().getEmail()}</td>                                
                                <td>${p.phone}</td>
                                <td>${p.gender}</td>
                                <td>${p.dob}</td>
                                <td>${p.address}</td>
                                <td>${p.emergencyContact}</td>
                                <td>
                                    <a href="UpdatePatient?id=${p.id}" class="btn btn-sm btn-warning">Sửa</a>
                                    <a href="DeletePatient?id=${p.id}" class="btn btn-sm btn-danger"
                                       onclick="return confirm('Xác nhận xóa bệnh nhân?');">Xóa</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>