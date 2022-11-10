<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
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
        .write-container {
            width: 50%;
            margin: 200px auto 150px;
            font-size: 1.2em;
        }

        .fileDrop {
            width: 600px;
            height: 200px;
            border: 1px dashed gray;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5em;
        }

        .uploaded-list {
            display: flex;
        }

        .img-sizing {
            display: block;
            width: 100px;
            height: 100px;
        }
    </style>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <!-- custom css -->
    <link rel="stylesheet" href="/css/main-write.css">
    <link rel="stylesheet" href="/css/custom-write.css">
    <link href="/css/topbar.css" rel="stylesheet">
</head>

<body>
<%@include file="../topbar.jsp"%>
<div class="wrap custom-wrap">
    <%--    <%@ include file="../include/header.jsp" %>--%>
    <input type="hidden" name="diaryNo" value="${d.diaryNo}">
    <div class="write-container custom-container">

        <form id="write-form" action="/diary/write" method="post" autocomplete="off" enctype="multipart/form-data">


            <div>
                <h1 class="today-diary">(작성자)의 일기</h1>
            </div>

            <div class="mb-3">
                <select name="emotion" id="emotion-input">
                    <option value="">${d.emotion}</option>
                    <option value="좋음">좋음</option>
                    <option value="보통">보통</option>
                    <option value="슬픔">슬픔</option>
                    <option value="근심">근심/걱정</option>
                </select>
            </div>

            <div class="mb-3">
                <select name="diaryShow" id="show-input">
                    <option value="">${d.diaryShow}</option>
                    <option value="비공개">비공개</option>
                    <option value="공개">공개</option>

                </select>
            </div>
            <div class="mb-3">
                <textarea name="diaryContent" class="form-control" id="exampleFormControlTextarea1" rows="10" placeholder="내용">${d.diaryContent}</textarea>
            </div>

            <div class="d-grid gap-2 btn-list">
                <button id="reg-btn" class="btn btn-dark custom-button" type="submit">일기 수정</button>
                <button id="to-list" class="btn btn-warning custom-button" type="button">목록</button>
            </div>

        </form>

    </div>

    <%--    <%@ include file="../include/footer.jsp" %>--%>
</div>
<script>
    //목록버튼 이벤트
    const $toList = document.getElementById('to-list');
    $toList.onclick = e => {
        location.href = '/diary/list';
    };
</script>

</body>

</html>