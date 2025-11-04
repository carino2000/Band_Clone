<%-- band-detail.jsp (예쁘게 정리된 버전) --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title><c:out value="${band.name}"/> - Band</title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 페이지 전용 스타일 (프로젝트 전역 스타일과 충돌 주의) */
        .wrap {
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 12px;
            box-sizing: border-box;
        }

        .layout {
            display: flex;
            gap: 18px;
            align-items: flex-start;
        }

        .col {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .left {
            flex: 1;
            min-width: 220px;
        }

        .center {
            flex: 4;
            min-width: 600px;
        }

        .right {
            flex: 1;
            min-width: 200px;
        }

        .card {
            background: #fff;
            border: 1px solid #aaaaaa;
            border-radius: 10px;
            padding: 14px;
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.03);
        }

        .muted {
            color: #777;
            font-size: 13px;
        }

        /* 멤버 리스트 */
        .member-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .member-item {
            display: flex;
            gap: 8px;
            align-items: center;
            padding: 8px;
            border-radius: 8px;
            background: #fafafa;
        }

        /* 헤더 영역 (밴드 이름 / 액션) */
        .band-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 8px;
            margin-bottom: 6px;
        }

        .band-title {
            font-size: 20px;
            font-weight: 800;
            color: #154b14;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        /* 버튼 */
        .btn {
            padding: 8px 12px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn.ghost {
            background: transparent;
            border: 1px solid #e6e6e6;
            color: #333;
        }

        .btn.primary {
            background: #1ec800;
            color: #fff;
        }

        .btn.warn {
            background: #ff5757;
            color: #fff;
        }

        /* 게시글 폼 */
        .textarea {
            width: 100%;
            min-height: 90px;
            padding: 10px;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #e6e6e6;
            resize: vertical;
        }

        /* 게시글/댓글 */
        .post {
            border-bottom: 1px solid #f2f2f2;
            padding: 12px 0;
        }

        .post-meta {
            display: flex;
            gap: 8px;
            color: #888;
            font-size: 13px;
            margin-bottom: 8px;
        }

        .post-content {
            font-size: 15px;
            color: #222;
            white-space: pre-wrap;
        }

        .comment-list {
            list-style: none;
            padding: 0;
            margin: 8px 0 0 0;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .comment-item {
            padding: 8px;
            background: #fafafa;
            border-radius: 8px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
        }

        @media (max-width: 880px) {
            .layout {
                flex-direction: column;
            }
        }
    </style>

    <%-- 서버 사이드로 URL/값 미리 생성 (JS에서 안전하게 사용) --%>
    <c:url var="joinBase" value="/band/join"/>
    <c:url var="bandLeaveUrl" value="/band-leave"/>
    <c:url var="bandDeleteUrl" value="/band-delete"/>
    <c:url var="articleDeleteUrl" value="/article/delete"/>
    <c:url var="commentDeleteUrl" value="/comment/delete"/>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap">
    <c:choose>
        <c:when test="${msg == 1}">
            <script>alert("게시글 수정이 정상 처리되었습니다.");</script>
        </c:when>
        <c:when test="${msg == 3}">
            <script>alert("댓글 삭제가 정상 처리되었습니다.");</script>
        </c:when>
    </c:choose>

    <div class="layout">
        <!-- LEFT: 가입된 멤버 목록 -->
        <aside class="col left">
            <div class="card">
                <h4 style="margin:0 0 8px 0;">가입된 멤버</h4>
                <ul class="member-list">
                    <c:forEach items="${memberList}" var="m">
                        <li class="member-item">
                            <div style="width:36px; height:36px; border-radius:6px; background:#eafbf0; display:flex; align-items:center; justify-content:center; font-weight:700; color:#157a1a;">
                                <c:out value="${fn:substring(m.memberNickname,0,1)}"/>
                            </div>
                            <div>
                                <div style="font-weight:700;"><c:out value="${m.memberId}"/></div>
                                <div class="muted">(<c:out value="${m.memberNickname}"/>님)</div>
                            </div>
                        </li>
                    </c:forEach>
                    <c:if test="${empty memberList}">
                        <li class="muted">가입된 멤버가 없습니다.</li>
                    </c:if>
                </ul>
            </div>
        </aside>

        <!-- CENTER: 밴드 헤더 / 게시글 영역 -->
        <main class="col center">
            <div class="card">
                <div class="band-header">
                    <div>
                        <div class="band-title"><c:out value="${band.name}"/></div>
                        <div class="muted">운영자: <c:out value="${band.masterId}"/> · 생성일: <c:out
                                value="${band.prettyCreatedAt}"/></div>
                    </div>

                    <div class="actions" role="group" aria-label="밴드 액션">
                        <c:choose>
                            <c:when test="${!isNotMember && member.id == band.masterId}">
                                <!-- 밴드 삭제: POST 폼 -->
                                <form id="bandDeleteForm" action="<c:url value='/band-delete'/>" method="post"
                                      style="display:inline;">
                                    <input type="hidden" name="bandNo" value="<c:out value='${band.no}'/>"/>
                                    <input type="hidden" name="masterId" value="<c:out value='${band.masterId}'/>"/>
                                    <button type="button" class="btn warn"
                                            onclick="confirmAndSubmit('bandDeleteForm', '정말로 이 밴드를 삭제하시겠습니까? 삭제 시 복구할 수 없습니다.')">
                                        밴드 삭제
                                    </button>
                                </form>
                            </c:when>
                            <c:when test="${!isNotMember && member.id != band.masterId}">
                                <form id="bandLeaveForm" action="<c:url value='/band-leave'/>" method="post"
                                      style="display:inline;">
                                    <input type="hidden" name="bandNo" value="<c:out value='${band.no}'/>"/>
                                    <button type="button" class="btn ghost"
                                            onclick="confirmAndSubmit('bandLeaveForm', '정말로 이 밴드에서 탈퇴하시겠습니까?')">밴드 탈퇴
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <a href="<c:url value='/band/join'><c:param name='bandNo' value='${band.no}'/></c:url>"
                                   class="btn primary">가입하기</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <%-- 게시글 작성 폼(권한 있는 경우) --%>
                <c:if test="${!isNotMember}">
                    <form id="createNewArticle" action="<c:url value='/band/new-article'/>" method="post"
                          style="margin-top:12px;">
                        <input type="hidden" name="bandNo" value="<c:out value='${band.no}'/>"/>
                        <textarea name="content" id="content" class="textarea" placeholder="새로운 소식을 남겨보세요."></textarea>
                        <div style="margin-top:8px; display:flex; gap:8px; justify-content:flex-end;">
                            <button type="button" class="btn primary"
                                    onclick="document.getElementById('createNewArticle').submit();">게시
                            </button>
                        </div>
                    </form>
                </c:if>

            </div>

            <%-- 게시글 목록 / 상태 메시지 --%>
            <div style="margin-top:12px;">
                <c:choose>
                    <c:when test="${isPrivate && isNotMember}">
                        <div class="card" style="text-align:center;">
                            <h3>비공개 밴드입니다</h3>
                            <p class="muted">게시글을 확인하려면 밴드에 가입해주세요.</p>
                            <a href="<c:url value='/band/join'><c:param name='bandNo' value='${band.no}'/></c:url>"
                               class="btn primary">가입하기</a>
                        </div>
                    </c:when>

                    <c:when test="${isPrivate && !isApproved}">
                        <div class="card">
                            <h3>가입 승인 대기 중</h3>
                            <p class="muted">밴드 마스터가 신청을 수락할 때까지 기다려주세요.</p>
                        </div>
                    </c:when>

                    <c:when test="${articleNotExists}">
                        <div class="card">
                            <h3>게시글이 없습니다</h3>
                            <p class="muted">아직 게시글이 없어요. 소식을 남겨보세요.</p>
                        </div>
                    </c:when>

                    <c:otherwise>
                        <c:forEach items="${articles}" var="one" varStatus="st">
                            <div class="card post" style="margin-bottom:12px;">
                                <div style="display: flex; justify-content: space-between">
                                    <div class="post-meta" style="padding-left: 20px">
                                        <div><strong><c:out value="${one.writerId}"/></strong></div>
                                        <div class="muted"><c:out value="${one.prettyWroteAt}"/></div>
                                    </div>
                                    <div class="muted" style="margin-right: 20px">💬${one.commentCnt}</div>
                                </div>
                                <div style="background:#fafafa; border:1px solid #e6e6e6; border-radius:10px; padding:14px 18px; margin-top:5px; font-size:18px; line-height:1.6; color:#333; word-break:keep-all; box-shadow:0 4px 12px rgba(0,0,0,0.03);">
                                    <c:out value="${one.content}"/>
                                </div>


                                <div style="margin-top:10px; display:flex; gap:8px; justify-content:flex-end; align-items:center;">
                                    <c:if test="${member.id == one.writerId}">
                                        <a class="btn ghost"
                                           href="<c:url value='/article/edit'><c:param name='idx' value='${one.idx}'/><c:param name='bandNo' value='${band.no}'/></c:url>">수정</a>

                                        <form id="deleteArticleForm${one.idx}" action="<c:url value='/article/delete'/>"
                                              method="post" style="display:inline;">
                                            <input type="hidden" name="idx" value="<c:out value='${one.idx}'/>"/>
                                            <input type="hidden" name="bandNo" value="<c:out value='${band.no}'/>"/>
                                            <button type="button" class="btn warn"
                                                    onclick="confirmAndSubmit('deleteArticleForm${one.idx}', '해당 게시글을 정말 삭제하시겠습니까?')">
                                                삭제
                                            </button>
                                        </form>
                                    </c:if>
                                </div>

                                    <%-- 댓글 입력(멤버만) --%>
                                <c:if test="${!isNotMember}">
                                    <div style="margin-top:12px;">
                                        <form id="newComment${one.idx}" action="/band" method="post"
                                              style="display:flex; gap:8px; align-items:center;">
                                            <input type="hidden" name="articleNo" value="<c:out value='${one.idx}'/>"/>
                                            <input type="hidden" name="bandNo" value="<c:out value='${band.no}'/>"/>
                                            <input type="text" name="comment" placeholder="댓글을 남겨보세요"
                                                   style="flex:1; padding:8px 10px; border-radius:8px; border:1px solid #e6e6e6;"/>
                                            <button type="button" class="btn primary"
                                                    onclick="document.getElementById('newComment${one.idx}').submit();">
                                                작성
                                            </button>
                                        </form>
                                    </div>
                                </c:if>

                                    <%-- 댓글 목록 (각 댓글에 삭제 폼 포함, 작성자만 삭제 버튼 노출) --%>
                                <div style="margin-top:10px;">
                                    <ul class="comment-list">
                                        <c:forEach items="${one.articleComments}" var="cmt">
                                            <li class="comment-item">
                                                <div>
                                                    <strong><c:out value="${cmt.writerId}"/></strong>
                                                    <span class="muted" style="margin-left:8px;">(<c:out
                                                            value="${cmt.prettyWritingTime}"/>)</span>
                                                    <div style="margin-top:6px;"><c:out value="${cmt.comment}"/></div>
                                                </div>

                                                <div>
                                                    <c:if test="${cmt.writerId == member.id}">
                                                        <form id="deleteCommentForm${cmt.idx}"
                                                              action="<c:url value='/comment/delete'/>" method="post"
                                                              style="display:inline;">
                                                            <input type="hidden" name="idx"
                                                                   value="<c:out value='${cmt.idx}'/>"/>
                                                            <input type="hidden" name="bandNo"
                                                                   value="<c:out value='${band.no}'/>"/>
                                                            <input type="hidden" name="writerId"
                                                                   value="${cmt.writerId}">
                                                            <button type="button" class="btn warn"
                                                                    onclick="confirmAndSubmit('deleteCommentForm${cmt.idx}', '해당 댓글을 삭제하시겠습니까?')">
                                                                삭제
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </li>
                                        </c:forEach>

                                        <c:if test="${empty one.articleComments}">
                                            <li class="muted">댓글이 없습니다.</li>
                                        </c:if>
                                    </ul>
                                </div>

                            </div>
                            <!-- .post -->
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

        </main>

        <!-- RIGHT: 내 활동 / 링크 -->
        <aside class="col right">
            <div class="card">
                <h4 style="margin:0 0 8px 0;">내 활동 바로가기</h4>
                <ul style="list-style:none; padding-left:0; margin:0; display:flex; flex-direction:column; gap:8px;">
                    <li><a href="<c:url value='/my-page'/>" class="muted">내 정보</a></li>
                    <li><a href="<c:url value='/my/posts'/>" class="muted">작성한 글</a></li>
                    <li><a href="<c:url value='/my/comments'/>" class="muted">댓글</a></li>
                    <li><a href="<c:url value='/my/notice'/>" class="muted">알림<c:if test='${noticeCnt != 0}'> (<c:out
                            value='${noticeCnt}'/>)</c:if></a></li>
                </ul>
            </div>
        </aside>
    </div>
</div>

<script>
    // 공용 확인 + 폼 제출 함수
    function confirmAndSubmit(formId, message) {
        if (!formId) return;
        if (confirm(message)) {
            var f = document.getElementById(formId);
            if (f) f.submit();
        }
    }
</script>
</body>
</html>
