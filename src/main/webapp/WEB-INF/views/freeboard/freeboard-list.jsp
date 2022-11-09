<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>자유게시판</title>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <style>
        .wrap {
            width: 60%;
            margin: 0 auto;
        }
        .freeboard-list{
            margin-top: 100px;
        }
        table tbody a {
            color: #000 !important;
            text-decoration: none;
        }
        table tbody a:hover {
            color: orange !important;
            text-decoration: underline;
        }

        .bottom-section nav {
            flex: 9;
            display: flex;
            justify-content: center;
        }
        .pagination-custom li a {
            color: #000 !important;
        }
        .pagination-custom li.active a,
        .pagination-custom li:hover a {
            background: lightyellow !important;
            border-color: orange !important;
        }

        table tr th:nth-child(1) {
            width: 10%;
        }

        table tr th:nth-child(2) {
            width: 15%;
        }

        table tr th:nth-child(3) {
            width: 30%;
        }
    </style>
</head>
<body>
<h1>자유게시판</h1>
<%-- 글 목록 영역 --%>
<div class="wrap">
    <div class="freeboard-list">
        <table class="table table-hover">
            <thead class="table-warning">
            <tr>
                <th scope="col">#</th>
                <th scope="col">작성자</th>
                <th scope="col">제목</th>
                <th scope="col">추천수</th>
                <th scope="col">조회수</th>
                <th scope="col">작성시간</th>
            </tr>
            </thead>
            <tbody class="table-group-divider">
            <c:forEach var="b" items="${boardList}">
                <tr>
                    <th>${b.boardNo}</th>
                    <td>${b.writer}</td>
                    <td><a href="#">${b.shortTitle}</a></td>
                    <td>${b.good}</td>
                    <td>${b.hit}</td>
                    <td>${b.prettierDate}</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <!-- 게시글 목록 하단 영역 -->
        <div class="bottom-section">
            <!-- 페이지 버튼 영역 -->
            <nav aria-label="Page navigation example">
                <ul class="pagination pagination-lg pagination-custom">

                    <c:if test="${pm.prev}">
                        <li class="page-item"><a class="page-link"
                                                 href="/freeboard/list?pageNum=${pm.beginPage - 1}&amount=${pm.page.amount}">prev</a>
                        </li>
                    </c:if>

                    <c:forEach var="n" begin="${pm.beginPage}" end="${pm.endPage}" step="1">
                        <li data-page-num="${n}" class="page-item">
                            <a class="page-link"
                               href="/freeboard/list?pageNum=${n}&amount=${pm.page.amount}">${n}</a>
                        </li>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <li class="page-item"><a class="page-link"
                                                 href="/freeboard/list?pageNum=${pm.endPage + 1}&amount=${pm.page.amount}">next</a>
                        </li>
                    </c:if>

                </ul>
            </nav>

            <!-- 글쓰기 버튼 영역 -->
            <div class="btn-write">
                <button id="btn-write" type="button" class="btn btn-warning">글쓰기</button>
            </div>
        </div>
    </div>
</div>


<script>
    // 성공 메시지
    function alertServerMessage() {
        const msg = '${msg}';
        console.log('msg : ', msg);
        if (msg === 'write-success') {
            alert('게시물이 정상 등록되었습니다.');
        } else if(msg === 'delete-success'){
            alert('게시글이 정상적으로 삭제되었습니다.');
        }
    }

    // 글 작성 폼으로 이동
    function writeForm() {
        const $btnWrite = document.getElementById("btn-write");
        $btnWrite.addEventListener("click", function () {
            location.href = "/freeboard/write";
        });
    }

    // 게시글 상세보기
    function detailEvent() {
        const $tbody = document.querySelector('.table-group-divider');
        $tbody.onclick = e => {
            if (!e.target.matches('a')) return;
            const boardNo = e.target.parentNode.parentNode.firstElementChild.textContent;
            console.log(boardNo);
            location.href = "/freeboard/detail/"
                + boardNo + "?pageNum=${pm.page.pageNum}&amount=${pm.page.amount}"
            ;
        }
    }

    //현재 위치한 페이지에 active 스타일 부여하기
    function appendPageActive() {
        // 현재 내가 보고있는 페이지 번호
        const curPageNum = '${pm.page.pageNum}';
        console.log('현재 페이지 번호는 ', curPageNum);

        // 페이지 li태그들을 전부 확인해서
        // 현재 위치한 페이지 번호와 텍스트컨텐트가
        // 일치하는 li를 찾아서 class active 부여
        const $ul = document.querySelector('.pagination');

        for (let $li of [...$ul.children]) {
            if (curPageNum === $li.dataset.pageNum) {
                $li.classList.add('active');
                break;
            }
        }
    }


    (function () {
        alertServerMessage();
        detailEvent();
        writeForm();
        appendPageActive();
    })();

</script>

</body>
</html>
