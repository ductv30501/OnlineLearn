<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Online-Learn</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">


        <!--<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">--> 
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="../assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />


    </head>
    <style>
         .pageheader{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(../assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }
    </style>

    <body>
        <!-- Navbar Start -->
        <div>
            <jsp:include page="../user/guest/header.jsp" ></jsp:include>
            </div>
            <div class="container-fluid pageheader" style="margin-bottom: 90px;">
                <div class="container">
                    <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                        <h3 class="display-4 text-white text-uppercase">Khóa Học Nổi Bật</h3>
                        <div class="d-inline-flex text-white">
                            <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Chủ</a></p>
                            <i class="fa fa-angle-double-right pt-1 px-3"></i>
                            <p class="m-0 text-uppercase">Khóa Học Nổi Bật</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container-fluid py-5">

                <div class="container-fluid py-5">
                    <div class="container py-5">
                        <div class="text-center mb-5">
                            <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Khóa Học</h5>
                            <h1>Khóa Học Nổi Bật</h1>
                        </div>
                        <div class="row">

                       <c:forEach var="course" items="${requestScope.popularCourses}" >
                            <div class="col-md-3 mb-3">
                                <div class="rounded overflow-hidden mb-2">
                                    <img class="img-fluid" src="${course.avatar}" style="min-height: 180px; max-height: 180px;" alt="">
                                    <div class="bg-secondary p-4" style="min-height: 200px; max-height: 200px;">
                                        <div class="d-flex justify-content-between mb-3">

                                            <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${course.totalLearner}</small>

                                        </div>
                                        <div style="min-height: 50px; max-height: 50px;">
                                        
                                        <a class="h5" href="detail?cid=${course.courseId}">${course.courseTitle}</a>
                                        </div>
                                        <div class="border-top mt-4 pt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="m-0"><i class="fa fa-star text-primary mr-2"></i> ${course.rate}</h6>
                                                <h5 class="m-0">${course.rate}</h5>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </c:forEach>

                    </div>
                </div>
            </div>
            <!--My Courses End -->

            <!--<script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>-->
        </div>

        <div>
            <jsp:include page="../component/footer.jsp"></jsp:include>
        </div>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
        <script src="../assets/js/slider.js"></script>
    </body>
</html>