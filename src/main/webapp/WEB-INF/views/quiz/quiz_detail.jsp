<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
    <!-- fontawesome css: https://fontawesome.com -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css">
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <!-- JavaScript Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
            crossorigin="anonymous"></script>

    <!-- 상세보기 css -->
    <link href="/css/board/board-detail.css" rel="stylesheet"/>
    <!-- 상단바 css -->
    <link href="/css/topbar.css" rel="stylesheet">

    <!--제이쿼리-->
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />

</head>
<style>
    .answer {
        display: none;
    }

    #crown {
        display: none;
        width: 2em;
    }
    .wrap{
        position: relative;
    }
    #stamp{
        position: absolute;
        left: 14%;
        top: 28%;
        width: 70%;
        display: none;
    }

    #fixStamp{
        position: absolute;
        right: 0;
        width: 10em;
        display: none;
    }


    .flex{
        display: flex;
    }
    .result{
        line-height: 44px;
        margin-left: 10px;
        display: none;
    }

    .bg-size {
        width: 70px;
        text-align: center;
        line-height: 50px;
        background-size: 100% 100%;
        color: white;
    }
    .board-no-title {
        display: flex;
        justify-content: space-between;
        line-height: 50px;
    }
</style>
<body>

<%@include file="../topbar.jsp" %>

<%-- 글 상세보기 영역 --%>
<div class="wrap">
    <div class="content-container">

        <h1 class="main-title">퀴즈</h1>
        <div class="board-no-title">
            <span>${q.quizNo}번 게시물</span>
            <c:if test="${q.quizScore == '500'}">
                <div class="fs-5 bg-size" style="background-image: url('/img/red.png');">${q.quizScore}점</div>
            </c:if>
            <c:if test="${q.quizScore == '400'}">
                <div class="fs-5 bg-size" style="background-image: url('/img/orange.png');">${q.quizScore}점</div>
            </c:if>
            <c:if test="${q.quizScore == '300'}">
                <div class="fs-5 bg-size" style="background-image: url('/img/yellow.png');">${q.quizScore}점</div>
            </c:if>
            <c:if test="${q.quizScore == '200'}">
                <div class="fs-5 bg-size" style="background-image: url('/img/blue.png');">${q.quizScore}점</div>
            </c:if>
            <c:if test="${q.quizScore == '100'}">
                <div class="fs-5 bg-size" style="background-image: url('/img/purple.png');">${q.quizScore}점</div>
            </c:if>
        </div>

        <div class="mb-3">
            <label for="writer-input" class="form-label">출제자</label>
            <input type="text" class="form-control" id="writer-input"
                   placeholder="이름" name="quiz_writer" value="${q.quizWriter}" disabled>
        </div>

        <div class="mb-3">
            <img src="/img/stamp.png" id="fixStamp">
            <img src="/img/stamp.png" id="stamp" class="stamp">
<%--            <img src="/img/discorrect.png" id="discorrect">--%>
            <img id="my-img" class="my-img">
        </div>

        <div class="mb-3">
            <img src="/img/crown.png" id="crown">
            <input type="text" class="form-control answer" id="quiz-input"
                   placeholder="퀴즈 정답" name="quiz_answer" readonly>
        </div>

        <div class="mb-3 flex">
            <input type="" class="form-control w-25 media-w" id="answer"
                   name="quiz_result" placeholder="정답을 입력해주세요">
            <div class="result" id="result" style="color: red">틀렸습니다.</div>
        </div>

        <div class="mb-3">
            <button type="button" class="form-control w-25 media-w " id="quiz-button"
                    name="quiz-button">정답확인
            </button>
        </div>


        <!-- 댓글 영역 -->
        <div id="comments" class="row">
            <div class="col-md-12">
                <!--댓글 내용 영역-->
                <div class="card">
                    <!-- 댓글 내용 헤더 -->
                    <div class="card-header text-white m-0 bg-warning bg-opacity-50">
                        <div class="float-left text-black" id="good-comment-area">
                            <i class="far fa-heart fs-4" id="good-check"></i>&nbsp좋아요 (<span id="goodCnt">0</span>)

                            &nbsp&nbsp댓글 (<span id="commentCnt">0</span>)
                        </div>
                    </div>

                    <!-- 댓글 내용 바디 -->
                    <div id="commentCollapse" class="card">
                        <div id="commentData">
                            <!--
                            < JS로 댓글 정보 DIV삽입 >
                        -->
                        </div>

                        <!-- 댓글 페이징 영역 -->
                        <ul class="pagination justify-content-center pagination-custom">
                            <!--
                            < JS로 댓글 페이징 DIV삽입 >
                        -->
                        </ul>
                    </div>
                </div> <!-- end comment content -->

                <!-- 댓글 수정 모달 -->
                <div class="modal fade bd-example-modal-lg" id="commentEditModal">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">

                            <!-- Modal Header -->
                            <div class="modal-header" style="background: #343A40; color: white;">
                                <h4 class="modal-title">댓글 수정하기</h4>
                                <button type="button" class="close text-black" data-bs-dismiss="modal">X</button>
                            </div>

                            <!-- Modal body -->
                            <div class="modal-body">
                                <div class="form-group">
                                    <input id="modCommentId" type="hidden">
                                    <label for="modCommentText" hidden>댓글내용</label>
                                    <textarea id="modCommentText" class="form-control"
                                              placeholder="수정할 댓글 내용을 입력하세요."
                                              rows="3"></textarea>
                                </div>
                            </div>

                            <!-- Modal footer -->
                            <div class="modal-footer">
                                <button id="modalCommentEditBtn" type="button" class="btn btn-dark">수정</button>
                                <button id="modal-close" type="button" class="btn btn-danger"
                                        data-bs-dismiss="modal">닫기
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end replyModifyModal -->

                <!-- 댓글 쓰기 영역 -->
                <div class="card">
                    <div class="card-body">

                        <c:if test="${empty loginUser}">
                            <a href="/user/login">댓글은 로그인 후 작성 가능합니다.</a>
                        </c:if>

                        <c:if test="${not empty loginUser}">
                            <div class="row">
                                <div class="col-md-9">
                                    <div class="form-group">
                                        <label for="newCommentContent" hidden>댓글 내용</label>
                                        <textarea rows="5" id="newCommentContent" name="commentContent"
                                                  class="form-control"
                                                  placeholder="댓글을 입력해주세요."></textarea>
                                        <div id="comment-cnt">(0 / 300)</div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <div class="form-group">
                                        <button id="commentAddBtn" type="button"
                                                class="btn btn-dark form-control">등록
                                        </button>
                                        <label for="newCommentWriter" hidden>댓글 작성자</label>
                                        <input id="newCommentWriter" name="commentWriter" type="text"
                                               class="form-control" placeholder="작성자 이름" readonly
                                               value="${loginUser.userNickname}"
                                               style="margin-bottom: 6px;">
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </div> <!-- end comment write -->
            </div>
        </div>

        <div class="d-flex">
            <c:if test="${loginUser.userNickname == q.quizWriter || loginUser.auth == 'ADMIN'}">
                <button id="del-btn" class="btn btn-danger" type="button" style="width: 100%;">삭제하기</button>
            </c:if>
        </div>
        <div class="d-grid gap-2">
            <button id="to-list" class="btn bg-warning bg-opacity-50" type="button">목록으로</button>
        </div>
        </form>
    </div>


</div>

<!-- 게시글 상세보기 관련 script -->
<script>
    // 그림 크기 설정
    function setImgSize() {
        const canvas = document.querySelector("#my-img");
        const width = 951;
        const height = 600;

        canvas.width = width;
        canvas.height = height;
        // canvas.style.width = "150%";
        canvas.style.marginBottom = "10px";
        canvas.style.border = "3px solid black";
    }


    //본인 출제 문제 감지
    function my(){
        let writer = '${q.quizWriter}';
        let user = '${user.userNickname}';
        const $quiz = document.getElementById('quiz-button');
        const $answer = document.getElementById('answer');
        const $showAnswer = document.getElementById('quiz-input');
        if(writer==user){
            $quiz.style.display="none";
            $answer.style.display="none";
        }
    }

    // 이미 정답을 맞춘 퀴즈 감지
    function check() {
        const $quiz = document.getElementById('quiz-button');
        const $answer = document.getElementById('answer');
        const $showAnswer = document.getElementById('quiz-input');
        const $crown = document.getElementById('crown');
        const $fixStamp = document.getElementById('fixStamp');
        let check = ${q.quizCheck};
        if(check=='1'){
            $quiz.style.display="none";
            $answer.style.display="none";
            $crown.style.display="block";
            $showAnswer.style.display="inline-block";
            $showAnswer.value='정답: ${q.quizAnswer} / 정답자: ${q.whoCorrect}';
            $fixStamp.style.display="block";
        }
    }

    // 퀴즈 정답홧인
    function quiz() {
        const $quiz = document.getElementById('quiz-button');
        const $stamp = document.getElementById('stamp');
        const $result = document.getElementById('result');
        $quiz.onclick = e => {
            let answer = document.getElementById('answer').value;

            if (${empty loginUser}) { // 로그인 안돼있으면
                alert("로그인 후 이용 가능한 서비스 입니다.");
                return;
            } else if (answer === '' && ${not empty loginUser}){
                alert('정답을 입력해주세요.')
                return;
            }

            const $answer = document.getElementById('answer');
            const $crown = document.getElementById('crown');
            console.log(answer);
            fetch('/quiz/check?quizAnswer=' + answer + '&quizNo=${q.quizNo}')
                .then(res => res.text())
                .then(quiz => {
                    let jsonQuiz = JSON.parse(quiz);
                    let check = jsonQuiz.quizCheck;
                    let quizAnswer = jsonQuiz.quizAnswer;
                    let whoCorrect = jsonQuiz.whoCorrect;
                    if(check=='1'){
                        const $showAnswer = document.getElementById('quiz-input');
                        $crown.style.display="block";
                        $quiz.style.display="none";
                        $answer.style.display="none";
                        $showAnswer.style.display="inline-block";
                        $showAnswer.value="정답: "+quizAnswer+" / 정답자: "+whoCorrect;
                        $stamp.style.display="block";
                        $stamp.className="animate__animated animate__flash";
                        $result.style.display="none";
                    }else{
                        $answer.style.border="red solid 2px";
                        $answer.className="form-control w-25 media-w animate__animated animate__flash";
                        $result.style.display="block";
                        setTimeout(() =>
                                $answer.style.border="#ced4da solid 2px", 1200);
                        setTimeout(() =>
                            $answer.className="form-control w-25 media-w",1200);
                    }
                })
        }

    }


    const $goodCheck = document.getElementById('good-check');   // 좋아요 버튼
    const goodList = $goodCheck.classList;  // 좋아요 버튼의 클래스 리스트

    // 좋아요 요청 URL
    const Good_URL = '/api/v1/quiz-good';

    // 퀴즈 번호
    const qno = '${q.quizNo}';

    // 로그인 계정 번호
    const uno = '${loginUser.userNo}';

    // 좋아요 체크 여부
    let flag = 'false';

    // 목록으로 가기
    function toList() {
        // 목록 버튼
        const $toList = document.getElementById('to-list');
        $toList.onclick = e => {
            location.href = "/quiz/list?pageNum=${diaryPage.pageNum}&amount=${diaryPage.amount}";
        }
    }

    // 게시글 삭제하기
    function deleteEvent() {
        // 삭제하기 버튼
        const $delBtn = document.getElementById("del-btn");
        if ($delBtn !== null) {
            $delBtn.onclick = e => {
                if (!confirm("삭제하시겠습니까?")) return;
                location.href = "/quiz/delete?quizNo=" + qno + "&pageNum=${diaryPage.pageNum}&amount=${diaryPage.amount}";
            }
        }
    }


    // 로그인 여부 메시지
    function alertServerMessage() {
        const msg = '${msg}';
        if (msg === 'no-match') {
            alert('로그인 정보가 맞지 않습니다.');
        }
    }

    // 좋아요 여부 확인
    function goodOrNot() {
        if (uno !== '') {
            fetch(Good_URL + '/check?quizNo=' + qno + '&userNo=' + uno)
                .then(res => res.text())
                .then(msg => {
                    flag = msg;
                    if (flag === 'true') {
                        goodList.replace('far', 'fas'); // 엄지 체크
                    }
                });
        }
    }

    // 좋아요 수 요청 함수
    function getGoodCount() {
        fetch(Good_URL + '?quizNo=' + qno)
            .then(res => res.text())
            .then(cnt => {
                // 좋아요 수 배치
                document.getElementById('goodCnt').textContent = cnt;
            })
    }

    // 좋아요 이벤트
    function goodCheckEvent() {
        $goodCheck.onclick = e => {

            if (${empty loginUser}) { // 로그인 안돼있으면
                alert("로그인 후 이용 가능한 서비스 입니다.");
                return;
            }

            // 로그인 돼있으면 아래 실행
            if (flag === 'false') {  // 빈 엄지이면
                goodCheck();
                flag = 'true';
                goodList.replace('far', 'fas'); // 빈 좋아요를 채워진 엄지로 변경
            } else if (flag === 'true') {    // 채워진 엄지이면
                goodUnCheck();
                flag = 'false';
                goodList.replace('fas', 'far');   // 빈 엄지로 변경
            }
        };
    }

    // 좋아요 체크 처리 요청
    function goodCheck() {
        // 서버로 전송할 데이터들
        const replyData = {
            userNo: uno,
            quizNo: qno
        };

        // POST요청을 위한 요청 정보 객체
        const reqInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(replyData)
        };

        fetch(Good_URL, reqInfo)
            .then(function () {
                getGoodCount(); // 좋아요 수 비동기로 가져오기
            });
    }

    // 좋아요 취소 처리 요청
    function goodUnCheck() {
        // 서버로 전송할 데이터들
        const replyData = {
            userNo: uno,
            quizNo: qno
        };

        // POST요청을 위한 요청 정보 객체
        const reqInfo = {
            method: 'DELETE',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(replyData)
        };

        fetch(Good_URL, reqInfo)
            .then(function () {
                getGoodCount(); // 좋아요 수 비동기로 가져오기
            })
    }

    function urlToImg() {
        const $img = document.getElementById('my-img');
        $img.setAttribute('src', '${q.fileName}');
    }

    (function () {
        //본인 퀴즈 감지
        my();
        //정답 처리된 퀴즈 감지
        check();
        alertServerMessage();
        toList();
        deleteEvent();
        // editEvent();
        urlToImg();
        // 퀴즈 정답
        quiz();

        // 좋아요 수 가져오기
        getGoodCount();
        // 좋아요 여부 확인
        goodOrNot();
        // 좋아요 이벤트
        goodCheckEvent();

        // 그림 크기 설정
        setImgSize();

    })();
</script>

<!-- 댓글 관련 script -->
<script>
    // 댓글 글자수 제한
    $(document).ready(function () {

        // 엔터키 못치게
        $('#newCommentContent').keypress(function (e) {
            if (e.keyCode == 13)
                e.preventDefault();
        });

        $('#newCommentContent').on('keyup', function (e) {
            $('#comment-cnt').html("(" + $(this).val().length + " / 300)");

            if ($(this).val().length > 300) {
                alert('300자까지 입력할 수 있습니다..');
                $(this).val($(this).val().substring(0, 300));
                $('#comment-cnt').html("(300 / 300)");
            }
        });
    });

    // 로그인한 계정의 닉네임
    const currNickname = '${loginUser.userNickname}';
    const currAuth = '${loginUser.auth}';

    // 댓글 요청 URL
    const URL = '/api/v1/quiz-comment';

    // 댓글 등록버튼 클릭
    function clickRegister() {
        const $commentAddBtn = document.getElementById('commentAddBtn');
        if ($commentAddBtn !== null) {
            $commentAddBtn.onclick = commentRegisterEvent;
        }
    }

    // 댓글 등록 요청 함수
    function commentRegisterEvent() {

        const $writerInput = document.getElementById('newCommentWriter');
        const $contentInput = document.getElementById('newCommentContent');

        if ($contentInput.value === '') {
            alert('댓글을 작성해주세요.');
            return;
        }

        // 서버로 전송할 데이터들
        const commentData = {
            quizCommentWriter: $writerInput.value,
            quizCommentContent: $contentInput.value,
            quizNo: qno
        };

        // POST 요청을 위한 요청 정보 객체
        const reqInfo = {
            method: 'POST',
            headers: {
                'content-type': 'application/json'
            },
            body: JSON.stringify(commentData)
        };

        // 등록 성공하면
        fetch(URL, reqInfo).then(res => res.text())
            .then(msg => {
                if (msg === 'insert-success') {
                    // 댓글 입력 창 초기화
                    $writerInput.value = '${loginUser.userNickname}';
                    $contentInput.value = '';
                    document.getElementById('comment-cnt').textContent = '(0 / 300)';
                    // 댓글 목록 재요청
                    showComment(document.querySelector('.pagination').dataset.fp);
                } else {
                    alert('댓글 등록 실패');
                }
            })
    }

    // 댓글 목록을 서버로부터 비동기 요청으로 불러오는 함수
    function showComment(pageNum = 1) {
        fetch(URL + '?quizNo=' + qno + '&pageNum=' + pageNum)
            .then(res => res.json())
            .then(commentMap => {
                makeCommentDOM(commentMap);
            })
    }

    // 댓글 목록 DOM을 생성하는 함수
    function makeCommentDOM({quizCommentList, pageMaker, count}) {
        // 각 댓글 하나의 태그
        let tag = '';
        if (quizCommentList === null || quizCommentList.length === 0) {
            tag += "<div id='commentContent' class='card-body'>댓글이 아직 없습니다.</div>";
        } else {
            for (let comment of quizCommentList) {
                tag +=
                    "<div id='commentContent' class='card-body bottom-line' data-commentId='" + comment.quizCommentNo + "'>" +
                    "    <div class='row user-block'>" +
                    "       <span class='col-md-3'>" +
                    "         <b>" + comment.quizCommentWriter + "</b>" +
                    "       </span>" +
                    "       <span class='offset-md-6 col-md-3 text-right'><b>" + formatDate(comment.quizCommentDate) +
                    "       </b></span>" +
                    "    </div><br>" +
                    "    <div class='row'>" +
                    "       <div class='col-md-6'>" + comment.quizCommentContent + "</div>" +
                    "       <div class='offset-md-2 col-md-4 text-right'>";
                if (currNickname === comment.userNickname || currAuth === "ADMIN") {
                    tag +=
                        "           <a id='commentEditBtn' class='btn btn-sm btn-outline-dark' data-bs-toggle='modal' data-bs-target='#commentEditModal'>수정</a>&nbsp;" +
                        "           <a id='commentDelBtn' class='btn btn-sm btn-outline-dark' href='#'>삭제</a>";
                }
                tag +=
                    "       </div>" +
                    "   </div>" +
                    " </div>";
            }
        }

        // 댓글 목록에 생성된 DOM 추가
        document.getElementById('commentData').innerHTML = tag;

        // 댓글 수 배치
        document.getElementById('commentCnt').textContent = count;

        // 페이지 렌더링
        makePageDOM(pageMaker);
    }

    // 댓글 페이지 태그 생성 렌더링 함수
    function makePageDOM(pageInfo) {
        let tag = '';
        const begin = pageInfo.beginPage;
        const end = pageInfo.endPage;

        // 이전 버튼 만글디
        if (pageInfo.prev) {
            tag +=
                "<li class='page-item'><a class='page-link' href='" + (begin - 1) +
                "'>이전</a></li>";
        }
        // 페이지 번호 리스트 만들기
        for (let i = begin; i <= end; i++) {
            let active = '';
            if (pageInfo.page.pageNum === i) {
                active = 'active';
            }

            tag += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
        }
        // 다음 버튼 만들기
        if (pageInfo.next) {
            tag +=
                "<li class='page-item'><a class='page-link' href='" + (end + 1) +
                "'>다음</a></li>";
        }

        // 페이지 태그 렌더링
        const $pageUI = document.querySelector('.pagination');
        $pageUI.innerHTML = tag;

        // ul에 마지막 페이지 번호 저장
        $pageUI.dataset.fp = pageInfo.finalPage;
    }

    // 페이지 이동 함수
    function pageMove() {
        // 페이지 버튼 클릭 이벤트 처리
        const $pageUI = document.querySelector('.pagination');
        $pageUI.onclick = e => {
            if (!e.target.matches('.page-item a')) return;

            e.preventDefault();
            // 누른 페이지 번호 가져오기
            const pageNum = e.target.getAttribute('href');
            console.log(pageNum);

            // 페이지 번호에 맞는 목록 비동기 요청
            showComment(pageNum);
        }
    }

    // 날짜 포맷 변환 함수
    function formatDate(dateTime) {
        // 문자열 날짜 데이터를 날짜 객체로 변환
        const dateObj = new Date(dateTime);
        // console.log(dateObj);

        // 날짜 객체를 통해 각 날짜 정보 얻기
        let year = dateObj.getFullYear();
        let month = dateObj.getMonth() + 1;   // 1월이 0으로 설정돼있음
        let day = dateObj.getDate();
        let hour = dateObj.getHours();
        let minute = dateObj.getMinutes();

        // 숫자가 한자리일 경우 두자리로 변환
        (month < 10) ? month = '0' + month : month;
        (day < 10) ? day = '0' + day : day;
        (day < 10) ? day = '0' + day : day;
        (hour < 10) ? hour = '0' + hour : hour;
        (minute < 10) ? minute = '0' + minute : minute;
        return year + '-' + month + '-' + day + ' ' + ' ' + hour + ':' + minute;
    }

    // 댓글 수정화면 열기, 삭제 처리 핸들러 정의
    function commentEditAndDelHandler(e) {

        const cno = e.target.parentElement.parentElement.parentElement.dataset.commentid;

        e.preventDefault();

        if (e.target.matches('#commentEditBtn')) {
            openEditModal(e, cno);
        } else if (e.target.matches('#commentDelBtn')) {
            removeComment(cno);
        }
    }

    // 댓글 수정화면 열기, 삭제 이벤트 처리
    function openEditModalAndDelEvent() {
        const $commentData = document.getElementById('commentData');
        $commentData.onclick = commentEditAndDelHandler;
    }

    // 댓글 삭제 요청
    function removeComment(cno) {
        if (!confirm('정말 삭제하시겠습니까')) return;

        fetch(URL + '?quizCommentNo=' + cno, {
            method: 'DELETE'
        })
            .then(res => res.text())
            .then(msg => {
                if (msg === 'del-success') {
                    showComment();  // 댓글 새로 불러오기
                } else {
                    alert('삭제 실패');
                }
            })
    }

    // 댓글 수정화면 열기 요청
    function openEditModal(e, cno) {
        console.log('번호는 ', cno)
        const commentText = e.target.parentElement.parentElement.firstElementChild.textContent;
        console.log('댓글 내용은 ', commentText);

        // 모달에 해당 댓글 내용을 배치
        document.getElementById('modCommentText').textContent = commentText;

        // 모달을 띄울 때 다음 작업(수정 완료 처리)을 위해 댓글 번호를 모달에 달아두자
        const $modal = document.querySelector('.modal');
        $modal.dataset.cno = cno;
    }

    // 댓글 수정 비동기 처리
    function editComment() {
        const $modal = new bootstrap.Modal(document.getElementById('commentEditModal'));

        document.getElementById('modalCommentEditBtn').onclick = e => {
            console.log('수정 버튼 클릭');

            // 서버에 수정 비동기 요청 보내기
            const cno = e.target.closest('.modal').dataset.cno;
            console.log(cno);

            const reqInfo = {
                method: 'PUT',
                headers: {
                    'content-type': 'application/json'
                },
                body: JSON.stringify({
                    quizCommentNo: cno,
                    quizCommentContent: document.querySelector('#modCommentText').value
                })
            };
            console.log(reqInfo);

            fetch(URL + '/' + cno, reqInfo)
                .then(res => res.text())
                .then(msg => {
                    if (msg === 'edit-success') {
                        $modal.hide();   // 모달창 닫기
                        showComment();  // 댓글 새로 불러오기
                    } else {
                        alert('수정 실패');
                    }
                })
        }
    }


    // 메인 실행부
    (function () {
        // 댓글 목록 비동기 요청
        showComment();

        // 댓글 등록 요청
        clickRegister();

        // 페이지 이동 처리
        pageMove();

        // 댓글 수정화면 열기, 삭제 이벤트 처리
        openEditModalAndDelEvent();

        // 댓글 수정 요청
        editComment();


    })();
</script>

</body>
</html>
