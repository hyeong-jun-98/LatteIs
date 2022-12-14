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
    <meta name="viewport" content="width=device-width; initial-scale=1">
</head>

<body>
<div class="wrap">
<%--    <%@ include file="../include/header.jsp" %>--%>

    <div class="write-container">

        <form id="write-form" action="/diary/write" method="post" class="form-size">


            <div>
                <h1 class="today-diary">????????? ??????</h1>
            </div>

            <div class="mb-3">
                <select name="emotion" id="emotion-input">
                    <option value="">????????? ??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????">??????</option>
                    <option value="??????/??????">??????/??????</option>
                </select>
            </div>

            <div class="mb-3">
                <select name="diaryShow" id="show-input">
                    <option value="">????????????</option>
                    <option value="?????????">?????????</option>
                    <option value="??????">??????</option>

                </select>
            </div>
            <div class="mb-3">
                <textarea name="diaryContent" class="form-control" id="exampleFormControlTextarea1" rows="10" placeholder="??????"></textarea>
            </div>
            <div id="test_cnt">(0 / 100)</div>

            <div class="d-grid gap-2 mt-5">
                <button id="reg-btn" class="btn btn-dark custom-button" type="button">?????? ??????</button>
                <button id="to-list" class="btn btn-warning custom-button" type="button">??????</button>
            </div>

        </form>

    </div>

<%--    <%@ include file="../include/footer.jsp" %>--%>



</div>


<script>

/*
    // ????????? ?????? ????????? ?????? ??????
    function validateFormValue() {
        // ??????????????????, ?????? ????????????

        const $emotionInput = document.getElementById('emotion-input');
        let flag = false; // ?????? ??????????????? true??? ??????


        console.log('t: ', $emotionInput.value);

        if ($emotionInput.value.trim() === '') {
            alert('????????? ??????????????????~');
        } else {
            flag = true;
        }

        console.log('flag:', flag);

        return flag;

    }
*/
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



    // ????????? ????????? ??????
    const $regBtn = document.getElementById('reg-btn');

    $regBtn.onclick = e => {
        // ?????? ???????????? ??? ???????????? ?????? ???????????????.
        const $form = document.getElementById('write-form');

        if($('#emotion-input').val() === '') {
            alert('????????? ????????? ???????????????');

        } else if($('#show-input').val() === '') {
            alert('???????????? ??????????????? ???????????????');
        } else if($('#exampleFormControlTextarea1').val() === '') {
            alert('????????? ????????? ????????????');
        } else {
            $form.submit();
        }


    };


    //???????????? ?????????
    const $toList = document.getElementById('to-list');
    $toList.onclick = e => {
        location.href = '/diary/list';
    };


</script>





</body>

</html>