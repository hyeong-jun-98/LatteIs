<%@ page contentType="text/html; charset=UTF-8" language="java" %>
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
    body{
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




</style>

<body>
<%--topbar--%>
<%@include file="../topbar.jsp"%>

<!-- Header-->
<header class="py-5">
    <div class="container px-lg-5">
        <div class="p-4 p-lg-5 rounded-3 text-center list-title">
            <div class="m-4 m-lg-5">
                <h1 class="display-5 fw-bold custom-Mylist diary-header">모두의 일기장</h1>
                <a class="btn btn-primary btn-lg custom-gotoWrite diary-header" href="/diary/write" style="color: black">일기 작성하러 가기</a>
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

<%--<!-- 목록 개수별 보기 영역 -->--%>
<%--<ul class="amount">--%>
<%--    <li><a class="btn btn-danger" href="/diary/list?amount=10">10</a></li>--%>
<%--    <li><a class="btn btn-danger" href="/diary/list?amount=20">20</a></li>--%>
<%--    <li><a class="btn btn-danger" href="/diary/list?amount=30">30</a></li>--%>
<%--</ul>--%>

<!--글 목록-->
<div id="article-container" class="container mx-auto flex flex-wrap justify-start">


    <!--글 하나하나-->
    <c:forEach var="d" items="${dPList}">
        <div class="lg:w-1/4 md:w-1/2 w-full p-5 articles margin " data-diary-num="${d.diaryNo}">
            <a href="#" style="color: black">
                <div class="hover:shadow-2x1 card shadow-lg w-full h-full break-all hover">
                    <div class="card-body h-72 bg-white">
                        <div class="flex justify-between">
                            <div>
                            <p>${d.userNickname}</p>
                            <p class="text-right text-sm text-gray-500 date">${d.prettierDate}</p>
                            <p class="text-sm text-gray-500 date">좋아요 : ${d.diaryGood}</p>
                            <!-- <p class="text-sm text-gray-500 text-right">조회수 </p> -->

<%--                        <div class="divider my-0">--%>

<%--                        </div>--%>
                            </div>
                        </div>
                        <h2 class="card-title">오늘의 기분 : ${d.emotion}</h2>

                        <div class="text-clip overflow-hidden">
                            <p>${d.diaryContent}</p>
                        </div>
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
                                         href="/diary/list?pageNum=${pm.beginPage - 1}&amount=${pm.diaryPage.amount}">prev</a>
                </li>
            </c:if>

            <c:forEach var="n" begin="${pm.beginPage}" end="${pm.endPage}" step="1">
                <li data-page-num="${n}" class="page-item" style="color: black">
                    <a class="page-link" href="/diary/list?pageNum=${n}&amount=${pm.diaryPage.amount}" >${n}</a>
                </li>
            </c:forEach>

            <c:if test="${pm.next}">
                <li class="page-item"><a class="page-link"
                                         href="/diary/list?pageNum=${pm.endPage + 1}&amount=${pm.diaryPage.amount}">next</a>
                </li>
            </c:if>

        </ul>
    </nav>
</div>

<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->
<script src="js/scripts.js"></script>

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

            // console.log(e.target);

            if (!e.target.matches('.break-all *')) return;

            // console.log('게시글 내부 영역 클릭됨! - ', e.target);

            const $targetDiv = e.target.closest('.articles');
            // console.log($targetDiv);
            let diaryNo = $targetDiv.dataset.diaryNum;
            // console.log('글번호: ' + diaryNo);

            location.href = '/diary/detail/' + diaryNo
                + "?pageNum=${pm.diaryPage.pageNum}"
                + "&amount=${pm.diaryPage.amount}";
        });
    }
    function hover(){
        const $hover = document.getElementsByClassName("hover");
        for(let i of $hover){
            console.log(i);
            i.onmouseover = e =>{
                i.className = "hover:shadow-2x1 card shadow-lg w-full h-full break-all hover animate__animated animate__bounce";
                console.log(i);
            }
            i.onmouseout = e =>{
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
