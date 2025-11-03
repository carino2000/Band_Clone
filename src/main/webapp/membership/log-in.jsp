<%-- login.jsp (깔끔한 그린 테마 + 동작 보장) --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>로그인</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 전체 배경 / 중앙 박스 */
        body {
            margin: 0;
            background: #f6fff6;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif;
            color: #073217;
        }
        .wrap {
            display: flex;
            max-width: 750px;
            margin: 36px auto;
            padding: 20px;
            box-sizing: border-box;
        }

        .card {
            width: 68%;
            background: #ffffff;
            border-radius: 12px;
            padding: 28px;
            box-shadow: 0 10px 30px rgba(6,90,30,0.06);
            border: 1px solid rgba(10,90,20,0.04);
        }

        .logo {
            display:flex;
            align-items:center;
            gap:12px;
            text-decoration:none;
            color:#0b3e16;
            margin-bottom:12px;
        }
        .logo .mark {
            width:44px; height:44px; border-radius:8px;
            background:linear-gradient(180deg,#7ff18a,#2bd34c);
            display:flex; align-items:center; justify-content:center; color:#06320a; font-weight:800;
            box-shadow:0 6px 18px rgba(26,166,31,0.08);
        }
        .logo .title { font-size:18px; font-weight:800; }

        h2 { margin:6px 0 4px 0; color:#0f3e13; font-size:20px; }
        .subtitle { color:#4b6b4b; margin-bottom:18px; }

        label small { display:block; font-weight:700; color:#154f22; margin-bottom:6px; }
        .input {
            width:100%;
            padding:10px 12px;
            border-radius:8px;
            border:1px solid #dfeee0;
            background:#fbfffb;
            box-sizing:border-box;
            font-size:14px;
        }
        .input:focus { outline:none; border-color:#1aa61f; box-shadow:0 6px 18px rgba(26,166,31,0.07); }

        .row { margin-top:12px; display:flex; align-items:center; gap:8px; }
        .checkbox { display:inline-flex; align-items:center; gap:8px; color:#154f22; cursor:pointer; }

        .bt-submit {
            margin-top:18px;
            width:100%;
            padding:11px 14px;
            border-radius:10px;
            background: linear-gradient(90deg,#2bd34c,#1aa61f);
            color:#fff;
            border:none;
            font-weight:800;
            font-size:15px;
            cursor:pointer;
            transition:transform .08s ease;
        }
        .bt-submit:disabled {
            opacity:0.55;
            cursor:not-allowed;
            transform:none;
            box-shadow:none;
        }
        .helper { margin-top:12px; color:#6b7f6b; font-size:13px; text-align:center; }

        .foot { margin-top:16px; text-align:center; color:#154f22; font-weight:600; }
        .foot a { color:#0b3e16; text-decoration:none; margin-left:6px; }

        @media (max-width:520px) {
            .wrap { padding:12px; margin:18px auto; }
            .card { padding:18px; }
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="card" role="main" aria-labelledby="loginTitle">

        <a class="logo" href="<c:url value='/'/>" aria-label="홈으로 이동">
            <div class="mark">B</div>
            <div class="title">BandClone</div>
        </a>

        <h2 id="loginTitle">로그인</h2>
        <div class="subtitle">계정으로 로그인해 밴드 활동을 시작하세요.</div>

        <form id="loginForm" class="signup-form" action="/log-in" method="post" autocomplete="off">
            <c:if test="${destination != null}">
                <input type="hidden" name="destination" value="${destination}"/>
            </c:if>

            <div>
                <label for="id"><small>아이디</small></label>
                <input id="id" name="id" class="input" type="text" required autocomplete="username" autofocus/>
            </div>

            <div class="row" style="flex-direction:column; align-items:stretch;">
                <label for="pw"><small>비밀번호</small></label>
                <input id="pw" name="pw" class="input" type="password" required autocomplete="current-password"/>
            </div>

            <div class="row" style="justify-content:space-between; margin-top:10px;">
                <label class="checkbox"><input id="keepLogin" name="keepLogin" type="checkbox" onchange="keepLoginConfirm()"/> 로그인 상태 유지</label>
                <div style="font-size:13px; color:#6b7f6b;">공용 PC에서는 사용하지 마세요</div>
            </div>

            <div>
                <button id="loginbt" class="bt-submit" type="submit" disabled>로그인</button>
            </div>
        </form>

        <div class="foot">
            아직 회원이 아니신가요?
            <a href="<c:url value='/sign-up'/>">회원가입</a>
        </div>
    </div>
</div>

<script>
    (function(){
        const idInput = document.getElementById('id');
        const pwInput = document.getElementById('pw');
        const loginBtn = document.getElementById('loginbt');

        function updateButtonState() {
            const idVal = idInput.value.trim();
            const pwVal = pwInput.value.trim();
            loginBtn.disabled = !(idVal.length > 0 && pwVal.length > 0);
        }

        // attach events (works on older browsers too)
        idInput.addEventListener('input', updateButtonState);
        pwInput.addEventListener('input', updateButtonState);

        // keep login confirm
        window.keepLoginConfirm = function() {
            const cb = document.getElementById('keepLogin');
            if(cb.checked){
                if(!confirm('공용 PC에서는 사용을 삼가해주세요. 계속하시겠습니까?')){
                    cb.checked = false;
                }
            }
        };

        // initialize (in case browser autofills)
        window.addEventListener('load', function(){
            // small timeout to allow browser autofill to populate fields
            setTimeout(updateButtonState, 150);
        });

        // optional: prevent double submit by disabling button once clicked
        document.getElementById('loginForm').addEventListener('submit', function(e){
            if(loginBtn.disabled) {
                e.preventDefault();
                return;
            }
            loginBtn.disabled = true;
            // allow form submit to proceed
        });
    })();
</script>
</body>
</html>
