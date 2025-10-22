<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page pageEncoding="UTF-8" %>
<meta charset="UTF-8">

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                background-color: #f8f9fa;
                height: 100vh;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .login-form {
                width: 100%;
                max-width: 400px;
                background: #ffffff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 5px 8px rgba(0, 0, 0, 0.1), 0 9px 26px rgba(0, 0, 0, 0.1);
            }

            .login-form h3 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }
            
            .ForgetPwd {
                display: block;
                text-align: center;
                margin-top: 10px;
                color: #0062cc;
                font-weight: 600;
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <%
String user = (String) session.getAttribute("username");
if (user != null) {
    response.sendRedirect("home.jsp");
}
        %>
        <div class="login-form">
            <h3>Login</h3>
            <form action="login" method="post">
                <div class="form-group mb-3">
                    <label for="username" class="form-label">Tên đăng nhập</label>
                    <input type="text" name="username" id="username" class="form-control" required>

                </div>
                <div class="form-group mb-3">
                    <label for="password" class="form-label">Mật khẩu</label>
                    <input type="password" name="password" id="password" class="form-control" required>
                </div>
                <div class="form-group mt-4">
                    <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                </div>
                <a href="#" class="ForgetPwd">Forget Password?</a>
            </form>
        </div>
    </body>
</html>


