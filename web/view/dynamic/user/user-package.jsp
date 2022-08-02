<%-- 
    Document   : userCourse
    Created on : May 26, 2022, 1:56:11 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <link href="../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">
        <!-- css Header -->
        <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../assets/css/style.css" rel="stylesheet">


        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="../assets/css/data-table-js.js" ></script>

        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">

        <link rel="stylesheet" href="../assets/css/simple-notify.min.css" />
        <script src="../assets/js/simple-notify.min.js"></script>
        <script src="../js/main.js"></script>
        <script>
            function deleteUserCourse(id, name, username)
            {
                var result = confirm("Bạn có muốn xóa khóa" + name + " không?");
                if (result)
                {
                    window.location.href = "../courseUser/delete?courseID=" + id + "&username=" + username;
                }
            }
            function pagger(id, pageindex, totalpage, gap)
            {
                var container = document.getElementById(id);
                var result = '';
                //generate first
                if (pageindex - gap > 1)
                    result += '<a href="course?page=1">First</a>';

                for (var i = pageindex - gap; i < pageindex; i++)
                {
                    if (i >= 1)
                    {
                        result += '<a href="course?page=' + i + '">' + i + '</a>';
                    }
                }

                // generate span for pageindex
                result += '<span>' + pageindex + '</span>';

                for (var i = pageindex + 1; i <= pageindex + gap; i++)
                {
                    if (i <= totalpage)
                    {
                        result += '<a href="course?page=' + i + '">' + i + '</a>';
                    }
                }

                //generate last
                if (pageindex + gap < totalpage)
                    result += '<a href="course?page=' + totalpage + '">Last</a>';

                container.innerHTML = result;
            }
            function submitSearchForm() {
                document.getElementById("searchForm").submit();
            }
        </script>
        <style>
            .containerPager span
            {
                font-weight: bold;
                color: red;
                padding: 2px;
            }

            .containerPager a
            {
                border-style: solid;
                border-width: 1px;
                margin-left: 2px;
                margin-top: 2px;
                padding: 2px;
            }

            .page-header{
                background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(../assets/img/page-header.jpg), no-repeat center center;
                background-size: cover;
            }

            #mytable  {
                width: 100%;

            }


            #mytable tbody {
                display: block;
                max-height: 320px;
                /*width: 80vw;*/
                overflow: auto;
            }
            #mytable thead,  #mytable tbody tr {
                display: table;
                width: 100%;
                table-layout: fixed;/* even columns width , fix width of table too*/
            }

            #mytable thead {
                width: 100%;
            }

            #mytable tr th,
            #mytable tr td {
                border-color: #e9e9e9;
                padding: 15px 15px;
                vertical-align: middle;
                overflow: auto;
                /*border: 1px solid #000;*/
                box-sizing: border-box;
                text-align: center;

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




            #invoice-modal{

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
                min-height: 70vh;
                box-shadow: 0 5px 10px rgba(0,0,0,.1);
            }


            .invoice-container {
                padding: 25px;
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
        </style>
    </head>
    <body>
        <c:if test="${sessionScope.user.group.name == 'Học viên'}">
            <jsp:include page="../user/learner/header.jsp"></jsp:include>
        </c:if>
        <!-- End Header -->
        <div class="container-fluid page-header" style="margin-bottom: 90px;">
            <div class="container">
                <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                    <h3 class="display-4 text-white text-uppercase">Lịch sử đăng ký</h3>
                    <div class="d-inline-flex text-white">
                        <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Chủ</a></p>
                        <i class="fa fa-angle-double-right pt-1 px-3"></i>
                        <p class="m-0 text-uppercase">Lịch sử đăng ký</p>
                    </div>
                </div>
            </div>
        </div>
        <!-- Courses Start -->
        <div class="container-fluid py-1">

            <div class="container-fluid py-1">
                <div class="container py-5">

                    <div class="text-center mb-5">
                        <h5 class="text-primary text-uppercase mb-3">Gói Đăng Ký</h5>
                        <h1>Gói Đăng Ký Hiện Tại</h1>
                    </div>

                    <div style="width: 100%;" class="row">


                        <section style=" margin-left: 34%;" id="pricing" class="pricing">
                            <div  class="container" data-aos="fade-up">
                                <c:set var="pp" value="${requestScope.package}" ></c:set>


                                    <div   class="col-lg-12"  >
                                        <div class="box">
                                            <h3>${pp.packageTitle}</h3>
                                        <h4>
                                            <sup>
                                                <fmt:setLocale value="vi_VN"/>
                                                <fmt:formatNumber value="${pp.total_price}" type="currency"/>
                                            </sup>
                                            <span> /  ${pp.p.durationText}</span></h4>
                                        <ul>
                                            <c:forEach var="ub" items="${pp.p.benefits}" >

                                                <li>${ub}</li>
                                                </c:forEach>

                                        </ul>
                                        <div class="btn-wrap">
                                            <span>Thời gian sử dụng:</span>  <span style="font-weight: bold; color: #000;" > <em>${pp.valid_from}</em> -  <em>${pp.valid_to}</em></span>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </section><!-- End Pricing Section -->

                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid">

            <div class="container-fluid">
                <div class="container">

                    <div class="text-center mb-5">
                        <h5 class="text-primary text-uppercase mb-3">Hóa Đơn</h5>
                        <h1>Danh Sách Hóa Đơn</h1>
                    </div>

                    <div class="row">

                        <table id="mytable" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Mã số</th>
                                    <th>Gói ưu đãi</th>
                                    <th>Ngày đăng ký</th>
                                    <th>Tổng tiền</th>
                                    <th>Hành động</th>

                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="b" items="${requestScope.bills}">
                                    <tr>
                                        <td>#${b.billId}</td>                                        
                                        <td>${b.packageTitle}</td>                                        
                                        <td>${b.registration_date}</td>                                        
                                        <td>
                                            <fmt:setLocale value="vi_VN"/>
                                            <fmt:formatNumber value="${b.price}" type="currency"/>
                                        </td>  
                                        <td onclick="viewBill('${b.billId}')" > <i class="bi bi-eye"></i></td>       
                                    </tr>
                                </c:forEach>
                            </tbody>
                            <!--load course list-->
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal" >


            <div id="invoice-modal">
                <div class="invoice-container">
                    <div class="top">
                        <div class="top-left">
                            <h3 class="main">Hóa Đơn</h3>
                            <span class="code invoice-info">#</span>
                        </div>
                        <div class="top-right">
                            <div class="date invoice-package">Ngày tạo: </div>
                        </div>
                    </div>
                    <div class="bill-box">
                        <div class="left">
                            <div class="text-m">Thông tin thanh toán: </div>
                            <div class="invoice-info" ></div>
                            <div class="invoice-info" ></div>
                            <div class="invoice-info" ></div>
                            <div class="invoice-info" ></div>
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
                        <button onclick="modal('invoice-modal', 0, 'scale(0)');" class="btn btn-main">Đóng</button>
                    </div>

                </div>
            </div>

        </div>


        <!-- Courses End -->
        <div>
            <jsp:include page="../component/footer.jsp"></jsp:include>
        </div>
    </body>
    <script>
        $(document).ready(function () {
            $('#mytable').DataTable();
        });

        function viewBill(bill) {
            var url = "../authen/bill/view?bill=" + bill;

            fetch(url, {method: "POST"})
                    .then(response => response.json())
                    .then(result => {

                        var userInfo = document.getElementsByClassName("invoice-info");
                        var packageInfo = document.getElementsByClassName("invoice-package");

                        var bill = result.bill;


                        userInfo[0].innerHTML = '#' + bill.billId;
                        userInfo[1].innerHTML = 'Họ và tên: ' + bill.user.name;
                        userInfo[2].innerHTML = 'Email: ' + bill.user.email;
                        userInfo[3].innerHTML = 'Số điện thoại: ' + bill.user.phone;
                        userInfo[4].innerHTML = 'Địa chỉ: ' + bill.user.address;




                        var registerDate = new Date(bill.registration_date);
                        packageInfo[1].innerHTML = bill.packageTitle;



                        var dateFormatter = Intl.DateTimeFormat('vi-VN', {
                            day: 'numeric', // numeric, 2-digit
                            year: 'numeric', // numeric, 2-digit
                            month: 'long', // numeric, 2-digit, long, short, narrow
                        });


                        var from = new Date(bill.valid_from);
                        var to = new Date(bill.valid_to);

                        packageInfo[0].innerHTML = dateFormatter.format(registerDate);
                        packageInfo[2].innerHTML = dateFormatter.format(from)
                                + " - " + dateFormatter.format(to);

                        var formatter = new Intl.NumberFormat('it-IT', {
                            style: 'currency',
                            currency: 'VND',

                        });
                        packageInfo[3].innerHTML = formatter.format(bill.price);
                        packageInfo[4].innerHTML = formatter.format(bill.price);

                        modal('invoice-modal', 0, 'scale(1)');
                    });
        }

    </script>
    <!-- js header -->
    <script src="../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</html>
