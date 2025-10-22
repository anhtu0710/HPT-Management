<%-- 
    Document   : prescriptionEdit
    Created on : 16 thg 7, 2025, 16:07:31
    Author     : ASUS
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Prescriptions" %>
<%
    Prescriptions p = (Prescriptions) request.getAttribute("prescription");
%>
<html>
<head>
    <title>Sửa đơn thuốc</title>
</head>
<body>
<h2>Sửa đơn thuốc ID #<%= p.getId() %></h2>

<form action="prescription" method="post">
    <input type="hidden" name="action" value="update">
    <input type="hidden" name="id" value="<%= p.getId() %>">
    <input type="hidden" name="medicalRecordId" value="<%= p.getMedicalRecordId() %>">

    <label>Tên thuốc:</label><br>
    <input type="text" name="medicineName" value="<%= p.getMedicineName() %>" required><br><br>

    <label>Chỉ dẫn sử dụng:</label><br>
    <textarea name="instructions" rows="4" cols="40" required><%= p.getInstructions() %></textarea><br><br>

    <input type="submit" value="Cập nhật">
    <a href="prescription?action=list&recordId=<%= p.getMedicalRecordId() %>">Hủy</a>
</form>
</body>
</html>