<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="topbar">
    <div class="icon-wrapper" id="home" style="cursor: pointer">
        <div class="icon">

        </div>
        <div class="icon-text">
            Latte is...
        </div>
    </div>
    <div class="category" style="cursor: pointer">
        <div id="img">
        </div>
        <div id="fiximg">
        </div>
        <div id="keyword">
            오늘의 키워드
        </div>

        <div id="generation">
            연령대별 추억 공유
            <a href="#" id="2000">2000년대 게시판</a>
            <a href="#" id="1990">1990년대 게시판</a>
            <a href="#" id="1980">1980년대 게시판</a>
            <a href="#" id="1970">1970년대 게시판</a>
        </div>

        <div id="list">
            자유게시판
        </div>

        <div id="game">
            스무고개
        </div>

        <div id="diary">
            나의 한 줄 일기
        </div>
    </div>
    <c:if test="${loginUser == null}">
        <div class="login" id="tologin" style="cursor: pointer">로그인/회원가입</div>
    </c:if>
    <c:if test="${loginUser != null}">
        <div class="nickname" style="cursor: pointer">
            <div id="tomypage">${loginUser.userNickname}</div>
            <div id="logout">/로그아웃</div>
        </div>
    </c:if>
</div>
<script>
    //페이지에 해당하는 탑바 색 바꾸기
    function changeFont() {
        var page = "${page}";
        const $pencil = document.getElementById("fiximg");
        if (page != null) {
            switch (page) {
                case 'diary':
                    document.getElementById('diary').style.color = "white";
                    $pencil.style.left = "1355px";
                    $pencil.style.display = "block";
                    // document.getElementById('diary').style.background="rgba(0,0,0,0.3)";
                    break;
                case 'free':
                    document.getElementById('list').style.color = "white";
                    $pencil.style.left = "860px";
                    $pencil.style.display = "block";
                    // document.getElementById('list').style.background="rgba(0,0,0,0.3)";
                    break;
            }
        }
    }

    //홈으로 이동
    function toHome() {
        const $toHome = document.getElementById('home');
        $toHome.onclick = e => {
            location.href = "/";
        }
    }

    // 전체 연령대별  게시판 이동
    function toGenerationList() {
        const $generation = document.getElementById('generation');
        $generation.onclick = e => {
            if (!e.target.matches('div')) return;    // div일때만 전체 리스트로..
            location.href = '/generation/list?generation=9999';
        }
    }
    // 00년대 게시판 이동
    function to00List(){
        const $2000 = document.getElementById('2000');
        $2000.onclick = e =>{
            location.href='/generation/list?generation=2000';
        }
    }
    // 90년대 게시판 이동
    function to90List(){
        const $1990 = document.getElementById('1990');
        $1990.onclick = e =>{
            location.href='/generation/list?generation=1990';
        }
    }
    // 80년대 게시판 이동
    function to80List(){
        const $1980 = document.getElementById('1980');
        $1980.onclick = e =>{
            location.href='/generation/list?generation=1980';
        }
    }
    // 70년대 게시판 이동
    function to70List(){
        const $1970 = document.getElementById('1970');
        $1970.onclick = e =>{
            location.href='/generation/list?generation=1970';
        }
    }

    // 목록으로 가지
    function toList() {
        // 목록 버튼
        const $toList = document.getElementById('list');
        $toList.onclick = e => {
            location.href = "/freeboard/list";
        }

    }

    function toDiary() {
        const $toDiary = document.getElementById('diary');
        $toDiary.onclick = e => {
            location.href = "/diary/list";
        }
    }

    function toLogin() {
        const $toLogin = document.getElementById("tologin");
        $toLogin.onclick = e => {
            location.href = "/user/login";
        }
    }

    function logout() {
        const $logout = document.getElementById("logout");
        $logout.onclick = e => {
            location.href = "/user/logout";
        }
    }

    function hover() {
        const $keyword = document.getElementById("keyword");
        const $generation = document.getElementById("generation");
        const $list = document.getElementById("list");
        const $game = document.getElementById("game");
        const $diary = document.getElementById("diary");
        const $pencil = document.getElementById("img");
        $keyword.onmouseenter = e => {
            $pencil.style.left = "325px";
            $pencil.style.display = "block";
        }
        $keyword.onmouseout = e => {
            $pencil.style.display = "none";
        }
        $generation.onmouseenter = e => {
            $pencil.style.left = "565px";
            $pencil.style.display = "block";
        }
        $generation.onmouseout = e => {
            $pencil.style.display = "none";
        }
        $list.onmouseenter = e => {
            $pencil.style.left = "860px";
            $pencil.style.display = "block";
        }
        $list.onmouseout = e => {
            $pencil.style.display = "none";
        }
        $game.onmouseenter = e => {
            $pencil.style.left = "1135px";
            $pencil.style.display = "block";
        }
        $game.onmouseout = e => {
            $pencil.style.display = "none";
        }
        $diary.onmouseenter = e => {
            $pencil.style.left = "1355px";
            $pencil.style.display = "block";
        }
        $diary.onmouseout = e => {
            $pencil.style.display = "none";
        }
    }

    (function () {
        changeFont();
        hover();
        toGenerationList();
        to00List(); // 00년대 게시판으로
        to90List(); // 90년대 게시판으로
        to80List(); // 80년대 게시판으로
        to70List(); // 70년대 게시판으로
        toList();
        toDiary();
        <c:if test="${loginUser == null}">
        toLogin();
        </c:if>
        <c:if test="${loginUser != null}">
        logout();
        </c:if>
        toHome();
    })();
</script>