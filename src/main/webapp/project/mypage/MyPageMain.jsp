<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<style>
    .myPage-content {
        display: flex;
        width: 1000px;
        min-height: 700px;
        margin: 90px auto;
        font-family: 'NanumSquareRound', 'sans-serif';
        justify-content: center;
    }

    .list-group > li {
        height: 50px;
        font-size: 18px;
    }

    .list-group > li > a {
        color: black;
        text-decoration: none;

        display: flex;
        height: 100%;

        justify-content: center;
        align-items: center;

        border-bottom: 2px solid #ddd;
    }

    .list-group > li > a:hover {
        background-color: #ccc;
    }

    /* ********************************* */
    /* 마이페이지 공통 */
    .myPage-main {
        width: 75%;
        padding: 0 50px;
        margin-top: 20px;
    }

    .myPage-main-title {
        text-align: center;
    }

    /* 마이페이지 제목 */
    .myPage-title {
        margin-bottom: 10px;
        font-size: 30px;
    }

    /* 마이페이지 부제 */
    .myPage-subject {
        display: block;
        margin-bottom: 30px;

        font-size: 14px;
        letter-spacing: -1px;
    }

    .myPage-row > * {
        font-size: 18px;
        font-weight: bold;
    }

    /* 행 제목 */
    .myPage-row > label {
        width: 30%;
        color: #455ba8;
    }

    .myPage-row > span {
        width: 70%;
        color: #455ba8;
    }

    /* 행 내부 input 태그 */
    .myPage-row > input {
        width: 100%;
        height: 100%;
        border: none;
        outline: none;
        font-weight: normal;
    }

    /* form태그 */
    form[name='myPageFrm'] {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
    }


    .info-address > button {
        width: 30%;
        height: 70%;

        font-size: 14px;
        font-weight: normal;

        background-color: white;
        border: 1px solid gray;
        cursor: pointer;
    }

    /* *********비밀번호 변경 화면*********** */
    .myPage-row > input[type='password'] {
        width: 70%;
    }

    /* **********회원 탈퇴 약관********** */
    .secession-terms {
        width: 500px;
        height: 300px;
        border: 1px solid black;

        overflow: auto;
        /* 내용이 요소를 벗어나는 경우 방향에 맞춰서 자동으로 스크롤 추가 */

        font-family: sans-serif; /* 돋움체 */
        font-size: 14px;
    }

    /* ************* 프로필 화면 ************* */
    #profileFrm {
        flex-direction: row;
    }

    .profile-image-area {
        width: 150px;
        height: 150px;
        border: 3px solid #ccc;
        border-radius: 50%;
        position: relative;
        overflow: hidden;
        display: flex;
        justify-content: center;
        align-content: center;
        margin-left: 35px;
    }

    #profileImage {
        height: 100%;
        display: flex;
        justify-content: center;
    }

    /* 이미지 버튼 영역 */
    .profile-btn-area {
        width: 230px;
        margin: 20px 0;


        align-items: center;
    }

    .profile-btn-area > * {
        width: 110px;
        height: 33px;
        padding: 5px 10px;
        border-radius: 10px;
        border: 1px solid black;
        background-color: white;
        font-size: 14px;
        cursor: pointer;
        text-align: center;
    }

    #imageInput {
        display: none;

    }

    .profile-btn-area > button {
        background-color: #0d9bf1;
        border: none;
        border-radius: 10px; /* 각을 둥글게 설정 */
        color: white;
        font-size: 1em;
        margin-left: 2px;
    }

    label {
        width: 50%;
        text-align: left;
        margin-bottom: 15px;
        font-weight: bold;
    }

    /* 인풋 스타일 설정 */
    input {
        width: 50%;
        padding: 15px; /* 패딩을 15px로 줄임 */
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 10px; /* 각을 둥글게 설정 */
        font-size: 1em;
    }

    .mypage_information {
        display: flex;
        flex-direction: column;
        align-items: center;
    }

    .mypage_information > span {
        width: 50%;
        height: 40px;
        padding: 8px 15px; /* 패딩을 15px로 줄임 */
        margin-bottom: 15px;
        border: 1px solid #ddd;
        border-radius: 10px; /* 각을 둥글게 설정 */
        font-size: 1em;
    }

    .nickname_change, .pass_change, .id_change {
        margin-left: 5px;
        background-color: #0d9bf1;
        border: none;
        border-radius: 10px; /* 각을 둥글게 설정 */
        color: white;
        font-size: 10px;
    }

    .nickname_change:hover {
        background-color: #06466c;
    }

    .nickname_change:active {
        background-color: #0d9bf1;
    }

    .id_change:hover {
        background-color: #06466c;
    }

    .id_change:active {
        background-color: #0d9bf1;
    }

    .pass_change:hover {
        background-color: #06466c;
    }

    .pass_change:active {
        background-color: #0d9bf1;
    }

    .user_out {
        border: none;
        color: black;
        font-size: 10px;
        background-color: white;
        display: flex;
        justify-content: flex-start;
    }

    .img_change:hover {
        background-color: #06466c;
    }

    .img_change:active {
        background-color: #0d9bf1;
    }

    /* 반응형 웹을 위한 미디어 쿼리 */
    @media (max-width: 600px) {
        .myPage-content {
            flex-direction: column;
            align-items: center;
            width: 90%;
            margin: 20px auto;
        }
    }
</style>
<html>

<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <script>
        function confirmDelete(event) {
            event.preventDefault();//기본 폼 제출 막기
            var result = confirm("정말 탈퇴하시겠습니까?");

            if (result) {
                //확인 클릭 시 폼 제출
                document.getElementById("deleteForm").submit();
            }
        }
    </script>

</head>
<body>
<header>
    <jsp:include page="../include/navbar.jsp"></jsp:include>
    <br/>
</header>

<section class="myPage-content">


    <!-- 오른쪽 마이페이지 주요 내용 부분 -->
    <section class="myPage-main">
        <div class="myPage-main-title">
            <h1 class="myPage-title">마이페이지</h1>
            <span class="myPage-subject">개인정보를 변경할 수 있습니다.</span>
        </div>

        <section>
            <form action="profile" method="POST" name="myPageFrm" id="profileFrm" enctype="multipart/form-data">
                <div class="mypage_top">
                    <div class="profile-image-area">
                        <%-- 프로필 이미지가 없으면 기본 이미지 --%>
                        <c:if test="${empty loginMember.profileImage}">
                            <img src="/image/user_default_img.png" id="profileImage">
                        </c:if>

                        <%-- 프로필 이미지가 있으면 있는 이미지 --%>
                        <c:if test="${!empty loginMember.profileImage}">
                            <img src="${loginMember.profileImage}" id="profileImage">
                        </c:if>

                    </div>

                    <div class="profile-btn-area">
                        <label for="imageInput">이미지 선택</label>
                        <input type="file" name="profileImage" id="imageInput" accept="image/*" class="img_input">
                        <button class="img_change">변경하기</button>
                    </div>
                </div>


            </form>

            <div class="mypage_information">
                <label> <!--for="username"-->아이디
                </label>
                <span class="info">${loginMember.id}</span>

                <label> <!--for="username"-->이메일
                </label>
                <span class="info">${loginMember.email}</span>

                <label>닉네임
                    <button class="nickname_change" onclick="location.href='/project/mypage/NicknameChange.jsp'">수정</button>
                </label>
                <span class="info">${loginMember.nickname}</span>

                <label> 비밀번호
                    <button class="pass_change" onclick="location.href='/project/mypage/PassChange.jsp'">수정</button>
                </label>

                <div style="width: 52%; margin-top: 10px">
                    <%--회원 탈퇴 폼--%>
                    <form id="deleteForm" action="/deleteUser" method="post">
                        <input type="hidden" name="id" value="${loginMember.id}">
                        <button type="submit" class="user_out" onclick="confirmDelete(event)">>회원탈퇴</button>
                    </form>
                </div>
            </div>
        </section>
    </section>

</section>


<footer>
    <jsp:include page="../include/footer.jsp"></jsp:include>
</footer>

</body>
</html>
