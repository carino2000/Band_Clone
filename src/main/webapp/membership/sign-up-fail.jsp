<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 2025-10-17
  Time: 오전 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>커뮤니티</title>
    <style>
        body {
            margin: 0px;
        }

        .signup-wrap {
            margin: 6rem 0rem;
            display: flex;
            justify-content: center;
        }

        .signup {
            max-width: 28rem;
        }

        .text-center {
            text-align: center;
        }

        .text-gray {
            color: #8f8f8f
        }

        .mt-1 {
            margin-top: 0.25rem;
        }

        .input {
            width: 100%;
            padding: 0.5rem 0.75rem;
            border-radius: 0.375rem;
            border-color: #8f8f8f;
        }

        .signup-form > div {
            margin-top: 1.5rem;
        }

        .bt-submit {
            width: 100%;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            border: none;
            cursor: pointer;
        }

        .bt-submit:hover {
            background-color: #6f6f6f;
            color: #efefef;
        }

        .error-main {
            background-color: rgba(239, 68, 68, 0.9);
            color: white;
            padding: 1rem;
        }

        .error-detail {
            color: rgba(239, 68, 68, 0.9)
        }
    </style>
</head>
<body>
<div class="signup-wrap">
    <div class="signup">
        <a href="/">로고</a>
        <h2 class="text-center">가제에 오신것을 환영합니다.</h2>
        <p class="text-center text-gray">
            가제는 소프트웨어 개발자를 위한 지식공유 플랫폼입니다.
        </p>
        <form class="signup-form" action="/sign-up" method="post">
            <c:if test="${mainError != null}">
                <div class="error-main">
                    <b>회원가입 실패</b><br/>
                        ${mainError}
                </div>
            </c:if>
            <div>
                <label for="id"><small>아이디</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="id" id="id" placeholder="4~15자 이내로 입력해주세요"
                           value="${member.id}" required/>
                </div>
            </div>
            <div>
                <label for="password"><small>비밀번호</small></label>
                <div class="mt-1">
                    <input type="password" class="input" name="pw" id="password"
                           placeholder="영문, 숫자, 특수문자를 포함한 6~15자" value="${member.pw}" required/>
                </div>
            </div>
            <div>
                <label for="email"><small>이메일</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="email" id="email" placeholder="test@test.com"
                           value="${member.email}" required/>
                </div>
            </div>
            <div>
                <label for="name"><small>실명</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="name" id="name" placeholder="홍길동" value="${member.name}"
                           required/>
                </div>
            </div>
            <div>
                <label for="nickname"><small>닉네임</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="nickname" id="nickname"
                           placeholder="별명을 알파벳,한글,숫자 20자 이하로 입력해주세요."
                           value="${member.nickname}" required/>
                </div>
            </div>
            <div>
                <label for="age"><small>나이</small></label>
                <div class="mt-1">
                    <input type="number" class="input" name="age" id="age"
                           placeholder="나이를 입력해주세요." value="${member.age}" required>
                </div>
            </div>
            <div>
                <label for="interest"><small>관심태그</small></label>
                <div class="mt-1">
                    <input type="text" class="input" name="interest" id="interest"
                           placeholder="백엔드,프론트엔드,모바일,취업,신기술..." value="${member.interest}">
                </div>
            </div>
            <div>
                <div style="display: flex; justify-content: space-between">
                    <label><small>이메일 수신동의</small></label>
                    <div>
                        <input type="checkbox" name="agree" value="true" ${member.agree ? 'checked' : ''}/>
                    </div>
                </div>
                <div class="text-gray mt-1">
                    가제에서 주최하는 다양한 이벤트, 정보성 뉴스레터 및 광고 수신여부를 설정할 수 있습니다
                </div>
            </div>
            <div>
                <button class="bt-submit">회원가입</button>
            </div>
        </form>

    </div>
</div>
`
</body>
</html>
