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
        
        
    </style>

    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
        <div class ="row mt-3" style="">
                <div class = "col-lg-1"></div>
                <div class="col-lg-10">
                    <div class="card">
                        <div class="card-body">
                            <form action = "insert"  method ="POST" enctype="multipart/form-data">
                                <h3 class="card-title mt-3 mb-3" style="font-size: 24px;">Thêm Khóa Học</h3>
                                <label class="labels mt-2 mb-2" for ="course_title">Nhập Tên Khóa Học: </label><input id ="course_title" name="course_title" type="text" class="form-control"required>
                                <label class="labels mt-2 mb-2 mt-3" for ="topic_id">Chọn Chủ Đề: </label>
                                <select name="topic_id" id ="topic_id" class ="form-control mb-2">
                                <c:forEach items="${listTopic}" var ="t">
                                    <option value = ${t.topicId}>${t.topicName}</option>
                                </c:forEach>
                            </select>
                            <h3></h3>
                            <label class="labels mb-2 mt-3" for ="username_expert">Chọn giáo viên: </label>
                            <select name="username_expert" id = "username_expert" class ="form-control">
                                <c:forEach items="${listExpert}" var ="t">
                                    <option value = ${t.username}>${t.name}</option>
                                </c:forEach>
                            </select>
                            <div class="mb-3 mt-3">
                                Chọn ảnh: <input style="margin-top: 10px" class="form-control" type="file" accept=".jpg, .jpeg, .png" name="img" required>
                            </div>

                            <label class="labels mb-2" for ="description">Mô tả khóa học: </label><input name="description" id ="description" type="text" class="form-control">
                            <div class ="row mt-3 mb-4">
                                <div class ="col-md-2">
                                    <input type="submit" id="submit" value = "Lưu thông tin" class ="mt-2 form-control-lg" style="font-size: 16px;">
                                </div>
                                <div class ="col-md-8 center mt-3">
                                    <p class="message msg1">
                                        <c:if test = "${requestScope.msg==1}">
                                            Thêm Thành Công
                                        </c:if>
                                    </p>
                                    <p class="message msg2">
                                        <c:if test = "${requestScope.msg==2}">
                                            Thêm Không Thành Công
                                        </c:if>
                                    </p>
                                </div>
                            </div>


                        </form>

                    </div>
                </div>

            </div>
            <div class = "col-lg-1"></div>
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
</html>

