<%--
  Created by IntelliJ IDEA.
  User: SL
  Date: 2022-11-09
  Time: 오후 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<form id="del-form" action="/diary/delete" method="post">
    <input type="hidden" name="diaryNo" value="${diaryNo}">
</form>

<script>
    const $form = document.getElementById('del-form')
    $form.submit();
</script>

</body>
</html>
