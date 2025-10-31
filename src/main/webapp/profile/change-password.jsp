<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 24.
  Time: 오후 3:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>change password</title>
</head>
<body>
<div style="text-align: center">
    <div>
        <h2>비밀번호 변경</h2>
    </div>
    <div>
        <form id="changePw" action="/password-changes" method="post">
            <div>
                <label>현재 비밀번호</label>
                <input type="password" name="pw" id="pw" required autofocus/>
            </div>
            <div>
                <label>신규 비밀번호</label>
                <input type="password" name="newPw" id="newPw" placeholder="최소 6자 이상" required/>
            </div>
            <div>
                <label>신규 비밀번호 확인</label>
                <input type="password" name="checkNewPw" id="checkNewPw" required/>
            </div>
            <div style="text-align: center">
                <button id="changeBt" type="submit" onclick="checkAbleEdit()">비밀번호 변경</button>
            </div>
        </form>

    </div>
    <c:if test="${mainError != null}">
        <div class="error-main">
            <b>비밀번호 변경 실패</b><br/>
                ${mainError}
        </div>
    </c:if>
</div>


<script>
    const inputPw = document.getElementById("pw");
    const inputNewPw = document.getElementById("newPw");
    const inputCheckNewPw = document.getElementById("checkNewPw");
    const inputChangePw = document.getElementById("changePw");


    function checkAbleEdit(){
        if(inputNewPw.value !== inputCheckNewPw.value){
            window.alert("새로운 비밀번호가 서로 일치하지 않습니다.");
        }else{
            if (window.confirm("비밀번호를 수정하시겠습니까?")) {
                inputChangePw.submit();
            }
        }
    }

</script>
</body>
</html>
