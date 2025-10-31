<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 31.
  Time: 오후 4:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>가제 - 게시글 수정</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="main">
    <div style="flex:1"><!-- 인기 유저 목록 -->
        인기 유저 목록
    </div>
    <div style="flex:4"><!-- 글쓰기 폼 -->
        <div>
            <h2>게시글 수정하기</h2>
        </div>
        <div>
            <form action="/article/edit" method="post">
                <input type="hidden" name="id" value="${article.writerId}">
                <input type="hidden" name="idx" value="${article.idx}">
                <input type="hidden" name="bandNo" value="${bandNo}">

                <div style="margin-top: 10px">
                    <label>본문</label>
                    <div>
                        <label>
                            <textarea name="content" class="input-100"
                                      style="height: 300px; resize: none">${article.content}</textarea>
                        </label>
                    </div>
                </div>
                <div style="display: flex; justify-content: space-between; margin-top: 50px">
                    <button type="reset">지우기</button>
                    <button type="submit">수정하기</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
