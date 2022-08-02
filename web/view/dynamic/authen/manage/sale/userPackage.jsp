<%-- 
    Document   : package
    Created on : May 28, 2022, 10:15:17 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
        <!--<link href="../../../../admin/css/tabler.min.css" rel="stylesheet"/>-->
        <link href="../../../css/tabler.css" rel="stylesheet"/>
        <!--<link href="../../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">-->

        <style>

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
                table-layout: fixed; /* even columns width , fix width of table too*/
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
                width: 100%;
                height: 20px;

            }
            table.table tr th:nth-child(2),
            table.table tr td:nth-child(2){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(3),
            table.table tr td:nth-child(3){
                width: 100%;
                height: 20px;

            }
            table.table tr th:nth-child(4),
            table.table tr td:nth-child(4){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(5),
            table.table tr td:nth-child(5){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(6),
            table.table tr td:nth-child(6){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(7),
            table.table tr td:nth-child(7){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(8),
            table.table tr td:nth-child(8){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(9),
            table.table tr td:nth-child(9){
                width: 100%;
                height: 20px;
            }
            table.table tr th:nth-child(10),
            table.table tr td:nth-child(10){
                width: 100%;
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
                z-index: 2;
            }



            #add-package-modal,
            #view-package-modal,
            #edit-package-modal{
                top: 5%;
                left: 20%;
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


            #add-package-modal .title,
            #view-package-modal .title,
            #edit-package-modal .title{
                font-size: 25px;
                font-weight: 500;
                position: relative;
                margin-bottom: 30px;
            }
            #add-package-modal .title::before,
            #view-package-modal .title::before,
            #edit-package-modal .title::before{
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
            #add-package-modal .content form .user-details,
            #view-package-modal .content form .user-details,
            #edit-package-modal .content form .user-details{
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                margin: 20px 0 12px 0;
            }
            form .user-details .input-box{
                margin-bottom: 15px;
                width: calc(100% / 2 );
            }
            form .input-box span.details{
                display: block;
                font-weight: 500;
                margin-bottom: 5px;
            }
            .user-details .input-box input{
                height: 45px;
                width: 80%;
                outline: none;
                font-size: 16px;
                border-radius: 5px;
                padding-left: 15px;
                border: 1px solid #ccc;
                border-bottom-width: 2px;
                transition: all 0.3s ease;
            }
            .user-details .input-box input:focus,
            .user-details .input-box input:valid{
                border-color: #9b59b6;
            }
            form .button-x,
            form .button{
                height: 45px;
                box-sizing: border-box;

                width: 100%;
                margin: 35px 0;
                /*border: 1px solid #000;*/
            }
            form .button-x input{
                margin-left: 300px;
                height: 100%;
                width: 30%;
                border-radius: 5px;
                border: none;
                color: #fff;
                font-size: 18px;
                font-weight: 500;
                letter-spacing: 1px;
                cursor: pointer;

                background: #FFC107;
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
            form .button-x input:hover,
            form .button input:hover{
                /* transform: scale(0.99); */
                background: #03A9F4;
            }
            @media(max-width: 584px){
                .container{
                    max-width: 100%;
                }
                form .user-details .input-box{
                    margin-bottom: 15px;
                    width: 100%;
                }

                .content form .user-details{
                    max-height: 300px;
                    overflow-y: scroll;
                }
                .user-details::-webkit-scrollbar{
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
                width:180%;
            }

        </style>

    </head>
    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>

            <div class="col-lg-1" ></div>
            <div class="container col-lg-10" style="padding: 0px; ">
                <div class="table-responsive">
                    <div class="table-wrapper">
                        <div class="table-title">
                            <div class="row">
                                <div class="col-sm-6">
                                    <h2>Danh sách <b>đăng ký</b></h2>
                                </div>
<!--                                <div class="col-sm-6">
                                    <button onclick="openModal('add-package-modal')" class="btn btn-success"><i class="material-icons">&#xE147;</i> <span>Thêm mới</span></button>
                                </div>-->
                            </div>
                        </div>
                        <table id="mytable" class="table table-striped table-hover">
                            <thead>
                                <tr>
                                    <th>Tên đăng nhập</th>
                                    <!--<th>Email</th>-->
                                    <th>Ngày đăng ký</th>
                                    <th>Tên gói</th>
                                    <th>Giá</th>
                                    <th>Trạng thái</th>
                                    <!--                                    <th>Ngày bắt đầu</th>
                                                                        <th>Ngày kết thúc</th>-->
                                    <th>Người sửa lần cuối</th>
                                    <th>Hành động</th>
                                </tr>
                            </thead>
                            <tbody >
                            <c:set var="index" value="1" ></c:set>
                            <c:forEach var="up" items="${requestScope.userPackages}">
                                <tr>        
                                    <td>${up.username}</td>
                                    <!--<td>${up.email}</td>-->
                                    <td>${up.registration_date}</td>
                                    <td>${up.packageTitle}</td>
                                    <td>${up.total_price}</td>
                                    <td>
                                        <c:if test="${up.status == true}" > đã duyệt </c:if>
                                        <c:if test="${up.status == false}" > chưa duyệt </c:if>
                                        </td>
<!--                                    <td>${up.valid_from}</td>
                                    <td>${up.valid_to}</td>-->
                                    <td>${up.lastUpdateBy}</td>
                                    <td>
                                        <button type="button" onclick="getPackageDetail('${up.username}',${up.packageID})" class="edit"><i class="fa fa-pencil" title="Edit"></i></button>
                                        <button type="button" onclick="getPackageDetailView('${up.username}',${up.packageID})" class="view"><i class="fa fa-eye" title="View"></i></button>
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
            <div id="add-package-modal">
                <div class="title">Thêm mới gói ưu đãi</div>
                <div class="content">
                    <form action="insert" method="POST">
                        <div class="user-details">
                            <div class="input-box">
                                <span class="details">Mã</span>
                                <span>Mã tự động</span>
                                <!--<input type="" placeholder="Enter your name" required>-->
                            </div>
                            <div class="input-box">
                                <span class="details">Tiêu đề</span>
                                <input name="title" type="text" placeholder="Nhập tiêu đề" required>
                            </div>
                            <div class="input-box">
                                <span class="details">Giá</span>
                                <input name="price" type="text" placeholder="Nhập giá" required>
                            </div>
                            <div class="input-box">
                                <span class="details">Thời gian sử dụng</span>
                                <input name="duration" type="text" placeholder="Nhập thời gian sử dụng" required>
                                <select name="durationType" >
                                    <option value="month" >Tháng</option>
                                    <option value="year" >Năm</option>
                                </select>
                            </div>
                            <div class="input-box">
                                <span class="details">Nội dung ưu đãi</span>
                                <textarea name="benefits" cols="97" rows="6" placeholder="Nhập nội dung ưu đãi" required></textarea>
                            </div>
                        </div>
                        <div class="input-box">
                            <span class="details">Trạng thái</span>
                            <input checked="checked" type="radio" name="status" value="public"> Công khai 
                            <input type="radio" name="status" value="private" > Ẩn
                        </div>

                        <div class="button">
                            <input type="submit" value="Lưu">
                            <input type="button" onclick="closeModal('add-package-modal')" value="Hủy"> 
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- Edit Modal HTML -->
        <div class="modal">
            <div id="edit-package-modal">
                <div class="title">Chỉnh sửa trạng thái</div>
                <div class="content">
                    <form action="edit" method="POST">
                        <div class="user-details">
                            <div class="input-box">
                                <span class="details">Tên tài khoản</span>
                                <input type="hidden" class="edit-package" name="userId"/>
                                <span class="edit-package"></span>
                                <!--<input type="" placeholder="Enter your name" required>-->
                            </div>
                            <div class="input-box">
                                <span class="details">Email</span>
                                <input class="edit-package" name="email" type="hidden">
                                <span class="edit-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Ngày đăng ký</span>
                                <input class="edit-package" name="registration_date" type="hidden" placeholder="Nhập ngày đăng ký" required>
                                <span class="edit-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Tên gói</span>
                                <input class="edit-package" name="package_title" type="hidden" >
                                <span class="edit-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Mã Gói đăng ký</span>
                                <input class="edit-package" name="packageID" type="hidden" >
                                <span class="edit-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Giá</span>
                                <input class="edit-package" name="total_price" type="hidden" placeholder="Nhập tên gói" required>
                                <span class="edit-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Ngày bắt đầu</span>
                                <input class="edit-package" name="valid_from" type="date" placeholder="Nhập ngày bắt đầu" required>
                            </div>
                            <div class="input-box">
                                <span class="details">Ngày kết thúc</span>
                                <input class="edit-package" name="valid_to" type="date" placeholder="Nhập ngày kết thúc" required>
                            </div>
                            <div class="input-box">
                                <span class="details">Người sửa lần cuối</span>
                                <input class="edit-package" name="editBy" type="hidden" placeholder="Nhập Người sửa lần cuối" required>
                                <span class="edit-package"></span>
                            </div>
                            
                        </div>
                        <div class="input-box">
                            <span class="details">Trạng thái</span>
                            <input class="edit-option" type="radio" name="status" value="active"> đã duyệt 
                            <input class="edit-option" type="radio" name="status" value="nonactive" > chưa duyệt
                        </div>

                        <div class="button">
                            <input type="submit" value="Lưu">
                            <input type="button" onclick="closeModal('edit-package-modal')" value="Hủy"> 
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- End Edit Modal HTML -->
        <!-- View Modal HTML -->
        <div class="modal">
            <div id="view-package-modal">
                <div class="title">Thông tin đăng ký khóa học</div>
                <div class="content">
                    <form action="edit" method="POST">
                        
                        <div class="user-details">
                            <div class="input-box">
                                <span class="details">Tên tài khoản</span>
                                <input type="hidden" class="view-package" name="userId"/>
                                <span class="view-package"></span>
                                <!--<input type="" placeholder="Enter your name" required>-->
                            </div>
                            <div class="input-box">
                                <span class="details">Họ tên</span>
                                <input class="view-package" name="name" type="hidden">
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Email</span>
                                <input class="view-package" name="email" type="hidden">
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Số điện thoại</span>
                                <input class="view-package" name="phone" type="hidden">
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Giới tính</span>
                                <input class="view-package" name="gender" type="hidden">
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Ngày đăng ký</span>
                                <input class="view-package" name="registration_date" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Mã Gói đăng ký</span>
                                <input class="view-package" name="packageID" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Tên gói</span>
                                <input class="view-package" name="package_title" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Giá</span>
                                <input class="view-package" name="total_price" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Ngày bắt đầu</span>
                                <input class="view-package" name="valid_from" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Ngày kết thúc</span>
                                <input class="view-package" name="valid_to" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Người sửa lần cuối</span>
                                <input class="view-package" name="editBy" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                            <div class="input-box">
                                <span class="details">Trạng thái</span>
                                <input class="view-package" name="status" type="hidden" >
                                <span class="view-package"></span>
                            </div>
                        </div>
                        <div class="button-x">
                            <input type="button" onclick="closeModal('view-package-modal')" value="thoát"> 
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- End View Modal HTML -->


        <div class="col-lg-1" ></div>


    </body>
    <script>

        $(document).ready(function () {
            $('#mytable').DataTable();
        });


        function openModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'add-package-modal') {
                modal[0].style.transform = "scale(1)";
            } else if (id === 'edit-package-modal') {
                modal[1].style.transform = "scale(1)";
            }else if(id === 'view-package-modal'){
                modal[2].style.transform = "scale(1)"
            }
            box.style.transform = "scale(1)";
        }

        function closeModal(id) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            if (id === 'add-package-modal') {
                modal[0].style.transform = "scale(0)";
            } else if (id === 'edit-package-modal') {
                modal[1].style.transform = "scale(0)";
            }else if (id === 'view-package-modal') {
                modal[2].style.transform = "scale(0)";
            }

            box.style.transform = "scale(0)";
        }
        function getPackageDetailView(id, packageID) {
            var url = "view?id=" + id + "&packageID=" + packageID;
            var edits = document.getElementsByClassName('view-package');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var data = result.split('|');
                //username
                edits[0].value = data[0];
                edits[1].innerHTML = data[0];
                //full name
                edits[2].value = data[11];
                edits[3].innerHTML = data[11];
                //email
                edits[4].value = data[1];
                edits[5].innerHTML = data[1];
                //phone
                edits[6].value = data[12];
                edits[7].innerHTML = data[12];
                //gender
                edits[8].value = data[13];
                edits[9].innerHTML = data[13];
                //registration date
                edits[10].value = data[2];
                edits[11].innerHTML = data[2];
                //package ID 
                edits[12].value = data[9];
                edits[13].innerHTML = data[9];
                //package title
                edits[14].value = data[3];
                edits[15].innerHTML = data[3];
                //price
                edits[16].value = data[4];
                edits[17].innerHTML = data[4];
                //valid from 
                edits[18].value = data[5];
                edits[19].innerHTML = data[5];
                //valid to
                edits[20].value = data[6];
                edits[21].innerHTML = data[6];
                
                // last edit by
                edits[22].value = data[7];
                edits[23].innerHTML = data[7];
                // status
                edits[24].value = data[8];
                edits[25].innerHTML = data[8];
//                if (data[8] === "active") {
//                    edits[24].checked = "checked";
//                } else {
//                    edits[25].checked = "checked";
//                }
            });

            openModal('view-package-modal');

        }

        function getPackageDetail(id, packageID) {
            var url = "edit?id=" + id + "&packageID=" + packageID;
            var edits = document.getElementsByClassName('edit-package');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var data = result.split('|');
                //username
                edits[0].value = data[0];
                edits[1].innerHTML = data[0];
                //email
                edits[2].value = data[1];
                edits[3].innerHTML = data[1];
                //registration date
                edits[4].value = data[2];
                edits[5].innerHTML = data[2];
                //package title
                edits[6].value = data[3];
                edits[7].innerHTML = data[3];
                //package ID
                edits[8].value = data[9];
                edits[9].innerHTML = data[9];
                //price
                edits[10].value = data[4];
                edits[11].innerHTML = data[4];
                //valid from 
                edits[12].value = data[5];
                //valid to
                edits[13].value = data[6];
                // last edit by
                edits[14].value = data[7];
                edits[15].innerHTML = data[7];
                //status
                var option = document.getElementsByClassName('edit-option');
                if (data[8] === "active") {
                    option[0].checked = "checked";
                } else {
                    option[1].checked = "checked";
                }
            });

            openModal('edit-package-modal');

        }
    </script>
    <script src="../../../admin/js/tabler.min.js" defer></script>
    <script src="../../../admin/js/demo.min.js" defer></script>
</html>
