<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 25. 10. 29.
  Time: 오전 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>band main</title>
    <link rel="stylesheet" href="/static/css/style.css"/>
</head>
<body>
<%@include file="/template/header.jspf" %>
<c:choose>
    <c:when test="${msg == 1}">
        <script>
            window.alert("게시글 수정이 정상 처리되었습니다.");
        </script>
    </c:when>
</c:choose>


<div class="main">
    <div style="flex: 1">
        <span>가입된 맴버</span>
        <div>
            <ul>
                <c:forEach items="${memberList}" var="m">
                    <li>
                        <div>
                            <span>${m.memberId}<br/></span>
                            <small><span>(${m.memberNickname}님)</span></small>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </div>
    <div style="flex: 4"> <!-- 중앙 -->
        <div><!-- 이미지 베너 -->
            이미지 베너
        </div>
        <div>
            <span>${band.name} 밴드에 오신걸 환영합니다!</span>
        </div>

        <div>
            <form action="/band/new-article" method="post" id="createNewArticle">
                <input type="hidden" value="${band.no}" name="bandNo"/>
                <div>
                    <textarea name="content" id="content" placeholder="새로운 소식을 남겨보세요."></textarea>
                </div>
                <button type="button" onclick="reactionHandle(${isNotMember})">게시</button>
            </form>
        </div>


        <div>
            <c:choose>
                <c:when test="${isPrivate && isNotMember}">
                    <h2>비공개 밴드입니다! 게시글을 확인하시려면 ${band.name} 밴드에 가입해주세요</h2>
                    <a href="/band/join?bandNo=${band.no}"><button>가입하기</button></a>
                </c:when>
                <c:when test="${isPrivate && !isApproved}">
                    <h2>아직 밴드 맴버가 아닙니다! 밴드 마스터가 신청을 수리할 때까지 기다려주세요</h2>
                </c:when>
                <c:when test="${articleNotExists}">
                    <h2>아직 게시글이 없어요!</h2>
                </c:when>
                <c:otherwise>
                    <c:if test="${!isPrivate && !isApproved}"><a href="/band/join?bandNo=${band.no}"><button>가입하기</button></a></c:if>
                    <c:forEach items="${articles}" var="one">
                        <div>
                            <span>${one.writerId}</span>
                            <span>${one.prettyWroteAt}</span>
                        </div>
                        <div class="article-item">
                            <div>
                                <span style="font-size: 1.1rem; font-weight: 500"><c:out
                                        value="${one.content}"/> </span>
                            </div>
                        </div>
                        <c:if test="${member.id == one.writerId}">
                            <div><!-- 스크랩, 즐찾 등 이미지 -->
                                <a href="/article/edit?idx=${one.idx}&bandNo=${band.no}">
                                    <button>수정:✂</button>
                                </a>
                                    <button onclick="deleteConfirm(${one.idx})">삭제:❌</button>
                            </div>
                        </c:if>
                        <div>
                            <c:if test="${!isNotMember}">
                                <p>${member.nickname}님의 의견을 남겨주세요</p>
                                <div>
                                    <form action="/band" method="post" id="newComment">
                                        <input type="text" name="comment" id="comment" class="input"
                                               style="width: 500px"
                                               placeholder="댓글을 남겨주세요">
                                        <input type="hidden" name="articleNo" value="${one.idx}">
                                        <input type="hidden" name="bandNo" value="${band.no}">
                                        <button type="button" onclick="commentReactionHandle(${isNotMember})">작성하기
                                        </button>
                                    </form>
                                </div>
                            </c:if>
                        </div>
                        <div>
                            <ul>
                                <c:forEach items="${one.articleComments}" var="c">
                                    <li>${c.writerId} : ${c.comment} - (${c.prettyWritingTime})</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>

        </div>


    </div>
    <div style="flex: 1">

    </div>

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

    function commentReactionHandle(isNotMember) {
        if (isNotMember) {
            if (window.confirm("밴드 가입이 필요한 기능입니다.\n밴드 가입 페이지로 이동하시겠습니까?")) {
                location.href = "/band/join?bandNo=${band.no}";
            }
        } else {
            document.getElementById("newComment").submit();
        }
    }

    function deleteConfirm(idx) {
        if (window.confirm("해당 게시글을 정말 삭제하시겠습니까?")) {
                location.href = "/article/delete?idx="+idx+"&bandNo=${band.no}";
        }
    }
</script>

</body>
</html>

