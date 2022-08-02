<%-- 
    Document   : about
    Created on : May 20, 2022, 10:08:00 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Về Chúng Tôi</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Favicon -->
        <link href="" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
    </head>

    <body>
        <div>
            <jsp:include page="../user/guest/header.jsp"></jsp:include>
            </div>


            <!-- Header Start -->
            <div class="container-fluid page-header" style="margin-bottom: 90px;
                 background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(assets/img/page-header.jpg), no-repeat center center;
                 background-size: cover;">
                <div class="container">
                    <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                        <h3 class="display-4 text-white text-uppercase">Về chúng tôi</h3>
                        <div class="d-inline-flex text-white">
                            <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Chủ</a></p>
                            <i class="fa fa-angle-double-right pt-1 px-3"></i>
                            <p class="m-0 text-uppercase">Về chúng tôi</p>
                        </div>
                    </div>
                </div>
            </div>


            <!-- About Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="row align-items-center">
                        <div class="col-lg-5">
                            <img class="img-fluid rounded mb-4 mb-lg-0" src="assets/img/about.jpg" alt="">
                        </div>
                        <div class="col-lg-7">
                            <div class="text-left mb-4">
                                <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">VỀ CHÚNG TÔI</h5>
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
                            <a href="" class="btn btn-primary py-md-2 px-md-4 font-weight-semi-bold mt-2">Tìm Hiểu Thêm</a>
                        </div>
                    </div>
                </div>
            </div>
            <!-- About End -->


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
                                            <input type="text" class="form-control border-0 p-4" placeholder="Họ và Tên" required="required" />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control border-0 p-4" placeholder="Tên đăng nhập" required="required" />
                                        </div>
                                        <div class="form-group">
                                            <input type="text" class="form-control border-0 p-4" placeholder="Email" required="required" />
                                        </div>
                                        <div class="form-group">
                                            <input type="email" class="form-control border-0 p-4" placeholder="Mật khẩu" required="required" />
                                        </div>
                                        <!--                                    <div class="form-group">
                                                                                <select class="custom-select border-0 px-4" style="height: 47px;">
                                                                                    <option selected>Select a course</option>
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


            <!-- Testimonial Start -->
            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="text-center mb-5">
                        <h5 class="text-primary text-uppercase mb-3">Feedbacks</h5>
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


        <!-- Footer Start -->
        <div>
            <jsp:include page="../component/footer.jsp" ></jsp:include>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="fa fa-angle-double-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="assets/lib/easing/easing.min.js"></script>
        <script src="assets/lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
