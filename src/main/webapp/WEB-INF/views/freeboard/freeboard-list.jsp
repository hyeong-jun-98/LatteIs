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
        .wrap{
            width: 60%;
            margin: 0 auto;
        }
        table tr th:nth-child(1){
            width: 10%;
        }
        table tr th:nth-child(2){
            width: 15%;
        }
        table tr th:nth-child(3){
            width: 30%;
        }
    </style>
</head>
<body>

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
            <c:forEach var="i" begin="0" end="10" step="1">
                <tr>
                    <th>${i+1}</th>
                    <td>Mark</td>
                    <td>Otto</td>
                    <td>@mdo</td>
                    <td>@mdo</td>
                    <td>@mdo</td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
    <!-- 글쓰기 버튼 영역 -->
    <div class="btn-write">
        <button id="btn-write" type="button" class="btn btn-warning">글쓰기</button>
    </div>
</div>



<script>
    // 게시글 작성 성공 메시지
    function alertServerMessage(){
        const msg = '${msg}';
        console.log('msg : ', msg);
        if(msg === 'write-success'){
            alert('게시물이 정상 등록되었습니다.');
        }
    }

    // 글 작성 폼으로 이동
    function writeForm(){
        const $btnWrite = document.getElementById("btn-write");
        $btnWrite.addEventListener("click", function(){
            location.href="/freeboard/write";
        });
    }

    (function(){
        alertServerMessage();
        writeForm();
    })();

</script>

</body>
</html>
