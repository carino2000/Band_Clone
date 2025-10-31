<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 28.
  Time: 오전 9:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>index</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<c:choose>
    <c:when test="${msg == 1}">
        <script>
            window.alert("회원 정보 수정 완료\n다시 로그인해주세요.");
        </script>
    </c:when>
</c:choose>
<%@include file="/template/header.jspf"%>

</body>
</html>
