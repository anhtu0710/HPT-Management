<%-- 
    Document   : signup
    Created on : Jun 21, 2025, 9:02:34 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign up</title>
        <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet">
        <style>
            body {
                background-color: #f8f9fa;
                height: auto;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .signup-form {
                width: 100%;
                max-width: 400px;
                background: #ffffff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 5px 8px rgba(0, 0, 0, 0.1), 0 9px 26px rgba(0, 0, 0, 0.1);
            }

            .signup-form h3 {
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
}%>
        <div class="signup-form">
            <h3>Sign up</h3>
            <form action="signup" method="post">
                <div class="form-group">
                    <label for="username">Username:</label>
                    <input type="text" name="username" id="username" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">Password:</label>
                    <input type="password" name="password" id="password" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">Repeat Password:</label>
                    <input type="password" name="repassword" id="repassword" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="fullname">Full Name:</label>
                    <input type="text" name="fullname" id="fullname" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="email">Email:</label>
                    <input type="email" name="email" id="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="text" name="phone" id="phone" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="gender">Gender:</label>
                    <select name="gender" id="gender" class="form-control">
                        <option value="Nam">Nam</option>
                        <option value="Nữ">Nữ</option>
                    </select>
                </div>
                <div class="form-group">
                    <label for="dob">Date of Birth:</label>
                    <input type="date" name="dob" id="dob" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="address">Address:</label>
                    <input type="text" name="address" id="address" class="form-control" required>
                </div>
                <% if (request.getAttribute("error") != null) { %>
                <p style="color: red;"><%= request.getAttribute("error") %></p>
                <% } %>

                <div class="form-group mt-4">
                    <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
                </div>
            </form>
        </div>
    </body>
</html>
