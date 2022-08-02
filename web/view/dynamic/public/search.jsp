<%-- 
    Document   : search
    Created on : Jul 11, 2022, 1:47:53 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search | Khóa học</title>

        <!--link css for header-->
        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">
        <link href="css/style.css" rel="stylesheet">


        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>

        <style>
            .logo {
                padding-left: 40px;
                box-sizing: border-box;
            }

            /*------------------------------- CSS for navigation bar ------------------------*/
            /* Fixed sidenav, full height */

            input[type=checkbox] {
                transform: scale(1.5);
            }

            .sidenav {
                height: 100%;
                z-index: 1;
                top: 0;
                left: 0;
                /*background-color: #F5F7F8;*/
                overflow-x: hidden;
                padding-top: 20px;
            }

            .body-container {
                display: flex;
                flex-direction: row;
                flex-wrap: nowrap;
                justify-content: space-between;
                align-items: stretch;
            }

            /* Style the sidenav links and the dropdown button */
            .sidenav a, .dropdown-btn {
                padding: 6px 8px 6px 16px;
                text-decoration: none;
                font-size: 20px;
                color: #000;
                display: block;
                border: none;
                background: none;
                width: 100%;
                text-align: left;
                cursor: pointer;
                outline: none;
            }

            /* On mouse-over */
            .sidenav a:hover, .dropdown-btn:hover {
                color: #FF7700;
            }

            /* Main content */
            .main {
                margin-left: 200px; /* Same as the width of the sidenav */
                font-size: 20px; /* Increased text to enable scrolling */
                padding: 0px 10px;
            }

            /* Add an active class to the active dropdown button */
            /*            .active {
                            background-color: green;
                            color: white;
                        }*/

            /* Dropdown container (hidden by default). Optional: add a lighter background color and some left padding to change the design of the dropdown content */
            .dropdown-container {
                display: none;
                /*background-color: #ccc;*/
                padding-left: 24px;
            }

            /* Optional: Style the caret down icon */
            .fa-caret-down {
                float: right;
                padding-right: 8px;
            }

            /* Some media queries for responsiveness */
            @media screen and (max-height: 450px) {
                .sidenav {
                    padding-top: 15px;
                }
                .sidenav a {
                    font-size: 18px;
                }
            }

            .filter{
                margin-top: 80px;
                margin-bottom: 40px;
            }

            .topicItem {
                margin-top: 4px;
                font-size: 18px;
                color: #000;
                display: flex;
                flex-direction: row;
                flex-wrap: nowrap;
                justify-content: flex-start;
                align-items: center;
                height: 40px;
                /*                border: 1px solid black;*/
            }

            .topic-radio {
                margin-right: 5px;
            }

            .pagination {
                display: inline-block;
            }

            .pagination a {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border-radius: 5px;
            }

            .pagination a:hover:not(.active) {
                background-color: #ddd;
                border-radius: 5px;
            }

            /*--------------------- css for tap butn -------------------------*/

            /* Style the tab */
            .tab {
                overflow: hidden;
                border: 1px solid #ccc;
                background-color: #f1f1f1;
            }

            /* Style the buttons inside the tab */
            .tab button {
                background-color: inherit;
                float: left;
                border: none;
                outline: none;
                cursor: pointer;
                padding: 14px 16px;
                transition: 0.3s;
                font-size: 17px;
            }

            /* Change background color of buttons on hover */
            .tab button:hover {
                background-color: #ddd;
            }

            /* Create an active/current tablink class */
            .tab button.active {
                background-color: #ccc;
            }

            /* Style the tab content */
            .tabcontent {
                display: none;
                padding: 6px 12px;
                border: 1px solid #ccc;
                border-top: none;
            }

        </style>


    </head>
    <body>
        <div class="header">
            <jsp:include page="../user/learner/header.jsp"></jsp:include>
            </div>
        </div>


        <div class="tabcontent-course" id="course-body">
            <div class="body-container">
            <c:set var="query" value="${requestScope.query}"></c:set>
                <div class="sidenav col-lg-2">
                    <div class="filter">
                        <h3 class="text-center">Lọc kết quả theo:</h3>
                    </div>

                    <button class="dropdown-btn">Topic
                        <i class="fa fa-caret-down"></i>
                    </button>
                    <div class="dropdown-container">
                        <form action="search" method="post">
                        <c:forEach var="topic" items="${requestScope.topics}">
                            <c:set var="topicId" value="${topic.topicId}"></c:set>
                            <c:set var="pIndex" value="${requestScope.index}"></c:set>
                            <div class="topicItem" onclick="sendTopic('${query}', ${topicId}, ${pIndex}, 0)">
                                <div class="topic-radio" >
                                    <input type="checkbox" id="topicPicker${topicId}" class="topic-group" name="topic" value="${topic.topicId}">
                                </div>
                                <div>
                                    <label class="topic-lable">${topic.topicName}</label>
                                </div>

                            </div>

                        </c:forEach>
                    </form>

                </div>
                <button class="dropdown-btn">Rate
                    <i class="fa fa-caret-down"></i>
                </button>
                <div class="dropdown-container">
                    <form action="search" method="post">
                        <c:forEach var="i" begin="0" end="5">
                            <c:set var="pIndex" value="${requestScope.index}"></c:set>
                            <div class="rate-layout"  onclick="sendTopic('${query}', 0, ${pIndex}, ${i})">
                                
                                
                                <input <c:if test="${i == 0}" >type="hidden"</c:if> type="checkbox" id="ratePicker${i}" class="star-group" name="rate" value="${i}">
                                <label <c:if test="${i == 0}" >style="display: none;"</c:if> >Từ ${i-1} đến ${i} <i class="fas fa-star"></i></label>
                            </div>
                        </c:forEach>

                    </form>
                </div>
            </div>

            <div class="container-fluid py-5 custom-paging">
                <div class="container py-5">
                    <div class="text-center mb-5">
                        <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Khóa học</h5>
                        <h1>Kết quả tìm kiếm</h1>
                    </div>

                    <div class="row" id="course-js">
                        <c:forEach var="course" items="${requestScope.result}">
                            <div class="col-lg-3 col-md-6 mb-3">
                                <div class="rounded overflow-hidden mb-2">
                                    <img class="img-fluid" src="${course.avatar}" alt="" style="max-height: 264px; min-height: 248px; width: 100%">
                                    <div class="bg-secondary p-4">
                                        <div class="d-flex justify-content-between mb-3">
                                            <small class="m-0"><i class="fa fa-users text-primary mr-2"></i>${course.totalLearner} Học viên</small>
                                            <small class="m-0"><i class="far fa-clock text-primary mr-2"></i>${totalTime}</small>
                                        </div>
                                        <a class="h5" href="">${course.courseTitle}</a>
                                        <div class="border-top mt-4 pt-4">
                                            <div class="d-flex justify-content-between">
                                                <h6 class="m-0"><i class="fa fa-star text-primary mr-2"></i>${course.rate} <small>(0 đánh giá)</small></h6>
                                                <!--<h5 class="m-0">$99</h5>-->
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <div class="pagination">
                    <a href="#">&laquo;</a>
                    <c:forEach var="i" begin="1" end="${requestScope.countPaging}">
                        <a onclick="sendPagingReq('${requestScope.query}', ${i})">${i}</a>
                    </c:forEach>
                    <a href="#">&raquo;</a>
                </div>
            </div>
        </div>




        <div>
            <jsp:include page="../component/footer.jsp"></jsp:include>
        </div>

        <script>
            /* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
            var dropdown = document.getElementsByClassName("dropdown-btn");
            var i;

            for (i = 0; i < dropdown.length; i++) {
                dropdown[i].addEventListener("click", function () {
                    this.classList.toggle("active");
                    var dropdownContent = this.nextElementSibling;
                    if (dropdownContent.style.display === "block") {
                        dropdownContent.style.display = "none";
                    } else {
                        dropdownContent.style.display = "block";
                    }
                });
            }
        </script>

        <script>
            function sendTopic(query, topicId, index, starId) {


                var elemId = 'topicPicker' + topicId;
                var starId = 'ratePicker' + starId;
                var topicPicker = document.getElementById(elemId);
                var starPicker = document.getElementById(starId);
                
                if (topicId != 0) {
                    if (!topicPicker.checked) {
                        topicPicker.checked = true;
                    } else {
                        topicPicker.checked = false;
                    }
                }

                if (starId != 0) {
                    if (!starPicker.checked) {
                        starPicker.checked = true;
                    } else {
                        starPicker.checked = false;
                    }
                }


                var groupTopic = document.querySelectorAll('input[name=topic]:checked');
                var starTopic = document.querySelectorAll('input[name=rate]:checked');

                var starIds = [];
                var topicIds = [];
                var topicReq = "";
                var starReq = "";

                $('input[name=topic]:checked').each(function () {
                    topicIds.push(this.value);
                    topicReq += "&";
                });
                $('input[name=rate]:checked').each(function () {
                    starIds.push(this.value);
                });

                $.ajax({
                    //                type: "GET",
                    url: "/onlinelearn/search/filter?query=" + query + "",
                    //                dataType: 'json',

                    data: {
                        topic: topicIds,
                        rate: starIds,
                        index: index
                    },
                    success: function (data) {
                        var row = document.getElementById('course-js');
                        row.innerHTML = data;
                        console.log(query);
                    },
                    error: function (request, status, errorThrown) {
                        console.log(request);
                        console.log(status);
                        console.log(errorThrown);
                    }
                });
            }


            function sendPagingReq(query, index) {
                //get all topic active checkbox
                var groupTopic = document.querySelectorAll('input[name=topic]:checked');
                var starTopic = document.querySelectorAll('input[name=rate]:checked');

                var starIds = [];
                var topicIds = [];
                var topicReq = "";
                var starReq = "";

                $('input[name=topic]:checked').each(function () {
                    topicIds.push(this.value);
                    topicReq += "&";
                });
                $('input[name=rate]:checked').each(function () {
                    starIds.push(this.value);
                });

                $.ajax({
                    type: "GET",
                    url: "/onlinelearn/search/paging?query=" + query + "&index=" + index + "",
                    //                dataType: 'json',
                    data: {
                        query: query,
                        index: index,
                        topic: topicIds,
                        rate: starIds
                    },
                    success: function (data) {
                        var row = document.getElementById('course-js');
                        row.innerHTML = data;
                    },
                    error: function (request, status, errorThrown) {
                        console.log(request);
                        console.log(status);
                        console.log(errorThrown);
                    }
                });
            }

        </script>
        <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
        <script type="text/javascript" src="assets/js/slider.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

</body>

</html>
