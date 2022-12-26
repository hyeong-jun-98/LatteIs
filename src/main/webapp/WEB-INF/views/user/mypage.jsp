<%--
  Created by IntelliJ IDEA.
  User: hojong
  Date: 2022-11-15
  Time: 오후 4:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <link href="/css/topbar.css" rel="stylesheet">
</head>
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
    h1{
        text-align: center;
        margin-top: 5em;
        font-size: 50px;
    }
    .mypage_wrapper{
        width: 40%;
        height: 20em;
        background: white;
        border-radius: 20px;
        margin: auto;
        margin-bottom: 10em;
        padding: 2em;
    }
    .mypage_wrapper > div:last-child{
        display: flex;
        width: 100%;
        justify-content: space-around;
        padding-top: 1em;
    }
    .myInfo{
        display:flex;
        float: left;
        height: 70%;
        width: 100%;
        border-radius: 20px;
        border: 2px black solid;
    }
    .myInfo > div{
        width: 25%;
        background-size: 100% 100%;
        background-repeat: no-repeat;
        text-align: center;
        line-height: 2.4em;
        font-size: 80px;
        margin-left: 0.1em;
    }
    table{
        margin-left: 4em;
    }
    tr td:last-child{
        padding-left: 5em;
    }
    button{
        width: 30%;
        height: 40px;
        background: white;
        z-index: 1000;
        position: relative;
        margin: 1em 0;
    }
    @media screen and (max-width: 820px) {
        .mypage_wrapper{
            width: auto;
            height: auto;
        }
        .myInfo{
            display: block;
            height: auto;
        }
        table{
            margin-left: 0;
        }
        .myInfo > div{
            width: auto;
            margin-left: 0;
            border-bottom: 2px solid black;

        }
        tr td:last-child{
            padding-left: 0.3em;
            border-left: 2px solid black;
        }
        td{
            width: 50%;
            padding-left: 0.8em;
        }
        tr{
            border-bottom: 2px solid black;
        }
        tr:last-child{
            border-bottom: none;
        }
    }
</style>
<body>
    <%@include file="../topbar.jsp"%>
    <h1>마이페이지</h1>
    <div class="mypage_wrapper">
        <div class="myInfo">
            <div id="userImg">${loginUser.userYear}</div>
            <table class="infoTable">
                <tr>
                    <td>
                        <div>아이디</div>
                        <div>${loginUser.userEmail}</div>
                    </td>
                    <td>
                        <div>이름</div>
                        <div>${loginUser.userName}</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>닉네임</div>
                        <div>${loginUser.userNickname}</div>
                    </td>
                    <td>
                        <div>연령대</div>
                        <div>${loginUser.userYear}년대</div>
                    </td>
                </tr>
                <tr>
                    <td>
                        <div>총점수</div>
                        <div>${loginUser.userScore}점</div>
                    </td>
                    <td>
                        <div>등급</div>
                        <div>${loginUser.userGrade}</div>
                    </td>
                </tr>
            </table>
        </div>
        <div>
            <button type="button" id="toHome">홈으로</button>
            <button type="button" id="toRevise">회원정보 수정</button>
            <button type="button" id="toExit">회원 탈퇴</button>
        </div>
<%--        <div class="bg">--%>
<%--            <div class="icon"></div>--%>
<%--            <div class="text">Latte is...</div>--%>
<%--        </div>--%>

    </div>
</body>
<script>
    function toMyHome(){
        document.getElementById("toHome").onclick = e =>{
            location.href="/";
        }
    }
    function toRevise(){
        document.getElementById("toRevise").onclick = e =>{
            location.href="/user/revise";
        }
    }
    function toExit(){
        document.getElementById("toExit").onclick = e =>{
            if (confirm("정말 회원정보를 삭제 하겠습니까?") == true){    //확인
                location.href="/user/exit";
            }else{   //취소
                return;
            }
        }
    }
    function setImg(){
        const yearCheck = '${loginUser.userYear}';
        switch (yearCheck){
            case '70':
                document.getElementById("userImg").style.backgroundImage="url('/img/blue.png')";
                break;
            case '80':
                document.getElementById("userImg").style.backgroundImage="url('/img/red.png')";
                break;
            case '90':
                document.getElementById("userImg").style.backgroundImage="url('/img/orange.png')";
                break;
            case '00':
                document.getElementById("userImg").style.backgroundImage="url('/img/yellow.png')";
                break;
        }
    }
    (function (){
        toMyHome();
        toRevise();
        toExit();
        setImg();
    })()
</script>
</html>
