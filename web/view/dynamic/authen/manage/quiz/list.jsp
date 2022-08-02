<%-- 
    Document   : list
    Created on : Jun 25, 2022, 12:24:49 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <!--<link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />-->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">-->
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet" type="text/css"/>

        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
        <title>JSP Page</title>

        <style>
            .message {
                text-align: right;
                color: red;
                font-size: 14px;
                margin: 2px 6px;

                animation-name: myAnimation;
                animation-duration: 10000ms;
                animation-fill-mode: forwards;
            }
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
                z-index: 99;
                display: flex;
            }

            #insert-quiz-modal
            {

                margin: auto;
                width: 45%;
                /*height: 600px;*/

                padding: 15px 35px 15px 35px;
                background: #fff;
                transform: scale(0);
                transition-duration: 0.4s;
                z-index: 99;
                border-radius: 5px;
                box-shadow: 0px 0px 1px 1px #ccc;
            }
            /*            #insert-quiz-modal .insert-quiz-left {
                            width: 45%;
                            float: left;
                        }
            
                        #insert-quiz-modal .insert-quiz-right {
                            width: 60%;
                            float: right;
                        }*/

            #edit-quiz-modal{

                margin: auto;
                width: 45%;
                display: block;
                padding: 15px 35px 15px 35px;
                background: #fff;
                transform: scale(0);
                transition-duration: 0.4s;
                z-index: 99;
                border-radius: 5px;
                box-shadow: 0px 0px 1px 1px #ccc;
            }

            .active {
                z-index: 3;
            }



            .html-duration-picker-input-controls-wrapper .html-duration-picker {
                text-align: right;
                padding-right: 20px;
                box-sizing: border-box;
                width: 100%;
                margin: 0;
                cursor: text;
            }

            .html-duration-picker-input-controls-wrapper .scroll-btn {
                text-align: center;
                width: 16px;
                padding: 0 4px;
                border: none;
                cursor: default;
                position: absolute;
            }

            .html-duration-picker-input-controls-wrapper .caret {
                width: 0;
                height: 0;
                border-style: solid;
            }

            .html-duration-picker-input-controls-wrapper .caret.caret-up {
                border-width: 0 4px 5px 4px;
                border-color: transparent transparent #000 transparent;
            }

            .html-duration-picker-input-controls-wrapper .caret.caret-down {
                border-width: 5px 4px 0 4px;
                border-color: #000 transparent transparent transparent;
            }

            .html-duration-picker-input-controls-wrapper .controls {
                display: inline-block;
                position: absolute;
                top: 1px;
                padding: 2px 0;
            }

            .html-duration-picker-input-controls-wrapper {
                display: inline-block;
                position: relative;
                background: transparent;
                padding: 0;
                box-sizing: border-box;
            }

        </style>

    </head>
    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <!-- start insert modal comment -->
            <div class="modal">
                <div  id="insert-quiz-modal">
                    <form action="insert" method="POST" >
                        <div class="insert-quiz-left" >
                            <div class="col-md-6">
                                <h4 class="text-right">Thêm bài kiểm tra mới</h4>
                                <div id="notification"></div>
                            </div>
                            <div class="row mt-2">                      
                                <div class="col-md-6">
                                    <label class="labels">Tên bài kiểm tra</label>
                                    <input name="quiz_title"  class="form-control input" type="text" placeholder="Nhập tiêu đề bài kiểm tra" required="">
                                </div>

                                <div class="col-md-6">
                                    <label class="labels">Điểm điều kiện</label>
                                    <input name="topass" type="text" class="form-control input" placeholder="Nhập điểm điều kiện" required="">
                                </div>
                            </div>                       
                            <div class="row mt-2">
                                <div class="col-md-6">
                                    <label class="labels">Miêu tả</label>
                                    <input name="description" class="form-control input" type="text" placeholder="Nhập miêu tả" required="">
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Thời gian</label>
                                    <input  data-duration-max="24:00:00" name="duration" class="html-duration-picker form-control input" type="text" placeholder="Nhập thời gian" required="">
                                </div>

                            </div>
                            <div class="row mt-2">
                                <div class="col-md-4">
                                    <label class="labels">Khóa học</label>
                                    <input name="searchCourse" class="form-control input" type="text" placeholder="Nhập tên khóa học" required="">
                                </div>
                                <div class="col-md-2">
                                    <label class="labels"></label>
                                    <a name="btnSearchCourse" class="input-box button" style="padding: 8px;border-radius: 5px;margin-top: 20px;" onclick="searchCourse('input', 'insert-quiz-modal', 0, 'scale(1)', 'insert-chapter', 'mySelect')" href="#" type="button"><i class="bi bi-search"></i></a>
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Khóa học</label>
                                    <select id="mySelect" name="course" class="form-select input" aria-label="Default select example" onchange="LoadChapter('insert-quiz-modal', 0, 'scale(1)', 'insert-chapter', 'mySelect')">
                                    <c:forEach items="${requestScope.courses}" var="c">
                                        <option value="${c.courseId}">${c.courseTitle} </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="row mt-2">                                                                                                   
                            <div class="col-md-6">
                                <label class="labels">Chương </label>
                                <div class="col-md-12">
                                    <select onchange="getQuestionList('insert-chapter')" id="insert-chapter" name="chapter" class="form-select input" aria-label="Default select example">
                                        <c:forEach items="${requestScope.chapterOfFristCourse}" var="c">
                                            <option value="${c.chapterId}">${c.chapterTitle} </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="labels">Số lượng câu hỏi</label>
                                <input name="numberQuestion" class="form-control input" type="text" onchange="CheckNumberQuestion('input')" placeholder="Nhập số lượng câu hỏi" required="">
                            </div>
                        </div>
                        <!--                        <div class="row mt-2">
                                                    <input type="text" class="html-duration-picker" data-duration="00:05:00" data-duration-min="00:01:00"
                                                           data-duration-max="24:00:00">
                                                </div> -->
                        <div class="text-center mt-5">
                            <button class="input-box button" type="button" style="padding: 5px;border-radius: 5px" onclick="insertQuiz()">Lưu</button>
                            <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('insert-quiz-modal', 0, 'scale(0)')">Đóng</button>
                        </div>
                    </div>
                    <!--                    <div class="insert-quiz-right" >
                                            <div class="col-md-6">
                                                <h4 class="text-center">Danh sách câu hỏi</h4>
                                                <div id="notification"></div>
                                            </div>
                                            <div>
                                                <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                                                    <thead>
                                                        <tr>
                                                            <th>Chọn</th>
                                                            <th>STT</th>
                                                            <th  class="th-sm">Nội dung</th>
                                                            <th class="th-sm">Cấp độ</th>
                                                            <th class="th-sm">Hành động</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody id="question-list" >
                                                    </tbody>         
                                                </table>
                                            </div>
                                        </div>-->

                </form>
            </div>
        </div> 
        <!-- end insert modal comment -->
        <!-- start edit modal comment -->
        <div class="modal"> 
            <div id="edit-quiz-modal">
                <form action="edit" method="POST">
                    <div class="row ">               
                        <div class="col-md-12 ">
                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h3 class="text-center">Thông tin bài kiểm tra</h3>
                                </div> 
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">Tên bài kiểm tra</label>
                                        <input name="quiz_title"  class="form-control edit" type="text" placeholder="Nhập tiêu đề bài kiểm tra" required="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Điểm điều kiện</label>
                                        <input name="topass" type="text" class="form-control edit" placeholder="Nhập điểm điều kiện vd: 80" required="">
                                    </div>                                                             
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">Miêu tả</label>
                                        <input name="description" class="form-control edit" type="text" placeholder="Nhập miêu tả" required="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Thời gian</label>
                                        <input  data-duration-max="24:00:00" name="duration" class="html-duration-picker form-control edit" type="text" placeholder="Nhập thời gian" required="">
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-4">
                                        <label class="labels">Khóa học</label>
                                        <input name="searchCourse" class="form-control edit" type="text" placeholder="Nhập tên khóa học"  >
                                    </div>
                                    <div class="col-md-2">
                                        <label class="labels"></label>
                                        <a name="btnSearchCourse" class="input-box button" style="padding: 8px;border-radius: 5px;margin-top: 20px;" onclick="searchCourse('edit', 'edit-quiz-modal', 1, 'scale(1)', 'edit-chapter', 'mySelectUpdate')" href="#" type="button"><i class="bi bi-search"></i></a>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Khóa học</label>
                                        <div class="col-md-12">
                                            <select id="mySelectUpdate" name="course" class="form-select edit" aria-label="Default select example" onchange="LoadChapter('edit-quiz-modal', 1, 'scale(1)', 'edit-chapter', 'mySelectUpdate')">
                                                <c:forEach items="${requestScope.courses}" var="c">
                                                    <option value="${c.courseId}">${c.courseTitle} </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>

                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">Chương </label>
                                        <div class="col-md-12">
                                            <select onchange="getQuestionList('edit-chapter')" id="edit-chapter" name="chapter" class="form-select edit" aria-label="Default select example">
                                                <c:forEach items="${requestScope.chapterOfFristCourse}" var="c">
                                                    <option value="${c.chapterId}">${c.chapterTitle} </option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Số lượng câu hỏi</label>
                                        <input name="numberQuestion" class="form-control edit" onchange="CheckNumberQuestion('edit')" type="text" placeholder="Nhập số lượng câu hỏi" required="">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels"></label>
                                        <input name="quiz_id" class="form-control edit" type="hidden">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <button class="input-box button" id="btnSave" type="submit" style="padding: 5px;border-radius: 5px">Lưu thông tin</button>
                            <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('edit--modal', 1, 'scale(0)')">Đóng</button>
                        </div>
                    </div>  
                </form>
            </div>
        </div>
        <!-- end edit modal  -->
        <!-- start table  -->

        <div style="background: #fff; padding:10px;margin-top: 20px; border-radius: 10px;" class="container col-lg-10">
            <form method="GET" action="list" style="margin-bottom: 20px; ">
                <div class="row">
                    <!-- number element in table -->
                    <div class="form-group col-md-1">
                        <label for="inputState" >Hiển thị</label>
                        <select id="inputState" class="form-control" name="number" onchange="this.form.submit()">
                            <option ${"5"==requestScope.number?"selected=\"selected\"":""} value="5">5 hàng</option>
                            <option ${"10"==requestScope.number?"selected=\"selected\"":""} value="10">10 hàng</option>
                            <option ${"15"==requestScope.number?"selected=\"selected\"":""} value="15">15 hàng</option>
                            <option ${"20"==requestScope.number?"selected=\"selected\"":""} value="20">20 hàng</option>
                        </select>                       
                    </div>
                    <!-- role -> course --> 
                    <div class="form-group col-md-2">
                        <label for="inputState">Khóa học</label>
                        <select id="inputState" name="course" class="form-control" onchange="this.form.submit()">
                            <option value="-1">Tất cả</option>
                            <c:forEach items="${requestScope.courses}" var="c">
                                <option ${c.courseId == requestScope.course?"selected=\"selected\"":""} value="${c.courseId}">${c.courseTitle}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- status -> chapter -->
                    <div class="form-group col-md-2">
                        <label for="inputState" >Chapter</label>
                        <select id="inputState" class="form-control" name="chapter" onchange="this.form.submit()">
                            <option value="-1">Tất cả</option>
                            <c:forEach items="${requestScope.chapters}" var="c">
                                <option ${c.chapterId == requestScope.chapter?"selected=\"selected\"":""} value="${c.chapterId}">${c.chapterTitle}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <!-- text search -->    
                    <div class="form-group col-md-3">
                        <input type="text"  class="form-control" placeholder="Nhập tiêu đề, mô tả"  name="search" style="margin-top: 20px">
                    </div>
                    <div class="form-group col-md-2" style="">
                        <label for="inputState" ></label><br/>
                        <button class="input-box button" type="submit" style="border-radius: 5px;padding: 5px 15px 5px 15px;">
                            <i  style="" class="bi bi-search fa-lg"></i> Tìm kiếm
                        </button>
                    </div>
                    <!-- insert button -->
                    <div class="form-group col-md-2">
                        <label for="inputState" ></label><br/>
                        <button style="padding: 5px 15px 5px 15px;border-radius: 5px;text-align: center" class="input-box button" type="button" onclick="modal('insert-quiz-modal', 0, 'scale(1)');" >
                            <i class="bi bi-quote-plus-fill"></i> Thêm bài kiểm tra
                        </button>
                    </div>                  
                </div>
            </form>
            <!-- table -->            
            <div class="text-center">
                <c:if test="${requestScope.quizies.size()>0}">
                    <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                        <thead>
                            <!-- sort -->
                            <tr>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj == 'quizz_id'}">
                                        <a style="text-decoration: none;color: black" 
                                           href="list?sortTitle=asc quizz_id&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Mã bài kiểm tra <img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>

                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='quizz_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc quizz_id&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Mã bài kiểm tra <img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='quizz_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc quizz_id&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Mã bài kiểm tra</a>
                                    </c:if>                                
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='quizz_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc quizz_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Tiêu đề Quiz <img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.sort=='asc' && requestScope.obj=='quizz_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc quizz_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Tiêu đề Quiz <img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='quizz_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc quizz_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Tiêu đề Quiz</a>
                                    </c:if>
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='description'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc description&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Mô tả <img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.sort=='asc' && requestScope.obj=='description'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc description&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Mô tả <img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='description'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc description&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Mô tả</a>
                                    </c:if>
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='topass'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc topass&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Điểm điều kiện <img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.sort=='asc' && requestScope.obj=='topass'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc topass&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Điểm điều kiện <img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='topass'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc topass&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Điểm điều kiện</a>
                                    </c:if>
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='chapter_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc chapter_id&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}"> Chapter ID <img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.sort=='asc' && requestScope.obj=='chapter_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc chapter_id&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Chapter ID <img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='chapter_id'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc chapter_id&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Chapter ID</a>
                                    </c:if>
                                </th>
                                <th> 
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='chapter_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc chapter_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Chương <img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.sort=='asc' && requestScope.obj=='chapter_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc chapter_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Chương<img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='chapter_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc chapter_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Chương</a>
                                    </c:if>
                                </th>
                                <th> 
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='course_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc course_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Khóa học<img style="width: 15px" src="../../../assets/img/down.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.sort=='asc' && requestScope.obj=='course_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc course_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Khóa học<img style="width: 15px" src="../../../assets/img/up.png" alt=""/></a>
                                        </c:if>
                                        <c:if test="${requestScope.obj!='course_title'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc course_title&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">Khóa học</a>
                                    </c:if>
                                </th>
                                <th>Hành động</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.quizies}" var="q">
                                <tr>
                                    <td>${q.quizId}</td>
                                    <td>${q.quizTitle}</td>
                                    <td>${q.description}</td>
                                    <td>${q.toPass}%</td>
                                    <td>${q.chapter.chapterId}</td>
                                    <td>${q.chapter.chapterTitle}</td>
                                    <td>${q.course.courseTitle}</td>
                                    <td>
                                        <a style="text-decoration: none" href="#" onclick="getQuizDetail('${q.quizId}')">Chi tiết</a>
                                        <a style="text-decoration: none" href="#" onclick="deleteQuiz('${q.quizId}', '${q.quizTitle}')"> <label style="color: red">Xóa</label> </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="h-100  d-flex align-items-center justify-content-center">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <c:if test="${requestScope.index>3}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=1&course=${requestScope.course}&sortTitle=${requestScope.sortTitle}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang đầu<span class="sr-only"></span></span></a>
                                </li>
                            </c:if>
                            <c:if test="${requestScope.index>2}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-2}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-2}</a></li>
                                </c:if> 
                                <c:if test="${requestScope.index>1}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-1}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-1}</a></li>
                                </c:if>                                              
                            <li class="page-item " style="background: #FF6600;border-radius:5px">
                                <span class="page-link" >${requestScope.index}
                                </span>
                            </li>
                            <c:if test="${requestScope.index<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+1}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+1}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+1<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+2}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+2}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+2<requestScope.totalPage}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=${requestScope.totalPage}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang cuối<span class="sr-only"></span></span></a>
                                </li>                        
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.quizies.size()==0}">
            <div class="alert alert-info">
                <strong>Không tìm thấy bài quiz nào!</strong>
            </div>
        </c:if>    
        <div class="col-lg-1" style="margin-bottom: 20px;"></div>
        <div>
            <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>
        <div style="height: 20px; margin-top: 10px;"></div>
        <script>



            function createQuestion(index, question) {
                var box = "";
                var level = "";
                box += "<tr>";
                box += "<td><input type=\"checkbox\" value=\"" + question.questionId + "\" name=\"questionList\" /></td>";
                box += "<td>" + index + "</td>";
                box += "<td>" + question.questionTitle + "</td>";
                if (question.questionLevel === 1) {
                    level = "Dễ";
                } else if (question.questionLevel === 2) {
                    level = "Thường";
                } else {
                    level = "Khó";

                }
                box += "<td>" + level + "</td>";
                box += "<td><button onclick=\"showQuestionDetail('" + question.questionId + "')\" >Chi tiết</button></td>";
                box += "</tr>";
                return box;
            }
            function showQuestionDetail(questionId) {
                var url = "../../manage/question/get?questionId=" + questionId;
                fetch(url, {method: "POST"}).then(response => response.json())
                        .then(result => {
                            var question = result.question;

                        });

            }

            function getQuestionList(id) {
                var chapter = document.getElementById(id);
                var chapterId = chapter.options[chapter.selectedIndex].value;
                var questionList = document.getElementById('question-list');
                var url = "../../manage/question/get?chapterId=" + chapterId;

                fetch(url, {method: "POST"}).then(response => response.json())
                        .then(result => {
                            var questions = result.questions;
                            for (var i = 0; i < questions.length; i++) {
                                var box = createQuestion(i + 1, questions[i]);
                                questionList.insertAdjacentHTML('beforeend', box);
                            }
                        });


            }

            function modal(id, position, transform) {
                var box = document.getElementById(id);
                var modal = document.getElementsByClassName('modal');
                modal[position].style.transform = transform;
                box.style.transform = transform;
            }
            function CheckNumberQuestion(type) {
                var inputs = document.getElementsByClassName(type);
                var courseID = inputs[4].value;
                var chapterID = inputs[5].value;
                var numberQuestion = inputs[6].value;

                var url = "check?course=" + courseID;
                url += "&chapter=" + chapterID;
                fetch(url).then(function (response) {
                    return response.json();
                }).then(function (result) {
                    var numberQuestionOfChapter = result.numberQuestionOfChapter;
                    if (numberQuestion < 0) {
                        alert('số lượng câu hỏi phải lớn hơn 0');
                        inputs[6].value = "0";
                        return;
                    }
                    if (numberQuestion > numberQuestionOfChapter) {
                        alert('số lượng câu hỏi của chương không đủ để tạo bài \n' +
                                'kiểm tra vui lòng thêm câu hỏi hoặc giảm câu hỏi trong bài kiểm tra!\n' +
                                'số lượng câu hỏi đang có trong chương là: ' + numberQuestionOfChapter + '');
                        inputs[6].value = "0";
                        return;
                    }

                });

            }

            function insertQuiz() {
                var inputs = document.getElementsByClassName('input');
                var quiz_title = inputs[0].value;
                var topass = inputs[1].value;
                var description = inputs[2].value;
                var duration = inputs[3].value;
                var course = inputs[5].value;
                var chapter = inputs[6].value;
                var numberQuestion = inputs[7].value;
                if (quiz_title === '') {
                    alert('Tiêu đề bài kiểm tra đang trống!');
                    return;
                } else if (topass === '') {
                    alert('Điểm điều kiện đang trống!');
                    return;
                } else if (description === '') {
                    alert('Miêu tả đang trống!');
                    return;
                } else if (numberQuestion === '') {
                    alert('Chưa nhập số lượng câu hỏi!');
                    return;
                }


                var url = "insert?quiz_title=" + quiz_title + "&topass=" + topass + "&description=" + description + "&numberQuestion=" + numberQuestion + "&course=" + course + "&duration=" + duration;
                url += "&chapter=" + chapter + "";
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    if (result === '3') {
                        alert('Thêm bài kiểm tra thành công');
                        window.location.href = "list";
                    }
                });
            }



            function getQuizDetail(quiz_id) {
                var url = "edit?quiz_id=" + quiz_id;
                var edits = document.getElementsByClassName('edit');
                fetch(url).then(function (response) {
                    return response.json();
                }).then(function (result) {
                    var saveButton = document.getElementById('btnSave');
                    var checkExist = result.checkExist;
                    saveButton.style.display = "inline-block";
                    if (checkExist) {
                        alert('Bài kiểm tra không thể chỉnh sửa vì đã có học viên làm bài');
                        saveButton.style.display = "none";
                    }


                    var editChapter = document.getElementById('edit-chapter');
                    var quiz = result.quiz;
                    var chapters = result.chapters;
                    var courses = result.courses;

                    edits[0].value = quiz.quizTitle;
                    edits[1].value = quiz.toPass;
                    edits[2].value = quiz.description;
                    edits[3].value = result.duration;
                    edits[7].value = quiz.numberQuestion;
                    edits[8].value = quiz_id;
                    var editCourse = document.getElementById('mySelectUpdate');
                    var str = "";
                    for (var i = 0; i < courses.length; i++) {
                        str += "<option value=\"" + courses[i].courseId + "\" ";
                        if (courses[i].courseTitle === quiz.courseTitle) {
                            str += "selected";
                        }
                        str += ">" + courses[i].courseTitle + "</option>";
                    }
                    editCourse.innerHTML = str;

                    var s = "";
                    for (var i = 0; i < chapters.length; i++) {
                        s += "<option value=\"" + chapters[i].chapterId + "\" ";
                        if (chapters[i].chapterTitle === quiz.chapterTitle) {
                            s += "selected";
                        }
                        s += ">" + chapters[i].chapterTitle + "</option>";
                    }

                    editChapter.innerHTML = s;

                });
                modal('edit-quiz-modal', 1, 'scale(1)');
            }

            function LoadChapter(modalID, position, transform, element, select) {
                var courseID = document.getElementById(select).value;
                var url = "load?courseID=" + courseID;
                fetch(url).then(function (response) {
                    return response.json();
                }).then(function (result) {
                    var insertChapter = document.getElementById(element);
                    var chapters = result.chapters;
                    var s = "";
                    for (var i = 0; i < chapters.length; i++) {
                        s += "<option value=\"" + chapters[i].chapterId + "\" ";
                        s += ">" + chapters[i].chapterTitle + "</option>";
                    }
                    insertChapter.innerHTML = s;
                });
                modal(modalID, position, transform);
            }
            function searchCourse(type, modalID, position, transform, element, select) {
                var inputs = document.getElementsByClassName(type);
                var search = inputs[3].value;
                var url = "http://localhost:8080/onlinelearn/authen/expert/course/search?searchBy=" + search;
                fetch(url).then(function (response) {
                    return response.json();
                }).then(function (result) {
                    var courses = result.courseSearch;



                    //load course
                    var selectCourse = document.getElementById(select);
                    var s = "";
                    for (var i = 0; i < courses.length; i++) {
                        s += "<option value=\"" + courses[i].courseId + "\" ";
                        s += ">" + courses[i].courseTitle + "</option>";
                    }
                    selectCourse.innerHTML = s;


                });
                modal(modalID, position, transform);
            }
            function deleteQuiz(id, name)
            {
                var check = confirm("Bạn có muốn xóa khóa " + name + " không?");
                if (check)
                {
                    var url = "delete?quiz_id=" + id;
                    fetch(url).then(function (response) {
                        return response.text();
                    }).then(function (result) {
                        if (result === '0') {
                            alert('Bài kiểm tra không thể xóa vì đã có học viên làm bài');
                            window.location.href = "list";
                        } else if (result === '1') {
                            alert('Đã xóa bài kiểm tra ' + name + ' thành công');
                            window.location.href = "list";
                        }
                    });
                }
            }
        </script>
        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <script src="../../../assets/js/html-duration-picker.js" ></script>
        <script src="https://cdn.jsdelivr.net/npm/html-duration-picker@latest/dist/html-duration-picker.min.js"></script>


    </body>
</html>
