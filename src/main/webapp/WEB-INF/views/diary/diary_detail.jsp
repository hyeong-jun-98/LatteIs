<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link href="/css/topbar.css" rel="stylesheet">
    <meta name="viewport" content="width=device-width, initial-scale=1">
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


        <form id="write-form" class="custom-write" action="/diary/write" method="post" autocomplete="off" enctype="multipart/form-data">

            <input type="hidden" name="diaryNo" id="diaryNo" value="${d.diaryNo}">

<%--            <input type="hidden" name="userNo" id="userNo" value="${loginUser.userNo}">--%>

            <div class="detail_div">
                <h1 class="today-diary">${d.userNickname}??? ??????</h1>
                <div class="badge badge-primary custom-emotion">${d.emotion}</div>
                <div class="badge badge-primary custom-show">${d.diaryShow}</div>
                <div class="badge badge-primary custom-good" id="diaryGood">????????? : ${d.diaryGood}</div>
                <div class="badge badge-primary custom-good">????????? : ${d.diaryHit}</div>
                <c:if test="${user.userNickname != null}">
                <div class="good-part">
                    <%--       false ??? ???       --%>
<%--                    <c:if test="${!goodCheckCT}">--%>
                    <button type="button" id="btnGoodTrue" class="badge badge-primary custom-good-bt text-right">?????????</button>
<%--                    </c:if>--%>
                            <%--      true??? ???        --%>
<%--                    <c:if test="${goodCheckCT}">--%>
                    <button type="button" id="btnGoodFalse" class="badge badge-primary custom-good-bt text-right" >???????????????</button>
<%--                        onclick="location.href='/diary/goodCheck?diaryNo=${d.diaryNo}' "--%>
<%--                    </c:if>--%>
                </div>
                </c:if>
            </div>


<%--            <div class="mb-3 custom-emotion">--%>
<%--                <select name="emotion" id="emotion-input">--%>
<%--                    <option value="">${d.emotion}</option>--%>
<%--                </select>--%>
<%--            </div>--%>

<%--            <div class="mb-3">--%>
<%--                <select name="diaryShow" id="show-input">--%>
<%--                    <option value="">${d.diaryShow}</option>--%>
<%--                </select>--%>
<%--            </div>--%>

            <div class="mb-3">
                <textarea name="diaryContent" class="form-control" id="exampleFormControlTextarea1" rows="10" readonly>${d.diaryContent}</textarea>
            </div>



            <div class="d-grid gap-2 btn-list">
                <button id="to-list" class="btn btn-warning custom-button" type="button">??????</button>
                <c:if test="${user.userNickname == d.userNickname || user.auth == 'ADMIN'}">
                    <button id="btn-update" class="btn btn-warning custom-button" type="button">??????</button>
                    <button id="btn-delete" class="btn btn-warning custom-button" type="button">??????</button>
                </c:if>
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
    // ????????? ????????? ??????
    // const $regBtn = document.getElementById('reg-btn');
    //
    // $regBtn.onclick = e => {
    //     // ?????? ???????????? ??? ???????????? ?????? ???????????????.
    //     const $form = document.getElementById('write-form');
    //     $form.submit();
    // };


    //???????????? ?????????
    const $toList = document.getElementById('to-list');
    $toList.onclick = e => {
        location.href = '/diary/list';
    }

    if (${loginUser.userNickname == d.userNickname || loginUser.auth == 'ADMIN'}) {
        // ??????
        const $update = document.getElementById('btn-update');

        if($update !== null) {

            $update.onclick = e => {


                location.href = '/diary/modify?diaryNo=${d.diaryNo}';
            };
        }
    }
    // ??????
    if(${user.userNickname == d.userNickname || user.auth == 'ADMIN'}){
    const $delete = document.getElementById('btn-delete');
    $delete.onclick = e => {
        if(!confirm('????????? ????????????? ??????..? ????????????....')) {
            return;
        }
        location.href = '/diary/delete?diaryNo=${diaryNo}';
        };
    }

    // ??????
    $("#btnGoodTrue").click(function () {
            like_func();
    })

    $("#btnGoodFalse").click(function () {
            like_func();
    })

    let check = false;
    // ????????? ?????? ?????????!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    function like_func() {

        fetch("/api/v1/diaryGood/${d.diaryNo}")
            .then(res => res.text())
            .then(flag =>{
                console.log('flag : ', flag);
                let jsonObj = JSON.parse(flag);
                let totalGoodCount = jsonObj.totalGoodCount;
                console.log('count : ', totalGoodCount);



                if(check) {
                    // true
                    document.getElementById('btnGoodTrue').style.display="inline";
                    document.getElementById('btnGoodFalse').style.display="none";
                    // document.getElementById('diaryGood').textContent =  totalGoodCount;
                    check = false;
                } else {
                    document.getElementById('btnGoodFalse').style.display="inline";
                    document.getElementById('btnGoodTrue').style.display="none";
                    // document.getElementById('diaryGood').textContent = totalGoodCount;
                    check = true;
                }

                document.getElementById('diaryGood').textContent = " ????????? : " + totalGoodCount;

            })

        <%--console.log("${goodCheck}");--%>
        // diaryNo.submit();


    }
    function detailGoodCheck() {
        if(${goodCheckCT}) {
            check = true;
            console.log(check);
            document.getElementById('btnGoodTrue').style.display="none";
            document.getElementById('btnGoodFalse').style.display="inline";

        } else {
            check = false;
            console.log(check);
            document.getElementById('btnGoodFalse').style.display="none";
            document.getElementById('btnGoodTrue').style.display="inline";
        }
    }

    (function () {
        detailGoodCheck();
    })();






</script>





</body>

</html>