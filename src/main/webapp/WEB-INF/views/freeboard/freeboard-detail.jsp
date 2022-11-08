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

    <style>
        .wrap {
            width: 60%;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<h1>글 상세보기 페이지</h1>

<%-- 글 상세보기 영역 --%>
<div class="wrap">

    <div class="write-container">

        <form id="write-form" autocomplete="off" enctype="multipart/form-data">

            <div class="mb-3">
                <label for="writer-input" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer-input"
                       placeholder="이름" name="writer" maxlength="20" readonly value="${board.writer}">
            </div>
            <div class="mb-3">
                <label for="title-input" class="form-label">글제목</label>
                <input type="text" class="form-control" id="title-input"
                       placeholder="제목" name="title" value="${board.title}">
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control"
                          id="exampleFormControlTextarea1" rows="10">${board.content}</textarea>
            </div>

            <div class="d-grid gap-2">
                <button id="edit-btn" class="btn btn-dark" type="button">수정하기</button>
                <button id="del-btn" class="btn btn-danger" type="button">삭제하기</button>
                <button id="to-list" class="btn btn-warning" type="button">목록으로</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 목록으로 가지
    function toList() {
        // 목록 버튼
        const $toList = document.getElementById('to-list');
        $toList.onclick = e => {
            location.href = "/freeboard/list?pageNum=${page.pageNum}&amount=${page.amount}";
        }
    }
    (function(){
        toList();
    })();
</script>
</body>
</html>
