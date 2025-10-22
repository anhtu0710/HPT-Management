<%-- 
    Document   : doctorList
    Created on : Jul 21, 2025, 4:38:02 AM
    Author     : LENOVO
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thông tin Bác sĩ</title>
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
                        <th>Chuyên ngành</th>
                        <th>Học vị</th>
                        <th>Kinh nghiệm</th>
                        <th>Giới thiệu</th>
                        <th>Hành động</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="d" items="${doctorList}">
                        <tr>
                            <td>${d.id}</td>
                            <td>${d.fullname}</td>
                            <td>${d.specialty}</td>
                            <td>${d.degree}</td>
                            <td>${d.experienceYears} năm</td>
                            <td>${d.bio}</td>
                            <td>
                                <a href="doctor-detail?id=${d.id}" class="btn btn-info btn-sm">Xem thông tin</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
