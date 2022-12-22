<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>연령대별 추억 공유</title>

    <!-- fontawesome css: https://fontawesome.com -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">
    <!-- board-list css -->
    <link href="/css/board/board-list.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width; initial-scale=1">
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


    </style>
</head>
<body>
<%@include file="../topbar.jsp" %>

<%-- 글 목록 영역 --%>
<div class="wrap">
    <div class="board-list">

        <h1 class="main-title">80년대 게시판</h1>

        <div class="top-section">
            <div class="search">
                <form>
                    <select class="form-class" name="type" id="search-type">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                        <option value="tc">제목+내용</option>
                    </select>

                    <input type="text" class="form-control" name="keyword" value="${search.keyword}">
                    <input type="hidden" name="generation" value="${sessionGeneration}">

                    <button id="btn-search" class="btn btn-warning" type="button">
                        <i class="fas fa-search"></i>
                    </button>

                </form>
            </div>

            <!-- 한 페이지 당 보여질 게시글 수 => amount -->
            <ul class="amount">
                <li data-amount="10"><a class="btn btn-outline-warning"
                                        href="/generation/list?amount=10&type=${search.type}&keyword=${search.keyword}&generation=${sessionGeneration}">10</a>
                </li>
                <li data-amount="20"><a class="btn btn-outline-warning"
                                        href="/generation/list?amount=20&type=${search.type}&keyword=${search.keyword}&generation=${sessionGeneration}">20</a>
                </li>
                <li data-amount="30"><a class="btn btn-outline-warning"
                                        href="/generation/list?amount=30&type=${search.type}&keyword=${search.keyword}&generation=${sessionGeneration}">30</a>
                </li>
            </ul>

        </div>

        <table class="table table-hover">
            <thead class="table-warning">
            <tr>
                <th scope="col">연령대</th>
                <th scope="col">작성자</th>
                <th scope="col">제목</th>
                <th scope="col">추천수</th>
                <th scope="col">조회수</th>
                <th scope="col">작성시간</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <c:forEach var="b" items="${boardList}">
                <tr>
                    <td data-bno="${b.boardNo}">80년대</td>
                    <td>${b.writer} [${b.userYear}]</td>
                    <td title="${b.title}" id="title">
                        <a href="#">${b.shortTitle}</a><span>[${b.commentCount}]</span>
                        <c:if test="${b.newPost}">
                            <span class="badge bg-opacity-75 bg-danger">new</span>
                        </c:if>
                    </td>
                    <td>${b.good}</td>
                    <td>${b.hit}</td>
                    <td>${b.prettierDate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <%-- 아이폰 12 프로 화면일 때 리스트 --%>
        <div class="board-area" style="margin-bottom: 10px">
            <c:forEach var="b" items="${boardList}">
                <div class="board-one">
                    <div id="board-top">
                        <p>${fn:substring(b.generation, 2, 4)}년대</p>
                        <p>${b.prettierDate}</p>
                    </div>
                    <div id="board-title">
                        <a href="#" data-bno="${b.boardNo}">${b.shortTitle}</a>
                        <c:if test="${b.newPost}">
                            <span class="badge bg-opacity-75 bg-danger">new</span>
                        </c:if>
                    </div>
                    <div id="board-bottom">
                        <span>좋아요 ${b.good}</span>&nbsp;&nbsp;&nbsp;
                        <span>댓글 ${b.commentCount}</span>&nbsp;&nbsp;&nbsp;
                        <span>조회수 ${b.hit}</span>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- 게시글 목록 하단 영역 -->
        <div class="bottom-section">
            <!-- 페이지 버튼 영역 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination pagination-lg pagination-custom">

                    <c:if test="${pm.prev}">
                        <li class="page-item">
                            <a class="page-link"
                               href="/generation/list?pageNum=${pm.beginPage - 1}&amount=${pm.page.amount}
                                &type=${search.type}&keyword=${search.keyword}&generation=${sessionGeneration}">prev</a>
                        </li>
                    </c:if>

                    <c:forEach var="n" begin="${pm.beginPage}" end="${pm.endPage}" step="1">
                        <li data-page-num="${n}" class="page-item">
                            <a class="page-link"
                               href="/generation/list?pageNum=${n}&amount=${pm.page.amount}
                               &type=${search.type}&keyword=${search.keyword}&generation=${sessionGeneration}">${n}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <li class="page-item">
                            <a class="page-link"
                               href="/generation/list?pageNum=${pm.endPage + 1}&amount=${pm.page.amount}
                               &type=${search.type}&keyword=${search.keyword}&generation=${sessionGeneration}">next</a>
                        </li>
                    </c:if>

                </ul>
            </nav>

            <!-- 글쓰기 버튼 영역 -->
            <c:if test="${not empty loginUser}">
                <div class="btn-write">
                    <button id="btn-write" type="button" class="btn btn-warning">글쓰기</button>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
    // 게시글 검색
    function search() {
        const $btnSearch = document.getElementById('btn-search');
        $btnSearch.onclick = e => {
            const $form = document.querySelector('form');
            $form.method = "get";
            $form.action = "/generation/list";
            $form.submit();
        }
    }

    // 성공 메시지
    function alertServerMessage() {
        const msg = '${msg}';
        if (msg === 'write-success') {
            alert('게시물이 정상 등록되었습니다.');
        } else if (msg === 'delete-success') {
            alert('게시글이 정상적으로 삭제되었습니다.');
        }
    }

    // 글 작성 폼으로 이동
    function writeForm() {
        const $btnWrite = document.getElementById("btn-write");
        if ($btnWrite !== null) {
            $btnWrite.addEventListener("click", function () {
                location.href = "/generation/write";
            });
        }
    }

    // 게시글 상세보기
    function detailEvent() {
        const $tbody = document.querySelector('.table-group-divider');
        $tbody.onclick = e => {
            if (!e.target.matches('a')) return;
            const boardNo = e.target.parentNode.parentNode.firstElementChild.dataset.bno;
            console.log(boardNo);
            location.href = "/generation/detail/"
                + boardNo + "?pageNum=${pm.page.pageNum}&amount=${pm.page.amount}&generation=${sessionGeneration}"
            ;
        }
    }
    // 모바일 -> 게시글 상세보기
    function mobileDetailEvent() {
        const toDetailList = document.querySelectorAll('.board-area a');
        for (let toDetail of toDetailList) {
            toDetail.onclick = () => {
                location.href = "/generation/detail/"
                    + toDetail.dataset.bno + "?pageNum=${pm.page.pageNum}&amount=${pm.page.amount}";
            }
        }
    }

    //현재 위치한 페이지에 active 스타일 부여하기
    function appendPageActive() {
        // 현재 내가 보고있는 페이지 번호
        const curPageNum = '${pm.page.pageNum}';
        console.log('현재 페이지 번호는 ', curPageNum);

        // 페이지 li태그들을 전부 확인해서
        // 현재 위치한 페이지 번호와 텍스트컨텐트가
        // 일치하는 li를 찾아서 class active 부여
        const $ul = document.querySelector('.pagination');

        for (let $li of [...$ul.children]) {
            if (curPageNum === $li.dataset.pageNum) {
                $li.classList.add('active');
                break;
            }
        }
    }

    // 현재 amount에 active 스타일 부여
    function appendAmountActive() {
        // 현재 내 amount
        const curAmount = '${pm.page.amount}';

        const $ul = document.querySelector('.amount');
        for (let $li of [...$ul.children]) {
            if (curAmount === $li.dataset.amount) {
                $li.firstChild.classList.add('active');
                break;
            }
        }
    }

    // 검색 조건 고정
    function fixSearchOption() {
        const $select = document.getElementById('search-type');
        // console.log($select);
        for (let $opt of [...$select.children]) {
            console.log($opt.value);
            if ($opt.value === '${search.type}') {
                $opt.setAttribute('selected', 'selected');
                break;
            }
        }
    }

    (function () {
        alertServerMessage();
        detailEvent();
        mobileDetailEvent();    // 모바일 -> 글 상세보기
        writeForm();
        appendPageActive();
        appendAmountActive();
        search();
        fixSearchOption();
    })();
</script>
</body>
</html>
