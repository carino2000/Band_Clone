<%-- my-page.jsp (개선판: 그린 테마, 안정 동작) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>내 정보 | My Page</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 그린 테마, 간결한 인라인 스타일 (전역 CSS와 충돌 최소화) */
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; background:#f6fff6; margin:0; color:#072a14; }
        .wrap { max-width:1100px; margin:20px auto; padding:18px; box-sizing:border-box; }
        .layout { display:flex; gap:18px; align-items:flex-start; }
        .col { display:flex; flex-direction:column; gap:12px; }
        .left { flex:1; min-width:220px; }
        .center { flex:4; min-width:600px; }
        .right { flex:1; min-width:200px; }

        .card { background:#fff; border-radius:12px; padding:16px; box-shadow: 0 8px 20px rgba(10,80,30,0.04); border:1px solid rgba(10,80,30,0.06); }

        h2 { margin:0 0 6px 0; color:#0c3e16; }
        .muted { color:#5c7a60; font-size:13px; }

        label { display:block; font-weight:700; color:#153e18; margin-bottom:6px; }
        .form-row { display:flex; gap:12px; align-items:center; margin-top:8px; }
        input[type="text"], input[type="email"], input[type="number"] { width:100%; padding:10px 12px; border-radius:8px; border:1px solid #e6f3ea; background:#fbfffb; box-sizing:border-box; }
        input[readonly] { background:#f4fff4; }

        .btn { padding:8px 12px; border-radius:8px; border:none; cursor:pointer; font-weight:700; }
        .btn.primary { background: linear-gradient(180deg,#2bd34c,#1aa61f); color:#fff; box-shadow:0 8px 18px rgba(26,166,31,0.12); }
        .btn.ghost { background:transparent; border:1px solid #e6f3ea; color:#154f22; }
        .btn.warn { background:#ff6b6b; color:#fff; }

        .actions { display:flex; gap:8px; flex-wrap:wrap; }
        .small-note { font-size:13px; color:#557a54; }

        @media (max-width:880px) {
            .layout { flex-direction:column; }
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap">
    <div class="layout">
        <!-- LEFT: 빠른 액션 -->
        <aside class="left col">
            <div class="card">
                <h3 style="margin:0 0 10px 0;">빠른 설정</h3>
                <div class="actions" style="flex-direction:column; align-items:stretch;">
                    <a href="<c:url value='/password-changes'/>" class="btn ghost" role="button" style="text-align:center;">비밀번호 변경</a>
                    <a href="<c:url value='/my-posting'/>" class="btn ghost" role="button" style="text-align:center;">내가 쓴 글</a>
                    <a href="/my-loginHistory" class="btn ghost" role="button" style="text-align:center;">로그인 이력</a>

                    <!-- 계정 삭제: POST로 처리 -->
                    <form id="deleteForm" action="<c:url value='/delete-membership'/>" method="post" style="margin:0;">
                        <button type="button" id="deleteBt" class="btn warn" style="width:100%;" onclick="confirmDelete()">계정 삭제</button>
                    </form>
                </div>
            </div>
        </aside>

        <!-- CENTER: 프로필 편집 -->
        <main class="center col">
            <div class="card">
                <div style="display:flex; justify-content:space-between; align-items:center; gap:12px;">
                    <div>
                        <h2><c:out value='${fn:escapeXml(member.id)}'/>님의 페이지</h2>
                        <div class="muted">회원 정보 수정</div>
                    </div>

                    <div class="small-note">가입일: <c:out value='${fn:escapeXml(member.joinAt)}'/></div>
                </div>

                <form id="editForm" action="<c:url value='/my-page'/>" method="post" style="margin-top:14px;">
                    <input type="hidden" name="id" value="<c:out value='${fn:escapeXml(member.id)}'/>"/>

                    <div style="margin-top:10px;">
                        <label>아이디 <small style="font-weight:600;color:#4b6b4b;">(수정 불가)</small></label>
                        <input type="text" name="idDisplay" value="<c:out value='${fn:escapeXml(member.id)}'/>" readonly />
                    </div>

                    <div style="margin-top:10px;">
                        <label for="name">이름</label>
                        <input id="name" name="name" type="text" value="<c:out value='${fn:escapeXml(member.name)}'/>" required/>
                    </div>

                    <div style="margin-top:10px;">
                        <label for="nickname">닉네임</label>
                        <input id="nickname" name="nickname" type="text" value="<c:out value='${fn:escapeXml(member.nickname)}'/>" required/>
                    </div>

                    <div style="margin-top:10px;">
                        <label for="email">이메일</label>
                        <input id="email" name="email" type="email" value="<c:out value='${fn:escapeXml(member.email)}'/>" required/>
                    </div>

                    <div style="margin-top:10px;">
                        <label style="display:flex; align-items:center; gap:10px;">
                            <input type="checkbox" id="agree" name="agree" value="true"
                                   <c:if test="${member.agree}">checked="checked"</c:if> />
                            <span style="font-weight:600; color:#153e18;">이메일 수신 동의</span>
                        </label>
                        <div class="muted" style="margin-top:6px;">이메일 수신에 동의하시면 공지 및 이벤트 정보를 이메일로 받습니다.</div>
                    </div>

                    <div style="margin-top:10px; display:flex; gap:12px;">
                        <div style="flex:1;">
                            <label for="age">나이</label>
                            <input id="age" name="age" type="number" min="0" value="<c:out value='${fn:escapeXml(member.age)}'/>" required/>
                        </div>

                        <div style="flex:1;">
                            <label for="interest">관심사</label>
                            <input id="interest" name="interest" type="text" value="<c:out value='${fn:escapeXml(member.interest)}'/>" />
                        </div>
                    </div>

                    <div style="display:flex; justify-content:flex-end; gap:8px; margin-top:20px;">
                        <a href="<c:url value='/band-main'/>" class="btn ghost" role="button">취소</a>
                        <button type="button" id="editBt" class="btn primary" onclick="confirmEdit()">수정하기</button>
                    </div>
                </form>
            </div>
        </main>


    </div>
</div>

<script>
    function confirmEdit() {
        if (confirm("프로필을 수정하시겠습니까?")) {
            document.getElementById('editForm').submit();
        }
    }

    function confirmDelete() {
        if (confirm("정말로 계정을 삭제하시겠습니까? 삭제 시 복구할 수 없습니다.")) {
            var f = document.getElementById('deleteForm');
            if (f) f.submit();
        }
    }
</script>
</body>
</html>
