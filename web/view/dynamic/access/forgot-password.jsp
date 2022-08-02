<%-- 
    Document   : forgot-password
    Created on : May 21, 2022, 5:28:58 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>TODO supply a title</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="../assets/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
      
        <link rel="stylesheet" href="../assets/css/simple-notify.min.css" />
        <script src="../assets/js/simple-notify.min.js"></script>
        <script src="../js/main.js"></script>
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
            background-image: url("../img/background.jpg");
            background-size: 100% auto;
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
        }
        .wrapper h2{
            position: relative;
            font-size: 22px;
            font-weight: 600;
            color: #333;
            text-transform: uppercase;
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
            margin: 18px 0;
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


    </style>
    <body>

        <div class="wrapper">
            <h2>Quên mật khẩu</h2>
            <form action="forgot" method="post">
                <div class="input-box">
                    <input id="email" name="email" class="email" type="email" onchange="CheckFormatEmail()" placeholder="Nhập email của bạn" required>
                </div>
                <div class="input-box button">
                    <input type="button" onclick="sendEmail()" value="Gửi Email">
                    
                </div>
                <div class="text">
                    <h3><a  href="http://localhost:8080/onlinelearn/login">Đăng nhập</a></h3>
                </div>
            </form>
        </div>
    </body>
    <script>
        function CheckFormatEmail() {
            var email = document.getElementsByClassName('email').value;
            if (!email.match("^[a-zA-Z0-9]+@[a-zA-Z]+(.[a-zA-Z])+$")) {
                alert('Định dạng email không đúng');
                return;
            }
        }
        
        function sendEmail() {
            var email = document.getElementById('email').value;
            var url = "forgot?email=" + email;
            
            fetch(url, {method: "POST"})
                    .then(response => response.json())
                    .then(result => {
                        
                        var notify = result.notify;
                
                        createNotify(notify.type, notify.title, notify.text, notify.autoClose);
                    });
        }
    </script>
</html>
