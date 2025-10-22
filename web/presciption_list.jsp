<%-- 
    Document   : prescription_list
    Created on : Jul 8, 2025, 2:15:10 AM
    Author     : Admin
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Prescriptions" %>
<%
    List<Prescriptions> list = (List<Prescriptions>) request.getAttribute("prescriptionList");
    int recordId = (Integer) request.getAttribute("recordId");
%>

<html>
<head>
    <title>Danh sách đơn thuốc</title>
</head>
<body>
<h2>Danh sách đơn thuốc cho hồ sơ bệnh án #<%= recordId %></h2>

<table border="1" cellpadding="8">
    <tr>
        <th>ID</th>
        <th>Tên thuốc</th>
        <th>Chỉ dẫn</th>
        <th>Hành động</th>
    </tr>
    <%
        for (Prescriptions p : list) {
    %>
    <tr>
        <td><%= p.getId() %></td>
        <td><%= p.getMedicineName() %></td>
        <td><%= p.getInstructions() %></td>
        <td>
            <a href="prescription?action=edit&id=<%= p.getId() %>">Sửa</a> |
            <a href="prescription?action=delete&id=<%= p.getId() %>&recordId=<%= recordId %>"
               onclick="return confirm('Bạn có chắc chắn muốn xóa?')">Xóa</a>
        </td>
    </tr>
    <%
        }
    %>
</table>

<br>
<a href="prescriptionAdd.jsp?recordId=<%= recordId %>">+ Thêm đơn thuốc mới</a>
</body>
</html>

