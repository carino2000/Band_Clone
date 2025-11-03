<%-- my-posting.jsp (최소 변경, fn 미사용, 동작 보장) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>my-posting</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 최소 스타일 보완 (원본 느낌 유지) */
        body { margin:0; font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", Arial, sans-serif; background:#fff; color:#111; }
        .main { max-width:1100px; margin:20px auto; padding:12px; display:flex; gap:12px; box-sizing:border-box; }
        .col-side { flex:1; min-width:180px; }
        .col-center { flex:4; min-width:480px; }
        .article-item { padding:12px; border-bottom:1px solid #f0f0f0; }
        .article-link { text-decoration:none; color:inherit; }
        .meta { color:#666; font-size:13px; margin-top:6px; }
        .heading { margin-top:20px; margin-bottom:12px; font-weight:700; color:#0b3e16; }
        @media (max-width:920px) { .main { flex-direction:column; } }
    </style>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="main">
    <div class="col-side">
        <!-- left side (빈 공간 유지) -->
    </div>

    <div class="col-center">
        <div class="heading">----------------- 내가 쓴 글 -----------------</div>

        <c:if test="${empty writerId}">
            <div class="article-item">
                <div>작성한 글이 없습니다.</div>
            </div>
        </c:if>

        <c:forEach items="${writerId}" var="one">
            <div class="article-item" role="article" aria-label="내가 쓴 글">
                <div style="display:flex; justify-content:space-between; align-items:flex-start; gap:12px; flex-wrap:wrap;">
                    <div>
                        <div>
                            <span><b>'<c:out value='${one.bandName}'/>'</b> 밴드에서 <c:out value='${one.writerId}'/>님이 작성한 글 입니다.</span>
                        </div>
                        <div class="meta">
                            &middot; <small><c:out value='${one.wroteAt}'/>에 작성함</small>
                        </div>
                    </div>
                </div>

                <div style="margin-top:8px;">
                    <a class="article-link" href="<c:url value='/band'/>?no=<c:out value='${one.bandNo}'/>">
                        <span style="font-size:1.05rem; font-weight:500; display:block;"><c:out value='${one.content}'/></span>
                    </a>
                </div>

                <div style="margin-top:8px; display:flex; gap:8px; flex-wrap:wrap;">
                    <a href="<c:url value='/band'/>?no=<c:out value='${one.bandNo}'/>" style="text-decoration:none;">
                        <button type="button" style="padding:6px 10px; border-radius:6px; border:1px solid #e6e6e6; background:#fff; cursor:pointer;">밴드 보기</button>
                    </a>

                    <a href="<c:url value='/article/edit'/>?idx=<c:out value='${one.idx}'/>&bandNo=<c:out value='${one.bandNo}'/>" style="text-decoration:none;">
                        <button type="button" style="padding:6px 10px; border-radius:6px; border:1px solid #e6e6e6; background:#fff; cursor:pointer;">수정</button>
                    </a>

                    <button type="button" onclick="if(confirm('해당 게시글을 삭제하시겠습니까?')) location.href='<c:url value='/article/delete'/>?idx=<c:out value='${one.idx}'/>&bandNo=<c:out value='${one.bandNo}'/>';"
                            style="padding:6px 10px; border-radius:6px; border:1px solid #f5c6c6; background:#fff; color:#b52b2b; cursor:pointer;">
                        삭제
                    </button>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="col-side">
        <!-- right side (빈 공간 유지) -->
    </div>
</div>

</body>
</html>
