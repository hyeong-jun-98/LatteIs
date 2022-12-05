<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>메인페이지</title>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>

    <!-- Core theme CSS (includes Bootstrap)-->
    <%--    <link href="/css/topbar.css" rel="stylesheet"/>--%>

    <%--  topbar  --%>
    <link href="/css/topbar.css" rel="stylesheet">
    <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"
    />
    <link href="/css/index.css" rel="stylesheet">

    <%--    <link rel="stylesheet" href="css/animations.css">--%>

    <style>
        .ready {
            width: 50%;
            margin: 300px auto;
        }
        span {
            display: flex;
            justify-content: center;
            font-size: 100px;
        }
    </style>
</head>
<body>
<%@include file="../topbar.jsp" %>

    <div class="ready">
        <span>준비중입니다용..!</span>
    </div>
</body>


</html>
