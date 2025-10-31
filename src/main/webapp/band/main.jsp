<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 28.
  Time: 오후 1:00
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

        </div>

        <div>
            <p style="margin-top: 10px">----------------- 내가 만든 밴드 노출 -----------------</p>
            <c:forEach items="${myBands}" var="one">
                <div class="article-item">
                    <div style="display: flex; justify-content: space-between">
                        <div>
                            <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                <span class="article-topic text-gray">${topic}
<%--                                    <c:if test="${!st.last}"> |</c:if>--%>
                                </span>
                            </c:forEach>
                            <span>${one.masterId}님의 밴드</span>
                            <span>&middot; <small>${one.prettyCreatedAt}에 창설됨</small></span>
                        </div>
                    </div>
                    <div>
                        <a href="/band?no=${one.no}" class="article-link">
                            <span style="font-size: 1.1rem; font-weight: 500"><c:out value="${one.name}"/> </span>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <div>
            <p style="margin-top: 20px">----------------- 내가 가입한 밴드 노출 -----------------</p>
            <c:forEach items="${joinedBands}" var="one">
                <div class="article-item">
                    <div style="display: flex; justify-content: space-between">
                        <div>
                            <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                <span class="article-topic text-gray">${topic}
<%--                                    <c:if test="${!st.last}"> |</c:if>--%>
                                </span>
                            </c:forEach>
                            <span>${one.masterId}님의 밴드</span>
                            <span>&middot; <small>${one.prettyCreatedAt}에 창설됨 <c:if test="${!one.approved}">(가입 승인 대기 중)</c:if> </small></span>
                        </div>
                    </div>
                    <div>
                        <a href="/band?no=${one.no}" class="article-link">
                            <span style="font-size: 1.1rem; font-weight: 500"><c:out value="${one.name}"/> </span>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div>
            <p style="margin-top: 20px">----------------- ${keyword == '' ? '전체 밴드 노출' : '검색한 밴드 노출'} -----------------</p>
            <c:forEach items="${keywordBands}" var="one">
                <div class="article-item">
                    <div style="display: flex; justify-content: space-between">
                        <div>
                            <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                <span class="article-topic text-gray">${topic}</span>
                            </c:forEach>
                            <span>${one.masterId}님의 밴드</span>
                            <span>&middot; <small>${one.prettyCreatedAt}에 창설됨</small></span>
                        </div>
                    </div>
                    <div>
                        <a href="/band?no=${one.no}" class="article-link">
                            <span style="font-size: 1.1rem; font-weight: 500"><c:out value="${one.name}"/> </span>
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

