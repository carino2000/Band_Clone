<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 29.
  Time: 오전 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>band main</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@include file="/template/header.jspf" %>


<div class="main">
    <div style="flex: 1">

    </div>
    <div style="flex: 4"> <!-- 중앙 -->
        <div><!-- 이미지 베너 -->
            이미지 베너
        </div>
        <div>
            <span>${band.name}</span>
        </div>

        <div>
            <form action="/band/new-article" method="post">
                <input type="hidden" value="${band.no}" name="bandNo"/>
                <div>
                    <textarea name="content" id="content" placeholder="새로운 소식을 남겨보세요."></textarea>
                </div>
                <button>게시</button>
            </form>
        </div>


        <div>
            <c:forEach items="${articles}" var="one">
                <div>
                    <span>${one.writerId}</span>
                    <span>${one.prettyWroteAt}</span>
                </div>
                <div class="article-item">
                    <div>
                        <span style="font-size: 1.1rem; font-weight: 500"><c:out value="${one.content}"/> </span>
                    </div>
                </div>
                <div>
                    <c:if test="${auth}">
                        <p>${member.nickname}님의 의견을 남겨주세요</p>
                    </c:if>

                    <div>
                        <form action="/band" method="post">
                            <input type="text" name="comment" id="comment" class="input" style="width: 500px"
                                   placeholder="댓글을 남겨주세요">
                            <input type="hidden" name="articleNo" value="${one.idx}">
                            <input type="hidden" name="bandNo" value="${band.no}">
                            <button onclick="reactionHandle(${auth})">작성하기</button>
                        </form>
                    </div>
                </div>
                <div>
                    <ul>
                        <c:forEach items="${one.articleComments}" var="c">
                            <li>${c.writerId} : ${c.comment} - (${c.prettyWritingTime})</li>
                        </c:forEach>
                    </ul>
                </div>
            </c:forEach>
        </div>


    </div>
    <div style="flex: 1">

    </div>


</div>

</body>
</html>

