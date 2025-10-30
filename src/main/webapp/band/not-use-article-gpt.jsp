<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 29.
  Time: 오전 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>${band.name} - Band</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
    <style>
        :root{
            --bg:#f4f6fb; --card:#fff; --muted:#6b7280; --accent:#3b82f6; --radius:12px; --shadow:0 8px 24px rgba(2,6,23,0.06);
        }
        html,body{height:100%;margin:0;font-family:Inter, "Noto Sans KR", system-ui, -apple-system, Roboto, "Segoe UI", sans-serif;background:var(--bg);color:#0f172a}
        .wrap{max-width:1000px;margin:28px auto;padding:18px;display:flex;gap:20px}
        .col-side{flex:1;min-width:160px}
        .col-main{flex:4;min-width:600px}

        /* 헤더 배너 */
        .band-header{background:linear-gradient(90deg, rgba(59,130,246,0.06), rgba(99,102,241,0.02));padding:18px;border-radius:var(--radius);display:flex;align-items:center;gap:16px;box-shadow:var(--shadow)}
        .band-title{font-size:1.25rem;font-weight:700}
        .band-sub{color:var(--muted);font-size:0.95rem}
        .band-actions{margin-left:auto;display:flex;gap:8px}
        .btn{background:var(--accent);color:#fff;padding:8px 12px;border-radius:10px;text-decoration:none;font-weight:600;border:none;cursor:pointer}
        .btn.ghost{background:transparent;color:var(--accent);border:1px solid rgba(59,130,246,0.12)}

        /* 게시글 작성 박스 */
        .write-box{background:var(--card);padding:12px;border-radius:10px;border:1px solid rgba(15,23,42,0.04);box-shadow:var(--shadow);margin-top:14px}
        .write-box textarea{width:100%;height:88px;border-radius:8px;border:1px solid rgba(15,23,42,0.06);padding:10px;font-size:0.95rem;resize:vertical}
        .write-box .controls{display:flex;justify-content:space-between;align-items:center;margin-top:10px}

        /* 게시글 리스트 */
        .posts{margin-top:20px;display:flex;flex-direction:column;gap:14px}
        .post-card{background:var(--card);border-radius:10px;padding:14px;border:1px solid rgba(15,23,42,0.04);box-shadow:var(--shadow)}
        .post-meta{display:flex;gap:10px;align-items:center;color:var(--muted);font-size:0.9rem;margin-bottom:8px}
        .post-content{font-size:1rem;line-height:1.5;color:#0b1220}

        /* 댓글 */
        .comment-box{margin-top:10px;display:flex;gap:8px;align-items:flex-start}
        .comment-box input[type="text"]{flex:1;padding:8px;border-radius:8px;border:1px solid rgba(15,23,42,0.06)}
        .comment-list{margin-top:10px;padding-left:14px;color:var(--muted)}

        /* 비공개 / 승인 대기 메시지 */
        .notice{background:linear-gradient(90deg, rgba(245,158,11,0.06), rgba(245,158,11,0.02));padding:12px;border-radius:8px;color:#92400e}

        /* 반응형 */
        @media (max-width:880px){.wrap{flex-direction:column;padding:12px}.col-side{display:none}}
    </style>
</head>
<body>
<%@include file="/template/header.jspf" %>

<div class="wrap">
    <div class="col-side">
        <!-- 사이드 : 간단 정보나 멤버 요약 -->
        <div style="background:var(--card);padding:12px;border-radius:10px;box-shadow:var(--shadow);border:1px solid rgba(15,23,42,0.04);position:sticky;top:20px">
            <h3 style="margin:0 0 8px 0">밴드 정보</h3>
            <p style="margin:0;font-weight:700">${band.name}</p>
            <p style="margin:6px 0 0 0;color:var(--muted)">${band.topic}</p>
            <a href="/band/join?bandNo=${band.no}" class="btn ghost" style="display:inline-block;margin-top:10px">가입 신청</a>
        </div>
    </div>

    <main class="col-main">
        <div class="band-header">
            <div>
                <div class="band-title">${band.name}</div>
                <div class="band-sub">${band.masterId} · ${one.prettyCreatedAt}</div>
            </div>
            <div class="band-actions">
                <a href="/band/members?bandNo=${band.no}" class="btn ghost">멤버보기</a>
                <c:if test="${isMaster}">
                    <a href="/band/requests?bandNo=${band.no}" class="btn">가입신청 관리</a>
                </c:if>
            </div>
        </div>

        <div class="write-box">
            <form action="/band/new-article" method="post" id="createNewArticle">
                <input type="hidden" value="${band.no}" name="bandNo"/>
                <textarea name="content" id="content" placeholder="새로운 소식을 남겨보세요." style="width: 97%"></textarea>
                <div class="controls">
                    <div style="color:var(--muted);font-size:0.9rem">멤버와 소식을 공유하세요</div>
                    <div style="display:flex;gap:8px">
                        <button type="button" class="btn" onclick="reactionHandle(${isNotMember})">게시</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="posts">
            <c:choose>
                <c:when test="${isPrivate && isNotMember}">
                    <div class="notice">비공개 밴드입니다! 게시글을 확인하시려면 ${band.name} 밴드에 가입해주세요</div>
                </c:when>
                <c:when test="${isPrivate && !isApproved}">
                    <div class="notice">아직 밴드 멤버가 아닙니다! 밴드 마스터가 신청을 수리할 때까지 기다려주세요</div>
                </c:when>
                <c:when test="${articleNotExists}">
                    <div class="post-card"><h3 style="margin:0">아직 게시글이 없어요!</h3><p class="post-content" style="margin-top:8px;color:var(--muted)">처음으로 소식을 남겨보세요.</p></div>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${articles}" var="one">
                        <div class="post-card">
                            <div class="post-meta">
                                <div style="font-weight:700">${one.writerId}</div>
                                <div>${one.prettyWroteAt}</div>
                            </div>

                            <div class="post-content">
                                <c:out value="${one.content}"/>
                            </div>

                            <c:if test="${!isNotMember}">
                                <div style="margin-top:12px">
                                    <div class="comment-box">
                                        <form action="/band" method="post" style="display:flex;flex:1;gap:8px;align-items:center">
                                            <input type="text" name="comment" id="comment" class="input" placeholder="댓글을 남겨주세요"/>
                                            <input type="hidden" name="articleNo" value="${one.idx}"/>
                                            <input type="hidden" name="bandNo" value="${band.no}"/>
                                            <button type="button" class="btn" onclick="reactionHandle(${isNotMember})">작성하기</button>
                                        </form>
                                    </div>
                                </div>
                            </c:if>

                            <div class="comment-list">
                                <ul>
                                    <c:forEach items="${one.articleComments}" var="c">
                                        <li style="margin-bottom:6px"> <strong>${c.writerId}</strong>: ${c.comment} <small style="color:var(--muted)">(${c.prettyWritingTime})</small></li>
                                    </c:forEach>
                                </ul>
                            </div>

                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>

    </main>

    <aside class="col-side">
        <div style="background:var(--card);padding:12px;border-radius:10px;box-shadow:var(--shadow);border:1px solid rgba(15,23,42,0.04);position:sticky;top:20px">
            <h3 style="margin:0 0 8px 0">빠른 알림</h3>
            <p style="margin:0;color:var(--muted)">가입 신청, 쪽지 등을 확인하세요.</p>
        </div>
    </aside>
</div>

<script>
    function reactionHandle(isNotMember) {
        if (isNotMember) {
            if (window.confirm("밴드 가입이 필요한 기능입니다.\n밴드 가입 페이지로 이동하시겠습니까?")) {
                location.href = "/band/join?bandNo=${band.no}";
            }
        } else {
            document.getElementById("createNewArticle").submit();
        }
    }
</script>

</body>
</html>
