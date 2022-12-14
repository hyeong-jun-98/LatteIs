<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>퀴즈</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/css/styles.css" rel="stylesheet"/>
    <link href="/css/custom-list.css" rel="stylesheet"/>
    <link href="/css/topbar.css" rel="stylesheet">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />

</head>

<style>
    @font-face {
        font-family: 'KyoboHand';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/KyoboHand.woff') format('woff');
        font-weight: bold;
        font-style: normal;
    }

    body {
        background-image: url("https://img.freepik.com/free-photo/white-crumpled-paper-texture-for-background_1373-159.jpg");
        background-repeat: no-repeat;
        background-size: cover;
        overflow: visible;
        font-family: KyoboHand;
    }


    .amount {
        display: flex;
        /* background: skyblue; */
        justify-content: flex-end;
    }

    .amount li {
        width: 8%;
        margin-right: 10px;
    }

    .amount li a {
        width: 100%;
    }

    /* bottom-section style */
    .bottom-section nav {
        flex: 9;
        display: flex;
        justify-content: center;
    }

    .bottom-section button {
        font-size: 20px;
    }

    .pagination-custom li a {
        color: #000 !important;
    }

    .pagination-custom li.active a,
    .pagination-custom li:hover a {
        background: lightyellow !important;
        border-color: orange !important;
    }

    .bg-size {
        width: 70px;
        text-align: center;
        line-height: 50px;
        background-size: 100% 100%;
        color: white;
    }
    .div-height {
        height: 50px;
        line-height: 50px;
    }

    #canvas {
        border: 1px solid black;
    }
    #stamp{
        position: absolute;
        left: 0;
        top: 0;
        width: 10em;
    }
    .position{
        position: relative;
    }

    .user{
        font-size: 1.5em !important;
        height: 1.5em;
        line-height: 50px;
    }
    .user:nth-child(2){
        font-size: 1.5em !important;
    }
    .grade{
        width: 1.2em;
    }
</style>

<body>
<%--topbar--%>
<%@include file="../topbar.jsp" %>

<!-- Header-->
<header class="py-5">
    <div class="container px-lg-5">
        <div class="p-4 p-lg-5 rounded-3 text-center list-title">
            <div class="m-4 m-lg-5">
                <h1 class="display-5 fw-bold custom-Mylist diary-header">퀴즈</h1>
                <a class="btn btn-primary btn-lg custom-gotoWrite diary-header" href="/quiz/write"
                   style="color: black">퀴즈 작성하러 가기</a>
            </div>
        </div>
    </div>
</header>

<!--글 목록-->
<div id="article-container" class="container mx-auto flex flex-wrap justify-start">

    <!--글 하나하나-->
    <c:forEach var="q" items="${quizList}">
        <div class="lg:w-1/4 md:w-1/2 w-full p-5 articles margin" data-quiz-num="${q.quizNo}">
            <a href="#" style="color: black">
                <div class="hover:shadow-2x1 card shadow-lg w-full h-full break-all hover position">
                    <c:if test="${q.quizCheck == '1'}">
                    <img id="stamp" src="/img/stamp.png">
                    </c:if>
                    <div class="card-body bg-white">
                        <div class="flex justify-between">
                            <div class="w-100">
                                <div class="d-flex justify-content-between mb-3 div-height">
                                    <p class="fs-5 user">
                                        <c:if test="${q.userGrade=='애기'}">
                                            <img src="/img/10.png" class="grade">
                                        </c:if>
                                        <c:if test="${q.userGrade=='유치원생'}">
                                            <img src="/img/100.png" class="grade">
                                        </c:if>
                                        <c:if test="${q.userGrade=='초등학생'}">
                                            <img src="/img/500.png" class="grade">
                                        </c:if>
                                        <c:if test="${q.userGrade=='중학생'}">
                                            <img src="/img/1000.png" class="grade">
                                        </c:if>
                                        <c:if test="${q.userGrade=='고등학생'}">
                                            <img src="/img/5000.png" class="grade">
                                        </c:if>
                                        <c:if test="${q.userGrade=='대학생'}">
                                            <img src="/img/10000.png" class="grade">
                                        </c:if>
                                        <c:if test="${q.userGrade=='졸업생'}">
                                            <img src="/img/50000.png" class="grade">
                                        </c:if>
                                            ${q.quizWriter}</p>
                                    <c:if test="${q.quizScore == '500'}">
                                        <div class="fs-5 bg-size" style="background-image: url('/img/red.png');">${q.quizScore}점</div>
                                    </c:if>
                                    <c:if test="${q.quizScore == '400'}">
                                        <div class="fs-5 bg-size" style="background-image: url('/img/orange.png');">${q.quizScore}점</div>
                                    </c:if>
                                    <c:if test="${q.quizScore == '300'}">
                                        <div class="fs-5 bg-size" style="background-image: url('/img/yellow.png');">${q.quizScore}점</div>
                                    </c:if>
                                    <c:if test="${q.quizScore == '200'}">
                                        <div class="fs-5 bg-size" style="background-image: url('/img/blue.png');">${q.quizScore}점</div>
                                    </c:if>
                                    <c:if test="${q.quizScore == '100'}">
                                        <div class="fs-5 bg-size" style="background-image: url('/img/purple.png');">${q.quizScore}점</div>
                                    </c:if>
                                </div>

                                <p class=" text-sm text-gray-500 date">${q.prettierDate}</p>

                                <div class="like-view">
                                    <p class="text-sm text-gray-500 date">좋아요 : ${q.quizGood}</p>
                                    <p class="text-sm text-gray-500 date">조회수 : ${q.quizHit} </p>
                                </div>
                            </div>
                        </div>
                        <img id="canvas" src="${q.fileName}">
                    </div>
                </div>
            </a>
        </div>
    </c:forEach>
</div>

<!-- 게시글 목록 하단 영역 -->
<div class="bottom-section">

    <!-- 페이지 버튼 영역 -->
    <nav aria-label="Page navigation example">
        <ul class="pagination pagination-lg pagination-custom">

            <c:if test="${pm.prev}">
                <li class="page-item"><a class="page-link"
                                         href="/quiz/list?pageNum=${pm.beginPage - 1}&amount=${pm.diaryPage.amount}">prev</a>
                </li>
            </c:if>

            <c:forEach var="n" begin="${pm.beginPage}" end="${pm.endPage}" step="1">
                <li data-page-num="${n}" class="page-item" style="color: black">
                    <a class="page-link" href="/quiz/list?pageNum=${n}&amount=${pm.diaryPage.amount}">${n}</a>
                </li>
            </c:forEach>

            <c:if test="${pm.next}">
                <li class="page-item"><a class="page-link"
                                         href="/quiz/list?pageNum=${pm.endPage + 1}&amount=${pm.diaryPage.amount}">next</a>
                </li>
            </c:if>

        </ul>
    </nav>
</div>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<%--<script src="js/scripts.js"></script>--%>

<script>

    //현재 위치한 페이지에 active 스타일 부여하기
    function appendPageActive() {

        // 현재 내가 보고 있는 페이지 넘버
        const curPageNum = '${pm.diaryPage.pageNum}';
        // console.log("현재페이지: ", curPageNum);

        // 페이지 li태그들을 전부 확인해서
        // 현재 위치한 페이지 넘버와 텍스트컨텐츠가 일치하는
        // li를 찾아서 class active 부여
        const $ul = document.querySelector('.pagination');

        for (let $li of [...$ul.children]) {
            if (curPageNum === $li.dataset.pageNum) {
                $li.classList.add('active');
                break;
            }
        }

    }

    function detailEvent() {
        //상세보기 요청 이벤트
        const $table = document.querySelector("#article-container");
        // console.log($table);
        $table.addEventListener('click', e => {

            console.log(e.target);

            if (!e.target.matches('.break-all *')) return;

            console.log('게시글 내부 영역 클릭됨! - ', e.target);

            const $targetDiv = e.target.closest('.articles');
            console.log($targetDiv);
            let quizNo = $targetDiv.dataset.quizNum;
            console.log('글번호: ' + quizNo);

            location.href = '/quiz/detail/' + quizNo
                + "?pageNum=${pm.diaryPage.pageNum}"
                + "&amount=${pm.diaryPage.amount}";
        });
    }

    function hover() {
        const $hover = document.getElementsByClassName("hover");
        for (let i of $hover) {
            i.onmouseover = e => {
                i.className = "hover:shadow-2x1 card shadow-lg w-full h-full break-all hover animate__animated animate__bounce";
                console.log(i);
            }
            i.onmouseout = e => {
                i.className = "hover:shadow-2x1 card shadow-lg w-full h-full break-all hover";
            }
        }

    }

    (function () {
        appendPageActive();
        detailEvent();
        hover();
    })();


</script>
</body>
</html>
