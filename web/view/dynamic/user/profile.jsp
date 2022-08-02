<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <title>Online-Learn</title>


        <!-- Google Web Fonts -->
        <link href="../../assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
        <c:if test="${sessionScope.user.group.name == 'Học viên'}">
            <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
            <link href="https://fonts.googleapis.com/css2?family=Alegreya&family=Spectral&family=Tinos&display=swap" rel="stylesheet"> 
            <!-- Font Awesome -->

            <!-- Libraries Stylesheet -->
            <!--<link href="../../lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">-->

            <!-- Customized Bootstrap Stylesheet -->
            <link href="../../assets/css/style.css" rel="stylesheet">

            <link href="../../css/style.css" rel="stylesheet">
        </c:if>
        <c:if test="${sessionScope.user.group.name != 'Học viên'}">
            <link href="../../admin/css/demo.min.css" rel="stylesheet"/>
            <link href="../../css/tabler.css" rel="stylesheet"/>
            <!--<link href="../../js/main.js" rel="stylesheet"/>-->
        </c:if>

    </head>
    <style>

        /*        body {
                    background:whitesmoke
                }*/

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
            margin-top: 20px;
            display: flex;
            /*margin: auto;*/
            width: 80%;
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

        .page-header{
            background: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url(../../assets/img/page-header.jpg), no-repeat center center;
            background-size: cover;
        }
    </style>
    <body>
        <div>
            <c:if test="${sessionScope.user.group.name != 'Học viên'}">
                <jsp:include page="../component/header.jsp"></jsp:include>
            </c:if>
            <c:if test="${sessionScope.user.group.name == 'Học viên'}">
                <jsp:include page="../user/learner/header.jsp"></jsp:include>
            </c:if>
        </div>
        <c:if test="${sessionScope.user.group.name == 'Học viên'}">
            <div class="container-fluid page-header" style="margin-bottom: 90px;">
                <div class="container">
                    <div class="d-flex flex-column justify-content-center" style="min-height: 300px">
                        <h3 class="display-4 text-white text-uppercase">Thông tin cá nhân</h3>
                        <div class="d-inline-flex text-white">
                            <p class="m-0 text-uppercase"><a class="text-white" href="http://localhost:8080/onlinelearn/home">Trang Chủ</a></p>
                            <i class="fa fa-angle-double-right pt-1 px-3"></i>
                            <p class="m-0 text-uppercase">Thông tin cá nhân</p>
                        </div>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${sessionScope.user.group.name != 'Học viên'}">
            <div class="col-lg-1"></div>
        </c:if>


        <div class="container col-lg-10 rounded bg-white user-profile " style="margin-bottom: 20px;">  
            <form action="profile" method="POST" enctype="multipart/form-data">
                <input type="hidden" value="${requestScope.user.avatar}" name="imageURL" />
                <input type="hidden" value="${requestScope.user.publicId}" name="publicId" />
                <div class="row">               
                    <div class="col-md-3">
                        <div class="d-flex flex-column align-items-center text-center ">                       
                            <img class="rounded-circle mt-5" id="avatar" width="150px" height="150px" src="${requestScope.user.avatar}" />
                            <span class="font-weight-bold" style="margin-top: 10px">${requestScope.user.name}</span>
                            <div class="mb-3">
                                Chọn ảnh: <input style="margin-top: 10px" class="form-control form-control-sm" id="formFileSm" onchange="previewAvatar();" type="file" accept=".jpg, .jpeg, .png" value="${requestScope.user.avatar}" name="img">
                            </div>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <div class="">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h2 class="text-right">Thông tin cá nhân</h2>
                            </div> 
                            <c:if test="${requestScope.tbao!=null}">${requestScope.tbao}</c:if>
                                <div class="row mt-3">
                                    <div class="col-md-6">
                                        <label class="labels">Tài khoản</label><br/>
                                    ${sessionScope.user.username}
                                    <input name="username" type="hidden" value="${sessionScope.user.username}">
                                </div>
                                <div class="col-md-6">
                                    <label class="labels">Email</label><br/>${sessionScope.user.email}
                                    <input name="email" type="hidden" value="${sessionScope.user.email}">
                                </div>
                            </div>                          
                            <div class="row mt-2">                               
                                <div class="col-md-6"><label class="labels">Họ và tên (bắt buộc)</label><input name="name" type="text" class="form-control" placeholder="Họ và tên" value="${requestScope.user.name}" required></div>                           
                                <div class="col-md-6"><label class="labels">Ngày sinh (tùy chọn)</label><input name="dob" type="date" class="form-control"  value="${requestScope.user.dob}"></div>
                            </div>                       
                            <div class="row mt-2">                                
                                <div class="col-md-6"><label class="labels">Số điện thoại (bắt buộc)</label><input name="phone" pattern="[0-9]{10}" type="text" class="form-control" placeholder="Số điện thoại" value="${requestScope.user.phone}" required></div>                               
                                <div class="col-md-6"><label class="labels">Giới tính (tùy chọn)</label><br/>                                  
                                    <input ${requestScope.user.gender?"checked=\"checked\"":""}
                                        type="radio" value="male" name="gender"> Nam
                                    <input ${!requestScope.user.gender?"checked=\"checked\"":""} 
                                        type="radio" value="female" name="gender" style="margin-left: 10px"> Nữ
                                </div>
                            </div>                         
                            <div class="row mt-3">
                                <div class=""><label class="labels">Địa chỉ</label><br/><input name="address" type="text" class="form-control" placeholder="Địa chỉ" value="${requestScope.user.address}"></div>
                            </div>
                            <div class="row mt-3">
                                <div class=""><label class="labels">Mô tả về bản thân</label><br/><textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="description"  value="${requestScope.user.description}" >${requestScope.user.description}</textarea></div>
                            </div>

                        </div>
                    </div>
                </div> 
                <div class="mt-4 mb-4 text-center"><button class="btn btn-primary profile-button" type="submit">Lưu thông tin</button>
                </div>
            </form>


        </div>


        <c:if test="${sessionScope.user.group.name != 'Học viên'}">
            <div class="col-lg-1"></div>
            <div>
                <jsp:include page="../component/private-footer.jsp"></jsp:include>
                </div>
                <div style="height: 5px; margin-top: 20px;" ></div>
        </c:if>

        <div>

            <c:if test="${sessionScope.user.group.name == 'Học viên'}">
                <jsp:include page="../component/footer.jsp"></jsp:include>
            </c:if>
        </div>
        <script src="../../assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <c:if test="${sessionScope.user.group.name == 'Học viên'}">
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        </c:if>
            
        <c:if test="${sessionScope.user.group.name != 'Học viên'}">
            <script src="../../admin/js/tabler.min.js" defer></script>
            <script src="../../admin/js/demo.min.js" defer></script>
        </c:if>


    </body>

    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="//cdn.ckeditor.com/4.18.0/basic/ckeditor.js"></script>
    <script>
                                    CKEDITOR.replace('exampleFormControlTextarea1');//name textarea
    </script>
    <script>
        function previewAvatar() {
            var file = document.getElementById("formFileSm").files;
            if (file.length > 0) {
                var fileReader = new FileReader();

                fileReader.onload = function (event) {
                    document.getElementById("avatar").setAttribute("src", event.target.result);
                };

                fileReader.readAsDataURL(file[0]);
            }
        }
    </script>
</html>
