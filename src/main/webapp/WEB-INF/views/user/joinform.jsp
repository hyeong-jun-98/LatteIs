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
    <!-- jquery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
</style>
</head>
<body>
<div class="login_wrapper">
    <div class="login_form">
        <form id="joinForm">
            <div class="input">
                <label id="user_email">아이디
                <input type="text" id="loginid" name="user_email"></label>
                <div class="check_email">필수 입력 사항입니다.</div>
                <label id="password">비밀번호
                <input type="password" id="loginpw" name="password"></label>
                <div class="check_pass">필수 입력 사항입니다.</div>
                <label id="repassword">비밀번호 재확인
                <input type="password" id="reloginpw"></label>
                <div class="check_repass">필수 입력 사항입니다.</div>
                <label id="user_nickname">닉네임
                <input type="text" name="user_nickname"></label>
                <div class="check_nick"></div>
                <label name="user_name">이름
                <input type="text" id="user_name" name="user_name"></label>
                <div name="user_year">연령대</div>
                <div class="check_year">필수 입력 사항입니다.</div>
                <div class="user_year" name="user_year">
                    <label><input type="radio" name="user_year" value="70">70년대</label>
                    <label><input type="radio" name="user_year" value="80">80년대</label>
                    <label><input type="radio" name="user_year" value="90">90년대</label>
                    <label><input type="radio" name="user_year" value="00">00년대</label>
                </div>

            </div>
            <button id="join">회원가입</button>
        </form>

    </div>

    <div class="bg">
        <div class="icon"></div>
        <div class="text">Latte is...</div>
    </div>

</div>
</body>
<script>
    // 회원가입 폼 검증
    $(document).ready(function () {
        //입력값 검증 정규표현식
        const getIdCheck = RegExp(/^[a-zA-Z0-9]{4,14}$/);
        const getPwCheck = RegExp(
            /([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
        const getName = RegExp(/^[가-힣]+$/);
        const getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);

        // 입력값 검증 배열
        // 1: 아이디,  2: 비번, 3: 비번확인, 4: 이름, 5: 이메일
        const checkArr = [false, false, false, false, false];

        // 1. 아이디 검증
        const $idInput = $('#loginid');

        $idInput.on('keyup', e => {

            // 아이디를 입력하지 않은 경우
            if ($idInput.val().trim() === '') {
                $idInput.css('border-color', 'red');
                $('.check_email').textContent='아이디를 입력해주세요';
                checkArr[0] = false;
            }

                // 아이디를 패턴에 맞지 않게 입력하였을 경우
                // test() 메서드는 정규표현식을 검증하여 입력값이 표현식과
            // 일치하면 true, 일치하지 않으면 false를 리턴
            else if (!getIdCheck.test($idInput.val())) {
                $idInput.css('border-color', 'red');
                $('.check_email').textContent='영문, 숫자로 4~14자 사이로 작성하세요!';
                checkArr[0] = false;
            }

            // 아이디 중복 확인 검증
            else {

                fetch('/member/check?type=account&value=' + $idInput.val())
                    .then(res => res.text())
                    .then(flag => {
                        console.log('flag:', flag);
                        if (flag === 'true') {
                            $idInput.css('border-color', 'red');
                            $('#idChk').html('<b class="c-red">[중복된 아이디입니다.]</b>');
                            checkArr[0] = false;
                        } else {
                            // 정상적으로 입력한 경우
                            $idInput.css('border-color', 'skyblue');
                            $('#idChk').html('<b class="c-blue">[사용가능한 아이디입니다.]</b>');
                            checkArr[0] = true;
                        }
                    });

            }

        }); //end id check event

        //2. 패스워드 입력값 검증.
        $('#password').on('keyup', function () {
            //비밀번호 공백 확인
            if ($("#password").val() === "") {
                $('#password').css('border-color', 'red');
                $('#pwChk').html('<b class="c-red">[패스워드는 필수정보!]</b>');
                checkArr[1] = false;
            }
            //비밀번호 유효성검사
            else if (!getPwCheck.test($("#password").val()) || $("#password").val().length < 8) {
                $('#password').css('border-color', 'red');
                $('#pwChk').html('<b class="c-red">[특수문자 포함 8자이상]</b>');
                checkArr[1] = false;
            } else {
                $('#password').css('border-color', 'skyblue');
                $('#pwChk').html('<b class="c-blue">[참 잘했어요]</b>');
                checkArr[1] = true;
            }

        });

        //패스워드 확인란 입력값 검증.
        $('#password_check').on('keyup', function () {
            //비밀번호 확인란 공백 확인
            if ($("#password_check").val() === "") {
                $('#password_check').css('border-color', 'red');
                $('#pwChk2').html('<b class="c-red">[패스워드확인은 필수정보!]</b>');
                checkArr[2] = false;
            }
            //비밀번호 확인란 유효성검사
            else if ($("#password").val() !== $("#password_check").val()) {
                $('#password_check').css('border-color', 'red');
                $('#pwChk2').html('<b class="c-red">[위에랑 똑같이!!]</b>');
                checkArr[2] = false;
            } else {
                $('#password_check').css('border-color', 'skyblue');
                $('#pwChk2').html('<b class="c-blue">[참 잘했어요]</b>');
                checkArr[2] = true;
            }

        });

        //이름 입력값 검증.
        $('#user_name').on('keyup', function () {
            //이름값 공백 확인
            if ($("#user_name").val() === "") {
                $('#user_name').css('border-color', 'red');
                $('#nameChk').html('<b class="c-red">[이름은 필수정보!]</b>');
                checkArr[3] = false;
            }
            //이름값 유효성검사
            else if (!getName.test($("#user_name").val())) {
                $('#user_name').css('border-color', 'red');
                $('#nameChk').html('<b class="c-red">[이름은 한글로 ~]</b>');
                checkArr[3] = false;
            } else {
                $('#user_name').css('border-color', 'skyblue');
                $('#nameChk').html('<b class="c-blue">[참 잘했어요]</b>');
                checkArr[3] = true;
            }

        });

        //이메일 입력값 검증.
        const $emailInput = $('#user_email');
        $emailInput.on('keyup', function () {
            //이메일값 공백 확인
            if ($emailInput.val() == "") {
                $emailInput.css('border-color', 'red');
                $('#emailChk').html('<b class="c-red">[이메일은 필수정보에요!]</b>');
                checkArr[4] = false;
            }
            //이메일값 유효성검사
            else if (!getMail.test($emailInput.val())) {
                $emailInput.css('border-color', 'red');
                $('#emailChk').html('<b class="c-red">[이메일 형식 몰라?]</b>');
                checkArr[4] = false;
            } else {

                //이메일 중복확인 비동기 통신
                fetch('/member/check?type=email&value=' + $emailInput.val())
                    .then(res => res.text())
                    .then(flag => {
                        //console.log(flag);
                        if (flag === 'true') {
                            $emailInput.css('border-color', 'red');
                            $('#emailChk').html(
                                '<b class="c-red">[이메일이 중복되었습니다!]</b>');
                            checkArr[4] = false;
                        } else {
                            $emailInput.css('border-color', 'skyblue');
                            $('#emailChk').html(
                                '<b class="c-blue">[사용가능한 이메일입니다.]</b>'
                            );
                            checkArr[4] = true;
                        }
                    });
            }

        });


        // 회원가입 양식 서버로 전송하는 클릭 이벤트
        const $form = $('#joinForm');

        $('#join').on('click', e => {

            if (!checkArr.includes(false)) {
                $form.submit();
            } else {
                alert('입력란을 다시 확인하세요!');
            }
        });



    }); // end jQuery
</script>
</html>
