<%-- 
    Document   : pricing
    Created on : May 20, 2022, 10:09:17 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <title>Pricing</title>


        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Raleway:300,300i,400,400i,500,500i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Vendor CSS Files -->
        <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

        <!-- Template Main CSS File -->
        <link href="css/style.css" rel="stylesheet">

        <!-- Google Web Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <!--link to font awesome cdn-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>


        <link rel="stylesheet" href="assets/css/simple-notify.min.css" />
        <script src="assets/js/simple-notify.min.js"></script>

        <script src="js/main.js"></script>


    </head>
    <style>
        .pricing .box {
            padding: 20px;
            background: #fff;
            text-align: center;
            border: 1px solid #eef0ef;
            border-radius: 0;
            box-shadow: 2px 2px 2px 2px #ccc;

            position: relative;
            overflow: hidden;
        }
        .pricing h3 {
            font-weight: 400;
            margin: -20px -20px 20px -20px;
            padding: 20px 15px;
            font-size: 16px;
            font-weight: 600;
            color: #777777;
            background: #f8f8f8;
        }
        .pricing h4 {
            font-size: 36px;
            color: #5fcf80;
            font-weight: 600;
            font-family: "Poppins", sans-serif;
            margin-bottom: 20px;
        }
        .pricing h4 sup {
            font-size: 20px;
            top: -15px;
            left: -3px;
        }
        .pricing h4 span {
            color: #bababa;
            font-size: 16px;
            font-weight: 300;
        }
        .pricing ul {
            padding: 0;
            list-style: none;
            color: #444444;
            text-align: center;
            line-height: 20px;
            font-size: 14px;
        }
        .pricing ul li {
            padding-bottom: 16px;
        }
        .pricing ul i {
            color: #5fcf80;
            font-size: 18px;
            padding-right: 4px;
        }
        .pricing ul .na {
            color: #ccc;
            text-decoration: line-through;
        }
        .pricing .btn-wrap {
            margin: 20px -20px -20px -20px;
            padding: 20px 15px;
            background: #f8f8f8;
            text-align: center;
        }
        .btn-buy {
            background: #5fcf80;
            display: inline-block;
            padding: 8px 35px;
            border-radius: 10px;
            color: #fff;
            transition: none;
            font-size: 14px;
            font-weight: 400;
            font-family: "Raleway", sans-serif;
            font-weight: 600;
            transition: 0.3s;
        }
        .btn-buy:hover {
            background: #3ac162;
        }
        .pricing .featured h3 {
            color: #fff;
            background: #5fcf80;
        }
        .pricing .advanced {
            width: 200px;
            position: absolute;
            top: 18px;
            right: -68px;
            transform: rotate(45deg);
            z-index: 1;
            font-size: 14px;
            padding: 1px 0 3px 0;
            background: #5fcf80;
            color: #fff;
        }

        .page-header{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }


        .modal {

            position: fixed;
            left: 0;
            top: 0;
            display: block;
            background: rgba(0, 0, 0, 0.5);
            height: 100%;
            width: 100%;
            transform: scale(0);
            transition-duration: 0s;
            z-index: 5;
        }




        #pay-modal,
        #invoice-modal,
        #exist-package-modal{

            top: 5%;
            left: 25%;
            width: 50%;
            /*height: 25vh;*/
            position: absolute;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 10;
            border-radius: 3px;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 75vh;
            box-shadow: 0 5px 10px rgba(0,0,0,.1);
        }

        #exist-package-modal {
            left: 25%;
            width: 50%;
            min-height: 65vh;
        }

        #pay-modal form,
        #exist-package-modal form
        {
            padding:25px;
            width: 100%;
            background: #fff;

        }

        #pay-modal form .row,
        #exist-package-modal form .row
        {
            display: flex;
            flex-wrap: wrap;
            gap:15px;
        }

        #pay-modal form .row .col,
        #exist-package-modal form .row .col
        {
            flex:1 1 250px;
        }

        #pay-modal form .row .col .title,
        #exist-package-modal form .row .col .title
        {
            font-size: 20px;
            color:#333;
            padding-bottom: 5px;
            text-transform: uppercase;
        }

        #pay-modal form .row .col .inputBox,
        #exist-package-modal form .row .col .inputBox
        {
            margin:15px 0;
        }

        #pay-modal form .row .col .inputBox span,
        #exist-package-modal form .row .col .inputBox span
        {
            margin-bottom: 10px;
            display: block;
        }

        #pay-modal form .row .col .inputBox input,
        #exist-package-modal form .row .col .inputBox input
        {
            width: 100%;
            border:1px solid #ccc;
            padding:10px 15px;
            font-size: 15px;
            text-transform: none;
        }

        #pay-modal form .row .col .inputBox input:focus,
        #exist-package-modal form .row .col .inputBox input:focus
        {
            border:1px solid #000;
        }

        #pay-modal form .row .col .flex,
        #exist-package-modal form .row .col .flex
        {
            display: flex;
            gap:15px;
        }

        #pay-modal form .row .col .flex .inputBox,
        #exist-package-modal form .row .col .flex .inputBox
        {
            margin-top: 5px;
        }

        #pay-modal form .row .col .inputBox img,
        #exist-package-modal form .row .col .inputBox img
        {
            height: 34px;
            margin-top: 5px;
            filter: drop-shadow(0 0 1px #000);
        }

        #pay-modal form .submit-btn,
        #exist-package-modal form .submit-btn
        {

            padding:12px;
            font-size: 17px;
            border-radius: 5px;
            color:#fff;
            margin-top: 5px;
            cursor: pointer;
        }

        #pay-modal form .submit-btn,
        #exist-package-modal form .submit-btn
        {
            width: 100%;
            background: #FF6600;
        }


        #pay-modal form .submit-btn:hover,
        #exist-package-modal form .submit-btn:hover
        {
            background: #2ecc71;
        }

        .cancel-btn {
            position: absolute;
            top: 10px;
            right: 10px;
        }



        /* Invoice */


        .invoice-container {
            padding: 20px;
            width: 100%;
            background: #fff;
        }
        .invoice-container .top {
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
        }
        .invoice-container .top .top-left {
            color: #0034BB;
        }
        .invoice-container .top .main {
            text-transform: uppercase;
            font-weight: 500;
            display: block;
            margin-bottom: 10px;
        }

        .invoice-container .top .date {
            color: #ADADAD;
            margin-bottom: 10px;
        }

        .bill-box {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            color: #ADADAD;
        }
        .bill-box .left, .bill-box .right {
            max-width: 100%;
        }
        .bill-box .text-m {
            margin-bottom: 10px;
            text-transform: uppercase;
        }
        .bill-box .title {
            margin-bottom: 1rem;
            font-weight: 500;
            color: #2B2B2B;
        }

        .table-bill table {
            width: 100%;
            border-spacing: 0px;
        }

        .table-bill th, .table-bill td {
            text-align: left;
            padding: 10px 0px;
            font-weight: 500;
        }



        .table-bill th {
            text-transform: uppercase;
            color: #0034BB;
            font-weight: 500;
        }

        .table-bill .quantity {
            width: 150px;
        }

        .table-bill .cost {
            text-align: right;
            white-space: nowrap;
        }

        .table-bill .total {
            color: #0034BB;
        }
        .table-bill .total td {
            font-weight: normal;
            border-top: 1px solid #ececec;
        }
        .table-bill .total .number {
            text-align: right;
            font-weight: 600;
        }

        .actions {
            text-align: center;
            margin-top: 4rem;
        }
        .actions .btn {
            margin: 3px;
            padding: 8px 10px;
            text-transform: uppercase;
            font-weight: bold;
            border: 0px;
            min-width: 130px;
            color: #0034BB;
            border-radius: 8px;
            background: rgba(0, 52, 187, 0.06);
            cursor: pointer;
        }
        .actions .btn:hover {
            background: rgba(0, 52, 187, 0.1);
        }

        .note {
            text-align: center;
            margin-top: 1rem;
            color: #ADADAD;
        }



    </style>

    <body>

        <input type="hidden" value="${requestScope.status}" id="status" />
        <div>
            <c:if test="${sessionScope.user == null}">
                <jsp:include page="../user/guest/header.jsp"></jsp:include>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <jsp:include page="../user/learner/header.jsp"></jsp:include>
            </c:if>
        </div>
        <div class="container-fluid page-header" style="margin-bottom: 90px;">
            <div class="container">
                <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                    <h3 class="display-4 text-white text-uppercase">Gói Ưu Đãi</h3>
                    <div class="d-inline-flex text-white">
                        <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Chủ</a></p>
                        <i class="fa fa-angle-double-right pt-1 px-3"></i>
                        <p class="m-0 text-uppercase">Gói Ưu Đãi</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal" >
            <div id="pay-modal" >
                <div class="cancel-btn" >
                    <button  class="btn-close" aria-label="Close" onclick="modal('pay-modal', 0, 'scale(0)')"  ></button>
                </div>
                <form action="">

                    <div class="row">

                        <div class="col">

                            <h3 class="title">Thông Tin</h3>

                            <div class="inputBox">
                                <span>Họ và tên:</span>
                                <input class="user-info" type="text" placeholder="ex: Lam Nguyen">
                            </div>
                            <div class="inputBox">
                                <span>Email:</span>
                                <input class="user-info" type="email" placeholder="ex: example@example.com">
                            </div>
                            <div class="inputBox">
                                <span>Số điện thoại:</span>
                                <input class="user-info" type="text" placeholder="ex: 0385981070">
                            </div>
                            <div class="inputBox">
                                <span>Địa chỉ:</span>
                                <input class="user-info" type="text" placeholder="ex: Ha Noi">
                            </div>



                        </div>
                        <div class="col">

                            <h3 class="title">Gói Ưu Đãi</h3>

                            <div class="inputBox">
                                <span>Tên:</span>
                                <input disabled class="package-info" type="text" placeholder="ex: Lam Nguyen">
                            </div>
                            <div class="inputBox">
                                <span>Giá:</span>
                                <input disabled class="package-info" type="email" placeholder="ex: example@example.com">
                            </div>
                            <div class="inputBox">
                                <span>Thời gian sử dụng:</span>
                                <input disabled class="package-info" type="text" placeholder="ex: 0385981070">
                            </div>




                        </div>



                    </div>
                    <div style="width: 100%;" >
                        <span>Thanh Toán</span>
                        <div style="width: 100%;" id="paypal-button-container"> </div>
                    </div>
                    <!--<input id="pay-btn" type="button" value="Thanh Toán" class="submit-btn">-->

                </form>

            </div>
        </div>

        <div class="modal" >


            <div id="invoice-modal">
                <div class="invoice-container">
                    <div class="top">
                        <div class="top-left">
                            <h3 class="main">Hóa Đơn</h3>
                            <span class="invoice-info" class="code">#</span>
                        </div>
                        <div class="top-right">
                            <div class="date invoice-package">Ngày tạo: </div>
                        </div>
                    </div>
                    <div class="bill-box">
                        <div class="left">
                            <div class="text-m">Thông tin thanh toán: </div>
                            <div class="invoice-info" >Họ và tên: </div>
                            <div class="invoice-info" >Email: </div>
                            <div class="invoice-info" >Số điện thoại: </div>
                            <div class="invoice-info" >Địa chỉ: </div>
                        </div>

                    </div>
                    <div class="table-bill">
                        <table class="table-service">
                            <thead>
                                <tr>
                                    <th class="quantity">Số lượng</th>
                                    <th>Gói ưu đãi</th>
                                    <th >Thời gian sử dụng</th>
                                    <th >Trị giá</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>1</td>
                                    <td class="invoice-package" ></td>
                                    <td class="invoice-package"></td>
                                    <td class="invoice-package"></td>
                                </tr>

                            </tbody>
                            <tfoot>
                                <tr class="total">
                                    <td class="name">Tổng</td>
                                    <td ></td>
                                    <td ></td>
                                    <td style="text-align: left;" class="number invoice-package"></td>
                                </tr>
                            </tfoot>
                        </table>
                    </div>
                    <div class="actions">
                        <!--<button onclick="modal('invoice-modal', 1, 'scale(0)');" class="btn btn-main">Đóng</button>-->
                        <button onclick="window.location.href = 'http://localhost:8080/onlinelearn/home'" class="btn btn-main">Trở Lại Trang chủ</button>
                    </div>
                    <div class="note">
                        <p>Cảm ơn đã tin tưởng sử dụng dịch vụ của chúng tôi!</p>
                    </div>
                </div>
            </div>

        </div>

        <div class="modal" >
            <div id="exist-package-modal" >
                <div class="cancel-btn" >
                    <button  class="btn-close" aria-label="Close" onclick="modal('exist-package-modal', 2, 'scale(0)')"  ></button>
                </div>
                <form action="">

                    <div class="row">


                        <div class="col">

                            <h3 class="title">Gói Ưu Đãi Đang Sử Dụng</h3>

                            <div class="inputBox">
                                <span>Tên:</span>
                                <input disabled class="exist-package-info" type="text" placeholder="ex: Lam Nguyen">
                            </div>
                            <div class="inputBox">
                                <span>Giá:</span>
                                <input disabled class="exist-package-info" type="email" placeholder="ex: example@example.com">
                            </div>
                            <div class="inputBox">
                                <span>Ngày đăng ký:</span>
                                <input disabled class="exist-package-info" type="text" placeholder="ex: 0385981070">
                            </div>
                            <div class="inputBox">
                                <span>Thời gian sử dụng:</span>
                                <span style="background-color: #fafafa; border: 1px solid #ccc; display: block; width: 100%; padding: 12px;" class="exist-package-info" type="text" ></span>
                            </div>




                        </div>



                    </div>
                    <div style="width: 100%;" >
                        <div class="btn-wrap">
                            <button class="btn-buy" type="button" onclick="deleteUserPackage()" >Hủy Gói</button>
                        </div>
                    </div>
                    <!--<input id="pay-btn" type="button" value="Thanh Toán" class="submit-btn">-->

                </form>

            </div>
        </div>



        <main id="main">


            <!-- ======= Pricing Section ======= -->
            <section id="pricing" class="pricing">
                <div class="container" data-aos="fade-up">

                    <div class="row">

                        <c:forEach var="pp" items="${requestScope.packages}" >

                            <div   class="col-lg-3 col-md-3"  >
                                <div class="box">
                                    <h3>${pp.packageTitle}</h3>
                                    <h4>
                                        <sup>
                                            <fmt:setLocale value="vi_VN"/>
                                            <fmt:formatNumber value="${pp.price}" type="currency"/>
                                        </sup>
                                        <span> /  ${pp.durationText}</span></h4>
                                    <ul>
                                        <c:forEach var="ub" items="${pp.benefits}" >

                                            <li>${ub}</li>
                                            </c:forEach>



                                    </ul>
                                    <div class="btn-wrap">
                                        <button class="btn-buy" type="button" onclick="buyNow('${pp.packageId}', '${sessionScope.user}')" >Đăng ký ngay</button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>

                    </div>

                </div>
            </section><!-- End Pricing Section -->

        </main><!-- End #main -->



        <div id="preloader"></div>
        <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

        <div>
            <jsp:include page="../component/footer.jsp"></jsp:include>
        </div>

    </body>
    <script src="https://www.paypal.com/sdk/js?client-id=AR6zIWW81GU0a49EwPIS_Vycia5BXgcGllWjfAIzU_qZK6ecqHDnMXeqo7pUWWN4rXlHwzBnPbLHmiNC&locale=vi_VN&disable-funding=card,paylater,mybank"></script>

    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script>

    </script>
    <script>

        var status = document.getElementById('status').value;

        if (status !== '' && status === 'false') {
            createNotify("warning", "Thông báo", "Bạn phải đăng ký gói để truy cập", false);
        }

        function deleteUserPackage() {
            var url = "authen/user/package/delete";
            fetch(url).then(response => response.text())
                    .then(result => {
                        createNotify('success', "Thông báo", "Hủy gói thành công", false);
                        modal('exits-package-modal', 2, 'scale(0)');
                    });
        }

        function buyNow(packageId, user) {
            if (user === "") {
                window.location.href = "http://localhost:8080/onlinelearn/login";

            } else {
                var url = "authen/user/package/get";
                fetch(url).then(response => response.json())
                        .then(result => {
                            if (result === "not-exist") {
                                showPayPal(packageId);
                            } else {

                                var package = result.package;
                                var formatter = new Intl.NumberFormat('it-IT', {
                                    style: 'currency',
                                    currency: 'VND',

                                });


                                var packageInfo = document.getElementsByClassName("exist-package-info");
                                packageInfo[0].value = package.packageTitle;
                                packageInfo[1].value = formatter.format(package.total_price);

                                var dateFormatter = Intl.DateTimeFormat('vi-VN', {
                                    day: 'numeric', // numeric, 2-digit
                                    year: 'numeric', // numeric, 2-digit
                                    month: 'long', // numeric, 2-digit, long, short, narrow
                                });


                                var from = new Date(package.valid_from);
                                var to = new Date(package.valid_to);

                                packageInfo[2].value = dateFormatter.format(from);
                                packageInfo[3].innerHTML = "Từ <strong>" + dateFormatter.format(from)
                                        + "</strong> đến hết <strong>" + dateFormatter.format(to) + "</strong>";
                                modal('exist-package-modal', 2, 'scale(1)');
                                createNotify('warning', "Thông báo", "Gói ưu đãi đang dùng chưa hết hạn", true);
                            }
                        });

            }
        }

        function showPayPal(packageId) {
            var url = "authen/manage/package/get?packageId=" + packageId;

            fetch(url, {method: "POST"})
                    .then(response => response.json())
                    .then(result => {
                        var userInfo = document.getElementsByClassName("user-info");
                        var packageInfo = document.getElementsByClassName("package-info");

                        var user = result.user;
                        var package = result.package;


                        userInfo[0].value = user.name;
                        userInfo[1].value = user.email;
                        userInfo[2].value = user.phone;
                        userInfo[3].value = user.address;


                        packageInfo[0].value = package.packageTitle;

                        var formatter = new Intl.NumberFormat('it-IT', {
                            style: 'currency',
                            currency: 'VND',

                        });


                        packageInfo[1].value = formatter.format(package.price);
                        packageInfo[2].value = result.durationText;


                        var price = parseFloat(package.price / 23403).toFixed(2);

                        createPayPal(packageId, price);
                        modal('pay-modal', 0, 'scale(1)');

                    });
        }



        function createPayPal(packageId, price) {
            var container = document.getElementById('paypal-button-container');
            container.innerHTML = "";

            paypal.Buttons({

                style: {
                    layout: 'vertical',
                    color: 'blue',
                    shape: 'rect',
                    label: 'paypal',
                },
                createOrder: function (data, actions) {
                    return actions.order.create({
                        purchase_units: [{
                                amount: {
                                    value: price
                                }
                            }]
                    });

                },

                onShippingChange: function (data, actions) {

                    return actions.resolve();
                },
                onApprove: function (data, actions) {
                    var url = "authen/package/register?packageId=" + packageId;

                    fetch(url, {method: "POST"})
                            .then(response => response.json())
                            .then(result => {
                                modal('pay-modal', 0, 'scale(0)');

                                var userInfo = document.getElementsByClassName("invoice-info");
                                var packageInfo = document.getElementsByClassName("invoice-package");

                                var bill = result.bill;


                                userInfo[0].innerHTML += bill.billId;
                                userInfo[1].innerHTML += bill.user.name;
                                userInfo[2].innerHTML += bill.user.email;
                                userInfo[3].innerHTML += bill.user.phone;
                                userInfo[4].innerHTML += bill.user.address;




                                var registerDate = new Date(bill.registration_date);
                                packageInfo[1].innerHTML = bill.packageTitle;



                                var dateFormatter = Intl.DateTimeFormat('vi-VN', {
                                    day: 'numeric', // numeric, 2-digit
                                    year: 'numeric', // numeric, 2-digit
                                    month: 'long', // numeric, 2-digit, long, short, narrow
                                });


                                var from = new Date(bill.valid_from);
                                var to = new Date(bill.valid_to);

                                packageInfo[0].innerHTML += dateFormatter.format(registerDate);
                                packageInfo[2].innerHTML = dateFormatter.format(from)
                                        + " - " + dateFormatter.format(to);

                                var formatter = new Intl.NumberFormat('it-IT', {
                                    style: 'currency',
                                    currency: 'VND',

                                });
                                packageInfo[3].innerHTML = formatter.format(bill.price);
                                packageInfo[4].innerHTML = formatter.format(bill.price);

                                modal('invoice-modal', 1, 'scale(1)');
                                createNotify('success', 'Thông báo', 'Bạn đã đăng ký thành công', false);
                            });
                },
                onCancel: function (data) {

                },
                onError: function (err) {
                    createNotify('error', 'Thông báo', 'Đã xảy ra lỗi trong quá trình thanh toán', false);

                }
            }).render('#paypal-button-container');
        }


    </script>
</html>
