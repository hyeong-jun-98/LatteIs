<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <link href="/css/topbar.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width; initial-scale=1">
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
        .form-control {
            height: 212px;
        }
        html > body {
            font-family: 'KyoboHand';
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
    <link href="/css/topbar.css" rel="stylesheet">
</head>

<body>
<%@include file="../topbar.jsp"%>
<div class="wrap custom-wrap">
    <%--    <%@ include file="../include/header.jsp" %>--%>
    <div class="write-container custom-container">

        <form id="write-form" action="/diary/modify" method="post" >
            <input type="hidden" name="diaryNo" value="${d.diaryNo}">


            <div>
                <h1 class="today-diary">${d.userNickname}??? ??????</h1>
            </div>

            <div class="mb-3">
                <select name="emotion" id="emotion-input">
<%--                    <option disabled>${d.emotion}</option/>--%>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????/??????">??????/??????</option>
                </select>
            </div>

            <div class="mb-3">
                <select name="diaryShow" id="show-input">
<%--                    <option value="" disabled>${d.diaryShow}</option>--%>
                    <option value="?????????">?????????</option>
                    <option value="??????">??????</option>

                </select>
            </div>
            <div class="mb-3">
                <textarea name="diaryContent" class="form-control" id="exampleFormControlTextarea1" rows="10" placeholder="??????" style="height: 210px">${d.diaryContent}</textarea>
            </div>
            <div id="test_cnt"></div>

            <div class="d-grid gap-2 btn-list">
                <button id="reg-btn" class="btn btn-dark custom-button" type="button">?????? ??????</button>
                <button id="to-list" class="btn btn-warning custom-button" type="button">??????</button>
            </div>

        </form>

    </div>

    <%--    <%@ include file="../include/footer.jsp" %>--%>
</div>
<script>

    const $regBtn = document.getElementById('reg-btn');

    $regBtn.onclick = e => {
        // ?????? ???????????? ??? ???????????? ?????? ???????????????.
        const $form = document.getElementById('write-form');

        if ($('#exampleFormControlTextarea1').val() === '') {
            alert('????????? ????????? ????????????');
        } else {
            $form.submit();
        }

    }





        // ?????? ??? ?????? and ??????
    $(document).ready(function() {
        $('#exampleFormControlTextarea1').on('keyup', function() {
            $('#test_cnt').html("(" + $(this).val().length +" / 100)");

            if($(this).val().length > 100) {
                $(this).val($(this).val().substring(0,100));
                $('#test_cnt').html("(100 / 100)");
            }


        })
    })

    //???????????? ?????????
    const $toList = document.getElementById('to-list');
    $toList.onclick = e => {
        location.href = '/diary/list';
    };


    const emotion = '${d.emotion}';
    const diaryShow = '${d.diaryShow}';


    function selectedOption() {
        const $select_emotion = document.querySelector('#emotion-input');
        const $select_show = document.querySelector('#show-input');
        console.log($select_emotion);
        console.log($select_show);

        // console.log($select.children)
        for (let $option of [...$select_emotion.children]) {
            if (emotion === $option.value){
                console.log($option.value);
                $option.setAttribute('selected', 'selected');
            }
        }
        for (let $option of [...$select_show.children]) {
            if (diaryShow === $option.value){
                console.log($option.value);
                $option.setAttribute('selected', 'selected');
            }
        }
    }

    (function () {
        selectedOption();
    })();



</script>

</body>

</html>