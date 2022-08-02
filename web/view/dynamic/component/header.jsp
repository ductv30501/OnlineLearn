<%-- 
    Document   : header
    Created on : May 28, 2022, 9:50:25 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <script src ="js/main.js" ></script>

    </head>
    <style>
        .dropdown-divider {
            margin: 0px;
        }

        
        #search-result {
            position: absolute;
            top: 60px;
            border: 1px solid #ccc;
            padding: 10px;
            max-height: 200px;
            overflow: auto;
            width: 355px;
            display: none;
            z-index: 12;
            background-color: #fff;
            cursor: pointer;
            box-shadow: 1px 1p 1px #ccc;
            border-radius: 3px;
        }
      
    </style>
    <script>
        window.onload = function () {
            var currentUrl = window.location.href;

            var navLinks = document.getElementsByClassName('dropdown-item');
            var navItems = document.getElementsByClassName('my-nav-item');

            // Set nav link active if current url include its url value
            for (var i = 0; i < navLinks.length; i++) {
                var navLink = navLinks[i];
                var url = navLink.href;
                if (currentUrl.includes(url)) {
                    navLink.classList.add("active");
                }
            }

            // Set nav item active if it contains nav-link active
            for (var i = 1; i <= navItems.length; i++) {
                var navItem = navItems[i - 1];
                var navLin = document.getElementsByClassName('nav-link-' + i);
                for (var j = 0; j < navLin.length; j++) {
                    if (navLin[j].classList.contains('active')) {
                        navItem.classList.add("active");
                        break;
                    }
                }
            }

            var navItemHome = document.getElementById('nav-item-home');
            if (currentUrl === 'http://localhost:8080/onlinelearn/home') {
                navItemHome.classList.add("active");
            }

        };

      

    </script>
    <body>
     


        <c:set var="index" value="1" ></c:set>
        <c:set var="groupName" value="${sessionScope.groupName}" ></c:set>
            <!-- Navbar Start -->
            <header class="navbar navbar-expand-md navbar-light d-print-none">
                <div class="container-xl">
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbar-menu">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <h1 class="navbar-brand navbar-brand-autodark d-none-navbar-horizontal pe-0 pe-md-3">
                        <span class="text-primary ">E-</span>COURSE

                    </h1>
                    <div class="navbar-nav flex-row order-md-last">

                        <div class="d-none d-md-flex">
                            <a href="?theme=dark" class="nav-link px-0 hide-theme-dark" title="Enable dark mode" data-bs-toggle="tooltip" data-bs-placement="bottom">
                                <!-- Download SVG icon from http://tabler-icons.io/i/moon -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M12 3c.132 0 .263 0 .393 0a7.5 7.5 0 0 0 7.92 12.446a9 9 0 1 1 -8.313 -12.454z" /></svg>
                            </a>
                            <a href="?theme=light" class="nav-link px-0 hide-theme-light" title="Enable light mode" data-bs-toggle="tooltip" data-bs-placement="bottom">
                                <!-- Download SVG icon from http://tabler-icons.io/i/sun -->
                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><circle cx="12" cy="12" r="4" /><path d="M3 12h1m8 -9v1m8 8h1m-9 8v1m-6.4 -15.4l.7 .7m12.1 -.7l-.7 .7m0 11.4l.7 .7m-12.1 -.7l-.7 .7" /></svg>
                            </a>
                            <div class="nav-item dropdown d-none d-md-flex me-3">
                                <a href="#" class="nav-link px-0" data-bs-toggle="dropdown" tabindex="-1" aria-label="Show notifications">
                                    <!-- Download SVG icon from http://tabler-icons.io/i/bell -->
                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M10 5a2 2 0 0 1 4 0a7 7 0 0 1 4 6v3a4 4 0 0 0 2 3h-16a4 4 0 0 0 2 -3v-3a7 7 0 0 1 4 -6" /><path d="M9 17v1a3 3 0 0 0 6 0v-1" /></svg>
                                    <span class="badge bg-red"></span>
                                </a>
                                <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-end dropdown-menu-card">
                                    <div class="card">
                                        <div class="card-header">
                                            <h3 class="card-title">Thông báo</h3>
                                        </div>
                                        <div class="list-group list-group-flush list-group-hoverable">
                                        <c:forEach begin="0" end="3" var="notification" >
                                            <div class="list-group-item">
                                                <div class="row align-items-center">
                                                    <div class="col-auto"><span class="status-dot status-dot-animated bg-red d-block"></span></div>
                                                    <div class="col text-truncate">
                                                        <a href="#" class="text-body d-block">Thông báo 1</a>
                                                        <div class="d-block text-muted text-truncate mt-n1">
                                                            Nội dung 1 
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <a href="#" class="list-group-item-actions">
                                                            <!-- Download SVG icon from http://tabler-icons.io/i/star -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon text-muted" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><path d="M12 17.75l-6.172 3.245l1.179 -6.873l-5 -4.867l6.9 -1l3.086 -6.253l3.086 6.253l6.9 1l-5 4.867l1.179 6.873z" /></svg>
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </c:forEach>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link d-flex lh-1 text-reset p-0" data-bs-toggle="dropdown" aria-label="Open user menu">
                            <span class="avatar avatar-sm" style="background-image: url(${sessionScope.user.avatar})"></span>
                            <div class="d-none d-xl-block ps-2">
                                <div style="font-weight: bold; display: inline-block; font-size: 12px;">${sessionScope.user.name}</div>
                                <!--<div class="mt-1 small text-muted">${groupName}</div>-->
                            </div>
                        </a>
                        <ul style="width: 230px; padding: 5px;" class="dropdown-menu dropdown-menu-end dropdown-menu-arrow ">
                            <li style="margin-bottom: 5px; " class="dropdown-header">
                                <span style="font-weight: bold; display: inline-block; font-size: 12px;">${sessionScope.user.name}</span> <br />
                                <span>${groupName}</span>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/authen/user/profile">
                                    <i style="margin-right: 10px; padding-top: 4px;" class="bi bi-person"></i>
                                    <span>Thông tin cá nhân</span>
                                </a>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li >
                                <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/password/change">
                                    <i style="margin-right: 10px; padding-top: 4px;" class="bi bi-gear"></i>
                                    <span>Đổi mật khẩu</span>
                                </a>
                            </li>

                            <li>
                                <hr class="dropdown-divider">
                            </li>

                            <li>
                                <a class="dropdown-item d-flex align-items-center" href="http://localhost:8080/onlinelearn/logout">
                                    <i style="margin-right: 10px; padding-top: 4px;" class="bi bi-box-arrow-right"></i>
                                    <span>Đăng xuất</span>
                                </a>
                            </li>

                        </ul><!-- End Profile Dropdown Items -->


                    </div>
                </div>
            </div>
        </header>
        <div class="navbar-expand-md">
            <div class="collapse navbar-collapse" id="navbar-menu">
                <div class="navbar navbar-light">
                    <div class="container-xl">
                        <ul class="navbar-nav">
                            <li class="nav-item" id="nav-item-home">
                                <a class="nav-link" href="http://localhost:8080/onlinelearn/home" >
                                    <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/home -->
                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="5 12 3 12 12 3 21 12 19 12" /><path d="M5 12v7a2 2 0 0 0 2 2h10a2 2 0 0 0 2 -2v-7" /><path d="M9 21v-6a2 2 0 0 1 2 -2h2a2 2 0 0 1 2 2v6" /></svg>
                                    </span>
                                    <span class="nav-link-title">
                                        Trang chủ
                                    </span>
                                </a>
                            </li>
                            <c:if test="${groupName == 'Quản trị nội dung'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý chủ đề
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">

                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/manage/topic/list">
                                                    Danh sách chủ đề
                                                </a>



                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Quản trị nội dung'}" >
                                <li class="nav-item my-nav-item dropdown" >
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý khóa học
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">

                                                <a class="dropdown-item nav-link-${index} " href="http://localhost:8080/onlinelearn/authen/manage/course/list">
                                                    Danh sách khóa học
                                                </a>



                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Quản trị nội dung' || groupName == 'Giảng viên'}" >
                                <li class="nav-item my-nav-item dropdown" >
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý bài kiểm tra
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index} " href="http://localhost:8080/onlinelearn/authen/expert/quiz/list">
                                                    Danh sách bài kiểm tra
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                                    <li class="nav-item my-nav-item dropdown" >
                                        <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                            <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                                <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                            </span>
                                            <span class="nav-link-title">
                                                Quản lý câu hỏi
                                            </span>
                                        </a>
                                        <div class="dropdown-menu">
                                            <div class="dropdown-menu-columns">
                                                <div class="dropdown-menu-column">
                                                    <a class="dropdown-item nav-link-${index} " href="http://localhost:8080/onlinelearn/authen/course/select">
                                                    Danh sách câu hỏi
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Quản trị nội dung'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý phản hồi
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">

                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/feedback/list">
                                                    Danh sách phản hồi
                                                </a>



                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Giảng viên'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý khóa học
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/manage/course/list">
                                                    Danh sách khóa học của tôi
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>

                            </c:if>
                            <c:if test="${groupName == 'Tiếp thị'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý blog
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/marketing/post/list">
                                                    Danh sách blog
                                                </a>

                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Tiếp thị'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý slider
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/manage/slider/list">
                                                    Danh sách slider
                                                </a>

                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>

                            <c:if test="${groupName == 'Admin'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý tài khoản
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/manage/user/list">
                                                    Danh sách tài khoản
                                                </a>
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/manage/feature/list">
                                                    Phân quyền
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Bán hàng'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý đăng ký
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/sale/registration/list">
                                                    Danh sách đăng ký
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                            <c:if test="${groupName == 'Bán hàng'}" >
                                <li class="nav-item my-nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#navbar-base" data-bs-toggle="dropdown" data-bs-auto-close="outside" role="button" aria-expanded="false" >
                                        <span class="nav-link-icon d-md-none d-lg-inline-block"><!-- Download SVG icon from http://tabler-icons.io/i/package -->
                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="12 3 20 7.5 20 16.5 12 21 4 16.5 4 7.5 12 3" /><line x1="12" y1="12" x2="20" y2="7.5" /><line x1="12" y1="12" x2="12" y2="21" /><line x1="12" y1="12" x2="4" y2="7.5" /><line x1="16" y1="5.25" x2="8" y2="9.75" /></svg>
                                        </span>
                                        <span class="nav-link-title">
                                            Quản lý gói ưu đãi
                                        </span>
                                    </a>
                                    <div class="dropdown-menu">
                                        <div class="dropdown-menu-columns">
                                            <div class="dropdown-menu-column">
                                                <a class="dropdown-item nav-link-${index}" href="http://localhost:8080/onlinelearn/authen/manage/package/list">
                                                    Danh sách gói ưu đãi
                                                </a>
                                                <!--                                                <a class="dropdown-item nav-link-${index}" href="./accordion.html">
                                                                                                    Chỉ định khóa học
                                                                                                </a>
                                                -->
                                            </div>
                                        </div>
                                    </div>
                                    <c:set var="index" value="${index + 1}" ></c:set>
                                    </li>
                            </c:if>
                        </ul>
                    </div>
                </div>
            </div>
        </div>


    </body>


</html>
