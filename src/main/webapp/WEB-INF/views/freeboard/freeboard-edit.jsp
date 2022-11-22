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

    <!--제이쿼리-->
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

</head>

<body>
<%@include file="../topbar.jsp" %>

<div class="wrap">

    <div class="content-container">

        <form>
            <input type="hidden" name="pageNum" value="${page.pageNum}">
            <input type="hidden" name="amount" value="${page.amount}">
            <input type="hidden" name="boardNo" value="${board.boardNo}">

            <h1 class="main-title">자유게시판</h1>
            <h2 class="board-no-title">${board.boardNo}번 게시물</h2>

            <div class="mb-3">
                <label for="writer-input" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer-input" placeholder="이름" name="writer"
                       value="${board.writer}" readonly>
            </div>
            <div class="mb-3">
                <label for="title-input" class="form-label">글제목</label>
                <textarea type="text" class="form-control" id="title-input" placeholder="제목" name="title"
                          rows="1" oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.title}</textarea>
            </div>

            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control main-content"
                          id="exampleFormControlTextarea1"
                          oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.content}</textarea>
            </div>


            <div class="btn-group btn-group-lg custom-btn-group" role="group">
                <button id="apply-btn" type="button" class="btn btn-warning">완료</button>
                <button id="cancel-btn" type="button" class="btn btn-dark">취소</button>
            </div>
        </form>

    </div>
</div>

<script>
    // 제목 글자수 제한
    $(document).ready(function () {

        // 엔터키 못치게
        $('#title-input').keypress(function (e) {
            if (e.keyCode == 13)
                e.preventDefault();
        });

        $('#title-input').on('keyup', function (e) {
            if ($(this).val().length > 100) {
                alert('제목을 100자 이내로 입력하세요.');
                $(this).val($(this).val().substring(0, 100));
            }
        });
    });

    // 게시글 수정 완료
    function edit() {
        // 완료버튼
        const $editBtn = document.getElementById("apply-btn");
        $editBtn.onclick = e => {
            if (document.getElementById('title-input').value === '') {
                alert('제목을 입력해주세요');
                return;
            } else if (document.querySelector('.main-content').value === '') {
                alert('글 내용을 작성해주세요.');
                return;
            }

            if (!confirm("수정하시겠습니까?")) return;
            const $form = document.querySelector("form");
            $form.method = "post";
            $form.action = "/freeboard/edit";
            $form.submit();
        }
    }

    // 수정 취소
    function cancel() {
        // 취소 버튼
        const $cancelBtn = document.getElementById('cancel-btn');
        $cancelBtn.onclick = e => {
            location.href = "/freeboard/detail/${board.boardNo}?pageNum=${page.pageNum}&amount=${page.amount}";
        }
    }

    // 스크롤 높이 계산
    function scrollHeightCal() {
        const $title = document.querySelector('#title-input');
        const $content = document.querySelector('#exampleFormControlTextarea1');
        $title.style.height = $title.scrollHeight + 'px';
        $content.style.height = $content.scrollHeight + 'px';
    }

    (function () {
        edit();
        cancel();
        scrollHeightCal();
    })();
</script>
</body>
</html>
