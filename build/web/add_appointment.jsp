<%-- 
    Document   : add_appointment
    Created on : 1 thg 7, 2025, 23:31:21
    Author     : ASUS
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thêm lịch hẹn</title>
    </head>
    <body>
        <div class="container mt-5">
            <h2>Thêm lịch hẹn</h2>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form action="addServlet" method="post">
                <%-- doctorId từ session, không cần nhập --%>
                <input type="hidden" name="doctorId" value="${sessionScope.doctorId}">

                <div class="mb-3">
                    <label>Bệnh nhân</label>
                    <select name="patientId" class="form-control" required>
                        <option value="">-- Chọn bệnh nhân --</option>
                        <c:forEach var="p" items="${patients}">
                            <option value="${p.id}">${p.fullname} (${p.gender}, ${p.dob})</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mb-3">
                    <label>Ngày hẹn</label>
                    <input type="datetime-local" name="appointmentDate" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label>Lý do</label>
                    <textarea name="reason" class="form-control"></textarea>
                </div>

                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
        </div>
    </body>
</html>
</body>
</html>
