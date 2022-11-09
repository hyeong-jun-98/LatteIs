<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메인페이지</title>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- Core theme CSS (includes Bootstrap)-->
<%--    <link href="/css/main.css" rel="stylesheet"/>--%>

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
        .main{
            width: 100%;
        }
        /*topbar*/
        .topbar{
            width: 100%;
            height: 150px;
            background: rgba(0,0,0,0.1);
            padding: 30px;
            display: flex;
        }
        .icon{
            width: 80px;
            height: 80px;
            margin-top: -10px;
            background-size: cover;
            background-image: url("https://cdn-icons-png.flaticon.com/128/6937/6937770.png");
        }
        .icon-wrapper{
            width: 300px;
            height: 100px;
            padding: 10px;
            display: flex;
        }
        .icon-text{
            margin-top: 20px;
            font-size: 30px;
        }
        .category{
            font-size: 30px;
            height: 150px;
            margin-top: -30px;
            display: flex;
        }
        .category div{
            width: 200px;
            height: 100%;
            margin: 20px;
            margin-right: 40px;
            text-align: center;
            line-height: 150px;
            margin-top: 0;
            margin-bottom: 0;
        }
        .category div:hover{
            background: rgba(0,0,0,0.3);
        }
        /*topbar end*/
        .title{
            width: 100%;
            font-size: 150px;
            line-height: 600px;
            text-align: center;
        }
        .today{
            width: 60%;
            height: 600px;
            margin: auto;
            margin-bottom: 200px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
            align-content: space-around;
        }
        .today > div{
            width: 40%;
            height: 40%;
            background: white;
            border-radius: 20px;
            text-align: center;
            line-height: 250px;
            font-size: 30px;
        }
        .today .keyword div{
            margin: auto;
            height: 50%;
            line-height: 100px;
        }
        .today .keyword div:first-child{
            margin-top: 30px;
        }
        .today .keyword div:last-child{
            line-height: 0;
            color: red;
        }
    </style>
</head>
<body>
    <div class="topbar">
        <div class="icon-wrapper">
            <div class="icon">

            </div>
            <div class="icon-text">
                Latte is...
            </div>
        </div>
        <div class="category">
            <div>
                오늘의 키워드
            </div>
            <div>
                연령대별 추억 공유
            </div>
            <div id="list">
                자유게시판
            </div>
            <div>
                스무고개
            </div>
            <div id="diary">
                나의 한 줄 일기
            </div>
        </div>
    </div>
    <div class="main">
        <div class="title">
            Latte is...
        </div>
        <div class="today">
            <div class="keyword">
                <div>오늘의 키워드</div>
                <div>사탕</div>
            </div>
            <div>스무고개 랭킹</div>
            <div>베스트 게시글</div>
            <div>베스트 일기</div>
        </div>
    </div>
</body>
<script>
    // 목록으로 가지
    function toList() {
        // 목록 버튼
        const $toList = document.getElementById('list');
        $toList.onclick = e => {
            location.href = "/freeboard/list";
        }
    }
    function toDiary(){
        const $toDiary = document.getElementById('diary');
        $toDiary.onclick = e => {
            location.href = "/diary/list";
        }
    }
    (function(){
        toList();
        toDiary();
    })();
</script>
</html>
