<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 31.
  Time: 오전 10:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>my page</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@include file="/template/header.jspf" %>


<div class="main">
    <div style="flex: 1">

        <button onclick="location.href='/password-changes'">비밀번호 변경</button>
        <button onclick="location.href='/my-posting'">내가 쓴 글</button>
        <button onclick="location.href='/my-loginHistory'">내 로그인 이력</button>
        <button onclick="location.href='/my-article-like'">좋아요 누른 글</button>

        <button id="deleteBt"onclick="deleteConfirm()">계정삭제</button>
    </div>
    <div style="flex: 4"> <!-- 중앙 -->
        <div><!-- 이미지 베너 -->
            이미지 베너
        </div>

        <div>
            <h2>${member.id}님의 페이지</h2>
            <p>회원 정보</p>
            <div>
                <form action="/my-page" method="post" id="editForm">
                    <div style="margin-top: 5px">
                        <label>아이디<small>(수정 불가)</small></label>
                        <input type="text" name="id" value="${member.id}" readonly>
                    </div>
                    <div style="margin-top: 5px">
                        <label>이름</label>
                        <input type="text" name="name" value="${member.name}" required>
                    </div>
                    <div style="margin-top: 5px">
                        <label>닉네임</label>
                        <input type="text" name="nickname" value="${member.nickname}" required>
                    </div>
                    <div style="margin-top: 5px">
                        <label>이메일</label>
                        <input type="text" name="email" value="${member.email}" required>
                    </div>
                    <div style="margin-top: 5px">
                        <label>이메일 수신 동의</label>
                        <input type="checkbox" name="agree" ${member.agree ? 'checked' : ''}/> 수신동의<br/>
                    </div>
                    <div style="margin-top: 5px">
                        <label>나이</label>
                        <input type="text" name="age" value="${member.age}" required>
                    </div>
                    <div style="margin-top: 5px">
                        <label>관심사</label>
                        <input type="text" name="interest" value="${member.interest}">
                    </div>
                    <%--                    <div style="margin-top: 5px">--%>
                    <%--                        <label>광고성 이메일 수신 동의</label>--%>
                    <%--                        <input type="checkbox" name="agree" value="${member.agree}">--%>
                    <%--                    </div>--%>
                    <div style="margin-top: 5px">
                        <label>회원가입 날짜</label>
                        <input type="text" name="joinAt" value="${member.joinAt}" readonly>
                    </div>
                    <div style="display: flex; justify-content: right; margin-top: 50px">
                        <button type="button" id="editBt" onclick="editConfirm()">수정하기</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div style="flex: 1">
        <h3>Top Writers</h3>
    </div>


</div>

<script>
    function editConfirm() {
        if (window.confirm("정말 수정하시겠습니까?")) {
            document.getElementById("editForm").submit();
        }
    }

    function deleteConfirm(){
        if (window.confirm("정말 탈퇴하시겠습니까?")) {
            location.href="/delete-membership";
        }
    }


</script>

</body>
</html>
