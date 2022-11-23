<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- 상세보기 css -->
    <link href="/css/board/board-detail.css" rel="stylesheet"/>
    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">

    <style>

    </style>
</head>

<body>
<%@include file="../topbar.jsp"%>

<div class="wrap">

    <div class="content-container">

        <form>
            <input type="hidden" name="pageNum" value="${page.pageNum}">
            <input type="hidden" name="amount" value="${page.amount}">
            <input type="hidden" name="boardNo" value="${board.boardNo}">

            <h1 class="main-title">키워드 게시판</h1>
            <h2 class="board-no-title">${board.boardNo}번 게시물</h2>

            <div class="mb-3">
                <label for="exampleFormControlInput1" class="form-label">작성자</label>
                <input type="text" class="form-control" id="exampleFormControlInput1" placeholder="이름" name="writer"
                       value="${board.writer}" readonly>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlInput2" class="form-label">글제목</label>
                <input type="text" class="form-control" id="exampleFormControlInput2" placeholder="제목" name="title"
                       value="${board.title}">
            </div>

            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control main-content"
                          id="exampleFormControlTextarea1" oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.content}</textarea>
            </div>


            <div class="btn-group btn-group-lg custom-btn-group" role="group">
                <button id="apply-btn" type="button" class="btn btn-warning">완료</button>
                <button id="cancel-btn" type="button" class="btn btn-dark">취소</button>
            </div>
        </form>

    </div>
</div>

<script>

    // 게시글 수정 완료
    function edit(){
        // 완료버튼
        const $editBtn = document.getElementById("apply-btn");
        $editBtn.onclick=e=>{
            if (!confirm("수정하시겠습니까?"))return;
            const $form = document.querySelector("form");
            $form.method="post";
            $form.action="/keyword/edit";
            $form.submit();
        }
    }

    // 수정 취소
    function cancel(){
        // 취소 버튼
        const $cancelBtn = document.getElementById('cancel-btn');
        $cancelBtn.onclick = e =>{
            location.href = "/keyword/detail/${board.boardNo}?pageNum=${page.pageNum}&amount=${page.amount}";
        }
    }

    // 스크롤 높이 계산
    function scrollHeightCal(){
        const $textarea = document.querySelector('#exampleFormControlTextarea1');
        $textarea.style.height = $textarea.scrollHeight + 'px';
    }

    (function(){
        edit();
        cancel();
        scrollHeightCal();
    })();
</script>
</body>
</html>
