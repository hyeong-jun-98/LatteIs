<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>퀴즈</title>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- Core theme CSS (includes Bootstrap)-->
    <%--    <link href="/css/topbar.css" rel="stylesheet"/>--%>

    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">
    <link href="/css/index.css" rel="stylesheet">
    <link href="/css/quiz-write.css" rel="stylesheet">

    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />
        <link rel="stylesheet" href="css/animations.css">
    <style>
        .main-content * {
            font-size: 20px;
        }

        #palette span {
            font-size: 15px;
        }

        .sub-content {
            display: flex;
            justify-content: space-between;
        }

        .btn-write {
            display: flex;
            justify-content: end;
            margin-top: 10px;
        }

        .main-content .main-title {
            font-size: 30px;
            font-weight: 700;
            text-align: center;
            border-bottom: 2px solid rgb(75, 73, 73);
            padding: 0 20px 15px;
            width: fit-content;
            margin: 20px auto 30px;
        }
        /*====================================*/
        @media screen and (max-width: 390px) {

            .my-img {
                width: 100%;
                height: 100%;
            }

            .wrap {
                width: 100%;
                margin: 0 auto;
                padding: 5%;
            }

            .main-content {
                 margin: 100px auto;
             }

        }
    </style>
</head>
<body>
<%@include file="../topbar.jsp" %>

<div class="wrap">
    <div class="main-content wrap">

        <h1 class="main-title">퀴즈</h1>

        <form id="write-form" autocomplete="off" enctype="multipart/form-data">
            <input type="hidden" name="userNickname" value="${loginUser.userNickname}">

            점수 :
            <select id="quiz-score" name="quizScore">
                <option value="">점수를 선택하세요.</option>
                <option value="100">100</option>
                <option value="200">200</option>
                <option value="300">300</option>
                <option value="400">400</option>
                <option value="500">500</option>
            </select>

            <div class="mb-3">
                <label for="writer-input" class="form-label">출제자</label>
                <input type="text" class="form-control" id="writer-input" placeholder="이름"
                       name="quizWriter" value="${loginUser.userNickname}" readonly>
            </div>

            <div class="mb-3">
                <label for="answer-input" class="form-label">정답</label>
                <input type="text" class="form-control" id="answer-input" placeholder="10글자 이내의 단어" name="quizAnswer">
            </div>

            <canvas id="canvas" class="my-img"></canvas>
            <div class="sub-content">
                <div id="palette">
                    <span class="red color">red</span>
                    <span class="orange color">orange</span>
                    <span class="yellow color">yellow</span>
                    <span class="green color">green</span>
                    <span class="blue color">blue</span>
                    <span class="navy color">navy</span>
                    <span class="purple color">purple</span>
                    <span class="black color">black</span>
                    <span class="white color">white</span>
                    <span class="gray color">gray</span>
                    &nbsp; &nbsp;
                    <span class="clear">지우기</span>
                    <span class="fill">채우기</span>
                    <br>
                    <span class="pink color">pink</span>
                    <span class="brown color">brown</span>
                    <span class="skyblue color">skyblue</span>
                    <br>
                    <br>
                </div>
                <div id="weight">
                    굵기 :
                    <select id="line-width">
                        <option value="">굵기를 선택하세요.</option>
                        <option value="3">3</option>
                        <option value="5">5</option>
                        <option value="7">7</option>
                        <option value="10">10</option>
                        <option value="15">15</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                    </select>
                </div>
            </div>
        </form>


        <div class="btn-write">
            <button id="btn-write" type="button" class="btn btn-warning">작성하기</button>
        </div>
    </div>

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>

    // ----------------- 정답 유효성 검사 --------------------
    $('#answer-input').on('keyup', function (e) {
        if ($(this).val().length > 10) {
            alert('정답을 10자 이내로 입력하세요.');
            $(this).val($(this).val().substring(0, 10));
        }
    });

    const canvas = document.querySelector("#canvas");
    const ctx = canvas.getContext("2d");
    const width = 945;
    const height = 600;

    canvas.width = width;
    canvas.height = height;
    canvas.style.marginBottom = "10px";
    canvas.style.border = "3px solid black";

    let painting = false;

    function stopPainting(event) {
        painting = false;
    }

    function startPainting() {
        painting = true;
    }

    ctx.lineWidth = 3;

    function onMouseMove(event) {
        const x = event.offsetX;
        const y = event.offsetY;
        if (!painting) {
            ctx.beginPath();
            ctx.moveTo(x, y);
        } else {
            ctx.lineTo(x, y);
            ctx.stroke();
        }
    }

    if (canvas) {
        canvas.addEventListener("mousemove", onMouseMove);
        canvas.addEventListener("mousedown", startPainting);
        canvas.addEventListener("mouseup", stopPainting);
        canvas.addEventListener("mouseleave", stopPainting);
    }

    document.querySelector("#palette").style.marginLeft = "10px";
    const buttons = [
        "red",
        "orange",
        "yellow",
        "green",
        "blue",
        "navy",
        "purple",
        "black",
        "white",
        "gray",
        "pink",
        "brown",
        "skyblue",
        "clear",
        "fill"
    ];
    function btnreset(){
        buttons.forEach((content) =>{
            let button = document.querySelector(`.\${content}`);
            button.style.boxShadow= "1px 2px 2px gray";
            button.className=content;
        });
    };
    let lineColor = "black";
    buttons.forEach((content) => {
        let button = document.querySelector(`.\${content}`);

        if (content === "clear" || content === "fill") {
            button.style.background = "rgba(100,100,100,0.2)";
        } else {
            button.style.background = content;
        }
        button.style.color = "white";
        button.style.display = "inline-block";
        button.style.textShadow =
            "1px 0 black, 0 1px black, 1px 0 black, 0 -1px black";
        button.style.lineHeight = "22px";
        button.style.textAlign = "center";
        button.style.width = "50px";
        button.style.height = "20px";
        button.style.borderRadius = "25px";
        button.style.boxShadow = "1px 2px 2px gray";
        button.style.marginBottom = "10px";
        button.onclick = () => {
            ctx.strokeStyle = content;
            lineColor = content;
            btnreset();
            button.className=content+" animate__animated animate__bounce";
            button.style.boxShadow="0.2px 2px 10px 2px "+ content;
        };

    });


    document.querySelector(".clear").onclick = () => {
        ctx.clearRect(0, 0, width, height);
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, width, height);
    };

    document.querySelector(".fill").onclick = () => {
        ctx.fillStyle = lineColor;
        ctx.fillRect(0, 0, width, height);
    };


    // 굵기 변경
    const $lineWidth = document.getElementById('line-width');
    $lineWidth.onchange = e => {
        if (e.target.value === '3' || e.target.value === '') {
            console.log(e.target.value);
            ctx.lineWidth = 3;
        } else if (e.target.value === '5') {
            console.log(e.target.value);
            ctx.lineWidth = 5;
        } else if (e.target.value === '7') {
            ctx.lineWidth = 7;
        } else if (e.target.value === '10') {
            ctx.lineWidth = 10;
        } else if (e.target.value === '15') {
            ctx.lineWidth = 15;
        } else if (e.target.value === '20') {
            ctx.lineWidth = 20;
        } else if (e.target.value === '20') {
            ctx.lineWidth = 20;
        } else if (e.target.value === '30') {
            ctx.lineWidth = 30;
        } else if (e.target.value === '40') {
            ctx.lineWidth = 40;
        } else if (e.target.value === '50') {
            ctx.lineWidth = 50;
        }
    }


    // 퀴즈 작성하기
    function write() {
        const $btnWrite = document.getElementById('btn-write');
        $btnWrite.onclick = e => {

            if (document.querySelector('select').value === "") {
                alert('점수를 선택해주세요.');
                return;
            } else if (document.getElementById('answer-input').value === '') {
                alert('정답을 입력해주세요.');
                return;
            } else if (canvas.toDataURL() === 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAA7EAAADWCAYAAAAHOgUmAAAAAXNSR0IArs4c6QAAD79JREFUeF7t18EJADAMA7F2/6Fd6BYHygRGzsd3244jQIAAAQIECBAgQIAAAQIBgWvEBloSkQABAgQIECBAgAABAgS+gBHrEQgQIECAAAECBAgQIEAgI2DEZqoSlAABAgQIECBAgAABAgSMWD9AgAABAgQIECBAgAABAhkBIzZTlaAECBAgQIAAAQIECBAgYMT6AQIECBAgQIAAAQIECBDICBixmaoEJUCAAAECBAgQIECAAAEj1g8QIECAAAECBAgQIECAQEbAiM1UJSgBAgQIECBAgAABAgQIGLF+gAABAgQIECBAgAABAgQyAkZspipBCRAgQIAAAQIECBAgQMCI9QMECBAgQIAAAQIECBAgkBEwYjNVCUqAAAECBAgQIECAAAECRqwfIECAAAECBAgQIECAAIGMgBGbqUpQAgQIECBAgAABAgQIEDBi/QABAgQIECBAgAABAgQIZASM2ExVghIgQIAAAQIECBAgQICAEesHCBAgQIAAAQIECBAgQCAjYMRmqhKUAAECBAgQIECAAAECBIxYP0CAAAECBAgQIECAAAECGQEjNlOVoAQIECBAgAABAgQIECBgxPoBAgQIECBAgAABAgQIEMgIGLGZqgQlQIAAAQIECBAgQIAAASPWDxAgQIAAAQIECBAgQIBARsCIzVQlKAECBAgQIECAAAECBAgYsX6AAAECBAgQIECAAAECBDICRmymKkEJECBAgAABAgQIECBAwIj1AwQIECBAgAABAgQIECCQETBiM1UJSoAAAQIECBAgQIAAAQJGrB8gQIAAAQIECBAgQIAAgYyAEZupSlACBAgQIECAAAECBAgQMGL9AAECBAgQIECAAAECBAhkBIzYTFWCEiBAgAABAgQIECBAgIAR6wcIECBAgAABAgQIECBAICNgxGaqEpQAAQIECBAgQIAAAQIEjFg/QIAAAQIECBAgQIAAAQIZASM2U5WgBAgQIECAAAECBAgQIGDE+gECBAgQIECAAAECBAgQyAgYsZmqBCVAgAABAgQIECBAgAABI9YPECBAgAABAgQIECBAgEBGwIjNVCUoAQIECBAgQIAAAQIECBixfoAAAQIECBAgQIAAAQIEMgJGbKYqQQkQIECAAAECBAgQIEDAiPUDBAgQIECAAAECBAgQIJARMGIzVQlKgAABAgQIECBAgAABAkasHyBAgAABAgQIECBAgACBjIARm6lKUAIECBAgQIAAAQIECBAwYv0AAQIECBAgQIAAAQIECGQEjNhMVYISIECAAAECBAgQIECAgBHrBwgQIECAAAECBAgQIEAgI2DEZqoSlAABAgQIECBAgAABAgSMWD9AgAABAgQIECBAgAABAhkBIzZTlaAECBAgQIAAAQIECBAgYMT6AQIECBAgQIAAAQIECBDICBixmaoEJUCAAAECBAgQIECAAAEj1g8QIECAAAECBAgQIECAQEbAiM1UJSgBAgQIECBAgAABAgQIGLF+gAABAgQIECBAgAABAgQyAkZspipBCRAgQIAAAQIECBAgQMCI9QMECBAgQIAAAQIECBAgkBEwYjNVCUqAAAECBAgQIECAAAECRqwfIECAAAECBAgQIECAAIGMgBGbqUpQAgQIECBAgAABAgQIEDBi/QABAgQIECBAgAABAgQIZASM2ExVghIgQIAAAQIECBAgQICAEesHCBAgQIAAAQIECBAgQCAjYMRmqhKUAAECBAgQIECAAAECBIxYP0CAAAECBAgQIECAAAECGQEjNlOVoAQIECBAgAABAgQIECBgxPoBAgQIECBAgAABAgQIEMgIGLGZqgQlQIAAAQIECBAgQIAAASPWDxAgQIAAAQIECBAgQIBARsCIzVQlKAECBAgQIECAAAECBAgYsX6AAAECBAgQIECAAAECBDICRmymKkEJECBAgAABAgQIECBAwIj1AwQIECBAgAABAgQIECCQETBiM1UJSoAAAQIECBAgQIAAAQJGrB8gQIAAAQIECBAgQIAAgYyAEZupSlACBAgQIECAAAECBAgQMGL9AAECBAgQIECAAAECBAhkBIzYTFWCEiBAgAABAgQIECBAgIAR6wcIECBAgAABAgQIECBAICNgxGaqEpQAAQIECBAgQIAAAQIEjFg/QIAAAQIECBAgQIAAAQIZASM2U5WgBAgQIECAAAECBAgQIGDE+gECBAgQIECAAAECBAgQyAgYsZmqBCVAgAABAgQIECBAgAABI9YPECBAgAABAgQIECBAgEBGwIjNVCUoAQIECBAgQIAAAQIECBixfoAAAQIECBAgQIAAAQIEMgJGbKYqQQkQIECAAAECBAgQIEDAiPUDBAgQIECAAAECBAgQIJARMGIzVQlKgAABAgQIECBAgAABAkasHyBAgAABAgQIECBAgACBjIARm6lKUAIECBAgQIAAAQIECBAwYv0AAQIECBAgQIAAAQIECGQEjNhMVYISIECAAAECBAgQIECAgBHrBwgQIECAAAECBAgQIEAgI2DEZqoSlAABAgQIECBAgAABAgSMWD9AgAABAgQIECBAgAABAhkBIzZTlaAECBAgQIAAAQIECBAgYMT6AQIECBAgQIAAAQIECBDICBixmaoEJUCAAAECBAgQIECAAAEj1g8QIECAAAECBAgQIECAQEbAiM1UJSgBAgQIECBAgAABAgQIGLF+gAABAgQIECBAgAABAgQyAkZspipBCRAgQIAAAQIECBAgQMCI9QMECBAgQIAAAQIECBAgkBEwYjNVCUqAAAECBAgQIECAAAECRqwfIECAAAECBAgQIECAAIGMgBGbqUpQAgQIECBAgAABAgQIEDBi/QABAgQIECBAgAABAgQIZASM2ExVghIgQIAAAQIECBAgQICAEesHCBAgQIAAAQIECBAgQCAjYMRmqhKUAAECBAgQIECAAAECBIxYP0CAAAECBAgQIECAAAECGQEjNlOVoAQIECBAgAABAgQIECBgxPoBAgQIECBAgAABAgQIEMgIGLGZqgQlQIAAAQIECBAgQIAAASPWDxAgQIAAAQIECBAgQIBARsCIzVQlKAECBAgQIECAAAECBAgYsX6AAAECBAgQIECAAAECBDICRmymKkEJECBAgAABAgQIECBAwIj1AwQIECBAgAABAgQIECCQETBiM1UJSoAAAQIECBAgQIAAAQJGrB8gQIAAAQIECBAgQIAAgYyAEZupSlACBAgQIECAAAECBAgQMGL9AAECBAgQIECAAAECBAhkBIzYTFWCEiBAgAABAgQIECBAgIAR6wcIECBAgAABAgQIECBAICNgxGaqEpQAAQIECBAgQIAAAQIEjFg/QIAAAQIECBAgQIAAAQIZASM2U5WgBAgQIECAAAECBAgQIGDE+gECBAgQIECAAAECBAgQyAgYsZmqBCVAgAABAgQIECBAgAABI9YPECBAgAABAgQIECBAgEBGwIjNVCUoAQIECBAgQIAAAQIECBixfoAAAQIECBAgQIAAAQIEMgJGbKYqQQkQIECAAAECBAgQIEDAiPUDBAgQIECAAAECBAgQIJARMGIzVQlKgAABAgQIECBAgAABAkasHyBAgAABAgQIECBAgACBjIARm6lKUAIECBAgQIAAAQIECBAwYv0AAQIECBAgQIAAAQIECGQEjNhMVYISIECAAAECBAgQIECAgBHrBwgQIECAAAECBAgQIEAgI2DEZqoSlAABAgQIECBAgAABAgSMWD9AgAABAgQIECBAgAABAhkBIzZTlaAECBAgQIAAAQIECBAgYMT6AQIECBAgQIAAAQIECBDICBixmaoEJUCAAAECBAgQIECAAAEj1g8QIECAAAECBAgQIECAQEbAiM1UJSgBAgQIECBAgAABAgQIGLF+gAABAgQIECBAgAABAgQyAkZspipBCRAgQIAAAQIECBAgQMCI9QMECBAgQIAAAQIECBAgkBEwYjNVCUqAAAECBAgQIECAAAECRqwfIECAAAECBAgQIECAAIGMgBGbqUpQAgQIECBAgAABAgQIEDBi/QABAgQIECBAgAABAgQIZASM2ExVghIgQIAAAQIECBAgQICAEesHCBAgQIAAAQIECBAgQCAjYMRmqhKUAAECBAgQIECAAAECBIxYP0CAAAECBAgQIECAAAECGQEjNlOVoAQIECBAgAABAgQIECBgxPoBAgQIECBAgAABAgQIEMgIGLGZqgQlQIAAAQIECBAgQIAAASPWDxAgQIAAAQIECBAgQIBARsCIzVQlKAECBAgQIECAAAECBAgYsX6AAAECBAgQIECAAAECBDICRmymKkEJECBAgAABAgQIECBAwIj1AwQIECBAgAABAgQIECCQETBiM1UJSoAAAQIECBAgQIAAAQJGrB8gQIAAAQIECBAgQIAAgYyAEZupSlACBAgQIECAAAECBAgQMGL9AAECBAgQIECAAAECBAhkBIzYTFWCEiBAgAABAgQIECBAgIAR6wcIECBAgAABAgQIECBAICNgxGaqEpQAAQIECBAgQIAAAQIEjFg/QIAAAQIECBAgQIAAAQIZASM2U5WgBAgQIECAAAECBAgQIGDE+gECBAgQIECAAAECBAgQyAgYsZmqBCVAgAABAgQIECBAgAABI9YPECBAgAABAgQIECBAgEBGwIjNVCUoAQIECBAgQIAAAQIECBixfoAAAQIECBAgQIAAAQIEMgJGbKYqQQkQIECAAAECBAgQIEDAiPUDBAgQIECAAAECBAgQIJARMGIzVQlKgAABAgQIECBAgAABAkasHyBAgAABAgQIECBAgACBjIARm6lKUAIECBAgQIAAAQIECBAwYv0AAQIECBAgQIAAAQIECGQEjNhMVYISIECAAAECBAgQIECAgBHrBwgQIECAAAECBAgQIEAgI2DEZqoSlAABAgQIECBAgAABAgSMWD9AgAABAgQIECBAgAABAhkBIzZTlaAECBAgQIAAAQIECBAgYMT6AQIECBAgQIAAAQIECBDICBixmaoEJUCAAAECBAgQIECAAAEj1g8QIECAAAECBAgQIECAQEbAiM1UJSgBAgQIECBAgAABAgQIGLF+gAABAgQIECBAgAABAgQyAkZspipBCRAgQIAAAQIECBAgQMCI9QMECBAgQIAAAQIECBAgkBEwYjNVCUqAAAECBAgQIECAAAECRqwfIECAAAECBAgQIECAAIGMgBGbqUpQAgQIECBAgAABAgQIEDBi/QABAgQIECBAgAABAgQIZASM2ExVghIgQIAAAQIECBAgQICAEesHCBAgQIAAAQIECBAgQCAjYMRmqhKUAAECBAgQIECAAAECBIxYP0CAAAECBAgQIECAAAECGQEjNlOVoAQIECBAgAABAgQIECDwAM03VawGB7l4AAAAAElFTkSuQmCC') {
                alert('그림을 그려주세요.');
                return;
            }

            if (!confirm('작성하시겠습니까?')) return;
            const $writeForm = document.getElementById('write-form');
            const $input = document.createElement('input');
            $input.setAttribute("type", "text");
            $input.setAttribute("name", "fileName");
            $input.setAttribute("value", canvas.toDataURL());
            $writeForm.append($input);

            $writeForm.method = 'POST';
            $writeForm.action = '/quiz/write';
            $writeForm.submit();
        }

    }

    (function () {
        ctx.fillStyle = 'white';
        ctx.fillRect(0, 0, width, height);

        // 퀴즈 작성
        write();
    })();

</script>

</body>


</html>
