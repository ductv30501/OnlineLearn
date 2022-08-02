<%-- 
    Document   : listuser
    Created on : May 31, 2022, 1:04:56 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
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
          
            position: fixed;
            left: 30px;
            top: 130px;
            
        }

        .question-navigation-link {
            display: block;
            padding: 10px;
            width: 100%;
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
            overflow: auto;
            max-height: 70vh;
        }
        #btn-show {
            padding: 10px 20px 10px 20px;
            border-color: blue;
            border-radius: 5px;
            font-weight: 600;
            color: #939BB4;
        }





    </style>
    <body id="body">

        <div>
            <jsp:include page="header.jsp" ></jsp:include>
            </div>
        <c:set var="quiz" value="${requestScope.quiz}" ></c:set>
            <div class="col-lg-3"></div>
            <form id="quiz-form" action="handle" method="POST"  >
                <input type="hidden" value="${chapterId}" name="chapterId" />
                <input type="hidden" value="${quiz.quizId}" name="quizId" />
            <div class="container col-lg-6" style="padding: 0; margin-top: 120px;" >
                <div class="quiz-header" >
                    <h3 style="color: #646F90; font-size: 30px; margin-bottom: 10px;" >${quiz.quizTitle}</h3>
                    <div class="quiz-header-section" >
                        <h3  >Tổng điểm: ${quiz.totalPoint}</h3>
                        <span class="taken-date" >Ngày làm: ${requestScope.takenDate}</span> 
                    </div>
                </div>
                <c:set var="index" value="1" ></c:set>
                <c:forEach var="question" items="${quiz.questions}" >
                    <div id="position-${index}" class="question-box" >
                        <div class="question-header" >


                            <span class="question-title" > <strong>${index}. </strong>${question.questionTitle}</span>
                            <c:if test="${question.questionType.questionTypeName == 'Nhiều lựa chọn'}" >
                                <span style="font-weight: 600; color: red;" >(Chọn tất cả đáp án đúng)</span>
                            </c:if>
                            <c:if test="${question.questionType.questionTypeName == 'Một lựa chọn'}" >
                                <span  style="font-weight: 600; color: red;">(Chọn 1 đáp án đúng)</span>
                            </c:if>
                            <span class="point" style="font-size: 15px;" >${question.point} điểm</span>


                        </div>
                        <div class="options" >
                            <ul>
                                <c:forEach var="option" items="${question.options}" >
                                    <li onclick="setCheckOption('option-' + '${option.optionId}')" >
                                        <c:if test="${question.questionType.questionTypeName == 'Nhiều lựa chọn'}" >
                                            <input id="option-${option.optionId}" class="option-input" type="checkbox" name="${question.questionId}" value="${option.optionId}" />
                                        </c:if>
                                        <c:if test="${question.questionType.questionTypeName == 'Một lựa chọn'}" >
                                            <input id="option-${option.optionId}" class="option-input" type="radio" name="${question.questionId}" value="${option.optionId}" />
                                        </c:if>
                                        <label>${option.optionDetail}</label>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                    </div>
                    <c:set var="index" value="${index + 1}" ></c:set>
                </c:forEach>
                <div class="btn-group" >
                    <button type="submit"> <i class="fas fa-save" style="margin-right: 10px; font-size: 15px;" ></i>Lưu</button>
                    <button onclick="window.location.href = 'http://localhost:8080/onlinelearn/authen/lesson/view?courseId=${requestScope.courseId}'" 
                            type="button" >
                        <i class="fa fa-times-circle" style="margin-right: 10px;" ></i>Hủy
                    </button>
                </div>
            </div>

        </form>

        <div class="col-lg-3" style="margin-top: 50px; height: 1px;"></div>


        <div class="question-navigation" >
            <button id="btn-show" onclick="showQuestionList()" >Hiện danh sách câu hỏi</button>
            <div id="question-list" >
                <c:set var="index" value="1" ></c:set>
                <c:forEach var="question" items="${quiz.questions}" >
                    <a href="#position-${index}" onclick="scrollToTop('position-' + '${index}', event);" class="question-navigation-link" >${index}</a>
                    <c:set var="index" value="${index + 1}" ></c:set>
                </c:forEach>
            </div>
        </div>
                
                <div>
                    
                </div>

        <script>

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
        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../js/main.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <!--<script src="https://code.jquery.com/jquery-3.5.1.js" ></script>-->
    </body>   
</html>
