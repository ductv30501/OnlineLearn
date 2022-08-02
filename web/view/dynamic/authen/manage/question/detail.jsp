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
        <title>Quản lí câu hỏi</title>     
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

    </head>
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
        h2{
            text-align: center;
            margin-top: 20px;
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

        #insert-option-modal{

            margin: auto;
            width: 40%;

            padding: 15px 35px 15px 35px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 99;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }
        #edit-option-modal{

            margin: auto;
            width: 40%;

            padding: 15px 35px 15px 35px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 99;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }




    </style>
    <body>
        <!--start insert option modal-->
        <div class="modal">
            <div  id="insert-option-modal">
                <form action="insert" method="POST" >
                    <div class="col-md-6">
                        <h4 class="text-right">Thêm câu trả lời</h4>
                        <div id="notification"></div>
                    </div>
                    <div class="row mt-2">                      
                        <div class="col-md-6">
                            <label class="labels">Nội dung đáp án</label>
                            <input id="option-detail-new" name="optionDetail"  class="form-control input" type="text" placeholder="Nhập nội dung câu hỏi" required="">
                        </div>

                        <div class="col-md-6">
                            <label  class="labels">là đáp đúng ?</label><br>
                            <input type="radio" name="status_new" value="1" required=""> đúng
                            <input type="radio" name="status_new" value="0" required=""> sai 
                        </div>
                    </div>                       
                    <div class="text-center mt-5">
                        <input type="button" class="input-box button" style=" padding: 5px;border-radius: 5px;" value="Thêm đáp án" onclick="InputOption(${requestScope.question.questionId})">
                        <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('insert-option-modal', 0, 'scale(0)')">Đóng</button>
                    </div>
                </form>
            </div>
        </div>
        <!--end insert option modal-->
        <!--start edit option modal-->
        <div class="modal">
            <div  id="edit-option-modal">
                <form action="edit" method="POST" >
                    <div class="col-md-6">
                        <h4 class="text-right">Thêm câu trả lời</h4>
                        <div id="notification"></div>
                    </div>
                    <div class="row mt-2">                      
                        <div class="col-md-6">
                            <label class="labels">Nội dung đáp án</label>
                            <input id="option-detail-new" name="optionDetail"  class="form-control edit" type="text" placeholder="Nhập nội dung câu hỏi" required="">
                            <input  name="optionID_edit"  class="form-control edit" type="hidden">
                        </div>

                        <div class="col-md-6">
                            <label  class="labels">là đáp đúng ?</label><br>
                            <input type="radio" name="status_edit" value="1" required=""> đúng
                            <input type="radio" name="status_edit" value="0" required=""> sai 
                        </div>
                    </div>                       
                    <div class="text-center mt-5">
                        <input type="button" class="input-box button" style=" padding: 5px;border-radius: 5px;" value="Lưu" onclick="EditOption(${requestScope.question.questionId})">
                        <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('edit-option-modal', 1, 'scale(0)')">Đóng</button>
                    </div>
                </form>
            </div>
        </div>
        <!--end edit option modal-->
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1"></div>
            <div class="container col-lg-10" style="background-color: #fff; padding-bottom: 20px;">
                <h2 style="padding-top: 20px;">Nội dung câu hỏi</h2>
                <form action="detail" method="POST">
                    <div class="row">               
                        <div class="col-md-12 " style="width: 100%;">
                            <div class="p-3 py-5">
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">Nội dung câu hỏi</label>
                                        <input name="content"  class="form-control editQ" type="text" value="${requestScope.question.questionTitle}" placeholder="Nhập nội dung câu hỏi" required="">
                                    <input name="question_id"  class="form-control editQ" type="hidden" value="${requestScope.question.questionId}" >
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Điểm</label>
                                    <input name="point" type="text" class="form-control editQ" value="${requestScope.question.point}" placeholder="Nhập điểm của câu hỏi" required="">
                                </div>                                                             
                            </div>
                            <div class="row mt-3">    
                                <div class="col-md-4">
                                    <label class="labels">Khóa học</label>
                                    <input name="searchCourse" class="form-control editQ" type="text" placeholder="Nhập tên khóa học" >
                                </div>
                                <div class="col-md-2">
                                    <label class="labels"></label>
                                    <a name="btnSearchCourse" class="input-box button" style="padding: 8px;border-radius: 5px;margin-top: 20px;" onclick="searchCourse('input', 'insert-quiz-modal', 0, 'scale(1)', 'edit-chapter', 'mySelectUpdate')" href="#" type="button"><i class="bi bi-search"></i></a>
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Khóa học</label>
                                    <div class="col-md-12">
                                        <select id="mySelectUpdate" name="course" class="form-select editQ" onchange="LoadChapter()" aria-label="Default select example" >
                                            <c:forEach items="${requestScope.courses}" var="c">
                                                <option ${c.courseId == requestScope.chapters.get(0).course.courseId?"selected=\"selected\"":""} value="${c.courseId}" >${c.courseTitle}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="row mt-3">
                                <div class="col-md-6">
                                    <label class="labels">Chương </label>
                                    <div class="col-md-12">
                                        <select id="edit-chapter" name="chapter" class="form-select editQ" aria-label="Default select example">
                                            <c:forEach items="${requestScope.chapterOfFristCourse}" var="c">
                                                <option ${c.chapterId==requestScope.question.chapter.chapterId?"selected=\"selected\"":""} value="${c.chapterId}">${c.chapterTitle} </option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Cấp độ</label>
                                    <select  name="level" class="form-select editQ" aria-label="Default select example">
                                        <option ${"1"==requestScope.question.questionLevel?"selected=\"selected\"":""} value="1">dễ</option>
                                        <option ${"2"==requestScope.question.questionLevel?"selected=\"selected\"":""} value="2">thường</option>
                                        <option ${"3"==requestScope.question.questionLevel?"selected=\"selected\"":""} value="3">khó</option>
                                    </select>
                                </div>                                                             
                            </div>
                        </div> <br>

                        <table id="dtBasicExample" class="table table-striped table-bordered table-sm" style="text-align: center">
                            <thead>
                                <tr>
                                    <th>nội dung câu trả lời</th>
                                    <th>Đúng/Sai</th>
                                    <th>Sửa</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${requestScope.options}" var="o">
                                    <tr>
                                        <td>${o.optionDetail}</td>
                                        <td><c:if test="${o.isCorrect==true}"><p style="color: green">Đúng</p></c:if>
                                            <c:if test="${o.isCorrect==false}"><p style="color: red">Sai</p></c:if>
                                            </td>
                                            <td>
                                                <a style="text-decoration: none" href="#" onclick="getOptionDetail(${o.optionId})">sửa</a>
                                            <a style="text-decoration: none;color: black" onclick="deleteOption(${o.optionId}, '${o.optionDetail}')">xóa</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- insert button -->
                        <div class="form-group col-md-2">
                            <label for="inputState" ></label><br/>
                            <button style="padding: 5px 5px 5px 15px;border-radius: 5px;text-align: center" class="input-box button" type="button" onclick="modal('insert-option-modal', 0, 'scale(1)');" >
                                <i class="bi bi-question-plus-fill"></i> Thêm đáp án
                            </button>
                        </div> <br>

                    </div>
                    <div class="text-center">
                        <button class="input-box button" id="btnSave" type="submit" style="padding: 5px;border-radius: 5px">Lưu thông tin</button>
                        <a class="input-box button" style="padding: 5px;border-radius: 5px" href="http://localhost:8080/onlinelearn/authen/manage/question/list"> Quay về</a>
                    </div>

                </div> 

            </form>
        </div>

        <div class="col-lg-1" style="margin-bottom: 20px;"></div>
        <div>
            <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>
        <div style="height: 20px; margin-top: 10px;"></div>
        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
        <script>
                                function modal(id, position, transform) {
                                    var box = document.getElementById(id);
                                    var modal = document.getElementsByClassName('modal');
                                    modal[position].style.transform = transform;
                                    box.style.transform = transform;
                                }
                                function LoadChapter() {
                                    var courseID = document.getElementById('mySelectUpdate').value;
                                    var url = "http://localhost:8080/onlinelearn/authen/expert/quiz/load?courseID=" + courseID;
                                    fetch(url).then(function (response) {
                                        return response.json();
                                    }).then(function (result) {
                                        var insertChapter = document.getElementById('edit-chapter');
                                        var chapters = result.chapters;
                                        var s = "";
                                        for (var i = 0; i < chapters.length; i++) {
                                            s += "<option value=\"" + chapters[i].chapterId + "\" ";
                                            s += ">" + chapters[i].chapterTitle + "</option>";
                                        }
                                        insertChapter.innerHTML = s;
                                    });
                                }
                                function showInputOption() {
                                    var inputOption = document.getElementById("insertOption");
                                    if (inputOption.style.display == "block") {
                                        inputOption.style.display = "none";
                                    } else {
                                        inputOption.style.display = "block"
                                    }

                                }
                                function InputOption(question_id) {
                                    var option_detail = document.getElementById("option-detail-new").value;
                                    var checkBox = document.getElementsByName('status_new');
                                    if (option_detail === '') {
                                        alert('Nội dung đáp án đang trống!');
                                        return;
                                    } else if (checkBox[0].checked === false && checkBox[1].checked === false) {
                                        alert('Chưa chọn đúng sai cho đáp án!');
                                        return;
                                    }

                                    var status = "";
                                    for (var i = 0; i < checkBox.length; i++) {
                                        if (checkBox[i].checked === true) {
                                            status = checkBox[i].value;
                                        }
                                    }
                                    var url = "http://localhost:8080/onlinelearn/authen/manage/option/insert?optionDetail=" + option_detail + "&status=" + status + "&question_id=" + question_id;
                                    fetch(url).then(function (response) {
                                        return response.json();
                                    }).then(function (result) {
                                        var notification = result.notification;
                                        if (notification === "1") {
                                            alert("thêm đáp án mới thành công");
                                            return;
                                        } else {
                                            alert("thêm đáp án mới thất bại");
                                            return;
                                        }
                                    });
                                    location.reload();
                                }
                                function EditOption(question_id) {
                                    var edits = document.getElementsByClassName('edit');
                                    //                                    var option_detail = document.getElementById("option-detail-new").value;
                                    var checkBox = document.getElementsByName('status_edit');
                                    if (edits[0].value === '') {
                                        alert('Nội dung đáp án đang trống!');
                                        return;
                                    } else if (checkBox[0].checked === false && checkBox[1].checked === false) {
                                        alert('Chưa chọn đúng sai cho đáp án!');
                                        return;
                                    }

                                    var status = "";
                                    for (var i = 0; i < checkBox.length; i++) {
                                        if (checkBox[i].checked === true) {
                                            status = checkBox[i].value;
                                        }
                                    }
                                    var url = "http://localhost:8080/onlinelearn/authen/manage/question/edit?optionDetail=" + edits[0].value + "&optionID=" + edits[1].value + "&status=" + status + "&question_id=" + question_id;
                                    fetch(url).then(function (response) {
                                        return response.json();
                                    }).then(function (result) {
                                        var notification = result.notification;
                                        if (notification === "1") {
                                            alert("sửa đáp án thành công");
                                            return;
                                        } else {
                                            alert("sửa đáp án thất bại");
                                            return;
                                        }
                                    });
                                    location.reload();
                                }
                                function deleteOption(id, name)
                                {
                                    var check = confirm("Bạn có muốn xóa khóa " + name + " không?");
                                    if (check)
                                    {
                                        var url = "http://localhost:8080/onlinelearn/authen/manage/option/delete?optionID=" + id;
                                        fetch(url).then(function (response) {
                                            return response.text();
                                        }).then(function (result) {
                                            if (result === '0') {
                                                alert('Xóa câu trả lời thất bại');
                                                window.location.reload();
                                            } else if (result === '1') {
                                                alert('Đã xóa câu trả lời ' + name + ' thành công');
                                                window.location.reload();
                                            }
                                        });
                                    }
                                }
                                function getOptionDetail(option_id) {
                                    var url = "http://localhost:8080/onlinelearn/authen/manage/option/detail?option_id=" + option_id;
                                    var edits = document.getElementsByClassName('edit');
                                    var statusEdit = document.getElementsByName('status_edit');
                                    fetch(url).then(function (response) {
                                        return response.json();
                                    }).then(function (result) {
                                        var myOption = result.option;

                                        edits[0].value = myOption.optionDetail;
                                        edits[1].value = myOption.optionId;
                                        if (myOption.isCorrect) {
                                            statusEdit[0].checked = "checked";
                                        } else {
                                            statusEdit[1].checked = "checked";
                                        }
                                        //                                        


                                    });
                                    modal('edit-option-modal', 1, 'scale(1)');
                                }
                                function searchCourse(type, modalID, position, transform, element, select) {
                                    var inputs = document.getElementsByClassName('editQ');
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

                                }
        </script>
    </body>
</html>
