<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Trang chính - Quản lý Bệnh viện</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c5aa0;
                --secondary-color: #4a90e2;
                --accent-color: #00c851;
                --light-bg: #f8f9fa;
                --card-shadow: 0 8px 25px rgba(0,0,0,0.1);
                --hover-shadow: 0 12px 35px rgba(0,0,0,0.15);
            }

            body {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            .navbar-custom {
                background: linear-gradient(45deg, var(--primary-color), var(--secondary-color)) !important;
                box-shadow: 0 4px 20px rgba(0,0,0,0.1);
                padding: 1rem 0;
                position: relative;
                z-index: 1000;
            }

            .navbar-brand {
                font-weight: bold;
                font-size: 1.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }

            .nav-link {
                font-weight: 500;
                transition: all 0.3s ease;
                margin: 0 0.2rem;
                border-radius: 20px;
                padding: 0.5rem 1rem !important;
            }

            .nav-link:hover {
                background: rgba(255,255,255,0.2);
                transform: translateY(-2px);
            }

            .nav-link.active {
                background: rgba(255,255,255,0.3) !important;
            }

            .main-card {
                background: white;
                border-radius: 20px;
                box-shadow: var(--card-shadow);
                border: none;
                overflow: hidden;
                transition: all 0.3s ease;
            }

            .main-card:hover {
                box-shadow: var(--hover-shadow);
                transform: translateY(-5px);
            }

            .welcome-header {
                background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
                color: white;
                padding: 2rem;
                margin: -1.5rem -1.5rem 2rem -1.5rem;
                position: relative;
            }

            .welcome-header::before {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                right: 0;
                height: 20px;
                background: white;
                border-radius: 20px 20px 0 0;
            }

            .welcome-header h3 {
                margin: 0;
                font-weight: 300;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            }

            .role-badge {
                background: rgba(255,255,255,0.2);
                padding: 0.3rem 1rem;
                border-radius: 20px;
                font-size: 0.9rem;
                margin-top: 0.5rem;
                display: inline-block;
            }

            .feature-list {
                list-style: none;
                padding: 0;
            }

            /* Đã sửa: Thêm style cho các liên kết feature */
            .feature-link {
                display: block;
                background: linear-gradient(45deg, #f8f9ff, #e8f4ff);
                margin: 0.8rem 0;
                padding: 1rem 1.5rem;
                border-radius: 15px;
                border-left: 5px solid var(--secondary-color);
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
                cursor: pointer;
                text-decoration: none;
                color: inherit;
            }

            .feature-link::before {
                content: '';
                position: absolute;
                left: 0;
                top: 0;
                height: 100%;
                width: 0;
                background: linear-gradient(45deg, var(--secondary-color), var(--accent-color));
                transition: width 0.3s ease;
                z-index: 1;
            }

            .feature-link:hover::before {
                width: 5px;
            }

            .feature-link:hover {
                transform: translateX(10px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                text-decoration: none;
                color: inherit;
            }

            .feature-link > * {
                position: relative;
                z-index: 2;
            }

            .feature-icon {
                color: var(--secondary-color);
                margin-right: 0.8rem;
                font-size: 1.2rem;
            }

            .btn-custom {
                border-radius: 25px;
                padding: 0.6rem 1.5rem;
                font-weight: 500;
                transition: all 0.3s ease;
                border: 2px solid transparent;
            }

            .btn-outline-light {
                border: 2px solid rgba(255,255,255,0.5);
            }

            .btn-outline-light:hover {
                background: rgba(255,255,255,0.2);
                border-color: white;
                transform: translateY(-2px);
            }

            .btn-light:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            }

            .user-info {
                background: rgba(255,255,255,0.15);
                padding: 0.5rem 1rem;
                border-radius: 20px;
                margin-right: 1rem;
                backdrop-filter: blur(10px);
            }

            .container {
                position: relative;
                z-index: 100;
            }

            .guest-welcome {
                text-align: center;
                padding: 3rem 2rem;
            }

            .guest-welcome h3 {
                color: var(--primary-color);
                margin-bottom: 1.5rem;
                font-weight: 300;
            }

            .guest-welcome p {
                font-size: 1.1rem;
                color: #666;
                line-height: 1.6;
            }

            .guest-welcome a {
                color: var(--secondary-color);
                text-decoration: none;
                font-weight: 500;
                border-bottom: 2px solid transparent;
                transition: all 0.3s ease;
            }

            .guest-welcome a:hover {
                border-bottom-color: var(--secondary-color);
            }

            .decorative-bg {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                z-index: -1;
                opacity: 0.1;
                background-image:
                    radial-gradient(circle at 20% 50%, white 2px, transparent 2px),
                    radial-gradient(circle at 80% 50%, white 2px, transparent 2px);
                background-size: 100px 100px;
                animation: float 20s ease-in-out infinite;
                pointer-events: none;
            }

            @keyframes float {
                0%, 100% {
                    transform: translateY(0px);
                }
                50% {
                    transform: translateY(-20px);
                }
            }

            .section-title {
                color: var(--primary-color);
                font-weight: 600;
                margin-bottom: 1.5rem;
                position: relative;
                padding-bottom: 0.5rem;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 50px;
                height: 3px;
                background: linear-gradient(45deg, var(--secondary-color), var(--accent-color));
                border-radius: 2px;
            }
        </style>
    </head>
    <body>
        <div class="decorative-bg"></div>

        <c:set var="username" value="${sessionScope.username}" />
        <c:set var="role" value="${sessionScope.role}" />

        <!-- Navbar -->
        <nav class="navbar navbar-expand-lg navbar-dark navbar-custom">
            <div class="container-fluid">
                <a class="navbar-brand" href="#">
                    <i class="fas fa-hospital-alt"></i> Quản lý Bệnh viện
                </a>

                <!-- Toggle button for mobile -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="home.jsp">
                                <i class="fas fa-home"></i> Trang chủ
                            </a>
                        </li>

                        <c:if test="${role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link" href="patientList">
                                    <i class="fas fa-users"></i> Quản lý người dùng
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="doctorList">
                                    <i class="fas fa-user-md"></i> Quản lý bác sĩ
                                </a>
                            </li>
                        </c:if>

                        

                        <c:if test="${role == 'patient'}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/patientApppoimentServlet">
                                    <i class="fas fa-calendar-plus"></i> 
                                    Đặt lịch khám
                                </a>
                            </li>
                        </c:if>
                    </ul>

                    <div class="d-flex align-items-center">
                        <c:choose>
                            <c:when test="${not empty username}">
                                <div class="user-info">
                                    <i class="fas fa-user-circle"></i>
                                    <strong>${username}</strong> (${role})
                                </div>
                                <a href="logout" class="btn btn-outline-light btn-custom">
                                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="login.jsp" class="btn btn-outline-light btn-custom me-2">
                                    <i class="fas fa-sign-in-alt"></i> Đăng nhập
                                </a>
                                <a href="signup.jsp" class="btn btn-light btn-custom">
                                    <i class="fas fa-user-plus"></i> Đăng ký
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </nav>

        <!-- Main content -->
        <div class="container mt-5">
            <div class="main-card p-4">

                <c:choose>
                    <c:when test="${not empty username}">
                        <div class="welcome-header">
                            <h3>
                                <i class="fas fa-hand-peace"></i>
                                Chào mừng <span style="font-weight: bold;">${username}</span>!
                            </h3>
                            <div class="role-badge">
                                <c:choose>
                                    <c:when test="${role == 'admin'}">
                                        <i class="fas fa-crown"></i> Quản trị viên
                                    </c:when>
                                    <c:when test="${role == 'doctor'}">
                                        <i class="fas fa-stethoscope"></i> Bác sĩ
                                    </c:when>
                                    <c:when test="${role == 'patient'}">
                                        <i class="fas fa-user"></i> Bệnh nhân
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-question"></i> ${role}
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <h5 class="section-title">
                            <i class="fas fa-cogs"></i> Chức năng chính
                        </h5>
                        <div class="feature-list">
                            <c:choose>
                                <c:when test="${role == 'admin'}">
                                    <a href="patientList" class="feature-link">
                                        <i class="fas fa-users feature-icon"></i>
                                        Quản lý người dùng
                                    </a>
                                    <a href="doctorList" class="feature-link">
                                        <i class="fas fa-user-md feature-icon"></i>
                                        Quản lý bác sĩ
                                    </a>
                                    <a href="ManageAppointment" class="feature-link">
                                        <i class="fas fa-calendar-check feature-icon"></i>
                                        Quản lý lịch hẹn
                                    </a>
                                </c:when>
                                <c:when test="${role == 'doctor'}">
                                    <a href="doctorAppointment" class="feature-link">
                                        <i class="fas fa-calendar-alt feature-icon"></i>
                                        Xem và xử lý lịch hẹn
                                    </a>
                                    <a href="DoctorPatient" class="feature-link">
                                        <i class="fas fa-user-injured feature-icon"></i>
                                        Xem thông tin bệnh nhân
                                    </a>
                                    <a href="MedicalRecord" class="feature-link">
                                        <i class="fas fa-file-medical feature-icon"></i>
                                        Ghi chú và hồ sơ bệnh án
                                    </a>
                                    
                                </c:when>
                                <c:when test="${role == 'patient'}">
                                    <a href="${pageContext.request.contextPath}/patientApppoimentServlet" class="feature-link">
                                        <i class="fas fa-calendar-plus feature-icon"></i>
                                        Đặt lịch hẹn khám
                                    </a>
                                    <a href="doctorListForPatient" class="feature-link">
                                        <i class="fas fa-info-circle feature-icon"></i>
                                        Xem thông tin bác sĩ
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <div class="feature-link">
                                        <i class="fas fa-question feature-icon"></i>
                                        Không rõ vai trò
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <div class="guest-welcome">
                            <h3>
                                <i class="fas fa-hospital"></i>
                                Chào mừng đến với hệ thống quản lý bệnh viện!
                            </h3>
                            <p>
                                Vui lòng <a href="login.jsp"><i class="fas fa-sign-in-alt"></i> đăng nhập</a> 
                                hoặc <a href="signup.jsp"><i class="fas fa-user-plus"></i> đăng ký</a> 
                                để sử dụng hệ thống.
                            </p>
                        </div>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>