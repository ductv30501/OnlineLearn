<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <title>JSP Page</title>
    </head>
    <style>
        /*@import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');*/
        *{
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            /*font-family: 'Poppins', sans-serif;*/
        }
        body{
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            /*background: #fff;*/

            /*to get background image properties*/
            background-image: url("../img/background.jpg");
            background-size: 100% auto;
            background-repeat: no-repeat;
        }

        nav {
            top: 0;
            margin-top: 25px;
            width: 100%;
            position: fixed;
            /*height: 100px;*/
            background-color: #fff;
            /*border: 1px solid #000;*/

        }

        nav .navContainer {
            width: 95%;
            height: 100%;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        @media only screen and (max-width: 1200px) {
            nav .navContainer {
                width: 100%;
            }
        }

        nav .navContainer .logo {
            color: #111;
            font-size: 25px;
            font-weight: 700;
        }

        @media only screen and (max-width: 730px) {
            nav .navContainer .logo {
                position: relative;
                left: 100px;
            }
        }

        nav .navContainer .logo a {
            text-decoration: none;
            color: #111;
        }

        nav .navContainer .logo a span {
            color: #5071df;
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
            background: #4070f4;
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

        /*this is code of phi*/
        .message {
            /*border: 1px solid #000;*/
            text-align: right;
            color: red;
            font-size: 12px;
            margin: 0px 0px;

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
        .input-box {
            margin-bottom: 100px;
        }

    </style>
    <body>
        <div class="wrapper">
            <h2>Đổi mật khẩu</h2>
            <form action="" method="POST">
                <div class="input-box">
                    <input name="username" type="hidden" placeholder="Tên đăng nhập" value="${requestScope.user.username}">
                    ${requestScope.user.username}
                </div>
                <div class="labels"> Nhập mật khẩu mới</div>
                <div class="input-box">
                    <input class="input-password" name="newpass" type="password" placeholder="Mật khẩu mới" required>
                </div>

                <div class="labels"> Nhập lại mật khẩu mới</div>
                <div class="input-box">
                    <input class="input-password" type="password" onchange="checkPassword()" placeholder="Xác nhận mật khẩu" name="renewpass" required>
                </div>
                <div class="input-box button">
                    <input type="Submit" value="Xác nhận">
                </div>
                <c:if test="${requestScope.message != null}">
                        <p class="message">
                            <i class="fa-solid fa-circle-exclamation"></i>
                            ${requestScope.message}
                        </p>
                    </c:if>
                <div class="text">
                    <h3><a  href="http://localhost:8080/onlinelearn/home">Trang chủ</a></h3>
                </div>
            </form>
          
        </div>
            <script>
                function checkPassword() {
                    var password = document.getElementsByClassName('input-password');
                    if(password[0].value !== password[1].value){
                        alert("Mật khẩu mới mà xác nhận mật khẩu mới không trùng nhau! Vui lòng nhập lại");
                        return ;
                    }
                }
            </script>   
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    </body>
</html>
