<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<html >
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover"/>
        <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
        <title>Dashboard</title>
        <!-- CSS files -->
        <!--<link href="admin/css/tabler.min.css" rel="stylesheet"/>-->
        <!--<link href="admin/css/tabler-flags.min.css" rel="stylesheet"/>-->
        <!--<link href="admin/css/tabler-payments.min.css" rel="stylesheet"/>-->
        <!--<link href="admin/css/tabler-vendors.min.css" rel="stylesheet"/>-->
        <!--<link href="admin/css/demo.min.css" rel="stylesheet"/>-->


        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <!--        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">-->
        <!--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>-->
        <!--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>-->
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="assets/css/data-table-js.js" ></script>
        <link href="assets/css/data-table.css" rel="stylesheet" type="text/css"/>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <!--<link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />-->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">-->

        <link href="admin/css/demo.min.css" rel="stylesheet"/>
        <link href="css/tabler.css" rel="stylesheet"/>
        <link href="js/main.js" rel="stylesheet"/>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    </head>
    <style>

        /* width */
        ::-webkit-scrollbar {
            width: 8px;
        }

        /* Track */
        ::-webkit-scrollbar-track {
            background: #f1f1f1;

        }

        /* Handle */
        ::-webkit-scrollbar-thumb {
            background: #888;
            border-radius: 5px;

        }

        /* Handle on hover */
        ::-webkit-scrollbar-thumb:hover {
            background: #555;
        }

        textarea {
            resize: vertical;
            max-height: 200px;
            min-height: 100px;
            width:100%;
        }


        .table-responsive {
            padding: 20px;
        }
        .table-wrapper {
            background: #fff;
            border-radius: 3px;
            /*min-width: 1000px;*/
            box-shadow: 0 1px 1px rgba(0,0,0,.05);
        }


        table {
            width: 100%;
            cursor: pointer;
        }


        tbody {
            display: block;
            max-height: 320px;
            /*width: 80vw;*/
            overflow: auto;
        }
        thead, tbody tr {
            display: table;
            width: 100%;
            table-layout: fixed;/* even columns width , fix width of table too*/
        }

        thead {
            width: 100%;
            background-color: #666;
        }



        table.table tr th,
        table.table tr td {
            border-color: #e9e9e9;
            padding: 5px 5px;
            vertical-align: middle;
            overflow: auto;
            /*border: 1px solid #000;*/
            box-sizing: border-box;
            text-align: center;
        }

        table tbody tr:nth-of-type(odd) {
            background-color: #fff;
        }

        table tbody tr:nth-of-type(even) {
            background-color: #f5f5f5;
        }

        table tbody tr:hover {
            background: #f5f5f5;
        }

        .date-title {
            margin-right: 10px;
        }

        .date-input {
            margin-right: 10px;
        }

        .dot {
            height: 10px;
            width: 10px;
            background-color: green;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }

    </style>
    <body >
        <div class="page">
            <div>
                <jsp:include page="../component/header.jsp" ></jsp:include>
                </div>
                <div class="page-wrapper">
                    <div class="container-xl">
                        <!-- Page title -->
                        <div class="page-header d-print-none">
                            <div class="row g-2 align-items-center">
                                <div class="col">
                                    <!-- Page pre-title -->
                                    <div class="page-pretitle">
                                        Tổng quan
                                    </div>
                                    <h2 class="page-title">
                                        Trang chủ
                                    </h2>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="page-body">
                        <div class="container-xl">
                            <div class="row row-deck row-cards">
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="subheader">Gói ưu đãi bán được</div>
                                                <div class="ms-auto lh-1">
                                                    <div class="dropdown">
                                                         <div class="dropdown">
                                                            <a
                                                               class="dropdown-toggle text-muted" 
                                                               href="#" data-bs-toggle="dropdown" 
                                                               aria-haspopup="true" 
                                                               aria-expanded="false">Từ 7 ngày trước</a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <a 
                                                                   class="dropdown-item new-user-search active" href="#">Từ 7 ngày trước</a>
                                                                <a 
                                                                   class="dropdown-item new-user-search" href="#">Từ 2 tuần trước</a>
                                                                <a 
                                                                   class="dropdown-item new-user-search" href="#">Từ 1 tháng trước</a>
                                                                <a  
                                                                   class="dropdown-item new-user-search" href="#">Từ 2 tháng trước</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-baseline">
                                                <div class="h1 mb-3 me-2">30</div>
                                                <div class="me-auto">
                                                    <span class="text-yellow d-inline-flex align-items-center lh-1">
                                                        0% <!-- Download SVG icon from http://tabler-icons.io/i/minus -->
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                                    </span>
                                                </div>
                                            </div>
                                            <div style="margin-top: 50px;" id="chart-new-clients" class="chart-sm"></div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="subheader">Tổng danh thu</div>
                                                <div class="ms-auto lh-1">
                                                    <div class="dropdown">
                                                        <div class="dropdown">
                                                            <a
                                                               class="dropdown-toggle text-muted" 
                                                               href="#" data-bs-toggle="dropdown" 
                                                               aria-haspopup="true" 
                                                               aria-expanded="false">Từ 7 ngày trước</a>
                                                            <div class="dropdown-menu dropdown-menu-end">
                                                                <a 
                                                                   class="dropdown-item new-user-search active" href="#">Từ 7 ngày trước</a>
                                                                <a 
                                                                   class="dropdown-item new-user-search" href="#">Từ 2 tuần trước</a>
                                                                <a 
                                                                   class="dropdown-item new-user-search" href="#">Từ 1 tháng trước</a>
                                                                <a  
                                                                   class="dropdown-item new-user-search" href="#">Từ 2 tháng trước</a>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-baseline">
                                                <div class="h1 mb-0 me-2"> <fmt:setLocale value="vi_VN"/>
                                            <fmt:formatNumber value="52590000" type="currency"/></div>
                                                <div class="me-auto">
                                                    <span class="text-green d-inline-flex align-items-center lh-1">
                                                        8% <!-- Download SVG icon from http://tabler-icons.io/i/trending-up -->
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="3 17 9 11 13 15 21 7" /><polyline points="14 7 21 7 21 14" /></svg>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div id="chart-revenue-bg" class="chart-sm"></div>
                                    </div>
                                </div>
                                <div class="col-sm-6 col-lg-3">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="d-flex align-items-center">
                                                <div class="subheader">Người dùng mới</div>
                                                <div class="ms-auto lh-1">
                                                    <div class="dropdown">
                                                        <a id="new-user-search-option"
                                                           class="dropdown-toggle text-muted" 
                                                           href="#" data-bs-toggle="dropdown" 
                                                           aria-haspopup="true" 
                                                           aria-expanded="false">Từ 7 ngày trước</a>
                                                        <div class="dropdown-menu dropdown-menu-end">
                                                            <a onclick="getData(event, 'new-user-search', 'newUser')" 
                                                               class="dropdown-item new-user-search active" href="#">Từ 7 ngày trước</a>
                                                            <a onclick="getData(event, 'new-user-search', 'newUser')" 
                                                               class="dropdown-item new-user-search" href="#">Từ 2 tuần trước</a>
                                                            <a onclick="getData(event, 'new-user-search', 'newUser')" 
                                                               class="dropdown-item new-user-search" href="#">Từ 1 tháng trước</a>
                                                            <a onclick="getData(event, 'new-user-search', 'newUser')" 
                                                               class="dropdown-item new-user-search" href="#">Từ 2 tháng trước</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="d-flex align-items-baseline">
                                                <div id="new-user" class="h1 mb-3 me-2">${requestScope.registeredUsers.size()}</div>
                                            <div class="me-auto">
                                                <span class="text-yellow d-inline-flex align-items-center lh-1">
                                                    0% <!-- Download SVG icon from http://tabler-icons.io/i/minus -->
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><line x1="5" y1="12" x2="19" y2="12" /></svg>
                                                </span>
                                            </div>
                                        </div>
                                        <canvas id="new-user-chart" ></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-lg-3">
                                <div class="card">
                                    <div class="card-body">
                                        <div class="d-flex align-items-center">
                                            <div  class="subheader">Người dùng hoạt động</div>
                                            <div class="ms-auto lh-1">
                                                <div class="dropdown">
                                                    <a id="frequent-user-search-option"
                                                       class="dropdown-toggle text-muted" 
                                                       href="#" data-bs-toggle="dropdown" 
                                                       aria-haspopup="true" 
                                                       aria-expanded="false">Từ 7 ngày trước</a>
                                                    <div class="dropdown-menu dropdown-menu-end">
                                                        <a onclick="getData(event, 'frequent-user-search', 'activeUser')" 
                                                           class="dropdown-item frequent-user-search active" href="#">Từ 7 ngày trước</a>
                                                        <a onclick="getData(event, 'frequent-user-search', 'activeUser')" 
                                                           class="dropdown-item frequent-user-search" href="#">Từ 2 tuần trước</a>
                                                        <a onclick="getData(event, 'frequent-user-search', 'activeUser')" 
                                                           class="dropdown-item frequent-user-search" href="#">Từ 1 tháng trước</a>
                                                        <a onclick="getData(event, 'frequent-user-search', 'activeUser')" 
                                                           class="dropdown-item frequent-user-search" href="#">Từ 2 tháng trước</a>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="d-flex align-items-baseline">
                                            <div id="frequent-user" class="h1 mb-3 me-2" style="height: 35px;" ></div>
                                            <div class="me-auto">
                                                <span class="text-green d-inline-flex align-items-center lh-1">
                                                    4% <!-- Download SVG icon from http://tabler-icons.io/i/trending-up -->
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="icon ms-1" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round"><path stroke="none" d="M0 0h24v24H0z" fill="none"/><polyline points="3 17 9 11 13 15 21 7" /><polyline points="14 7 21 7 21 14" /></svg>
                                                </span>
                                            </div>
                                        </div>
                                        <canvas id="active-user-chart" ></canvas>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="row row-cards">
                                    <div class="col-sm-3 col-lg-6">
                                        <div class="card card-sm">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-auto">
                                                        <span class="bg-blue text-white avatar"><!-- Download SVG icon from http://tabler-icons.io/i/currency-dollar -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-brand-apple-podcast" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <path d="M18.364 18.364a9 9 0 1 0 -12.728 0"></path>
                                                            <path d="M11.766 22h.468a2 2 0 0 0 1.985 -1.752l.5 -4a2 2 0 0 0 -1.985 -2.248h-1.468a2 2 0 0 0 -1.985 2.248l.5 4a2 2 0 0 0 1.985 1.752z"></path>
                                                            <circle cx="12" cy="9" r="2"></circle>
                                                            </svg>                                                        </span>
                                                    </div>
                                                    <div class="col">
                                                        <div class="font-weight-medium">
                                                            ${requestScope.totalUsers} Người dùng

                                                        </div>
                                                        <!--                                                            <div class="text-muted">
                                                                                                                        12 waiting payments
                                                                                                                    </div>-->
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-3 col-lg-6">
                                        <div class="card card-sm">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-auto">
                                                        <span class="bg-green text-white avatar"><!-- Download SVG icon from http://tabler-icons.io/i/shopping-cart -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-user" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <circle cx="12" cy="7" r="4"></circle>
                                                            <path d="M6 21v-2a4 4 0 0 1 4 -4h4a4 4 0 0 1 4 4v2"></path>
                                                            </svg>                                                            </span>
                                                    </div>
                                                    <div class="col">
                                                        <div class="font-weight-medium">
                                                            ${requestScope.activeUsers.size()} Người dùng đang hoạt động
                                                            
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div> 
                                    <div class="col-sm-3 col-lg-6">
                                        <div class="card card-sm">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-auto">
                                                        <span class="bg-twitter text-white avatar"><!-- Download SVG icon from http://tabler-icons.io/i/brand-twitter -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-man" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <circle cx="12" cy="5" r="2"></circle>
                                                            <path d="M10 22v-5l-1 -1v-4a1 1 0 0 1 1 -1h4a1 1 0 0 1 1 1v4l-1 1v5"></path>
                                                            </svg>                                                        </span>
                                                    </div>
                                                    <div class="col">
                                                        <div class="font-weight-medium">
                                                            ${requestScope.totalTopics} Chủ đề
                                                           
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 col-lg-6">
                                        <div class="card card-sm">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-auto">
                                                        <span class="bg-facebook text-white avatar"><!-- Download SVG icon from http://tabler-icons.io/i/brand-facebook -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-woman" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <circle cx="12" cy="5" r="2"></circle>
                                                            <path d="M10 22v-4h-2l2 -6a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1l2 6h-2v4"></path>
                                                            </svg>                                                        </span>
                                                    </div>
                                                    <div class="col">
                                                        <div class="font-weight-medium">
                                                             ${requestScope.totalCourses} Khóa học
                                                           
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 col-lg-6">
                                        <div class="card card-sm">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-auto">
                                                        <span class="bg-facebook text-white avatar"><!-- Download SVG icon from http://tabler-icons.io/i/brand-facebook -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-woman" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <circle cx="12" cy="5" r="2"></circle>
                                                            <path d="M10 22v-4h-2l2 -6a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1l2 6h-2v4"></path>
                                                            </svg>                                                        </span>
                                                    </div>
                                                    <div class="col">
                                                        <div class="font-weight-medium">
                                                             ${requestScope.totalPricePackages} Gói ưu đãi
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-6 col-lg-6">
                                        <div class="card card-sm">
                                            <div class="card-body">
                                                <div class="row align-items-center">
                                                    <div class="col-auto">
                                                        <span class="bg-facebook text-white avatar"><!-- Download SVG icon from http://tabler-icons.io/i/brand-facebook -->
                                                            <svg xmlns="http://www.w3.org/2000/svg" class="icon icon-tabler icon-tabler-woman" width="24" height="24" viewBox="0 0 24 24" stroke-width="2" stroke="currentColor" fill="none" stroke-linecap="round" stroke-linejoin="round">
                                                            <path stroke="none" d="M0 0h24v24H0z" fill="none"></path>
                                                            <circle cx="12" cy="5" r="2"></circle>
                                                            <path d="M10 22v-4h-2l2 -6a1 1 0 0 1 1 -1h2a1 1 0 0 1 1 1l2 6h-2v4"></path>
                                                            </svg>                                                        </span>
                                                    </div>
                                                    <div class="col">
                                                        <div class="font-weight-medium">
                                                           20 Blog
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>


                                    <!--                                    <div class="col-12">
                                                                            <div class="card card-sm">
                                                                                <form action="" method="POST" id="search-date" >
                                                                                    <div style="border: none;" class="card-header">
                                                                                        <h3 style="margin-right: 10px;" class="card-title">Tìm kiếm: </h3>
                                                                                        <label class="date-title" >Từ ngày: </label>
                                                                                        <input class="date-input" type="date" onchange="submitForm('search-date')" name="startDate" value="${requestScope.startDate}" />
                                                                                        <label class="date-title">Đến ngày: </label>
                                                                                        <input  class="date-input" type="date" name="endDate" onchange="submitForm('search-date')" value="${requestScope.endDate}"/>
                                                                                    </div>
                                                                                </form>
                                                                            </div>
                                                                        </div>-->
                                    <div  class="col-12">
                                        <div class="card">
                                            <img style="width: 100%; height: 90%" src="assets/img/dashboard.png" />
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <div class="col-6">
                                <div class="card">
                                    <canvas style="padding: 20px;" id="user-chart" ></canvas>

                                </div>
                            </div>

                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">Top 10 chủ đề nổi bật</h3>
                                    </div>
                                    <canvas style="padding: 20px;" id="popular-topic-chart" width="400" height="200"></canvas>
                                </div>
                            </div>
                            <div class="col-lg-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h3 class="card-title">Top 10 khóa học nổi bật</h3>
                                    </div>
                                    <canvas style="padding: 20px;" id="popular-course-chart" width="400" height="200"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
        <div>
            <input type="hidden" id="login-list" />
            <input type="hidden" id="register-list" />
            <input type="hidden" id="active-list" />
        </div>
                                                                                    
                                                                                    <div>
            <jsp:include page="../component/private-footer.jsp" ></jsp:include>
        </div>

        <!-- Libs JS -->
        <script src="admin/libs/apexcharts/dist/apexcharts.min.js" defer></script>
        <script src="admin/libs/jsvectormap/dist/js/jsvectormap.min.js" defer></script>
        <script src="admin/libs/jsvectormap/dist/maps/world.js" defer></script>
        <script src="admin/libs/jsvectormap/dist/maps/world-merc.js" defer></script>
        <!-- Tabler Core -->
        <script src="admin/js/tabler.min.js" defer></script>
        <script src="admin/js/demo.min.js" defer></script>
        <script></script>
        <script>
                                                          // @formatter:off
                                                          document.addEventListener("DOMContentLoaded", function () {
                                                              window.ApexCharts && (new ApexCharts(document.getElementById('chart-new-clients'), {
                                                                  chart: {
                                                                      type: "line",
                                                                      fontFamily: 'inherit',
                                                                      height: 40.0,
                                                                      sparkline: {
                                                                          enabled: true
                                                                      },
                                                                      animations: {
                                                                          enabled: false
                                                                      },
                                                                  },
                                                                  fill: {
                                                                      opacity: 1,
                                                                  },
                                                                  stroke: {
                                                                      width: [2, 1],
                                                                      dashArray: [0, 3],
                                                                      lineCap: "round",
                                                                      curve: "smooth",
                                                                  },
                                                                  series: [{
                                                                          name: "May",
                                                                          data: [37, 35, 44, 28, 36, 24, 65, 31, 37, 39, 62, 51, 35, 41, 35, 27, 93, 53, 61, 27, 54, 43, 4, 46, 39, 62, 51, 35, 41, 67]
                                                                      }, {
                                                                          name: "April",
                                                                          data: [93, 54, 51, 24, 35, 35, 31, 67, 19, 43, 28, 36, 62, 61, 27, 39, 35, 41, 27, 35, 51, 46, 62, 37, 44, 53, 41, 65, 39, 37]
                                                                      }],
                                                                  grid: {
                                                                      strokeDashArray: 4,
                                                                  },
                                                                  xaxis: {
                                                                      labels: {
                                                                          padding: 0,
                                                                      },
                                                                      tooltip: {
                                                                          enabled: false
                                                                      },
                                                                      type: 'datetime',
                                                                  },
                                                                  yaxis: {
                                                                      labels: {
                                                                          padding: 4
                                                                      },
                                                                  },
                                                                  labels: [
                                                                      '2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19'
                                                                  ],
                                                                  colors: ["#206bc4", "#a8aeb7"],
                                                                  legend: {
                                                                      show: false,
                                                                  },
                                                              })).render();
                                                          });
                                                          // @formatter:on
        </script>
        <script>
            // @formatter:off
            document.addEventListener("DOMContentLoaded", function () {
                window.ApexCharts && (new ApexCharts(document.getElementById('chart-revenue-bg'), {
                    chart: {
                        type: "area",
                        fontFamily: 'inherit',
                        height: 40.0,
                        sparkline: {
                            enabled: true
                        },
                        animations: {
                            enabled: false
                        },
                    },
                    dataLabels: {
                        enabled: false,
                    },
                    fill: {
                        opacity: .16,
                        type: 'solid'
                    },
                    stroke: {
                        width: 2,
                        lineCap: "round",
                        curve: "smooth",
                    },
                    series: [{
                            name: "Profits",
                            data: [37, 35, 44, 28, 36, 24, 65, 31, 37, 39, 62, 51, 35, 41, 35, 27, 93, 53, 61, 27, 54, 43, 19, 46, 39, 62, 51, 35, 41, 67]
                        }],
                    grid: {
                        strokeDashArray: 4,
                    },
                    xaxis: {
                        labels: {
                            padding: 0,
                        },
                        tooltip: {
                            enabled: false
                        },
                        axisBorder: {
                            show: false,
                        },
                        type: 'datetime',
                    },
                    yaxis: {
                        labels: {
                            padding: 4
                        },
                    },
                    labels: [
                        '2020-06-20', '2020-06-21', '2020-06-22', '2020-06-23', '2020-06-24', '2020-06-25', '2020-06-26', '2020-06-27', '2020-06-28', '2020-06-29', '2020-06-30', '2020-07-01', '2020-07-02', '2020-07-03', '2020-07-04', '2020-07-05', '2020-07-06', '2020-07-07', '2020-07-08', '2020-07-09', '2020-07-10', '2020-07-11', '2020-07-12', '2020-07-13', '2020-07-14', '2020-07-15', '2020-07-16', '2020-07-17', '2020-07-18', '2020-07-19'
                    ],
                    colors: ["#206bc4"],
                    legend: {
                        show: false,
                    },
                })).render();
            });
            // @formatter:on
        </script>
        <script>
            const courseChart = document.getElementById('popular-course-chart').getContext('2d');
            const topicChart = document.getElementById('popular-topic-chart').getContext('2d');

            var url = "authen/manager/dashboard";
            fetch(url, {method: "POST"}).then(response => response.json())
                    .then(result => {
                        var topicLables = result.topicLables;
                        var topicLearners = result.topicLearners;
                        var totalLearners = result.totalLearners;
                        console.log(topicLables);
                        createVerticalChartTopic(topicLables, topicLearners, totalLearners);

                        var courseLables = result.courseLables;
                        var courseLearners = result.courseLearners;
                        createHorizontalChart(courseLables, courseLearners, totalLearners);
                    });

            function createVerticalChartTopic(topicLables, topicLearners, totalLearners) {
                const myChart = new Chart(topicChart, {
                    type: 'bar',
                    data: {
                        labels: topicLables,
                        datasets: [{
                                label: 'Học viên',
                                data: topicLearners,
                                backgroundColor: 'rgba(0, 0, 200, 0.5)',
                                borderColor: [

                                ],
                                borderWidth: 1
                            }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true,
                                suggestedMax: totalLearners
                            }
                        }
                    }
                });
            }
            function createHorizontalChart(courseLables, courseLearners, totalLearners) {
                const myChart = new Chart(courseChart, {
                    type: 'bar',
                    data: {
                        labels: courseLables,
                        datasets: [{
                                label: 'Học viên',
                                data: courseLearners,
                                backgroundColor: 'rgba(0, 0, 200, 0.5)',
                                borderColor: [

                                ],

                                borderWidth: 1
                            }]
                    },
                    options: {
                        scales: {
                            x: {
                                beginAtZero: true,
                                suggestedMax: totalLearners
                            }
                        },
                        indexAxis: 'y',
                        // Elements options apply to all of the options unless overridden in a dataset
                        // In this case, we are setting the border of each horizontal bar to be 2px wide
                        elements: {
                            bar: {
                                borderWidth: 1,
                            }
                        },
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'right',
                            },

                        }
                    },
                });
            }

        </script>


        <script>
            var activeUserTable = $('#active-user-table').DataTable();
            var newUserTable = $('#new-user-table').DataTable();
            var loginUserTable = $('#login-user-table').DataTable();


            const activeUserChart = document.getElementById('active-user-chart').getContext('2d');
            const newUserChart = document.getElementById('new-user-chart').getContext('2d');
            const userChart = document.getElementById('user-chart').getContext('2d');
            window.onload = function () {

                var url = "authen/dashboard";
                fetch(url, {method: "POST"}).then(response => response.json())
                        .then(result => {
                            var groupLables = result.groupLables;
                            var totalUserData = result.totalUserData;
                            createDoughnutChart(groupLables, totalUserData);

                            var activeUserData = result.activeUserData;
                            var activeUserLabel = result.activeUserLabel;
                            var totalUsers = result.totalUsers;
//                                                                        

                            var newUserData = result.newUserData;
                            var newUserLabel = result.newUserLabel;

                            createVerticalChartUser(activeUserData, activeUserLabel, totalUsers);
                            createLineChart(newUserData, newUserLabel, totalUsers);
                        });
            }







            //                                                setInterval(getNewData, 2000);
            function getData(event, className, searchType) {
                var element = event.target;
//                                                                element.preventDefault();
                var choseOption = document.getElementById(className + "-option");
                choseOption.innerHTML = element.innerHTML;
                var options = document.getElementsByClassName(className);
                for (var i = 0; i < options.length; i++) {
                    options[i].className = options[i].className.replace(" active", "");
                }

                element.className += " active";
                var url = "authen/dashboard?searchDuration=" + element.innerHTML + "&searchType=" + searchType;
                fetch(url, {method: "POST"}).then(response => response.json())
                        .then(result => {
                            var activeUserData = result.activeUserData;
                            var activeUserLabel = result.activeUserLabel;
                            var frequentUsers = result.frequentUsers;
                            var registeredUsers = result.registeredUsers;
                            console.log(registeredUsers);
                            var fUser = document.getElementById('frequent-user');
                            var nUser = document.getElementById('new-user');
                            var newUserData = result.newUserData;
                            var newUserLabel = result.newUserLabel;
                            var totalUsers = result.totalUsers;
                            if (searchType === 'newUser') {
                                nUser.innerHTML = registeredUsers.length;
                                createLineChart(newUserData, newUserLabel, totalUsers);
                            } else {
//                                fUser.innerHTML = frequentUsers.length;
                                createVerticalChartUser(activeUserData, activeUserLabel, totalUsers);
                            }
                        });
            }

        </script>                                        
        <script>


            let myChart = new Chart(userChart);
            function createDoughnutChart(groupLables, totalUserData) {
                myChart.destroy();
                myChart = new Chart(userChart, {
                    type: 'doughnut',
                    data: {
                        labels: groupLables,
                        datasets: [{
                                label: 'Người dùng',
                                data: totalUserData,
                                backgroundColor: [
                                    'rgb(82, 215, 38)',
                                    'rgb(255, 236, 0)',
                                    'rgb(255, 115, 0)',
                                    'rgb(155, 191, 224)',
                                    'rgb(198, 214, 143)'
                                ],
                                borderColor: [

                                ],
                                hoverOffset: 6
                            }]
                    },
                });
            }


            let newUser = new Chart(newUserChart);
            function createLineChart(datas, labels, totalUsers) {
                newUser.destroy();

                const config = {
                    type: 'line',
                    data: {
                        labels: labels,
                        datasets: [{
                                label: 'Người dùng mới',
                                data: datas,
                                fill: false,
                                tension: 0.1,
                                backgroundColor: 'rgba(0, 0, 200, 0.5)',
                                borderColor: [

                                ],
                                borderWidth: 1
                            }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {

                            y: {
                                beginAtZero: true,
                                suggestedMax: totalUsers
                            },
                            x: {
                                ticks: {
                                    // Include a dollar sign in the ticks
                                    callback: function (value, index, ticks) {
                                        return '';
                                    }
                                }
                            }
                        }
                    }
                };
                newUser = new Chart(newUserChart, config);
            }


            let activeUser = new Chart(activeUserChart);
            function createVerticalChartUser(datas, labels, totalUsers) {
                activeUser.destroy();

                const config = {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                                label: 'Người dùng',
                                data: datas,
                                backgroundColor: 'rgba(0, 0, 200, 0.5)',
                                borderColor: [

                                ],
                                borderWidth: 1
                            }]
                    },
                    options: {
                        plugins: {
                            legend: {
                                display: false
                            }
                        },
                        scales: {

                            y: {
                                beginAtZero: true,
                                suggestedMax: totalUsers
                            },
                            x: {
                                ticks: {
                                    // Include a dollar sign in the ticks
                                    callback: function (value, index, ticks) {
                                        return '';
                                    }
                                }
                            }
                        }
                    }
                };
                activeUser = new Chart(activeUserChart, config);
            }
        </script>


    </body>
</html>