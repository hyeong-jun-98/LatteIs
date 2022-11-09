<%--
  Created by IntelliJ IDEA.
  User: hojong
  Date: 2022-11-09
  Time: 오후 4:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인/회원가입</title>
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
            margin-top: 100px;
            margin-left: 40px;
        }
        .login_form .input{
            font-size: 40px;
            z-index: 100;
            position: relative;
        }
        .login_form .input input{
            width: 100%;
            line-height: 40px;
            border-radius: 20px;
        }
        .login_form .check{
        }
        .login_form .join{
            width: 100%;
            height: 300px;
        }
        .login_form .join button{
            width: 100%;
            height: 40px;
            margin: 5px 0;
            background: white;
        }
        .login_form .join :nth-child(2){
            margin-bottom: 100px;
        }
        .login_form .join a{
            margin-left: 25%;
            z-index: 100;
            position: relative;
        }
        .login_form .join{
            margin: auto;
            z-index: 100;
            position: relative;
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
                </div>
            </form>
            자동 로그인<input class="check" type="checkbox">
            <div class="join">
                <button id="login">로그인</button>
                <button id="signin">회원가입</button>
                <a id="custom-login-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=${kakaoAppKey}&redirect_uri=http://localhost:8183${kakaoRedirect}&response_type=code">
                    <img src="//mud-kage.kakao.com/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="300"/>
                </a>
            </div>
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
