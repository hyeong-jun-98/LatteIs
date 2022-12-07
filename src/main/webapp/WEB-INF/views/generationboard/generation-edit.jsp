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
<%@include file="../topbar.jsp"%>

<div class="wrap">

    <div class="content-container">

        <form id="write-form" autocomplete="off" enctype="multipart/form-data">
            <input type="hidden" name="pageNum" value="${page.pageNum}">
            <input type="hidden" name="amount" value="${page.amount}">
            <input type="hidden" name="boardNo" value="${board.boardNo}">
            <input type="hidden" name="generation" value="${board.generation}">

            <h1 class="main-title">연령대별 게시판</h1>
            <div class="board-no-title">
                <span>${board.boardNo}번 게시물 - ${board.generation}년대</span>
            </div>

            <div class="mb-3">
                <label for="writer-input" class="form-label">작성자</label>
                <input type="text" class="form-control" id="writer-input" placeholder="이름" name="writer"
                       value="${board.writer}" readonly>
            </div>
            <div class="mb-3">
                <label for="title-input" class="form-label">글제목</label>
                <textarea type="text" class="form-control" id="title-input" placeholder="제목" name="title"
                          rows="1" oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.title}</textarea>
            </div>

            <div class="mb-3">
                <label for="exampleFormControlTextarea1" class="form-label">내용</label>
                <textarea name="content" class="form-control main-content"
                          id="exampleFormControlTextarea1" oninput="this.style.height = '';this.style.height = this.scrollHeight + 'px'">${board.content}</textarea>
            </div>

            <!-- 첨부파일 드래그 앤 드롭 영역 -->
            <div class="form-group">
                <div class="fileDrop">
                    <span>Drop Here!!</span>
                </div>
                <div class="uploadDiv">
                </div>
                <!-- 업로드된 이미지의 썸네일을 보여줄 영역 -->
                <div class="write-img-uploaded-list">
                </div>
                <!-- 업로드된 파일의 썸네일을 보여줄 영역 -->
                <div class="write-file-uploaded-list">
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
    let deleteFileNames = [];     // 삭제할 파일 이름을 담을 배열

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

        // 수정화면 로딩때 가져온 파일의 확장자에 따른 렌더링 처리
        function checkExtType(fileName) {
            // 원본 파일명 추출
            let originFileName = fileName.substring(fileName.indexOf("_") + 1);

            // 확장자 추출 후, 이미지인지 아닌지 확인
            if (isImageFile(originFileName)) {
                // 이미지 요소 생성
                const $img = document.createElement('img');
                $img.classList.add('img-sizing');
                $img.setAttribute('data-name', originFileName);
                $img.setAttribute('src', '/loadFile?fileName=' + fileName);
                $img.setAttribute('alt', originFileName);
                $('.write-img-uploaded-list').append($img);
            } else {    // 이미지가 아니라면 다운로드 링크를 생성
                const $a = document.createElement('a');
                $a.classList.add('a-sizing');
                $a.setAttribute('data-name', fileName);

                const $i = document.createElement('i');
                $i.classList.add('fas');
                $i.classList.add('fa-file');
                $i.classList.add('fa-4x');
                $i.setAttribute('style', 'display:block');

                $a.append($i);
                $a.innerHTML += '<span>' + originFileName + '</span>'
                $('.write-file-uploaded-list').append($a);
            }
        }

        // 드롭한 파일을 화면에 보여주는 함수
        function showFileData(fileNames) {
            for (let fileName of fileNames) {
                checkExtType(fileName);
            }
        }

        // 이미지 썸네일 보여주기
        function handleFiles(files) {
            for (let i = 0; i < files.length; i++) {
                const file = files[i];
                console.log(file);
                const fileName = file.name;
                // 원본 파일명 추출
                let originFileName = fileName.substring(fileName.indexOf("_") + 1);

                if (isImageFile(originFileName)) {
                    const $img = document.createElement("img");
                    $img.classList.add("img-sizing");
                    $img.setAttribute('data-name', originFileName);
                    $('.write-img-uploaded-list').append($img);

                    const reader = new FileReader();
                    reader.onload = (function (aImg) {
                        return function (e) {
                            aImg.src = e.target.result;
                        };
                    })($img);
                    reader.readAsDataURL(file);

                } else {    // 이미지가 아니라면
                    const $a = document.createElement('a');
                    $a.classList.add('a-sizing');
                    $a.setAttribute('data-name', originFileName);

                    const $i = document.createElement('i');
                    $i.classList.add('fas');
                    $i.classList.add('fa-file');
                    $i.classList.add('fa-4x');
                    $i.setAttribute('style', 'display:block');

                    $a.append($i);
                    $a.innerHTML += '<span>' + originFileName + '</span>'
                    $('.write-file-uploaded-list').append($a);
                }
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

            // 2. file input 태그 생성
            const $fileInput = $('<input>', {type: 'file', name: 'files', style: 'display:none'});
            $('.uploadDiv').append($fileInput);

            // 3. 생성한 input 태그에 드롭한 file 저장
            $fileInput.prop('files', files);

            // 4. 썸네일 보여주기
            handleFiles(files);

        })

        // 파일 목록 불러오기
        fetch('/freeboard/file/' + ${board.boardNo})
            .then(res => res.json())
            .then(fileNames => {
                showFileData(fileNames);
            })

        // 사진 삭제 이벤트
        $(document).on('click', 'img', function () {
            const $img = $(this);   // 클릭한 이미지
            console.log($img);
            const imgSrc = $img.attr("src");     // 이미지에 담긴 경로
            const imgName = imgSrc.substring(imgSrc.indexOf('=') + 1);     // 클릭한 이미지 이름

            const $fileInput = document.getElementsByName('files');     // input file 리스트
            console.log('fileInput의 길이는 ', $fileInput.length);
            if ($fileInput.length === 0) {
                const $hiddenInput = document.createElement('input');
                const $writForm = document.getElementById('write-form');
                $hiddenInput.setAttribute('type', 'hidden');
                $hiddenInput.setAttribute('name', 'editFileNames');
                $hiddenInput.setAttribute('value', imgName);
                $writForm.append($hiddenInput);
            } else {
                for (let item of $fileInput) {
                    if (item.value.substring(item.value.lastIndexOf('\\') + 1) === $img.data('name')) {
                        item.remove();  // 클릭한 이미지의 input 태그 삭제
                    } else if (!(item.value.substring(item.value.lastIndexOf('\\') + 1) === $img.data('name'))) {
                        const $hiddenInput = document.createElement('input');
                        const $writForm = document.getElementById('write-form');
                        $hiddenInput.setAttribute('type', 'hidden');
                        $hiddenInput.setAttribute('name', 'editFileNames');
                        $hiddenInput.setAttribute('value', imgName);
                        $writForm.append($hiddenInput);
                    }
                }
            }

            // 클릭한 사진 화면에서 삭제
            $img.remove();

            // 삭제할 사진 이름 배열에 담기
            deleteFileNames.push(imgName);
        })

        // 파일 삭제 이벤트
        $(document).on('click', 'a', function () {
            const $file = $(this);   // 클릭한 이미지
            console.log($file);
            const fileName = $file.data('name');     // 이미지에 담긴 경로
            console.log('파일 이름은 ', fileName);

            const $fileInput = document.getElementsByName('files');     // input file 리스트
            console.log('fileInput의 길이는 ', $fileInput.length);
            if ($fileInput.length === 0) {
                const $hiddenInput = document.createElement('input');
                const $writForm = document.getElementById('write-form');
                $hiddenInput.setAttribute('type', 'hidden');
                $hiddenInput.setAttribute('name', 'editFileNames');
                $hiddenInput.setAttribute('value', fileName);
                $writForm.append($hiddenInput);
            } else {
                for (let item of $fileInput) {
                    if (item.value.substring(item.value.lastIndexOf('\\') + 1) === $file.data('name')) {
                        item.remove();  // 클릭한 이미지의 input 태그 삭제
                    } else if (!(item.value.substring(item.value.lastIndexOf('\\') + 1) === $file.data('name'))) {
                        const $hiddenInput = document.createElement('input');
                        const $writForm = document.getElementById('write-form');
                        $hiddenInput.setAttribute('type', 'hidden');
                        $hiddenInput.setAttribute('name', 'editFileNames');
                        $hiddenInput.setAttribute('value', fileName);
                        $writForm.append($hiddenInput);
                    }
                }
            }

            $file.remove();  // 화면에서 삭제

            // 삭제할 사진 이름 배열에 담기
            deleteFileNames.push(fileName);
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
    function edit(){
        // 완료버튼
        const $editBtn = document.getElementById("apply-btn");
        $editBtn.onclick=e=>{
            if (document.getElementById('title-input').value === '') {
                alert('제목을 입력해주세요');
                return;
            } else if (document.querySelector('.main-content').value === '') {
                alert('글 내용을 작성해주세요.');
                return;
            }

            if (!confirm("수정하시겠습니까?"))return;

            deleteFile();   // 첨부파일 먼저 삭제

            const $form = document.querySelector("form");
            $form.method="post";
            $form.action="/generation/edit";
            $form.submit();
        }
    }

    // 수정 취소
    function cancel(){
        // 취소 버튼
        const $cancelBtn = document.getElementById('cancel-btn');
        $cancelBtn.onclick = e =>{
            location.href = "/generation/detail/${board.boardNo}?pageNum=${page.pageNum}&amount=${page.amount}";
        }
    }

    // 스크롤 높이 계산
    function scrollHeightCal(){
        const $title = document.querySelector('#title-input');
        const $content = document.querySelector('#exampleFormControlTextarea1');
        $title.style.height = $title.scrollHeight + 'px';
        $content.style.height = $content.scrollHeight + 'px';
    }

    (function(){
        edit();
        cancel();
        scrollHeightCal();
    })();
</script>
</body>
</html>
