<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Thêm Hồ Sơ Bệnh Án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container mt-5">
    <div class="card">
        <div class="card-header bg-info text-white">
            <h4>📝 Thêm Hồ Sơ Bệnh Án</h4>
        </div>
        <div class="card-body">
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>
            <form method="post" action="AddMedicalRecord">
                <input type="hidden" name="appointmentId" value="${appointmentId}" />
                <div class="mb-3">
                    <label class="form-label">Chẩn đoán</label>
                    <input type="text" class="form-control" name="diagnosis" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Ghi chú</label>
                    <textarea class="form-control" name="notes" rows="3"></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Lưu hồ sơ</button>
            </form>
        </div>
    </div>
</div>
</body>
</html>
