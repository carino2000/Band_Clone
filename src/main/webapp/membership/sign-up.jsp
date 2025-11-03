<%-- sign-up.jsp (그린 테마, 검증 포함, 작동 우선) --%>
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
        /* 전체 레이아웃 */
        body { margin:0; background:#f6fff6; color:#083214; font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Noto Sans KR",Arial,sans-serif; }
        .wrap { max-width:840px; margin:36px auto; padding:20px; box-sizing:border-box; }
        .card { background:#fff; border-radius:12px; padding:28px; box-shadow:0 10px 30px rgba(6,90,30,0.06); border:1px solid rgba(10,90,20,0.04); }

        .header { display:flex; align-items:center; gap:12px; margin-bottom:12px; }
        .mark { width:44px; height:44px; border-radius:8px; background:linear-gradient(180deg,#7ff18a,#2bd34c); display:flex; align-items:center; justify-content:center; color:#06320a; font-weight:800; }
        .brand { font-weight:800; font-size:18px; color:#0b3e16; }

        h2 { margin:6px 0 8px 0; color:#0f3e13; font-size:22px; }
        .lead { color:#4b6b4b; margin-bottom:18px; }

        label small { display:block; font-weight:700; color:#154f22; margin-bottom:6px; }
        .field { margin-top:12px; }
        .input { width:100%; padding:10px 12px; border-radius:8px; border:1px solid #dfeee0; background:#fbfffb; box-sizing:border-box; font-size:14px; }
        .input:focus { outline:none; border-color:#1aa61f; box-shadow:0 6px 18px rgba(26,166,31,0.07); }

        .row { display:flex; gap:12px; align-items:center; margin-top:12px; }
        .row .col { flex:1; min-width:0; }

        .checkbox { display:inline-flex; align-items:center; gap:8px; color:#154f22; cursor:pointer; }

        .bt-primary {
            margin-top:18px; width:100%; padding:12px 16px; border-radius:10px; border:none;
            background: linear-gradient(90deg,#2bd34c,#1aa61f); color:#fff; font-weight:800; font-size:15px; cursor:pointer;
        }
        .bt-primary:active { transform:translateY(1px); }

        .helper { margin-top:10px; color:#6b7f6b; font-size:13px; }

        .note { margin-top:12px; color:#4b6b4b; font-size:13px; }

        .error-inline { color:#bf2b2b; font-size:13px; margin-top:6px; display:none; }

        @media (max-width:720px){
            .row { flex-direction:column; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="card" role="region" aria-labelledby="signupTitle">
        <div class="header">
            <div class="mark" aria-hidden="true">B</div>
            <div class="brand">BandClone</div>
        </div>

        <h2 id="signupTitle">가제에 오신 것을 환영합니다</h2>
        <div class="lead">소프트웨어 개발자를 위한 지식공유 플랫폼에 가입하세요.</div>

        <form id="signupForm" action="<c:url value='/sign-up'/>" method="post" autocomplete="off" novalidate>
            <div class="field">
                <label for="id"><small>아이디</small></label>
                <input id="id" name="id" class="input" type="text" placeholder="4 ~ 15자 이내" required aria-required="true"/>
                <div id="err-id" class="error-inline">아이디는 4~15자여야 합니다.</div>
            </div>

            <div class="field">
                <label for="pw"><small>비밀번호</small></label>
                <input id="pw" name="pw" class="input" type="password" placeholder="영문, 숫자, 특수문자 포함 6~15자" required aria-required="true"/>
                <div id="err-pw" class="error-inline">비밀번호는 6~15자이며 영문+숫자 포함을 권장합니다.</div>
            </div>

            <div class="field">
                <label for="email"><small>이메일</small></label>
                <input id="email" name="email" class="input" type="email" placeholder="test@example.com" required aria-required="true"/>
                <div id="err-email" class="error-inline">유효한 이메일 주소를 입력하세요.</div>
            </div>

            <div class="row">
                <div class="col">
                    <label for="name"><small>실명</small></label>
                    <input id="name" name="name" class="input" type="text" placeholder="홍길동" required/>
                </div>
                <div class="col">
                    <label for="nickname"><small>별명</small></label>
                    <input id="nickname" name="nickname" class="input" type="text" placeholder="별명을 20자 이내로" required/>
                    <div id="err-nick" class="error-inline">별명을 20자 이내로 입력해주세요.</div>
                </div>
            </div>

            <div class="row">
                <div class="col">
                    <label for="age"><small>나이</small></label>
                    <input id="age" name="age" class="input" type="number" min="0" max="150" placeholder="나이를 입력해주세요" required/>
                    <div id="err-age" class="error-inline">유효한 나이를 입력하세요.</div>
                </div>

                <div class="col">
                    <label for="interest"><small>관심태그</small></label>
                    <input id="interest" name="interest" class="input" type="text" placeholder="예: 백엔드, 프론트엔드, 모바일" />
                </div>
            </div>

            <div class="row" style="justify-content:space-between; align-items:center; margin-top:12px;">
                <label class="checkbox"><input id="agree" name="agree" type="checkbox" value="true"/> 이메일 수신동의</label>
                <div class="note">이벤트·뉴스레터 수신 동의 여부입니다.</div>
            </div>

            <div>
                <button type="button" class="bt-primary" onclick="validateAndSubmit()">회원가입</button>
            </div>
        </form>
    </div>
</div>

<script>
    // 간단한 클라이언트 검증 함수들
    function showError(id, msg) {
        var el = document.getElementById(id);
        if (!el) return;
        if (msg) {
            el.textContent = msg;
            el.style.display = 'block';
        } else {
            el.style.display = 'none';
        }
    }

    function validateAndSubmit() {
        // 요소 참조
        const id = document.getElementById('id');
        const pw = document.getElementById('pw');
        const email = document.getElementById('email');
        const nickname = document.getElementById('nickname');
        const age = document.getElementById('age');

        // 유효성 검사
        let ok = true;

        // 아이디: 4~15자
        const idVal = id.value.trim();
        if (idVal.length < 4 || idVal.length > 15) {
            showError('err-id','아이디는 4~15자여야 합니다.');
            ok = false;
        } else {
            showError('err-id','');
        }

        // 비밀번호: 6~15자 (간단 체크 — 필요시 패턴 확장)
        const pwVal = pw.value;
        if (pwVal.length < 6 || pwVal.length > 15) {
            showError('err-pw','비밀번호는 6~15자여야 합니다.');
            ok = false;
        } else {
            showError('err-pw','');
        }

        // 이메일 간단체크
        const emailVal = email.value.trim();
        const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRe.test(emailVal)) {
            showError('err-email','유효한 이메일 주소를 입력하세요.');
            ok = false;
        } else {
            showError('err-email','');
        }

        // 닉네임 길이
        const nickVal = nickname.value.trim();
        if (nickVal.length === 0 || nickVal.length > 20) {
            showError('err-nick','별명을 1~20자 이내로 입력해주세요.');
            ok = false;
        } else {
            showError('err-nick','');
        }

        // 나이
        const ageVal = Number(age.value);
        if (!Number.isInteger(ageVal) || ageVal < 0 || ageVal > 150) {
            showError('err-age','유효한 나이를 입력하세요.');
            ok = false;
        } else {
            showError('err-age','');
        }

        if (!ok) {
            // 첫 번째 오류 필드로 포커스
            const firstErr = document.querySelector('.error-inline[style*="block"]');
            if (firstErr) {
                const input = firstErr.previousElementSibling;
                if (input && input.focus) input.focus();
            }
            return;
        }

        // 마지막 확인(옵션)
        if (!confirm('입력하신 내용대로 회원가입 하시겠습니까?')) return;

        // 서버 제출
        document.getElementById('signupForm').submit();
    }

    // Enter키로 제출할 때 기본 동작 차단 및 검증 실행
    document.getElementById('signupForm').addEventListener('keydown', function(e){
        if (e.key === 'Enter') {
            // 폼 내부 textarea가 없다면 Enter로 submit하려는 의도일 수 있으니 validateAndSubmit
            e.preventDefault();
            validateAndSubmit();
        }
    });
</script>
</body>
</html>
