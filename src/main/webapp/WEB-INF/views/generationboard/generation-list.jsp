<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <!-- freeboard-list css -->
    <link href="/css/board/board-list.css" rel="stylesheet">

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

        <h1 class="main-title">연령대별 게시판</h1>

        <div class="top-section">
            <div class="search">
                <form>
                    <select class="form-class" name="type" id="search-type">
                        <option value="title">제목</option>
                        <option value="content">내용</option>
                        <option value="writer">작성자</option>
                        <option value="tc">제목+내용</option>
                    </select>

                    <input type="text" class="form-control" name="keyword" value="">

                    <button id="btn-search" class="btn btn-warning" type="button">
                        <i class="fas fa-search"></i>
                    </button>

                </form>
            </div>

            <!-- 한 페이지 당 보여질 게시글 수 => amount -->
            <ul class="amount">
                <li data-amount="10"><a class="btn btn-outline-warning"
                                        href="<%--/freeboard/list?amount=10&type=${search.type}&keyword=${search.keyword}--%>">10</a></li>
                <li  data-amount="20"><a class="btn btn-outline-warning"
                                         href="<%--/freeboard/list?amount=20&type=${search.type}&keyword=${search.keyword}--%>">20</a></li>
                <li  data-amount="30"><a class="btn btn-outline-warning"
                                         href="<%--/freeboard/list?amount=30&type=${search.type}&keyword=${search.keyword}--%>">30</a></li>
            </ul>

        </div>

        <table class="table table-hover">
            <thead class="table-warning">
            <tr>
                <th scope="col">#</th>
                <th scope="col">작성자</th>
                <th scope="col">제목</th>
                <th scope="col">추천수</th>
                <th scope="col">조회수</th>
                <th scope="col">작성시간</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <%--<c:forEach var="b" items="${boardList}">
                <tr>
                    <td>${b.boardNo}</td>
                    <td>${b.writer}</td>
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
            </c:forEach>--%>
            <tr>
                <td></td>
                <td></td>
                <td title="" id="title">
                    <a href="#"></a><span>[]</span>
                    <%--<c:if test="${b.newPost}">
                        <span class="badge bg-opacity-75 bg-danger">new</span>
                    </c:if>--%>
                </td>
                <td></td>
                <td></td>
                <td></td>
            </tr>
            </tbody>
        </table>

        <!-- 게시글 목록 하단 영역 -->
        <div class="bottom-section">
            <!-- 페이지 버튼 영역 -->
            <%--<nav aria-label="Page navigation example">
                <ul class="pagination pagination-lg pagination-custom">

                    <c:if test="${pm.prev}">
                        <li class="page-item"><a class="page-link"
                                                 href="/freeboard/list?pageNum=${pm.beginPage - 1}&amount=${pm.page.amount}&type=${search.type}&keyword=${search.keyword}">prev</a>
                        </li>
                    </c:if>

                    <c:forEach var="n" begin="${pm.beginPage}" end="${pm.endPage}" step="1">
                        <li data-page-num="${n}" class="page-item">
                            <a class="page-link"
                               href="/freeboard/list?pageNum=${n}&amount=${pm.page.amount}&type=${search.type}&keyword=${search.keyword}">${n}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <li class="page-item"><a class="page-link"
                                                 href="/freeboard/list?pageNum=${pm.endPage + 1}&amount=${pm.page.amount}&type=${search.type}&keyword=${search.keyword}">next</a>
                        </li>
                    </c:if>

                </ul>
            </nav>--%>

            <!-- 글쓰기 버튼 영역 -->
            <div class="btn-write">
                <button id="btn-write" type="button" class="btn btn-warning">글쓰기</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
