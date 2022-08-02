<%-- 
    Document   : home
    Created on : May 20, 2022, 11:42:51 PM
    Author     : ADMIN
--%>

<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.Course"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Online-Learn</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">

        <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
        <!--link to font awesome cdn-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <!-- Template Javascript -->
        <script src="mail/contact.js"></script>

        <script src="js/main.js"></script>
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        
        
         <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-1.11.0.min.js"></script>
        <script type="text/javascript" src="https://code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
        <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
        <script type="text/javascript" src="assets/js/slider.js"></script>
        <!-- Contact Javascript File -->
    </head>
    <style>
        .pageheader{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }
    </style>
    <script>
        function submitform()
        {
            document.getElementById("submitBlog").submit();
        }
        function submit(pageIndex, cateId, tagId)
        {

            var tag = document.getElementById("tag");
            var page = document.getElementById("page");
            var cate = document.getElementById("cate");
            var search = document.getElementById("search");

            search.value = document.getElementById('search-input').value;
            tag.value = tagId;
            page.value = pageIndex;
            cate.value = cateId;

            //alert( "tag: " + tag.value + ", page: " + page.value + ", cate: " + cate.value +", search: " + search.value   );


            submitform();

        }

    </script>
    <body>
        <div>
            <c:if test="${sessionScope.user == null}">
                <jsp:include page="../user/guest/header.jsp"></jsp:include>
            </c:if>
            <c:if test="${sessionScope.user != null}">
                <jsp:include page="../user/learner/header.jsp"></jsp:include>
            </c:if>
        </div>
            <!-- Header Start -->
            <div class="container-fluid pageheader" style="margin-bottom: 90px;">
                <div class="container">
                    <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                        <h3 class="display-4 text-white text-uppercase">Danh Sách Blog</h3>
                        <div class="d-inline-flex text-white">
                            <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/ho">Trang Chủ</a></p>
                            <i class="fa fa-angle-double-right pt-1 px-3"></i>
                            <p class="m-0 text-uppercase">Danh Sách Blog</p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Header End -->

            <form action="blog" method="POST" id ="submitBlog">
                <input id ="page" type="hidden" value ="${page}" name="page" >
            <input id ="cate" type="hidden" value ="${cate}" name="cate" >
            <input id ="tag" type="hidden" value ="${tag}" name="tag" >
            <input id ="search" type="hidden" value ="${search}" name="search" >
        </form>
        <!-- Blog Start -->
        <div class="container-fluid py-5">
            <div class="container py-5">
                <div class="row">
                    <div class="col-lg-8">
                        <div class="row pb-3" style="justify-content: center; font-size: 18px;">
                            <div class="row pb-3" id = "result">
                                <c:if test="${requestScope.listBlog.size()==0}">
                                    <div style="justify-content: center;">Không có blog nào!</div>
                                </c:if>
                                <c:if test="${requestScope.listBlog.size()>0}">
                                    <c:forEach items="${requestScope.listBlog}" var = "b">
                                        <div class="col-lg-6 mb-4">
                                            <div class="blog-item position-relative overflow-hidden rounded mb-2">
                                                <img class="img-fluid" src="${b.avatar}" alt="">
                                                <a class="blog-overlay text-decoration-none" href="http://localhost:8080/onlinelearn/blog/content?pid=${b.blog_id}">
                                                    <h5 class="text-white mb-3">${b.blog_title}</h5>
                                                    <p><fmt:formatDate pattern = "dd,MM yyyy"  value = "${b.public_date}" /></p>
                                                </a>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>

                            <div class="col-12">
                                <nav aria-label="Page navigation">
                                    <ul class="pagination pagination-lg justify-content-center mb-0">

                                        <c:if test="${requestScope.listBlog.size()>0}">
                                            <c:if test="${totalPage>1}">
                                                <li class="page-item">
                                                    <a class="page-link" onclick="submit('page',${page==1?page:page-1});"  aria-label="Previous">
                                                        <span aria-hidden="true">&laquo;</span>
                                                        <span class="sr-only">Trước</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                            <c:if test="${totalPage>=3}">
                                                <li class="page-item active"><a class="page-link ${page==i?"active":""}"onclick="submit('page',${page+1});" >${page+1}</a></li>
                                                <li class="page-item"><a class="page-link ${page==i?"active":""}" onclick="submit('page',${page+2});">${page+2}</a></li>
                                                <li class="page-item"><a class="page-link ${page==i?"active":""}" onclick="submit('page',${page+3});">${page+3}</a></li>
                                                </c:if>

                                            <c:if test="${totalPage<3}">
                                                <c:forEach begin="1" end="${totalPage}" var="i">
                                                    <li onclick="submit(${i}, ${cate}, ${tag}, ${search});"  class="page-item ${page==i?"active":""}"><a class="page-link">${i}</a></li>
                                                    </c:forEach>
                                                </c:if>  
                                                <c:if test="${totalPage!=page}">
                                                <li class="page-item">
                                                    <a class="page-link" onclick="submit('page',${page+1>totalPage?totalPage:page+1});" aria-label="Next">
                                                        <span aria-hidden="true">&raquo;</span>
                                                        <span class="sr-only">Sau</span>
                                                    </a>
                                                </li>
                                            </c:if>

                                        </c:if>

                                    </ul>
                                </nav>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 mt-5 mt-lg-0">

                        <!-- Search Form -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Tìm Kiếm </h3>

                            <div class="input-group">
                                <input type="text" value ="${search}" id="search-input" class="form-control form-control-lg" placeholder="Tìm Kiếm">

                                <div class="input-group-append">
                                    <button type="text" onclick="submit(${page}, ${cate}, ${tag});"  class="input-group-text bg-transparent text-primary"><i class="fa fa-search" ></i></button>
                                </div>
                            </div>



                        </div>

                        <!-- Category List -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Các chủ đề</h3>
                            <ul class="list-group list-group-flush">

                                <c:forEach items="${listCategories}" var="c">
                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                        <a onclick="submit(${page}, ${c.cate_id}, ${tag});" class="text-cyan text-decoration-none h6 m-0">${c.cate_title}</a>
                                        <span class="text-uppercase badge badge-primary badge-pill">${c.totalPost}</span>
                                    </li>
                                </c:forEach> 
                            </ul>
                        </div>

                        <!-- Recent Post -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Bài đăng mới nhất</h3>
                            <c:forEach items="${requestScope.listLatestBlog}" var="lb">
                                <a class="d-flex align-items-center text-decoration-none mb-3" href="http://localhost:8080/onlinelearn/blog/content?pid=${lb.blog_id}">
                                    <img class="img-fluid rounded" src="${lb.avatar}" alt="" width="100px" height="100px">
                                    <div class="pl-3">
                                        <h6 class="m-1">${lb.blog_title}</h6>
                                        <p>Tháng <fmt:formatDate pattern = "MM,dd yyyy"  value = "${lb.public_date}" /></p>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>

                        <!-- Tag Cloud -->
                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Tag Cloud</h3>
                            <div class="d-flex flex-wrap m-n1">

                                <c:forEach items="${listCategories}" var="c">
                                    <a onclick="submit(${page}, ${cate}, ${c.tag.tag_id});" class="btn btn-outline-primary m-1">
                                        ${c.tag.tag_title}</a>
                                    </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Blog End -->
        <div>
            <jsp:include page="../component/footer.jsp"></jsp:include>
        </div>

       

    </body>
</html>
