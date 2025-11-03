<%-- article-edit.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html lang="ko">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <title>게시글 수정 | <c:out value="${fn:escapeXml(bandName)}"/></title>
    <link rel="stylesheet" href="<c:url value='/static/css/style.css'/>"/>
    <style>
        /* 페이지 전용 최소 스타일 (global style과 충돌할 수 있으니 필요하면 삭제) */
        .wrap {
            max-width: 1100px;
            margin: 20px auto;
            padding: 0 12px;
            box-sizing: border-box;
        }

        .main {
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

        .card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 10px;
            padding: 14px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.03);
        }

        h2 {
            margin: 0 0 12px 0;
            font-size: 20px;
            color: #154b14;
        }

        label {
            font-weight: 600;
            color: #333;
            display: block;
            margin-bottom: 6px;
        }

        .textarea {
            width: 100%;
            min-height: 300px;
            padding: 12px;
            box-sizing: border-box;
            border-radius: 8px;
            border: 1px solid #e6e6e6;
            resize: vertical;
            font-size: 14px;
            line-height: 1.5;
        }

        .form-row {
            display: flex;
            justify-content: space-between;
            gap: 8px;
            align-items: center;
            margin-top: 16px;
        }

        .btn {
            padding: 8px 12px;
            border-radius: 8px;
            border: none;
            cursor: pointer;
            font-weight: 600;
        }

        .btn.reset {
            background: transparent;
            border: 1px solid #e6e6e6;
            color: #333;
        }

        .btn.submit {
            background: #1ec800;
            color: #fff;
            border: 1px solid #17b700;
        }

        .btn.cancel {
            background: #fff;
            color: #333;
            border: 1px solid #e6e6e6;
            text-decoration: none;
            padding: 8px 12px;
            border-radius: 8px;
        }

        .muted {
            color: #777;
            font-size: 13px;
        }

        @media (max-width: 880px) {
            .main {
                flex-direction: column;
            }
        }
    </style>

    <script>
        function validateArticleEdit() {
            var ta = document.getElementById('content');
            if (!ta) return true;
            var v = ta.value.trim();
            if (v.length === 0) {
                alert('본문을 입력해주세요.');
                ta.focus();
                return false;
            }
            if (v.length < 3) {
                alert('본문은 최소 3자 이상 입력해야 합니다.');
                ta.focus();
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
<%@ include file="/template/header.jspf" %>

<div class="wrap">
    <div class="main">
        <div style="flex: 1">
        </div>
        <div style="flex: 4">
            <main class="col center">
                <div class="card">
                    <h2>게시글 수정하기</h2>

                    <form id="editArticleForm" action="<c:url value='/article/edit'/>" method="post"
                          onsubmit="return validateArticleEdit();">
                        <input type="hidden" name="id" value="<c:out value='${article.writerId}'/>"/>
                        <input type="hidden" name="idx" value="<c:out value='${article.idx}'/>"/>
                        <input type="hidden" name="bandNo" value="<c:out value='${bandNo}'/>"/>

                        <div>
                            <label for="content">본문</label>
                            <textarea id="content" name="content" class="textarea" placeholder="수정할 본문을 입력하세요."><c:out
                                    value='${article.content}'/></textarea>
                        </div>

                        <div class="form-row">
                            <div>
                                <button type="reset" class="btn reset">지우기</button>
                            </div>

                            <div style="display:flex; gap:8px;">
                                <a href="<c:url value='/article/view'><c:param name='idx' value='${article.idx}'/><c:param name='bandNo' value='${bandNo}'/></c:url>"
                                   class="btn cancel">취소</a>
                                <button type="submit" class="btn submit">수정하기</button>
                            </div>
                        </div>
                    </form>
                </div>
            </main>
        </div>
        <div style="flex: 1">
        </div>

        <!-- 중앙: 편집 폼 -->

    </div>
</div>

</body>
</html>
