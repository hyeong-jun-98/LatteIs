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
    .login_wrapper{
        margin: auto;
        width: 40%;
        border-radius: 20px;
        background: white;
        margin-top: 50px;
        margin-bottom: 200px;
        padding: 40px;
    }
    .login_form{
        width: 80%;
        height: 40%;
        float: left;
        margin-left: 40px;
    }
    .login_form .input{
        font-size: 20px;
        z-index: 100;
        position: relative;
    }
    .login_form .input>label{
        width: 100%;
        display: inline-block;
        margin-bottom: 5px;
    }
    .login_form .input>label input{
        width: 100%;
        line-height: 40px;
        border-radius: 20px;
    }

    .user_year{
        margin-top: 25px;
        display: flex;
        justify-content: space-around;
    }
    button{
        width: 100%;
        height: 40px;
        background: white;
        z-index: 1000;
        position: relative;
    }

    .bg{
        width: 80%;
        /*height: 100%;*/
        z-index: -100;
        margin: auto;
        opacity: 0.3;
    }

    .bg .icon{
        width: 100%;
        height: 60%;
        background-image: url("https://cdn-icons-png.flaticon.com/128/6937/6937770.png");
        background-size: 100% 100%;
        background-repeat: no-repeat;
    }
    .bg .text{
        width: 100%;
        /*height: 40%;*/
        font-size: 80px;
        text-align: center;
    }
    .check_email{
        font-size: 15px;
        color: red;
    }
    .check_pass{
        font-size: 15px;
        color: red;
    }
    .check_repass{
        font-size: 15px;
        color: red;
    }
    .check_year{
        font-size: 15px;
        color: red;
    }
    .c-red{
        color: red;
    }
    .c-green{
        color: green;
    }
    span{
        height: 30px;
        width: 100%;
        display:inline-block;
    }
    b{
        font-size: 20px;
    }
</style>
<body>
    <%@include file="../topbar.jsp"%>
    <h1>마이페이지</h1>
    <div class="login_wrapper">
        <div class="login_form">
            <form id="joinForm" action="/user/join" method="post">
                <div class="input">
                    <label id="user_email">아이디
                        <input type="text" id="loginid" name="userEmail"></label>
                    <span class="check_id"></span>
                    <label id="password">비밀번호
                        <input type="password" id="loginpw" name="password"></label>
                    <span class="check_pass"></span>
                    <label id="repassword">비밀번호 재확인
                        <input type="password" id="reloginpw"></label>
                    <span class="check_repass"></span>
                    <label id="user_nickname">닉네임
                        <input type="text" id="nickname" name="userNickname"></label>
                    <span class="check_nickname"></span>
                    <label name="user_name">이름
                        <input type="text" id="user_name" name="userName"></label>
                    <span class="check_name"></span>
                    <div name="user_year">연령대</div>
                    <div class="check_year">필수 입력 사항입니다.</div>
                    <div class="user_year" name="userYear">
                        <label><input type="radio" name="userYear" value="70">70년대</label>
                        <label><input type="radio" name="userYear" value="80">80년대</label>
                        <label><input type="radio" name="userYear" value="90">90년대</label>
                        <label><input type="radio" name="userYear" value="00">00년대</label>
                    </div>

                </div>
                <button id="join" type="button">회원가입</button>
            </form>

        </div>

        <div class="bg">
            <div class="icon"></div>
            <div class="text">Latte is...</div>
        </div>

    </div>
</body>
</html>
