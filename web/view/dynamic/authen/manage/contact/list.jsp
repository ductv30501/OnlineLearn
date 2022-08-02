<%-- 
    Document   : course-list
    Created on : May 25, 2022, 10:30:11 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Bootstrap Datatable | Webdevtrick.com</title>

        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <!--<link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />-->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">-->

        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>-->
        <!--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>-->
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="../../assets/css/data-table-js.js" ></script>

        <link href="../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    </head>
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
        .btn-add button:hover{
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
        .modal:nth-of-type(3) {
            position: fixed;
            left: 0;
            top: 0;
            display: block;
            background: rgba(0, 0, 0, 0);
            height: 100%;
            width: 100%;
            transform: scale(0);
            transition-duration: 0s;
            z-index: 2;
        }
        #delete-feedback-modal {
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

        #view-feedback-modal{
            top: 5%;
            left: 20%;
            width: 50%;

            position: absolute;
            padding: 15px 35px 15px 35px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 10;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }

        #view-feedback-modal .title{
            font-size: 25px;
            font-weight: 500;
            position: relative;
            margin-bottom: 30px;
        }

        #view-feedback-modal.title::before{
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
        #view-feedback-modal .content form .user-details{
            /*                display: flex;*/
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 20px 0 12px 0;
        }

        form .user-details .input-box{
            margin-bottom: 15px;
            width:100%;
        }
        form .input-box span.details{
            display: block;
            font-weight: 500;
            margin-bottom: 5px;
        }
        .user-details .input-box input{
            /*                height: 45px;
            */                width: 100%;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
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
            border-radius: 5px;
            border: none;
            color: #fff;
            font-size: 18px;
            font-weight: 500;
            letter-spacing: 1px;
            cursor: pointer;
            transition: all 0.3s ease;

            background: #FF6600;
        }

        form .button input:hover{
            /* transform: scale(0.99); */
            background: #0e4bf1;
            ;
        }

        .insert-btn {
            margin-top: 10px;
        }

        .btn-action {
            margin-top: 30px;
            margin-bottom: 15px;
            width: 100%;
        }


        .btn-action button:nth-of-type(1),
        .btn-action button:nth-of-type(2),
        .insert-btn{
            display: inline-block;
            padding: 10px;
            box-sizing: border-box;
            border-radius: 5px;
            background-color: #FF6600;
            border: none;
            color: #fff;
            font-weight: 600;
        }
        .btn-action button:nth-of-type(1):hover,
        .btn-action button:nth-of-type(2):hover,
        .insert-btn:hover{
            background: #076af7;
        }
        .btn-action button:nth-of-type(1) {
            width: 48%;
            margin-right: 10px;

        }
        .btn-action button:nth-of-type(2) {
            width: 48.5%;

        }
    </style>

    <script>
        function submitform()
        {
            document.getElementById("submitForm").submit();
        }

        function submit(pageIndex)
        {
            var page = document.getElementById("page");
            var search = document.getElementById("search");
            search.value = document.getElementById("search-input").value;
            page.value = pageIndex;
            submitform();
        }


    </script>

    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1"></div>

            <div style="background: #fff; padding:10px;margin-top: 20px; margin-bottom: 20px;border-radius: 5px;" class="container col-lg-10">

                <div class="row">
                    <div class="form-group row">
                        <div class ="col-md-6">
                            <form method="GET" action="list" style="margin-bottom: 15px;" id ="submitForm">
                                <input id ="page" type="hidden" value ="${page}" name="page" >
                            <input id ="search" type="hidden" value ="${search}" name="search">
                            <div class ="row">
                                <div class ="col-sm-2 mt-2 ">
                                    <label for="sizePage">Hiển Thị: </label>
                                </div>    
                                <div class ="col-sm-1" style="width: 60px; flex: left;">
                                    <select onchange="submitform();" name ="sizePage"  class="form-control text-center" >
                                        <option ${(sizePage==5)?"selected =\"selected\"":"" } value="5">5</option>
                                        <option ${(sizePage==10)?"selected =\"selected\"":"" } value="10">10</option>
                                        <option ${(sizePage==25)?"selected =\"selected\"":"" } value="25">25</option>
                                        <option ${(sizePage==50)?"selected =\"selected\"":"" } value="50">50</option>
                                    </select>
                                </div>
                                    <div class ="col-sm-2 mt-2 ">
                                    <label for="sizePage">Trạng Thái:</label>
                                </div>    
                                <div class ="col-sm-4" style="width: 150px; flex: right;">
                                    <select onchange="submitform();" name ="status"  class="form-control text-center" >
                                        <option ${(status==-1)?"selected =\"selected\"":"" } value="-1">Chọn Trạng Thái</option>
                                        <option ${(status==0)?"selected =\"selected\"":"" } value="0">Đã Phản Hồi</option>
                                        <option ${(status==1)?"selected =\"selected\"":"" } value="1">Chưa Phản Hồi</option>
                                    </select>
                                </div>
                            </div>
                        </form>

                    </div>

<!--                    <div class="form-group col-md-4 mb-3 btn-add" >



                    </div>-->
                    <div class="form-group col-md-3">
                        <input type="text"  class="form-control" placeholder="Tìm Kiếm" id="search-input" value ="${search}"  name="search-input" style="margin-top: 2px">
                    </div>
                    <div class="form-group col-md-3 " >
                        <input class="input-box button" onclick="submit(${page});" type="submit" value="Tìm kiếm" style="height: 60%;width: 50%;margin-top:2px;border-radius: 5px;margin-right: 10px; float:left"/>
                        <i style="position: absolute; left: 20px; top: 10px; color: #fff;" class="bi bi-search fa-lg"></i>
                    </div>

                </div>
            </div>


            <div class="text-center">
                <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                    <thead>
                        <tr>
                            <th class="th-sm">Mã</th>
                            <th  class="th-sm">Họ và Tên</th>
                            <th class="th-sm">Email</th>
                            <th class="th-sm">Số Điện Thoại</th>
                            <th class="th-sm">Tiêu Đề</th>
                            <th class="th-sm">Nội Dung</th>
                            <th class="th-sm">Trạng Thái</th>
                            <th class="th-sm">Hành Động</th>
                        </tr>
                    </thead>

                    <c:forEach items="${requestScope.contacts}" var="c">
                        <tbody>
                        <td>${c.contactId}</td>
                        <td>${c.name}</td>
                        <td>${c.email}</td>
                        <td>${c.phone}</td>
                        <td>${c.subject}</td>
                        <td>${c.message}</td>
                        <td>${c.status==true?"Chưa Phản Hồi":"Đã Phản Hồi"}</td>
                        <td>
                            <button type="button" onclick="openDetail(${c.contactId})"  class="view btn btn-orange">Phản Hồi</button>
                            <button type="button" onclick="commit(${c.contactId}, 'Phản hồi của học viên sẽ bị xóa, bạn có muốn tiếp tục?')"  class="delete btn btn-orange">Xóa</button>
                        </td>
                        </tbody>
                    </c:forEach>



                </table>


            </div>
            <div style="width: 100%; display: table;">
                <div style="display: table-row">
                    <div style="width: 1100px; display: table-cell;"> 
                        <div>Hiện thị ${(page-1)*sizePage} đến ${(page*sizePage>sizeListContact)?sizeListContact-1:page*sizePage-1} trong tổng số ${sizeListContact} liên hệ</div>
                    </div>
                    <div style="display: table-cell;">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination">

                                <c:if test="${totalPage>1 && page>1}">
                                    <li class="page-item"onclick="submit(${page==1?1:page-1});"><a class="page-link" >Trước</a></li>
                                    </c:if>

                                <c:if test ="${totalPage==1}">
                                    <li  class="page-item active" ><a class="page-link active" style="background-color: #FF6600;" onclick="submit(1);" >${page}</a></li>
                                    </c:if>
                                    <c:if test ="${totalPage==2}">
                                    <li class="page-item active"><a class="page-link active" style="background-color: #FF6600;" onclick="submit(1);" >${page}</a></li>
                                    <li class="page-item"><a class="page-link" onclick="submit(2);" >${page+1}</a></li>
                                    </c:if>
                                    <c:if test ="${totalPage>=3}">
                                    <li class="page-item active"><a class="page-link active" style="background-color: #FF6600;" onclick="submit(1);" >${page}</a></li>
                                    <li class="page-item"><a class="page-link" onclick="submit(2);" >${page+1}</a></li>
                                    <li class="page-item"><a class="page-link" onclick="submit(3);" >${page+2}</a></li>
                                    </c:if>
                                    <c:if test ="${totalPage>page}">
                                    <li class="page-item"><a class="page-link" onclick="submit(${page==totalPage?totalPage:page+1});" >Tiếp</a></li>
                                    </c:if>



                            </ul>
                        </nav>
                    </div>
                </div>
            </div>

            <!-- Edit Modal HTML -->
            <div class="modal">
                <div id="view-feedback-modal">
                    <div class="title">Phản Hồi Liên Hệ </div>
                    <div class="content">
                        <form id ="sendMailContact" action="sendmail" method ="POST">
                            <div class="user-details">
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Mã Liên Hệ: </span>
                                        </div>
                                        <div  class = "col-md-9">

                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Tên chủ đề: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <input name="subject" id ="subject" type="text" class="form-control view-feedback">
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Nội dung phản hồi: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="control-group">
                                                <textarea  
                                                    style="text-align: left;"
                                                    class="form-control border-1 py-3 px-4" 
                                                    rows="5" 
                                                    id ="msg" 
                                                    name="msg" 

                                                    placeholder="Nội dung" 
                                                    data-validation-required-message="Please enter your message">
                                                </textarea>
                                                <p class="help-block text-danger"></p>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                            <input name="contactId" id ="contactId" type="text" class="form-control ">
                            <input name="name" id ="name" type="text" class="form-control ">
                            <input name="email" id ="email" type="text" class="form-control ">
                            <div class="button" >
                                <div class="btn-action" >
                                    <button type="submit"  >Gửi Phản Hồi</button>
                                    <button type="button" onclick="closeModal('view-feedback-modal')">Quay Lại</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>   
            <form id="form-delete" action ="delete" method="POST" >
                <input id="id-delete" type="hidden" name="id" />
            </form>
            <div class="modal" >
                <div id="delete-feedback-modal">

                </div>
            </div>
        </div>
        <div class="col-lg-1"></div>

        <div>
            <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>
    </div>
</body>
<script>

    function previewAvatar(position) {
        var file = document.getElementById("file-" + position).files;
        if (file.length > 0) {
            var fileReader = new FileReader();

            fileReader.onload = function (event) {
                document.getElementById("avatar-" + position).setAttribute("src", event.target.result);
            };

            fileReader.readAsDataURL(file[0]);
        }
    }

    function openModal(id) {
        var box = document.getElementById(id);
        var modal = document.getElementsByClassName('modal');
        if (id === 'delete-feedback-modal') {
            modal[1].style.transform = "scale(1)";
        } else if (id === 'view-feedback-modal') {
            modal[0].style.transform = "scale(1)";
        }
        box.style.transform = "scale(1)";
    }

    function closeModal(id) {
        var box = document.getElementById(id);
        var modal = document.getElementsByClassName('modal');
        if (id === 'delete-feedback-modal') {
            modal[1].style.transform = "scale(0)";
        } else if (id === 'view-feedback-modal') {
            modal[0].style.transform = "scale(0)";
        }
        box.style.transform = "scale(0)";
    }

    function commit(id, message) {
        openModal('delete-feedback-modal');
        var commitModal = document.getElementById('delete-feedback-modal');
        var modalBody = "";
        modalBody += "<p>" + message + "</p>";
        modalBody += "<div class=\"btn-action\" >";
        modalBody += "<button type=\"button\" onclick=\"deleteRow('" + id + "')\" >Chấp nhận</button>";
        modalBody += "<button type=\"button\" onclick=\"closeModal('delete-feedback-modal')\">Hủy</button>";
        modalBody += "</div>";
        commitModal.innerHTML = modalBody;
    }
    function deleteRow(id) {
        var form = document.getElementById('form-delete');
        var input = document.getElementById('id-delete');
        input.value = id;
        form.submit();
    }
    function openDetail(id) {
        //openModal('view-feedback-modal');
        var url = "sendmail?id=" + id;
        var view = document.getElementsByClassName('view-feedback');
        var subject = document.getElementById("subject");
        var contactId = document.getElementById('contactId');
        var name = document.getElementById('name');
        var email = document.getElementById('email');
        fetch(url).then(function (response) {
            return response.json();
        }).then(function (result) {
            var contact = result.contact;
            view[0].innerHTML = contact.contactId;
            subject.value = contact.subject;
            contactId.value = contact.contactId;
            name.value = contact.name;
            email.value = contact.email;
            openModal('view-feedback-modal');

        });
    }
    function sendMailContact() {
        document.getElementById("submitForm").submit();

//        var id = document.getElementById('contactId');
//        var subject = document.getElementById('subject');
//        var email = document.getElementById('email');
//        var name = document.getElementById('name');
//        var msg = document.getElementById('msg');
//        var url = "sendmail?id=" + id + "&subject=" + subject + "&email=" + email + "&name=" + name + "&msg=" + msg;
//        fetch(url, {method: "POST"}).then(function (response) {
//            return response.text();
//        }).then(function (result) {
//            createNotify("success", "Thông báo", "Phản Hồi Liên Hệ Thành Công", true);
//        });
    }

</script>

<script src="../../admin/js/tabler.min.js" defer></script>
<script src="../../admin/js/demo.min.js" defer></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
<script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>

</html>
