<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width">
    <title>커뮤니티 게시판</title>
    <link href="/css/CommuList.css" rel="stylesheet">
    <!-- FontAwesome CDN 링크 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<jsp:include page="../include/navbar.jsp"/>
<br/>
<body>
<div class="container">
<div class="info">
    <h2>커뮤니티</h2>
    <p>공유하고 싶은 정보를 서로 공유하세요!</p>
</div>

<%--검색 폼--%>
<form method="get" class="search-form">
    <div class="search-box">
        <select name="searchField" class="search-select">
            <option value="title">제목</option>
            <option value="content">내용</option>
        </select>
        <input type="text" name="searchWord" class="search-input" placeholder="원하시는 키워드를 입력하세요.">
        <button type="submit" class="search-button">
            <i class="fa-solid fa-magnifying-glass"></i>
        </button>
    </div>
</form>

<%--글쓰기, 최신순 버튼--%>
<div class="button-container">
    <button type="button" onclick="location.href='../mvcboard/write.do';">글쓰기</button>
    <select class="sort" name="sort">
        <option value="latest">최신순</option>
        <option value="comments">댓글순</option>
    </select>
</div>


<%--게시물 목록 테이블--%>
<table class="board-table">
<%--    <tr>--%>
<%--        &lt;%&ndash;글 번호&ndash;%&gt;--%>
<%--        <th width="10%">번호</th>--%>
<%--        &lt;%&ndash;작성자&ndash;%&gt;--%>
<%--        <th width="15%">작성자</th>--%>
<%--        &lt;%&ndash;제목&ndash;%&gt;--%>
<%--            <th width="*">제목</th>--%>
<%--            &lt;%&ndash;조회수&ndash;%&gt;--%>
<%--        <th width="10%">조회수</th>--%>
<%--            &lt;%&ndash;작성일&ndash;%&gt;--%>
<%--        <th width="15%">작성일</th>--%>
<%--            &lt;%&ndash;첨부파일&ndash;%&gt;--%>
<%--&lt;%&ndash;        <th width="8%">첨부파일</th>&ndash;%&gt;--%>
<%--    </tr>--%>

    <c:choose>
        <c:when test="${empty boardList}">
            <%--게시글이 없을 때--%>
            <tr>
                <td colspan="5" align="center">
                    등록된 게시물이 없습니다.
                </td>
            </tr>
        </c:when>
        <c:otherwise>
            <%--게시글이 있을 때--%>
            <c:forEach items="${boardList}" var="row" varStatus="loop">
                <tr align="center" class="board-list tr1">
                    <td rowspan="2" width="3%">${row.num}</td>
                    <td colspan="2" width="60%">${row.id}</td>
                    <td width="15%">${row.postdate}</td>
                </tr>
                <tr align="center" class="board-list tr2">
                    <td align="left" width="70%">
                        <a href="../mvcboard/view.do?num=${row.num}">${row.title}</a>
                    </td>
                    <td><i class="fa-solid fa-eye" width="5%"> ${row.visitcount}</i></td>
                    <td><i class="fa-regular fa-comments" width="15%"> ${row.replyCount} </i></td>
                </tr>
            </c:forEach>
        </c:otherwise>
    </c:choose>


</table>

<table class="paging">
    <tr>
        <td>
            ${map.pagingImg}
        </td>
    </tr>
</table>
</div>
<br/>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>
