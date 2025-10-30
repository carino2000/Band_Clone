<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 28.
  Time: 오후 1:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Band Main</title>
    <link rel="stylesheet" href="/static/css/style.css"/>

    <!-- 페이지 전용 간단한 스타일 (외부 css를 건드리기 어렵다면 이 블록만 수정하세요) -->
    <style>
        :root{
            --bg: #f6f7fb;
            --card: #ffffff;
            --muted: #6b7280;
            --accent: #3b82f6;
            --accent-dark: #1e40af;
            --radius: 12px;
            --shadow: 0 6px 18px rgba(15,23,42,0.07);
        }
        html,body{height:100%;margin:0;font-family:Inter, "Segoe UI", Roboto, "Noto Sans KR", -apple-system, sans-serif;background:var(--bg);color:#0f172a}
        .container{max-width:1100px;margin:28px auto;padding:20px;display:flex;gap:20px}
        /* 좌/중/우 레이아웃 */
        .col-side{flex:1;min-width:160px}
        .col-main{flex:4;min-width:540px}

        /* 배너 */
        .banner{background:linear-gradient(90deg, rgba(59,130,246,0.08), rgba(99,102,241,0.04));border-radius:var(--radius);padding:18px;display:flex;align-items:center;gap:16px;box-shadow:var(--shadow)}
        .banner h1{margin:0;font-size:1.15rem}
        .banner p{margin:0;color:var(--muted);font-size:0.95rem}

        /* 섹션 제목 */
        .section-title{margin:20px 0 12px;font-weight:600;color:#0b1220}
        .section-sub{color:var(--muted);font-size:0.9rem;margin-bottom:10px}

        /* 카드(밴드 아이템) */
        .article-item{background:var(--card);border-radius:10px;padding:14px;border:1px solid rgba(15,23,42,0.04);box-shadow:var(--shadow);margin-bottom:12px;display:flex;flex-direction:column;gap:8px}
        .article-top{display:flex;align-items:center;gap:10px;justify-content:space-between}
        .article-meta{display:flex;flex-wrap:wrap;gap:8px;align-items:center}
        .article-topic{display:inline-block;background:rgba(15,23,42,0.04);padding:4px 8px;border-radius:999px;font-size:0.82rem;color:var(--muted)}
        .article-link{color:inherit;text-decoration:none}
        .article-link:hover{text-decoration:underline;color:var(--accent-dark)}
        .article-title{font-size:1.05rem;font-weight:600}
        .article-sub{color:var(--muted);font-size:0.88rem}

        /* 상태 태그 */
        .tag{font-size:0.75rem;padding:6px 8px;border-radius:999px;border:1px solid rgba(15,23,42,0.06);background:#fff}
        .tag.waiting{color:#92400e;border-color:#f59e0b;background:rgba(245,158,11,0.06)}
        .tag.owner{color:var(--accent-dark);border-color:rgba(59,130,246,0.12)}

        /* 반응형 */
        @media (max-width:880px){
            .container{flex-direction:column;padding:12px}
            .col-side{display:none}
            .col-main{min-width:0}
        }
    </style>
</head>
<body>
<%@include file="/template/header.jspf" %>

<div class="container">
    <div class="col-side">
        <!-- 빈 공간: 추후 사이드바(알림 요약 등) 추가 가능 -->
    </div>

    <main class="col-main">
        <div class="banner">
            <div>
                <h1>내 밴드 홈</h1>
                <p>내가 만든 밴드, 가입한 밴드, 그리고 새로운 밴드를 한눈에 확인해보세요.</p>
            </div>
            <div style="margin-left:auto;display:flex;gap:8px;align-items:center">
                <a href="/band-create" class="tag owner">+ 밴드 만들기</a>
            </div>
        </div>

        <section aria-label="내가 만든 밴드">
            <h2 class="section-title">내가 만든 밴드</h2>
            <p class="section-sub">내가 생성한 밴드를 관리할 수 있습니다.</p>

            <c:forEach items="${myBands}" var="one">
                <div class="article-item">
                    <div class="article-top">
                        <div>
                            <div class="article-meta">
                                <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                    <span class="article-topic text-gray">${topic}</span>
                                </c:forEach>
                                <span class="tag owner">${one.masterId}님의 밴드</span>
                                <span class="article-sub">&middot; <small>${one.prettyCreatedAt}에 창설됨</small></span>
                            </div>
                        </div>
                        <div style="display:flex;gap:8px;align-items:center">
                            <a href="/band?no=${one.no}" class="article-link">보기</a>
                        </div>
                    </div>

                    <div>
                        <a href="/band?no=${one.no}" class="article-link">
                            <div class="article-title"><c:out value="${one.name}"/></div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </section>

        <section aria-label="내가 가입한 밴드">
            <h2 class="section-title">내가 가입한 밴드</h2>
            <p class="section-sub">가입 상태와 함께 확인할 수 있습니다.</p>

            <c:forEach items="${joinedBands}" var="one">
                <div class="article-item">
                    <div class="article-top">
                        <div>
                            <div class="article-meta">
                                <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                    <span class="article-topic text-gray">${topic}</span>
                                </c:forEach>
                                <span class="tag">${one.masterId}님의 밴드</span>
                                <span class="article-sub">&middot; <small>${one.prettyCreatedAt}에 창설됨</small></span>
                            </div>
                        </div>
                        <div style="display:flex;gap:8px;align-items:center">
                            <c:if test="${!one.approved}">
                                <span class="tag waiting">가입 승인 대기 중</span>
                            </c:if>
                            <a href="/band?no=${one.no}" class="article-link">보기</a>
                        </div>
                    </div>

                    <div>
                        <a href="/band?no=${one.no}" class="article-link">
                            <div class="article-title"><c:out value="${one.name}"/></div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </section>

        <section aria-label="전체 밴드">
            <h2 class="section-title">전체 밴드</h2>
            <p class="section-sub">다른 사용자가 만든 밴드들입니다. 관심 있는 밴드를 찾아보세요.</p>

            <c:forEach items="${otherBands}" var="one">
                <div class="article-item">
                    <div class="article-top">
                        <div>
                            <div class="article-meta">
                                <c:forEach items="${one.prettyTopic}" var="topic" varStatus="st">
                                    <span class="article-topic text-gray">${topic}</span>
                                </c:forEach>
                                <span class="tag">${one.masterId}님의 밴드</span>
                                <span class="article-sub">&middot; <small>${one.prettyCreatedAt}에 창설됨</small></span>
                            </div>
                        </div>
                        <div style="display:flex;gap:8px;align-items:center">
                            <a href="/band?no=${one.no}" class="article-link">가입/보기</a>
                        </div>
                    </div>

                    <div>
                        <a href="/band?no=${one.no}" class="article-link">
                            <div class="article-title"><c:out value="${one.name}"/></div>
                        </a>
                    </div>
                </div>
            </c:forEach>
        </section>

    </main>

    <aside class="col-side">
        <!-- 오른쪽 사이드바: 공지사항, 빠른 링크 등 -->
        <div class="article-item" style="position:sticky;top:20px">
            <h3 style="margin:0 0 8px 0">빠른 알림</h3>
            <p class="article-sub">가입 신청, 메시지 등 알림 설정을 확인하세요.</p>
            <ul style="margin:8px 0 0 16px;padding:0;color:var(--muted)">
                <li>새로운 가입 신청</li>
                <li>받지 않은 개인 메시지</li>
            </ul>
            <a href="/notifications" class="article-link" style="display:inline-block;margin-top:12px">알림 설정 바로가기</a>
        </div>
    </aside>
</div>

</body>
</html>
