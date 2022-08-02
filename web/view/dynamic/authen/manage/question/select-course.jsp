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
        <link href="../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <!--this is font-awesome library added by phi-->
        <link rel="stylesheet" href="../../assets/css/simple-notify.min.css" />
        <script src="../../assets/js/simple-notify.min.js"></script>
        <script src="../../js/main.js"></script>


    </head>
    <style>
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

        #choose-course-modal{

            top: 25%;
            left: 25%;
            width: 50%;
            /*height: 25vh;*/
            position: absolute;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            padding: 20px;
            z-index: 10;
            border-radius: 3px;
            min-height: 50vh;
            z-index: 99;
            box-shadow: 0 5px 10px rgba(0,0,0,.1);
        }

        .course-container {
            position: relative;
        }


        .course-title {
            display: block;
            padding-top: 10px;
            padding-bottom: 10px;
            padding-left: 5px;
            padding-right: 5px;
            border-radius: 3px;
        }

        .course-title:hover {
            background-color: #ff6600;
            color: #fff;
        }


        .btn-choose-course:hover {
            box-shadow: 1px 1px 1px #ccc;
        }

        .btn-choose-course {
            padding: 5px 20px 5px 20px;
            border:1px solid #ccc;
            color: #fff;
            background-color: #ff6600;
            border-radius: 3px;
            width: 150px;
        }
    </style>
    <script>


        function searchCourses(event) {
            var search = event.value;
            var url = "http://localhost:8080/onlinelearn/authen/manage/question/import?search=" + search;
            fetch(url).then(response => response.json())
                    .then(result => {
                        var courses = result.courses;

                        var resultBox = document.getElementById('search-result');
                        var box = "";

                        for (var i = 0; i < courses.length; i++) {
                            var course = courses[i];
                            box += "<span onclick=\"setCourse('" + course.courseId + "', '" + course.courseTitle + "')\" class=\"course-title\" >" + course.courseTitle + "</span>";
                        }
                        resultBox.style.display = "block";
                        resultBox.innerHTML = box;
                    });

        }


        function setCourse(id, title) {
            var url = "http://localhost:8080/onlinelearn/authen/manage/chapter/get?courseId=" + id;
            fetch(url).then(response => response.json())
                    .then(result => {
                        var search = document.getElementById('search');
                        var courseId = document.getElementById('course-id');
                        courseId.value = id;
                        search.value = title;
                        var resultBox = document.getElementById('search-result');
                        var chapters = result.chapters;
                        var chapterBox = document.getElementById('chapter');
                        var s = "<select name=\"chapter\" id=\"chapterBox\" class=\"form-select input\" aria-label=\"Default select example\">";
                        for (var i = 0; i < chapters.length; i++) {
                            s += "<option value=\"" + chapters[i].chapterId + "\" ";
                            s += "   >" + chapters[i].chapterTitle + "</option>";
                        }
                        s += "</select>";

                        resultBox.style.display = "none";
                        chapterBox.innerHTML = s;
                    });
        }
    </script>
    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>

        <div style=" margin-top: 20px; " class="container col-md-12">
            <p style="color: red;" >* Vui lòng chọn khóa học để hiện thị danh sách câu hỏi</p>
            <button class="btn-choose-course" onclick="modal('choose-course-modal', 0, 'scale(1)');" >Chọn khóa học</button>
        </div>

        <div class="modal">
            <div id="choose-course-modal">
                <form style="width: 100%;" action="http://localhost:8080/onlinelearn/authen/manage/question/list" method="GET">                      
                    <h3>Chọn khóa học</h3>
                    <div class="row">                                                                                                   
                        <div  class="col-6  course-container ">
                            <label class="labels">Khoá học</label>
                            <div class="row">
                                <p >
                                    <input type="hidden" name="course" id="course-id" />
                                    <input  type="text"  class="form-control" 
                                            placeholder="Nhập tên khoá học"
                                            id="search"
                                            oninput="searchCourses(this)">
                                </p>                               
                            </div>    
                            <div id="search-result" ></div>

                        </div>                      
                        <div class="col-6">
                            <label for="inputState">Chương</label >
                            <div id="chapter">
                                <p style="color:red">Bạn chưa chọn khoá học!</p>
                            </div>
                        </div>
                    </div>                                   
                    <div class="text-center" style="margin-top: 200px;">
                        <button class="btn-choose-course" type="submit" onclick="">Xác nhận</button>
                        <button style="margin-left: 10px;" class="btn-choose-course" type="button" onclick="closeAll()">Đóng</button>
                    </div>

                </form>
            </div>
        </div> 
    </body>
    <script src="../../admin/js/tabler.min.js" defer></script>
    <script src="../../admin/js/demo.min.js" defer></script>
    <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
    <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
    <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
    <script>
                            function closeAll() {
                                var resultBox = document.getElementById('search-result');
                                var search = document.getElementById('search');
                                var chapterBox = document.getElementById('chapter');
                               
                                search.value = "";
                                resultBox.style.display = "none";

                                chapterBox.innerHTML = "   <p style=\"color:red\">Bạn chưa chọn khoá học!</p>";

                                modal('choose-course-modal', 0, 'scale(0)')
                            }

                            modal('choose-course-modal', 0, 'scale(1)');
    </script>
</html>
