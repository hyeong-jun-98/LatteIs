<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>Title</title>
</head>
<body>

<form id="del-form" action="/quiz/delete" method="post">
    <input type="hidden" name="quizNo" value="${quizNo}">
    <input type="hidden" name="pageNum" value="${diaryPage.pageNum}">
    <input type="hidden" name="amount" value="${diaryPage.amount}">
</form>

<script>
    const $form = document.getElementById('del-form')
    $form.submit();
</script>

</body>
</html>
