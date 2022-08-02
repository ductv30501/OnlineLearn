<%-- 
    Document   : coursedetail
    Created on : May 28, 2022, 3:10:08 AM
    Author     : ADMIN
--%>

<%@page import="java.util.HashMap"%>
<%@page import="model.Chapter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Lesson"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Chi tiết Khóa học</title>
        <meta name="robots" content="noindex, follow">
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- CSS
            ============================================ -->
        <link rel="stylesheet" href="../assets/css/vendor/bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/vendor/remixicon.css">
        <link rel="stylesheet" href="../assets/css/vendor/eduvibe-font.css">
        <link rel="stylesheet" href="../assets/css/vendor/magnifypopup.css">
        <link rel="stylesheet" href="../assets/css/vendor/slick.css">
        <link rel="stylesheet" href="../assets/css/vendor/odometer.css">
        <link rel="stylesheet" href="../assets/css/vendor/lightbox.css">
        <link rel="stylesheet" href="../assets/css/vendor/animation.css">
        <link rel="stylesheet" href="../assets/css/vendor/jqueru-ui-min.css">
        <link rel="stylesheet" href="../assets/css/detailstyle.css">
        <link rel="stylesheet" href="../assets/css/coursedetailmin.css">

        <!--link to font awesome-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!--link to css for header-->
        <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">


        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="../assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <link href="../assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="../assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="../assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <%
            ArrayList<Chapter> chapters = (ArrayList<Chapter>) request.getAttribute("chapters");

            HashMap<Integer, ArrayList> lessonMap = (HashMap<Integer, ArrayList>) request.getAttribute("lessonMap");
            ArrayList<Integer> countStars = (ArrayList<Integer>) request.getAttribute("countstar");
            Integer reviewSize = (Integer) request.getAttribute("reviewsize");
        %>
    </head>
    <style>
        body {
            font-size: 25px;
        }
    </style>

    <body>
        <div>
            <c:if test="${sessionScope.user == null}" >
                <jsp:include page="../user/guest/header.jsp"></jsp:include>

            </c:if>
            <c:if test="${sessionScope.user != null}" >
                <jsp:include page="../user/learner/header.jsp"></jsp:include>

            </c:if>
        </div>
        <input value="${sessionScope.user}" type="hidden" id="user"  />
        <div class="main-wrapper" >
            <div class="edu-course-details-area edu-section-gap bg-color-white">
                <div class="container">
                    <div class="row g-5">
                        <div class="col-xl-8 col-lg-7">
                            <div class="course-details-content">

                                <h3 class="title">${requestScope.courseById.courseTitle}</h3>

                                <div class="course-details-card">
                                    <div class="course-content">
                                        <h5>Thông tin khóa học</h5>
                                        <p>${requestScope.courseById.description}</p>

                                    </div>
                                </div>
                                <div class="course-details-card mt--40">
                                    <h5 style="margin-bottom: 20px;">Nôi Dung khóa học</h5>
                                    <div class="course-content">
                                        <div class="edu-accordion-02" id="accordionExample1">
                                            <%for (Chapter chap : chapters) {%>
                                            <%ArrayList<Lesson> lessons = lessonMap.get(chap.getChapterId());%>
                                            <div class="edu-accordion-item bg-active">
                                                <div class="edu-accordion-header" id="headingOne">
                                                    <button class="edu-accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%=chap.getChapterId()%>" aria-expanded="true" aria-controls="collapseOne">
                                                        <%=chap.getChapterTitle()%>
                                                    </button>
                                                </div>
                                                <div id="collapse<%=chap.getChapterId()%>" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample1">
                                                    <div class="edu-accordion-body">
                                                        <ul>
                                                            <%for (Lesson les : lessons) {%>
                                                            <li>
                                                                <div class="text"><i class="fas fa-book-open"></i> <%=les.getLessonTitle()%></div>
                                                                <div class="icon"><i class="fas fa-lock"></i></div>
                                                            </li>
                                                            <%}%>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </div>
                                            <%}%>
                                        </div>
                                    </div>
                                </div>

                                <div class="course-details-card mt--40">
                                    <h5 style="margin-bottom: 20px;" >Giảng viên</h5>
                                    <div class="course-content">
                                        <div class="course-author-wrapper">
                                            <div style="margin-right: 40px;" >
                                                <img style="width: 100px; height: 100px;" src="${teacher.avatar}" alt="Author Images">
                                            </div>
                                            <div class="author-content">
                                                <h6 class="title">
                                                    <a href="instructor-profile.html">${requestScope.teacher.name}</a>
                                                </h6>
                                                <span class="subtitle">Email: ${requestScope.teacher.email}</span>
                                                <p>${requestScope.teacher.description}</p>
                                                <ul class="social-share border-style">
                                                    <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
                                                    <li><a href="#"><i class="fab fa-linkedin-in"></i></a></li>
                                                    <li><a href="#"><i class="fab fa-instagram"></i></a></li>
                                                    <li><a href="#"><i class="fab fa-twitter-square"></i></a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="course-details-card mt--40">
                                    <div class="course-content">
                                        <h5 class="mb--20">Đánh giá</h5>
                                        <div class="row row--30">
                                            <div class="col-lg-4">
                                                <div class="rating-box">
                                                    <div class="rating-number">${requestScope.courseById.rate}</div>
                                                    <div class="rating">
                                                        <i class="icon-Star"></i>
                                                        <i class="icon-Star"></i>
                                                        <i class="icon-Star"></i>
                                                        <i class="icon-Star"></i>
                                                        <i class="icon-Star"></i>
                                                    </div>
                                                    <span>(25 Review)</span>
                                                </div>
                                            </div>
                                            <div class="col-lg-8">
                                                <div class="review-wrapper">

                                                    <% for (int i = 0; i < countStars.size(); i++) {%>
                                                    <div class="single-progress-bar">
                                                        <div class="rating-text">
                                                            <%=(i + 1)%> <i class="fas fa-star" style="color:#FFA41B"></i>
                                                        </div>
                                                        <div class="progress">
                                                            <div class="progress-bar" role="progressbar" style="" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100"></div>
                                                        </div>
                                                    </div>
                                                    <%}%>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="comment-wrapper pt--40">
                                            <div class="section-title">
                                                <h5 class="mb--25">Phản hồi của học viên</h5>
                                            </div>
                                            <c:forEach var="reviews" items="${requestScope.reviews}">
                                                <div class="edu-comment">
                                                    <div class="thumbnail">
                                                        <img src="../img/team-3.jpg" alt="Comment Images">
                                                    </div>
                                                    <div class="comment-content">
                                                        <div class="comment-top">
                                                            <h6 class="title">${reviews.user.name}</h6>
                                                            <div class="rating">
                                                                <c:forEach var="i" begin="1" end="${reviews.star}">
                                                                    <i class="fas fa-star" style="color:#FFA41B"></i>
                                                                </c:forEach>
                                                                <c:forEach var="i" begin="${reviews.star+1}" end="5">
                                                                    <i class="fas fa-star"></i>
                                                                </c:forEach>                                                                
                                                            </div>
                                                        </div>

                                                        <p>${reviews.comment}</p>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-xl-4 col-lg-5">
                            <div class="eduvibe-sidebar course-details-sidebar">
                                <div class="inner">
                                    <div class="eduvibe-widget">

                                        <div class="eduvibe-widget-details mt--35">
                                            <div class="widget-content">
                                                <ul>
                                                    <li><span><i class="fas fa-business-time"></i> Tổng thời gian</span><span>${requestScope.courseById.durationText}</span></li>

                                                    <li><span><i class="fas fa-users"></i> Số học viên</span><span>${requestScope.enrolled}</span></li>

                                                    <li><span><i class="fas fa-briefcase"></i> Số bài học</span><span>${requestScope.countlessons}</span></li>

                                                    <li><span><i class="fas fa-user-graduate"></i>Giảng viên </span><span>${requestScope.teacher.name}</span></li>
                                                </ul>

                                                <input id="course-id" type="hidden" value="${requestScope.courseById.courseId}" />
                                                <div id="button-action" class="read-more-btn mt--15">

                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>




        <!-- JS
    ============================================ -->
        <!-- Modernizer JS -->
        <script src="../assets/js/vendor/modernizr.min.js"></script>
        <!-- jQuery JS -->
        <script src="../assets/js/vendor/jquery.js"></script>
        <script src="../assets/js/vendor/bootstrap.min.js"></script>
        <script src="../assets/js/vendor/sal.min.js"></script>
        <script src="../assets/js/vendor/backtotop.js"></script>
        <script src="../assets/js/vendor/magnifypopup.js"></script>
        <script src="../assets/js/vendor/slick.js"></script>
        <script src="../assets/js/vendor/countdown.js"></script>
        <script src="../assets/js/vendor/jquery-appear.js"></script>
        <script src="../assets/js/vendor/odometer.js"></script>
        <script src="../assets/js/vendor/isotop.js"></script>
        <script src="../assets/js/vendor/imageloaded.js"></script>
        <script src="../assets/js/vendor/lightbox.js"></script>
        <script src="../assets/js/vendor/wow.js"></script>
        <script src="../assets/js/vendor/paralax.min.js"></script>
        <script src="../assets/js/vendor/paralax-scroll.js"></script>
        <script src="../assets/js/vendor/jquery-ui.js"></script>
        <script src="../assets/js/vendor/tilt.jquery.min.js"></script>
        <!-- Main JS -->
        <script src="../assets/js/coursedetailmain.js"></script>

        <script>
            var courseId = document.getElementById('course-id').value;

            var url = "../authen/check/register?courseId=" + courseId;


            fetch(url).then(response => response.text())
                    .then(result => {
                        var btnAction = document.getElementById('button-action');
                        var btn = "";
                        if (result === "true") {
                            btn = "<a  class=\"edu-btn w-100 text-center\" href=\"#\" onclick=\"checkLogin('http://localhost:8080/onlinelearn/authen/lesson/view?courseId=" + courseId + "')\">Tiếp tục học</a>";
                        } else {
                            btn = "<a  class=\"edu-btn w-100 text-center\" href=\"#\" onclick=\"checkLogin('../course-register?courseID=" + courseId + "')\">Đăng ký</a>";
                        }

                        btnAction.innerHTML = btn;
                    });

            function checkLogin(link) {
                var user = document.getElementById('user').value;
                if (user === null || user === '') {
                    window.location.href = "http://localhost:8080/onlinelearn/login";
                } else {
                    window.location.href = link;
                }
            }
        </script>
        <div>
            <jsp:include page="../component/footer.jsp" ></jsp:include>
        </div>
        <!--<script src="./../assets/js/coursedetailmain.js" type="text/javascript"></script>-->
    </body>
</html>