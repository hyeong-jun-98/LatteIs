<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<%--    <%@ include file="../include/static-head.jsp" %>--%>

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

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <!-- custom css -->
    <link rel="stylesheet" href="/css/main-write.css">
    <link rel="stylesheet" href="/css/custom-write.css">
</head>

<body>
<div class="wrap">
<%--    <%@ include file="../include/header.jsp" %>--%>

    <div class="write-container">

        <form id="write-form" action="/diary/write" method="post">


            <div>
                <h1 class="today-diary">오늘의 일기</h1>
            </div>

            <div class="mb-3">
                <select name="emotion" id="emotion-input">
                    <option value="">오늘의 기분</option>
                    <option value="좋음">좋음</option>
                    <option value="보통">보통</option>
                    <option value="슬픔">슬픔</option>
                    <option value="근심/걱정">근심/걱정</option>
                </select>
            </div>

            <div class="mb-3">
                <select name="diaryShow" id="show-input">
                    <option value="">공개여부</option>
                    <option value="비공개">비공개</option>
                    <option value="공개">공개</option>

                </select>
            </div>
            <div class="mb-3">
                <textarea name="diaryContent" class="form-control" id="exampleFormControlTextarea1" rows="10" placeholder="내용"></textarea>
            </div>
            <div id="test_cnt">(0 / 100)</div>

            <div class="d-grid gap-2">
                <button id="reg-btn" class="btn btn-dark custom-button" type="button">일기 작성</button>
                <button id="to-list" class="btn btn-warning custom-button" type="button">목록</button>
            </div>

        </form>

    </div>

<%--    <%@ include file="../include/footer.jsp" %>--%>



</div>


<script>

/*
    // 게시물 등록 입력값 검증 함수
    function validateFormValue() {
        // 이름입력태그, 제목 입력태그

        const $emotionInput = document.getElementById('emotion-input');
        let flag = false; // 입력 제대로하면 true로 변경


        console.log('t: ', $emotionInput.value);

        if ($emotionInput.value.trim() === '') {
            alert('감정은 필수값입니다~');
        } else {
            flag = true;
        }

        console.log('flag:', flag);

        return flag;

    }
*/
    // 글자 수 체크 and 제한
    $(document).ready(function() {
        $('#exampleFormControlTextarea1').on('keyup', function() {
            $('#test_cnt').html("(" + $(this).val().length +" / 100)");

            if($(this).val().length > 100) {
                $(this).val($(this).val().substring(0,100));
                $('#test_cnt').html("(100 / 100)");
            }
        })
    })



    // 게시물 입력값 검증
    const $regBtn = document.getElementById('reg-btn');

    $regBtn.onclick = e => {
        // 필수 입력값을 잘 채웠으면 폼을 서브밋한다.
        const $form = document.getElementById('write-form');

        if($('#emotion-input').val() === '') {
            alert('오늘의 감정을 알려주세요');
        } else if($('#show-input').val() === '') {
            alert('공개인지 비공개인지 알려주세요');
        } else if($('#exampleFormControlTextarea1').val() === '') {
            alert('자세한 일기를 써주세요');
        } else {
            $form.submit();
        }


    };


    //목록버튼 이벤트
    const $toList = document.getElementById('to-list');
    $toList.onclick = e => {
        location.href = '/diary/list';
    };


</script>





</body>

</html>