<%-- 
    Document   : home
    Created on : May 20, 2022, 11:42:51 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Online-Learn</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">
        <link href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../../assets/css/style.css" rel="stylesheet">
        <link href="../../assets/img/favicon.ico" rel="icon">
        <!-- Favicon -->
        <link href="../../img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <!--<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">--> 
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="../../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../../css/style.css" rel="stylesheet">
    </head>
    <style>
        .page-header{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(../../assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }
    </style>
    <body>
        <div>
            <jsp:include page="header.jsp"></jsp:include>
            </div>
            <div class="container-fluid page-header" style="margin-bottom: 90px;">
                <div class="container">
                    <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                        <h3 class="display-4 text-white text-uppercase" >Khóa Học Của Tôi</h3>
                        <div class="d-inline-flex text-white">
                            <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Chủ</a></p>
                            <i class="fa fa-angle-double-right pt-1 px-3"></i>
                            <p class="m-0 text-uppercase">Khóa Học Của Tôi</p>
                        </div>
                    </div>
                </div>
            </div>
            <div>
                <!-- Courses Start -->
                <div class="container-fluid py-1">
                    <div class="container py-5">
                        <div class="text-center mb-5">
                            <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Khóa Học</h5>
                            <h1>Khóa Học Của Tôi</h1>
                        </div>
                        <div class ="mb-2 h5" style="font-size: 18px;"><i class="fa fa-award"></i> Các Khóa Học Đã Hoàn Thành</div>
                        <div class="row">
                        <c:if test="${requestScope.listMyCourseDone.size() > 0}" >
                            <c:forEach items = "${requestScope.listMyCourseDone}" var ="c">
                                <div class="col-lg-3 col-md-5 mb-4">
                                    <div class="rounded overflow-hidden mb-2">
                                        <img style ="min-height: 200px;max-height: 250px;"  class="img-fluid" src="${c.course.avatar}" alt="">
                                        <div class="bg-secondary p-2">
                                            <div class="d-flex justify-content-between mb-2">
                                                <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${c.course.totalLearner} Học Sinh</small>
                                                <small class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.totalLearnedTimeAsText}</small>
                                            </div>
                                            <a class="h6" href="http://localhost:8080/onlinelearn/course/detail?cid=${c.course.courseId}">${c.course.courseTitle}</a>

                                            <div class="border-top mt-2 pt-4">
                                                <div class="d-flex justify-content-between mb-2">
                                                    <h6 class="m-0 mr-5"><i class="fa fa-star text-primary ml-2"></i> ${c.course.rate} <small></small></h6>
                                                    <h6 class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.totalLearnedTimeAsText}</h6>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                        </c:if>

                        <c:if test="${requestScope.listMyCourseDone.size() == 0}" >
                            <div style=" color: orange; padding-left: 20px; padding-bottom: 10px;" >
                                Bạn chưa có khóa học đã hoàn thành!
                            </div>
                        </c:if>
                    </div>
                    <div class ="mb-2 h5" style="font-size: 18px;"><i class="fa fa-bookmark"></i> Các Khóa Học Chưa Hoàn Thành</div>
                    <div class="row">

                        <c:if test="${requestScope.InProgressCourse.size() > 0}" >
                            <c:forEach items = "${requestScope.InProgressCourse}" var ="c">
                                <div class="col-lg-3 col-md-5 mb-4">
                                    <div class="rounded overflow-hidden mb-2">
                                        <img style ="min-height: 200px;max-height: 250px;"  class="img-fluid" src="${c.course.avatar}" alt="">
                                        <div class="bg-secondary p-2">
                                            <div class="d-flex justify-content-between mb-2">
                                                <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${c.course.totalLearner} Học Sinh</small>
                                                <small class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.totalLearnedTimeAsText}</small>
                                            </div>
                                            <a class="h6" href="http://localhost:8080/onlinelearn/course/detail?cid=${c.course.courseId}">${c.course.courseTitle}</a>

                                            <div class="border-top mt-2 pt-4">
                                                <div class="d-flex justify-content-between mb-2">
                                                    <h6 class="m-0 mr-5"><i class="fa fa-star text-primary ml-2"></i> ${c.course.rate} <small></small></h6>
                                                    <h6 class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.totalLearnedTimeAsText}</h6>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </c:forEach>
                        </c:if>

                        <c:if test="${requestScope.InProgressCourse.size() == 0}" >
                            <div style=" color: orange; padding-left: 20px; padding-bottom: 10px;" >
                                Không có khóa học nào!
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
            <!-- Courses End -->
            <div>
                <jsp:include page="../../component/footer.jsp"></jsp:include>
            </div>
        </div>
    </body>
    <script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</html>
