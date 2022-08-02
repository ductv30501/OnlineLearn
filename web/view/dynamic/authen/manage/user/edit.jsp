<%-- 
    Document   : edituser
    Created on : May 31, 2022, 11:31:27 PM
    Author     : Admin
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">-->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <title>JSP Page</title>
        <style>


            .form-control:focus {
                box-shadow: none;
                border-color: #BA68C8
            }

            .profile-button {
                background: #0e4bf1;
                box-shadow: none;
                border: none
            }

            .profile-button:hover {
                background: #682773

            }

            .profile-button:focus {
                background: blue;
                box-shadow: none
            }

            .profile-button:active {
                background: blue;
                box-shadow: none
            }

            .back:hover {
                color: #682773;
                cursor: pointer
            }

            .labels {
                font-size: 11px
            }

            .add-experience:hover {
                background: #BA68C8;
                color: #fff;
                cursor: pointer;
                border: solid 1px #BA68C8
            }

            .user-profile {
                display: flex;
                /*margin: auto;*/
                width: 100%;
                margin-left: 300px;
                /*border: 1px solid #000;*/
                border-radius: 10px;
                /*box-shadow: 2px 2px 2px 2px solid #ccc;*/
                background-color: #fff;
            }
            .user-profile form {
                margin: auto;
                width: 100%;
                /*height: 500px;*/
            }
            textarea {
                max-height: 150px;
            }

        </style>
    </head>
    <body>    
        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div class="col-lg-1" > </div>
            <div style="background: #fff; margin-top: 20px; min-height: 80vh;" class="container col-lg-10" > 
                <form action="edit" method="POST">
                    <div class="row ">               
                        <div class="col-md-3 ">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5">                       
                                <img class="rounded-circle mt-5" id="avatar" width="150px" height="150px" src="${requestScope.user.avatar}" />
                            <span class="font-weight-bold" style="margin-top: 10px">${requestScope.user.name}</span>                             
                        </div>
                    </div>
                    <div class="col-md-9 ">
                        <div class="p-3 py-5">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h4 class="text-right">Thông tin người dùng</h4>
                            </div> 
                            <c:if test="${requestScope.tbao!=null}">${requestScope.tbao}</c:if>
                                <div class="row mt-3">
                                    <div class="col-md-4">
                                        <label class="labels">Tài khoản</label><br/>
                                    ${requestScope.user.username}
                                    <input name="img" type="hidden" value="${requestScope.user.avatar}" />
                                    <input name="username" type="hidden" value="${requestScope.user.username}">
                                </div>
                                <div class="col-md-4">
                                    <label class="labels">Email</label><br/>${requestScope.user.email}
                                    <input name="email" type="hidden" value="${requestScope.user.email}">

                                </div>
                                <div class="col-md-4"><label class="labels">Họ và tên</label><input name="name" type="text" class="form-control" placeholder="Họ và tên" value="${requestScope.user.name}" required></div>                           
                            </div>                          
                            <div class="row mt-2">                               
                                <div class="col-md-4"><label class="labels">Ngày sinh</label><input name="dob" type="date" class="form-control"  value="${requestScope.user.dob}"></div>
                                <div class="col-md-4"><label class="labels">Số điện thoại</label><input name="phone" pattern="[0-9]{10}" type="text" class="form-control" placeholder="Số điện thoại" value="${requestScope.user.phone}" required></div>                               
                                <div class="col-md-4"><label class="labels">Giới tính</label><br/>  
                                    <input ${requestScope.user.gender?"checked=\"checked\"":""}
                                        type="radio" value="male" name="gender"> Nam
                                    <input ${!requestScope.user.gender?"checked=\"checked\"":""} 
                                        type="radio" value="female" name="gender" style="margin-left: 10px"> Nữ
                                </div>
                            </div>                       
                            
                            <div class="row mt-2">
                                <div class="col-md-4"><label class="labels">Vai trò</label>
                                    <select name="group" class="form-select" aria-label="Default select example">
                                        <c:forEach items="${requestScope.groups}" var="g">
                                            <option  ${g.id==requestScope.user.group.id?"selected=\"selected\"":""} value="${g.id}">${g.name}</option>
                                        </c:forEach>
                                    </select>
                                </div> 
                                <div class="col-md-4"><label class="labels">Trạng thái</label>
                                    <select name="status" class="form-select" aria-label="Default select example">
                                        <option  ${"1"==requestScope.user.status?"selected=\"selected\"":""} value="1">Active</option>
                                        <option  ${"0"==requestScope.user.status?"selected=\"selected\"":""} value="0">Deactive</option>                               
                                    </select>
                                </div>
                                <div class="col-md-4"><label class="labels">Địa chỉ</label><br/><input name="address" type="text" class="form-control" placeholder="Địa chỉ" value="${requestScope.user.address}"></div>
                            </div>
                      
                            <div class="row mt-3">
                                <div class=""><label class="labels">Mô tả về bản thân</label><br/><textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="description"  value="${requestScope.user.description}">${requestScope.user.description}</textarea></div>
                            </div>
                            <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="submit" style="margin-right: 20px">Lưu thông tin</button>
                            </div>
                        </div>
                    </div>
                </div>  
            </form>
        </div>
        <div class="col-lg-1" > </div>


        <!--        <script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
                 thư viện ckeditor 4 
                <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
                <script src="//cdn.ckeditor.com/4.18.0/basic/ckeditor.js"></script>
                <script>
                    CKEDITOR.replace('exampleFormControlTextarea1');//name textarea
                </script>-->

        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
    </body>
</html>
