<%-- 
    Document   : contact
    Created on : May 20, 2022, 10:13:08 AM
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

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">


        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />

        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

        <link rel="stylesheet" href="assets/css/simple-notify.min.css" />
        <script src="assets/js/simple-notify.min.js"></script>
        <script src="js/main.js"></script>

    </head>
    <style>
        .page-header{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }
    </style>
    <body>
        <c:if test="${sessionScope.user == null}">
            <div>
                <jsp:include page="../user/guest/header.jsp"></jsp:include>
                </div>
        </c:if>
        <c:if test="${sessionScope.user != null}">
            <div>
                <jsp:include page="../user/learner/header.jsp"></jsp:include>
                </div>
        </c:if>


        <!-- Header Start -->
        <div class="container-fluid page-header" style="margin-bottom: 90px;">
            <div class="container">
                <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                    <h3 class="display-4 text-white text-uppercase">Li??n H???</h3>
                    <div class="d-inline-flex text-white">
                        <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Ch???</a></p>
                        <i class="fa fa-angle-double-right pt-1 px-3"></i>
                        <p class="m-0 text-uppercase">Li??n H???</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Header End -->


        <!-- Contact Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="text-center mb-5">
                    <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Li??n H???</h5>
                    <h1>Li??n H??? N???u C?? Th???c M???c</h1>

                </div>
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <p>Ch??ng t??i lu??n s???n s??ng ti???p nh???n m???i ?? ki???n ???????ng g??p v?? gi???i ????p nh???ng y??u c???u c???a b???n.
                            H??y li??n h??? ngay v???i ch??ng t??i.<br/></p>

                        <p><i class="fa fa-map mr-2"></i>H?? N???i, Vi???t Nam</p>
                        <p><i class="fa fa-phone mr-2"></i>033333333</p>
                        <p><i class="fa fa-envelope mr-2"></i>ecourses@gmail.com</p>
                    </div>
                </div>

                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="contact-form bg-secondary rounded p-5">
                            <div id="success"></div>
                            <form name="sentMessage" id="contactForm" novalidate="novalidate">

                                <div class="control-group">
                                    <input type="text" class="form-control border-0 p-4" id="name" placeholder="H??? v?? T??n c???a b???n" required data-validation-required-message="Vui l??ng nh???p t??n c???a b???n" />
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="control-group">
                                    <input type="email" class="form-control border-0 p-4" id="email" placeholder="Email c???a b???n" required data-validation-required-message="Vui l??ng nh???p email c???a b???n" />
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="control-group">
                                    <input type="text" class="form-control border-0 p-4" id="phone" placeholder="S??? ??i???n tho???i c???a b???n" required data-validation-required-message="Vui l??ng nh???p s??? ??i???n tho???i c???a b???n" />
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="control-group">
                                    <input type="text" class="form-control border-0 p-4" id="subject" placeholder="Ti??u ?????" required data-validation-required-message="Vui l??ng nh???p ti??u ?????" />
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="control-group">
                                    <textarea class="form-control border-0 py-3 px-4" rows="5" id="message" placeholder="N???i dung" required data-validation-required-message="Vui l??ng nh???p n???i dung li??n h???"></textarea>
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="text-center">
                                    <button class="btn btn-primary py-3 px-5" type="button" onclick ="submitContact()" >G???i</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Contact End -->


        <!-- Footer Start -->
        <div>
            <jsp:include page="../component/footer.jsp" ></jsp:include>
        </div>
        <!-- Footer End -->

        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="fa fa-angle-double-up"></i></a>
        <script>
            function submitContact() {
                var name = document.getElementById("name").value;
                var email = document.getElementById("email").value;
                var subject = document.getElementById("subject").value;
                var message = document.getElementById("message").value;
                var phone = document.getElementById("phone").value;

                name = name.replace("\\s+", " ").trim();

                var flag = true;

                if (name === null || name === "") {
                    createNotify('warning', 'Th??ng b??o', 'T??n kh??ng ???????c ????? tr???ng', true);
                    flag = false;
                } else if (email === null || email === "") {
                    createNotify('warning', 'Th??ng b??o', 'Email kh??ng ???????c ????? tr???ng', true);
                    flag = false;
                } else if (subject === null || subject === "") {
                    createNotify('warning', 'Th??ng b??o', 'Ti??u ????? kh??ng ???????c ????? tr???ng', true);
                    flag = false;
                } else if (message === null || message === "") {
                    createNotify('warning', 'Th??ng b??o', 'N???i dung kh??ng ???????c ????? tr???ng', true);
                    flag = false;
                } else if (phone === null || phone === "") {
                    createNotify('warning', 'Th??ng b??o', 'S??? ??i???n tho???i kh??ng ???????c ????? tr???ng', true);
                    flag = false;
                }



                if (flag) {
                    var url = "contact?name=" + name + "&email=" + email + "&subject=" + subject + "&message=" + message + "&phone=" + phone;
                    fetch(url, {method: "POST"}).then(response => response.json())
                            .then(result => {
                                var notify = result.notification;
                                createNotify(notify.type, notify.title, notify.text, notify.autoClose);
                            });

                }
            }
        </script>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

        <!-- Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

    </body>

</html>
