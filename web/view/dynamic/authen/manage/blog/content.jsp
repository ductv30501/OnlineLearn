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
        <title>Nội Dung Blog</title>
        <!--<link href="../../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">-->
        <link href="../../../../admin/css/demo.min.css" rel="stylesheet"/>

        <link href="../../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../../admin/css/tabler-flags.min.css" rel="stylesheet"/>
        <link href="../../../../admin/css/tabler-payments.min.css" rel="stylesheet"/>
        <link href="../../../../admin/css/tabler-vendors.min.css" rel="stylesheet"/>
        <link href="../../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />    
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

        .modal{
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

        .edit-modal{
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

        #edit-block-modal{

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

        .delete-modal{
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

        #delete-block-modal{

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

        button {
            border: #ccc ;
            background: #ccc;
            /*width: 40px;*/
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
                data: form.serialize(),
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
//            console.log(box);
            var modal = document.getElementsByClassName('modal');
//            console.log(modal);
            modal[position].style.transform = "scale(1)";
            box.style.transform = "scale(1)";
        }
        function closeModal(id, position) {
            var box = document.getElementById(id);

            var modal = document.getElementsByClassName('modal');

            modal[position].style.transform = "scale(0)";
            box.style.transform = "scale(0)";

        }

        function openEditModel(id, position) {
            var box = document.getElementById(id);
//            console.log(box);
            var modal = document.getElementsByClassName('edit-modal');
//            console.log(modal);
            var heading = document.getElementById('heading').value;

            modal[position].style.transform = "scale(1)";
            console.log(modal[position]);
            box.style.transform = "scale(1)";
        }


        function closeEditModal(id, position) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('edit-modal');
            modal[position].style.transform = "scale(0)";
            box.style.transform = "scale(0)";
        }

        function deleteStudent(bid, pid) {
            var result = confirm("Are you sure?");
            if (result)
            {
                window.location.href = "../delete/content?bid=" + bid + "&pid=" + pid;
            }
        }

        var editor = '';
        $(document).ready(function () {
            $('.content').each(function () {
                var x = CKEDITOR.replace($(this).prop('id'));
//                test language
//               CKEDITOR.config.language = 'vi';

            });

            var y = document.getElementById('block-paragraph');
            CKEDITOR.replace(y);
            CKEDITOR.config.language = 'vi';
        });


        function show(id) {
            var block = document.getElementById(id);
            if (block.className === "collapse") {
                block.className = "";
            } else {
                block.className = "collapse";

            }
        }
    </script>


    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1"></div>
            <div class=" container col-lg-10">
                <div class ="row mt-3" style="">
                    <div class="col-lg-7">

                        <div class="card">
                            <div class="card-body">
                                <h1 class="card-title" style="font-size: 24px;">${requestScope.blog.blog_title}</h1>
                            <h2>Nhập nội dung cho từng khối</h2>

                            <c:forEach var="block" items="${requestScope.blocks}">

                                <!--Edit modal-->
                                <form action="../../post/content/edit?id=${block.block_id}" enctype="multipart/form-data" method="POST">
                                    <div>
                                        <div class="block">

                                            <input type="hidden" name="bid" value="${block.block_id}">
                                            <!--block heading-->
                                            <label class="labels" for ="block-heading">Đề mục của khối</label>
                                            <input type="text" name="heading" value="${block.heading}" id = "heading" class ="form-control">

                                            <button type="button" onclick="show(${block.block_id})" class="mb-2">
                                                Xem nội dung <i class="fas fa-expand-alt"></i>
                                            </button>
                                            <div id="${block.block_id}" class="collapse mt-2">
                                                <div class="labels">

                                                    <textarea class="content" id="content${block.block_id}" name="content${block.block_id}" class ="form-control mb-2" required="required" style="min-height: 200px">${block.content}</textarea>
                                                </div>
                                                <div>
                                                    <input type="submit" value="Chỉnh sửa" />
                                                    <input onclick="closeEditModal('edit-block-modal', 0)" type="button" value="Đóng" />
                                                    <input type="button" value="Xóa Block" onclick="deleteStudent(${block.block_id}, ${requestScope.blog.blog_id})"/>
                                                </div>
                                            </div>
                                            <!--block content-->

                                            <div>
                                                <input type="hidden" name="postId" value="${requestScope.pid}">
                                            </div>
                                        </div>
                                    </div>
                                </form>

                            </c:forEach>
                        </div>
                    </div>

                </div>

                <!--input information of post-->
                <div class = "col-lg-5" style="background-color: #fff; padding: 10px; border-radius: 5px;" >      
                    <form action = "../edit" enctype="multipart/form-data" method ="POST">

                        <input type="hidden" name="postid" value="${requestScope.blog.blog_id}">

                        <h3 class="card-title" style="font-size: 24px;">Thông tin bài đăng</h3>
                        <!--input of title-->
                        <label class="labels" for ="post_title">Tiêu đề bài đăng: </label>
                        <input id ="post_title" name="post_title" value="${requestScope.blog.blog_title}" type="text" class="form-control" required="required">

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
                            <input  type="date" name="public_date" value="${requestScope.blog.public_date}" class ="form-control mb-2 col-md-6" required="required">
                        </div>
                        <div class="">
                            Chọn ảnh bìa <input style="margin-top: 10px" class="form-control" type="file" accept=".jpg, .jpeg, .png" name="thumnail" required="required" value="${requestScope.blog.avatar}">
                        </div>

                        <div class="">
                            <label class="labels " for="ispublic">Trạng thái</label>
                            <br>
                            <div class="form-control mt-2">
                                <input type="radio" name="ispubic" value="1" <c:if test="${requestScope.blog.is_public == true}">checked="checked"</c:if>/>Công khai
                                <input type="radio" name="ispubic" value="0" <c:if test="${requestScope.blog.is_public == false}">checked="checked"</c:if>/>Riêng tư
                                </div>

                            </div>

                            <div class ="row mt-3 mb-4">
                                <div class ="text-center">
                                    <input type="submit" value="Cập nhật" class ="mt-2 form-control-lg" style="font-size: 16px; display: inline-block;">
                                    <a href="http://localhost:8080/onlinelearn/blog/content?pid=${requestScope.blog.blog_id}" style="display: inline-block;">
                                    <input type="button" value="Xem trước" class ="mt-2 form-control-lg" style="font-size: 16px;display: inline-block; " >
                                </a>
                            </div>
                            <div class ="col-md-8 center mt-3">

                            </div>
                        </div>

                        <!--                    <div>
                                                <p>Chọn thẻ</p>
                                                <div>
                        <c:forEach var="tag" items="${requestScope.tags}">
                            <input type="checkbox" name="tag" value="${tag.tag_title}" />
                            <label class="labels" for="tags">${tag.tag_title}</label>
                            <br>
                        </c:forEach>
                    </div>
                </div>-->
                    </form>
                </div>
            </div>

            <!--insert modal-->
            <form action="content" method="POST">
                <div class="modal" >
                    <div id="insert-block-modal" class="block" style="border: 1px solid red">

                        <!--block heading-->
                        <label class="labels" for ="block-heading">Đề mục của khối</label>
                        <input type="text" name="heading" id = "heading" class ="form-control">

                        <!--block content-->
                        <div class="labels">
                            <label class="labels mt-2 mt-3" for="cotent">Nhập nội dung văn bản</label>
                            <textarea id="block-paragraph" name="insert-content" class ="form-control mb-2" required="required" style="min-height: 200px"></textarea>
                        </div>

                        <!--block quote-->
                        <div class="labels">
                            <label class="labels mt-2 mt-3" for="public_date">Nhập Trích dẫn (nếu có)</label>
                            <input id="quote" type="text" name="quote" class ="form-control mb-2">
                        </div>
                        <div>
                            <input type="hidden" name="postid" value="${requestScope.pid}">
                        </div>

                        <div>
                            <input type="submit" value="Lưu thông tin" />
                            <input onclick="closeModal('insert-block-modal', 0)" type="button" value="Dong" />
                        </div>
                    </div>
                </div>
            </form>

            <!--Edit modal-->
            <form action="../../content/edit" method="POST">
                <div class="edit-modal" >
                    <div id="edit-block-modal" class="block">

                        <!--block heading-->
                        <label class="labels" for ="block-heading">Đề mục của khối</label>
                        <input type="text" name="heading" id = "heading" class ="form-control">

                        <!--block content-->
                        <div class="labels">
                            <label class="labels mt-2 mt-3" for="cotent">Nhập nội dung văn bản</label>
                            <textarea id="block-paragraph" name="content" class ="form-control mb-2" required="required" style="min-height: 200px"></textarea>
                        </div>

                        <!--block quote-->
                        <div class="labels">
                            <label class="labels mt-2 mt-3" for="public_date">Nhập Trích dẫn (nếu có)</label>
                            <input id="quote" type="text" name="quote" class ="form-control mb-2">
                        </div>
                        <div>
                            <!--<input type="hidden" name="postid" value="${requestScope.pid}">-->
                        </div>

                        <div>
                            <input type="submit" value="Lưu thông tin" />
                            <input onclick="closeEditModal('edit-block-modal', 0)" type="button" value="Dong" />
                        </div>
                    </div>
                </div>
            </form>
            <div class = "">
                <button onclick="openModal('insert-block-modal', 0)" id="addBlock-btn">thêm</button>
            </div>
        </div>
        <div class="col-lg-1"></div>

    </body>

    <!-- Libs JS -->
    <script src="../../../../admin/libs/apexcharts/dist/apexcharts.min.js" defer></script>
    <script src="../../../../admin/libs/jsvectormap/dist/js/jsvectormap.min.js" defer></script>
    <script src="../../../../admin/libs/jsvectormap/dist/maps/world.js" defer></script>
    <script src="../../../../admin/libs/jsvectormap/dist/maps/world-merc.js" defer></script>
    <!-- Tabler Core -->
    <script src="../../../../admin/js/tabler.min.js" defer></script>
    <script src="../../../../admin/js/demo.min.js" defer></script>

    <!--Link to Ajax jquery-->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!--<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>-->
    <script src="../../../../ckeditor/ckeditor.js" type="text/javascript"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</html>

