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
        <title>Bootstrap Datatable | Webdevtrick.com</title>

        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <!--<link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />-->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">-->
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" integrity="sha512-1ycn6IcaQQ40/MKBW2W4Rhis/DbILU74C1vSrLJxCq57o941Ym01SwNsOMqvEBFlcgUa6xLiPY/NS5R+E6ztJQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script>
            $(document).ready(function () {
                $("#keyword").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    $("#blogs tr").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
                    });
                });
            });
        </script>
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

    </style>
    <body>
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1">

            </div>

            <div style="background: #fff; padding:10px;margin-top: 20px; margin-bottom: 20px; border-radius: 5px;" class="container col-lg-10">
                <form method="GET" action="list" style="margin-bottom: 15px;">
                    <div class="row">
                        <div class="form-group col-md-3">
                            <input id="keyword" type="text"  class="form-control" placeholder="Nhập từ khóa" name="search" style="margin-top: 20px">
                        </div>
                        <div class="form-group col-md-3" style="position: relative;">
                            <input class="input-box button" type="submit" value="Tìm kiếm" style="height: 50%;width: 50%;margin-top:22px;border-radius: 5px;margin-right: 10px; float:left"/>
                            <i style="position: absolute; left: 20px; top: 27px; color: #fff;" class="bi bi-search fa-lg"></i>
                        </div>
                        <div class="form-group col-md-2" style="margin-top: 28px">
                            <a style="text-decoration: none;color: black" href="http://localhost:8080/onlinelearn/authen/marketing/post/insert" style="text-decoration: none"><i class="bi bi-plus-circle-fill"></i> Thêm Bài Post</a>
                        </div>
                    </div>
                </form>
                <div class="text-center">

                    <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                        <thead>
                            <tr>
                                <th>
                                    Post ID
                                </th>

                                <th  class="th-sm">Tiêu Đề

                                </th>
                                <th class="th-sm">Chủ Đề Blog

                                </th>
                                <th class="th-sm">Tác giả

                                </th>
                                <th class="th-sm">Ngày xuất bản

                                </th>
                                <th class="th-sm">Số người đọc

                                </th>
                                <th class="th-sm">Trạng Thái

                                </th>                   
                                <th class="th-sm" colspan="3">Hành động

                                </th>
                            </tr>
                        </thead>
                        <tbody id="blogs">
                        <c:forEach var="b" items="${requestScope.blogs}">
                            <tr>
                                <td>${b.blog_id}</td>
                                <td>${b.blog_title}</td>
                                <td>${b.category.cate_title}</td>
                                <td>${b.author}</td>
                                <td>${b.public_date}</td>
                                <td>${b.totalRead}</td>
                                <td>
                                    <c:if test="${b.is_public==true}"><p style="color: green">Công khai</p></c:if>
                                    <c:if test="${b.is_public==false}"><p style="color: red">Riêng tư</p></c:if>
                                </td>
                                <td>
                                    <a href="http://localhost:8080/onlinelearn/blog/content?pid=${b.blog_id}">
                                        <i class="fas fa-eye"></i> Xem
                                    </a>
                                    
                                </td>
                                <td>
                                    <a href="http://localhost:8080/onlinelearn/authen/marketing/post/insert/content?id=${b.blog_id}">
                                        <i class="fas fa-edit"></i> Sửa
                                    </a>
                                </td>
                                
                                <td>
                                    <a href="delete?pid=${b.blog_id}">
                                        <i class="fas fa-trash"></i> Xóa
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>         
                </table>
            </div>
            <div class="h-100 d-flex align-items-center justify-content-center">

            </div>
        </div>

        <div class="col-lg-1"></div>
        <div>
        <jsp:include page="../../../component/private-footer.jsp" ></jsp:include>
        </div>

        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
    </body>
</html>
