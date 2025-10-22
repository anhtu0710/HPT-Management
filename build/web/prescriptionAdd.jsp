<%-- 
    Document   : prescriptionAdd
    Created on : 16 thg 7, 2025, 16:06:48
    Author     : ASUS
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    int recordId = Integer.parseInt(request.getParameter("recordId"));
%>
<html>
<head>
    <title>Thêm đơn thuốc</title>
</head>
<body>
<h2>Thêm đơn thuốc cho hồ sơ bệnh án #<%= recordId %></h2>

<form action="prescription" method="post">
    <input type="hidden" name="action" value="add">
    <input type="hidden" name="medicalRecordId" value="<%= recordId %>">

    <label>Tên thuốc:</label><br>
    <input type="text" name="medicineName" required><br><br>

    <label>Chỉ dẫn sử dụng:</label><br>
    <textarea name="instructions" rows="4" cols="40" required></textarea><br><br>

    <input type="submit" value="Thêm">
    <a href="prescription?action=list&recordId=<%= recordId %>">Hủy</a>
</form>
</body>
</html>