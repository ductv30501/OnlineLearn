<%-- 
    Document   : show
    Created on : Jun 14, 2022, 12:55:38 PM
    Author     : ADMIN
--%>

<%@page import="model.Blog"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Blog | Nội dung</title>

        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <!--<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">--> 
        <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <!-- Libraries Stylesheet -->
        <link href="assets/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="../css/style.css" rel="stylesheet">

        <link href="../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link href="../assets/css/style.css" rel="stylesheet">

        <!--link to slick for slider-->
        <link rel="stylesheet" href="../assets/css/slider.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
        <!--link to font awesome cdn-->
        <%
            Blog b = (Blog) request.getAttribute("blog");
        %>
    </head>
    <body>
        
          <div>
            <c:if test="${sessionScope.user == null}" >
                <jsp:include page="../../../user/guest/header.jsp"></jsp:include>

            </c:if>
            <c:if test="${sessionScope.user != null}" >
                <c:if test="${sessionScope.user.group.name == 'Học viên'}" >
                    <jsp:include page="../../../user/learner/header.jsp"></jsp:include>
                </c:if>
                  

            </c:if>
        </div>

      

            <div class="container-fluid py-5">
                <div class="container py-5">
                    <div class="row">
                        <div class="col-lg-8">

                            <div class="mb-5">
                                <h6 class="text-primary mb-3"> Ngày đăng: 
                                <fmt:formatDate pattern="dd-MM-yyyy" value="${requestScope.blog.public_date}" />
                            </h6>
                            <h1 class="mb-5">${requestScope.blog.blog_title}</h1>
                            <c:if test="${requestScope.blog.avatar == null}">
                                <img class="img-fluid rounded w-100 mb-4" src="../assets/img/course-3.jpg">
                            </c:if>

                            <c:if test="${requestScope.blog.avatar !=null}">
                                <img class="img-fluid rounded w-100 mb-4" src="<%=b.getAvatar()%>"> 
                            </c:if>


                            <c:forEach var="block" items="${requestScope.blocks}">
                                <div>
                                    <c:if test="${block.heading != null}">
                                        <h4 class="mb-4">${block.heading}</h4>
                                    </c:if>

                                    <!--                                    <img class="img-fluid rounded w-50 float-left mr-4 mb-3" src="../assets/img/about.jpg" alt="Image">-->
                                    <c:if test="${block.content != null}">
                                        <p>${block.content}</p>
                                    </c:if>

                                    <!--                                    <p>Diam dolor est labore duo invidunt ipsum clita et, sed et lorem voluptua tempor invidunt at
                                                                            est sanctus sanctus. Clita dolores sit kasd diam takimata justo diam lorem sed. Magna amet
                                                                            sed rebum eos. Clita no magna no dolor erat diam tempor rebum consetetur, sanctus labore sed
                                                                            nonumy diam lorem amet eirmod. No at tempor sea diam kasd, takimata ea nonumy elitr
                                                                            sadipscing gubergren erat.</p>-->
                                </div>

                            </c:forEach>

                        </div>

                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">${requestScope.totalComment} bình luận</h3>

                            <c:forEach var="comment" items="${requestScope.comments}">
                                <div class="media mb-4">
                                    <c:if test="${comment.user.avatar == null}">
                                        <img src="../assets/img/team-1.jpg" alt="Image" class="img-fluid rounded-circle mr-3 mt-1" style="width: 45px;">
                                    </c:if>
                                    <c:if test="${comment.user.avatar != null}">
                                        <img src="${comment.user.avatar}" alt="Image" class="img-fluid rounded-circle mr-3 mt-1" style="width: 45px;">
                                    </c:if>
                                    <div class="media-body">
                                        <h5 style="font-weight: bold; color: #c69500;">${comment.user.name}</h5>
                                        <p>${comment.comment}</p>
                                        <!--<button class="btn btn-sm btn-secondary">Reply</button>-->
                                    </div>
                                </div>
                            </c:forEach>

                            <!--                            <div class="media mb-4">
                                                            <img src="img/user.jpg" alt="Image" class="img-fluid rounded-circle mr-3 mt-1" style="width: 45px;">
                                                            <div class="media-body">
                                                                <h6>John Doe <small><i>01 Jan 2045 at 12:00pm</i></small></h6>
                                                                <p>Diam amet duo labore stet elitr ea clita ipsum, tempor labore accusam ipsum et no at.
                                                                    Kasd diam tempor rebum magna dolores sed sed eirmod ipsum. Gubergren clita aliquyam
                                                                    consetetur sadipscing, at tempor amet ipsum diam tempor consetetur at sit.</p>
                                                                <button class="btn btn-sm btn-secondary">Reply</button>
                                                                <div class="media mt-4">
                                                                    <img src="img/user.jpg" alt="Image" class="img-fluid rounded-circle mr-3 mt-1" style="width: 45px;">
                                                                    <div class="media-body">
                                                                        <h6>John Doe <small><i>01 Jan 2045 at 12:00pm</i></small></h6>
                                                                        <p>Diam amet duo labore stet elitr ea clita ipsum, tempor labore accusam ipsum
                                                                            et no at. Kasd diam tempor rebum magna dolores sed sed eirmod ipsum.
                                                                            Gubergren clita aliquyam consetetur, at tempor amet ipsum diam tempor at
                                                                            sit.</p>
                                                                        <button class="btn btn-sm btn-secondary">Reply</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>-->
                        </div>

                        <div class="bg-secondary rounded p-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Leave a comment</h3>
                            <form action="content/insert" method="POST">
                                <div class="form-group">
                                    <label for="name">Tên đăng nhập *</label>
                                    <input name="username" type="text" class="form-control border-0" id="name">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email *</label>
                                    <input name="email" type="email" class="form-control border-0" id="email">
                                </div>

                                <div>                                    
                                    <input name="postid" type="hidden" value="${requestScope.blog.blog_id}" class="form-control border-0" id="email">
                                </div>

                                <div class="form-group">
                                    <label for="message">Message *</label>
                                    <textarea id="message" name="message" cols="30" rows="5" class="form-control border-0"></textarea>
                                </div>
                                <div class="form-group mb-0">
                                    <input type="submit" value="Leave Comment" class="btn btn-primary py-md-2 px-md-4 font-weight-semi-bold">
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-4 mt-5 mt-lg-0">

                        <div class="mb-5">
                            <h4>Tìm kiếm blog</h4>
                            <form action="">
                                <div class="input-group">
                                    <input type="text" class="form-control form-control-lg" placeholder="Keyword">
                                    <div class="input-group-append">
                                        <span class="input-group-text bg-transparent text-primary"><i class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Thể loại</h3>
                            <c:forEach var="cate" items="${requestScope.categories}">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex justify-content-between align-items-center px-0">
                                        <a href="" class="text-decoration-none h6 m-0">${cate.cate_title}</a>
                                        <span class="badge badge-primary badge-pill">${cate.totalPost}</span>
                                    </li>

                                </ul>
                            </c:forEach>

                        </div>

                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Đăng gần đây</h3>
                            <c:forEach var="re" items="${requestScope.recents}">
                                <a class="d-flex align-items-center text-decoration-none mb-3" href="content?pid=${re.blog_id}">
                                    <c:if test="${re.avatar == null}">
                                        <img src="../assets/img/team-1.jpg" alt="Image" class="img-fluid rounded-circle mr-3 mt-1" style="width: 45px;">
                                    </c:if>
                                    <c:if test="${re.avatar != null}">
                                        <img src="${re.avatar}" alt="Image" class="img-fluid rounded-circle mr-3 mt-1" style="width: 45px;">
                                    </c:if>
                                    <div class="pl-3">
                                        <h6 class="m-1">${re.blog_title}</h6>
                                        <small>
                                            <fmt:formatDate pattern="dd/MM/yyyy" value="${re.public_date}" />
                                        </small>
                                    </div>
                                </a>
                            </c:forEach>


                        </div>

                        <div class="mb-5">
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Tag</h3>
                            <div class="d-flex flex-wrap m-n1">
                                <c:forEach var="tag" items="${requestScope.tags}">
                                    <a href="" class="btn btn-outline-primary m-1">${tag.tag_title}</a>
                                </c:forEach>

                            </div>
                        </div>

                        <div class="d-flex flex-column text-center bg-dark rounded mb-5 py-5 px-4">
                            <img src="../assets/img/team-1.jpg" class="img-fluid rounded-circle mx-auto mb-3" style="width: 100px;">
                            <h3 class="text-primary mb-3">${requestScope.author.name}</h3>
                            <h3 class="text-uppercase mb-4" style="letter-spacing: 5px;">Tag Cloud</h3>
                            <p class="text-white m-0">${requestScope.author.description}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
 <div>
            <jsp:include page="../../../component/footer.jsp"></jsp:include>
        </div>

      
       

        <script src="https://code.jquery.com/jquery-3.4.1.min.js" type="text/javascript"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js" type="text/javascript"></script>
        <script src="../lib/easing/easing.min.js" type="text/javascript"></script>
        <script src="../lib/owlcarousel/owl.carousel.min.js" type="text/javascript"></script>

        <script src="../mail/jqBootstrapValidation.min.js" type="text/javascript"></script>
        <script src="../mail/contact.js" type="text/javascript"></script>

        <script src="../js/main.js" type="text/javascript"></script>

</html>
