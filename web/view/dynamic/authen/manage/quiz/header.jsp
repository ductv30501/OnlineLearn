<%-- 
    Document   : header
    Created on : Jun 25, 2022, 11:35:50 AM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <style>


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
        }


        #start-modal {
            top: 50%;
            left: 10%;
            width: 60%;
            /*height: 25vh;*/
            position: absolute;
            padding: 15px 35px 15px 35px;
            background: #fff;
            transform: scale(0);
            transition-duration: 0.4s;
            z-index: 10;
            border-radius: 5px;
            box-shadow: 0px 0px 1px 1px #ccc;
        }




    </style>

    <body>
        <div class="quiz-navbar" >
            <header class="navbar navbar-expand-md navbar-light d-print-none " style="padding: 20px;"  >
                <div class="container-xl">
                    <a class="link-back"  href="http://localhost:8080/onlinelearn/authen/lesson/view?courseId=${requestScope.quiz.course.courseId}" >
                        <button  ><i class="fa fa-arrow-left"></i>Trở lại</button>
                    </a>
                    <div class="left">
                        <span class="title" >${requestScope.quiz.quizTitle}</span> 
                        <span>Thời gian: ${requestScope.quiz.durationTimeAsVN}</span>

                    </div >
                    <div class="right" >
                        <div id="clockdiv" style="width: 200px;">
                            <div>
                                <span class="hours"></span>
                            </div>
                            <div>
                                <span class="minutes"></span>
                            </div>
                            <div>
                                <span class="seconds"></span>
                            </div>
                        </div>
                    </div>

                </div>
            </header>
        </div>
        <input id="duration" type="hidden" value="${requestScope.quiz.duration}" />


    </body>
    <script>
        function getTimeRemaining(endtime) {
            const total = Date.parse(endtime) - Date.parse(new Date());
            const seconds = Math.floor((total / 1000) % 60);
            const minutes = Math.floor((total / 1000 / 60) % 60);
            const hours = Math.floor((total / (1000 * 60 * 60)) % 24);

            return {
                total,
                hours,
                minutes,
                seconds
            };
        }

        function initializeClock(id, endtime) {
            const clock = document.getElementById(id);
            const hoursSpan = clock.querySelector('.hours');
            const minutesSpan = clock.querySelector('.minutes');
            const secondsSpan = clock.querySelector('.seconds');

            function updateClock() {
                const t = getTimeRemaining(endtime);

                hoursSpan.innerHTML = ('0' + t.hours).slice(-2) + ' : ';
                minutesSpan.innerHTML = ('0' + t.minutes).slice(-2) + ' : ';
                secondsSpan.innerHTML = ('0' + t.seconds).slice(-2);

                if (t.total <= 0) {
                    clearInterval(timeinterval);
                    var quizForm = document.getElementById('quiz-form');
                    quizForm.submit();
                }


            }

            updateClock();
            const timeinterval = setInterval(updateClock, 1000);
        }



        window.onload = function () {
            var duration = document.getElementById('duration').value;
            const deadline = new Date(Date.parse(new Date()) + duration * 1000);
            initializeClock('clockdiv', deadline);
        }


    </script>
</html>
