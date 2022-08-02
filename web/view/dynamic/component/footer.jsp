<%-- 
    Document   : footer
    Created on : May 20, 2022, 10:31:24 AM
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
    <body>
        <div class="container-fluid bg-dark text-white py-5 px-sm-3 px-lg-5" style="margin-top: 90px;">
            <div class="row pt-5">
                <div class="col-lg-7 col-md-12">
                    <div class="row">
                        <div class="col-md-6 mb-5">
                            <h5 class="text-primary text-uppercase mb-4" style="letter-spacing: 5px;">Liên Hệ</h5>
                            <p><i class="fa fa-map-marker-alt mr-2"></i>Hà Nội, Việt Nam</p>
                            <p><i class="fa fa-phone-alt mr-2"></i>033333333</p>
                            <p><i class="fa fa-envelope mr-2"></i>ecourses@gmail.com</p>
                            <div class="d-flex justify-content-start mt-4">
                                <a class="btn btn-outline-light btn-square mr-2" href="#"><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-outline-light btn-square mr-2" href="#"><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-outline-light btn-square mr-2" href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a class="btn btn-outline-light btn-square" href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                        <div class="col-md-6 mb-5">
                            <h5 class="text-primary text-uppercase mb-4" style="letter-spacing: 5px;">CHỦ ĐỀ</h5>
                            <div class="d-flex flex-column justify-content-start">
                                
                                <c:forEach var="topic" items="${requestScope.topics}" >
                                    <a class="text-white mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>${topic.topicName}</a>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 col-md-12 mb-5">
                    <h5 class="text-primary text-uppercase mb-4" style="letter-spacing: 5px;">Nhận Thông Báo</h5>
                    <p>ECourses luôn cập nhật những bản tin mới nhất hằng ngày. Bạn đang tìm hiểu, bạn muốn nắm bắt bản tin của ECourses hãy để lại email để nhận được!</p>
                    <div class="w-100">
                        <div class="input-group">
                            <input type="text" class="form-control border-light" style="padding: 30px;" placeholder="Email của bạn">
                            <div class="input-group-append">
                                <button class="btn btn-primary px-4">Đăng Ký</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid bg-dark text-white border-top py-4 px-sm-3 px-md-5" style="border-color: rgba(256, 256, 256, .1) !important;">
            <div class="row">
                <div class="col-lg-6 text-center text-md-left mb-3 mb-md-0">
                    <p class="m-0 text-white">&copy; <a href="#">Bản quyền thuộc về ECourses</a>. Thiết kế bởi <a href="#">OnLearn</a>
                    </p>
                </div>
                <div class="col-lg-6 text-center text-md-right">
                    <ul class="nav d-inline-flex">
<!--                        <li class="nav-item">
                            <a class="nav-link text-white py-0" href="#">Privacy</a>
                        </li>-->
                        <li class="nav-item">
                            <a class="nav-link text-white py-0" href="#">Chính Sách Và Điều Khoản</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white py-0" href="#">Câu Hỏi</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-white py-0" href="#">Trợ Giúp</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </body>
</html>
