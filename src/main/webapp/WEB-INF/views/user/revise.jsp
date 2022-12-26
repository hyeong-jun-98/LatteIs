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
    <meta name="viewport" content="width=device-width; initial-scale=1">
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
        border-radius: 20px;
        background: white;
        margin-top: 200px;
        margin-bottom: 200px;
        padding: 40px;
    }
    .login_form{
        width: 80%;
        height: 40%;
        margin-left: 40px;
    }
    .login_form .input{
        font-size: 20px;
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
    @media screen and (max-width: 820px) {
        .login_wrapper{
            width: 100%;
            height: 1000px;
            margin: 0;
            border-radius: 0px;
        }
        body{
            margin: 0;
        }
        .login_form{
            margin-left: 0;
        }
        .login_form .join a{
            margin-left: 6px;
            width: 100%;
        }
        input:focus{
            outline: none;
        }
    }
</style>
</head>
<body>
<div class="login_wrapper">
    <div class="login_form">
        <form id="joinForm" action="/user/revise" method="post">
            <div class="input">
                <label id="user_nickname">닉네임
                <input type="text" id="nickname" name="userNickname" value="${loginUser.userNickname}"></label>
                <span class="check_nickname"></span>
                <label name="user_name">이름
                <input type="text" id="user_name" name="userName" value="${loginUser.userName}"></label>
                <span class="check_name"></span>
                <div name="user_year">연령대</div>
                <div class="user_year" name="userYear">
                    <label><input type="radio" name="userYear" value="70">70년대</label>
                    <label><input type="radio" name="userYear" value="80">80년대</label>
                    <label><input type="radio" name="userYear" value="90">90년대</label>
                    <label><input type="radio" name="userYear" value="00">00년대</label>
                </div>

            </div>
            <button id="join" type="button">정보수정</button>
        </form>

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

        //연대 체크
        const checkYear = [...document.querySelectorAll("[name=userYear]")];
        const year = '${loginUser.userYear}';
        switch (year){
            case "70":
                checkYear[1].setAttribute('checked', 'checked');
                break;
            case "80":
                checkYear[2].setAttribute('checked', 'checked');
                break;
            case "90":
                checkYear[3].setAttribute('checked', 'checked');
                break;
            case "00":
                checkYear[4].setAttribute('checked', 'checked');
                break;
        }

        // 입력값 검증 배열
        // 1: 닉네임, 2: 이름
        const checkArr = [true, true];

        // 1. 닉네임 검증
        const $idInput = $('#nickname');

        $idInput.on('keyup', e => {

            // 닉네임 입력하지 않은 경우
            if ($idInput.val().trim() === '') {
                $idInput.css('border-color', 'red');
                $('.check_nickname').html('<b class="c-red">닉네임은 필수 정보입니다.</b>');
                checkArr[0] = false;
            }

                // 닉네임 패턴에 맞지 않게 입력하였을 경우
                // test() 메서드는 정규표현식을 검증하여 입력값이 표현식과
            // 일치하면 true, 일치하지 않으면 false를 리턴
            else if (!getIdCheck.test($idInput.val())) {
                $idInput.css('border-color', 'red');
                $('.check_nickname').html('<b class="c-red">영문, 숫자로 4~14자 사이로 작성하세요!</b>');
                checkArr[0] = false;
            }

            // 닉네임 중복 확인 검증
            else {

                fetch('/user/check?loginType=latteis&type=user_nickname&value=' + $idInput.val())
                    .then(res => res.text())
                    .then(flag => {
                        console.log('flag:', flag);
                        if (flag === 'true') {
                            $idInput.css('border-color', 'red');
                            $('.check_nickname').html('<b class="c-red">중복된 닉네임입니다.</b>');
                            checkArr[0] = false;
                        } else {
                            // 정상적으로 입력한 경우
                            $idInput.css('border-color', 'green');
                            $('.check_nickname').html('<b class="c-green">사용가능한 닉네임입니다.</b>');
                            checkArr[0] = true;
                        }
                    });

            }

        }); //end id check event


        //이름 입력값 검증.
        $('#user_name').on('keyup', function () {
            //이름값 공백 확인
            if ($("#user_name").val() === "") {
                $('#user_name').css('border-color', 'red');
                $('.check_name').html('<b class="c-red">이름은 필수정보!</b>');
                checkArr[1] = false;
            }
            //이름값 유효성검사
            else if (!getName.test($("#user_name").val())) {
                $('#user_name').css('border-color', 'red');
                $('.check_name').html('<b class="c-red">이름은 한글로 ~</b>');
                checkArr[1] = false;
            } else {
                $('#user_name').css('border-color', 'green');
                $('.check_name').html('<b class="c-green">참 잘했어요</b>');
                checkArr[1] = true;
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
