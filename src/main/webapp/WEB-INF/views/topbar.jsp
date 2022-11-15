<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<div class="topbar">
    <div class="icon-wrapper">
        <div class="icon">

        </div>
        <div class="icon-text">
            Latte is...
        </div>
    </div>
    <div class="category">
        <div>
            오늘의 키워드
        </div>
        <div>
            연령대별 추억 공유
        </div>
        <div id="list">
            자유게시판
        </div>
        <div>
            스무고개
        </div>
        <div id="diary">
            나의 한 줄 일기
        </div>
    </div>
    <c:if test="${loginUser == null}">
    <div class="login" id="tologin">로그인/회원가입</div>
    </c:if>
    <c:if test="${loginUser != null}">
        <div class="nickname">
            <div id="tomypage">${loginUser.userNickname}</div>
            <div id="logout">/로그아웃</div>
        </div>
    </c:if>
</div>
<script>
// 목록으로 가지
function toList() {
// 목록 버튼
const $toList = document.getElementById('list');
$toList.onclick = e => {
location.href = "/freeboard/list";
}
}
function toDiary(){
const $toDiary = document.getElementById('diary');
$toDiary.onclick = e => {
location.href = "/diary/list";
}
}
function toLogin(){
const $toLogin = document.getElementById("tologin");
$toLogin.onclick = e => {
location.href = "/user/login";
}
}
function logout(){
    const $logout = document.getElementById("logout");
    $logout.onclick = e => {
        location.href = "/user/logout";
    }
}
(function(){
toList();
toDiary();
    <c:if test="${loginUser == null}">
    toLogin();
    </c:if>
    <c:if test="${loginUser != null}">
    logout();
    </c:if>
})();
</script>