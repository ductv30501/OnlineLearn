<%-- 
    Document   : listuser
    Created on : May 31, 2022, 1:04:56 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Bootstrap CRUD Data Table for Database with Modal Form</title>
        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>-->
        <!--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>-->
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="../../../assets/css/data-table-js.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">

        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../css/tabler.css" rel="stylesheet"/>
        <link href="../../../js/main.js" rel="stylesheet"/>
        <title>JSP Page</title>
        <style>
            .input-box.button{
                color: #fff;
                letter-spacing: 1px;
                border: none;
                background: #FF6600;
                cursor: pointer;
            }
            
            .input-box.button:hover{
                background: #0e4bf1;
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


            #add-slider-modal,
            #edit-slider-modal{
                top: 5%;
                left: 10%;
                width: 60%;
                /*height: 25vh;*/
                position: absolute;
                padding: 15px 35px 15px 35px;
                background: #fff;
                transform: scale(0);
                transition-duration: 0.4s;
                z-index: 10;
                border-radius: 5px;
                box-shadow: 0px 0px 1px 1px #ccc;
            }


            #add-slider-modal .title,
            #edit-slider-modal .title{
                font-size: 25px;
                font-weight: 500;
                position: relative;
                margin-bottom: 30px;
            }
            #add-slider-modal .title::before,
            #edit-slider-modal .title::before{
                content: "";
                position: absolute;
                left: 0;
                bottom: 0;
                top: 45px;
                height: 2px;
                width: 100%;
                border-radius: 5px;
                background: linear-gradient(135deg, #71b7e6, #9b59b6);
            }
            
            #add-slider-modal .content form .form-upper-detail,
            #edit-slider-modal .content form .form-upper-detail{
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                margin: 20px 0 12px 0;
            }
            
            form .form-upper-detail .input-box{
                margin-bottom: 15px;
                width: 100%;
            }
            
            form .input-box span.details{
                display: block;
                font-weight: 500;
                margin-bottom: 5px;
            }
            
            .form-upper-detail .input-box input{
                height: 45px;
                width: 100%;
                outline: none;
                font-size: 16px;
                border-radius: 5px;
                padding-left: 15px;
                border: 1px solid #ccc;
                border-bottom-width: 2px;
                transition: all 0.3s ease;
            }
            .form-upper-detail .input-box input:focus,
            .form-upper-detail .input-box input:valid{
                border-color: #9b59b6;
            }

            form .button{
                height: 45px;
                box-sizing: border-box;

                width: 100%;
                margin: 35px 0;
                /*border: 1px solid #000;*/
            }
            form .button input{
                display: inline-block;
                height: 100%;
                width: 49.5%;
                border-radius: 5px;
                border: none;
                color: #fff;
                font-size: 18px;
                font-weight: 500;
                letter-spacing: 1px;
                cursor: pointer;
                transition: all 0.3s ease;

                background: #FFC107;
            }
            form .button input:hover{
                /* transform: scale(0.99); */
                background: #03A9F4;
            }
            @media(max-width: 584px){
                .container{
                    max-width: 100%;
                }
                form .form-upper-detail .input-box{
                    margin-bottom: 15px;
                    width: 100%;
                }

                .content form .form-upper-detail{
                    max-height: 300px;
                    overflow-y: scroll;
                }
                .form-upper-detail::-webkit-scrollbar{
                    width: 5px;
                }
            }



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
                margin: 30px 0;
            }
            .table-wrapper {
                background: #fff;
                padding: 20px 25px;
                border-radius: 3px;
                /*min-width: 1000px;*/
                box-shadow: 0 1px 1px rgba(0,0,0,.05);
            }
            .table-title {
                padding-bottom: 15px;
                /*background: #435d7d;*/
                /*color: #fff;*/
                padding: 16px 30px;
                min-width: 100%;
                margin: -20px -25px 10px;
                border-radius: 3px 3px 0 0;
            }
            .table-title h2 {
                margin: 5px 0 0;
                font-size: 24px;
            }
            .table-title .btn-group {
                float: right;
            }
            .table-title .btn {
                color: #fff;
                float: right;
                font-size: 13px;
                border: none;
                min-width: 50px;
                border-radius: 2px;
                border: none;
                outline: none !important;
                margin-left: 10px;
            }
            .table-title .btn i {
                float: left;
                font-size: 21px;
                margin-right: 5px;
            }
            .table-title .btn span {
                float: left;
                margin-top: 2px;
            }
            table {
                width: 100%;
            }


            tbody {
                display: block;
                /*width: 80vw;*/
                overflow: auto;
            }
            thead, tbody tr {
                display: table;
                width: 100%;
                table-layout: fixed;/* even columns width , fix width of table too*/
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

            table.table tr th, table.table tr td {
                border-color: #e9e9e9;
                padding: 12px 15px;
                vertical-align: middle;
                overflow: auto;

            }


            table.table tr th:first-child,
            table.table tr td:first-child {
                width: 100px;
                height: 20px;

            }


            table.table-striped tbody tr:nth-of-type(odd) {
                background-color: #fff;
            }
            table.table-striped.table-hover tbody tr:hover {
                background: #f5f5f5;
            }
            table.table th i {
                font-size: 13px;
                margin: 0 5px;
                cursor: pointer;
            }



            .pagination {
                float: right;
                margin: 0 0 5px;
            }
            .pagination li a {
                border: none;
                font-size: 13px;
                min-width: 30px;
                min-height: 30px;
                color: #999;
                margin: 0 2px;
                line-height: 30px;
                border-radius: 2px !important;
                text-align: center;
                padding: 0 6px;
            }
            .pagination li a:hover {
                color: #666;
            }
            .pagination li.active a, .pagination li.active a.page-link {
                background: #03A9F4;
            }
            .pagination li.active a:hover {
                background: #0397d6;
            }
            .pagination li.disabled i {
                color: #ccc;
            }
            .pagination li i {
                font-size: 16px;
                padding-top: 6px
            }
            #commit-modal {
                top: 0;
                left: 35%;
                width: 25%;
                /*height: 25vh;*/
                position: absolute;
                padding: 15px 35px 15px 35px;
                background: #fff;
                transform: scale(0);
                transition-duration: 0.3s;
                z-index: 10;
                border-radius: 5px;
                /*border: 1px solid #000;*/
                box-shadow: 1px 1px 1px 1px #ccc;
            }


            .btn-action button:nth-of-type(1),
            .btn-action button:nth-of-type(2),
            .insert-btn{
                display: inline-block;
                padding: 10px;
                box-sizing: border-box;
                border-radius: 5px;
                background-color: #FFC107;
                border: none;
                color: #fff;
                font-weight: 600;
            }
            .btn-action button:nth-of-type(1):hover,
            .btn-action button:nth-of-type(2):hover,
            .insert-btn:hover{
                background: #03A9F4;
            }
            .btn-action button:nth-of-type(1) {
                width: 48%;
                margin-right: 10px;

            }
            .btn-action button:nth-of-type(2) {
                width: 48.5%;

            }


        </style>

    </head>
    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1"></div>
            <div class="container col-lg-10" style="padding: 0px; ">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title">
                            <div class="row">
                                <div class="col-sm-6">
                                    <h2>Danh sách slider</h2>
                                </div>
                                <div class="col-sm-6">
                                    <button onclick="modal('add-slider-modal', 0, 'scale(1)')" class="btn btn-success"><i class="material-icons">&#xE147;</i> <span>Thêm mới</span></button>
                                </div>
                            </div>
                        </div>
                        <table id="mytable" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Hành động</th>
                                    <th>Tiêu đề slider</th>
                                    <th>Nội dung slider</th>
                                    <th>Trạng thái</th>
                                </tr>
                            </thead>
                            <tbody id="slider-list" >
                            <c:set var="index" value="1" ></c:set>
                            <c:forEach var="slider" items="${requestScope.sliders}">
                                <tr id="${slider.sliderId}" >
                                    <td><button type="button" onclick="commit(${slider.sliderId}, 'Tất cả thông tin liên quan đến slider sẽ bị xóa! Bạn có muốn tiếp tục?')" ><i class="fa fa-trash" ></i></button>
                                        <button type="button" onclick="editSlider(${slider.sliderId})" ><i class="fa fa-pencil" ></i></button>
                                    </td>
                                    <td>${slider.sliderTitle}</td>
                                    <td>${slider.sliderContent}</td>
                                    <td>
                                        <c:if test="${slider.status}" >
                                            Công khai
                                        </c:if>
                                        <c:if test="${!slider.status}" >
                                            Ẩn
                                        </c:if>
                                    </td>
                                </tr> 
                                <c:set var="index" value="${index + 1}" ></c:set>

                            </c:forEach>		

                        </tbody>
                    </table>

                </div>
            </div>        
        </div>

        <!-- Add Modal -->
        <div class="modal">
            <div id="add-slider-modal">
                <div class="title">Thêm mới slider</div>
                <div class="content">
                    <form action="insert" method="POST" enctype="multipart/form-data" >
                        <div class="form-upper-detail">
                            <div class="input-box">
                                <span class="details">Tiêu đề</span>
                                <input name="sliderTitle" type="text" placeholder="Nhập tiêu đề" required>
                            </div>
                            <div class="input-box">
                                <span class="details">Nội dung</span>
                                <textarea name="sliderContent" cols="97" rows="6" placeholder="Nhập mô tả" required></textarea>
                            </div>
                        </div>
                        <div class="input-box">
                            <span class="details">Trạng thái</span>
                            <input type="radio" name="status" value="true"   />
                            <label> Công khai </label>
                            <input type="radio" name="status" value="false" />
                            <label>Ẩn</label>
                        </div>
                        <div class="input-box">
                            <span class="details">Ảnh slider</span>
                            <input id="file-image-1" onchange="previewAvatar(1);" type="file" accept=".png, .jpg, .jpeg" name="sliderImg" />
                        </div>
                        <div class="input-box">
                            <span class="details">Xem trước ảnh</span>
                            <img  id="avatar-1" width="200px" height="150px" src="" />
                        </div>
                        <div class="button">
                            <input type="submit" value="Lưu">
                            <input type="button" onclick="modal('add-slider-modal', 0, 'scale(0)')" value="Hủy"> 
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div class="modal">
            <div id="edit-slider-modal">
                <div class="title">Chỉnh sửa slider</div>
                <div class="content">
                    <form action="edit" method="POST" enctype="multipart/form-data" >
                        <div class="form-upper-detail">
                            <div class="input-box">
                                <input class="edit-slider" type="hidden" name="sliderId" />
                                <span class="details">Tiêu đề</span>
                                <input class="edit-slider" name="sliderTitle" type="text" placeholder="Nhập tiêu đề" required>
                            </div>
                            <div class="input-box">
                                <span class="details">Nội dung</span>
                                <textarea  class="edit-slider" name="sliderContent" cols="97" rows="6" placeholder="Nhập nội dung" required></textarea>
                            </div>
                        </div>
                        <div class="input-box">
                            <span class="details">Trạng thái</span>
                            <input type="radio" name="status" value="true"   />
                            <label> Công khai </label>
                            <input type="radio" name="status" value="false" />
                            <label>Ẩn</label>
                        </div>
                        <div class="input-box">
                            <span class="details">Ảnh slider</span>
                            <input id="file-image-2" onchange="previewAvatar(2);" type="file" accept=".jpg, .jpeg, .png" name="sliderImg" />
                        </div>
                        <div class="input-box">
                            <span class="details">Xem trước ảnh</span>
                            <img  id="avatar-2" width="200px" height="150px" src="" />
                        </div>

                        <div class="button">
                            <input type="submit" value="Lưu">
                            <input type="button" onclick="modal('edit-slider-modal', 1, 'scale(0)')" value="Hủy"> 
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="modal" >
            <div id="commit-modal"></div>
        </div>
        <div class="col-lg-1"></div>

        <div>
            <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>
        <script>
            $(document).ready(function () {
                $('#mytable').DataTable();
            });


            function previewAvatar(position) {
                var file = document.getElementById("file-image-" + position).files;
                if (file.length > 0) {
                    var fileReader = new FileReader();

                    fileReader.onload = function (event) {
                        document.getElementById("avatar-" + position).setAttribute("src", event.target.result);
                    };

                    fileReader.readAsDataURL(file[0]);
                }
            }


            function commit(sliderId, message) {
                modal('commit-modal', 2, 'scale(1)');
                var commitModal = document.getElementById('commit-modal');
                var modalBody = "";
//            modalBody += "<h2 class =\"title\" >Cảnh báo</h2>";
                modalBody += "<p>" + message + "</p>";
                modalBody += "<div class=\"btn-action\" >";
                modalBody += "<button type=\"button\" onclick=\"deleteSlider('" + sliderId + "')\" >Chấp nhận</button>";
                modalBody += "<button type=\"button\" onclick=\"modal('commit-modal', 2, 'scale(0)')\">Hủy</button>";
                modalBody += "</div>";
                commitModal.innerHTML = modalBody;
            }

            function deleteSlider(sliderId) {
                var url = "delete?sliderId=" + sliderId;
                fetch(url, {method: "POST"});

                var sliderList = document.getElementById('slider-list');
                var slider = document.getElementById(sliderId);

                sliderList.removeChild(slider);
                modal('commit-modal', 2, 'scale(0)');
            }

            function editSlider(sliderId) {
                var url = "edit?sliderId=" + sliderId;
                var edits = document.getElementsByClassName('edit-slider');
                fetch(url).then(response => response.json())
                        .then(result => {
                            var slider = result.slider;

                            edits[0].value = slider.sliderId;
                            edits[1].value = slider.sliderTitle;
                            edits[2].value = slider.sliderContent;

                            modal('edit-slider-modal', 1, 'scale(1)');
                        });

            }


        </script>
        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../js/main.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <!--<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>-->
        <!--<script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>-->
        <!--<script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>-->
    </body>   
</html>
