<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
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

</head>

<body>
<%@include file="../topbar.jsp" %>

<div class="wrap">

    <div class="content-container">

        <form id="write-form" autocomplete="off" enctype="multipart/form-data">
            <input type="hidden" name="pageNum" value="${page.pageNum}">
            <input type="hidden" name="amount" value="${page.amount}">
            <input type="hidden" name="boardNo" value="${board.boardNo}">

            <h1 class="main-title">자유게시판</h1>
            <h2 class="board-no-title">${board.boardNo}번 게시물</h2>

            <div class="mb-3">
                <label for="writer-input" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer-input" placeholder="이름" name="writer"
                       value="${board.writer}" readonly>
            </div>
            <div class="mb-3">
                <label for="title-input" class="form-label">글제목</label>
                <textarea type="text" class="form-control" id="title-input" placeholder="제목" name="title"
                          rows="1"
                          oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.title}</textarea>
            </div>

            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control main-content"
                          id="exampleFormControlTextarea1"
                          oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.content}</textarea>
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

            <div class="btn-group btn-group-lg custom-btn-group" role="group">
                <button id="apply-btn" type="button" class="btn btn-warning">완료</button>
                <button id="cancel-btn" type="button" class="btn btn-dark">취소</button>
            </div>
        </form>

    </div>
</div>

<script>
    // 첨부파일 관련 변수 선언
    let deleteFileNames = [];     // 삭제할 이미지 이름을 담을 배열

    // ----------- Start JQuery ---------------
    // 제목 글자수 제한
    $(document).ready(function () {

        // 엔터키 못치게
        $('#title-input').keypress(function (e) {
            if (e.keyCode == 13)
                e.preventDefault();
        });
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

        // 파일 목록 불러오기 함수
        function showFileList() {
            fetch('/freeboard/file/' + ${board.boardNo})
                .then(res => res.json())
                .then(fileNames => {
                    showFileData(fileNames);
                })
        }
        showFileList();

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

            // 5. 비동기 요청
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

        // 파일 삭제 이벤트
        $(document).on('click', 'img', function () {
            const $img = $(this);   // 클릭한 이미지
            const imgSrc = $img.attr("src");     // 이미지에 담긴 경로
            const fileName = imgSrc.substring(imgSrc.indexOf('=') + 1);     // 클릭한 이미지 이름

            // 클릭한 사진 화면에서 삭제
            $img.remove();

            // 삭제할 사진 이름 배열에 담기
            deleteFileNames.push(fileName);

            // 삭제한 사진에 해당하는 input 태그 삭제
            const $input = document.getElementsByName('fileNames');
            for (let item of $input) {
                if (fileName === item.getAttribute('value')) {
                    console.log(item);
                    item.remove();
                }
            }
        })
    });
    // ----------- End JQuery ---------------

    // 파일 삭제 요청
    function deleteFile() {
        const reqInfo = {
            method: 'DELETE'
        };

        for (let fileName of deleteFileNames) {
            console.log(fileName);
            fetch(('/deleteFile?fileName=' + fileName), reqInfo)
                .then(res => res.text())
                .then(msg2 => {
                    console.log(msg2);
                });
        }
    }

    // 게시글 수정 완료
    function edit() {
        // 완료버튼
        const $editBtn = document.getElementById("apply-btn");
        $editBtn.onclick = e => {
            if (document.getElementById('title-input').value === '') {
                alert('제목을 입력해주세요');
                return;
            } else if (document.querySelector('.main-content').value === '') {
                alert('글 내용을 작성해주세요.');
                return;
            }

            if (!confirm("수정하시겠습니까?")) return;

            deleteFile();   // 첨부파일 먼저 삭제
            const $form = document.querySelector("form");
            $form.method = "post";
            $form.action = "/freeboard/edit";
            $form.submit();
        }
    }

    // 수정 취소
    function cancel() {
        // 취소 버튼
        const $cancelBtn = document.getElementById('cancel-btn');
        $cancelBtn.onclick = e => {
            location.href = "/freeboard/detail/${board.boardNo}?pageNum=${page.pageNum}&amount=${page.amount}";
        }
    }

    // 스크롤 높이 계산
    function scrollHeightCal() {
        const $title = document.querySelector('#title-input');
        const $content = document.querySelector('#exampleFormControlTextarea1');
        $title.style.height = $title.scrollHeight + 'px';
        $content.style.height = $content.scrollHeight + 'px';
    }

    (function () {
        edit();
        cancel();
        scrollHeightCal();
    })();
</script>
</body>
</html>
