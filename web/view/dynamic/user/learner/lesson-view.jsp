<%-- 
    Document   : lesson-view
    Created on : Jun 8, 2022, 9:37:06 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>E-Course</title>

        <!-- Google Web Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 

        <!-- Libraries Stylesheet -->
        <link href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>

        <link href="../../css/style.css" rel="stylesheet">
        <link href="../../assets/css/style.css" rel="stylesheet">

        <link rel="stylesheet" href="../../assets/css/simple-notify.min.css" />
        <script src="../../assets/js/simple-notify.min.js"></script>
        <script src="../../js/main.js"></script>

    </head>
    <style>

        *{
            box-sizing: border-box;
        }
        .main .left-rail {
            width: 70%;
            float: left;
            padding: 10px;
            padding-left: 50px;
            /*border: 1px solid #000;*/
        }

        .main .right-rail {
            padding-right: 50px;
            width: 28%;
            float: right;
            /*border: 1px solid #000;*/
            cursor: pointer;
            color: #000;

        }

        @media screen and (max-width: 800px) {
            .main .left-rail {
                width: 100%;
                float: none;
                padding: 10px;
                padding-left: 50px;
                /*border: 1px solid #000;*/
            }

            .main .right-rail {
                padding-left: 50px;
                padding-top: 10px;
                width: 100%;
                padding-right: 10px;
                float: none;
                /*border: 1px solid #000;*/
                cursor: pointer;
                color: #000;

            }
        }
        .table-of-contents-list,
        .show-more-less-list {
            padding: 0px;
        }

        .table-of-contents-list {
            width: 100%;
            border: 1px solid #E8E8E8;
            border-radius: 10px;
            padding: 10xp;
            overflow: auto;
            max-height: 700px;
        }

        .chapter {
            margin-left: 0px;
        }

        .show-more-less-button {
            display: block;
            width: 100%;
            text-align: left;
            background-color: #fff;
            padding: 15px 10px;
            border-bottom: 1px solid #E8E8E8;
        }

        /*        .show-more-less:visited {
                    border:none;
                }*/

        .show-more-less-list {
            display: block;
        }

        .lesson-item {
            display: block;
            padding: 20px 25px;
            box-sizing: border-box;
        }

        .show-more-less {
            background-color: #fff;
        }

        .lesson-list:hover,
        .show-more-less:hover {
            background-color: #E1E9EE;
        }

        .bg-color-current {
            background-color: #ccc;
        }

        .lesson-list {
            background-color: #fff;
            border-bottom: 1px solid #E8E8E8;
        }

        .lesson-details {
            display: inline-block;
        }


        .video-style {
            width: 100%;
            height: 100%;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .topics-nav{
            padding: 10px;
            background-color: #E8E8E8;
            margin-bottom: 20px;
        }

        .topic-link {
            display: inline-block;
            float: right;
            width: 50%;
        }

        .topic-link span {
            display: inline-block;
            margin-right: 20px;
        }

        .table-of-contents-header {
            font-weight: 500;
            /*border: 1px solid #000;*/

            margin-bottom: 20px;
        }

        .top-card {
            border: 1px solid #E8E8E8;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;


        }

        .video-details {
            padding: 20px;
            padding-bottom: 15px;
        }

        /* Style the tab */
        .tab {
            overflow: hidden;
            border: 1px solid #ccc;
            background-color: #f1f1f1;
        }

        /* Style the buttons inside the tab */
        .tab button {
            background-color: inherit;
            float: left;
            border: none;
            outline: none;
            cursor: pointer;
            padding: 14px 16px;
            transition: 0.3s;
            font-size: 17px;
        }

        /* Change background color of buttons on hover */
        .tab button:hover {
            background-color: #ddd;
        }

        /* Create an active/current tablink class */
        .tab button.active {
            background-color: #ccc;
        }

        /* Style the tab content */
        .tabcontent {
            display: none;
            padding: 20px;
            border: 1px solid #ccc;
            border-top: none;
        }

        .teacher-avatar,
        .teacher-info,
        .course-avatar,
        .course-info{
            display: inline-flex;
        }

        .teacher-info {
            padding-top: 18px;
        }


        .course-avatar {
            position: relative;
            margin-right: 20px;
        }

        .course-avatar .duration {
            position: absolute;
            right: 0;
            bottom: 0;
            background-color: #33393E;
            border-radius: 2px;
            color: #fff;
            display: inline-block;
            padding: 3px;
            font-size: 10px;
            align-items: center;
        }

        #related-course {
            display: flex;
            flex-direction: column;
            /*display: flex;*/
        }
        .course-info {
            display: flex;
            flex-direction: column;
        }

        .course-box {
            display: flex;
            flex-direction: row;
            margin-bottom: 15px;
        }

        .course-avatar .avatar {
            /*vertical-align: top;*/
            width: 200px;
            height: 100px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }

        .teacher-avatar .avatar {
            vertical-align: middle;
            width: 60px;
            height: 60px;
            border-radius: 50%;
        }

        .course,
        .course-title{
            margin-bottom: 10px;
        }

        .course-title {
            font-weight: 600;
        }

        .play-pause-btn {
            border-radius: 100%;
            border: 1px solid #ccc;
            font-size: 20px;
            width: 27px;
            height: 27px;
            display: block;
            padding: 0px;
            padding-left: 3px;

        }

        .video-container {
            position: relative;

        }

        .pre-play,
        .next-video {
            width: 100%;
            height: 98%;
            position: absolute;
            text-align: center;
            top: 0;
            left: 0;
            padding-top: 20%;
            background-color: rgba(0, 0, 0, 0.7);
            border-radius: 10px;
        }

        .next-video {
            display: none;
        }

        video{
            width: 100%;
            height: 100%;
        }

        .vertical-bar {
            width: 10px;
            height: 100%;
            background-color: blue;
        }

        #related-activities .more-activity {
            display: block;
        }

        #related-activities .more-activity .title {
            display: inline-block;
            width: 100px;
            font-weight: 600;
        }

        #related-activities .more-activity button {
            background-color: #fff;
            font-weight: 600;
            border: none;
            color: #FF6600;
            outline: none;
        }
        #related-activities .more-activity button:hover {
            color: blue;

        }

        .discustion{
            display: none;
        }
        .chat-messages {
            display: flex;
            flex-direction: column;
            max-height: 1000px;
        }

        .chat-message-left,
        .chat-message-right {
            display: flex;
            flex-shrink: 0;
        }
        .write-comment{
            display: none;
            width: 100%;
        }

        .star-wrapper {

            position: absolute;
            direction: rtl;

        }
        .star-wrapper a {

            text-decoration: none;
            transition: all 0.5s;
            margin: 4px;
        }
        .star-wrapper a:hover {
            color: gold;
            transform: scale(1.3);
        }
        .s1:hover ~ a {
            color: gold;
        }
        .s2:hover ~ a {
            color: gold;
        }
        .s3:hover ~ a {
            color: gold;
        }
        .s4:hover ~ a {
            color: gold;
        }
        .s5:hover ~ a {
            color: gold;
        }
        .wraper {
            position: absolute;
            bottom: 30px;
            right: 50px;
        }
        .feedback{
            display: none;
        }
        .feedbackOfCourse{
            display: none;
        }

        /*-------------------------------------------MODAL CSS---------------------------------------------------*/
        .quiz-modal {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 4;
            display: none;
            align-items: center;
            justify-content: center;
        }

        .quiz-modal-close {
            display: flex;
            justify-content: flex-end;

        }

        .quiz-modal-container {
            width: 900px;
            height: 600px;
            background: #fff;
            border-radius: 4px;
        }

        .item-content {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: flex-start;
        }

        .close-btn {
            border: none;

        }

        .content-start {
            /*width: 946px;*/
            height: 274px;
            /*                border: 1px solid #3bdb63;*/
        }

        .quiz-title {
            margin-top: 20px;
            margin-bottom: 20px;
        }

        .content-layout {
            padding: 1% 8%;
        }

        .quiz-body {
            /*border: 1px solid #0077B5;*/
        }

        .onsubmit {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: space-between;
            border-bottom: 1px solid #CCC;

            padding: 20px;
        }

        .submit-title {
            display: inline-block;

        }

        .submit-title > p {
            font-weight: bold;
            font-size: 16px;
        }

        .due {
            display: inline-block;
        }

        .your-grade {

        }

        .grade-content {
            display: flex;
            flex-direction: row;
            flex-wrap: nowrap;
            justify-content: flex-end;
            align-items: center;
        }

        .grade-report {
            padding: 10px 24px;
        }

        .feedback-btn {
            border-radius: 4px;
            text-transform: none;
            text-align: center;
            max-width: 320px;
            min-width: unset;
            transition: none 0s ease 0s;
            color: rgb(255, 255, 255);
            background-color: rgb(0, 86, 210);
            border: none;
            font-size: 1rem;
            line-height: 1.5rem;
            font-family: "Source Sans Pro", Arial, sans-serif;
            font-weight: 700;
            letter-spacing: -0.1px;
            padding: 12px 32px;
            height: 48px;
        }

        .check-icon-span {
            margin: 0px 8px 0px 0px;
            /*                font-size: */
        }

        .check-icon {
            color: #1d7c50;
            width: 18px;
        }

        .retake-btn {
            width: 96px;
            height: 48px;
            border: none;
            background-color: #fff;
            font-weight: bold;
            font-size: 18px;
            color: #0056D2;

        }

        .retake-btn:hover {
            background-color: rgb(243, 248, 255);
            width: 96px;
            height: 48px;
            border-radius: 4px;
            color: #ff6600
        }

        .score {
            font-weight: bold;
            font-size: 24px;

        }


        .group-button {
            display: inline-block;
        }
        .input-group {
            width: 100%;
        }

        .input-group button {
            position: relative;
            right: 0px;
            margin-right: 2px;
        }
        .form-control {
            /*margin-right: 5px;*/
            display: block;
            width: 90%;
            height: calc(1.5em + 0.75rem + 2px);
            padding: 0.375rem 0.75rem;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: #495057;
            background-color: #fff;
            background-clip: padding-box;
            border: 1px solid #ced4da;
            border-radius: 8px;
            transition: border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
        }
        .content {
            height: calc(1.5em + 0.75rem + 2px);

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

    </style>
    <body dir="ltr">
        <jsp:include page="header.jsp" ></jsp:include>
            <div class="topics">
                <div class="topics-nav">

                    <div class="topic-link" >
                        <span> Chủ đề:</span>
                    <c:forEach var="topic" items="${requestScope.topics}" begin="0" end="3" >
                        <a style="margin-right: 10px;" href="http://localhost:8080/onlinelearn/course/bytopic?topicId=${topic.topicId}" >${topic.topicName}</a>
                    </c:forEach>
                </div>
                <div style="clear: both;" ></div>
            </div>
        </div>
        <div class="certificate-info" >
            <span style="display: none;" id="course-title" >${requestScope.course.courseTitle}</span>
            <span  style="display: none;" id="user-name" >${sessionScope.user.username}</span>
        </div>

        <main class="main" id="main-content" role="main">
            <section class="left-rail">
                <div id="video" >  
                    <input type="hidden" id="course-id" value="${requestScope.course.courseId}" />
                    <p class="pre-headline">
                        Từ khóa học: <a href="" > ${requestScope.course.courseTitle}</a>
                    </p>
                    <section class="top-card">
                        <section class="">
                            <div class="video-container">
                                <video onclick="pauseVideo()" class="video video-style" id="video-display" >

                                </video>
                                <div class="pre-play" onclick="playVideo()" id="pre-play" >
                                    <!--<button id="play">-->
                                    <img style="background-color: #fff; border-radius: 50%;" src="../../assets/img/play-button.png" width="100;" height="100" />
                                    <!--</button>-->
                                </div>
                                <div class="next-video" id="next-video" >
                                    <table>
                                        <tr>
                                            <td>
                                                <img style="background-color: #fff; border-radius: 50%;" src="../../assets/img/play-button.png" width="100;" height="100" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Tiếp theo</td>
                                            <td id="next-lesson-title" ></td>
                                            <td id="next-lesson-duration" ></td>
                                            <td id="start" >Bắt đầu</td>
                                        </tr>
                                    </table>
                                </div>

                            </div>
                            <div class="video-details" > 
                                <h2 id="lesson-title-display" ></h2>
                                <p class="pre-headline">
                                    Từ khóa học: <a href="" > ${requestScope.course.courseTitle}</a>
                                </p>
                            </div>

                        </section>
                    </section>
                    <div class="details">               
                        <div class="tab">
                            <button class="tablinks" onclick="openTab(event, 'teacher')">Giảng viên</button>
                            <button class="tablinks" onclick="openTab(event, 'description')">Mô tả</button>
                            <button class="tablinks active" onclick="openTab(event, 'related-course')">Khóa học liên quan</button>
                            <button class="tablinks" onclick="openTab(event, 'related-activities')">Các hoạt động khác</button>
                        </div>

                        <div id="teacher" class="tabcontent">

                            <div class="teacher-avatar" >
                                <img class="avatar" src="${requestScope.teacher.avatar}"></span>
                            </div>
                            <div class="teacher-info" >
                                <div class="teacher-name" >${requestScope.teacher.name}</div>
                                <div class="teacher-experience" ></div>
                                <div class="view-teacher-profile" >

                                </div>
                            </div>
                        </div>

                        <div id="description" class="tabcontent">

                        </div>
                        <div id="related-course" class="tabcontent">
                            <c:forEach var="relatedCourse" items="${requestScope.relatedCourses}" >
                                <div class="course-box" >
                                    <div class="course-avatar" >
                                        <img class="avatar" src="${relatedCourse.avatar}"></span>
                                        <span class="duration" >${relatedCourse.durationText}</span>
                                    </div>
                                    <div class="course-info" >
                                        <div class="course" >Khóa học</div>
                                        <div class="course-title" >
                                            <a href="http://localhost:8080/onlinelearn/course/detail?cid=${relatedCourse.courseId}" >${relatedCourse.courseTitle}</a>
                                        </div> 
                                        <div class="course-total-learner" >${relatedCourse.totalLearner} học viên</div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                        <div id="related-activities" class="tabcontent">
                            <div>
                                <div class="more-activity" >
                                    <div style="display: inline-block;" >
                                        <i class="bi bi-folder2-open"></i>            
                                        <span class="title" >Tài liệu</span>
                                    </div>
                                    <button>Tải về</button>
                                </div> 
                                <div class="more-activity" >
                                    <div style="display: inline-block;" > 
                                        <i class="bi bi-card-checklist"></i>
                                        <span class="title">Chứng chi</span>
                                    </div>
                                    <button onclick="downloadImage()">Tải về</button>
                                </div> 

                            </div>
                        </div>

                    </div>

                </div>
                <div id ="discussion">
                    <h4 id="dicussion-header" class="table-of-contents-header"> </h4>
                    <ul class="table-of-contents-list" >
                        <div class="flex-grow-0 py-3 px-4 border-top ">
                            <input type="hidden" id="chapter-id" name="chapterId" />
                            <div class="input-group" >
                                <input type="hidden" id="list-comment" />
                                <input id="outer-comment" type="text" class="form-control" placeholder="Viết Bình Luận">
                                <button onclick="insertComment()" class="btn btn-primary"><i class="fa fa-paper-plane"></i></button>
                            </div>
                        </div>

                    </ul>
                    <ul class="table-of-contents-list" >
                        <div class="position-relative" id="discussion-box" ></div>
                    </ul>

                </div>
                <div id ="feedback" class = "feedback">
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="text-center">
                                <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Phản Hồi</h5>
                                <h1>Phản Hồi Về Khóa Học</h1>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <div class="contact-form bg-secondary rounded p-5">
                                        <div id="success"></div>

                                        <div class="control-group">
                                            <div class = "row">
                                                <div class = "col-md-3">
                                                    <label style="color: black;">Đánh giá: </label>
                                                </div>
                                                <div class = "col-md-9">
                                                    <div class ="title-feedback">
                                                        <input type="hidden" id ="feedback-id" 
                                                               value="${requestScope.feedback != null ? requestScope.feedback.feedbackId : "" }"
                                                               />
                                                        <input type="hidden" id ="feedback-stars" 
                                                               value="${requestScope.feedback != null ? requestScope.feedback.stars : "1" }"
                                                               />

                                                        <input type="hidden" name = "fb" id = "fb" value = "1"/>
                                                        <div class="star-wrapper">
                                                            <a onclick ="setFB(1)" class="fas fa-star s1 st" ></a>
                                                            <a onclick ="setFB(2)" class="fas fa-star s2 st"></a>
                                                            <a onclick ="setFB(3)" class="fas fa-star s3 st"></a>
                                                            <a onclick ="setFB(4)" class="fas fa-star s4 st"></a>
                                                            <a onclick ="setFB(5)" class="fas fa-star s5 st" style="color: gold;"></a>
                                                        </div>
                                                        <script src="https://kit.fontawesome.com/5ea815c1d0.js"></script>

                                                    </div>
                                                </div>
                                            </div>


                                        </div>

                                        <div class="control-group">
                                            <label style="color: black;">Nội Dung Phản Hồi:  </label>
                                            <textarea  
                                                style="text-align: left;"
                                                class="form-control border-0 py-3 px-4" 
                                                rows="5" 
                                                id ="msg" 
                                                name="msg" 

                                                placeholder="Nội dung" 
                                                data-validation-required-message="Please enter your message"><c:if test="${requestScope.feedback != null}">${requestScope.feedback.feedbackContent} </c:if>
                                                </textarea>
                                                <p class="help-block text-danger"></p>
                                            </div>
                                            <div class="text-center">

                                                <button class="btn btn-primary py-3 px-5" onclick="${requestScope.feedback == null ? "submitFeedback()" : "updateFeedback()" }" type ="submit">${requestScope.feedback == null ? "Gửi" : "Chỉnh sửa"}</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id ="feedbackofsystem" class = "feedbackofsystem">
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <div class="text-center">
                                <h5 class="text-primary text-uppercase mb-3" style="letter-spacing: 5px;">Phản Hồi</h5>
                                <h1>Phản Hồi Của Hệ Thống</h1>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <div class="contact-form bg-secondary rounded p-5">
                                        <div id="success"></div>

                                        <div class="control-group" id = "nd">
                                            <label style="color: black;">Nội Dung Phản Hồi:  </label>
                                            <div id="content-fb"></div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </section>
            <section class="right-rail">
                <section class="table-of-contents">
                    <h4 class="table-of-contents-header">
                        Nội dung
                    </h4>
                    <ul class="table-of-contents-list">
                        <c:set var="chapterPosition" value="0"  ></c:set>
                        <c:set var="lessonPosition" value="0"  ></c:set>
                        <c:forEach var="chapter" items="${requestScope.course.chapters}" >
                            <li class="chapter" >
                                <div style="position: relative;" class="show-more-less">
                                    <span onclick="showMoreLess('show-more-less-list', 'show-more-less-icon',${chapterPosition})" class="show-more-less-button">
                                        ${chapter.chapterTitle}
                                        <i style="position: absolute; right: 10px;" class="bi bi-chevron-down show-more-less-icon"></i>
                                    </span>
                                </div>
                                <ul class="show-more-less-list">
                                    <c:forEach var="lesson" items="${chapter.lessons}" >
                                        <li onclick="showVideo('${lessonPosition}')"  class="lesson-list">
                                            <div class="vertical-bar" ></div>
                                            <div  class="lesson-item"  style="position: relative;" >
                                                <input type="hidden" value="${lesson.videoURL}" class="video-url" />
                                                <input type="hidden" class="lesson-description" value="${lesson.description}" />
                                                <input type="hidden" class="lesson-id" value="${lesson.lessonId}" />
                                                <input type="hidden" id="video-position" />
                                                <div class="lesson-details">
                                                    <div class="lesson-done-status" style="display: inline-block; position: absolute; top: 10px; left: 10px;  " >
                                                        <c:set var="checked" value="false" ></c:set>
                                                        <c:forEach var="lessonDone" items="${requestScope.lessonDone}"  >
                                                            <c:if test="${lesson.lessonId == lessonDone.lessonId}" >
                                                                <c:set var="checked" value="true" ></c:set>
                                                                    <img src="../../assets/img/checked.png" width="25;" height="25" style="margin-left: 5px;" />
                                                            </c:if>

                                                        </c:forEach>
                                                        <c:if test="${!checked}" >
                                                            <img src="../../assets/img/play.png" width="35;" height="35" />
                                                        </c:if>

                                                    </div>
                                                    <div style="display: inline-block; position: absolute; left: 55px; top: 10px;">
                                                        <div class="lesson-title">
                                                            ${lesson.lessonTitle}
                                                        </div>
                                                        <div class="lesson-duration">
                                                            ${lesson.durationTimeAsText}
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                        <c:set var="lessonPosition" value="${lessonPosition+1}"  ></c:set>
                                    </c:forEach>



                                    <!----------------------------------------------code lam-------------------------------------------------->    
                                    <%--<c:if test="${chapter.quiz != null}" >--%>
<!--                                        <li onclick="takeQuiz(${chapter.chapterId}, ${requestScope.course.courseId})" >
                                            <div class="vertical-bar" ></div>
                                            <div  class="lesson-item"  style="position: relative;" >
                                                <div class="lesson-details">
                                                    <div class="lesson-done-status" style="display: inline-block; position: absolute; top: 10px; left: 10px;  " >
                                    <c:set var="checked" value="false" ></c:set>
                                    <c:forEach var="quizDone" items="${requestScope.quizDone}"  >
                                        <c:if test="${chapter.quiz.quizId == quizDone.quizId}" >
                                            <c:set var="checked" value="true" ></c:set>
                                        </c:if>

                                    </c:forEach>
                                    <c:if test="${!checked}" >
                                        <img src="../../assets/img/play.png" width="35;" height="35" />
                                    </c:if>
                                    <c:if test="${!checked}" >
                                        <img src="../../assets/img/play.png" width="35;" height="35" />
                                    </c:if>

                                </div>
                                <div style="display: inline-block; position: absolute; left: 55px; top: 10px;">
                                    <div class="lesson-title">
                                    ${chapter.quiz.quizTitle}
                                </div>
                                <div class="lesson-duration">
                                    ${chapter.quiz.durationTimeAsText}
                                </div>
                            </div>
                        </div>
                    </div>
                </li>-->
                                    <%--</c:if>--%>
                                    <!----------------------------------------------code lam-------------------------------------------------->        


                                    <c:forEach var="quiz" items="${chapter.quizz}" >

                                        <c:set var="qId" value="${quiz.quizId}"></c:set>
                                        <c:set var="qTitle" value="${quiz.quizTitle}"></c:set>

                                        <c:set var="toPass" value="${quiz.toPass}"></c:set>
                                        <c:set var="mark" value="${quiz.mark}"></c:set>
                                        <c:set var="point" value="${quiz.totalPoint}"></c:set>

                                            <li onclick="openModal(${qId}, '${qTitle}', ${mark}, ${point}, ${toPass}, ${chapter.chapterId});" class="quiz-list">
                                            <!--<div class="vertical-bar" ></div>-->

                                            <div  class="lesson-item"  style="position: relative;" >                                                <input id="quiz-item-${quiz.quizId}" type="hidden" name="quizId${quiz.quizId}" value="${quiz.quizId}">
                                                <input id="quiz-item-${quiz.quizId}" type="hidden" name="quizId${quiz.quizId}" value="${quiz.quizId}">
                                                <div class="lesson-details">
                                                    <div class="lesson-done-status" style="display: inline-block; position: absolute; top: 10px; left: 10px;  " >
                                                        <%--<c:set var="checked" value="false" ></c:set>--%>
                                                        <c:choose>
                                                            <c:when test = "${mark == 0}">
                                                                <img src="../../assets/img/quiz.png" width="25;" height="25" style="margin-left: 5px;" />
                                                            </c:when>


                                                            <c:when test = "${mark/point < toPass}">

                                                                <i class="fas fa-exclamation-circle" style="color: #fc5b00; font-size: 26px; margin-left: 4px"></i>
                                                            </c:when>

                                                            <c:otherwise>
                                                                <img src="../../assets/img/checked.png" width="25;" height="25" style="margin-left: 5px;" />

                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div style="display: inline-block; position: absolute; left: 55px; top: 10px;">
                                                        <div class="lesson-title">
                                                            <p>${quiz.quizTitle}<p>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>  

                                    <li onclick="showDiscustion('${chapter.chapterId}', 'Thảo Luận ' + '${chapter.chapterTitle}')">
                                        <div class="vertical-bar" ></div>
                                        <div  class="lesson-item"  style="position: relative;" >

                                            <div class="lesson-details">
                                                <i class=" far fa-comments"></i>
                                                <div style="display: inline-block; position: absolute; left: 55px; top: 20px;">
                                                    <div class="lesson-title">
                                                        Thảo Luận 
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </li>
                            <c:set var="chapterPosition" value="${chapterPosition+1}"  ></c:set>
                        </c:forEach>
                        <li onclick="feedback()" >
                            <div style="position: relative;"  >
                                <span class="show-more-less-button">
                                    Phản Hồi
                                </span>
                            </div>
                        </li>
                        <li onclick="feedbackOfCourse()" >
                            <div style="position: relative;"  >
                                <span class="show-more-less-button">
                                    Phản Hồi Của Hệ Thống
                                </span>
                            </div>
                        </li>


                    </ul>
                </section>
            </section>
            <div style="clear: both;" ></div>


            <!----------------------------------------- modal block ---------------------------------------->
            <div class="quiz-modal" id="modal-display">
                <div class="quiz-modal-container">

                    <div class="quiz-modal-close" onclick="closeModal();">
                        <div class="close-btn">
                            <button class="close-btn"><i class="fas fa-times-circle" style="color: #ff3300"></i></button>
                        </div>
                    </div> 

                    <div class="content-layout">
                        <!--content start layout-->
                        <div class="content-start">
                            <div class="quiz-title">
                                <h1 class="text-center" id="quiz-title-id">Đây là bài quiz đầu tiên</h1>
                            </div>

                        </div>

                        <div class="quiz-body">
                            <div class="onsubmit-layout">

                                <div class="onsubmit">
                                    <div class="submit-quiz col-md-6">
                                        <div class="submit-title">
                                            <span class="check-icon-span" id="pass-icon-id">
                                                <i class="fas fa-check-circle check-icon fa-lg"></i>
                                            </span>
                                            <div class="submit-title">
                                                <h4 id="quiz-message">Bạn đã hoàn thành</h4>
                                            </div>

                                        </div>

                                        <div class="deadline-layout">

                                            <!--                                            <span class="deadline">Hạn nộp:</span>
                                                                                        <div class="due">
                                                                                            <p>22/6/2022</p>
                                                                                        </div>-->

                                        </div>
                                    </div>

                                    <div class="take-action col-md-2">
                                        <a id="retake" href="">
                                            <button class="retake-btn">Thử lại</button>
                                        </a>
                                    </div>
                                </div>

                                <div class="onsubmit">
                                    <div class="submit-quiz col-md-6">
                                        <div class="submit-title">
                                            <span class="check-icon-span" id="mark-icon-id">
                                                <i class="fas fa-check-circle check-icon fa-lg"></i>
                                            </span>
                                            <div class="submit-title">
                                                <h4>Điểm số:</h4>
                                            </div>

                                        </div>

                                        <div class="deadline-layout">

                                            <span class="deadline">Tối thiểu cần đạt:</span>
                                            <div class="due">
                                                <p id="due-result">80%</p>
                                            </div>

                                        </div>
                                    </div>

                                    <div class="your-grade col-md-6">
                                        <div class="grade-content">
                                            <div class="grade-report">
                                                <h6>Điểm của bạn</h6>
                                                <div class="result">
                                                    <div class="score">
                                                        <span id="yourScore" style="color: #1D7C50">100%</span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="grade-content">
                                                <a href="#" id="view-result-id" style="text-decoration: none">
                                                    <button class="feedback-btn" type="button" data-test="feedback-button">
                                                        <span class="cds-106 cds-button-label">Xem kết quả</span>
                                                    </button>
                                                </a>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!----------------------------------------- modal block ---------------------------------------->


        </main>
        <jsp:include page="../../component/footer.jsp" ></jsp:include>
        <img style="display: none;"  id="scream"  src="../../assets/img/certificate.png" alt="The Scream">
        <canvas style="display: none;" width="2000" height="2000" id="myCanvas" style="border:1px solid #d3d3d3;">

        </canvas>

    </body>
    <script>
        function takeQuiz(chapterId, courseId) {
            window.location.href = "http://localhost:8080/onlinelearn/authen/manage/quiz/handle?chapterId="
                    + chapterId + "&courseId=" + courseId;
        }

        function downloadImage() {
            var canvas = document.getElementById("myCanvas");
            image = canvas.toDataURL("image/png").replace("image/png", "image/octet-stream");
            var link = document.createElement('a');
            link.download = "certificate.png";
            link.href = image;
            link.click();
        }



        window.onload = function () {
            var courseTitle = document.getElementById('course-title').innerHTML;
            var username = document.getElementById('user-name').innerHTML;
            var c = document.getElementById("myCanvas");
            var ctx = c.getContext("2d");
            var img = document.getElementById("scream");
            ctx.drawImage(img, 10, 10);
            ctx.font = "100px";
            ctx.strokeText(username, 550, 790);
            ctx.strokeText(courseTitle, 550, 790);
        };
        const video = document.getElementById('video-display');
        const playButton = document.getElementById('play');
        const prePlay = document.getElementById('pre-play');
        var lessonTitles = document.getElementsByClassName('lesson-title');
        var lessonDescriptions = document.getElementsByClassName('lesson-description');
        var videoURLs = document.getElementsByClassName('video-url');
        var lessonList = document.getElementsByClassName('lesson-list');
        showVideo(0);
        video.addEventListener('ended', function () {
            // Step 1: Get current lesson position
            var currentPosition = parseInt(document.getElementById('video-position').value);
            // Step 2: Next lesson position
            var nextPosition = currentPosition + 1;
            // Step 3: Insert lesson done to database
            insertLessonDone(currentPosition);
            // Step 4: Get all video attributes needed
            var imgChecked = "<img src=\"../../assets/img/checked.png\"\n\
                              width=\"25;\" height=\"25\"\n\
                               style=\"margin-left: 5px;\" />"


            // Get lesson list at next position
            var lessonListAtPosition = lessonList[nextPosition];
            // Get parent of the lession list and display it
            var parentList = lessonListAtPosition.parentElement;
            parentList.style.display = "block";
            // Set checked icon of completed lesson
            var lessonDoneStatus = document.getElementsByClassName('lesson-done-status');
            lessonDoneStatus[currentPosition].innerHTML = imgChecked;
//            var nextLessontitle = document.getElementById('next-lesson-title');
//            var startNextLesson = document.getElementById('start');
//            var nextVideo = document.getElementById('next-video');

//            nextVideo.style.display = "block";
//            startNextLesson.setAttribute('onclick', );
//            nextLessontitle.innerHTML = title;
            showVideo(nextPosition);
        });
        function insertLessonDone(position) {
            var courseId = document.getElementById('course-id').value;
            var lessonIds = document.getElementsByClassName('lesson-id');
            var lessonDone = lessonIds[position].value;
            var url = "done/insert?lessonId=" + lessonDone;
            url += "&courseId=" + courseId;
            fetch(url, {method: "POST"});
        }

        function playVideo() {
            prePlay.style.display = "none";
            video.play();
            video.controls = true;
        }

        function pauseVideo() {

            prePlay.style.display = "block";
            video.pause();
            video.controls = false;
        }


        function openTab(evt, tabName) {
            var i, tabcontent, tablinks;
            tabcontent = document.getElementsByClassName("tabcontent");
            for (i = 0; i < tabcontent.length; i++) {
                tabcontent[i].style.display = "none";
            }
            tablinks = document.getElementsByClassName("tablinks");
            for (i = 0; i < tablinks.length; i++) {
                tablinks[i].className = tablinks[i].className.replace(" active", "");
            }
            document.getElementById(tabName).style.display = "flex";
            evt.currentTarget.className += " active";
        }




        function showMoreLess(listChapter, listIcon, position) {
            //            var lesson = document.getElementsByClassName('lesson-list');
            var button = document.getElementsByClassName('show-more-less');
            var chapter = document.getElementsByClassName(listChapter);
            var icon = document.getElementsByClassName(listIcon);
            var chapterAtPosition = chapter[position];
            var iconAtPosition = icon[position];
            var btnAtPosition = button[position];
            for (var i = 0, max = button.length; i < max; i++) {
                button[i].style.backgroundColor = "#fff";
            }



            btnAtPosition.style.backgroundColor = "#E8E8E8";
            if (chapterAtPosition.style.display === 'block') {
                chapterAtPosition.style.display = 'none';
            } else {
                chapterAtPosition.style.display = 'block'
            }

            if (iconAtPosition.className === 'bi bi-chevron-down show-more-less-icon') {
                iconAtPosition.className = 'bi bi-chevron-up show-more-less-icon';
            } else {
                iconAtPosition.className = 'bi bi-chevron-down show-more-less-icon'
            }

        }

        function hiddenElement(id) {
            var element = document.getElementById(id);
            element.style.display = "none";
        }

        function showVideo(position) {
            hiddenElement('discussion');
            hiddenElement('feedback');
            hiddenElement('feedbackofsystem');
            var video = document.getElementById('video');
            video.style.display = "block";
            pauseVideo();
            var lessonTit = document.getElementById('lesson-title-display');
            var lessonDes = document.getElementById('description');
            lessonTit.innerHTML = lessonTitles[position].innerHTML;
            lessonDes.innerHTML = lessonDescriptions[position].value;
            var lesson = document.getElementsByClassName('lesson-list');
            var lessonAtPosition = lesson[position];
            for (var j = 0, max = lesson.length; j < max; j++) {
                lesson[j].style.backgroundColor = "#fff";
            }
//            for (var j = 0, max = lesson.length; j < max; j++) {
//                lesson[j].className = lesson[j].className.replace(" bg-color-current", "");
//
//              
//            }

//            lessonAtPosition.style.backgroundColor = "#ccc";
//            lessonAtPosition.className = lessonAtPosition.className += " bg-color-current";
            lessonAtPosition.style.backgroundColor = "#ccc";
//            alert(lessonAtPosition.className);
            var videoPlay = document.getElementById('video-display');

            url = videoURLs[position].value;
            videoPlay.src = url;

            var currentPosition = document.getElementById('video-position');
            currentPosition.value = position;
        }


        let  nIntervId = setInterval(getNewComment, 1000);

        function getNewComment() {
            var discussion = document.getElementById('discussion');
            if (discussion.style.display === 'block') {
                var chapter = document.getElementById('chapter-id');
                var discussionBox = document.getElementById('discussion-box');
                var listCommentObject = document.getElementById('list-comment');
                var listCommentStr = listCommentObject.value;
                var url = "../comment/list?chapterId=" + chapter.value;
                fetch(url).then(response => response.json())
                        .then(result => {
                            var newComments = result.comments;
                            for (var i = 0; i < newComments.length; i++) {
                                var comment = newComments[i];
                                if (!listCommentStr.includes(comment.commentId)) {
                                    var box = createBox(comment);
                                    discussionBox.insertAdjacentHTML("afterbegin", box);
                                } else {

                                    var commentContent = document.getElementById('content-' + comment.commentId);
                                    if (!commentContent.innerHTML.includes("input")
                                            && commentContent.innerHTML !== comment.content) {
                                        commentContent.innerHTML = comment.content;
                                    }

                                    var replyBox = document.getElementById("reply-" + comment.commentId);
                                    var listReplyObject = document.getElementById('list-reply-' + comment.commentId);
                                    var listReplyStr = listReplyObject.value;
                                    var replies = comment.replies;
                                    for (var j = 0; j < replies.length; j++) {
                                        var reply = replies[j];
                                        var replyId = reply.commentId;
                                        if (!listReplyStr.includes(replyId)) {
                                            var box = createReply(reply, comment.commentId);
                                            replyBox.insertAdjacentHTML("afterbegin", box);
                                            updateReplyNumber(replyBox, comment.commentId);
                                        } else {
                                            var replyContent = document.getElementById('content-' + replyId);
                                            if (!replyContent.innerHTML.includes("input")
                                                    && replyContent.innerHTML !== reply.content) {
                                                replyContent.innerHTML = reply.content;
                                            }
                                        }
                                    }

                                    var newListReplyStr = comment.listReplyStr;
                                    listReplyObject.value = newListReplyStr;

                                    var oldListReply = listReplyStr.trim().split(" ");

                                    for (var m = 0; m < oldListReply.length; m++) {
                                        var rid = oldListReply[m];
                                        if (!newListReplyStr.includes(rid)) {
                                            var deletedReply = document.getElementById('comment-' + rid);
                                            replyBox.removeChild(deletedReply);
                                            updateReplyNumber(replyBox, comment.commentId);
                                        }
                                    }

                                    // set new list reply

                                }
                            }
                            // set new list comment
                            var newListCommentStr = result.listCommentStr;
                            listCommentObject.value = newListCommentStr;

                            var oldListComment = listCommentStr.trim().split(" ");
                            for (var k = 0; k < oldListComment.length; k++) {
                                var commentId = oldListComment[k];
                                if (!newListCommentStr.includes(commentId)) {
                                    var deletedComment = document.getElementById('comment-' + commentId);
                                    discussionBox.removeChild(deletedComment);
                                }
                            }

                        });
            }
//            clearInterval(nIntervId);
        }

        function updateReplyNumber(replyBox, commentId) {
            var numberOfReply = replyBox.children.length;
            var showReply = document.getElementById('number-of-reply-' + commentId);
            if (numberOfReply === 0) {
                showReply.innerHTML = " Trả Lời";
            } else {
                showReply.innerHTML = " Trả Lời (" + numberOfReply + ")";
            }
        }

        function deleteComment(commentListId, commentId, isReply) {
            var commentList = document.getElementById(commentListId);
            var comment = document.getElementById("comment-" + commentId);
            var url = "../comment/delete?commentId=" + commentId + "&isReply=" + isReply;
            fetch(url).then(response => response.text())
                    .then(result => {
                        createNotify("success", "Thông báo", "Xóa bình luận thành công", true);
//                        commentList.removeChild(comment);
                        if (commentListId.includes('reply-')) {
                            var replyBox = document.getElementById(commentListId);
                            var numberOfReply = replyBox.children.length;
                            var cmtId = commentListId.replace('reply-', '');
                            var showReply = document.getElementById('number-of-reply-' + cmtId);
                            if (numberOfReply === 0) {
                                showReply.innerHTML = " Trả Lời";
                            } else {
                                showReply.innerHTML = " Trả Lời (" + numberOfReply + ")";
                            }
                        }

                    });
        }

        function createEditBox(id, content) {
            var box = "";
            box += "<div style=\"width: 48vw;\  class=\"flex-grow-0 py-3 px-4 border-top\"";
            box += "<div class=\"input-group\">";
            box += "<input class=\"form-control\" id=\"edit-content-" + id + "\" value=\"" + content + "\"  type=\"text\"  placeholder=\"Viết Bình Luận\" \>";
            box += "<button onclick=\"saveEdit('" + id + "')\" title=\"Lưu\"  class=\"btn btn-primary\"><i class=\"fa fa-save\"></i></button>";
            box += "<button onclick=\"cancelEdit('" + id + "','" + content + "')\" title=\"Hủy\" class=\"btn btn-primary\"><i class=\"fa fa-close\"></i></button>";
            box += "</div>";
            box += " </div>";
            return box;
        }

        function editComment(id, content) {
            var contentBox = document.getElementById("content-" + id);
            var groupBtn = document.getElementById("group-button-" + id);
            groupBtn.style.display = "none";
//            contentBox.innerHTML = "";
            contentBox.innerHTML = createEditBox(id, content);
        }
        function cancelEdit(id, content) {
            var contentBox = document.getElementById("content-" + id);
            var groupBtn = document.getElementById("group-button-" + id);
            groupBtn.style.display = "inline-block";
            contentBox.innerHTML = content;
        }

        function saveEdit(id) {
            var contentBox = document.getElementById("content-" + id);
            var groupBtn = document.getElementById("group-button-" + id);
            var newContent = document.getElementById("edit-content-" + id);
            var btnEdit = document.getElementById("btn-edit-" + id);
            newContent.value = (newContent.value).replace("\\s+", " ").trim();
            if (newContent.value === "") {
                createNotify("warning", "Thông báo", "Bình luận không được để trống", true);
                return;
            }


            var url = "../comment/edit?commentId=" + id + "&content=" + newContent.value;
            fetch(url).then(response => response.text())
                    .then(result => {
                        createNotify("success", "Thông báo", "Chỉnh sửa bình luận thành công", true);
                        contentBox.innerHTML = newContent.value;
                        groupBtn.style.display = "inline-block";
                        var func = "editComment('" + id + "','" + newContent.value + "')";
                        btnEdit.setAttribute("onclick", func);
                    });
        }
        function saveLike(commentId) {
            var url = "../comment/like?commentId=" + commentId;
            fetch(url).then(response => response.json())
                    .then(result => {
                        var show = document.getElementById('number-like-' + commentId);
                        var number = result.like;
                        //  alert(number);
                        if (number === 0) {
                            show.innerHTML = "<i class=\"fas fa-thumbs-up\"></i> Like";
                        } else {
                            show.innerHTML = "<i class=\"fas fa-thumbs-up\"></i> Like (" + number + ")";
                        }
                    });
        }


        function createBox(cmt) {
            var username = document.getElementById('user-name').innerHTML;
            var box = " <div id=\"comment-" + cmt.commentId + "\" class=\"chat-messages p-4\">";
            box += " <div class=\"chat-message-left pb-4\">";
            box += "<div>";
            box += " <img src=\"" + cmt.user.avatar + "\" class=\"rounded-circle mr-1\" alt=\"" + cmt.user.name + "\" width=\"40\" height=\"40\">";
            box += " <div class=\"text-muted small text-nowrap mt-2\"> " + cmt.date + "</div>";
            box += "</div>";
            box += "<div class=\"flex-shrink-1 bg-light rounded py-2 px-3 ml-3\">";
            box += " <div class=\"font-weight-bold mb-1\">" + cmt.user.name;
            if (cmt.user.username === username) {
                box += "<div class=\"group-button\" id=\"group-button-" + cmt.commentId + "\" >";

                box += "</div>";
            }

            box += "</div>";
            box += "<div id=\"content-" + cmt.commentId + "\" >" + cmt.content + "</div>";
            var numberOfReplies = "";
            if (cmt.replies.length > 0) {
                numberOfReplies = "(" + cmt.replies.length + ")";
            }
            var numberLike = "";
            if (cmt.countComment > 0) {
                numberLike += "(" + cmt.countComment + ")";
            }

            box += " <div style=\"cursor: pointer;\" >";
            box += "";
            box += "<span onclick=\"saveLike('" + cmt.commentId + "')\"id=\"number-like-" + cmt.commentId + "\" > <i class=\"fas fa-thumbs-up\"></i> Like " + numberLike + "</span>";


            box += "<i class=\"fa fa-reply-all ml-2\"></i>";
            box += "<span onclick=\"showWriteComment('" + cmt.commentId + "')\" id=\"number-of-reply-" + cmt.commentId + "\" > Trả Lời " + numberOfReplies + "</span>";

            if (cmt.user.username === username) {
                box += "<button id=\"btn-edit-" + cmt.commentId + "\" class=\"btn btn\" onclick=\"editComment('" + cmt.commentId + "','" + cmt.content + "')\" ><i class=\"fa fa-pencil\"></i> Chỉnh Sửa</button>";
                box += "<button class=\"btn \" onclick=\"deleteComment('discussion-box','" + cmt.commentId + "', 'false')\" ><i class=\"fa fa-trash\"></i> Xóa</button>";
            }
            box += "</div>";
            var replies = cmt.replies;
//                alert(cmt.commentId);
            box += "<div id=\"input-box-" + cmt.commentId + "\" class=\"write-comment mt-1 mb-2\" >";
            box += "<div>";
            box += "<div style=\"width: 55vw;\ class=\"flex-grow-0 py-3 px-4 border-top\"";
            box += "<div class=\"input-group\" >";
            box += "<input class=\"form-control\" id=\"input-reply-" + cmt.commentId + "\" type=\"text\"  placeholder=\"Viết Bình Luận\" \>";
            box += "<button onclick=\"insertReply( " + cmt.commentId + " )\"  class=\"btn btn-primary\"><i class=\"fa fa-paper-plane\"></i></button>";
            box += "</div>";
            box += " </div>";
            box += "<input type=\"hidden\" id=\"list-reply-" + cmt.commentId + "\" value=\"" + cmt.listReplyStr + "\" />";
            box += "<div class=\"position-relative\" id=\"reply-" + cmt.commentId + "\" >";
            for (var i = 0; i < replies.length; i++) {
                var reply = replies[i];
                box += "  <div id=\"comment-" + reply.commentId + "\" class=\"chat-message-left pt-4\">";
                box += " <div>";
                box += "<img src=\"" + reply.user.avatar + "\" class=\"rounded-circle mr-1 mt-2\" alt=\"" + reply.user.name + "\" width=\"40\" height=\"40\">";
                box += " <div class=\"text-muted small text-nowrap mt-2\">" + cmt.date + "</div>";
                box += " </div>";
                box += "<div class=\"flex-shrink-1 bg-light rounded py-2 px-3 ml-3\">";
                box += "<div class=\"font-weight-bold mb-1\">" + reply.user.name;
                if (reply.user.username === username) {
                    box += "<div  class=\"group-button\" id=\"group-button-" + reply.commentId + "\" >";

                    box += "</div>";
                }
                box += "</div>";
                box += "<div id=\"content-" + reply.commentId + "\" >" + reply.content + "</div>";
                var numberLikeR = "";
                if (reply.countComment > 0) {
                    numberLikeR += "(" + reply.countComment + ")";
                }
                box += " <div style=\"cursor: pointer;\" >";
                box += "<span onclick=\"saveLike('" + reply.commentId + "')\"id=\"number-like-" + reply.commentId + "\" > <i class=\"fas fa-thumbs-up\"></i> Like " + numberLikeR + "</span>";

                if (reply.user.username === username) {
                    box += "<button id=\"btn-edit-" + reply.commentId + "\" class=\"btn \" onclick=\"editComment('" + reply.commentId + "','" + reply.content + "')\" ><i class=\"fa fa-pencil\"></i>Chỉnh Sửa</button>";
                    box += "<button class=\"btn \" onclick=\"deleteComment('reply-" + cmt.commentId + "','" + reply.commentId + "', 'true')\" ><i class=\"fa fa-trash\"></i> Xóa</button>";
                }
                box += "</div>";
                box += " </div>";
                box += " </div>";
            }
            box += " </div>";
            box += " </div>";
            box += " </div>";
            box += " </div>";
            box += " </div>";
            box += " </div>";
            return box;
        }
        function createReply(cmt, listReplyId) {
            var username = document.getElementById('user-name').innerHTML;
            var box = "<div id=\"comment-" + cmt.commentId + "\" class=\"chat-messages pt-4\">";
            box += "<div class=\"chat-message-left\">";
            box += "<div>";
            box += "<img src=\"" + cmt.user.avatar + "\" class=\"rounded-circle mr-1\" alt=\"" + cmt.user.name + "\" width=\"40\" height=\"40\">";
            box += "<div class=\"text-muted small text-nowrap mt-2\">" + cmt.date + "</div>";
            box += "</div>";
            box += "<div class=\"flex-shrink-1 bg-light rounded py-2 px-3 ml-3\">";
            box += " <div class=\"font-weight-bold mb-1\">" + cmt.user.name;
            if (cmt.user.username === username) {
                box += "<div  class=\"group-button\" id=\"group-button-" + cmt.commentId + "\" >";

                box += "</div>";
            }

            box += "</div>";
            box += "<div id=\"content-" + cmt.commentId + "\" >" + cmt.content + "</div>";

            if (cmt.user.username === username) {
                box += "<button id=\"btn-edit-" + cmt.commentId + "\" class=\"btn\" onclick=\"editComment('" + cmt.commentId + "','" + cmt.content + "')\" ><i class=\"fa fa-pencil\"></i>Chỉnh Sửa</button>";
                box += "<button class=\"btn \" onclick=\"deleteComment('reply-" + listReplyId + "','" + cmt.commentId + "', 'true')\" ><i class=\"fa fa-trash\"></i>Xóa</button>";
            }


            box += "</div>";
            box += "</div>";
            return box;
        }


        function insertReply(commentId) {
            var chapterId = document.getElementById('chapter-id').value;
            var content = document.getElementById("input-reply-" + commentId);
            var replyBox = document.getElementById("reply-" + commentId);
            content.value = (content.value).replace("\\s+", " ").trim();
            if (content.value === "") {
                createNotify("warning", "Thông báo", "Bình luận không được để trống", true);
                return;
            }

            var url = "../comment/insert?chapterId=" + chapterId
                    + "&content=" + content.value
                    + "&commentId=" + commentId
                    + "&isReply=true";
            fetch(url).then(response => response.json())
                    .then(result => {
//                        alert(replyBox.innerHTML);
//                        var box = createReply(result.comment, commentId);
//                        replyBox.insertAdjacentHTML("afterbegin", box);
                        var numberOfReply = replyBox.children.length;
                        var showReply = document.getElementById('number-of-reply-' + commentId);
                        if (numberOfReply === 0) {
                            showReply.innerHTML = " Trả lời";
                        } else {
                            showReply.innerHTML = " Trả lời (" + numberOfReply + ")";
                        }

                        createNotify("success", "Thông báo", "Phản hồi thành công", true);
                        content.value = "";
                    });
        }

        function insertComment() {
            var chapterId = document.getElementById('chapter-id').value;
            var content = document.getElementById('outer-comment');

            content.value = (content.value).replace("\\s+", " ").trim();
            if (content.value === "") {
                createNotify("warning", "Thông báo", "Bình luận không được để trống", true);
                return;
            }


            var discussionBox = document.getElementById('discussion-box');
            var url = "../comment/insert?chapterId=" + chapterId
                    + "&content=" + content.value
                    + "&isReply=false";
            fetch(url).then(response => response.json())
                    .then(result => {
//                        var comment = result.comment;
//                        var box = createBox(comment);
//                        discussionBox.insertAdjacentHTML("afterbegin", box);
                        createNotify("success", "Thông báo", "Thêm bình luận thành công", true);
                        content.value = "";
                    });
        }



        function showDiscustion(chapterId, chapterTitle) {
            pauseVideo();
            hiddenElement('feedback');
            hiddenElement('feedbackofsystem');
            var chapter = document.getElementById('chapter-id');
            var discussionHeader = document.getElementById('dicussion-header');
            var listCommentObject = document.getElementById('list-comment');
            chapter.value = chapterId;
//            discussionHeader.innerHTML = "";
            discussionHeader.innerHTML = chapterTitle;
            var discussionBox = document.getElementById('discussion-box');
            var discussion = document.getElementById('discussion');
            discussionBox.innerHTML = "";
            var url = "../comment/list?chapterId=" + chapterId;
            fetch(url).then(response => response.json())
                    .then(result => {
                        var comments = result.comments;
                        listCommentObject.value = result.listCommentStr;
//                        console.log(comments);
                        for (var i = 0; i < comments.length; i++) {
                            var box = createBox(comments[i]);
                            discussionBox.insertAdjacentHTML("afterbegin", box);
                        }
                    });
            var video = document.getElementById('video');
            video.style.display = "none";
            discussion.style.display = "block";
        }
        function showWriteComment(index) {
            var comment = document.getElementById('input-box-' + index);
            if (comment.style.display === 'none') {
                comment.style.display = "block";
            } else {
                comment.style.display = "none";
            }
        }
        function feedback() {
            var fb = document.getElementById("feedback");
            var video = document.getElementById('video');
            var comment = document.getElementById('discussion');
            var feedbackOfCourse = document.getElementById('feedbackofsystem');
            comment.style.display = "none";
            video.style.display = "none";
            feedbackOfCourse.style.display = "none";

            fb.style.display = "block";
        }

        window.onload = function () {
            var stars = document.getElementById('feedback-stars').value;
            setFB(6 - parseInt(stars));
        }

        function setFB(position) {
            var fb = document.getElementById("fb");
            fb.value = position;
            var stars = document.getElementsByClassName('st');
            for (var i = 5; i >= position; i--) {
                document.getElementsByClassName('s' + i)[0].style.color = "gold";
            }
            for (var i = 1; i < position; i++) {
                document.getElementsByClassName('s' + i)[0].style.color = "#FF6600";
            }
        }

        function updateFeedback() {

            var feedbackId = document.getElementById('feedback-id').value;
            var courseId = document.getElementById('course-id').value;
            var stars = 6 - document.getElementById('fb').value;
            var msg = document.getElementById('msg').value;
            //            alert(stars + msg + courseId);
            var url = "../feedback/edit?stars=" + stars
                    + "&message=" + msg
                    + "&courseId=" + courseId
                    + "&feedbackId=" + feedbackId;
            fetch(url).then(response => response.json())
                    .then(result => {
                        var notify = result.notification;
                        createNotify(notify.type, notify.title, notify.text, notify.autoClose);
                    });
        }
        function setfbSystem() {
            var fb = document.getElementById("feedback");
            var video = document.getElementById('video');
            var comment = document.getElementById('discussion');
            var feedbackOfCourse = document.getElementById('feedbackofsystem');
            comment.style.display = "none";
            video.style.display = "none";
            fb.style.display = "none";
            feedbackOfCourse.style.display = "block";
        }
        function  feedbackOfCourse() {

            var courseId = document.getElementById('course-id').value;
            var url = "../feedback/system?courseId=" + courseId;
            fetch(url).then(response => response.json())
                    .then(result => {

                        var feedbackofsystem = result.feedbackofsystem;
                        if (feedbackofsystem === "1") {
                            var nd = document.getElementById("nd");
                            var ndfb = "Bạn không có phản hồi nào từ hệ thống";
                            nd.innerHTML = ndfb;
                            setfbSystem();
                        } else {
                            var content = document.getElementById("content-fb");
                            content.innerHTML = feedbackofsystem;
                            setfbSystem();
                        }

                    });
        }

        function submitFeedback() {
            var feedbackId = document.getElementById('feedback-id');
            var courseId = document.getElementById('course-id').value;
            var stars = 6 - document.getElementById('fb').value;
            var msg = document.getElementById('msg').value;
            //            alert(stars + msg + courseId);
            var url = "../feedback/insert?stars=" + stars + "&message=" + msg + "&courseId=" + courseId;
            fetch(url).then(response => response.json())
                    .then(result => {
                        var notify = result.notification;
                        var feedback = result.feedback;
                        feedbackId.value = feedback.feedbackId;
                        createNotify(notify.type, notify.title, notify.text, notify.autoClose);
                    });
        }


        //-------------------------------MODAL scripts------------------------------------------

        function openModal(id, name, mark, point, toPass, chapterId) {
            var courseId = document.getElementById('course-id').value;
            var retake = document.getElementById('retake');
            retake.href = "../manage/quiz/handle?chapterId=" + chapterId + "&courseId=" + courseId + "&quizId=" + id;
            console.log(mark);
            var show = document.querySelectorAll('.quiz-list');
            //step 1: get quiz-modal element
            var modalContainer = document.querySelector('.quiz-modal');
            //Get quiz title
            var title = document.getElementById('quiz-title-id');
            title.innerHTML = name;
            modalContainer.style.display = 'flex';
            //get percent mark
            percentMark = (mark / point * 100).toFixed(1);
            var yourGrade = document.getElementById('yourScore');
            yourGrade.innerHTML = percentMark + '%';
            //get topass
            var due = document.getElementById('due-result');
            due.innerHTML = toPass + '%';
            //check user is pass or not
            var message = document.getElementById('quiz-message');
            var passIcon = document.getElementById('pass-icon-id');
            var feedbackBtn = document.querySelector('.feedback-btn');
            var retakeParagraph = document.querySelector('.retake-btn');
            var gradeIcon = document.getElementById('mark-icon-id');
            var reviewLink = document.getElementById('view-result-id');
            var url = 'http://localhost:8080/onlinelearn/authen/course/quiz/review?quizId=' + id;
            if (mark === 0) {
                message.innerHTML = 'Bạn chưa làm bài quiz này';
                yourGrade.style.color = '#E9CC0E';
                passIcon.innerHTML = '<i class="fas fa-question-circle fa-lg" ></i>';
                feedbackBtn.style.display = 'none';
                yourGrade.innerHTML = '--';
                retakeParagraph.innerHTML = 'Làm bài';
            } else if (percentMark < toPass) {
                yourGrade.style.color = 'red';
                message.innerHTML = 'Bạn chưa vượt qua bài quiz';
                passIcon.innerHTML = '<i class="fas fa-exclamation-circle fa-lg" style="color: #ff3300"></i>';
                feedbackBtn.style.display = 'block';
                retakeParagraph.innerHTML = 'Thử lại';
                gradeIcon.innerHTML = '<i class="fas fa-marker fa-lg"></i>'
            } else if (percentMark >= toPass) {
                yourGrade.style.color = 'green';
                message.innerHTML = 'Chúc mừng, bạn đã vượt qua bài quiz';
                feedbackBtn.style.display = 'block';
                retakeParagraph.innerHTML = 'Thử lại';
                gradeIcon.innerHTML = '<i class="fas fa-marker fa-lg" style="color: green"></i>'
            }
            reviewLink.href = url;
        }



        function closeModal() {
            var closeBtn = document.getElementsByClassName('.quiz-modal-close');
            var modalContainer = document.querySelector('.quiz-modal');
//            console.log(modalContainer);
            modalContainer.style.display = 'none';
        }
    </script>
    <script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
</html>