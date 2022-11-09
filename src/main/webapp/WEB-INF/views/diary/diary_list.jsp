
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>일기장</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="/css/custom-list.css" rel="stylesheet" />

</head>

<style>


</style>

<body>

<!-- Header-->
<header class="py-5">
    <div class="container px-lg-5">
        <div class="p-4 p-lg-5 bg-light rounded-3 text-center">
            <div class="m-4 m-lg-5">
                <h1 class="display-5 fw-bold custom-Mylist">나의 일기장</h1>
                <a class="btn btn-primary btn-lg custom-gotoWrite" href="/diary/write" >일기 작성하러 가기</a>
            </div>
        </div>
    </div>
</header>
<!--
 Page Content
<section class="pt-4">
    <div class="container px-lg-5">
       Page Features
        <div class="row gx-lg-5">
            <div class="col-lg-6 col-xxl-4 mb-5">
                <div class="card bg-light border-0 h-100">
                    <div class="card-body text-center p-4 p-lg-5 pt-0 pt-lg-0">
                        <div class="feature bg-primary bg-gradient text-white rounded-3 mb-4 mt-n4"><i class="bi bi-collection"></i></div>
                        <h2 class="fs-4 fw-bold">Fresh new layout</h2>
                        <p class="mb-0">With Bootstrap 5, we've created a fresh new layout for this template!</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section> -->

<!--글 목록-->
<div class="container mx-auto flex flex-wrap justify-start">


    <!--글 하나하나-->
    <c:forEach var="d" items="${dList}">
    <div class="lg:w-1/4 md:w-1/2 w-full p-5">
        <a href="#">
            <div class="hover:shadow-2x1 card shadow-lg w-full h-full break-all">
                <div class="card-body h-72 bg-white">
                    <div class="flex justify-between">

                        <p>(작성자 이름)</p>
                        <div>
                            <p class="text-right text-sm text-gray-500">${d.diaryRegdate}</p>
                           <!-- <p class="text-sm text-gray-500 text-right">조회수 </p> -->
                        </div>
                    </div>
                    <div class="divider my-0">

                    </div>
                    <h2 class="card-title">기분 ${d.emotion}</h2>
                    <div class="text-clip overflow-hidden">
                        <p>${d.diaryContent}</p>
                    </div>
                </div>
            </div>
        </a>
    </div>
    </c:forEach>
</div>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>
</body>
</html>
