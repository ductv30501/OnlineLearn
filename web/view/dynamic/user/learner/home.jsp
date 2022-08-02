<%-- 
    Document   : home
    Created on : May 20, 2022, 11:42:51 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Online-Learn</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">


        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 

        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

        <!--link to font awesome cdn-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

    </head>

    <style>
        .page-header{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }
    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#myInput").on("keyup", function () {
                var value = $(this).val().toLowerCase();
                $("#myDIV").filter(function () {
                    $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                });
            });
        });

        $(document).ready(function () {
            $('.image-slider').slick({
                Infinity: false,
                slidesToShow: 4,
                slidesToScroll: 4,
                autoplay: false,
                autoplaySpeed: 3000,
                arrows: true,
                draggable: true,
                prevArrow: "<button type='button' class='slick-prev slick-arrow'><i class='fas fa-arrow-left fa-sm' aria-hidden='true'></i></button>",
                nextArrow: "<button type='button' class='slick-next slick-arrow'><i class='fas fa-arrow-right fa-sm' aria-hidden='true'></i></button>",
                dots: true
            });
        });
    </script>
    <body>
        <div>
            <jsp:include page="header.jsp"></jsp:include>
            </div>
            <div class="container-fluid page-header" style="margin-bottom: 90px;">
                <div class="container">
                    <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                        <h5 class="display-4 text-white text-uppercase">Trang Chủ</h5>
                    </div>
                </div>
            </div>
            <div class="container-fluid">

                <!-- My Courses Start -->
                <div class="container-fluid py-1">
                    <div class="container py-5">
                        <div class="text-center mb-5">
                            <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Khóa Học</h5>
                            <h1>Khóa Học Của Tôi</h1>
                        </div>
                        <div class="row image-slider">

                            <!--load course list-->

                        <c:forEach items = "${requestScope.mycourses}" var ="c">

                            <div 
                                <c:if test="${requestScope.mycourses.size() == 2}" > style="margin-right: 80px;" </c:if>
                                class="col-lg-4 col-md-6 mb-4 image-item">
                                <div class="rounded overflow-hidden mb-2 " style="min-width: 224px;
}" >
                                    <div class="crop">
                                        <img class="img-fluid" src="${c.course.avatar}" alt="" style="min-height: 180px; max-height: 180px;">
                                    </div>
                                    <div class="bg-secondary p-4" style="min-height: 200px; max-height: 200px;">
                                        <div class="d-flex justify-content-between mb-3">
                                            <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${c.course.totalLearner} Học Sinh</small>
                                            <small class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.course.durationText}</small>
                                        </div>
                                        <div style="min-height: 50px; max-height: 50px;  ">
                                            <a  class="h5" href="http://localhost:8080/onlinelearn/course/detail?cid=${c.course.courseId}">${c.course.courseTitle}</a>
                                        </div>
                                        <div class="border-top mt-4 pt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="m-0"><i class="fa fa-star text-primary mr-2"></i>${c.course.rate}  <small>${c.course.durationText}</small></h6>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </c:forEach>


                    </div>
                    <div class="container-btn">
                        <div class="btn-center">
                            <a href="authen/course/mycourse">
                                <!-- HTML !-->
                                <button class="button-17" role="button" onclick="">Xem thêm</button>
                            </a>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--My Courses End -->


        <!--image-slider-->
        <!--image-item-->
        <!-- Category Start -->
        <div id="myDIV" class="container pt-5 pb-3">
            <div class="text-center mb-5">
                <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Chủ Đề</h5>
                <h1>Khám Phá Chủ Đề Nổi Bật</h1>
            </div>
            <div class="row image-slider">
                <!--load course list-->
                <c:forEach var="topic" items="${requestScope.topics}">
                    <div class="col-lg-3 col-md-6 mb-4 image-item">
                        <div class="cat-item position-relative overflow-hidden rounded mb-2">
                            <img class="img-fluid" style="width: 100%; height: 170px;" src="${topic.avatar}" alt="">
                            <a class="cat-overlay text-white text-decoration-none" href="course/bytopic?topicId=${topic.topicId}">
                                <h4 class="text-white font-weight-medium">${topic.topicName}</h4>
                                <span></span>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>



        <!-- Courses Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Khóa Học</h5>
                    <h1>Khóa Học Đang Thịnh Hành</h1>
                </div>

                <div class="row image-slider">

                    <!--load course list-->
                   <c:forEach var="c" items="${requestScope.courses}" begin="0" end="${courses.size()}">
                        <div class="col-lg-4 col-md-6 mb-4 image-item">
                            <div class="rounded overflow-hidden mb-2" >
                                <div class="crop">
                                    <img class="img-fluid" src="${c.avatar}" alt="" style="min-height: 180px; max-height: 180px;">
                                </div>
                                <div class="bg-secondary p-4" style="min-height: 200px; max-height: 200px;">
                                    <div class="d-flex justify-content-between mb-3">
                                        <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${c.totalLearner}</small>
                                        <small class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.durationText}</small>
                                    </div>
                                    <div style="min-height: 50px; max-height: 50px;">
                                    <a class="h5" href="http://localhost:8080/onlinelearn/course/detail?cid=${c.courseId}">${c.courseTitle}</a>
                                    </div>
                                    <div class="border-top mt-4 pt-4">
                                        <div class="d-flex justify-content-between">
                                            <h6 class="m-0"><i class="fa fa-star text-primary mr-2"></i>4.5 <small>(250)</small></h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="container-btn">
                    <div class="btn-center">
                        <a href="course/popular">
                            <!-- HTML !-->
                            <button class="button-17" role="button" onclick="">Xem thêm</button>
                        </a>

                    </div>
                </div>
            </div>
        </div>
        <!-- Courses End -->
        <!-- Blog Start -->
        <div class="container-fluid py-5">
            <div class="container pt-5 pb-3">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Blog</h5>
                    <h1>Blog Mới Nhất</h1>
                </div>
                <div class="row pb-3">
                    <c:forEach items="${requestScope.topBlog}" var="b">
                        <div class="col-lg-4 mb-4">
                            <div class="blog-item position-relative overflow-hidden rounded mb-2">
                                <img class="img-fluid" src="${b.avatar}" alt="">
                                <a class="blog-overlay text-decoration-none" href="http://localhost:8080/onlinelearn/blog/content?pid=${b.blog_id}">
                                    <h5 class="text-white mb-3">${b.blog_title}</h5>
                                    <p>Tháng <fmt:formatDate pattern = "MM,dd yyyy"  value = "${b.public_date}" /></p>
                                </a>
                            </div>
                        </div>

                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- Blog End -->
    </div>

    <div>
        <jsp:include page="../../component/footer.jsp"></jsp:include>
    </div>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
    <script type="text/javascript" src="assets/js/slider.js"></script>




</body>
</html>
