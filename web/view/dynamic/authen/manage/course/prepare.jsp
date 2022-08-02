<%-- 
    Document   : prepare
    Created on : May 30, 2022, 10:12:47 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!--<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css"/>-->
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../css/tabler.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">

        <link rel="stylesheet" href="../../../assets/css/simple-notify.min.css" />
        <script src="../../../assets/js/simple-notify.min.js"></script>
        <script src="../../../js/main.js"></script>
    </head>
    <style>

        * {
            box-sizing: border-box;
        }
        body {
            overflow: auto;

        }
        .modal {
            position: fixed;
            left: 0;
            top: 0;
            display: block;
            background: rgba(0, 0, 0, 0.3);
            height: 100%;
            width: 100%;
            transform: scale(0);
            transition-duration: 0s;
            z-index: 2;
        }

        .modal:nth-of-type(4) {
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

        #insert-chapter-modal,
        #view-chapter-modal,
        #edit-chapter-modal {
            top: 2px;
            left: 35%;
            width: 35%;
            min-height: 320px;
            max-height: 80vh;
        }
        #insert-lesson-modal,
        #view-lesson-modal,
        #edit-lesson-modal
        {
            top: 2px;
            left: 15%;
            width: 70%;
            min-height: 390px;
            max-height: 100vh;
        }

        #insert-chapter-modal,
        #insert-lesson-modal,
        #edit-chapter-modal,
        #edit-lesson-modal,
        #view-lesson-modal,
        #view-chapter-modal
        {
            position: absolute;
            padding: 25px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 10;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }
        .course-detail {

            /*background: #fff;*/
            width: 100%;
            min-height: 200px;
            /*border: 1px solid #ccc;*/
            /*box-shadow: 1px 1px 1px 1px #ccc;*/
            border-radius: 5px;
            padding-top: 20px;
            margin-top: 20px;
            padding-left: 20px;
            padding-right:  20px;
            padding-bottom: 20px;
        }



        .course-detail .left {
            float: left;
            width: 70%;


        }

        .course-detail .left .chapter-list {
            overflow: auto;
            max-height:60.5vh;
        }

        .course-detail .right {
            float: right;
            width:28%;
        }

        .course-detail .left,
        .course-detail .right {
            background-color: #fff;
            box-shadow: 1px 1px 1px 1px #ccc;
            padding: 20px;
        }

        .course-detail .chapter-detail {
            margin-bottom: 10px;
        }
        .course-detail .chapter-detail .chapter-header {
            display: inline-block;
            width: 85%;
            padding-left: 30px;
            padding-bottom: 10px;
            padding-top: 10px;
            background: #F5F5F5;
            border-radius: 5px;
            box-sizing: border-box;
            cursor: pointer;
            position: relative;
        }

        .course-detail .chapter-detail .chapter-header .number-of-lessons{
            position: absolute;
            right: 15px;
            top: 15px;

        }
        .course-detail .chapter-detail .action-btn {
            display: inline-block;
            width: 90px;
            /*background: #ccc;*/
        }
        .course-detail .chapter-detail .action-btn button {
            border: none;
            background: #fff;
        }
        .course-detail .chapter-detail .action-btn button:hover {
            color: red;
        }

        .course-detail .chapter-detail .lesson-list {
            display: block;
        }

        .lesson-detail {
            display: inline-block;
            width: 100%;
        }
        .lesson-detail .lesson-header {
            border-bottom: 2px solid #ccc;
            padding: 10px;
            display: inline-block;
            width: 85%;
            padding-left: 35px;
            box-sizing: border-box;
        }
        .lesson-detail .lesson-body {
            display: none;
        }

        .lesson-detail .action-btn {
            display: inline-block;
            width: 10%;
        }



        ::selection{
            color: #fff;
            background: #6990F2;
        }
        .wrapper{
            width: 99%;
            background: #fff;
            border-radius: 5px;


        }



        .wrapper #insert-video,
        .wrapper #edit-video
        {
            box-shadow: 7px 7px 12px rgba(0,0,0,0.05);
            height: 197px;
            width: 100%;
            display: flex;
            cursor: pointer;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            border-radius: 5px;
            border: 2px dashed #6990F2;
            margin-bottom: 10px;
        }
        #insert-video :where(i, p),
        #edit-video :where(i, p){
            color: #6990F2;
        }
        #insert-video i,
        #edit-video i{
            font-size: 50px;
        }
        #insert-video p,
        #edit-video p{
            margin-top: 15px;
            font-size: 16px;
        }
        section .row{
            margin-bottom: 10px;
            background: #E9F0FF;
            list-style: none;
            padding: 15px 20px;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        section .row i{
            color: #6990F2;
            font-size: 30px;
        }
        section .details span{
            font-size: 14px;
        }
        .progress-area .row .content{
            width: 100%;
            margin-left: 15px;
        }
        .progress-area .details{
            display: flex;
            align-items: center;
            margin-bottom: 7px;
            justify-content: space-between;
        }
        .progress-area .content .progress-bar{
            height: 6px;
            width: 100%;
            margin-bottom: 4px;
            background: #fff;
            border-radius: 30px;
        }
        .content .progress-bar .progress{
            height: 100%;
            width: 0%;
            background: #6990F2;
            border-radius: inherit;
        }
        .uploaded-area{
            max-height: 232px;
            overflow-y: scroll;
        }
        .uploaded-area.onprogress{
            max-height: 150px;
        }
        .uploaded-area::-webkit-scrollbar{
            width: 0px;
        }
        .uploaded-area .row .content{
            display: flex;
            align-items: center;
        }
        .uploaded-area .row .details{
            display: flex;
            margin-left: 15px;
            flex-direction: column;
        }
        .uploaded-area .row .details .size{
            color: #404040;
            font-size: 11px;
        }
        .uploaded-area i.fa-check{
            font-size: 16px;
        }

        .modal-content .input-box,
        .course-info .info{
            margin-bottom: 15px;
            width: 100%;
            box-sizing: border-box;
        }
        .modal-content .input-box span.title,
        .course-info span.title,
        .wrapper span.title{
            display: block;
            /*border: 1px solid #000;*/
            font-weight: 500;
            margin-bottom: 5px;
        }

        .course-info .info {
            display: block;
            padding-top: 10px;
        }
        .modal-content .input-box input, .course-info .info{
            height: 45px;
            width: 97%;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
        }
        .modal-content  .input-box input:focus,
        .modal-content .input-box input:valid{
            border-color: #9b59b6;
        }



        h2.title{
            font-size: 25px;
            font-weight: 700;
            position: relative;
            /*margin: 0px;*/
            margin-bottom: 30px;
            margin-top: 0px;
            /*border: 1px solid #000;*/
        }

        .modal-header {
            padding: 0px;
        }
        h2.title::before{
            content: "";
            position: absolute;
            left: 0;
            bottom: 0;
            top: 40px;
            height: 2px;
            width: 100%;
            border-radius: 5px;
            background: linear-gradient(135deg, #71b7e6, #9b59b6);
        }

        .btn-action {
            margin-top: 30px;
            margin-bottom: 15px;
        }

        .insert-btn {
            margin-top: 10px;
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

        #insert-video-preview,
        #edit-video-preview {
            display: none;
            width: 100%;
            height: 185px;
            margin-bottom: 20px;
        }

        .wrapper-box {
            float: left;
            width: 49%;
            /*margin-right: 20px;*/
            box-sizing: border-box;
        }

        .wrapper-box:nth-of-type(2) {
            padding-left: 10px;
        }

        textarea {
            resize: vertical;
            width: 97%;
            max-height: 20em;
            min-height: 7em;
            outline: none;
            font-size: 16px;
            border-radius: 5px;
            padding-left: 15px;
            /*            padding-bottom: 15px;*/
            border: 1px solid #ccc;
            border-bottom-width: 2px;
            transition: all 0.3s ease;
            box-sizing: border-box;
        }
        .lesson-video {
            width: 100%;
            height: 100%;
        }

        .expand-btn-chapter,
        .expand-btn-lesson{
            border: none;
            background-color: #F5F5F5;
            font-size: 20px;
            display: inline-block;
            width: 20px;
            height: 100%;
        }

        .expand-btn-lesson {
            background-color: #fff;
        }



    </style>
    <body>
        <c:set var="course" value="${requestScope.course}" ></c:set>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1"></div>
            <div class="course-detail container col-lg-10" >
                <div class="left" >
                    <h2 class="title" >Nội dung khóa học</h2>
                    <button style="margin-top: 0px; margin-bottom: 20px;" class="insert-btn"  type="button" onclick="modal('insert-chapter-modal', 0, 'scale(1)');" >Thêm mới chương</button>
                <c:set var="index" value="0" ></c:set>
                <c:set var="x" value="0" ></c:set>
                    <div class="chapter-list" >
                    <c:forEach items="${requestScope.course.chapters}" var="chapter" >
                        <div id="chapter-${chapter.chapterId}" class="chapter-detail" >
                            <div class="chapter-header" >
                                <span class="expand-btn-chapter" type="button" onclick="showLesson('lesson-list', 'expand-btn-chapter', '${index}')" >+</span>
                                <span class="chapter-title" >${index + 1}: ${chapter.chapterTitle} </span>
                                <span class="number-of-lessons" >${chapter.lessons.size()} bài học</span>
                            </div>
                            <div class="action-btn">
                                <button onclick="commit('chapter', 'chapter/delete', '${chapter.chapterId}', 'Chương và các bài học liên quan sẽ bị xóa, bạn có muốn tiếp tục?')" >
                                    <i class="fa fa-trash" ></i>
                                </button>
                                <button onclick="editChapter('${chapter.chapterId}')"><i class="fa fa-pencil" ></i></button>
                                <button onclick="viewChapter('${chapter.chapterId}')"><i class="fa fa-eye" ></i></button>

                            </div>
                            <div class="lesson-list" >
                                <c:set var="y" value="0" ></c:set>
                                <c:forEach items="${chapter.lessons}" var="lesson" >
                                    <div id="lesson-${lesson.lessonId}" class="lesson-detail" >
                                        <div class="lesson-header" >
                                            <span><i class="fa fa-video"></i></span>
                                            <span class="chapter-title" >${index + 1}.${y+1}: ${lesson.lessonTitle} </span>
                                        </div>
                                        <div class="action-btn">
                                            <button  onclick="commit('lesson', 'lesson/delete', '${lesson.lessonId}', 'Bài học sẽ bị xóa, bạn có muốn tiếp tục?')" ><i class="fa fa-trash" ></i></button>
                                            <button onclick="editLesson('${lesson.lessonId}')"><i class="fa fa-pencil" ></i></button>
                                            <button onclick="viewLesson('${lesson.lessonId}')"><i class="fa fa-eye" ></i></button>
                                        </div>
                                        <!--                                <div class="lesson-body" >
                                                                            <video class="lesson-video" controls >
                                                                                <source src="${lesson.videoURL}" type="video/mp4" >
                                                                            </video>
                                                                        </div>-->
                                    </div>
                                    <c:set var="x" value="${x + 1}" ></c:set>
                                    <c:set var="y" value="${y + 1}" ></c:set>
                                </c:forEach>
                                <button class="insert-btn" type="button" onclick="insertLesson('${chapter.chapterId}');" >Thêm mới bài học</button>

                            </div>
                        </div>
                        <c:set var="index" value="${index + 1}" ></c:set>
                    </c:forEach>
                </div>

            </div>
            <div class="right">
                <h2 class="title" >Thông tin khóa học</h2>
                <img src="${course.avatar}" />
                <div class="course-info" >
                    <span class="title" >Tiêu đề</span>
                    <span class="info" >${course.courseTitle}</span>
                </div>
                <div class="course-info" >
                    <span class="title" >Chủ đề</span>
                    <span class="info" >${course.topic.topicName}</span>
                </div>
                <div class="course-info" >
                    <span class="title" >Giảng viên</span>
                    <span class="info" >${requestScope.teacher.name}</span>
                </div>
                <div class="course-info" >
                    <span class="title" >Trạng thái</span>
                    <c:if test="${course.status}" >
                        <span class="info" >Công khai</span>
                    </c:if>
                    <c:if test="${!course.status}" >
                        <span class="info" >Ẩn</span>
                    </c:if>

                </div>
            </div>
        </div>

        <div class="col-lg-1"></div>

        <form action="chapter/insert" method="POST" >
            <div class="modal" >
                <div id="insert-chapter-modal" >
                    <div class="modal-header" >
                        <h2 class="title" >Thêm mới chương</h2>
                    </div>
                    <div class="modal-content" >
                        <div class="input-box" >
                            <input name="id" type="hidden" value="${course.courseId}" />
                            <span class="title" >Tên chương</span> 
                            <input name="chapterTitle" type="text" value="" required placeholder="Nhập tên chương" />
                        </div>
                        <div  class="input-box">
                            <span class="title">Mô tả</span>
                            <textarea rows="4" name="description" placeholder="Mô tả"></textarea>
                        </div>
                    </div>
                    <div class="btn-action" >
                        <button type="submit" >Lưu</button>
                        <button type="button" onclick="modal('insert-chapter-modal', 0, 'scale(0)')" >Hủy</button>
                    </div>
                </div>
            </div>
        </form>
        <form action="lesson/insert" method="POST" enctype="multipart/form-data" >
            <div class="modal" >
                <div id="insert-lesson-modal" >
                    <div class="modal-header" >
                        <h2 class="title" >Thêm mới bài học</h2>
                    </div>
                    <div class="modal-content" >
                        <div class="wrapper-box"> 
                            <input name="id" type="hidden" value="${course.courseId}" />
                            <input type="hidden" name="chapterId" id="chapter-id" />
                            <div class="input-box" >
                                <span class="title" >Tên bài học</span> 
                                <input name="lessonTitle" type="text" value="" placeholder="Nhập tên bài học" required />
                            </div>
                            <div class="input-box" >
                                <span class="title" >Mô tả</span> 
                                <textarea rows="4" name="description" placeholder="Mô tả"></textarea>
                            </div>
                        </div>
                        <div class="wrapper-box" >
                            <div class="wrapper">
                                <span class="title" >Video bài giảng</span> 
                                <video id="insert-video-preview"  controls>
                                    Trình duyệt của bạn không hỗ trợ xem video.
                                </video>
                                <div id="insert-video" onclick="submitFile('file-input')" >
                                    <input onchange="previewVideo('insert-video', event);" id="file-input" type="file" accept=".mp4" name="video-input" hidden>
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Chọn video</p>
                                </div>
                                <section class="progress-area"></section>
                                <section class="uploaded-area"></section>
                            </div>
                        </div>
                        <div style="clear: both;" ></div>
                    </div>
                    <div class="btn-action">
                        <button type="submit" onclick="" >Lưu</button>
                        <button type="button" onclick="modal('insert-lesson-modal', 1, 'scale(0)')" >Hủy</button>
                    </div>
                </div>
            </div>
        </form>
        <div class="modal" >
            <form action="chapter/edit" method="POST" >
                <div id="edit-chapter-modal" >
                    <div class="modal-header" >
                        <h2 class="title">Chỉnh sửa chương</h2>
                    </div>
                    <div class="modal-content" >
                        <div class="input-box" >
                            <input name="id" type="hidden" value="${course.courseId}" />

                            <input class="edit-chapter" name="chapterId" type="hidden"/>
                            <span class="title" >Tên chương</span> 
                            <input class="edit-chapter" name="chapterTitle" type="text" placeholder="Nhập tên chương" required />
                        </div>
                        <div class="input-box">
                            <span>Mô tả</span> 
                            <textarea class="edit-chapter" rows="4" name="description" placeholder="Mô tả"></textarea>
                        </div>
                    </div>
                    <div class="btn-action" >
                        <button type="submit" >Lưu</button>
                        <button type="button" onclick="modal('edit-chapter-modal', 2, 'scale(0)')" >Hủy</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal" >
            <form action="lesson/edit" method="POST" enctype="multipart/form-data" >
                <div id="edit-lesson-modal" >
                    <div class="modal-header" >
                        <h2>Chỉnh sửa bài học</h2>
                    </div>
                    <div class="modal-content" >
                        <div class="wrapper-box">
                            <input name="id" type="hidden" value="${course.courseId}" />

                            <input class="edit-lesson" type="hidden" name="lessonId" />
                            <input class="edit-lesson" type="hidden" name="chapterId" />
                            <input class="edit-lesson" type="hidden" name="publicId" />
                            <input class="edit-lesson" type="hidden" name="videoURL" />
                            <div class="input-box">
                                <label class="title">Tên bài học</label> <br />
                                <input class="edit-lesson" name="lessonTitle" type="text" placeholder="Nhập tên bài học"  required />
                            </div>
                            <div class="input-box">
                                <label class="title">Mô tả</label> <br />
                                <textarea class="edit-lesson" rows="4" name="description" placeholder="Mô tả"></textarea>
                            </div>
                        </div>
                        <div class="wrapper-box" >
                            <div class="wrapper">
                                <span class="title" >Video bài giảng</span> 
                                <video id="edit-video-preview"  controls>
                                    Trình duyệt của bạn không hỗ trọ xem video.
                                </video>
                                <div id="edit-video" onclick="submitFile('file-edit')" >
                                    <input onchange="previewVideo('edit-video', event);" id="file-edit" type="file" accept=".mp4" name="video-input" hidden>
                                    <i class="fas fa-cloud-upload-alt"></i>
                                    <p>Chọn video</p>
                                </div>
                                <section class="progress-area"></section>
                                <section class="uploaded-area"></section>
                            </div>
                        </div>
                        <div style="clear: both;"></div>

                    </div>
                    <div class="btn-action" >
                        <button type="submit" >Lưu</button>
                        <button type="button" onclick="modal('edit-lesson-modal', 3, 'scale(0)')" >Hủy</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="modal" >
            <div id="view-chapter-modal" >
                <div class="modal-header" >
                    <h2 class="title">Xem thông tin chương</h2>
                </div>
                <div class="modal-content" >
                    <div class="input-box" >
                        <span class="title" >Tên chương</span> 
                        <span class="view-chapter"></span>
                    </div>
                    <div class="input-box">
                        <span>Mô tả</span> 
                        <p class="view-chapter"></p>
                    </div>
                </div>
                <div class="btn-action" >
                    <button style="width: 100%;" type="button" onclick="modal('view-chapter-modal', 4, 'scale(0)')" >Đóng</button>
                </div>
            </div>
        </div>
        <div class="modal" >
            <div id="view-lesson-modal" >
                <div class="modal-header" >
                    <h2 class="title" >Xem thông tin bài học</h2>
                </div>
                <div class="modal-content" >
                    <div class="wrapper-box">
                        <div class="input-box">
                            <span class="title">Tên bài học</span>
                            <span class="view-lesson" ></span>
                        </div>
                        <div class="input-box">
                            <span class="title">Mô tả</span> 
                            <p class="view-lesson"></p>
                        </div>
                    </div>
                    <div class="wrapper-box" >
                        <div class="wrapper">
                            <span class="title" >Video bài giảng</span> 
                            <video  style="width: 100%; height: 100%;"class="view-lesson"  controls>
                                Trình duyệt của bạn không hỗ trọ xem video.
                            </video>
                        </div>
                    </div>
                    <div style="clear: both;"></div>

                </div>
                <div class="btn-action" >
                    <button style="width: 100%;" type="button" onclick="modal('view-lesson-modal', 5, 'scale(0)')" >Dóng</button>
                </div>
            </div>
        </div>

        <form id="form-delete" method="POST" >
            <input id="course-id" name="courseId" type="hidden" value="${course.courseId}" />
            <input id="id-delete" type="hidden" name="id" />
        </form>

        <div class="modal" >
            <div id="commit-modal"></div>
        </div>
        <div   style="clear: both; margin-bottom: 20px;"></div>

        <div>
            <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>
        <div   style="height: 5px; margin-top: 20px;"></div>
    </body>



    <script>




        function previewVideo(id, event) {
            var wrap = document.getElementById(id);
            var childs = wrap.children;
            let file = event.target.files[0];
            let blobURL = URL.createObjectURL(file);
            var video = document.getElementById(id + "-preview");
            video.src = blobURL;
            video.style.display = "block";
            childs[2].innerHTML = "Chọn video khác";
        }
        function submitFile(id) {
            var fileInput = document.getElementById(id);
            fileInput.click();
        }

        function modal(id, position, transform) {
            var box = document.getElementById(id);
            var modal = document.getElementsByClassName('modal');
            modal[position].style.transform = transform;
            box.style.transform = transform;
        }


        function insertLesson(chapterId) {
            document.getElementById("chapter-id").value = chapterId;
            modal('insert-lesson-modal', 1, 'scale(1)');
        }

        function showLesson(chapterBodyClass, expandBtnClass, index) {
            var chapterBodies = document.getElementsByClassName(chapterBodyClass);
            var expandBtns = document.getElementsByClassName(expandBtnClass);
            var chapterBody = chapterBodies[index];
            var btn = expandBtns[index];
            if (btn.innerHTML === "+") {
                btn.innerHTML = "-";
            } else {
                btn.innerHTML = "+";
            }

            if (chapterBody.style.display === 'none') {
                chapterBody.style.display = 'block';
            } else {
                chapterBody.style.display = 'none';
            }

//            alert(chapterBody.style.display);

        }

        function commit(type, action, id, message) {
            modal('commit-modal', 6, 'scale(1)');
            var commitModal = document.getElementById('commit-modal');
            var modalBody = "";
//            modalBody += "<h2 class =\"title\" >Cảnh báo</h2>";
            modalBody += "<p>" + message + "</p>";
            modalBody += "<div class=\"btn-action\" >";
            modalBody += "<button type=\"button\" onclick=\"deleteRow('" + type + "','" + action + "','" + id + "')\" >Chấp nhận</button>";
            modalBody += "<button type=\"button\" onclick=\"modal('commit-modal', 6, 'scale(0)')\">Hủy</button>";
            modalBody += "</div>";
            commitModal.innerHTML = modalBody;
        }


        function deleteRow(type, action, id) {
            var list = document.getElementsByClassName(type + "-list")[0];
            var row = document.getElementById(type + "-" + id);
            

            var courseId = document.getElementById('course-id').value;

            var url = action + "?id=" + id + "&courseId=" + courseId;
            fetch(url).then(response => response.text())
                    .then(result => {
                        list.removeChild(row);
                        createNotify("success", "Thông báo", "Xóa thành công", true);
                        modal('commit-modal', 6, 'scale(0)');
                    });



        }

        function editChapter(chapterId) {
            var url = "chapter/edit?id=" + chapterId;
            var edits = document.getElementsByClassName('edit-chapter');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var data = result.split('|');
                edits[0].value = data[0];
                edits[1].value = data[1];
                edits[2].value = data[2];
            });
            modal('edit-chapter-modal', 2, 'scale(1)');
        }
        function viewChapter(chapterId) {
            var url = "chapter/view?id=" + chapterId;
            var edits = document.getElementsByClassName('view-chapter');
            fetch(url, {method: 'POST'}).then(function (response) {
                return response.text();
            }).then(function (result) {
                var data = result.split('|');
                edits[0].innerHTML = data[0];
                edits[1].innerHTML = data[1];
            });
            modal('view-chapter-modal', 4, 'scale(1)');
        }

        function viewLesson(lessonId) {
            var url = "lesson/view?id=" + lessonId;
            var edits = document.getElementsByClassName('view-lesson');
            fetch(url, {method: 'POST'}).then(function (response) {
                return response.text();
            }).then(function (result) {
                var data = result.split('|');
                edits[0].innerHTML = data[0];
                edits[1].innerHTML = data[1];
                edits[2].src = data[2];
            });
            modal('view-lesson-modal', 5, 'scale(1)');
        }
        function editLesson(lessonId) {
            var url = "lesson/edit?id=" + lessonId;
            var edits = document.getElementsByClassName('edit-lesson');
            fetch(url).then(function (response) {
                return response.text();
            }).then(function (result) {
                var data = result.split('|');
                edits[0].value = data[0];
                edits[1].value = data[1];
                edits[2].value = data[2];
                edits[3].value = data[3];
                edits[4].value = data[4];
//                edits[5].value = data[3];
                edits[6].value = data[5];
//                alert(data[5]);
            });
            modal('edit-lesson-modal', 3, 'scale(1)');
        }

    </script>
    <script src="../../../admin/js/tabler.min.js" defer></script>
    <script src="../../../admin/js/demo.min.js" defer></script>
</html>
