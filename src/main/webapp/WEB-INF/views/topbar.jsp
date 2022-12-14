<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<head>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />
    <meta name="viewport" content="width=device-width; initial-scale=1">
</head>
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
    <div class="homeMenu" id="homeMenu"></div>
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
<div class="menu" id="menu">
    <div>
        <div class="menu-icon-wrapper">
            <div></div>
            <div>Latte is...</div>
        </div>
    </div>
    <div>
        <div class="menu-category">
            <div><span id="keyp"></span><div id="m-keyword">키워드 게시판</div></div>
            <div><span id="genep"></span><div id="m-generation">연령대별 추억 공유</div><span id="geneArrow" class="gArrowDown"></span></div>
            <div id="m-subcatec">
                <div><span></span><div id="m-subc00">00년대</div></div>
                <div><span></span><div id="m-subc90">90년대</div></div>
                <div><span></span><div id="m-subc80">80년대</div></div>
                <div><span></span><div id="m-subc70">70년대</div></div>
            </div>
            <div><span id="freep"></span><div id="m-list">자유게시판</div></div>
            <div><span id="quizp"></span><div id="m-game">스무고개</div></div>
            <div><span id="diaryp"></span><div id="m-diary">일기</div><span id="diaryArrow" class="dArrowDown"></span></div>
            <div id="m-subcated">
                <div><span></span><div id="m-subd1">나의 일기</div></div>
                <div><span></span><div id="m-subd2">모두의 일기</div></div>
                <div><span></span><div id="m-subd3">베스트 일기</div></div>
            </div>
        </div>
    </div>
    <div>
        <c:if test="${loginUser == null}">
            <div class="m-login" id="m-tologin" style="cursor: pointer">로그인/회원가입</div>
        </c:if>
        <c:if test="${loginUser != null}">
            <div class="m-nickname" style="cursor: pointer">
                <div id="m-tomypage">${loginUser.userNickname}</div>
                <div id="m-logout">/로그아웃</div>
            </div>
        </c:if>
    </div>
</div>

<script>
    //페이지에 해당하는 탑바 색 바꾸기
    function changeFont() {

        var page = "${topbar}";
        console.log("페이지" + page);
        const $pencil = document.getElementById("fiximg");
        if (page != null) {
            switch (page) {
                case 'keyword':
                    document.getElementById('keyword').style.color = "white";
                    $pencil.style.left = "325px";
                    $pencil.style.display = "block";
                    // document.getElementById('diary').style.background="rgba(0,0,0,0.3)";
                    break;
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

    //키워드 게시판 이동
    function toKeyword(){
        const $keyword = document.getElementById('keyword');
        $keyword.onclick = e =>{
            location.href = '/keyword/list';
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

    // 스무고개
    function toQuiz(){
        const $quiz = document.getElementById('game');
        $quiz.onclick = e =>{
            location.href = "/quiz"
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

    function toMyPage(){
        const $tomypage = document.getElementById("tomypage");

        $tomypage.onclick = e =>{
            location.href="/user/mypage";
        }
    }

    /////////////////// 모바일 구역 /////////////////////////////////////////////////////

    function menu(){
        const $homeMenu = document.getElementById("homeMenu");
        const $menu = document.getElementById("menu");
        $homeMenu.onclick = e => {
            $menu.style.display="block";
            $menu.className="menu animate__animated animate__slideInRight";
        }
    }

    function outMenu(){
        const $menu = document.getElementById("menu");
        const $subDiary = document.getElementById("m-subcated");
        const $subGene = document.getElementById("m-subcatec");
        document.onclick = e =>{
            if(e.target.matches('.menu *')||e.target.matches('#homeMenu')) return;
            if($menu.className!="menu") {
                console.log('document click 이벤트!! d=none');

                $menu.className = "menu animate__animated animate__slideOutRight";
                $subDiary.style.display = "none";
                $subDiary.className = "";
                $subGene.style.display = "none";
                $subGene.className = "";
            }
        }
    }


    //페이지에 해당하는 탑바 색 바꾸기
    function mChangeFont() {

        var page = "${topbar}";
        console.log("페이지" + page);
        const $pencil1 = document.getElementById("keyp");
        const $pencil2 = document.getElementById("genep");
        const $pencil3 = document.getElementById("freep");
        const $pencil4 = document.getElementById("quizp");
        const $pencil5 = document.getElementById("diaryp");
        if (page != null) {
            switch (page) {
                case 'keyword':
                    $pencil1.style.visibility="visible";
                    break;
                case 'generation':
                    $pencil2.style.visibility="visible";
                    break;
                case 'free':
                    $pencil3.style.visibility="visible";
                    break;
                case 'quiz':
                    $pencil4.style.visibility="visible";
                    break;
                case 'diary':
                    $pencil5.style.visibility="visible";
                    break;
            }
        }
    }

    //키워드 게시판 이동
    function mToKeyword(){
        const $keyword = document.getElementById('m-keyword');
        $keyword.onclick = e =>{
            location.href = '/keyword/list';
        }
    }

    // 연령대별 게시판 이동
    function mToGenerationList(){
        const $generation = document.getElementById('m-generation');
        $generation.onclick = e =>{
            location.href = '/generation/list?generation=9999';
        }
    }

    // 연령대별 서브 카테고리 출력
    function mSubGeneration(){
        const $geneArrow = document.getElementById("geneArrow");
        const $subGene = document.getElementById("m-subcatec");
        $geneArrow.onclick = e =>{
            if($geneArrow.className==="gArrowDown") {
                $subGene.style.display = "block";
                $subGene.className = "animate__animated animate__fadeInDown";
                $geneArrow.className = "gArrowUp"
                $geneArrow.style.transform = "rotate(180deg)";
            }else{
                $subGene.className = "animate__animated animate__fadeOutUp";
                $geneArrow.className = "gArrowDown";
                $geneArrow.style.transform = "";
                setTimeout(()=>$subGene.style.display="none",700);
            }
        }
    }

    // 연령대별 게시판 이동
    function mTo00List(){
        const $subc00 = document.getElementById('m-subc00');
        $subc00.onclick = e =>{
            location.href = '/generation/list?generation=2000';
        }
    }
    // 연령대별 게시판 이동
    function mTo90List(){
        const $subc90 = document.getElementById('m-subc90');
        $subc90.onclick = e =>{
            location.href = '/generation/list?generation=1990';
        }
    }
    // 연령대별 게시판 이동
    function mTo80List(){
        const $subc80 = document.getElementById('m-subc80');
        $subc80.onclick = e =>{
            location.href = '/generation/list?generation=1980';
        }
    }
    // 연령대별 게시판 이동
    function mTo70List(){
        const $subc70 = document.getElementById('m-subc70');
        $subc70.onclick = e =>{
            location.href = '/generation/list?generation=1970';
        }
    }


    // 자유게시판
    function mToList() {
        const $toList = document.getElementById('m-list');
        $toList.onclick = e => {
            location.href = "/freeboard/list";
        }
    }

    // 스무고개
    function mToQuiz(){
        const $quiz = document.getElementById('m-game');
        $quiz.onclick = e =>{
            location.href = "/quiz"
        }
    }


    function mToDiary() {
        const $toDiary = document.getElementById('m-diary');
        const $toMyDiary = document.getElementById('m-subd1');
        const $toDiary2 = document.getElementById('m-subd2');
        const $toBestDiary = document.getElementById('m-subd3');
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

    function mSubDiary(){
        const $diaryArrow =  document.getElementById("diaryArrow");
        const $subDiary = document.getElementById("m-subcated");
        $diaryArrow.onclick = e =>{
            if($diaryArrow.className==="dArrowDown") {
                $subDiary.style.display = "block";
                $subDiary.className = "animate__animated animate__fadeInDown";
                $diaryArrow.className = "dArrowUp"
                $diaryArrow.style.transform = "rotate(180deg)";
            }else{
                $subDiary.className = "animate__animated animate__fadeOutUp";
                $diaryArrow.className = "dArrowDown";
                $diaryArrow.style.transform = "";
                setTimeout(()=>$subDiary.style.display="none",700);
            }
        }
    }


    function mToLogin() {
        const $toLogin = document.getElementById("m-tologin");
        $toLogin.onclick = e => {
            location.href = "/user/login";
        }
    }


    function mLogout() {
        const $logout = document.getElementById("m-logout");
        $logout.onclick = e => {
            location.href = "/user/logout";
        }
    }


    function mToMyPage(){
        const $tomypage = document.getElementById("m-tomypage");
        $tomypage.onclick = e =>{
            location.href="/user/mypage";
        }
    }

    (function () {
        changeFont();
        hover();
        toGenerationList();
        toKeyword();
        to00List();
        to90List();
        to80List();
        to70List();
        toList();
        toQuiz();
        toDiary();
        <c:if test="${loginUser == null}">
        toLogin();
        </c:if>
        <c:if test="${loginUser != null}">
        logout();
        toMyPage();
        </c:if>
        toHome();

        //모바일 함수 시작 부분

        menu();
        outMenu();
        mChangeFont();
        mToGenerationList();
        mSubGeneration();
        mToKeyword();
        mTo00List();
        mTo90List();
        mTo80List();
        mTo70List();
        mToList();
        mToQuiz();
        mToDiary();
        mSubDiary();
        <c:if test="${loginUser == null}">
        mToLogin();
        </c:if>
        <c:if test="${loginUser != null}">
        mLogout();
        mToMyPage();
        </c:if>
    })();
</script>