<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- Giả sử đã import JSTL --%>
        <div class="container mt-5">
            <h2>Chỉnh sửa lịch hẹn</h2>
            <form action="UpdateServlet" method="post">
                <input type="hidden" name="id" value="${appointment.id}">
                <div class="mb-3">
                    <label>Ngày hẹn</label>
                    <input type="text" name="appointmentDate" class="form-control"
                           value="<fmt:formatDate value='${appointment.appointmentDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" required>
                </div>
                <div class="mb-3">
                    <label>Lý do</label>
                    <textarea name="reason" class="form-control">${appointment.reason}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Cập nhật</button>
            </form>

        </div>

    </body>
</html>