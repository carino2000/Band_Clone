<%-- change-password-with-header.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>비밀번호 변경</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 전체 배경/타이포(헤더와 충돌 적게) */
        body { margin:0; background:#f6fff6; color:#083214; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; }
        /* 헤더 포함 시 내용이 헤더와 겹치지 않도록 여유 부여 (헤더 높이에 맞춰 조정 가능) */
        .content { max-width:500px; margin:0 auto; padding:28px 18px 60px 18px; box-sizing:border-box; text-align: center}
        .card { background:#ffffff; border-radius:12px; padding:28px; box-shadow:0 10px 30px rgba(10,80,30,0.06); border:1px solid rgba(10,80,30,0.06); }
        h2 { margin:0 0 10px 0; color:#0f3e13; font-size:22px; }
        .lead { color:#2d6f2f; margin-bottom:18px; }

        label { display:block; font-weight:700; color:#154f22; margin-bottom:6px; }
        .field { margin-bottom:14px; text-align: left }

        input[type="password"] {
            width:100%; max-width:420px;
            padding:10px 12px; border-radius:8px; border:1px solid #dfeee0;
            background:#fbfffb; box-sizing:border-box; font-size:14px;
        }
        input[type="password"]:focus { outline:none; border-color:#1aa61f; box-shadow:0 4px 12px rgba(26,166,31,0.08); }

        .btn-row { margin-top:18px; display:flex; gap:12px; align-items:center; }
        .btn { padding:10px 16px; border-radius:8px; font-weight:800; border:none; cursor:pointer; }
        .btn.primary { background:linear-gradient(180deg,#2bd34c,#1aa61f); color:#fff; box-shadow:0 8px 20px rgba(26,166,31,0.12); }
        .btn.ghost { background:transparent; border:1px solid #e6f3ea; color:#154f22; }

        .error-main { margin-top:14px; padding:12px; border-radius:8px; background:#fff8f8; color:#a80000; border:1px solid #ffc8c8; display:inline-block; }

        /* 반응형 */
        @media (max-width:520px) {
            .card { padding:18px; }
            .btn-row { flex-direction:column; align-items:stretch; }
            input[type="password"] { max-width:100%; }
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="content">
    <div class="card" role="region" aria-labelledby="changePwTitle">
        <h2 id="changePwTitle">비밀번호 변경</h2>
        <div class="lead">안전한 비밀번호로 정기적으로 변경하세요.</div>

        <form id="changePw" action="<c:url value='/password-changes'/>" method="post" autocomplete="off">
            <div class="field">
                <label for="pw">현재 비밀번호</label>
                <input type="password" name="pw" id="pw" placeholder="현재 비밀번호를 입력해주세요" required />
            </div>

            <div class="field">
                <label for="newPw">신규 비밀번호</label>
                <input type="password" name="newPw" id="newPw" placeholder="최소 6자 이상" required />
            </div>

            <div class="field">
                <label for="checkNewPw">신규 비밀번호 확인</label>
                <input type="password" name="checkNewPw" id="checkNewPw" placeholder="신규 비밀번호를 다시 입력해주세요" required />
            </div>

            <div class="btn-row">
                <button type="button" class="btn primary" id="changeBt" onclick="checkAbleEdit()">비밀번호 변경</button>
                <a href="<c:url value='/band-main'/>" class="btn ghost" role="button">취소</a>
            </div>
        </form>

        <c:if test="${not empty mainError}">
            <div class="error-main">
                <strong>비밀번호 변경 실패</strong>
                <div style="margin-top:6px;"><c:out value="${mainError}"/></div>
            </div>
        </c:if>
    </div>
</div>

<script>
    // 안전한 DOM 참조: null 체크 포함
    (function(){
        const form = document.getElementById('changePw');
        const inputNewPw = document.getElementById('newPw');
        const inputCheckNewPw = document.getElementById('checkNewPw');

        window.checkAbleEdit = function(){
            if(!inputNewPw || !inputCheckNewPw || !form) { // 안전 실패 시 기본 submit 안함
                alert('폼을 찾을 수 없습니다. 새로고침 후 다시 시도하세요.');
                return;
            }

            const newPw = inputNewPw.value.trim();
            const confirmPw = inputCheckNewPw.value.trim();

            if(newPw !== confirmPw){
                alert('새로운 비밀번호가 서로 일치하지 않습니다.');
                inputNewPw.focus();
                return;
            }

            if(newPw.length < 6){
                alert('비밀번호는 최소 6자 이상이어야 합니다.');
                inputNewPw.focus();
                return;
            }

            // 사용자 확인 후 전송
            if(confirm('비밀번호를 수정하시겠습니까?')){
                form.submit();
            }
        };
    })();
</script>
</body>
</html>
