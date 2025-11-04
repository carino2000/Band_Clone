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
        body {
            margin: 0;
            background: #f6fff6;
            color: #083214;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif;
        }

        .wrap {
            max-width: 1100px;
            margin: 18px auto;
            padding: 18px;
            box-sizing: border-box;
        }

        .layout {
            display: flex;
            gap: 18px;
            align-items: flex-start;
        }

        .col {
            margin-top: 30px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .side {
            flex: 1;
            min-width: 200px;
        }

        .center {
            flex: 4;
            min-width: 560px;
        }

        .page-title {
            font-size: 20px;
            font-weight: 800;
            color: #0c3e16;
            margin: 6px 0 8px 0;
        }

        .subtitle {
            color: #4b6b4b;
            margin-bottom: 12px;
        }

        .card {
            background: #fff;
            border-radius: 12px;
            padding: 14px;
            border: 1px solid rgba(10, 90, 20, 0.06);
            box-shadow: 0 8px 20px rgba(10, 80, 30, 0.04);
        }

        .section-title {
            font-size: 16px;
            font-weight: 700;
            color: #154f22;
            margin: 12px 0;
        }

        .request-item {
            display: flex;
            flex-direction: column;
            gap: 8px;
            padding: 12px;
            border-radius: 10px;
            background: linear-gradient(180deg, #fbfff9, #f4fff4);
            border: 1px solid rgba(20, 90, 20, 0.04);
        }

        .request-meta {
            display: flex;
            justify-content: space-between;
            gap: 12px;
            align-items: center;
        }

        .request-left {
            display: flex;
            gap: 12px;
            align-items: center;
        }

        .avatar {
            width: 44px;
            height: 44px;
            border-radius: 8px;
            background: #eafaf0;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #1a7f2a;
            font-size: 18px;
        }

        .request-info {
            display: flex;
            flex-direction: column;
        }

        .small {
            color: #557a54;
            font-size: 13px;
        }

        .greeting {
            color: #2d6f2f;
            font-weight: 700;
        }

        .controls {
            display: flex;
            gap: 8px;
            margin-top: 6px;
            flex-wrap: wrap;
        }

        .btn {
            padding: 8px 12px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 700;
        }

        .btn.approve {
            background: linear-gradient(180deg, #2bd34c, #1aa61f);
            color: #fff;
        }

        .btn.reject {
            background: #fff;
            border: 1px solid #ffd6d6;
            color: #b52b2b;
        }

        .btn.check {
            background: #eefbff;
            color: #0a566f;
            border: 1px solid #dff4fa;
        }

        .empty {
            padding: 14px;
            text-align: center;
            color: #6b8a6b;
        }

        /* -----------------------------
           알림 중앙 박스 스타일
           ----------------------------- */
        .notice-center {
            display: flex;
            justify-content: center;
            margin: 12px 0 18px 0;
        }

        .notice-pill {
            display: inline-flex;
            align-items: center;
            gap: 10px;
            padding: 10px 14px;
            border-radius: 20px;
            background: linear-gradient(180deg, #fff, #f7fff7);
            border: 1px solid rgba(10, 90, 20, 0.06);
            box-shadow: 0 6px 18px rgba(10, 80, 30, 0.03);
            min-width: 220px;
            max-width: 80%;
            box-sizing: border-box;
        }

        .notice-bell {
            position: relative;
            width: 44px;
            height: 44px;
            border-radius: 10px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            background: #fbfffb;
            border: 1px solid rgba(10, 90, 20, 0.04);
            box-sizing: border-box;
        }

        .notice-bell svg {
            width: 20px;
            height: 20px;
            display: block;
            color: #214a1f;
        }

        .notice-badge {
            position: absolute;
            top: 6%;
            right: 6%;
            min-width: 18px;
            height: 18px;
            padding: 0 6px;
            border-radius: 12px;
            font-size: 11px;
            line-height: 18px;
            background: #ff3b30;
            color: #fff;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            box-sizing: border-box;
            border: 1px solid #fff;
            transform: translate(10%, -10%);
            white-space: nowrap;
        }

        .notice-text {
            color: #154f22;
            font-weight: 700;
            font-size: 14px;
        }

        .notice-sub {
            color: #4b6b4b;
            font-size: 12px;
        }

        /* -----------------------------
           메신저 (사이드) 스타일 개선
           ----------------------------- */
        .recommend-title {
            font-size: 1rem;
            color: #444;
            margin-bottom: 0.5rem;
            padding-bottom: 0.3rem;
            border-bottom: 2px solid #e6efe6;
        }

        .recommend-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .msg-item {
            display: flex;
            gap: 8px;
            align-items: center;
            background: linear-gradient(180deg, #ffffff, #fbfffb);
            border-radius: 10px;
            padding: 8px;
            border: 1px solid rgba(10, 90, 20, 0.04);
        }

        .msg-meta {
            min-width: 0;
            display: flex;
            flex-direction: column;
            gap: 4px;
            flex: 0 0 110px;
            font-size: 13px;
            color: #2d6f2f;
        }

        .msg-input-wrap {
            display: flex;
            gap: 6px;
            align-items: center;
            flex: 1;
        }

        .msg-input {
            flex: 1;
            padding: 8px 10px;
            border-radius: 8px;
            border: 1px solid #e6efe6;
            font-size: 13px;
            background: #fff;
            box-sizing: border-box;
        }

        .msg-send {
            padding: 8px 12px;
            background: linear-gradient(180deg, #2bd34c, #1aa61f);
            color: #fff;
            border-radius: 8px;
            border: none;
            font-weight: 700;
            cursor: pointer;
            white-space: nowrap;
        }

        /* 반응형: 좁은 화면에서는 메신저 입력이 세로로 */
        @media (max-width: 540px) {
            .msg-item {
                flex-direction: column;
                align-items: stretch;
            }

            .msg-meta {
                flex: none;
            }

            .msg-input-wrap {
                flex-direction: column;
                gap: 8px;
            }

            .notice-pill {
                min-width: 180px;
            }
        }

        @media (max-width: 920px) {
            .layout {
                flex-direction: column;
            }

            .center {
                min-width: unset;
            }
        }

    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap" role="main" aria-labelledby="noticeTitle">
    <div class="layout">
        <div class="side"><!-- left spacer / widget area --></div>

        <main class="center col">
            <div class="card" style="padding-bottom:18px;">
                <div id="noticeTitle" class="page-title"><c:out value="${member.nickname}"/>님의 알림</div>
                <div class="subtitle">밴드 가입 요청과 받은 메시지를 확인하세요.</div>

                <!-- 중앙 알림 박스 : 벨 + 배지 -->
                <div class="notice-center" role="region" aria-label="알림 요약">
                    <div class="notice-pill" role="button" aria-pressed="false"
                         onclick="location.href='<c:url value='/my/notice'/>'">
                        <div class="notice-bell" aria-hidden="true">
                            <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" aria-hidden="true">
                                <path d="M12 22c1.1 0 2-.9 2-2h-4a2 2 0 0 0 2 2z" fill="currentColor"/>
                                <path d="M18 16V11c0-3.1-1.6-5.6-4.5-6.3V4a1.5 1.5 0 0 0-3 0v0.7C7.6 5.4 6 7.9 6 11v5l-2 2v1h16v-1l-2-2z"
                                      fill="currentColor"/>
                            </svg>

                            <c:if test="${noticeCnt != 0}">
                                <span class="notice-badge" aria-label="${noticeCnt}개의 알림">
                                    <c:out value='${noticeCnt}'/>
                                </span>
                            </c:if>
                        </div>

                        <div style="display:flex; flex-direction:column;">
                            <div class="notice-text">새 알림</div>
                            <div class="notice-sub"><c:out
                                    value="${noticeSummary != null ? noticeSummary : '최근 알림을 확인하세요.'}"/></div>
                        </div>
                    </div>
                </div>

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
                                                <div class="avatar" data-id="<c:out value='${one.memberId}'/>"
                                                     aria-hidden="true"></div>
                                                <div class="request-info">
                                                    <div><strong><c:out value="${one.memberId}"/></strong> 님이
                                                        <strong><c:out value="${one.bandName}"/></strong> 가입신청
                                                    </div>
                                                    <div class="small">신청일: <c:out
                                                            value="${one.prettyRequestAt}"/></div>
                                                </div>
                                            </div>

                                            <div class="small">신청자 닉네임: <strong><c:out
                                                    value="${one.memberNickname}"/></strong></div>
                                        </div>

                                        <div>
                                            <div class="greeting">인사말: <span
                                                    style="font-weight:500; color:#254f2a;"><c:out
                                                    value="${one.greeting}"/></span></div>

                                            <div class="controls" aria-hidden="false">
                                                <form action="<c:url value='/my/notice'/>" method="post"
                                                      style="display:inline;">
                                                    <input type="hidden" name="bandNo"
                                                           value="<c:out value='${one.bandNo}'/>"/>
                                                    <input type="hidden" name="memberId"
                                                           value="<c:out value='${one.memberId}'/>"/>
                                                    <button type="submit" name="approve" value="true"
                                                            class="btn approve"
                                                            onclick="return confirm('해당 신청을 승인하시겠습니까?');">승인
                                                    </button>
                                                    <button type="submit" name="approve" value="false"
                                                            class="btn reject"
                                                            onclick="return confirm('해당 신청을 거절하시겠습니까?');">거절
                                                    </button>
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

                <!-- 메신저 받은 메시지 목록 -->
                <div style="margin-top:18px;">
                    <div class="section-title"><c:out value="${member.id}"/>님이 받은 메시지</div>

                    <c:choose>
                        <c:when test="${not empty msgList}">
                            <div style="display:flex; flex-direction:column; gap:12px;">
                                <c:forEach var="msg" items="${msgList}">
                                    <div class="request-item" role="article" aria-label="받은 메시지">
                                        <div class="request-meta">
                                            <div class="request-left">
                                                <div class="avatar" data-id="<c:out value='${msg.writerId}'/>"
                                                     aria-hidden="true"></div>
                                                <div class="request-info">
                                                    <div><strong><c:out value="${msg.writerId}"/></strong> 님이 보낸 메시지</div>

                                                    <div class="small">작성일: <c:out value="${msg.prettyWroteAt}"/></div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="border: 0; border-top: 2px solid #ddd; margin: 0.3rem 0 0.8rem 0;">
                                        <div>
                                            <div class="greeting">내용: <span
                                                    style="font-weight:500; color:#254f2a;"><c:out
                                                    value="${msg.content}"/></span></div>

                                            <div class="controls">
                                                <form action="<c:url value='/my/notice'/>" method="post"
                                                      style="display:inline;">
                                                    <input type="hidden" name="msgIdx"
                                                           value="<c:out value='${msg.idx}'/>"/>
                                                    <button type="submit" name="deleteMsg" value="true"
                                                            class="btn check"
                                                            onclick="return confirm('해당 메시지를 확인하고 삭제하시겠습니까?');">확인/삭제
                                                    </button>
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

    <div class="col side" style="margin-top: 50px">
        <div class="card" style="padding:12px;">
            <h3 class="recommend-title">
                친구에게 메시지 보내기
            </h3>

            <ul class="recommend-list">
                <c:forEach var="one" items="${memberList}">
                    <li class="msg-item">
                        <div class="msg-meta">
                            <div style="font-weight:700;"><c:out value="${one.id}"/></div>
                            <div style="font-size:12px; color:#557a54;"><c:out value="${one.nickname}"/></div>
                        </div>

                        <form action="/send-messenger" method="post" style="flex:1; display:flex;"
                              class="msg-input-wrap">
                            <input type="hidden" value="${one.id}" name="recipientId"/>
                            <input type="text" name="content" class="msg-input" placeholder="메시지 입력 (최대 200자)"
                                   maxlength="200" aria-label="메시지 내용"/>
                            <button type="submit" class="msg-send">전송</button>
                        </form>
                    </li>
                </c:forEach>

                <c:if test="${empty memberList}">
                    <li class="empty">보낼 수 있는 회원이 없습니다.</li>
                </c:if>
            </ul>

        </div>
    </div>
</div>

<script>
    // 아바타: data-id 속성에서 첫 글자(문자열의 첫 코드포인트)를 안전하게 표시
    (function () {
        function firstChar(str) {
            if (!str) return '';
            // unicode surrogate-safe first grapheme-ish (approx): use Array.from to handle astral plane
            return Array.from(str.trim())[0] || '';
        }

        document.querySelectorAll('.avatar').forEach(function (el) {
            var id = el.getAttribute('data-id') || '';
            var ch = firstChar(id);
            if (ch) {
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
