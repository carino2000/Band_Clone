<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 11. 3.
  Time: 오전 10:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>my-posting</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@include file="/template/header.jspf" %>
<div class="main">
    <div style="flex: 1">

    </div>
    <div style="flex: 4"> <!-- 중앙 -->

        <p style="margin-top: 20px">----------------- 내가 쓴 글 -----------------</p>
        <c:forEach items="${writerId}" var="one">
            <div class="article-item">
                <div style="display: flex; justify-content: space-between">
                    <div>
                        <span>${one.writerId}님이 작성한 글 입니다.</span>
                        <span>&middot; <small>${one.wroteAt}에 작성함</small></span>
                    </div>
                </div>
                <div>
                    <a href="/band?no=${one.bandNo}" class="article-link">
                        <span style="font-size: 1.1rem; font-weight: 500"><c:out value="${one.content}"/> </span>
                    </a>
                </div>
            </div>
        </c:forEach>

    </div>
</div>
<div style="flex: 1">

</div>
</div>

</body>
</html>