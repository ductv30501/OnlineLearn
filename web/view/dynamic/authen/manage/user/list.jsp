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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css" rel="stylesheet" />-->
        <!--<link href="https://cdn.datatables.net/1.12.0/css/dataTables.bootstrap4.min.css" rel="stylesheet" />-->
        <!--<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" rel="stylesheet">-->
        <!--<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.3/font/bootstrap-icons.css">-->
        <link href="../../../admin/css/demo.min.css" rel="stylesheet"/>
        <link href="../../../admin/css/tabler.min.css" rel="stylesheet"/>
        <link href="../../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="../../../assets/css/simple-notify.min.css" />
        <script src="../../../assets/js/simple-notify.min.js"></script>
        <script src="../../../js/main.js"></script>
        <title>JSP Page</title>
        <style>
            .message {
                text-align: right;
                color: red;
                font-size: 14px;
                margin: 2px 6px;

                animation-name: myAnimation;
                animation-duration: 10000ms;
                animation-fill-mode: forwards;
            }
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

            #insert-user-modal{

                margin: auto;
                width: 40%;

                padding: 15px 35px 15px 35px;
                background: #fff;
                transform: scale(0);
                transition-duration: 0.4s;
                z-index: 99;
                border-radius: 5px;
                box-shadow: 0px 0px 1px 1px #ccc;
            }

            #edit-user-modal{

                margin: auto;
                width: 60%;
                display: block;
                padding: 15px 35px 15px 35px;
                background: #fff;
                transform: scale(0);
                transition-duration: 0.4s;
                z-index: 99;
                border-radius: 5px;
                box-shadow: 0px 0px 1px 1px #ccc;
            }

            .active {
                z-index: 3;
            }
        </style>

    </head>
    <body>

        <div class="modal">
            <div  id="insert-user-modal">
                <form id="searchForm" action="insert" method="POST" >
                    <div class="col-md-6">
                        <h4 class="text-right">Th??m ng?????i d??ng m???i</h4>
                        <div id="notification"></div>
                    </div>
                    <div class="row mt-2">                      
                        <div class="col-md-6">
                            <label class="labels">T??n t??i kho???n</label>
                            <input name="username"  class="form-control input" type="text" placeholder="Nh???p t??n t??i kho???n" required>
                        </div>
                        <div class="col-md-6">
                            <label class="labels">Email</label>
                            <input name="email" class="form-control input" type="email" placeholder="Nh???p email" required>
                        </div>
                    </div>                       
                    <div class="row mt-2">
                        <div class="col-md-6">
                            <label class="labels">H??? v?? t??n</label>
                            <input name="name" type="text" class="form-control input" placeholder="Nh???p h??? v?? t??n" required>
                        </div>
                        <div class="col-md-6">
                            <label class="labels">Ng??y sinh</label>
                            <input name="dob" type="date" class="form-control input">
                        </div>
                    </div> 
                    <div class="row mt-2">                                                 
                        <div class="col-md-6"><label class="labels">S??? ??i???n tho???i</label>
                            <input name="phone" pattern="[0-9]{10}" type="text" class="form-control input" placeholder="Nh???p s??? ??i???n tho???i" required>
                        </div>
                        <div class="col-md-6"><label class="labels">Gi???i t??nh</label><br/>  
                            <input type="radio"  name="gender" class="mt-3 input"> Nam
                            <input type="radio"  name="gender" style="margin-left: 50px" class="mt-3 input"> N???
                        </div>
                    </div> 
                    <div class="row mt-2">
                        <div>
                            <label class="labels">?????a ch???</label>
                            <input name="address" type="text" class="form-control input" placeholder="Nh???p ?????a ch???">
                        </div>
                    </div>
                    <div class="row mt-2">                                                                                                   
                        <div class="col-md-6">
                            <label class="labels">Vai tr??</label>
                            <select name="role" class="form-select input" aria-label="Default select example">
                                <c:forEach items="${requestScope.groups}" var="g">
                                    <option value="${g.id}">${g.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="labels">Tr???ng th??i</label>
                            <select name="status" class="form-select input" aria-label="Default select example">
                                <option value="1">K??ch ho???t</option>
                                <option value="0">Kho??</option>                               
                            </select>
                        </div>
                    </div>                                   
                    <div class="text-center mt-5">
                        <!--                        <button class="input-box button" type="submit" style="padding: 5px;border-radius: 5px">Th??m ng?????i d??ng</button>-->
                        <button class="input-box button" type="button" style="padding: 5px;border-radius: 5px" onclick="insertUser()">Th??m ng?????i d??ng</button>
                        <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('insert-user-modal', 0, 'scale(0)')">????ng</button>
                    </div>
                </form>
            </div>
        </div> 

        <div class="modal"> 
            <div id="edit-user-modal">
                <form action="edit" method="POST">
                    <div class="row ">               
                        <div class="col-md-3 ">
                            <div class="d-flex flex-column align-items-center text-center p-3 py-5">                       
                                <img  class="rounded-circle mt-5 edit-user" id="avatar" width="150px" height="150px"/>
                                <span  class="font-weight-bold edit-user" style="margin-top: 10px"></span>                             
                            </div>
                        </div>
                        <div class="col-md-9 ">
                            <div class="p-3 py-5">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h3 class="text-right">Th??ng tin ng?????i d??ng</h3>
                                </div> 
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">T??i kho???n</label><br/>
                                        <span class="edit-user" ></span>
                                        <input class="edit-user"  type="hidden" name="username"/>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="labels">Email</label><br/>
                                        <span class="edit-user"></span>                                  
                                    </div>                                                             
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-6"><label class="labels">H??? v?? t??n</label><br/><span class="edit-user"></span></div>
                                    <div class="col-md-6"><label class="labels">Ng??y sinh</label><br/><span class="edit-user"></span></div>
                                </div>
                                <div class="row mt-3">                              
                                    <div class="col-md-6"><label class="labels ">S??? ??i???n tho???i</label><br/><span  class="edit-user"></span></div>    
                                    <div class="col-md-6"><label class="labels">Gi???i t??nh</label><br/>  
                                        <span  class="edit-user" ></span>
                                    </div>
                                </div>                                                     
                                <div class="row mt-3">                                   
                                    <div class=""><label class="labels">?????a ch???</label><br/><span  class="edit-user" ></span></div>
                                </div>
                                <div class="row mt-3">                                
                                    <div class=""><label class="labels">M?? t??? v??? b???n th??n</label><br/><span  class="edit-user"></span></div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-md-3"><label class="labels">Vai tr?? hi???n t???i</label>
                                        <h3 id="role" class="mt-1"></h3>
                                    </div>
                                    <div class="col-md-4"><label class="labels">Vai tr??</label>
                                        <select id="edit-role" name="group" class="form-select" aria-label="Default select example">

                                        </select>
                                    </div> 
                                    <div class="col-md-4"><label class="labels">Tr???ng th??i</label>
                                        <select  name="status" class="form-select" aria-label="Default select example">
                                            <option class="edit-user" value="1">K??ch ho???t</option>
                                            <option class="edit-user" value="0">Kho??</option>                               
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="text-center">
                            <button class="input-box button" type="submit" style="padding: 5px;border-radius: 5px" >L??u th??ng tin</button>
                            <button class="input-box button" style="margin-left: 10px;padding:5px;border-radius: 5px" class="btn btn-primary profile-button" type="button" onclick="modal('edit-user-modal', 1, 'scale(0)')">????ng</button>

                        </div>
                    </div>  
                </form>
            </div>
        </div>

        <jsp:include page="../../../component/header.jsp" ></jsp:include>
            <div style="background: #fff; padding:10px;margin-top: 20px; border-radius: 10px;" class="container col-lg-10">
                <form method="GET" action="list" style="margin-bottom: 20px; ">
                    <div class="row">
                        <div class="form-group col-md-1">
                            <label for="inputState" >Hi???n th???</label>
                            <select id="inputState" class="form-control" name="number" onchange="this.form.submit()">
                                <option ${"5"==requestScope.number?"selected=\"selected\"":""} value="5">5 h??ng</option>
                            <option ${"10"==requestScope.number?"selected=\"selected\"":""} value="10">10 h??ng</option>
                            <option ${"15"==requestScope.number?"selected=\"selected\"":""} value="15">15 h??ng</option>
                            <option ${"20"==requestScope.number?"selected=\"selected\"":""} value="20">20 h??ng</option>
                        </select>                       
                    </div>
                    <div class="form-group col-md-2">
                        <label for="inputState">Vai tr??</label>
                        <select id="inputState" name="group" class="form-control" onchange="this.form.submit()">
                            <option value="-1">T???t c???</option>
                            <c:forEach items="${requestScope.groups}" var="g">
                                <option ${g.id==requestScope.group?"selected=\"selected\"":""} value="${g.id}">${g.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="inputState" >Tr???ng th??i</label>
                        <select id="inputState" class="form-control" name="status" onchange="this.form.submit()">
                            <option value="-1">T???t c???</option>
                            <option ${"1"==requestScope.status?"selected=\"selected\"":""} value="1">K??ch ho???t</option>
                            <option ${"0"==requestScope.status?"selected=\"selected\"":""} value="0">Kho??</option>
                        </select>
                    </div>
                    <div class="form-group col-md-3">
                        <input type="text"  class="form-control" placeholder="Nh???p t??n, email, s??? ??i???n tho???i"  name="search" style="margin-top: 20px">
                    </div>
                    <div class="form-group col-md-2" style="">
                        <label for="inputState" ></label><br/>
                        <button class="input-box button" type="submit" style="border-radius: 5px;padding: 5px 15px 5px 15px;">
                            <i  style="" class="bi bi-search fa-lg"></i> T??m ki???m
                        </button>
                    </div>
                    <div class="form-group col-md-2">
                        <label for="inputState" ></label><br/>
                        <button style="padding: 5px 15px 5px 15px;border-radius: 5px;text-align: center" class="input-box button" type="button" onclick="modal('insert-user-modal', 0, 'scale(1)');" >
                            <i class="bi bi-person-plus-fill"></i> Th??m
                        </button>
                    </div>                  
                </div>
            </form>

            <div class="text-center">
                <c:if test="${requestScope.users.size()>0}">
                    <table id="dtBasicExample" class="table table-striped table-bordered table-sm">
                        <thead>
                            <tr>
                                <th>
                                    ???nh                       
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='username'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc username&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">T??n t??i kho???n (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='username'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc username&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">T??n t??i kho???n (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='username'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc username&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">T??n t??i kho???n</a>
                                    </c:if>                                
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc name&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">H??? v?? t??n (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc name&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">H??? v?? t??n (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc name&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">H??? v?? t??n</a>
                                    </c:if>
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='email'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc email&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Email (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='email'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc email&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Email (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='email'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc email&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Email</a>
                                    </c:if>
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='phone'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc phone&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">S??? ??i???n tho???i (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='phone'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc phone&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">S??? ??i???n tho???i (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='phone'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc phone&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">S??? ??i???n tho???i</a>
                                    </c:if>
                                </th>
                                <th>
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='group_name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc group_name&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Vai tr?? (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='group_name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc group_name&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Vai tr?? (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='group_name'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc group_name&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Vai tr??</a>
                                    </c:if>
                                </th>
                                <th> 
                                    <c:if test="${requestScope.sort=='desc' && requestScope.obj=='status'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc status&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Tr???ng th??i (gi???m d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.sort=='asc' && requestScope.obj=='status'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=desc status&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Tr???ng th??i (t??ng d???n)</a>
                                    </c:if>
                                    <c:if test="${requestScope.obj!='status'}">
                                        <a style="text-decoration: none;color: black" href="list?sortTitle=asc status&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Tr???ng th??i</a>
                                    </c:if>
                                </th>
                                <th>H??nh ?????ng</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${requestScope.users}" var="u">
                                <tr>
                                    <td ><img style="height: 50px;" class="rounded-circle" src="${u.avatar}" /> </td>
                                    <td>${u.username}</td>
                                    <td>${u.name}</td>
                                    <td>${u.email}</td>
                                    <td>${u.phone}</td>
                                    <td>${u.group.name}</td>
                                    <td><c:if test="${u.status==true}"><p style="color: green">K??ch ho???t</p></c:if>
                                        <c:if test="${u.status==false}"><p style="color: red">Kho??</p></c:if>
                                        </td>
                                        <td>
                                            <a style="text-decoration: none" href="#" onclick="getUserDetail('${u.username}')">Chi ti???t</a>
                                        <c:if test="${u.status==true}">
                                            <a style="text-decoration: none;color: red" href="status/change?stt=${false}&sortTitle=${requestScope.sortTitle}&username=${u.username}&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">Kho??</a>
                                        </c:if>
                                        <c:if test="${u.status==false}">
                                            <a style="text-decoration: none;color: green" href="status/change?stt=${true}&sortTitle=${requestScope.sortTitle}&username=${u.username}&index=${requestScope.index}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">K??ch ho???t</a>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                <div class="h-100  d-flex align-items-center justify-content-center">
                    <nav aria-label="...">
                        <ul class="pagination">
                            <c:if test="${requestScope.index>3}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=1&group=${requestScope.group}&sortTitle=${requestScope.sortTitle}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang ?????u<span class="sr-only"></span></span></a>
                                </li>
                            </c:if>
                            <c:if test="${requestScope.index>2}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-2}&sortTitle=${requestScope.sortTitle}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-2}</a></li>
                                </c:if> 
                                <c:if test="${requestScope.index>1}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index-1}&sortTitle=${requestScope.sortTitle}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index-1}</a></li>
                                </c:if>                                              
                            <li class="page-item " style="background: #FF6600;border-radius:5px">
                                <span class="page-link" >${requestScope.index}
                                </span>
                            </li>
                            <c:if test="${requestScope.index<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+1}&sortTitle=${requestScope.sortTitle}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+1}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+1<requestScope.totalPage}">
                                <li class="page-item"><a class="page-link" href="list?index=${requestScope.index+2}&sortTitle=${requestScope.sortTitle}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}">${requestScope.index+2}</a></li>
                                </c:if>
                                <c:if test="${requestScope.index+2<requestScope.totalPage}">
                                <li class="page-item">
                                    <a style="text-decoration: none" href="list?index=${requestScope.totalPage}&sortTitle=${requestScope.sortTitle}&group=${requestScope.group}&status=${requestScope.status}&search=${requestScope.search}&number=${requestScope.number}"><span class="page-link">Trang cu???i<span class="sr-only"></span></span></a>
                                </li>                        
                            </c:if>
                        </ul>
                    </nav>
                </div>
            </div>
        </c:if>
        <c:if test="${requestScope.users.size()==0}">
            <div class="alert alert-info">
                <strong>Kh??ng t??m th???y ng?????i d??ng n??o</strong>
            </div>
        </c:if>    

        <script>
            function modal(id, position, transform) {
                var box = document.getElementById(id);
                var modal = document.getElementsByClassName('modal');
                modal[position].style.transform = transform;
                box.style.transform = transform;
            }

            function insertUser() {
                var inputs = document.getElementsByClassName('input');
                var username = inputs[0].value;
                var email = inputs[1].value;
                var name = inputs[2].value;
                var dob = inputs[3].value;
                var phone = inputs[4].value;
                var gender = null;
                if (inputs[5].checked) {
                    gender = true;
                } else if (inputs[6].checked) {
                    gender = false;
                }
                var address = inputs[7].value;
                var role = inputs[8].value;
                var status = inputs[9].value;
                if (username === '') {
                    createNotify("warning", "Th??ng b??o", "T??i kho???n ??ang tr???ng!", true);
                    return;
                } else if (email === '') {
                    createNotify("warning", "Th??ng b??o", "Email ??ang tr???ng!", true);
                    return;
                } else if (!email.match("^[A-Za-z0-9+_.-]+@(.+)$")) {
                    createNotify("warning", "Th??ng b??o", "Sai ?????nh d???ng email!", true);
                    return;
                } else if (name === '') {
                    createNotify("warning", "Th??ng b??o", "T??n ng?????i d??ng ??ang tr???ng!", true);
                    return;
                } else if (dob === '') {
                    createNotify("warning", "Th??ng b??o", "Ng??y sinh ??ang tr???ng!", true);
                    return;
                } else if (phone === '') {
                    createNotify("warning", "Th??ng b??o", "S??? ??i???n tho???i ??ang tr???ng!", true);
                    return;
                } else if (!phone.match("[0-9]{10}")) {
                    createNotify("warning", "Th??ng b??o", "S??? ??i???n tho???i bao g???m 10 s???!", true);
                    return;
                } else if (gender === null) {
                    createNotify("warning", "Th??ng b??o", "Vui l??ng ch???n gi???i t??nh", true);
                    return;
                } else if (address === '') {
                    createNotify("warning", "Th??ng b??o", "?????a ch??? ??ang tr???ng!", true);
                    return;
                }

                var url = "insert?username=" + username + "&address=" + address + "&name=" + name + "&phone=" + phone + "";
                url += "&email=" + email + "&role=" + role + "&dob=" + dob + "&gender=" + gender + "&status=" + status + "";
                fetch(url).then(function (response) {
                    return response.text();
                }).then(function (result) {
                    if (result === '1' || result === '0') {
                        createNotify("warning", "Th??ng b??o", "T??i kho???n ho???c email ???? t???n t???i!", true);
                    } else {
                        createNotify("success", "Th??ng b??o", "Th??m ng?????i d??ng th??nh c??ng!", true);
                        setTimeout(function () {
                            window.location.href = "list";
                        }, 1000);
                    }
                });
            }



            function getUserDetail(username) {
                var url = "edit?username=" + username;
                var edits = document.getElementsByClassName('edit-user');
                fetch(url).then(function (response) {
                    return response.json();
                }).then(function (result) {

                    var user = result.user;
                    var editRole = document.getElementById('edit-role');
                    var groups = result.groups;
                    edits[0].src = result.avatar;
                    if (user.name === undefined) {
                        edits[1].innerHTML = 'Kh??ng c?? th??ng tin';
                    } else {
                        edits[1].innerHTML = user.name;
                    }
                    edits[2].innerHTML = user.username;
                    edits[3].value = user.username;
                    edits[4].innerHTML = user.email;
                    if (user.name === undefined) {
                        edits[5].innerHTML = 'Kh??ng c?? th??ng tin';
                    } else {
                        edits[5].innerHTML = user.name;
                    }
                    if (user.dob === undefined) {
                        edits[6].innerHTML = 'Kh??ng c?? th??ng tin';
                    } else {
                        edits[6].innerHTML = result.dob;
                    }
                    if (user.phone === undefined) {
                        edits[7].innerHTML = 'Kh??ng c?? th??ng tin';
                    } else {
                        edits[7].innerHTML = user.phone;
                    }
                    if (user.gender === true) {
                        edits[8].innerHTML = 'Nam';
                    } else {
                        edits[8].innerHTML = 'N???';
                    }
                    if (user.address === undefined || user.address === '') {
                        edits[9].innerHTML = 'Kh??ng c?? th??ng tin';
                    } else {
                        edits[9].innerHTML = user.address;
                    }
                    if (user.description === undefined || user.description === '') {
                        edits[10].innerHTML = 'Kh??ng c?? th??ng tin';
                    } else {
                        edits[10].innerHTML = user.description;
                    }
                    if (user.status === true) {
                        edits[11].selected = "selected";
                    } else {
                        edits[12].selected = "selected";
                    }
                    var role = document.getElementById("role");
                    role.innerHTML = user.group.name;
                    var s = "";
                    for (var i = 0; i < groups.length; i++) {
                        s += "<option value=\"" + groups[i].id + "\" ";
                        s += "   >" + groups[i].name + "</option>";
                    }
                    editRole.innerHTML = s;
                });
                modal('edit-user-modal', 1, 'scale(1)');
            }
        </script>
        <script src="../../../admin/js/tabler.min.js" defer></script>
        <script src="../../../admin/js/demo.min.js" defer></script>
        <script src="https://code.jquery.com/jquery-3.5.1.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/jquery.dataTables.min.js" ></script>
        <script src="https://cdn.datatables.net/1.12.0/js/dataTables.bootstrap4.min.js" ></script>
    </body>   
</html>
