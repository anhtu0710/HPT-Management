<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Danh sách bệnh nhân</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/bootstrap.min.css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #3498db;
                --accent-color: #e74c3c;
                --success-color: #27ae60;
                --warning-color: #f39c12;
                --light-bg: #f8f9fa;
                --dark-bg: #2c3e50;
            }

            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .main-container {
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                border-radius: 20px;
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
                padding: 2rem;
                margin: 2rem auto;
                max-width: 1200px;
            }

            .page-header {
                text-align: center;
                margin-bottom: 2rem;
                padding-bottom: 1rem;
                border-bottom: 2px solid var(--secondary-color);
            }

            .page-title {
                color: var(--primary-color);
                font-size: 2.5rem;
                font-weight: 700;
                margin-bottom: 0.5rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.1);
            }

            .page-subtitle {
                color: #6c757d;
                font-size: 1.1rem;
                font-weight: 300;
            }

            .table-container {
                background: white;
                border-radius: 15px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                margin-top: 1rem;
            }

            .table {
                margin-bottom: 0;
                font-size: 0.95rem;
            }

            .table thead th {
                background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
                color: white;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                padding: 1rem 0.75rem;
                border: none;
                position: relative;
                font-size: 0.85rem;
            }

            .table thead th:first-child {
                border-top-left-radius: 15px;
            }

            .table thead th:last-child {
                border-top-right-radius: 15px;
            }

            .table tbody tr {
                transition: all 0.3s ease;
                border-bottom: 1px solid #e9ecef;
            }

            .table tbody tr:hover {
                background: linear-gradient(135deg, #f8f9fa, #e3f2fd);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table tbody td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                border: none;
            }

            .row-number {
                background: linear-gradient(135deg, var(--secondary-color), var(--success-color));
                color: white;
                border-radius: 50%;
                width: 35px;
                height: 35px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
                font-size: 0.85rem;
                margin: 0 auto;
            }

            .patient-name {
                font-weight: 600;
                color: var(--primary-color);
                font-size: 1rem;
            }

            .gender-badge {
                padding: 0.4rem 0.8rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 500;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .gender-male {
                background: linear-gradient(135deg, #3498db, #2980b9);
                color: white;
            }

            .gender-female {
                background: linear-gradient(135deg, #e91e63, #c2185b);
                color: white;
            }

            .contact-info {
                display: flex;
                align-items: center;
                gap: 0.5rem;
                color: var(--primary-color);
            }

            .contact-info i {
                color: var(--secondary-color);
                width: 16px;
            }

            .date-info {
                font-weight: 500;
                color: var(--primary-color);
                font-family: 'Courier New', monospace;
            }

            .address-cell {
                max-width: 200px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
                color: #6c757d;
            }

            .emergency-contact {
                color: var(--accent-color);
                font-weight: 500;
            }

            .stats-container {
                display: flex;
                justify-content: space-around;
                margin-bottom: 2rem;
                gap: 1rem;
            }

            .stat-card {
                background: linear-gradient(135deg, rgba(255, 255, 255, 0.9), rgba(255, 255, 255, 0.7));
                border-radius: 15px;
                padding: 1.5rem;
                text-align: center;
                flex: 1;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
                transition: transform 0.3s ease;
            }

            .stat-card:hover {
                transform: translateY(-5px);
            }

            .stat-number {
                font-size: 2rem;
                font-weight: 700;
                color: var(--secondary-color);
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #6c757d;
                font-weight: 500;
                text-transform: uppercase;
                font-size: 0.9rem;
                letter-spacing: 0.5px;
            }

            .responsive-table {
                overflow-x: auto;
            }

            @media (max-width: 768px) {
                .main-container {
                    margin: 1rem;
                    padding: 1rem;
                }

                .page-title {
                    font-size: 2rem;
                }

                .table {
                    font-size: 0.85rem;
                }

                .table thead th,
                .table tbody td {
                    padding: 0.5rem 0.3rem;
                }

                .stats-container {
                    flex-direction: column;
                    gap: 0.5rem;
                }

                .address-cell {
                    max-width: 100px;
                }
            }

            .loading-animation {
                display: inline-block;
                width: 20px;
                height: 20px;
                border: 3px solid #f3f3f3;
                border-top: 3px solid var(--secondary-color);
                border-radius: 50%;
                animation: spin 1s linear infinite;
            }

            @keyframes spin {
                0% { transform: rotate(0deg); }
                100% { transform: rotate(360deg); }
            }
        </style>
    </head>
    <body>
        <div class="main-container">
            <div class="page-header">
                <h1 class="page-title">
                    <i class="fas fa-user-md"></i> Bệnh nhân của tôi
                </h1>
                <p class="page-subtitle">Quản lý danh sách bệnh nhân một cách hiệu quả</p>
            </div>

            <div class="stats-container">
                <div class="stat-card">
                    <div class="stat-number">
                        <c:set var="patientCount" value="0"/>
                        <c:forEach var="p" items="${patients}">
                            <c:set var="patientCount" value="${patientCount + 1}"/>
                        </c:forEach>
                        ${patientCount}
                    </div>
                    <div class="stat-label">Tổng bệnh nhân</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">
                        <i class="fas fa-chart-line"></i>
                    </div>
                    <div class="stat-label">Theo dõi</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="stat-label">Sức khỏe</div>
                </div>
            </div>

            <div class="table-container">
                <div class="responsive-table">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th><i class="fas fa-hashtag"></i></th>
                                <th><i class="fas fa-user"></i> Họ tên</th>
                                <th><i class="fas fa-venus-mars"></i> Giới tính</th>
                                <th><i class="fas fa-birthday-cake"></i> Ngày sinh</th>
                                <th><i class="fas fa-phone"></i> SĐT</th>
                                <th><i class="fas fa-map-marker-alt"></i> Địa chỉ</th>
                                <th><i class="fas fa-exclamation-triangle"></i> Liên hệ khẩn</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${patients}" varStatus="s">
                                <c:forEach var="u" items="${users}">
                                    <tr>
                                        <td>
                                            <div class="row-number">${s.index + 1}</div>
                                        </td>
                                        <td>
                                            <div class="patient-name">${u.fullname}</div>
                                        </td>
                                        <td>
                                            <span class="gender-badge ${p.gender == 'Nam' ? 'gender-male' : 'gender-female'}">
                                                <i class="fas ${p.gender == 'Nam' ? 'fa-mars' : 'fa-venus'}"></i>
                                                ${p.gender}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="date-info">
                                                <i class="fas fa-calendar-alt"></i>
                                                ${p.dob}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="contact-info">
                                                <i class="fas fa-phone"></i>
                                                <c:out value="${p.phone}"/>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="address-cell" title="${p.address}">
                                                <i class="fas fa-home"></i>
                                                ${p.address}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="emergency-contact">
                                                <i class="fas fa-ambulance"></i>
                                                ${p.emergencyContact}
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>  
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            // Thêm hiệu ứng loading khi hover vào các hàng
            document.querySelectorAll('.table tbody tr').forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px)';
                });
                
                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0)';
                });
            });

            // Thêm tooltip cho địa chỉ dài
            document.querySelectorAll('.address-cell').forEach(cell => {
                if (cell.scrollWidth > cell.clientWidth) {
                    cell.setAttribute('title', cell.textContent);
                }
            });
        </script>
    </body>
</html>