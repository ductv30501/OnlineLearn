<%-- 
    Document   : header
    Created on : May 20, 2022, 10:31:18 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>
        .logo {
            padding-top: 12px;
        }
    </style>
    <body>


        <!-- Navbar Start -->
        <div class="container-fluid">
            <div class="row border-top px-xl-5">
                <div class="col-lg-2 d-none d-lg-block logo">
                    <h1 class="m-0"><span class="text-primary ">E</span>COURSE</h1>
                </div>
                <div class="col-lg-10" style="padding-left: 70px;">
                    <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0">
                        <a href="" class="text-decoration-none d-block d-lg-none">
                            <h1 class="m-0"><span class="text-primary">E-</span>LEARN</h1>
                        </a>
                        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                            <div class="navbar-nav py-1 px-4">
                                <a href="http://localhost:8080/onlinelearn/home" class="nav-item nav-link">Trang chủ</a>
                                <a href="http://localhost:8080/onlinelearn/about" class="nav-item nav-link">Về chúng tôi</a>
                                <a href="http://localhost:8080/onlinelearn/course/popular" class="nav-item nav-link">Khóa học</a>
                                <a href="http://localhost:8080/onlinelearn/expert/list" class="nav-item nav-link">Giảng viên</a>
                                <a href="http://localhost:8080/onlinelearn/blog" class="nav-item nav-link">Blog</a>
                                <a href="http://localhost:8080/onlinelearn/pricing" class="nav-item nav-link">Gói ưu đãi</a>
                                <a href="http://localhost:8080/onlinelearn/contact" class="nav-item nav-link">Liên hệ</a>
                            </div>
                            <div class="navbar-nav py-1 px-1">
                                <a style="margin-right: 10px;" class="btn btn-primary py-2 px-4 ml-auto d-none d-lg-block" href="http://localhost:8080/onlinelearn/login">Đăng nhập</a>
                                <a style="margin: 0px;" class="btn btn-primary py-2 px-4 ml-auto d-none d-lg-block" href="http://localhost:8080/onlinelearn/register">Đăng ký</a>
                            </div>

                        </div>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Navbar End -->
    </body>
    <script>
        window.onload = function () {
            var currentUrl = window.location.href;

            var navLinks = document.getElementsByClassName('nav-link');


            for (var i = 0; i < navLinks.length; i++) {
                var navLink = navLinks[i];
                var url = navLink.href;
                if (url === currentUrl) {
                    navLink.classList.add("active");
                }
            }


        };
    </script>
</html>
