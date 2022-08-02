<%-- 
    Document   : guest
    Created on : May 20, 2022, 10:15:07 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.io.OutputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>ECourse - Trang Chủ</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Favicon -->
        <link href="assets/img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>
    <style>
        /*        .crop{
                    height: 150px;
                    width: 500px;
                    overflow: hidden;
                }
                .crop img{
                    width: 100%;
                    height: auto;
                    position: relative;
                    top: 50%;
                    -webkit-transform: translateY(-50%);  Ch <36, Saf 5.1+, iOS < 9.2, An =<4.4.4 
                    -ms-transform: translateY(-50%);  IE 9 
                    transform: translateY(-50%);  IE 10, Fx 16+, Op 12.1+ 
                }*/

        .crop img {
            width:  450px;
            height: 200px;
        }
      

    </style>

    <body>
        <div>
            <jsp:include page="../guest/header.jsp"></jsp:include>
            </div>
           

            <!-- Carousel Start -->
            <div class="container-fluid p-0 pb-5 mb-5">
                <div id="header-carousel" class="carousel slide carousel-fade" data-ride="carousel">
                    <ol class="carousel-indicators">
                    <c:if test="${requestScope.sliders.size() > 0}" >
                         <c:forEach var="index" begin="0" end="${requestScope.sliders.size() - 1}" >
                        <li data-target="#header-carousel" data-slide-to="${index}" class="${index==0?"active":""}" ></li>
                        </c:forEach>
                    </c:if>
                </ol>
                <div class="carousel-inner">
                    <c:set var="index" value="0" ></c:set>
                    <c:forEach var="slider" items="${requestScope.sliders}" >
                        <div class="carousel-item ${index == 0?"active":""} " style="min-height: 300px; max-height: 800px;">
                            <img class="position-relative w-100" src="${slider.avatar}" style="min-height: 300px; object-fit: cover;">
                            <div class="carousel-caption d-flex align-items-center justify-content-center">
                                <div class="p-5" style="width: 100%; max-width: 900px;">
                                    <h5 class="text-white text-uppercase mb-md-3">${slider.sliderTitle}</h5>
                                    <h1 class="display-3 text-white mb-md-4">${slider.sliderContent}</h1>
                                    <a href="" class="btn btn-primary py-md-2 px-md-4 font-weight-semi-bold mt-2">Tìm hiểu thêm</a>
                                </div>
                            </div>
                        </div>
                        <c:set var="index" value="${index + 1}" ></c:set>
                    </c:forEach>

                </div>
            </div>
        </div>
        <!-- Carousel End -->


        <!-- About Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="row align-items-center">
                    <div class="col-lg-5">
                        <img class="img-fluid rounded mb-4 mb-lg-0" src="assets/img/about.jpg" alt="">
                    </div>
                    <div class="col-lg-7">
                        <div class="text-left mb-4">
                            <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;"s>VỀ CHÚNG TÔI</h5>
                            <h1>Cách Học Sáng Tạo</h1>
                        </div>
                        <p>Học trực tuyến đã trở thành xu hướng phồ biến trên khắp thế giới
                            hiện nay. Để hội nhập với xu hướng hiện nay, hệ thống học trực tuyến Ecourses
                            được tạo ra nhằm đem đến cho học viên những trải nghiệm tốt nhất.
                            Học viên có thể chủ động về thời gian học và học bất cứ đâu, bởi đa phần các bài học của Ecourses đều
                            được quay bằng video và học viên có thể theo dõi hàng chục lần cho đến khi nào
                            hiểu được bài giảng. Nếu học viên có trở ngại về mặt ngôn ngữ Ecourses sẽ giúp giải quyết
                            được vấn đề đó. Khi tham gia hệ thống, Ecourses sẽ luôn luôn lắng nghe để đem đến cho học viên một trải nghiệm tốt nhất!

                        </p>
                        <a href="" class="btn btn-primary py-md-2 px-md-4 font-weight-semi-bold mt-2">Tìm hiểu thêm</a>
                    </div>
                </div>
            </div>=
        </div>
        <!-- About End -->


        <!-- Category Start -->
        <div class="container-fluid py-5">
            <div class="container pt-5 pb-3">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;" >Chủ Đề</h5>
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
        </div>
        <!-- Category Start -->


        <!-- Courses Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Khóa Học</h5>
                    <h1>Khóa Học Nổi Bật</h1>
                </div>
                <div class="row image-slider">
                    <!--load course list-->
                    <c:forEach var="c" items="${requestScope.courses}" begin="0" end="${courses.size()}">
                        <div class="col-lg-4 col-md-6 mb-4 image-item">
                            <div class="rounded overflow-hidden mb-2">
                                <div class="crop">
                                    <img class="img-fluid" src="${c.avatar}" style="min-height: 180px; max-height: 180px;" alt="">
                                </div>
                                <div class="bg-secondary p-4" style="min-height: 200px; max-height: 200px;">
                                    <div class="d-flex justify-content-between mb-3">
                                        <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${c.totalLearner}</small>
                                        <small class="m-0"><i class="far fa-clock text-primary mr-2"></i>${c.durationText}</small>
                                    </div>
                                    <div style="min-height: 50px; max-height: 50px;">
                                     <a  class="h5" href="course/detail?cid=${c.courseId}">${c.courseTitle}</a>
                                    </div>
                                    <div class="border-top mt-4 pt-4">
                                        <div class="d-flex justify-content-between">
                                            <h6 class="m-0"><i class="fa fa-star text-primary mr-2"></i>${c.rate} <small>(${c.totalLearner})</small></h6>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- Courses End -->


        <!-- Registration Start -->
        <div class="container-fluid bg-registration py-5" style="margin: 90px 0;">
            <div class="container py-5">
                <div class="row align-items-center">
                    <div class="col-lg-7 mb-5 mb-lg-0">
                        <div class="mb-4">
                            <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Bất Kỳ Khóa Học Nào</h5>
                            <h1 class="text-white">Giảm giá 30% cho sinh viên mới</h1>
                        </div>
                        <p class="text-white">
                            ECourses hệ thống học trực tuyến luôn mong muốn học viên có trải nghiệm tốt nhất
                            và thực sụ thoải mái khi tham gia các khóa học. Nếu bạn là học viên mới hãy tham gia ngay để được
                            hưởng ưu đãi 30% khi đăng ký các khóa học, chương trình học tại đây!

                        </p>
                        <ul class="list-inline text-white m-0">
                            <li class="py-2"><i class="fa fa-check text-primary mr-3"></i>Các giảng viên có nhiều kinh nghiệm giảng </li>
                            <li class="py-2"><i class="fa fa-check text-primary mr-3"></i>Các Khóa học được hệ thống bài bản</li>
                            <li class="py-2"><i class="fa fa-check text-primary mr-3"></i>Nhiều ưu đãi khi trở thành học viên của ECourses</li>
                        </ul>
                    </div>
                    <div class="col-lg-5">
                        <div class="card border-0">
                            <div class="card-header bg-light text-center p-4">
                                <h1 class="m-0">Đăng Ký Ngay</h1>
                            </div>
                            <div class="card-body rounded-bottom bg-primary p-5">
                                <form>
                                    <div class="form-group">
                                        <input type="text" class="form-control border-0 p-4" placeholder="Họ và tên" required="required" />
                                    </div>
                                    <div class="form-group">
                                        <input type="text" class="form-control border-0 p-4" placeholder="Tên đăng nhập" required="required" />
                                    </div>
                                    <div class="form-group">
                                        <input type="email" class="form-control border-0 p-4" placeholder="Email" required="required" />
                                    </div>
                                    <!--                                    <div class="form-group">
                                                                            <select class="custom-select border-0 px-4" style="height: 47px;">
                                                                                <option selected>Chọn gói</option>
                                                                                <option value="1">Course 1</option>
                                                                                <option value="2">Course 1</option>
                                                                                <option value="3">Course 1</option>
                                                                            </select>
                                                                        </div>-->
                                    <div>
                                        <button class="btn btn-dark btn-block border-0 py-3" type="submit">Đăng Ký Ngay</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Registration End -->


        <!-- Team Start -->
        <div class="container-fluid py-5">
            <div class="container pt-5 pb-3">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Giảng Viên</h5>
                    <h1>Giảng Viên Của Chúng Tôi</h1>
                </div>
                 <div class="row image-slider">
                    <c:forEach var="expert" items="${requestScope.experts}"  >
                        <div class="col-md-6 col-lg-3 text-center team mb-4">
                            <div class="team-item rounded overflow-hidden mb-2">
                                <div class="team-img position-relative">
                                    <img class="img-fluid" src="${expert.avatar}" style="min-height: 300px; object-fit: cover;" alt="">
                                    <div class="team-social">
                                        <a class="btn btn-outline-light btn-square mx-1" href="#"><i class="fab fa-twitter"></i></a>
                                        <a class="btn btn-outline-light btn-square mx-1" href="#"><i class="fab fa-facebook-f"></i></a>
                                        <a class="btn btn-outline-light btn-square mx-1" href="#"><i class="fab fa-linkedin-in"></i></a>
                                    </div>
                                </div>
                                <div class="bg-secondary p-4">
                                    <h5>${expert.name}</h5>
                                    <p class="m-0">Web Designer</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
        <!-- Team End -->


        <!-- Testimonial Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Feedbacks</h5>
                    <h1>Phản Hồi Từ Học Viên</h1>
                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="owl-carousel testimonial-carousel">
                            <c:forEach var="feedback" items="${requestScope.feedbacks}">
                                <div class="text-center">
                                    <i class="fa fa-3x fa-quote-left text-primary mb-4"></i>
                                    <h4 class="font-weight-normal mb-4">${feedback.feedbackContent}</h4>
                                    <img class="img-fluid mx-auto mb-3" src="${feedback.user.avatar}" alt="">
                                    <h5 class="m-0">Tên học viên</h5>
                                    <span>${feedback.user.name}</span>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Testimonial End -->



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
                                <a class="blog-overlay text-decoration-none" href="">
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
        <!-- Footer Start -->
        <div>
            <jsp:include page="../../component/footer.jsp" ></jsp:include>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="fa fa-angle-double-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

        <!-- Template Javascript -->
        <!-- JavaScript Libraries -->
        <!--<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>-->
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>-->
        <!--<script src="assets/lib/easing/easing.min.js"></script>-->
        <script src="assets/lib/owlcarousel/owl.carousel.min.js"></script>

        <script src="js/main.js"></script>
        <script src="js/carousel.js"></script>
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

    </body>
</html>
