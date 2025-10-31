<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 31.
  Time: 오후 12:25
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
    <!-- 검색 영역 -->
    <div style="padding: 0.5rem 0rem; text-align: center">
        <form action="/band-search" id="search-form" onsubmit="keywordConfirm(event)">
            <input type="text" name="keyword" id="keyword" class="input" style="width: 200px"
                   placeholder="커뮤니티 내에서 검색"
                   value="${keyword}"/>
        </form>
    </div>
    <!-- 전체 보기 -->
    <div style="padding: 0.5rem 0rem">
        <a href="/band-search">
            <button>전체 밴드 보기</button>
        </a>
    </div>
    <div style="flex: 4"> <!-- 중앙 -->
        <div>
            <p style="margin-top: 20px">----------------- ${keyword == '' ? '전체 밴드 노출' : keyword+='에 대한 검색한 밴드 노출'}
                -----------------</p>
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
    <script>
        function keywordConfirm(event) {

            const keyword = document.getElementById("keyword").value.trim();

            if (keyword === "") {
                window.alert("빈칸으로 검색할 수 없습니다. 정보를 입력해주세요.");
                event.preventDefault();
                return;
            }
            const regex = /^[a-zA-Z0-9가-힣]{3,}$/;
            if (!regex.test(keyword)) {
                window.alert("영어, 숫자, 한글 중 3글자 이상 입력해야 검색이 가능합니다.");
                event.preventDefault();
                return;
            }


        }
    </script>
</div>

</body>
</html>
