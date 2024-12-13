<%@ page import="com.project.dailyeat.mvcboard.ReplyDAO" %>
<%@ page import="com.project.dailyeat.mvcboard.ReplyDTO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>DailyEat 커뮤니티</title>
    <!-- CSS 파일 링크 -->
    <link rel="stylesheet" type="text/css" href="/css/CommuView.css">
    <!-- Font Awesome 스크립트 추가 -->
    <script src="https://kit.fontawesome.com/849bb0fdc9.js" crossorigin="anonymous"></script>
</head>
<body>
<!-- 내비게이션 메뉴 -->
    <jsp:include page="../include/navbar.jsp"/>
<!-- 전체 컨테이너 -->
<div class="container">

    게시글 영역 구분선 -->
    <hr class="section-divider">

    <!-- 메인 콘텐츠 영역 -->
    <main>
        <!-- 게시글 상세보기 섹션 -->
        <section class="post-detail">
            <div class="post-info">
                <div class="info-item">
                    <span class="label">번호:</span>
                    <span class="value">${ dto.num }</span>
                    <span class="label">작성자:</span>
                    <span class="value">${ dto.id }</span>
                    <span class="label">작성일:</span>
                    <span class="value">${ dto.postdate }</span>
                    <span class="label"><i class="fa-solid fa-eye" width="5%"></i></span>
                    <span class="value">${dto.visitcount}</span>
                    <span><i class="fa-regular fa-comments" width="15%"></i> </span>
                    <span class="value">${replyCount}</span>
                </div>
            </div>
            <div class="post-title">
                <span class="label">제목</span>
                <span class="value">${ dto.title }</span>
            </div>
            <hr class="content-divider">
            <div class="post-content">
                <span class="label">내용</span>
                <div class="content">
                    ${ dto.content }
                    <c:if test="${not empty dto.ofile and isImage eq true}">
                        <br>
                        <img src="../upload/${dto.sfile}" style="max-width: 100%;"/>
                    </c:if>
                </div>
            </div>
            <div class="post-actions">
                <button type="button" onclick="location.href='../../mvcboard/pass.do?mode=edit&num=${ param.num }';">수정하기</button>
                <button type="button" onclick="location.href='../../mvcboard/pass.do?mode=delete&num=${ param.num }';">삭제하기</button>
                <button type="button" onclick="location.href='../../mvcboard/list.do';">목록 바로가기</button>
            </div>
        </section>

        <!-- 댓글 입력 섹션 -->
        <section class="comment-section">
            <c:if test="${not empty sessionScope.loginMember}">
                <form action="/mvcboard/insertReply" method="post">
                    <textarea name="content" placeholder="댓글을 작성하세요" required></textarea>
                    <input type="hidden" name="boardnum" value="${dto.num}">
                    <div class="comment-btn-wrapper">
                        <button class="comment-btn" type="submit">댓글쓰기</button>
                    </div>
                </form>
            </c:if>
            <c:if test="${empty sessionScope.loginMember}">
                <p>댓글을 작성하려면 <a href="/project/login/LoginMain.jsp">로그인</a>이 필요합니다.</p>
            </c:if>
        </section>




        <!-- 댓글 목록 섹션 -->

        <section class="comments">
            <h3>댓글</h3>

<%--            <c:forEach var="comment" items="${replies}">--%>


            <c:forEach var="comment" items="${replies}">
                <div class="comment">
                    <form method="post" action="/mvcboard/loadReplies">
                    <span class="author">${comment.id}</span> <!-- 댓글 작성자의 ID -->
                    <span class="time">${comment.rdate}</span> <!-- 댓글 작성 시간 -->
                    <p>${comment.content}</p> <!-- 댓글 내용 -->
                    </form>
                    

                    <c:if test="${sessionScope.loginMember.id == comment.id}">
                        <form action="/mvcboard/deleteReply" method="post" style="display:inline;">
                            <input type="hidden" name="replyNum" value="${comment.replynum}">
                            <input type="hidden" name="boardnum" value="${dto.num}">
                            <button type="submit" class="delete-btn">삭제</button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
            <%
                List<ReplyDTO> replies = (List<ReplyDTO>) request.getAttribute("replies");
                if (replies != null) {
                    for (ReplyDTO reply : replies) {
                        out.println("Reply: " + reply.getId() + " - " + reply.getContent() + "<br>");
                    }
                } else {
                    out.println("No replies found.");
                }
            %>
            <!-- 댓글이 없을 경우 표시할 메시지 -->
            <c:if test="${empty replies}">
                <p>댓글이 없습니다.</p>
            </c:if>
        </section>

    </main>

</div>
<!-- 푸터 섹션 -->
<footer>
<jsp:include page="../include/footer.jsp"/>
</footer>
</body>
</html>
