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
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="../../../assets/css/simple-notify.min.css" />
        <script src="../../../assets/js/simple-notify.min.js"></script>
        <script src="../../../js/main.js"></script>
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


        #insert-course-modal,
        #edit-course-modal{
            top: 5%;
            left: 15%;
            width: 70%;
            /*height: 25vh;*/
            position: absolute;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 10;
            border-radius: 3px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }

        .btn-course {
            padding: 10px;
            border-radius: 3px;
            color: #fff;
            width: 49%;
        }

        .btn-course:hover {
            box-shadow: 2px 2px 2px #ccc;
        }

        .btn-course:nth-of-type(1) {
            margin-right: 15px;
            background-color: rgb(0, 200, 0);
        }
        .btn-course:nth-of-type(2) {
            background-color: #3fc3ee;
        }



    </style>
    <body>
         <jsp:include page="../../../component/header.jsp" ></jsp:include>
        <div class="modal" >
            <div id="insert-course-modal" class="card">
                <div class="card-body">
                    <form action = "insert"  method ="POST" enctype="multipart/form-data">
                        <h3 class="card-title mt-3 mb-3" style="font-size: 24px;">Th??m Kh??a H???c</h3>
                        <div class="row" >
                            <div class="col-6" >
                                <label class="labels mt-2 mb-2" for ="course_title">Nh???p T??n Kh??a H???c: </label>
                                <input id ="course_title" name="course_title" type="text" class="form-control"required>
                                <label class="labels mt-2 mb-2 mt-3" for ="topic_id">Ch???n Ch??? ?????: </label>
                                <select name="topic_id" id ="topic_id" class ="form-control mb-2">
                                    <c:forEach items="${listTopic}" var ="t">
                                        <option value = ${t.topicId}>${t.topicName}</option>
                                    </c:forEach>
                                </select>
                                <h3></h3>
                                <label class="labels mb-2 mt-3" for ="username_expert">Ch???n gi??o vi??n: </label>
                                <select name="username_expert" id = "username_expert" class ="form-control">
                                    <c:forEach items="${listExpert}" var ="t">
                                        <option value = ${t.username}>${t.name}</option>
                                    </c:forEach>
                                </select>
                                <label class="labels mb-2 mt-2" for ="username_expert">M?? t??? kh??a h???c: </label>
                                <textarea  class="form-control" rows="10" name="description" id ="description"  >
                                </textarea>

                            </div>
                            <div class="col-6">

                                <div class="mb-3 mt-3">
                                    Ch???n ???nh: <input onchange="previewAvatar(1)" id="file-1" style="margin-top: 10px" class="form-control" type="file" accept=".jpg, .jpeg, .png" name="img" required>
                                </div>
                                <div class="mb-3 mt-3">
                                    Xem tr?????c ???nh:  
                                    <img id="avatar-1" />


                                </div>
                            </div>
                        </div>

                        <div class ="row mt-3 mb-4">
                            <div class ="col">
                                <input class="btn-course" type="submit" id="submit" value = "L??u th??ng tin" class ="mt-2 " style="font-size: 16px;">
                                <input class="btn-course" onclick="modal('insert-course-modal', 0, 'scale(0)')"  type="button" value = "????ng" class ="mt-2" style="font-size: 16px;">

                            </div>

                        </div>


                    </form>

                </div>
            </div>
        </div>

        <div class="modal" >
            <div id="edit-course-modal" class="card">
                <div class="card-body">
                    <form action = "edit"  method ="POST" enctype="multipart/form-data">
                        <h3 class="card-title mt-3 mb-3" style="font-size: 24px;">Ch???nh S???a Kh??a H???c</h3>
                        <div class="row" >
                            <div class="col-6" >
                                <input type="hidden" name="courseId" class="edit-course" />
                                <label class="labels mt-2 mb-2" for ="course_tt">Nh???p T??n Kh??a H???c: </label> <br />
                                <input style="padding: 6px; width: 100%; border: 1px solid #ccc; border-radius: 3px;" id="course-tt"  class="edit-course" name="course_title" type="text" class="form-control" required> <br />
                                <label class="labels mt-2 mb-2 mt-3" for ="topic_id">Ch???n Ch??? ?????: </label>
                                <select name="topic_id" id ="topic_id" class ="form-control mb-2">
                                    <c:forEach items="${listTopic}" var ="t">
                                        <option class="topic-option" value = ${t.topicId}>${t.topicName}</option>
                                    </c:forEach>
                                </select>
                                <h3></h3>
                                <label class="labels mb-2 mt-3" for ="username_expert">Ch???n gi??o vi??n: </label>
                                <select name="username_expert" id = "username_expert" class ="form-control">
                                    <c:forEach items="${listExpert}" var ="t">
                                        <option class="expert-option" value = ${t.username}>${t.name}</option>
                                    </c:forEach>
                                </select>
                                <label class="labels mb-2 mt-2" for ="username_expert">M?? t??? kh??a h???c: </label>
                                <div  id="edit-container">

                                </div>
                            </div>
                            <div class="col-6">
                                <div class="mb-3 mt-3">
                                    ???nh: 
                                    <img id="avatar-2" class="edit-course" />

                                </div>
                                <div class="mb-3 mt-3">
                                    Ch???n ???nh kh??c: <input onchange="previewAvatar(2)" id="file-2" style="margin-top: 10px" class="form-control" type="file" accept=".jpg, .jpeg, .png" name="img" required>
                                </div>

                            </div>
                        </div>

                        <div class ="row mt-3 mb-4">
                            <div class ="col">
                                <input class="btn-course" type="submit"  value = "L??u th??ng tin" class ="mt-2 " style="font-size: 16px;">
                                <input class="btn-course" onclick="modal('edit-course-modal', 1, 'scale(0)')"  type="button" value = "????ng" class ="mt-2" style="font-size: 16px;">

                            </div>

                        </div>


                    </form>

                </div>
            </div>
        </div>
       
            <div class="col-lg-1"></div>

            <div style="background: #fff; padding:10px;margin-top: 20px;border-radius: 5px;" class="container col-lg-10">
                <form method="GET" action="list" style="margin-bottom: 15px;">
                    <div class="row">
                        <div class="form-group col-md-1">
                            <label for="inputState" >Hi???n th???</label>
                            <select id="inputState" class="form-control" name="number" onchange="this.form.submit()">
                                <option ${"5"==requestScope.number?"selected=\"selected\"":""} value="5">5 h??ng</option>
                            <option ${"10"==requestScope.number?"selected=\"selected\"":""} value="10">10 h??ng</option>
                            <option ${"15"==requestScope.number?"selected=\"selected\"":""} value="15">15 h??ng</option>
                            <option ${"20"==requestScope.number?"selected=\"selected\"":""} value="20">20 h??ng</option>
                        </select>                       
                    </div>
                    <div class="form-group col-md-2">
                        <label for="inputState">Ch??? ?????</label>
                        <select id="inputState" class="form-control" name="topicId" onchange="this.form.submit()">
                            <option value="-1">T???t c???</option>
                            <c:forEach items="${requestScope.topics}" var="t">
                                <option ${t.topicId==requestScope.topicId?"selected=\"selected\"":""} value="${t.topicId}">${t.topicName}</option>
                            </c:forEach>
                        </select>
                    </div>           
                    <div class="form-group col-md-2">
                        <label for="inputState" >Tr???ng th??i</label >
                        <select id="inputState" class="form-control" name="status" onchange="this.form.submit()">
                            <option value="-1">T???t c???</option>
                            <option ${"1"==requestScope.status?"selected=\"selected\"":""} value="1">C??ng khai</option>
                            <option ${"0"==requestScope.status?"selected=\"selected\"":""} value="0">Kho??</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text"  class="form-control" placeholder="Nh???p t??n kho?? h???c" name="search" style="margin-top: 20px">
                    </div>
                    <div class="form-group col-md-2" style="">
                        <label for="inputState" ></label><br/>
                        <button class="input-box button" type="submit" style="border-radius: 5px;padding: 5px 15px 5px 15px;">
                            <i  style="" class="bi bi-search fa-lg"></i> T??m ki???m
                        </button>
                    </div>
                    <div class="form-group col-md-2" style="margin-top: 28px">
                        <button type="button" style="text-decoration: none;color: black" onclick="modal('insert-course-modal', 0, 'scale(1)')" style="text-decoration: none"><i class="bi bi-plus-circle-fill"></i> Th??m kho?? h???c</button>
                        <!--                   href="http://localhost:8080/onlinelearn/authen/manage/course/insert"-->

                    </div>
                </div>
            </form>
            <div class="text-center">
                <c:if test="${requestScope.courses.size()>0}">
                    <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                        <thead>
                            <tr>
                                <th style="width: 100px;" class="th-sm">???nh</th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='course_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc course_id&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">M?? (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='course_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc course_id&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">M?? (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='course_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc course_id&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">M??</a>
                                    </c:if>        
                                </th>

                                <th  class="th-sm">
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='course_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc course_title&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">T??n kho?? h???c (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='course_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc course_title&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">T??n kho?? h???c (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='course_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc course_title&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">T??n kho?? h???c</a>
                                    </c:if>       
                                </th>
                                <th class="th-sm">
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='topic_name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc topic_name&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Ch??? ????? (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='topic_name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc topic_name&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Ch??? ????? (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='topic_name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc topic_name&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Ch??? ?????</a>
                                    </c:if>     
                                </th>
                                <th class="th-sm">S??? ch????ng

                                </th>
                                <th class="th-sm">S??? b??i h???c

                                </th>
                                <th class="th-sm">
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='createdby'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc createdby&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Gi???ng vi??n (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='createdby'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc createdby&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Gi???ng vi??n (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='createdby'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc createdby&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Gi???ng vi??n</a>
                                    </c:if>   
                                </th>
                                <th class="th-sm">
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='[is_public]'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc [is_public]&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Tr???ng Th??i (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='[is_public]'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc [is_public]&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Tr???ng Th??i (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='[is_public]'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc [is_public]&index=${requestScope.index}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Tr???ng Th??i</a>
                                    </c:if>   
                                </th>                   
                                <th class="th-sm">H??nh ?????ng

                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.courses}" var="c">
                                <tr>
                                    <td ><img style="height: 50px; width: 70px;" class="img-thumbnail" src="${c.avatar}" /> </td>
                                    <td>${c.courseId}</td>
                                    <td>${c.courseTitle}</td>
                                    <td>${c.topic.topicName}</td>
                                    <td>${c.numberOfChapter}</td>
                                    <td>${c.numberOfLesson}</td>
                                    <td>${c.createdBy}</td>
                                    <td><c:if test="${c.status==true}"><p style="color: green">C??ng khai</p></c:if>
                                        <c:if test="${c.status==false}"><p style="color: red">Kho??</p></c:if>
                                        </td>
                                        <td>
                                            <a href="#" onclick="editCourse('${c.courseId}')" style="margin-right: 10px;text-decoration: none">Ch???nh s???a</a>
                                        <c:if test="${c.status==true}">
                                            <a style="text-decoration: none;color: red;" href="status/change?stt=${false}&id=${c.courseId}&index=${requestScope.index}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Kho??</a>
                                        </c:if>
                                        <c:if test="${c.status==false}">
                                            <a style="text-decoration: none;color: green" href="status/change?stt=${true}&id=${c.courseId}&index=${requestScope.index}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">C??ng khai</a>
                                        </c:if>
                                        <a href="prepare?id=${c.courseId}" style="margin-left: 10px;text-decoration: none">Th??m n???i dung</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>         
                    </table>
                </div>
                <div class="h-100 d-flex align-items-center justify-content-center">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <c:if test="${requestScope.index>3}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=1&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang ?????u</span></a>
                                </li>
                            </c:if>
                            <c:if test="${requestScope.index>2}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-2}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-2}</a></li>
                                </c:if> 
                                <c:if test="${requestScope.index>1}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-1}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-1}</a></li>
                                </c:if>                                              
                            <li class="page-item " style="background: #FF6600;border-radius:5px">
                                <span class="page-link">${requestScope.index}<span class="sr-only"></span>
                                </span>
                            </li>
                            <c:if test="${requestScope.index<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+1}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+1}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+1<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+2}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+2}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+2<requestScope.totalPage}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=${requestScope.totalPage}&sortTitle=${requestScope.sortTitle}&topicId=${requestScope.topicId}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang cu???i</span></a>
                                </li>                        
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>

            <div class="col-lg-1"></div>
        </c:if>
        <c:if test="${requestScope.courses.size()==0}">
            <div class="alert alert-info">
                <strong>Kh??ng t??m th???y kho?? h???c n??o!</strong>
            </div>
        </c:if>

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

            function editCourse(id) {
                var url = "edit?courseId=" + id;

                fetch(url).then(response => response.json())
                        .then(result => {
                            var course = result.course;

                            var editFeilds = document.getElementsByClassName("edit-course");
                            var topicOptions = document.getElementsByClassName("topic-option");
                            var expertOptions = document.getElementsByClassName("expert-option");

                            for (var i = 0; i < topicOptions.length; i++) {
                                var option = topicOptions[i];

                                if (parseInt(option.value) === course.topic.topicId) {
                                    option.selected = "selected";
                                }
                            }
                            for (var i = 0; i < expertOptions.length; i++) {
                                var option = expertOptions[i];

                                if (option.value === course.createdBy) {
                                    option.selected = "selected";
                                }
                            }
                            editFeilds[0].value = course.courseId;
                            editFeilds[1].value = course.courseTitle;

                            var container = document.getElementById('edit-container');

                            var box = " <textarea value=\"" + course.description + "\"  class=\"form-control edit-course\"\n\
                 rows=\"10\" name=\"description\" id =\"edit-description\" >";

                            box += course.description;
                            box += "   </textarea>";

                            container.innerHTML = box;

                            editFeilds[3].src = course.avatar;
                            CKEDITOR.replace('edit-description');//name textarea
                            modal('edit-course-modal', 1, 'scale(1)');
                        });
            }
        </script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="//cdn.ckeditor.com/4.18.0/basic/ckeditor.js"></script>
        <script>
            CKEDITOR.replace('description');//name textarea

        </script>
        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
    </body>
</html>
