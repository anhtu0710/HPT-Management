<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Sửa hồ sơ bệnh án</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-white">
            <h4>✏️ Sửa Hồ Sơ Bệnh Án</h4>
        </div>
        <div class="card-body">
            <form method="post" action="UpdateMedicalRecord">
                <input type="hidden" name="id" value="${record.id}" />
                <div class="mb-3">
                    <label class="form-label">Chẩn đoán</label>
                    <input type="text" name="diagnosis" class="form-control" value="${record.diagnosis}" required />
                </div>
                <div class="mb-3">
                    <label class="form-label">Ghi chú</label>
                    <textarea name="notes" class="form-control" rows="4">${record.notes}</textarea>
                </div>
                <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                <a href="home.jsp" class="btn btn-secondary">Hủy</a>
            </form>
        </div>
    </div>
</div>

</body>
</html>
