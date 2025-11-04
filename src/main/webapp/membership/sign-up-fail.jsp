<%-- sign-up.jsp (연두/초록 테마, mainError 포함, fn 미사용) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>회원가입</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 전체 레이아웃 / 그린 테마 */
        body { margin:0; background:#f6fff6; color:#083214; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; }
        .wrap { max-width:880px; margin:36px auto; padding:20px; box-sizing:border-box; }
        .card { background:#fff; border-radius:12px; padding:28px; box-shadow:0 10px 30px rgba(6,90,30,0.06); border:1px solid rgba(10,90,20,0.04); }

        .brand { display:flex; align-items:center; gap:12px; margin-bottom:12px; text-decoration:none; color:#0b3e16; }
        .mark { width:44px; height:44px; border-radius:8px; background:linear-gradient(180deg,#7ff18a,#2bd34c); display:flex; align-items:center; justify-content:center; color:#06320a; font-weight:800; }
        .brand-title { font-weight:800; font-size:18px; }

        h2 { margin:6px 0 8px 0; color:#0f3e13; font-size:22px; }
        .lead { color:#4b6b4b; margin-bottom:18px; }

        label small { display:block; font-weight:700; color:#154f22; margin-bottom:6px; }
        .field { margin-top:12px; }
        .input { width:100%; padding:10px 12px; border-radius:8px; border:1px solid #dfeee0; background:#fbfffb; box-sizing:border-box; font-size:14px; }
        .input:focus { outline:none; border-color:#1aa61f; box-shadow:0 6px 18px rgba(26,166,31,0.07); }

        .row { display:flex; gap:12px; align-items:center; margin-top:12px; }
        .row .col { flex:1; min-width:0; }

        .checkbox { display:inline-flex; align-items:center; gap:8px; color:#154f22; cursor:pointer; }

        .bt-primary { margin-top:18px; width:100%; padding:12px 16px; border-radius:10px; border:none; background: linear-gradient(90deg,#2bd34c,#1aa61f); color:#fff; font-weight:800; font-size:15px; cursor:pointer; }
        .helper { margin-top:10px; color:#6b7f6b; font-size:13px; }

        .error-main {
            margin-top:16px; padding:12px 14px; border-radius:10px;
            background: linear-gradient(180deg,#fff1f1,#fff8f8);
            border: 1px solid rgba(239,68,68,0.12);
            color:#a00000; display:flex; gap:12px; align-items:flex-start;
        }
        .error-icon { width:36px; height:36px; border-radius:8px; background:#ffecec; display:flex; align-items:center; justify-content:center; color:#a00000; font-weight:800; }
        .error-text { font-size:14px; }

        @media (max-width:720px) { .row { flex-direction:column; } .card { padding:18px; } }
    </style>
</head>
<body>
<div class="wrap">
    <div class="card" role="region" aria-labelledby="signupTitle">
        <a class="brand" href="<c:url value='/'/>" aria-label="홈">
            <div class="mark">B</div>
            <div class="brand-title">BandClone</div>
        </a>

        <h2 id="signupTitle">Band Clone에 오신 것을 환영합니다!</h2>
        <div class="lead">커뮤니티를 통해 당신의 견문을 넓혀보세요</div>

        <!-- 오류 메시지 -->
        <c:if test="${not empty mainError}">
            <div class="error-main" role="alert" aria-live="assertive">
                <div class="error-icon">!</div>
                <div class="error-text"><strong>회원가입 실패</strong><div style="margin-top:6px;"><c:out value="${mainError}"/></div></div>
            </div>
        </c:if>

        <form id="signupForm" class="signup-form" action="<c:url value='/sign-up'/>" method="post" autocomplete="off" novalidate>
            <div class="field">
                <label for="id"><small>아이디</small></label>
                <div class="mt-1">
                    <input id="id" name="id" class="input" type="text" placeholder="4~15자 이내로 입력해주세요" value="<c:out value='${member.id}'/>" required />
                </div>
            </div>

            <div class="field">
                <label for="pw"><small>비밀번호</small></label>
                <div class="mt-1">
                    <input id="pw" name="pw" class="input" type="password" placeholder="영문, 숫자, 특수문자 포함 6~15자" value="<c:out value='${member.pw}'/>" required />
                </div>
            </div>

            <div class="field">
                <label for="email"><small>이메일</small></label>
                <div class="mt-1">
                    <input id="email" name="email" class="input" type="email" placeholder="test@example.com" value="<c:out value='${member.email}'/>" required />
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <label for="name"><small>실명</small></label>
                    <div class="mt-1">
                        <input id="name" name="name" class="input" type="text" placeholder="홍길동" value="<c:out value='${member.name}'/>" required />
                    </div>
                </div>
                <div class="col">
                    <label for="nickname"><small>닉네임</small></label>
                    <div class="mt-1">
                        <input id="nickname" name="nickname" class="input" type="text" placeholder="별명을 20자 이하로 입력해주세요" value="<c:out value='${member.nickname}'/>" required />
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <label for="age"><small>나이</small></label>
                    <div class="mt-1">
                        <input id="age" name="age" class="input" type="number" min="0" max="150" placeholder="나이를 입력해주세요" value="<c:out value='${member.age}'/>" required />
                    </div>
                </div>
                <div class="col">
                    <label for="interest"><small>관심태그</small></label>
                    <div class="mt-1">
                        <input id="interest" name="interest" class="input" type="text" placeholder="백엔드,프론트엔드,모바일,취업..." value="<c:out value='${member.interest}'/>" />
                    </div>
                </div>
            </div>

            <div class="field" style="margin-top:16px; display:flex; justify-content:space-between; align-items:center;">
                <label class="checkbox"><input id="agree" name="agree" type="checkbox" value="true"
                                               <c:if test="${member.agree}">checked="checked"</c:if> /> 이메일 수신동의</label>
                <div class="helper">이벤트·뉴스레터 수신 여부를 설정합니다.</div>
            </div>

            <div>
                <button type="button" class="bt-primary" onclick="validateAndSubmit()">회원가입</button>
            </div>
        </form>
    </div>
</div>

<script>
    function showError(el, msg) {
        // simple floating alert (keeps DOM minimal)
        if (!msg) return;
        alert(msg);
    }

    function validateAndSubmit() {
        const id = document.getElementById('id').value.trim();
        const pw = document.getElementById('pw').value;
        const email = document.getElementById('email').value.trim();
        const name = document.getElementById('name').value.trim();
        const nickname = document.getElementById('nickname').value.trim();
        const age = document.getElementById('age').value.trim();

        if (id.length < 4 || id.length > 15) { showError(null, '아이디는 4~15자 사이로 입력하세요.'); return; }
        if (pw.length < 6 || pw.length > 15) { showError(null, '비밀번호는 6~15자 사이로 입력하세요.'); return; }
        const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRe.test(email)) { showError(null, '유효한 이메일을 입력하세요.'); return; }
        if (name.length === 0) { showError(null, '이름을 입력하세요.'); return; }
        if (nickname.length === 0 || nickname.length > 20) { showError(null, '별명은 1~20자 이내로 입력하세요.'); return; }
        const ageNum = Number(age);
        if (!Number.isInteger(ageNum) || ageNum < 0 || ageNum > 150) { showError(null, '유효한 나이를 입력하세요.'); return; }

        if (!confirm('입력하신 정보로 회원가입을 진행하시겠습니까?')) return;

        document.getElementById('signupForm').submit();
    }
</script>
</body>
</html>
