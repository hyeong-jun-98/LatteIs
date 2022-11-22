<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="topbar">
    <div class="icon-wrapper" id="home" style="cursor: pointer">
        <div class="icon">

        </div>
        <div class="icon-text">
            Latte is...
        </div>
    </div>
    <div class="category" style="cursor: pointer" id="category">
        <div id="img">
        </div>
        <div id="fiximg">
        </div>
        <div id="keyword">
            오늘의 키워드
        </div>

        <div id="generationcate">
            <div id="generation">
                연령대별 추억 공유
            </div>
            <div id="subcatec">
                <div><span></span><div id="subc00">00년대</div></div>
                <div><span></span><div id="subc90">90년대</div></div>
                <div><span></span><div id="subc80">80년대</div></div>
                <div><span></span><div id="subc70">70년대</div></div>
            </div>
        </div>

        <div id="list">
            자유게시판
        </div>

        <div id="game">
            스무고개
        </div>
        <div id="diarycate">
            <div id="diary">
                일기
            </div>
            <div id="subcated">
                <div><span></span><div id="subd1">나의 일기</div></div>
                <div><span></span><div id="subd2">모두의 일기</div></div>
                <div><span></span><div id="subd3">베스트 일기</div></div>
            </div>
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

        var page = "${topbar}";
        console.log("페이지" + page);
        const $pencil = document.getElementById("fiximg");
        if (page != null) {
            switch (page) {
                case 'diary':
                    document.getElementById('diary').style.color = "white";
                    $pencil.style.left = "1440px";
                    $pencil.style.display = "block";
                    // document.getElementById('diary').style.background="rgba(0,0,0,0.3)";
                    break;
                case 'free':
                    document.getElementById('list').style.color = "white";
                    $pencil.style.left = "860px";
                    $pencil.style.display = "block";
                    // document.getElementById('list').style.background="rgba(0,0,0,0.3)";
                    break;
                case 'generation':
                    document.getElementById('generation').style.color = "white";
                    $pencil.style.left = "585px";
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

    // 연령대별 게시판 이동
    function toGenerationList(){
        const $generation = document.getElementById('generation');
        $generation.onclick = e =>{
            location.href = '/generation/list?generation=9999';
        }
    }
    // 연령대별 게시판 이동
    function to00List(){
        const $subc00 = document.getElementById('subc00');
        $subc00.onclick = e =>{
            location.href = '/generation/list?generation=2000';
        }
    }
    // 연령대별 게시판 이동
    function to90List(){
        const $subc90 = document.getElementById('subc90');
        $subc90.onclick = e =>{
            location.href = '/generation/list?generation=1990';
        }
    }
    // 연령대별 게시판 이동
    function to80List(){
        const $subc80 = document.getElementById('subc80');
        $subc80.onclick = e =>{
            location.href = '/generation/list?generation=1980';
        }
    }
    // 연령대별 게시판 이동
    function to70List(){
        const $subc70 = document.getElementById('subc70');
        $subc70.onclick = e =>{
            location.href = '/generation/list?generation=1970';
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
        const $toMyDiary = document.getElementById('subd1');
        const $toDiary2 = document.getElementById('subd2');
        const $toBestDiary = document.getElementById('subd3');
        $toDiary.onclick = e => {
            location.href = "/diary/list";
        }
        $toMyDiary.onclick = e =>{
            location.href = "/diary/myList";
        }
        $toDiary2.onclick = e =>{
            location.href = "/diary/list";
        }
        $toBestDiary.onclick = e =>{
            location.href = "/diary/bestList";
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
        const $subcatec = document.getElementById("subcatec");
        const $subcated = document.getElementById("subcated");

        $keyword.onmouseenter = e => {
            $pencil.style.left = "325px";
            $pencil.style.display = "block";
        }
        $keyword.onmouseout = e => {
            $pencil.style.display = "none";
        }
        $generation.onmouseenter = e => {
            $pencil.style.left = "585px";
            $pencil.style.display = "block";
            $subcatec.style.animationName="slidec";
        }
        $generation.onmouseout = e => {
            $pencil.style.display = "none";
            $subcatec.style.animationName="";
        }
        $subcatec.onmouseover = e =>{
            $subcatec.style.height="400px";
        }
        $subcatec.onmouseleave = e =>{
            $subcatec.style.height="0px";
            $subcatec.style.animationName="";
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
        $diary.onmouseover = e => {
            $pencil.style.left = "1440px";
            $pencil.style.display = "block";
            $subcated.style.animationName="slided";
        }
        $diary.onmouseleave = e => {
            $pencil.style.display = "none";
            $subcated.style.animationName="";
        }
        $subcated.onmouseover = e =>{
            $subcated.style.height="300px";
        }
        $subcated.onmouseleave = e =>{
            $subcated.style.height="0px";
            $subcated.style.animationName="";
        }


    }

    (function () {
        changeFont();
        hover();
        toGenerationList();
        to00List();
        to90List();
        to80List();
        to70List();
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