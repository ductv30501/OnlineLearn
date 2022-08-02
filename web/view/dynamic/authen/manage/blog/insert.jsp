<%-- 
    Document   : insert
    Created on : May 26, 2022, 1:50:18 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>

        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler-flags.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler-payments.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler-vendors.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
    </head>
    <style>
        .message {
            text-align: left;
            font-size: 14px;
            margin: 2px 6px;

            animation-name: myAnimation;
            animation-duration: 8000ms;
            animation-fill-mode: forwards;
        }
        .msg1{
            color: green;
        }
        .msg2{

            color: red;
        }
        @keyframes myAnimation{
            0%{
                opacity: 1;
                transform: rotateX(90deg);
            }
            50%{
                opacity: 0.7;
                transform: rotateX(0deg);
            }
            100%{
                display: none;
                opacity: 0;
                transform: rotateX(90deg);
            }
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
            z-index: 99;
            display: flex;
        }

        #insert-block-modal{

            margin: auto;
            width: 60%;

            padding: 15px 35px 15px 35px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 99;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }


    </style>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <script>

        function saveBlock() {
//            var heading = document.getElementsById("block-heading").value;
//            console.log(heading);

            $.ajax({
                url: "/onlinelearn/authen/marketing/post/insert/block",
                //Use when pass data to servlet

                cache: false,
                type: "POST",
                //return a response just declared in servlet
                success: function (data) {
                    var block = JSON.parse(data);

                    var tr =
                            `<tr>
                        <td>` + block.heading + `</td>
                        <td>` + block.content + `</td>
                        <td>` + block.img + `</td>
                        <td>` + block.quote + `</td>
                        <td>` + block.blog.blog_title + `</td>
                    </tr>`;
                    var listBlock = document.getElementById('block-list');
//                    listBlock.insertAdjacentHTML('beforeend', tr);
                    listBlock.innerHTML += tr;
//                    alert(listBlock.innerHTML);

                    closeModal('insert-block-modal', 0);
                },
                error: function (xhr) {

                }

            });

        }

        function openModal(id, position) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            modal[position].style.transform = "scale(1)";
            box.style.transform = "scale(1)";
        }
        function closeModal(id, position) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            modal[position].style.transform = "scale(0)";
            box.style.transform = "scale(0)";
        }

    </script>


    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1"></div>
            <div class="container col-lg-10" style="padding: 20px; margin-top: 20px; margin-bottom: 20px;  background: #fff; ">

                <form action = "insert" enctype="multipart/form-data" method ="POST">
                    <h3 class="card-title" style="font-size: 24px;">Thông tin bài đăng</h3>
                    <!--input of title-->
                    <label class="labels" for ="post_title">Nhập Tiêu Đề: </label>
                    <input id ="post_title" name="post_title" type="text" class="form-control" required="required">

                    <!--lelect category for post-->
                    <div>
                        <label class="labels" for ="topic_id">Chọn Chủ Đề Bài Đăng: </label>
                        <select name="cateid" id ="cateid" class ="form-control mb-2">                         
                        <c:forEach var="cate" items="${requestScope.categories}">
                            <option value="${cate.cate_id}">${cate.cate_title}</option>
                        </c:forEach>
                    </select>
                </div>

                <!--select author for post-->
                <div>
                    <label class="labels" for ="author">Chọn Tác Giả </label>
                    <select name="author" id = "author" class ="form-control">
                        <c:forEach var="auth" items="${requestScope.authors}">
                            <option value="${auth.username}">${auth.name}</option>
                        </c:forEach>
                    </select>
                </div>


                <div class="">
                    <label class="labels " for="public_date">Ngày Đăng</label>
                    <input  type="date" name="public_date" class ="form-control mb-2 col-md-6" required="required">
                </div>
                <div class="">
                    Chọn ảnh bìa <input style="margin-top: 10px" class="form-control" type="file" accept=".jpg, .jpeg, .png" name="thumnail" required="required">
                </div>

                <div class ="row mt-3 mb-4">
                    <div class ="col-md-2">
                        <input type="submit" value="Lưu thông tin" class ="mt-2 form-control-lg" style="font-size: 16px;">
                    </div>
                    <div class ="col-md-8 center mt-3">

                    </div>
                </div>


            </form>

        </div>
        <div class="col-lg-1"></div>
        <div>
            <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>

    </body>

    <!-- Libs JS -->
    <script src="../../../admin/libs/apexcharts/dist/apexcharts.min.js" defer></script>
    <script src="../../../admin/libs/jsvectormap/dist/js/jsvectormap.min.js" defer></script>
    <script src="../../../admin/libs/jsvectormap/dist/maps/world.js" defer></script>
    <script src="../../../admin/libs/jsvectormap/dist/maps/world-merc.js" defer></script>
    <!-- Tabler Core -->
    <script src="../../../admin/js/tabler.min.js" defer></script>
    <script src="../../../admin/js/demo.min.js" defer></script>

    <!--Link to Ajax jquery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</html>

