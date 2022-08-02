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
        <!--<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">-->
        <!--<link href="assets/css/style.css" rel="stylesheet">-->
    </head>
    <style>
      
        .logo {
            padding-left: 40px;
            box-sizing: border-box;
        }
    </style>
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
    <body>
        <!-- Navbar Start -->
        <div class="container-fluid" style="border-bottom: 1px solid #ccc;">
            <div class="row border-top">
                <div class="col-lg-2 logo">
                    <a href="http://localhost:8080/onlinelearn/home" class="text-decoration-none">
                        <h1 class="m-0"><span class="text-primary">E</span>COURSE</h1>
                    </a>
                </div>
                <div class="col-lg-7" style="padding-left: 90px;" >
                    <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0">

                        <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                            <span class=navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse " id="navbarCollapse">
                            <div class="search-bar">
                                 <form class="search-form d-flex align-items-center explore-layout" method="GET" action="http://localhost:8080/onlinelearn/search">
                                    <input type="search" name="query" onchange="searchQuery()" id="query" placeholder="Search" title="Enter search keyword">
                                    <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                                </form>
                            </div> 
                            <div class="navbar-nav py-0">
                                <a href="http://localhost:8080/onlinelearn/home" class="nav-item nav-link ">Trang chủ</a>
                                <a href="http://localhost:8080/onlinelearn/authen/course/mycourse" class="nav-item nav-link">Khóa học của tôi</a>
                                <!--<a href="http://localhost:8080/onlinelearn/user/package" class="nav-item nav-link">Khóa học đã đăng ký của tôi</a>-->
                                <!--<a href="" class="nav-item nav-link">Giảng viên</a>-->
                                <div class="nav-item dropdown wrapper-blog">
                                    <a href="http://localhost:8080/onlinelearn/blog" class="nav-link">Blog</a>
                                </div>
                                <a href="http://localhost:8080/onlinelearn/pricing" class="nav-item nav-link">Gói ưu đãi</a>
                            </div>
                            <!--<a class="btn btn-primary py-2 px-4 ml-auto d-none d-lg-block" href="http://localhost:8080/onlinelearn/login">Đăng nhập</a>-->
                            <!--<a class="btn btn-primary py-2 px-4 ml-auto d-none d-lg-block" href="http://localhost:8080/onlinelearn/register">Đăng ký</a>-->
                        </div>
                    </nav>
                </div>
                <div class="col-lg-3 " style="padding: 10px 0px 10px 100px;  box-sizing: border-box;">
                    <nav class="header-nav ms-auto">
                        <ul class="d-flex align-items-end">

                            <li style="list-style-type: none;" class="dropdown">

                                <a class="nav-link nav-icon" href="#" data-bs-toggle="dropdown">
                                    <i class="bi bi-bell"></i>
                                    <span class="badge bg-primary badge-number">3</span>
                                </a><!-- End Notification Icon -->

                                <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow notifications">
                                    <li class="dropdown-header">
                                        Bạn có 3 thông báo
                                        <a href="#"><span class="badge rounded-pill  p-2 ms-2">Xem tất cả</span></a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <c:forEach var="x" begin="0" end="2">
                                        <li class="notification-item">
                                            <i class="bi bi-exclamation-circle"></i>
                                            <div>
                                                <h4>Thông báo ${x + 1}</h4>
                                                <p>Nội dung thông báo ${x + 1}</p>
                                                <p>Thời gian ${x + 1}</p>
                                            </div>
                                        </li>

                                        <li>
                                            <hr class="dropdown-divider">
                                        </li>
                                    </c:forEach>
                                    <li class="dropdown-footer">
                                        <a href="#">Show all notifications</a>
                                    </li>

                                </ul><!-- End Notification Dropdown Items -->

                            </li><!-- End Notification Nav -->

                            <li class="nav-item dropdown pe-3">

                                <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                                    <img style="margin-right: 5px;" src="${sessionScope.user.avatar}" alt="Profile" class="rounded-circle">
                                    <span  class="d-none d-md-block dropdown-toggle ps-2">${sessionScope.user.name}</span>
                                </a><!-- End Profile Iamge Icon -->

                                <ul style="width: 230px;" class="dropdown-menu dropdown-menu-end dropdown-menu-arrow ">
                                    <li class="dropdown-header">
                                        <h6>${sessionScope.user.name}</h6>
                                        <span>${sessionScope.userGroup.name}</span>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/authen/course/mycourse">
                                            <i class="bi bi-book"></i>
                                            <span>Khóa học của của tôi</span>
                                        </a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/user/package">
                                            <i class="bi bi-coin"></i>
                                            <span>Lịch sử đăng ký</span>
                                        </a>
                                    </li>
                                   
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/authen/user/profile">
                                            <i class="bi bi-person"></i>
                                            <span>Thông tin cá nhân</span>
                                        </a>
                                    </li>

                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/password/change">
                                            <i class="bi bi-gear"></i>
                                            <span>Đổi mật khẩu</span>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>
                                    
                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/contact">
                                            <i class="bi bi-question-circle"></i>
                                            <span>Liên hệ</span>
                                        </a>
                                    </li>
                                    <li>
                                        <hr class="dropdown-divider">
                                    </li>

                                    <li>
                                        <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/logout">
                                            <i class="bi bi-box-arrow-right"></i>
                                            <span>Đăng xuất</span>
                                        </a>
                                    </li>

                                </ul><!-- End Profile Dropdown Items -->
                            </li><!-- End Profile Nav -->

                        </ul>
                    </nav>
                </div>
            </div>
        </div> 
    </body>
     
</html>
