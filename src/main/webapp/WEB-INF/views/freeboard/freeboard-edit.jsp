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
    <link href="/css/freeboard/freeboard-detail.css" rel="stylesheet"/>
    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">

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
        .content-container .main-content{
            overflow:hidden;
        }


        /* 페이지 버튼 스타일 */
        /*.pagination-custom li a {*/
        /*    color: #000 !important;*/
        /*}*/
        /*.pagination-custom li.active a,*/
        /*.pagination-custom li:hover a {*/
        /*    background: lightyellow !important;*/
        /*    border-color: orange !important;*/
        /*}*/


        /*.wrap {*/
        /*    width: 50%;*/
        /*    margin: 0 auto;*/
        /*}*/
        /*.content-container {*/
        /*    margin-top: 200px;*/
        /*    margin-bottom: 100px;*/
        /*    font-size: 20px;*/
        /*}*/

        /*.content-container .main-title {*/
        /*    font-size: 24px;*/
        /*    font-weight: 700;*/
        /*    text-align: center;*/
        /*    border-bottom: 2px solid rgb(75, 73, 73);*/
        /*    padding: 0 20px 15px;*/
        /*    width: fit-content;*/
        /*    margin: 20px auto 30px;*/
        /*}*/

        /*.content-container .main-content {*/
        /*    border: 2px solid #ccc;*/
        /*    border-radius: 20px;*/
        /*    padding: 10px 25px;*/
        /*    font-size: 1.1em;*/
        /*    text-align: justify;*/
        /*    background: #fff;*/
        /*    min-height: 400px;*/
        /*}*/

        /*.content-container .custom-btn-group {*/
        /*    position: absolute;*/
        /*    left: 50%;*/
        /*    transform: translateX(-50%);*/
        /*}*/
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

            <h1 class="main-title">${board.boardNo}번 게시물</h1>

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
            $form.action="/freeboard/edit";
            $form.submit();
        }
    }

    // 수정 취소
    function cancel(){
        // 취소 버튼
        const $cancelBtn = document.getElementById('cancel-btn');
        $cancelBtn.onclick = e =>{
            location.href = "/freeboard/detail/${board.boardNo}?pageNum=${page.pageNum}&amount=${page.amount}";
        }
    }

    (function(){
        edit();
        cancel();

        const $textarea = document.querySelector('#exampleFormControlTextarea1');
        $textarea.style.height = $textarea.scrollHeight + 'px';

    })();
</script>
</body>
</html>
