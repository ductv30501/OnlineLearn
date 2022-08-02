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
        <!--this is font-awesome library added by phi-->
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
            z-index: 99;
            display: flex;
        }
        .block{
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

        #import-modal,  #question-import-result, #div-search{
            top: 5%;
            margin: auto;
            width: 50%;

            padding: 15px 35px 15px 35px;
            background: #fff;
            transition-duration: 0.4s;
            z-index: 99;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }

        #question-import-result {
            width: 80%;
            min-height: 80vh;

        }

        .table-wrapper {
            overflow: auto;
            max-height: 420px;
        }


    </style>
    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>

            <div class="modal">
                <div id="import-modal">
                    <form id="searchForm" enctype="multipart/form-data">                      
                        <div class="row mt-2">
                            <div>
                                <label class="labels">Chọn file Excel</label>
                                <input name="excel" id="excel" type="file" accept=".xlsx, .xls" class="form-control input" required=""/>
                            </div>
                        </div>
                        <input value="${requestScope.currentChapter.chapterId}" name="chapter" type="hidden" />                                 
                    <input  value="${requestScope.currentCourse.courseId}" name="course" type="hidden" />                                 
                    <div class="text-center mt-5">
                        <button class="input-box button" type="button" onclick="mySubmit();" style="padding: 5px;border-radius: 5px">Thêm câu hỏi</button>
                        <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('import-modal', 0, 'scale(0)')">Đóng</button>
                    </div>
                </form>
            </div>
        </div> 

        <div class="modal">
            <div  id="question-import-result">
                <h1 id="result-rate" ></h1>
                <form id="form-export" method="POST" action="export">
                    <div class="table-wrapper" >
                        <table id="result-table" class="table table-striped table-bordered table-sm">
                            <thead>
                                <tr>                                   
                                    <th  class="th-sm text-center">
                                        Nội dung câu hỏi
                                    </th>
                                    <th class="th-sm text-center">
                                        Điểm
                                    </th>
                                    <th class="th-sm text-center">
                                        Độ khó 
                                    </th>                                 
                                    <th class="th-sm text-center">
                                        Đáp án
                                    </th>
                                    <th class="th-sm text-center">
                                        Loại câu hỏi 
                                    </th>
                                    <th class="th-sm text-center">
                                        Ghi chú 
                                    </th>                               
                                </tr>
                            </thead>
                            <tbody id="question-list">

                            </tbody>         
                        </table>
                    </div>
                    <div style="display: none" id="data">

                    </div>
                    <div class="text-center mt-5">
                        <button id="export-invalid-question" class="input-box button" type="submit"  style="padding: 5px; border-radius: 5px">Xuất câu hỏi lỗi</button>
                        <button class="input-box button" type="button" style="margin-left: 10px;padding:5px;border-radius: 5px" onclick="window.location.reload();">Đóng</button>
                    </div>
                </form>
            </div>
        </div>           

        <div style="background: #fff; padding:20px;margin-top: 20px;border-radius: 5px; position: relative;" class="container col-md-12">
            <h1>Khóa học: ${requestScope.currentCourse.courseTitle}</h1>
            <h3>Chapter: ${requestScope.currentChapter.chapterTitle}</h3>
            <button onclick="window.location.href = 'http://localhost:8080/onlinelearn/authen/course/select'" style="  padding: 5px 20px 5px 20px;
                    border:1px solid #ccc;
                    color: #fff;
                    background-color: #ff6600;
                    border-radius: 3px;
                    width: 200px; right: 20px; top: 30px; position: absolute;">
                Chọn khóa học khác
            </button>
            <form  method="GET" action="list" style="margin-bottom: 15px; padding-top: 10px; border-top: 1px solid #ccc;">
                <input value="${requestScope.currentChapter.chapterId}" name="chapter" type="hidden" />                                 
                <input  value="${requestScope.currentCourse.courseId}" name="course" type="hidden" /> 
                <div class="row">
                    <div class="form-group col-md-1">
                        <label for="inputState" >Hiển thị</label>
                        <select id="inputState" class="form-control" name="number" onchange="this.form.submit()">
                            <option ${"5"==requestScope.number?"selected=\"selected\"":""} value="5">5 hàng</option>
                            <option ${"10"==requestScope.number?"selected=\"selected\"":""} value="10">10 hàng</option>
                            <option ${"15"==requestScope.number?"selected=\"selected\"":""} value="15">15 hàng</option>
                            <option ${"20"==requestScope.number?"selected=\"selected\"":""} value="20">20 hàng</option>
                        </select>                       
                    </div>

                    <div class="form-group col-md-1">
                        <label for="inputState" >Cấp độ</label >
                        <select id="inputState" class="form-control" name="level" onchange="this.form.submit()">
                            <option value="-1">Tất cả</option>                           
                            <option ${"1"==requestScope.level?"selected=\"selected\"":""} value="1">Dễ</option>
                            <option ${"2"==requestScope.level?"selected=\"selected\"":""} value="2">Thường</option>
                            <option ${"3"==requestScope.level?"selected=\"selected\"":""} value="3">khó</option>
                        </select>
                    </div>
                    <div class="form-group col-md-6">
                        <input type="text"  class="form-control" placeholder="Nhập nội dung câu hỏi" name="search" style="margin-top: 20px">
                    </div>                   
                    <div class="form-group col-md-4">
                        <div class="row">
                            <div class="col-md-4">
                                <label for="inputState" ></label><br/>
                                <button class="input-box button" type="submit" style="border-radius: 5px;padding: 5px 15px 5px 15px;">
                                    <i  style="" class="bi bi-search fa-lg"></i> Tìm kiếm
                                </button>
                            </div>
                            <div class="col-md-4">
                                <label for="inputState" ></label><br/>
                                <button class="input-box button" type="button" style="border-radius: 5px;padding: 6px 15px 0px 15px;float: right">
                                    <h5><a  style="text-decoration: none;color: white" href="../../../Excel/Sample.xlsx" download="Sample-Import"><i class="bi bi-box-arrow-down"></i> Tải bản mẫu</a></h5>
                                </button>
                            </div>
                            <div class="col-md-4">
                                <label for="inputState" ></label><br/>
                                <button class="input-box button" type="button" onclick="modal('import-modal', 0, 'scale(1)');" style="border-radius: 5px;padding: 6px 15px 0px 15px;float: right">
                                    <h5> <a  style="text-decoration: none;color: white" href="#"><i class="bi bi-upload"></i> Tải tệp lên</a></h5>
                                </button>
                            </div>
                        </div>
                    </div>                       
                </div>
            </form>
            <c:if test="${requestScope.questions.size()>0}">
                <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                    <thead>
                        <tr>                              

                            <th  class="th-sm text-center">
                                <c:if test="${requestScope.sort=='desc' && requestScope.obj=='question_content'}">
                                    <a style="text-decoration: none;color: black" href="list?sortTitle=asc question_content&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">Nội dung (giảm dần)</a>
                                </c:if>
                                <c:if test="${requestScope.sort=='asc' && requestScope.obj=='question_content'}">
                                    <a style="text-decoration: none;color: black" href="list?sortTitle=desc question_content&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">Nội dung (tăng dần)</a>
                                </c:if>
                                <c:if test="${requestScope.obj!='question_content'}">
                                    <a style="text-decoration: none;color: black" href="list?sortTitle=asc question_content&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">Nội dung</a>
                                </c:if>       
                            </th>

                            <th class="th-sm text-center">
                                <c:if test="${requestScope.sort=='desc' && requestScope.obj=='question_level'}">
                                    <a style="text-decoration: none;color: black" href="list?sortTitle=asc question_level&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">Cấp độ (giảm dần)</a>
                                </c:if>
                                <c:if test="${requestScope.sort=='asc' && requestScope.obj=='question_level'}">
                                    <a style="text-decoration: none;color: black" href="list?sortTitle=desc question_level&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">Cấp độ (tăng dần)</a>
                                </c:if>
                                <c:if test="${requestScope.obj!='question_level'}">
                                    <a style="text-decoration: none;color: black" href="list?sortTitle=asc question_level&index=${requestScope.index}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">Cấp độ</a>
                                </c:if>   
                            </th>
                            <th class="th-sm text-center">
                                Hành động
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${requestScope.questions}" var="q">
                            <tr>
                                <td>${q.questionTitle}</td>

                                <td class="text-center">
                                    <c:if test="${q.questionLevel=='1'}">Dễ</c:if>
                                    <c:if test="${q.questionLevel=='2'}">Thường</c:if>
                                    <c:if test="${q.questionLevel=='3'}">Khó</c:if>
                                    </td>
                                    <td class="text-center"><a style="text-decoration: none"  href="detail?question_id=${q.questionId}" >Chi tiết</a></td> 
                            </tr>
                        </c:forEach>
                    </tbody>         
                </table>
                <div class="h-100 d-flex align-items-center justify-content-center">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <c:if test="${requestScope.index>3}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=1&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang đầu</span></a>
                                </li>
                            </c:if>
                            <c:if test="${requestScope.index>2}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-2}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-2}</a></li>
                                </c:if> 
                                <c:if test="${requestScope.index>1}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-1}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-1}</a></li>
                                </c:if>                                              
                            <li class="page-item " style="background: #FF6600;border-radius:5px">
                                <span class="page-link">${requestScope.index}<span class="sr-only"></span>
                                </span>
                            </li>
                            <c:if test="${requestScope.index<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+1}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+1}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+1<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+2}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+2}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+2<requestScope.totalPage}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=${requestScope.totalPage}&sortTitle=${requestScope.sortTitle}&course=${requestScope.course}&chapter=${requestScope.chapter}&level=${requestScope.level}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang cuối</span></a>
                                </li>                        
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
            <div class="col-lg-1" style="margin-bottom: 20px;"></div>
        </c:if>
        <c:if test="${requestScope.questions.size()==0}">
            <div class="alert alert-info">
                <strong>Không tìm thấy câu hỏi nào!</strong>
            </div>
        </c:if>          
        <div>
            <jsp:include page="../../../component/private-footer.jsp"></jsp:include>
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

                                    function mySubmit() {
                                        var excel = document.getElementById('excel').value;
                                        if (excel === '') {
                                            createNotify("warning", "Thông báo", "Vui lòng chọn file trước!", true);
                                            return;
                                        } else {
                                            validateData();
                                        }
                                    }

                                    function validateData() {
                                        var form = document.getElementById("searchForm");
                                        var xhr = new XMLHttpRequest(); // create XMLHttpRequest
                                        var data = new FormData(form); // create formData object

                                        xhr.open("POST", "import", form.action); // open connection

                                        xhr.onload = function () {
                                            var result = JSON.parse(this.responseText);
                                            var notification = result.notification;
                                            var importResult = result.importResult;
                                            var Invalidquestions = result.Invalidquestions;
                                            var resultRate = document.getElementById('result-rate');

                                            resultRate.innerHTML = "Kết quả tải lên: "
                                                    + (parseInt(importResult.length) - parseInt(Invalidquestions.length))
                                                    + "/" + importResult.length;

                                            var questionList = document.getElementById("question-list");
                                            var row = "";
                                            for (var i = 0; i < importResult.length; i++) {
                                                row += "<tr>";
                                                row += "<td>" + importResult[i].questionTitle + "</td>";
                                                row += "<td style=\"text-align: center\">" + importResult[i].point + "</td>";
                                                row += "<td style=\"text-align: center\">" + importResult[i].questionLevel + "</td>";
                                                row += "<td>" + importResult[i].options + "</td>";
                                                row += "<td style=\"text-align: center\">" + importResult[i].questionType + "</td>";
                                                row += "<td>" + importResult[i].note + "</td>";
                                                row += "</tr>";
                                            }


                                            questionList.innerHTML = row;
                                            row = "";
                                            var data = document.getElementById("data");
                                            for (var i = 0; i < Invalidquestions.length; i++) {
                                                row += "<input type=\"hidden\" name=\"questionTitle\" value=\"" + Invalidquestions[i].questionTitle + "\">\n";
                                                row += "<input type=\"hidden\" name=\"point\" value=\"" + parseInt(Invalidquestions[i].point) + "\">\n";
                                                row += "<input type=\"hidden\" name=\"questionLevel\" value=\"" + parseInt(Invalidquestions[i].questionLevel) + "\">\n";
                                                row += "<input type=\"hidden\" name=\"options\" value=\"" + Invalidquestions[i].options + "\">\n";
                                                row += "<input type=\"hidden\" name=\"questionType\" value=\"" + parseInt(Invalidquestions[i].questionType) + "\">\n";
                                                row += "<input type=\"hidden\" name=\"note\" value=\"" + Invalidquestions[i].note + "\">";
                                            }
                                            data.innerHTML = row;

                                            var btnExport = document.getElementById('export-invalid-question');
                                            if (Invalidquestions.length === 0) {
                                                btnExport.style.display = "none";
                                            } else {
                                                btnExport.style.display = "inline-block";
                                            }
                                            createNotify("warning", "Thông báo", "Chi tiết tải lên câu hỏi!", false);
                                            modal("question-import-result", 1, "scale(1)");
//                                                createNotify("success", "Thông báo", "Tải tệp thành công!", true);
                                        };
                                        xhr.send(data);
                                    }



//                                    function getCourses() {
//                                        var search = document.getElementById('search').value;
//                                        if (search === '') {
//                                            createNotify("warning", "Thông báo", "Vui lòng tìm khoá học trước!", true);
//                                            return;
//                                        }
//                                        var url = "import?search=" + search + "";
//                                        fetch(url).then(function (response) {
//                                            return response.json();
//                                        }).then(function (result) {
//                                            var chapters = result.chapters;
//                                            var course = result.course;
//                                            var courseTitle = document.getElementById('courseTitle');
//                                            var chapter = document.getElementById('chapter');
//                                            if (course !== undefined) {
//                                                courseTitle.innerHTML = "<h4 style=\"color:black\">" + course.courseTitle + "</h4>";
//                                            } else {
//                                                courseTitle.innerHTML = "<p style=\"color:red\">Không tìm thấy khoá học nào!</p>";
//                                            }
//                                            if (chapters.length > 0) {
//                                                var s = "<select name=\"chapter\" id=\"chapterBox\" class=\"form-select input\" aria-label=\"Default select example\">";
//                                                for (var i = 0; i < chapters.length; i++) {
//                                                    s += "<option value=\"" + chapters[i].chapterId + "\" ";
//                                                    s += "   >" + chapters[i].chapterTitle + "</option>";
//                                                }
//                                                s += "</select>";
//                                                chapter.innerHTML = s;
//                                            } else {
//                                                chapter.innerHTML = '<p style="color:red">Khoá học này chưa có chương nào!</p>';
//                                            }
//                                        });
//                                    }
        </script>
    </body>
</html>
