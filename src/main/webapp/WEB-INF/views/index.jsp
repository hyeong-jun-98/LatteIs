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
<%--    <link href="/css/topbar.css" rel="stylesheet"/>--%>

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
        .main{
            width: 100%;
        }

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
        /*키워드 메인*/
        .keyword_main{
            margin:auto;
            width: 100%;
            height: 1000px;
            position: relative;
        }
        .keyword_main::before{
            content: "";
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-image: url("https://cdn.011st.com/11dims/resize/600x600/quality/75/11src/dl/22/0/4/6/9/3/8/JnKXS/2730046938_138591661.jpg");
            opacity: 0.4;
            padding-top: 5%;
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
        }
        .keyword_main .keyword_content{
            margin: auto;
            width: 90%;
            height: 90%;
            /*background: gray;*/
            display: flex;
            justify-content: space-around;
            padding: 5% 0;
            position: relative;

        }
        .keyword_picture{
            width: 40%;
            background: white;
            border-radius: 20px;
        }
        .keyword_describe{
            width: 50%;
            /*background: white;*/
        }
        .keyword_describe div:first-child{
            margin-top: 10%;
            font-size: 70px;
        }
        .keyword_describe div:last-child{
            margin-top: 10%;
            font-size: 40px;
        }
        /*세대별 메인*/
        .age_main{
            margin:auto;
            width: 100%;
            height: 1000px;
            position: relative;
        }
        .age_main::before{
            content: "";
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-image: url("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCeLTlt_Sb1PXIP0-qaPUuDfHrp9XhF2-Lkg&usqp=CAU");
            opacity: 0.4;
            padding-top: 5%;
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
        }
        .age_main .age_content{
            margin: auto;
            width: 90%;
            height: 90%;
            /*background: gray;*/
            display: flex;
            justify-content: space-around;
            padding: 5% 0;
            position: relative;

        }
        .age_picture{
            width: 40%;
            background: white;
            border-radius: 20px;
        }
        .age_describe{
            width: 50%;
            /*background: white;*/
        }
        .age_describe div:first-child{
            margin-top: 10%;
            font-size: 70px;
        }
        .age_describe div:last-child{
            margin-top: 20%;
            font-size: 40px;
        }
        /*스무고개 메인*/
        .quiz_main{
            margin:auto;
            width: 100%;
            height: 1000px;
            position: relative;
        }
        .quiz_main::before{
            content: "";
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-image: url("https://www.popco.net/zboard/data/com_freeboard/2015/12/08/108671684756662aa2bbc66.jpg");
            opacity: 0.4;
            padding-top: 5%;
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
        }
        .quiz_main .quiz_content{
            margin: auto;
            width: 90%;
            height: 90%;
            /*background: gray;*/
            display: flex;
            justify-content: space-around;
            padding: 5% 0;
            position: relative;

        }
        .quiz_picture{
            width: 40%;
            background: white;
            border-radius: 20px;
        }
        .quiz_describe{
            width: 50%;
            /*background: white;*/
        }
        .quiz_describe div:first-child{
            margin-top: 10%;
            font-size: 70px;
        }
        .quiz_describe div:last-child{
            margin-top: 20%;
            font-size: 40px;
        }
        /*일기 메인*/
        .diary_main{
            margin:auto;
            width: 100%;
            height: 1000px;
            position: relative;
        }
        .diary_main::before{
            content: "";
            background-repeat: no-repeat;
            background-size: 100% 100%;
            background-image: url("https://dispatch.cdnser.be/wp-content/uploads/2018/04/ally_2018-04-06_03-24-00_061588-1024x538.jpg");
            opacity: 0.4;
            padding-top: 5%;
            position: absolute;
            top: 0px;
            left: 0px;
            right: 0px;
            bottom: 0px;
        }
        .diary_main .diary_content{
            margin: auto;
            width: 90%;
            height: 90%;
            /*background: gray;*/
            display: flex;
            justify-content: space-around;
            padding: 5% 0;
            position: relative;

        }
        .diary_picture{
            width: 40%;
            background: white;
            border-radius: 20px;
        }
        .diary_describe{
            width: 50%;
            /*background: white;*/
        }
        .diary_describe div:first-child{
            margin-top: 10%;
            font-size: 70px;
        }
        .diary_describe div:last-child{
            margin-top: 20%;
            font-size: 40px;
        }
    </style>
</head>
<body>
    <%@include file="topbar.jsp"%>

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
    <div class="keyword_main">
        <div class="keyword_content">
            <div class="keyword_picture"></div>
            <div class="keyword_describe">
                <div>
                    추억의 키워드로 자신의 추억을 공유해보세요!
                </div>
                <div>
                    불량식품, 게임 등등 매일 새롭게 정해지는 추억의 키워드를 통해 다른 사용자들과 추억을 공유해보세요!
                </div>
            </div>
        </div>
    </div>
    <div class="age_main">
        <div class="age_content">
            <div class="age_describe">
                <div>
                    세대별로 추억을 공유해보세요!
                </div>
                <div>
                    70,80,90,00년대별로 나눠진 게시판에서 자신 세대의 추억을 다른 사용자들과 공유해보세요!
                </div>
            </div>
            <div class="age_picture"></div>
        </div>
    </div>
    <div class="quiz_main">
        <div class="quiz_content">
            <div class="quiz_picture"></div>
            <div class="quiz_describe">
                <div>
                    추억의 단어들로 퀴즈를 진행 해보세요!
                </div>
                <div>
                    본인이 직접 제시어를 정해 스무고개 문제를 내고 다른 사람의 스무고개를 맞춰 보세요!
                </div>
            </div>
        </div>
    </div>
    <div class="diary_main">
        <div class="diary_content">
            <div class="diary_describe">
                <div>
                    새로운 추억을 만들어보세요!
                </div>
                <div>
                    짧은 일기들로 자신만의 새로운 추억을 기록하고 공유하세요!
                </div>
            </div>
            <div class="diary_picture"></div>
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
    function toLogin(){
        const $toLogin = document.getElementById("tologin");
        $toLogin.onclick = e => {
            location.href = "/user/loginform";
        }
    }
    (function(){
        toList();
        toDiary();
        toLogin();
    })();
</script>
</html>
