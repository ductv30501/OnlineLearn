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
<link rel="stylesheet" href="../../assets/css/simple-notify.min.css" />
        <script src="../../assets/js/simple-notify.min.js"></script>
        <script src="../../js/main.js"></script>
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

        #view-feedback-modal, #send-feedback-modal{
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
        #send-feedback-modal .title{
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
        #send-feedback-modal.title::before{
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
        #view-feedback-modal.content form .user-details{
            /*                display: flex;*/
            flex-wrap: wrap;
            justify-content: space-between;
            margin: 20px 0 12px 0;
        }
        #send-feedback-modal.content form .user-details{
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
                        <div class ="col-md-4">
                            <form method="GET" action="list" style="margin-bottom: 15px;" id ="submitForm">
                                <input id ="page" type="hidden" value ="${page}" name="page" >
                            <input id ="search" type="hidden" value ="${search}" name="search">
                            <div class ="row">
                                <div class ="col-sm-2 mt-2 ">
                                    <label for="sizePage">Hiển Thị</label>
                                </div>    
                                <div class ="col-sm-2" style="width: 60px; flex: left;">
                                    <select onchange="submitform();" name ="sizePage"  class="form-control text-center" >
                                        <option ${(sizePage==5)?"selected =\"selected\"":"" } value="5">5</option>
                                        <option ${(sizePage==10)?"selected =\"selected\"":"" } value="10">10</option>
                                        <option ${(sizePage==25)?"selected =\"selected\"":"" } value="25">25</option>
                                        <option ${(sizePage==50)?"selected =\"selected\"":"" } value="50">50</option>
                                    </select>
                                </div>
                            </div>
                        </form>

                    </div>

                    <div class="form-group col-md-3">
                        <input type="text"  class="form-control" placeholder="Tìm Kiếm" id="search-input" value ="${search}"  name="search-input" style="margin-top: 2px">
                    </div>
                    <div class="form-group col-md-3 " >
                        <input class="input-box button" onclick="submit(${page});" type="submit" value="Tìm kiếm" style="height: 60%;width: 50%;margin-top:2px;border-radius: 5px;margin-right: 10px; float:left"/>
                        <i style="position: absolute; left: 20px; top: 10px; color: #fff;" class="bi bi-search fa-lg"></i>
                    </div>
                    <div class="form-group col-md-2 mb-3 btn-add" >

                    </div>
                </div>
            </div>


            <div class="text-center">
                <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                    <thead>
                        <tr>
                            <th class="th-sm">Mã</th>
                            <th  class="th-sm">Nội Dung Phản Hồi</th>
                            <th class="th-sm">Sao Phản Hồi</th>
                            <th class="th-sm">Tên Khóa Học</th>
                            <th class="th-sm">Tên Học Viên</th>
                            <th class="th-sm">Hành Động</th>
                        </tr>
                    </thead>
                    <c:forEach items="${requestScope.listFeedback}" var="f">
                        <tbody>
                        <td>${f.feedbackId}</td>
                        <td>${f.feedbackContent}</td>
                        <td>${f.stars}</td>
                        <td>${f.course.courseTitle}</td>
                        <td>${f.user.name}</td>
                        <td>
                            <button type="button" onclick="openSendFeedback(${f.feedbackId})"  class="view btn btn-orange">Trả Lời </button>
                            <button type="button" onclick="openDetail(${f.feedbackId})"  class="view btn btn-orange">Chi tiết</button>

                        </td>
                        </tbody>
                    </c:forEach>


                </table>


            </div>
            <div style="width: 100%; display: table;">
                <div style="display: table-row">
                    <div style="width: 1100px; display: table-cell;"> 
                        <div>Hiện thị ${(page-1)*sizePage} đến ${(page*sizePage>sizeListFeedback)?sizeListFeedback-1:page*sizePage-1} trong tổng số ${sizeListFeedback} phản hồi</div>
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
                    <div class="title">Chi Tiết Phản Hồi Học Viên </div>
                    <div class="content">
                        <form  enctype="multipart/form-data">
                            <div class="user-details">
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Mã phản hồi: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Nội dung phản hồi: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Đánh giá của học viên: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Khóa học: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Tỷ lệ xếp hạng: </span>
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
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Tên học viên: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Email: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Số điện thoại: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="view-feedback"></div>
                                        </div>
                                    </div>

                                </div>
                            </div>


                            <div class="button" >
                                <input type="button" onclick="modal('view-feedback-modal', 0, 'scale(0)')" value="Quay Lại"> 
                            </div>
                        </form>
                    </div>
                </div>
            </div>   

            <div class="modal">
                <div id="send-feedback-modal">
                    <div class="title">Chi Tiết Phản Hồi Học Viên </div>
                    <div class="content">
                        <form id="send-reply" action="reply" method="GET" enctype="multipart/form-data">

                            <div class="user-details">
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Mã phản hồi: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id = "id" type = "hidden" name = "id"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Nội dung phản hồi: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id="mess" type="hidden" name = "mess"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Đánh giá của học viên: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id = "star" name = "star" type = "hidden"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Khóa học: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id ="course" name ="course" type="hidden"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Tên chủ đề: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id ="topic" name ="topic" type="hidden"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Tên học viên: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id = "names" name ="names" type="hidden"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Email: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id = "email-student" name = "email-student" type = "hidden"/>
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Số điện thoại: </span>
                                        </div>
                                        <div  class = "col-md-9">
                                            <div class="send-feedback"></div>
                                            <input id = "phone-student" name ="phone-student" type="hidden" >
                                        </div>
                                    </div>

                                </div>
                                <div class="input-box">
                                    <div class ="row">
                                        <div class = "col-md-3">
                                            <span class="details">Nội dung phản hồi lại: </span>
                                        </div>

                                        <div  class = "col-md-9">
                                            <div class="control-group">
                                                <div id="textarea-container" >

                                                </div>
                                                <p class="help-block text-danger"></p>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>


                            <div class="button" >
                                <input type="button" value="Lưu" onclick="validateInput();" >
                                <input type="button" onclick="modal('send-feedback-modal', 1, 'scale(0)')" value="Hủy"> 
                            </div>
                        </form>
                    </div>
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
    function validateInput() {
        var form  = document.getElementById('send-reply');
        var textarea = document.getElementById('messageReplyfb');
        
        var content1 = textarea.value.replace('\\s+', ' ').trim();
        var content2 = textarea.innerHTML.replace('\\s+', ' ').trim();
        
        textarea.value = content1;
        textarea.innerHTML = content2;
        if(content1 === '' || content2 === '') {
            createNotify('warning', 'Thông báo', 'Nội dung không được để trống', true);
        } else {
            form.submit();
        }
        
    }

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


 
    function openDetail(id) {
        //openModal('view-feedback-modal');
        var url = "detail?id=" + id;
        var view = document.getElementsByClassName('view-feedback');
        fetch(url).then(function (response) {
            return response.json();
        }).then(function (result) {
            var feedback = result.feedback;
            var course = result.course;
            var topic = result.topic;
            var user = result.user;
            view[0].innerHTML = feedback.feedbackId;
            view[1].innerHTML = feedback.feedbackContent;
            view[2].innerHTML = feedback.stars;
            view[3].innerHTML = course.courseTitle;
            view[4].innerHTML = course.rate;
            view[5].innerHTML = topic.topicName;
            view[6].innerHTML = user.name;
            view[7].innerHTML = user.email;
            view[8].innerHTML = user.phone;
            modal('view-feedback-modal', 0, 'scale(1)');

        });
    }
    function openSendFeedback(id) {
        var url = "detail?id=" + id;
        var view = document.getElementsByClassName('send-feedback');
        fetch(url).then(function (response) {
            return response.json();
        }).then(function (result) {
            var feedback = result.feedback;
            var course = result.course;
            var topic = result.topic;
            var user = result.user;
            var reply = result.reply;

            var id = document.getElementById("id");
            var mess = document.getElementById("mess");
            var star = document.getElementById("star");
            var coursef = document.getElementById("course");
            var topicf = document.getElementById("topic");
            var name = document.getElementById("names");
            var email = document.getElementById("email-student");
            var phone = document.getElementById("phone-student");
            var textarea = document.getElementById("textarea-container");
            id.value = feedback.feedbackId;
            mess.value = feedback.feedbackContent;
            star.value = feedback.stars;
            coursef.value = course.courseTitle;
            topicf.value = topic.topicName;
            name.value = user.name;
            email.value = user.email;
            phone.value = user.phone;

            var box = " <textarea value=\"" + reply + "\" class=\"form-control border-1 py-3 px-4\" rows=\"5\" id =\"messageReplyfb\" name =\"messageReplyfb\" placeholder=\"Nội dung\">" + reply + "</textarea>";
            textarea.innerHTML = box;



            view[0].innerHTML = feedback.feedbackId;
            view[1].innerHTML = feedback.feedbackContent;
            view[2].innerHTML = feedback.stars;
            view[3].innerHTML = course.courseTitle;
            view[4].innerHTML = topic.topicName;
            view[5].innerHTML = user.name;
            view[6].innerHTML = user.email;
            view[7].innerHTML = user.phone;
            modal('send-feedback-modal', 1, 'scale(1)');
        });
    }

</script>

<script src="../../admin/js/tabler.min.js" defer></script>
<script src="../../admin/js/demo.min.js" defer></script>
<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
<script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
<script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>

</html>
