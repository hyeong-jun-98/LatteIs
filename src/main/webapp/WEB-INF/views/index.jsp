<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메인페이지</title>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- Core theme CSS (includes Bootstrap)-->
    <%--    <link href="/css/topbar.css" rel="stylesheet"/>--%>

    <%--  topbar  --%>
    <link href="/css/index.css" rel="stylesheet">
    <link href="/css/topbar.css" rel="stylesheet">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />

    <%--    <link rel="stylesheet" href="css/animations.css">--%>

</head>
<body>
<div class="wrapper">
    <%@include file="topbar.jsp" %>

<div class="main">
    <div class="title animate__animated animate__fadeInDown">
        Latte is...
    </div>
    <div class="today">
        <div class="keyword">
            <a>
                <div>오늘의 키워드</div>
                <div>${topicName}</div>
            </a>
            <div></div>
        </div>
        <div id="bestDiary" data-diary-num="${dBOne.diaryNo}">
            <a href="#" style="color: black">
                <div>
                    <div>베스트 일기</div>
                    <div>${dBOne.userNickname}</div>
                    <div>${dBOne.prettierDate}</div>
                    <div>좋아요 : ${dBOne.diaryGood}</div>
                    <div>조회수 : ${dBOne.diaryHit}</div>
                </div>
                <div>
                    <div>오늘의 기분 : ${dBOne.emotion}</div>
                    <div>${dBOne.diaryContent}</div>
                </div>
            </a>
            <div></div>
        </div>

            <div id="board">
                <div>베스트 게시글</div>
                <div>
                    <div>
                        <div>키워드 게시판(All)</div>
                        <div id="tokey">${bk.content}</div>
                        <div>좋아요 ${bk.goodCount}</div>
                        <div>댓글 <c:if test="${bk.commentCount == null}">0</c:if><c:if
                                test="${bk.commentCount != null}">${bk.commentCount}</c:if></div>
                    </div>
                    <div>
                        <div>연령대 게시판(00)</div>
                        <div id="to00">${b00.content}</div>
                        <div>좋아요 ${b00.goodCount}</div>
                        <div>댓글 <c:if test="${b00.commentCount == null}">0</c:if><c:if
                                test="${b00.commentCount != null}">${b00.commentCount}</c:if></div>
                    </div>
                    <div>
                        <div>연령대 게시판(90)</div>
                        <div id="to90">${b90.content}</div>
                        <div>좋아요 ${b90.goodCount}</div>
                        <div>댓글 <c:if test="${b90.commentCount == null}">0</c:if><c:if
                                test="${b90.commentCount != null}">${b90.commentCount}</c:if></div>
                    </div>
                    <div>
                        <div>연령대 게시판(80)</div>
                        <div id="to80">${b80.content}</div>
                        <div>좋아요 ${b80.goodCount}</div>
                        <div>댓글 <c:if test="${b80.commentCount == null}">0</c:if><c:if
                                test="${b80.commentCount != null}">${b80.commentCount}</c:if></div>
                    </div>
                    <div>
                        <div>연령대 게시판(70)</div>
                        <div id="to70">${b70.content}</div>
                        <div>좋아요 ${b70.goodCount}</div>
                        <div>댓글 <c:if test="${b70.commentCount == null}">0</c:if><c:if
                                test="${b70.commentCount != null}">${b70.commentCount}</c:if></div>
                    </div>
                    <div>
                        <div>자유 게시판(All)</div>
                        <div id="tofree">${bf.content}</div>
                        <div>좋아요 ${bf.goodCount}</div>
                        <div>댓글 <c:if test="${bf.commentCount == null}">0</c:if><c:if
                                test="${bf.commentCount != null}">${bf.commentCount}</c:if></div>
                    </div>
                </div>
            </div>
        </div>
        <div class="keyword_main">
            <div class="keyword_content">
                <div class="keyword_picture">
                    <div id="keyp1" class="keySlides"></div>
                    <div id="keyp2" class="keySlides"></div>
                    <div id="keyp3" class="keySlides"></div>
                    <a class="prev">❮</a>
                    <a class="next">❯</a>
                </div>
                <div class="keyword_describe">
                    <div>
                        추억의 키워드로 자신의 추억을 공유해보세요!
                    </div>
                    <div>
                        불량식품, 게임 등등 매일 새롭게 정해지는 추억의 키워드를 통해 다른 사용자들과 추억을 공유해보세요!
                    </div>
                </div>
            </div>
        </div>
        <div class="age_main">
            <div class="age_content">
                <div class="age_describe">
                    <div>
                        세대별로 추억을 공유해보세요!
                    </div>
                    <div>
                        70,80,90,00년대별로 나눠진 게시판에서 자신 세대의 추억을 다른 사용자들과 공유해보세요!
                    </div>
                </div>
                <div class="age_picture">
                    <div id="agep1" class="ageSlides"></div>
                    <div id="agep2" class="ageSlides"></div>

                    <a class="prev">❮</a>
                    <a class="next">❯</a>
                </div>
            </div>
        </div>
        <div class="quiz_main">
            <div class="quiz_content">
                <div class="quiz_picture">
                    <div id="quizp1" class="quizSlides"></div>
                    <div id="quizp2" class="quizSlides"></div>
                    <div id="quizp3" class="quizSlides"></div>
                    <a class="prev">❮</a>
                    <a class="next">❯</a>
                </div>
                <div class="quiz_describe">
                    <div>
                        그림 퀴즈를 즐겨보세요!
                    </div>
                    <div>
                        본인이 그린 그림을 문제로 내고 다른 사람의 그림 문제도 맞춰보세요!
                    </div>
                </div>
            </div>
        </div>
        <div class="diary_main">
            <div class="diary_content">
                <div class="diary_describe">
                    <div>
                        새로운 추억을 만들어보세요!
                    </div>
                    <div>
                        짧은 일기들로 자신만의 새로운 추억을 기록하고 공유하세요!
                    </div>
                </div>
                <div class="diary_picture">
                    <div id="diaryp1" class="diarySlides"></div>
                    <div id="diaryp2" class="diarySlides"></div>
                    <div id="diaryp3" class="diarySlides"></div>
                    <div id="diaryp4" class="diarySlides"></div>
                    <a class="prev">❮</a>
                    <a class="next">❯</a>
                </div>
            </div>
        </div>
    </div>

</div>
</body>
<script>
    let keySlideIndex = 1;
    let ageSlideIndex = 1;
    let quizSlideIndex = 1;
    let diarySlideIndex = 1;

    const $todiary = document.getElementById("bestDiary");
    $todiary.onclick = e => {
        location.href = "/diary/list";
    };

    // showSlides(keySlideIndex);

    // Next/previous controls
    function minusKeySlides() {
        const $prev = document.querySelector(".keyword_picture").querySelector(".prev");
        $prev.onclick = e =>{
            e.stopPropagation();
            showKeySlides(keySlideIndex += -1);

            document.getElementById("keyp" + keySlideIndex).className = 'keySlides animate__animated animate__fadeInLeft';

        }

    }
    function plusKeySlides() {
        const $next = document.querySelector(".keyword_picture").querySelector(".next");
        $next.onclick = e =>{
            e.stopPropagation();
            showKeySlides(keySlideIndex += +1);
            document.getElementById("keyp" + keySlideIndex).className = 'keySlides animate__animated animate__fadeInRight';
        }
    }


    function showKeySlides(n) {
        let i;
        let slides;
        slides = document.getElementsByClassName("keySlides");
        if (n > slides.length) {
            keySlideIndex = 1
        }
        if (n < 1) {
            keySlideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[keySlideIndex - 1].style.display = "block";
    }

    function minusAgeSlides() {
        const $prev = document.querySelector(".age_picture").querySelector(".prev");
        console.log($prev);
        $prev.onclick = e =>{
            e.stopPropagation();
            showAgeSlides(ageSlideIndex += -1);

            document.getElementById("agep" + ageSlideIndex).className = 'ageSlides animate__animated animate__fadeInLeft';

        }

    }
    function plusAgeSlides() {
        const $next = document.querySelector(".age_picture").querySelector(".next");
        $next.onclick = e =>{
            e.stopPropagation();
            showAgeSlides(ageSlideIndex += 1);
            document.getElementById("agep" + ageSlideIndex).className = 'ageSlides animate__animated animate__fadeInRight';
        }
    }

    function showAgeSlides(n) {
        let i;
        let slides;
        slides = document.getElementsByClassName("ageSlides");
        if (n > slides.length) {
            ageSlideIndex = 1
        }
        if (n < 1) {
            ageSlideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[ageSlideIndex - 1].style.display = "block";
    }

    function minusQuizSlides() {
        const $prev = document.querySelector(".quiz_picture").querySelector(".prev");
        $prev.onclick = e =>{
            e.stopPropagation();
            showQuizSlides(quizSlideIndex += -1);

            document.getElementById("quizp" + quizSlideIndex).className = 'quizSlides animate__animated animate__fadeInLeft';

        }

    }
    function plusQuizSlides() {
        const $next = document.querySelector(".quiz_picture").querySelector(".next");
        $next.onclick = e =>{
            e.stopPropagation();
            showQuizSlides(quizSlideIndex += 1);
            document.getElementById("quizp" + quizSlideIndex).className = 'quizSlides animate__animated animate__fadeInRight';
        }
    }

    function showQuizSlides(n) {
        let i;
        let slides;
        slides = document.getElementsByClassName("quizSlides");
        if (n > slides.length) {
            quizSlideIndex = 1
        }
        if (n < 1) {
            quizSlideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[quizSlideIndex - 1].style.display = "block";
    }

    function minusDiarySlides() {
        const $prev = document.querySelector(".diary_picture").querySelector(".prev");
        $prev.onclick = e =>{
            e.stopPropagation();
            showDiarySlides(diarySlideIndex += -1);

            document.getElementById("diaryp" + diarySlideIndex).className = 'diarySlides animate__animated animate__fadeInLeft';

        }

    }
    function plusDiarySlides() {
        const $next = document.querySelector(".diary_picture").querySelector(".next");
        $next.onclick = e =>{
            e.stopPropagation();
            showDiarySlides(diarySlideIndex += 1);
            document.getElementById("diaryp" + diarySlideIndex).className = 'diarySlides animate__animated animate__fadeInRight';
        }
    }

    function showDiarySlides(n) {
        let i;
        let slides;
        slides = document.getElementsByClassName("diarySlides");
        if (n > slides.length) {
            diarySlideIndex = 1
        }
        if (n < 1) {
            diarySlideIndex = slides.length
        }
        for (i = 0; i < slides.length; i++) {
            slides[i].style.display = "none";
        }
        slides[diarySlideIndex - 1].style.display = "block";
    }

    // Thumbnail image controls
    // function currentSlide(n) {
    //     showSlides(keySlideIndex = n);
    // }

    // function showSlides(n){
    //     let i;
    //     let slides;
    //     slides = document.getElementsByClassName("keySlides");
    //     if (n > slides.length) {keySlideIndex = 1}
    //     if (n < 1) {keySlideIndex = slides.length}
    //     for (i = 0; i < slides.length; i++) {
    //         slides[i].style.display = "none";
    //     }
    //     slides[keySlideIndex-1].style.display = "block";
    // }

    function toHotBoard() {
        const $tokey = document.getElementById("tokey");
        $tokey.onclick = e => {
            location.href = "/keyword/detail/" + '${bk.boardNo}'
        }
        const $to00 = document.getElementById("to00");
        $to00.onclick = e => {
            location.href = "/generation/detail/" + '${b00.boardNo}'
        }
        const $to90 = document.getElementById("to90");
        $to90.onclick = e => {
            location.href = "/generation/detail/" + '${b90.boardNo}'
        }
        const $to80 = document.getElementById("to80");
        $to80.onclick = e => {
            location.href = "/generation/detail/" + '${b80.boardNo}'
        }
        const $to70 = document.getElementById("to70");
        $to70.onclick = e => {
            location.href = "/generation/detail/" + '${b70.boardNo}'
        }
        const $tofree = document.getElementById("tofree");
        $tofree.onclick = e => {
            location.href = "/freeboard/detail/" + '${bf.boardNo}'
        }
    }

    // 자세히 보기
    function detailEvent() {
        const $table = document.getElementById("bestDiary");
        $table.addEventListener('click', e => {
            //     // console.log(e.target);


            location.href = '/diary/detail/' + '${dBOne.diaryNo}';

            //     if(!e.target.matches('#bestDiary *')){
            //         // console.log('게시글 내부');
            //         return;
            //     }
            //
            //     const $targetDiv = e.target.closest('#bestDiary');
            //     console.log($targetDiv);
            //
            //     let diaryNo = $targetDiv.dataset.diaryNum;
            //     console.log('글 번호 : ' + diaryNo);


            // })/

        })
    }



    (function () {
        detailEvent();
        toHotBoard();
        plusKeySlides();
        minusKeySlides();
        plusAgeSlides();
        minusAgeSlides();
        plusQuizSlides();
        minusQuizSlides();
        plusDiarySlides();
        minusDiarySlides();
    })();


</script>

</html>
