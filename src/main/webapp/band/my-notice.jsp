<%-- my-notice.jsp (fn 전혀 사용 안함; 아바타는 클라이언트에서 생성) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>내 알림</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 전반 레이아웃 (그린 테마) */
        body { margin:0; background:#f6fff6; color:#083214; font-family: -apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Noto Sans KR",Arial,sans-serif; }
        .wrap { max-width:1100px; margin:18px auto; padding:18px; box-sizing:border-box; }
        .layout { display:flex; gap:18px; align-items:flex-start; }
        .col { display:flex; flex-direction:column; gap:12px; }
        .side { flex:1; min-width:200px; }
        .center { flex:4; min-width:560px; }

        .page-title { font-size:20px; font-weight:800; color:#0c3e16; margin:6px 0 8px 0; }
        .subtitle { color:#4b6b4b; margin-bottom:12px; }

        .card { background:#fff; border-radius:12px; padding:14px; border:1px solid rgba(10,90,20,0.06); box-shadow:0 8px 20px rgba(10,80,30,0.04); }

        .section-title { font-size:16px; font-weight:700; color:#154f22; margin:12px 0; }

        .request-item {
            display:flex; flex-direction:column; gap:8px;
            padding:12px; border-radius:10px; background:linear-gradient(180deg,#fbfff9,#f4fff4);
            border:1px solid rgba(20,90,20,0.04);
        }
        .request-meta { display:flex; justify-content:space-between; gap:12px; align-items:center; }
        .request-left { display:flex; gap:12px; align-items:center; }
        .avatar {
            width:44px; height:44px; border-radius:8px; background:#eafaf0; display:flex; align-items:center; justify-content:center; font-weight:700; color:#1a7f2a;
            font-size:18px;
        }
        .request-info { display:flex; flex-direction:column; }
        .small { color:#557a54; font-size:13px; }

        .greeting { color:#2d6f2f; font-weight:700; }

        .controls { display:flex; gap:8px; margin-top:6px; flex-wrap:wrap; }
        .btn { padding:8px 12px; border-radius:8px; border:none; cursor:pointer; font-weight:700; }
        .btn.approve { background:linear-gradient(180deg,#2bd34c,#1aa61f); color:#fff; }
        .btn.reject { background:#fff; border:1px solid #ffd6d6; color:#b52b2b; }
        .btn.check { background:#eefbff; color:#0a566f; border:1px solid #dff4fa; }

        .empty { padding:14px; text-align:center; color:#6b8a6b; }

        @media (max-width:920px) {
            .layout { flex-direction:column; }
            .center { min-width:unset; }
        }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap" role="main" aria-labelledby="noticeTitle">
    <div class="layout">
        <div class="side"><!-- left spacer / widget area --></div>

        <main class="center col">
            <div class="card">
                <div id="noticeTitle" class="page-title"><c:out value="${member.nickname}"/>님의 알림</div>
                <div class="subtitle">밴드 가입 요청과 받은 메시지를 확인하세요.</div>

                <!-- 1) 밴드 가입 요청 목록 -->
                <div>
                    <div class="section-title">밴드 가입 요청 목록</div>

                    <c:choose>
                        <c:when test="${not empty requestList}">
                            <div style="display:flex; flex-direction:column; gap:12px;">
                                <c:forEach var="one" items="${requestList}">
                                    <div class="request-item" role="article" aria-label="밴드 가입 요청">
                                        <div class="request-meta">
                                            <div class="request-left">
                                                <!-- data-id 속성에 아이디를 넣어두면 아래 JS가 첫 글자 채워줌 -->
                                                <div class="avatar" data-id="<c:out value='${one.memberId}'/>" aria-hidden="true"></div>
                                                <div class="request-info">
                                                    <div><strong><c:out value="${one.memberId}"/></strong> 님이 <strong><c:out value="${one.bandName}"/></strong> 가입신청</div>
                                                    <div class="small">신청일: <c:out value="${one.prettyRequestAt}"/></div>
                                                </div>
                                            </div>

                                            <div class="small">신청자 닉네임: <strong><c:out value="${one.memberNickname}"/></strong></div>
                                        </div>

                                        <div>
                                            <div class="greeting">인사말: <span style="font-weight:500; color:#254f2a;"><c:out value="${one.greeting}"/></span></div>

                                            <div class="controls" aria-hidden="false">
                                                <form action="<c:url value='/my/notice'/>" method="post" style="display:inline;">
                                                    <input type="hidden" name="bandNo" value="<c:out value='${one.bandNo}'/>"/>
                                                    <input type="hidden" name="memberId" value="<c:out value='${one.memberId}'/>"/>
                                                    <button type="submit" name="approve" value="true" class="btn approve"
                                                            onclick="return confirm('해당 신청을 승인하시겠습니까?');">승인</button>
                                                    <button type="submit" name="approve" value="false" class="btn reject"
                                                            onclick="return confirm('해당 신청을 거절하시겠습니까?');">거절</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">현재 처리할 가입 요청이 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 2) 받은 메시지 목록 -->
                <div style="margin-top:18px;">
                    <div class="section-title"><c:out value="${member.id}"/>님이 받은 메시지</div>

                    <c:choose>
                        <c:when test="${not empty msgList}">
                            <div style="display:flex; flex-direction:column; gap:12px;">
                                <c:forEach var="msg" items="${msgList}">
                                    <div class="request-item" role="article" aria-label="받은 메시지">
                                        <div class="request-meta">
                                            <div class="request-left">
                                                <div class="avatar" data-id="<c:out value='${msg.writerId}'/>" aria-hidden="true"></div>
                                                <div class="request-info">
                                                    <div><strong><c:out value="${msg.writerId}"/></strong> 님이 보낸 메시지</div>
                                                    <div class="small">작성일: <c:out value="${msg.prettyWroteAt}"/></div>
                                                </div>
                                            </div>
                                        </div>

                                        <div>
                                            <div class="greeting">내용: <span style="font-weight:500; color:#254f2a;"><c:out value="${msg.content}"/></span></div>

                                            <div class="controls">
                                                <form action="<c:url value='/my/notice'/>" method="post" style="display:inline;">
                                                    <input type="hidden" name="msgIdx" value="<c:out value='${msg.idx}'/>"/>
                                                    <button type="submit" name="deleteMsg" value="true" class="btn check"
                                                            onclick="return confirm('해당 메시지를 확인하고 삭제하시겠습니까?');">확인/삭제</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty">받은 메시지가 없습니다.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div>
        </main>

        <div class="side"><!-- right spacer / widget area --></div>
    </div>
</div>

<script>
    // 아바타: data-id 속성에서 첫 글자(문자열의 첫 코드포인트)를 안전하게 표시
    (function(){
        function firstChar(str){
            if(!str) return '';
            // unicode surrogate-safe first grapheme-ish (approx): use Array.from to handle astral plane
            return Array.from(str.trim())[0] || '';
        }
        document.querySelectorAll('.avatar').forEach(function(el){
            var id = el.getAttribute('data-id') || '';
            var ch = firstChar(id);
            if(ch){
                // 한 글자가 알파벳/한글/숫자면 그대로, 아니면 기본 이모지
                el.textContent = ch;
            } else {
                el.textContent = '👤';
            }
        });
    })();
</script>

</body>
</html>
