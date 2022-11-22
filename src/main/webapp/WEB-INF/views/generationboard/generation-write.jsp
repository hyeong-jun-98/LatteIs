<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>글쓰기</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- 상세보기 css -->
    <link href="/css/board/board-detail.css" rel="stylesheet"/>
    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">

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


<div class="wrap">

    <div class="content-container">

        <h1 class="main-title">연령대별 게시판
            <c:if test="${generation != 9999}">
                - ${generation}년대
            </c:if>
        </h1>

        <form id="write-form" autocomplete="off" enctype="multipart/form-data">
            <input type="hidden" name="userNickname" value="${loginUser.userNickname}">

            <c:if test="${sessionGeneration != 9999}">
                <input type="text" name="generation" value="${sessionGeneration}">
            </c:if>

            <c:if test="${sessionGeneration == 9999}">
                <div class="mb-3">
                    <select name="generation">
                        <option value="">연대 선택</option>
                        <option value="2000">2000년대</option>
                        <option value="1990">1990년대</option>
                        <option value="1980">1980년대</option>
                        <option value="1970">1970년대</option>
                    </select>
                </div>
            </c:if>

            <div class="mb-3">
                <label for="writer-input" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer-input" placeholder="이름" name="writer" maxlength="20"
                       value="${loginUser.userNickname}" readonly>
            </div>
            <div class="mb-3">
                <label for="title-input" class="form-label">글제목</label>
                <input type="text" class="form-control" id="title-input" placeholder="제목" name="title">
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control main-content" id="exampleFormControlTextarea1"
                          oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'"></textarea>
            </div>

            <div class="d-grid gap-2">
                <button id="reg-btn" class="btn btn-dark" type="button">글 작성하기</button>
                <button id="to-list" class="btn btn-warning" type="button">목록으로</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 글 작성 이벤트
    function writeEvent() {
        document.getElementById("reg-btn").addEventListener("click", function () {
            const $form = document.getElementById("write-form");
            $form.action = "/generation/write";
            $form.method = "post";
            $form.submit();
        });
    }

    // 목록으로 가기
    function toList() {
        // 목록 버튼
        const $toList = document.getElementById('to-list');
        $toList.onclick = e => {
            location.href = "/generation/list";
        }
    }

    (function () {
        writeEvent();
        toList();
    })();

</script>


</body>
</html>
