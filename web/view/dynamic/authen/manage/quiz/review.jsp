<%-- 
    Document   : header
    Created on : Jun 25, 2022, 11:35:50 AM
    Author     : ADMIN
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title></title>
        <!--<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">-->
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
        <!--<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>-->
        <!--<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>-->
        <!--<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>-->
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="../../../assets/css/data-table-js.js" ></script>
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">

        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../css/tabler.css" rel="stylesheet"/>
        <link href="../../../js/main.js" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>JSP Page</title>


    </head>
    <style>


        body {
            background-color: #F6F7FB;
            color:#2A2A2A;

        }

        .question-box {
            /*border: 1px solid #000;*/
            margin-bottom: 60px;
            padding: 30px;
            background-color: #fff;
            box-shadow: 2px 2px 2px 2px #ccc;
            border-radius: 10px;
        }

        .question-box .options {
            margin-top: 10px;

        }
        li {
            margin-left: none;
            list-style: none;
            padding: 20px;
            border: 2px solid #EDEFF4;
            border-radius: 10px;
            margin-top: 20px;
            /*border: 1px solid #000;*/
        }

        li:hover {
            border-color: blue;
        }
        ul {
            padding-left: 0px;
        }

        .option-input {
            width: 15px;
            height: 15px;

        }

        .question-header {
            position: relative;
        }

        .question-header .point {
            position: absolute;
            right: 0;
            display: inline-block;
            /*width: 50px;*/
            padding: 5px;
            border-radius: 3px;
            background-color: #E5E7E8;
            color: #000;
            font-weight: 600;
        }

        .btn-group button {
            padding: 10px 40px 10px 40px;
            margin-right: 30px;
            color: #fff;
            border-radius: 5px;
            border: none;
            font-weight: 600;
        }


        .btn-group button:nth-of-type(1) {
            background-color: #0056D2;
        }

        .btn-group button:nth-of-type(2) {
            background-color:  #EDEDED;
            color: #000;
        }



        button:hover {
            box-shadow: 2px 2px 2px blue;
        }
        .quiz-header-section {
            position: relative;

        }

        .quiz-header {
            margin-bottom: 40px;
        }
        .taken-date {
            position: absolute;
            right: 0;
            top: 0;
            display: inline-block;
        }
        .question-header {
            font-size: 17px;
        }

        .question-navigation {
            width: 300px;
            position: fixed;
            left: 30px;
            top: 130px;
        }

        .question-navigation-link {
            display: block;
            padding: 10px;
            width: 61%;
            color: #3CCFCF;
            text-decoration: none;
        }

        .question-navigation-link:hover {
            background-color: #ccc;
            text-decoration: none;

        }

        #question-list {
            position: relative;
            left: -500px;
            transition: 0.3s ease;
            margin-top: 10px;
        }
        #btn-show {
            padding: 10px 20px 10px 20px;
            border-color: blue;
            border-radius: 5px;
            font-weight: 600;
            color: #939BB4;
        }



        body {
            color: #2A2A2A;
        }
        .quiz-navbar {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 88;
            width: 100%;
            background-color: #fff;
        }


        .left .title {
            font-weight: 600;
            font-size: 20px;
            text-align: center;
        }



        #clockdiv{
            color: #000;
            display: inline-block;
            font-weight: 100;
            text-align: center;
            font-size: 30px;
        }

        #clockdiv > div{
            /*padding: 10px;*/
            /*border-radius: 3px;*/
            display: inline-block;
        }

        #clockdiv div > span{
            /*padding: 15px;*/
            /*border-radius: 3px;*/
            /*background: #00816A;*/
            display: inline-block;
        }

        .link-back button {
            padding: 10px 40px 10px 40px;

            border-radius: 5px;
            color: #fff;
            font-weight: 600;
            border: none;
            /*outline: none;*/
            background-color: rgb(0, 222, 0);
            /*border-color: blue;*/
        }

        .link-back button:hover {
            /*background-color: rgb(0, 255, 0);*/
            box-shadow: 2px 2px 2px blue;


        }

        .fa-arrow-left {
            margin-right: 10px;
        }

        .left  span {
            display: block;
            text-align: center;
        }



    </style>


    <body>
        <div>
            <div class="quiz-navbar">
                <header class="navbar navbar-expand-md navbar-light d-print-none " style="padding: 20px;">
                    <div class="container-xl">
                        <a class="link-back" href="http://localhost:8080/onlinelearn/authen/lesson/view?courseId=${quiz.course.courseId}">
                            <button><i class="fa fa-arrow-left"></i>Trở lại</button>
                        </a>
                     <div style="width: 200px;">
                         <span> Kết quả:</span>
                             <div  class="progress" style="height: 20px; display: inline-block;">
                                <div class="progress-bar" role="progressbar" style="width: 25%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100">25%</div>
                            </div>
                        </div>
                    </div>
                </header>
            </div>
        </div>

        <div class="col-lg-3"></div>

        <c:set var="quiz" value="${requestScope.quiz}" ></c:set>

            <input type="hidden" value="20" name="chapterId">
            <div class="container col-lg-6" style="padding: 0; margin-top: 120px;">
                <div class="quiz-header">
                    <h3 style="color: #646F90; font-size: 30px; margin-bottom: 10px;">${quiz.quizTitle}</h3>
                <div class="quiz-header-section">
                    <h3>Tổng điểm: ${quiz.totalPoint}</h3>
                </div>
            </div>
            <c:set var="index" value="1" ></c:set>
            <c:forEach var="question" items="${quiz.questions}">


                <c:set var="isDone" value="${false}"></c:set>                   
                <c:forEach var="quesDone" items="${requestScope.answered}">

                    <c:if test="${question.questionId == quesDone.question.questionId}">
                        <c:set var="isDone" value="${true}" />
                    </c:if>

                </c:forEach>


                <!--if user done this question-->
                <c:if test="${isDone == true}">

                    <div id="position-${index}" class="question-box">
                        <div class="question-header">
                            <span class="question-title"> <strong>${index}. </strong>${question.questionTitle}</span>



                            <span class="point" style="font-size: 15px;">
                                ${question.point} điểm
                            </span>



                        </div>
                        <div class="options">
                            <ul>
                                <c:forEach var="option" items="${question.options}">

                                    <li
                                        <c:if test="${option.isCorrect && option.ischoosen}">
                                            style="background-color: greenyellow"
                                        </c:if>
                                        <c:if test="${!option.isCorrect && option.ischoosen}">
                                            style="background-color: #ff3333"
                                        </c:if>    
                                        >

                                        <c:if test="${question.questionType.questionTypeName == 'Nhiều lựa chọn'}">
                                            <input id="option-${option.optionId}" class="option-input" type="checkbox" name="${question.questionId}" value="${option.optionId}" 
                                                   <c:if test="${option.ischoosen}">
                                                       checked="checked"
                                                   </c:if> />
                                        </c:if>

                                        <c:if test="${question.questionType.questionTypeName == 'Một lựa chọn'}" >
                                            <c:if test="${option.ischoosen}">
                                                <input id="option-${option.optionId}" class="option-input" type="radio" name="${question.questionId}" value="${option.optionId}" checked="checked">
                                            </c:if>

                                            <c:if test="${!option.ischoosen}">
                                                <input id="option-${option.optionId}" class="option-input" type="radio" name="${question.questionId}" value="${option.optionId}">
                                            </c:if>
                                        </c:if>
                                        <label>${option.optionDetail}</label>
                                    </li>
                                </c:forEach>


                            </ul>
                        </div>
                    </div>

                </c:if>



                <!--if user not done this question-->
                <c:if test="${isDone != true}">

                    <div id="position-${index}" class="question-box">
                        <div class="question-header">
                            <span class="question-title"> <strong>${index}. </strong>${question.questionTitle}</span>



                            <span class="point" style="font-size: 15px;">0/${question.point} điểm (Chưa làm)</span>


                        </div>
                        <div class="options">
                            <ul>
                                <c:forEach var="option" items="${question.options}">

                                    <li>
                                        <c:if test="${question.questionType.questionTypeName == 'Nhiều lựa chọn'}">

                                            <input id="option-${option.optionId}" class="option-input" type="checkbox" name="${question.questionId}" value="${option.optionId}" />

                                        </c:if>
                                        <c:if test="${question.questionType.questionTypeName == 'Một lựa chọn'}" >
                                            <input id="option-${option.optionId}" class="option-input" type="radio" name="${question.questionId}" value="${option.optionId}"
                                                   <c:forEach var="answer" items="${quesDone.userQuestionDetails}">
                                                       <c:if test="${answer.option.optionId == option.optionId}">
                                                           checked="checked"
                                                       </c:if>
                                                   </c:forEach>
                                                   />
                                        </c:if>
                                        <label>${option.optionDetail}</label>
                                    </li>
                                </c:forEach>


                            </ul>
                        </div>
                    </div>

                </c:if>


                <c:set var="index" value="${index + 1}" ></c:set>
            </c:forEach>




            <div class="btn-group">
                <a  href="http://localhost:8080/onlinelearn/authen/manage/quiz/handle?chapterId=${quiz.chapter.chapterId}&courseId=${quiz.course.courseId}&quizId=${quiz.quizId}"> 
                    <button type="button"> <i class="fas fa-save" style="margin-right: 10px; font-size: 15px;"></i>Làm lại
                    </button>
                </a>
                <a  href="http://localhost:8080/onlinelearn/authen/lesson/view?courseId=${quiz.course.courseId}"> 

                    <button type="button"><i class="fa fa-times-circle" style="margin-right: 10px;"></i>Thoát</button>
                </a>
            </div>
        </div>


        <div class="col-lg-3" style="margin-top: 50px; height: 1px;"></div>


        <div class="question-navigation">
            <button id="btn-show" onclick="showQuestionList()">Hiện danh sách câu hỏi</button>
            <div id="question-list">
                <c:set var="index" value="1" ></c:set>
                <c:forEach var="question" items="${quiz.questions}" >
                    <a href="#position-${index}" onclick="scrollToTop('position-' + '${index}', event);" class="question-navigation-link" >${index}</a>
                    <c:set var="index" value="${index + 1}" ></c:set>
                </c:forEach>

            </div>
        </div>

        <script>

            //            $(document).ready(function () {
            //                $(input[type = "radio"]).click(function () {
            //                    return false;
            //                });
            //            });

            function showQuestionList() {
                var questionList = document.getElementById('question-list');
                var btnShow = document.getElementById('btn-show');

                if (questionList.style.left === '0px') {
                    //                    questionList.style.display = 'block';
                    btnShow.innerHTML = "Hiện danh sách câu hỏi";
                    questionList.style.left = "-500px";
                } else {
                    //                    questionList.style.display = 'none';
                    questionList.style.left = "0px";
                    btnShow.innerHTML = "Ẩn danh sách câu hỏi";
                }
            }

            //
            //            function scrollToTop(index, event) {
            //                event.preventDefault();
            //                var element = document.getElementById(index);
            //                setTimeout(function () {
            //                    window.scrollTo(0, element.offsetTop + 15);
            //                }, 0);
            //
            //            }
            function scrollToTop(index, event) {

                event.preventDefault();
                var element = document.getElementById(index);
                //                alert(element.offsetTop - element.scrollTop + element.clientTop);
                window.scrollTo(0, element.offsetTop - element.scrollTop + element.clientTop - 10);
            }

            function setCheckOption(id) {
                var element = document.getElementById(id);
                if (element.checked) {
                    element.checked = "";
                } else {
                    element.checked = "checked";
                }
            }


        </script>
        <script src="../../../admin/js/tabler.min.js" defer=""></script>
        <script src="../../../js/main.js" defer=""></script>
        <script src="../../../admin/js/demo.min.js" defer=""></script>
        <!--<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>-->


</html>
