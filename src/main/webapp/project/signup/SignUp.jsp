<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="../../css/SignUp.css?after" rel="stylesheet"/>
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
            $('#checkIdBtn').click(function() {
                const id = $('#username').val();

                $.getJSON('/signup/checkDuplicate', { id: id }, function(data) {
                    if (!data.idAvailable) {
                        alert('사용 중인 아이디입니다.');
                        $('#username').focus();
                    } else {
                        alert('사용 가능한 아이디입니다.');
                    }
                });
            });

            $('#checkNicknameBtn').click(function() {
                const nickname = $('#nickname').val();

                $.getJSON('/signup/checkDuplicate', { nickname: nickname }, function(data) {
                    if (!data.nicknameAvailable) {
                        alert('사용 중인 닉네임입니다.');
                        $('#nickname').focus();
                    } else {
                        alert('사용 가능한 닉네임입니다.');
                    }
                });
            });
        });
    </script>
</head>


<body>
<div class="container">
    <!-- 로고 이미지 -->
    <div class="logo">
        <a href="/project/home/Home.jsp">
        <img src="../../image/logo.png" alt="DailyEat Logo">
        </a>
    </div>
    <!-- 환영 메시지 -->
    <h1>DailyEat에 오신걸 환영합니다.</h1>
    <p>DailyEat은 매일 자신의 식단일지를 기록할 수 있는 공간입니다.</p>
    <!-- 구분선 -->
    <hr class="divider">
    <!-- 회원가입 폼 -->
    <form action="/signup/signup.do" method="post" id="signupForm">
        <!-- 아이디 입력 그룹 -->
        <div class="input-group">
            <label for="username">아이디</label>
            <input type="text" id="username" name="id" placeholder="아이디를 입력하세요">
            <div class="check-btn-container">
            <button type="button" id="checkIdBtn" class="check-btn">중복 확인</button>
            </div>
        </div>
        <!-- 비밀번호 입력 그룹 -->
        <div class="input-group input-group2">
            <label for="password">비밀번호</label>
            <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요">
        </div>
        <div class="input-group input-group2">
            <label for="confirmPassword">비밀번호 확인</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요">
        </div>
        <!-- 닉네임 입력 그룹 -->
        <div class="input-group">
            <label for="nickname">닉네임</label>
            <input type="text" id="nickname" name="nickname" placeholder="닉네임을 입력하세요">
            <div class="check-btn-container">
            <button type="button" id="checkNicknameBtn" class="check-btn">중복 확인</button>
            </div>
        </div>
        <!-- 이메일 입력 그룹 -->
        <div class="input-group input-group2">
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" placeholder="이메일을 입력하세요">
        </div>
        <!-- 제출 버튼 -->
        <button type="submit">회원가입</button>
    </form>
    <!--로그인 링크-->
    <div class="login">
        <p>이미 회원이신가요? <a href="../login/LoginMain.jsp" target="_blank">로그인</a></p>
    </div>
</div>
<!-- 푸터 -->
<footer>
    <p>DailyEat<p/>
</footer>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>

</body>
</html>
