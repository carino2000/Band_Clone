<%-- my-loginHistory.jsp (fn 태그 미사용 버전) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8"/>
    <title>my login history</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
    <style>
        /* 최소 스타일 (연두/초록 테마) */
        body { background:#f6fff6; color:#083214; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; margin:0; padding:0; }
        .main { display:flex; gap:16px; max-width:1100px; margin:20px auto; padding:0 12px; box-sizing:border-box; align-items:flex-start; }
        .col { display:flex; flex-direction:column; gap:12px; }
        .side { flex:1; min-width:200px; }
        .center { flex:4; min-width:520px; }

        .banner { height:120px; border-radius:10px; background:linear-gradient(90deg,#f0fff0,#e8f7e8); display:flex; align-items:center; justify-content:center; color:#1a7f2a; font-weight:700; margin-bottom:12px; border:1px solid rgba(15,90,20,0.04); }
        h2 { margin:8px 0; color:#0c3e16; }

        .article-item { padding:12px; border-radius:8px; background:linear-gradient(180deg,#ffffff,#fbfff9); border:1px solid rgba(18,80,20,0.04); margin-bottom:8px; }
        .meta { color:#2d6f2f; font-weight:700; }
        .sub { color:#557a54; font-size:13px; margin-top:6px; }

        .pager { padding:1.5rem 0; margin-top:2rem; text-align:center; }
        .pager button { margin:0 6px; padding:8px 12px; border-radius:8px; border:1px solid transparent; background:transparent; cursor:pointer; color:#154f22; font-weight:700;}
        .pager button:hover{ background:#eefbe9; }
        .pager .active { background:linear-gradient(180deg,#2bd34c,#1aa61f); color:#fff; box-shadow:0 6px 14px rgba(26,166,31,0.12); }

        .empty { padding:16px; text-align:center; color:#6b8a6b; }
        @media (max-width:920px){ .main{ flex-direction:column; } .side{min-width:unset;} }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="main">
    <div class="side">
        <!-- 좌측 빈공간(기존 구조 유지) -->
    </div>

    <div class="center">
        <div class="banner">이미지 베너</div>

        <h2><c:out value="${member.id}"/>님의 접속 기록</h2>

        <div>
            <c:forEach items="${history}" var="one">
                <div class="article-item">
                    <div style="display:flex; justify-content:space-between; align-items:center;">
                        <div>
                            <div class="meta">IP : <c:out value="${one.loginIp}"/></div>
                            <div class="sub">&middot; <c:out value="${one.prettyLoginAt}"/></div>
                        </div>
                        <div class="sub">
                            <c:choose>
                                <c:when test="${not empty one.userAgent}">
                                    <c:out value="${one.userAgent}"/>
                                </c:when>
                                <c:otherwise>
                                    -
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty history}">
                <div class="empty">로그인 기록이 없습니다.</div>
            </c:if>
        </div>

        <div class="pager" role="navigation" aria-label="페이지 네비게이션">
            <c:forEach var="i" begin="1" end="${maxPage}">
                <c:url var="pageUrl" value="/my-loginHistory">
                    <c:param name="page" value="${i}"/>
                </c:url>

                <c:choose>
                    <c:when test="${i == currentPage}">
                        <button type="button" class="active" onclick="location.href='${pageUrl}'"><c:out value="${i}"/></button>
                    </c:when>
                    <c:otherwise>
                        <button type="button" onclick="location.href='${pageUrl}'"><c:out value="${i}"/></button>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>
    </div>

    <div class="side">
        <!-- 우측 빈공간(기존 구조 유지) -->
    </div>
</div>

</body>
</html>
