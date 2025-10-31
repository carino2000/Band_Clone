<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 30.
  Time: 오후 6:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>my notice</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@include file="/template/header.jspf" %>

<div class="main">
    <div style="flex: 1">

    </div>
    <div style="flex: 4"> <!-- 중앙 -->
        <h2>${member.nickname}님의 알림</h2>

        <h3>--- 밴드 가입 요청 목록 ---</h3>
        <div>
            <c:forEach var="one" items="${requestList}">
                <div class="request-item"
                     style="margin-bottom:12px; padding:10px; border:1px solid #eee; border-radius:8px;">
                    <p>
                        <strong><c:out value="${one.memberId}"/></strong>님의
                        <strong><c:out value="${one.bandName}"/></strong> 밴드 가입 신청 - <small>${one.prettyRequestAt}
                    </p>
                    <p>[<c:out value="${one.memberNickname}"/>]님의 인사말: <c:out value="${one.greeting}"/></p>

                    <!-- 승인/거절 버튼 폼 -->
                    <form action="/my/notice" method="post" style="margin-top:6px;">
                        <input type="hidden" name="bandNo" value="${one.bandNo}"/>
                        <input type="hidden" name="memberId" value="${one.memberId}"/>

                        <button type="submit" name="approve" value="true" style="margin-right:6px;">승인</button>
                        <button type="submit" name="approve" value="false">거절</button>
                    </form>
                </div>
            </c:forEach>
        </div>
        <h3>--- ${member.id}님이 받은 메세지 ---</h3>
        <div>
            <c:forEach var="one" items="${msgList}">
                <div class="request-item"
                     style="margin-bottom:12px; padding:10px; border:1px solid #eee; border-radius:8px;">
                    <p>
                        <strong><c:out value="${one.writerId}"/></strong>님에게 온 메세지
                        <strong><c:out value="${one.content}"/></strong> 밴드 가입 신청 - <small>${one.prettyWroteAt}
                    </p>
                    <form action="/my/notice" method="post" style="margin-top:6px;">
                        <input type="hidden" name="msgIdx" value="${one.idx}"/>

                        <button type="submit" name="deleteMsg" value="true" style="margin-right:6px;">확인/삭제</button>
                    </form>
                </div>
            </c:forEach>
        </div>

    </div>
    <div style="flex: 1">

    </div>

</div>

</body>
</html>

