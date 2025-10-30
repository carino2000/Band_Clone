<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 29.
  Time: 오후 5:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>join-form</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@include file="/template/header.jspf" %>
<div class="signup-wrap">
    <div class="signup">
        <h2 class="text-center">${band.name} 밴드의 가입 신청 폼</h2>
        <form class="signup-form" action="/band/join" method="post">
            <input type="hidden" name="bandNo" value="${band.no}"/>
            <div>
                <label for="id"><small>아이디</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="id" id="id" value="${member.id}" readonly/>
                </div>
            </div>
            <div>
                <label for="nickname"><small>닉네임</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="nickname" id="nickname" placeholder="${band.name}밴드에서만 사용하는 별명을 작성해주세요~! (공란시 기존 닉네임)" autofocus/>
                </div>
            </div>
            <div>
                <label for="greeting"><small>가입 인사말</small></label>
                <div class="mt-1">
                    <textarea class="input-100" name="greeting" id="greeting" placeholder="가입 인사말을 작성해주세요!" required></textarea>
                </div>
            </div>

            <div>
                <button class="bt-submit" id="loginbt">가입 신청하기</button>
            </div>
        </form>

    </div>

</div>

</body>
</html>
