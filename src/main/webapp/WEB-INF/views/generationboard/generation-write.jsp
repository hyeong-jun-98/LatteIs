<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>글쓰기</title>

    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- 상세보기 css -->
    <link href="/css/board/board-detail.css" rel="stylesheet"/>
    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">

    <!--제이쿼리-->
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>

    <style>
        @font-face {
            font-family: 'KyoboHand';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/KyoboHand.woff') format('woff');
            font-weight: bold;
            font-style: normal;
        }

        body {
            background-image: url("https://img.freepik.com/free-photo/white-crumpled-paper-texture-for-background_1373-159.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            overflow: visible;
            font-family: KyoboHand;
        }

    </style>
</head>
<body>

<%@include file="../topbar.jsp" %>


<div class="wrap">

    <div class="content-container">

        <h1 class="main-title">연령대별 게시판
            <c:if test="${generation != 9999}">
                - ${generation}년대
            </c:if>
        </h1>

        <form id="write-form" autocomplete="off" enctype="multipart/form-data">
            <input type="hidden" name="userNickname" value="${loginUser.userNickname}">

            <c:if test="${sessionGeneration != 9999}">
                <input type="text" name="generation" value="${sessionGeneration}">
            </c:if>

            <c:if test="${sessionGeneration == 9999}">
                <div class="mb-3">
                    <select name="generation">
                        <option value="">연대 선택</option>
                        <option value="2000">2000년대</option>
                        <option value="1990">1990년대</option>
                        <option value="1980">1980년대</option>
                        <option value="1970">1970년대</option>
                    </select>
                </div>
            </c:if>

            <div class="mb-3">
                <label for="writer-input" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer-input" placeholder="이름" name="writer" maxlength="20"
                       value="${loginUser.userNickname}" readonly>
            </div>
            <div class="mb-3">
                <label for="title-input" class="form-label">글제목</label>
                <textarea type="text" class="form-control" id="title-input" placeholder="제목"
                          name="title" maxlength="200" rows="1"
                          oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'"></textarea>
            </div>
            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control main-content" id="exampleFormControlTextarea1"
                          oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'"></textarea>
            </div>

            <!-- 첨부파일 드래그 앤 드롭 영역 -->
            <div class="form-group">
                <div class="fileDrop">
                    <span>Drop Here!!</span>
                </div>
                <div class="uploadDiv">
                    <input type="file" name="files" id="ajax-file" style="display:none;">
                </div>
                <!-- 업로드된 파일의 썸네일을 보여줄 영역 -->
                <div class="uploaded-list">
                </div>
            </div>

            <div class="d-grid gap-2">
                <button id="reg-btn" class="btn btn-dark" type="button">글 작성하기</button>
                <button id="to-list" class="btn btn-warning" type="button">목록으로</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 제목 글자수 제한
    $(document).ready(function () {

        // 엔터키 못치게
        $('#title-input').keypress(function (e) {
            if (e.keyCode == 13)
                e.preventDefault();
        });

        // ----------------- 유효성 검사 --------------------
        $('#title-input').on('keyup', function (e) {
            if ($(this).val().length > 100) {
                alert('제목을 100자 이내로 입력하세요.');
                $(this).val($(this).val().substring(0, 100));
            }
        });

        // ----------------- 파일 업로드 --------------------
        // 이미지 파일인지 판단하는 함수
        function isImageFile(originFileName) {
            //정규표현식
            const pattern = /jpg$|gif$|png$/i;
            return originFileName.match(pattern);
        }

        // 파일의 확장자에 따른 렌더링 처리
        function checkExtType(fileName) {
            // 원본 파일명 추출
            let originFileName = fileName.substring(fileName.indexOf("_") + 1);

            // hidden input을 만들어서 변환 파일명을 서버로 넘김
            const $hiddenInput = document.createElement('input');
            $hiddenInput.setAttribute('type', 'hidden');
            $hiddenInput.setAttribute('name', 'fileNames');
            $hiddenInput.setAttribute('value', fileName);
            $('#write-form').append($hiddenInput);

            // 확장자 추출 후, 이미지인지 아닌지 확인
            if (isImageFile(originFileName)) {
                // 이미지 요소 생성
                const $img = document.createElement('img');
                $img.classList.add('img-sizing');
                $img.setAttribute('src', '/loadFile?fileName=' + fileName);
                $img.setAttribute('alt', originFileName);
                $('.uploaded-list').append($img);
            } else {    // 이미지가 아니라면 다운로드 링크를 생성
                const $a = document.createElement('a');
                $a.setAttribute('href', '/loadFile?fileName=' + fileName);

                const $img = document.createElement('img');
                $img.classList.add('img-sizing');
                $img.setAttribute('src', '/loadFile?fileName=' + fileName);
                $img.setAttribute('alt', originFileName);

                $a.append($img);
                $a.innerHTML += '<span>' + originFileName + '</span>'

                $('.uploaded-list').append($a);
            }
        }

        // 드롭한 파일을 화면에 보여주는 함수
        function showFileData(fileNames) {
            for (let fileName of fileNames) {
                checkExtType(fileName);
            }
        }

        // drag & drop 이벤트
        const $dropBox = $('.fileDrop');

        // drag 진입 이벤트
        $dropBox.on('dragover dragenter', e => {
            e.preventDefault();
            $dropBox
                .css('border-color', 'red')
                .css('background', 'lightgray');
        });

        // drag 탈출 이벤트
        $dropBox.on('dragleave', e => {
            e.preventDefault();
            $dropBox
                .css('border-color', 'gray')
                .css('background', 'transparent');
        });

        // drop 이벤트
        $dropBox.on('drop', e => {
            e.preventDefault();

            // 드롭된 파일 정보를 서버로 전송
            // 1. 드롭된 파일 데이터 읽기
            const files = e.originalEvent.dataTransfer.files;

            // 2. 읽은 파일 데이터를 input[type=file] 태그에 저장
            const $fileInput = $('#ajax-file');
            $fileInput.prop('files', files);

            // 3. 파일 데이터를 비동기 전송하기 위해서는 FormData 객체가 필요
            const formData = new FormData();

            // 4. 전송할 파일들을 전부 FormData에 저장
            for (let file of $fileInput[0].files) {
                formData.append('files', file);
            }

            // 5. 비동기 요청 전송
            const reqInfo = {
                method: 'POST',
                body: formData
            };
            fetch('/ajax-upload', reqInfo)
                .then(res => res.json())
                .then(fileNames => {
                    showFileData(fileNames);
                })
        })
    });

    // 글 작성 이벤트
    function writeEvent() {
        document.getElementById("reg-btn").addEventListener("click", function () {
            if (${sessionGeneration} ===
            9999
        )
            {
                if (document.querySelector('select').value === "") {
                    alert('연대를 선택해주세요.');
                    return;
                }
            }
            if (document.getElementById('title-input').value === '') {
                alert('제목을 입력해주세요');
                return;
            } else if (document.querySelector('.main-content').value === '') {
                alert('글 내용을 작성해주세요.');
                return;
            }
            const $form = document.getElementById("write-form");
            $form.action = "/generation/write";
            $form.method = "post";
            $form.submit();
        });
    }

    // 목록으로 가기
    function toList() {
        // 목록 버튼
        const $toList = document.getElementById('to-list');
        $toList.onclick = e => {
            location.href = "/generation/list";
        }
    }

    (function () {
        writeEvent();
        toList();
    })();

</script>


</body>
</html>
