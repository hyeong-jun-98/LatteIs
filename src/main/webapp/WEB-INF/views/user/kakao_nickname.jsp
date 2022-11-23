<%--
  Created by IntelliJ IDEA.
  User: hojong
  Date: 2022-11-16
  Time: 오후 5:37
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
      height: 400px;
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
</head>
<body>
<div class="login_wrapper">
  <div class="login_form">
    <form id="joinForm" action="/kakaonickname" method="post">
      <h1>추가 정보를 입력해주세요</h1>
      <div class="input">
        <label id="user_nickname">닉네임
          <input type="text" id="nickname" name="userNickname"></label>
        <span class="check_nickname"></span>
        <div name="user_year">연령대</div>
        <div class="check_year"></div>
        <div class="user_year" name="userYear">
          <label><input type="radio" name="userYear" value="70">70년대</label>
          <label><input type="radio" name="userYear" value="80">80년대</label>
          <label><input type="radio" name="userYear" value="90">90년대</label>
          <label><input type="radio" name="userYear" value="00">00년대</label>
        </div>

      </div>
      <button id="join" type="button">확인</button>
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

    // 입력값 검증 배열
    // 1: 닉네임,  2: 연령
    const checkArr = [false, false];

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

        fetch('/user/check?loginType=kakao&type=user_nickname&value=' + $idInput.val())
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

    // 라디오버튼에 change이벤트
    const $radio = $('.user_year');
    $radio.on('change', e => {
      const $userYear = $('input[name=userYear]:radio:checked');
      console.log($userYear.length);
      if($userYear.length<1){
        $('.check_year').html('<b class="c-red">연령 정보는 필수 정보입니다.</b>');
        checkArr[1] = false;
      }else{
        $('.check_year').html('<b class="c-green">잘 했어요!</b>');
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
