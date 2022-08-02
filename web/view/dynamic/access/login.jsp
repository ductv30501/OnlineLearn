<%-- 
    Document   : registration
    Created on : May 18, 2022, 9:06:00 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">

        <!--this is font-awesome library added by phi-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link rel="stylesheet" href="assets/css/simple-notify.min.css" />
        <script src="assets/js/simple-notify.min.js"></script>
        <script src="js/main.js"></script>
    </head>
    <style>
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            /*font-family: sans-serif;*/
        }
        body{
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: #fff;
            overflow: hidden;
            /*to get background image properties*/
            background-image: url("img/background.jpg");
            background-size:100% auto;
            background-repeat: no-repeat;
        }

        .wrapper{
            position: relative;
            max-width: 430px;
            width: 100%;
            background: #fff;
            padding: 34px;
            border-radius: 6px;
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
            /*border: 1px solid #000;*/

            /*set blur form and set color for form*/
            /*opacity: 1;*/
            background-color: #FFFFFF;
        }
        .wrapper h2{
            position: relative;
            font-size: 22px;
            font-weight: 600;
            color: #333;
            text-transform: uppercase;

            /*set aline to center*/
            text-align: center;
        }
        .wrapper h2::before{
            content: '';
            position: absolute;
            left: 0;
            bottom: 0;
            height: 3px;
            width: 0px;
            border-radius: 12px;
            background: #4070f4;
        }
        .wrapper form{
            margin-top: 30px;
        }
        .wrapper form .input-box{
            height: 52px;
            margin: 24px 0 18px 0;

        }
        form .input-box input{
            height: 100%;
            width: 100%;
            outline: none;
            padding: 0 15px;
            font-size: 17px;
            font-weight: 400;
            color: #333;
            border: 1.5px solid #C7BEBE;
            border-bottom-width: 2.5px;
            border-radius: 6px;
            transition: all 0.3s ease;
        }
        .input-box input:focus,
        .input-box input:valid{
            border-color: #4070f4;
        }
        form .policy{
            display: flex;
            align-items: center;
        }
        form h3{
            color: #707070;
            font-size: 14px;
            font-weight: 500;
            margin-left: 10px;
        }
        .input-box.button input{
            color: #fff;
            letter-spacing: 1px;
            border: none;
            background: #FF6600;
            cursor: pointer;
        }
        .input-box.button input:hover{
            background: #0e4bf1;
        }

        form .text {
            text-align: center;
        }
        form .text h3{
            color: #333;
            width: 100%;
            text-align: center;
        }
        form .text h3 a{
            color: #4070f4;
            text-decoration: none;
        }
        form .text h3 a:hover{
            text-decoration: underline;
        }

        .logo-wrapper {
            position: fixed;
            top: 110px;
            left: 665px;

        }
        .logo-wrapper h1 a{
            color: #5FCF80;
        }
        .forgotpassword {
            margin-top: 10px;
        }

        /*this is code of phi*/
        .message {
            text-align: right;
            color: red;
            font-size: 14px;
            margin: 2px 6px;

            animation-name: myAnimation;
            animation-duration: 5000ms;
            animation-fill-mode: forwards;
        }

        /*this code to set time exist of messeger alert*/
        @keyframes myAnimation{
            0%{
                opacity: 1;
                transform: rotateX(90deg);
            }
            50%{
                opacity: 0.5;
                transform: rotateX(0deg);
            }
            100%{
                display: none;
                opacity: 0;
                transform: rotateX(90deg);
            }
        }

        .policy input {
            margin-right: 5px;

        }

    </style>
    <body>

        <input type="hidden" id="notification-status" value="${requestScope.notificationStatus}"/>
        <div class="wrapper">
            <h2>Đăng nhập</h2>
            <form id="form-login" name="form-login" action="login" method="post">
                <div class="input-box">
                    <input id="username" name="usernameOrEmail" type="text" placeholder="Tên đăng nhập hoặc Email">              
                </div>
                <div class="input-box">
                    <input id="password" name="password" type="text" placeholder="Mật khẩu">
                </div>
                <div class="policy">
                    <input type="checkbox">
                    <span>Lưu mật khẩu</span>
                </div>

                <!--Đức thêm link phần này-->
                <div class="forgotpassword">
                    <label>Bạn quên mật khẩu?</label>
                    <a href="password/forgot">Quên mật khẩu</a>
                </div>

                <div class="input-box button">
                    <input type="button" onclick="submitForm('form-login')"  value="Đăng nhập">
                </div>


                <div class="text">
                    <h6>Bạn chưa có tài khoản? <a href="http://localhost:8080/onlinelearn/register">Đăng ký</a></h6>
                    <a href="http://localhost:8080/onlinelearn">Trở lại trang chủ</a>
                </div>

            </form>

        </div>


    </body>
    <script>
        var notificationStatus = document.getElementById("notification-status");
        if (notificationStatus.value) {
            createNotify('success', 'Đăng ký thành công', '', false);
        }


        function submitForm(id) {
            var username = document.getElementById('username').value;
            var password = document.getElementById('password').value;
            var form = document.getElementById(id);

            if (username === "" || password === "") {
                createNotify('warning',
                        'Cảnh báo',
                        'Vui lòng nhập tài khoản và mật khảu của bạn',
                        true);
                return;
            }

            var url = "login?usernameOrEmail=" + username + "&password=" + password + "&isCheck=true";
            fetch(url, {method: "POST"}).then(response => response.json())
                    .then(result => {
                        var notifications = result.notifications;
                        if (notifications.length > 0) {
                            for (var i = 0; i < notifications.length; i++) {
                                var notify = notifications[i];
                                createNotify(notify.type, notify.title, notify.text, notify.autoClose);
                            }
                        } else {
                            form.submit();
                        }
                    });
        }


    </script>
</html>
