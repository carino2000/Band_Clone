<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Band Clone</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #c9f2d1 0%, #e8f9ee 100%);
            position: relative;
            overflow: hidden;
        }

        /* 부드러운 장식 원형 패턴 */
        .circle {
            position: absolute;
            border-radius: 50%;
            opacity: 0.25;
            filter: blur(40px);
        }
        .circle.one {
            width: 250px; height: 250px;
            background: #7bdc9d;
            top: -60px; left: -60px;
        }
        .circle.two {
            width: 180px; height: 180px;
            background: #a3e7c3;
            bottom: -40px; right: -40px;
        }

        .container {
            z-index: 2;
            text-align: center;
            background: rgba(255,255,255,0.85);
            padding: 60px 80px;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            max-width: 420px;
        }

        .logo {
            font-size: 42px;
            font-weight: 800;
            color: #2b6443;
            margin-bottom: 8px;
        }

        .subtitle {
            font-size: 15px;
            color: #46785a;
            margin-bottom: 36px;
        }

        .btn {
            display: inline-block;
            padding: 12px 28px;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            text-decoration: none;
            transition: all .2s ease;
            margin: 0 8px;
        }

        .btn-login {
            background: transparent;
            border: 1.6px solid #4bb378;
            color: #2b6443;
        }

        .btn-login:hover {
            background: rgba(75,179,120,0.1);
        }

        .btn-join {
            background: linear-gradient(90deg, #4bb378, #5fd68f);
            color: #fff;
            box-shadow: 0 4px 10px rgba(75,179,120,0.3);
        }

        .btn-join:hover {
            transform: translateY(-2px);
        }

        @media (max-width: 600px) {
            .container { padding: 40px 30px; width: 90%; }
            .btn { display: block; width: 100%; margin: 10px 0; }
        }
    </style>
</head>
<body>

<c:choose>
    <c:when test="${msg == 1}">
        <script>window.alert("회원 정보 수정 완료\n다시 로그인해주세요.");</script>
    </c:when>
    <c:when test="${msg == 2}">
        <script>window.alert("비밀번호 변경 완료!\n다시 로그인해주세요.");</script>
    </c:when>
    <c:when test="${msg == 3}">
        <script>window.alert("회원 탈퇴 완료\n지금까지 함께해주셔서 감사합니다.");</script>
    </c:when>
</c:choose>

<div class="circle one"></div>
<div class="circle two"></div>

<div class="container">
    <div class="logo">Band Clone</div>
    <div class="subtitle">함께 소통하고 성장하는 커뮤니티 공간</div>
    <a href="/log-in" class="btn btn-login">로그인</a>
    <a href="/sign-up" class="btn btn-join">회원가입</a>
</div>

</body>
</html>
