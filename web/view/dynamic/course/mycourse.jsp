<%@page import="model.Course"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Online-Learn</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <!--<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">--> 
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <!--        <link href="../../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">-->

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../../css/style.css" rel="stylesheet">

        <link href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../../assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="../../assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

        <%
            
            ArrayList<Course> myCourses = (ArrayList<Course>) request.getAttribute("mycourses");
            HashMap<String, Integer> myCourseMap = (HashMap<String, Integer>) request.getAttribute("myCourseMap");
        %>
    </head>

    <body>
        <div>


            <!-- Navbar Start -->
            <div class="container-fluid" style="border-bottom: 1px solid #ccc;">
                <div class="row border-top px-xl-0">
                    <!--                                    <div class="col-lg-3 d-none d-lg-block">
                                                            <a class="d-flex align-items-center justify-content-between bg-secondary w-100 text-decoration-none" data-toggle="collapse" href="#navbar-vertical" style="height: 67px; padding: 0 30px;">
                                                                <h5 class="text-primary m-0"><i class="fa fa-book-open mr-2"></i>Subjects</h5>
                                                                <i class="fa fa-angle-down text-primary"></i>
                                                            </a>
                                                            <nav class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 border border-top-0 border-bottom-0 bg-light" id="navbar-vertical" style="width: calc(100% - 30px); z-index: 9;">
                                                                <div class="navbar-nav w-100">
                                                                    <div class="nav-item dropdown">
                                                                        <a href="#" class="nav-link" data-toggle="dropdown">Web Design <i class="fa fa-angle-down float-right mt-1"></i></a>
                                                                        <div class="dropdown-menu position-absolute bg-secondary border-0 rounded-0 w-100 m-0">
                                                                            <a href="" class="dropdown-item">HTML</a>
                                                                            <a href="" class="dropdown-item">CSS</a>
                                                                            <a href="" class="dropdown-item">jQuery</a>
                                                                        </div>
                                                                    </div>
                                                                    <a href="" class="nav-item nav-link">Apps Design</a>
                                                                    <a href="" class="nav-item nav-link">Marketing</a>
                                                                    <a href="" class="nav-item nav-link">Research</a>
                                                                    <a href="" class="nav-item nav-link">SEO</a>
                                                                </div>
                                                            </nav>
                                                        </div>-->
                    <div class="col-lg-3 logo">
                        <a href="" class="text-decoration-none">
                            <h1 class="m-0"><span class="text-primary">E</span>COURSE</h1>
                        </a>
                    </div>



                    <div class="col-lg-7" >
                        <nav class="navbar navbar-expand-lg bg-light navbar-light py-3 py-lg-0 px-0">

                            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                                <div class="search-bar">
                                    <form class="search-form d-flex align-items-center" method="POST" action="#">
                                        <input type="text" name="query" placeholder="Search" title="Enter search keyword">
                                        <button type="submit" title="Search"><i class="bi bi-search"></i></button>
                                    </form>
                                </div><!-- End Search Bar -->
                                <div class="navbar-nav py-0">
                                    <a href="http://localhost:8080/onlinelearn/home" class="nav-item nav-link active">Trang chủ</a>
                                    <a href="http://localhost:8080/onlinelearn/authen/course/list" class="nav-item nav-link">Khóa học của tôi</a>
                                    <!--<a href="" class="nav-item nav-link">Giảng viên</a>-->
                                    <div class="nav-item dropdown">
                                        <a href="" class="nav-link dropdown-toggle" data-toggle="dropdown">Blog</a>
                                        <div class="dropdown-menu rounded-0 m-0">
                                            <a href="" class="dropdown-item">Blog</a>
                                            <a href="single.html" class="dropdown-item">Thông tin blog</a>
                                        </div>
                                    </div>
                                    <a href="http://localhost:8080/onlinelearn/contact" class="nav-item nav-link">Liên hệ</a>
                                </div>
                                <!--<a class="btn btn-primary py-2 px-4 ml-auto d-none d-lg-block" href="http://localhost:8080/onlinelearn/login">Đăng nhập</a>-->
                                <!--<a class="btn btn-primary py-2 px-4 ml-auto d-none d-lg-block" href="http://localhost:8080/onlinelearn/register">Đăng ký</a>-->
                            </div>
                        </nav>
                    </div>
                    <div class="col-lg-2" style="padding: 10px; box-sizing: border-box;">
                        <nav class="header-nav ms-auto">
                            <ul class="d-flex align-items-center">

                                <li style="list-style-type: none;" class="nav-item dropdown">

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
                                        <img style="margin-right: 5px;" src="../../assets/img/profile-img.jpg" alt="Profile" class="rounded-circle">
                                        <span class="d-none d-md-block dropdown-toggle ps-2">${sessionScope.user.name}</span>
                                    </a><!-- End Profile Iamge Icon -->

                                    <ul style="width: 230px;" class="dropdown-menu dropdown-menu-end dropdown-menu-arrow ">
                                        <li class="dropdown-header">
                                            <h6>${sessionScope.user.name}</h6>
                                            <span>${sessionScope.userGroup}</span>
                                        </li>
                                        <li>
                                            <hr class="dropdown-divider">
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
                                            <a class="dropdown-item d-flex align-items-center" href="">
                                                <i class="bi bi-question-circle"></i>
                                                <span>Hỗ trợ</span>
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


            <div class="container-fluid py-5">

                <!-- My Courses Start -->
                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="text-center mb-5">
                            <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Courses</h5>
                            <h1>Khóa học của tôi</h1>
                        </div>
                        <div class="row">

                            <!--load course list-->
                            <% for (Course course : myCourses) {%>
                            <div class="col-md-3">
                                <div class="rounded overflow-hidden mb-2">
                                    <img class="img-fluid" src="../../img/course-1.jpg" alt="">
                                    <div class="bg-secondary p-4">
                                        <div class="d-flex justify-content-between mb-3">

                                            <small class="m-0"><i class="fa fa-users text-primary mr-2"></i><%=myCourseMap.get(course.getCourseId())%></small>

                                        </div>
                                        <a class="h5" href=""><%=course.getCourseTitle()%></a>
                                        <div class="border-top mt-4 pt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="m-0"><i class="fa fa-star text-primary mr-2"></i> <%=course.getRate()%> </h6>
                                                <h5 class="m-0"><%=course.getTopic().getTopicName()%></h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <%}%>

                        </div>
                    </div>
                </div>
                <!--My Courses End -->

                <!--<script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>-->
            </div>

            <div>
                <jsp:include page="../component/footer.jsp"></jsp:include>
            </div>
            <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
            <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
            <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
            <script src="../../assets/js/slider.js"></script>
    </body>
</html>