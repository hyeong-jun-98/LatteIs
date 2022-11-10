<%--
  Created by IntelliJ IDEA.
  User: SL
  Date: 2022-11-07
  Time: 오후 4:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
<title>회원가입</title>
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
    .login_wrapper{
        margin: auto;
        width: 40%;
        height: 600px;
        border-radius: 20px;
        background: white;
        margin-top: 200px;
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
    .login_form .input input{
        width: 100%;
        line-height: 40px;
        border-radius: 20px;
    }
    .passcheck{
        display: none;
    }
    .passcheck div:first-child{
        color:red;
    }
    .passcheck div:last-child{
        color: green;
    }
    .repasscheck{
        display: none;
    }
    .repasscheck div:first-child{
        color: red;
    }
    .repasscheck div:last-child{
        color: green;
    }

    .bg{
        width: 80%;
        height: 100%;
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
        height: 40%;
        font-size: 80px;
        text-align: center;
    }
</style>
</head>
<body>
<div class="login_wrapper">
    <div class="login_form">
        <form>
            <div class="input">
                <div name="user_email">아이디</div>
                <input type="text" id="loginid">
                <div name="password">비밀번호</div>
                <input type="password" id="loginpw">
                <div class="passcheck">
                    <div>비밀번호는 8자리 이상으로 해주세요</div>
                    <div>사용 가능한 비밀번호 입니다.</div>
                </div>
                <div name="repassword">비밀번호 재확인</div>
                <input type="password" id="reloginpw">
                <div class="repasscheck">
                    <div>비밀번호가 일치하지 않습니다.</div>
                    <div>비밀번호가 일치합니다.</div>
                </div>
                <div name="nickname">닉네임</div>
                <input type="text" id="nickname">

            </div>
        </form>

    </div>
    <div class="bg">
        <div class="icon"></div>
        <div class="text">Latte is...</div>
    </div>
</div>
</body>
<script>
    function login(){
        const $login = document.getElementById("login");
        $login.onclick = e =>{
            location.href= "user/login"
        }
    }
    (function(){
        login();
    })();
</script>
</html>
