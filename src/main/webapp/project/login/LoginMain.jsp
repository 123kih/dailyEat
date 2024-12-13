<%@ page contentType="text/html;charset=UTF-8" language="java"
            pageEncoding="UTF-8"
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link href="../../css/Login.css?after" rel="stylesheet"/>


</head>
<body>

<!DOCTYPE html>
<html lang="ko">
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
    <!-- 로그인 폼 -->
    <form action="/login.do" method="post">
        <label for="id">아이디</label>
        <input type="text" id="id" name="id" placeholder="아이디를 입력해 주세요" required>
        <label for="password">비밀번호</label>
        <input type="password" id="password" name="password" placeholder="비밀번호를 입력해 주세요" required>
        <button type="submit">로그인</button>
    </form>
    <!-- 아이디/비밀번호 찾기 링크 -->
    <div class="links">
        <a href="#">아이디찾기</a> / <a href="#">비밀번호 찾기</a>
    </div>
    <!-- 회원가입 링크 -->
    <div class="signup">
        <p>아직 회원이 아니신가요? <a href="../signup/SignUp.jsp" target="_blank">회원가입</a></p>
    </div>
</div>
<!-- 푸터 -->
<footer>
    <p>DailyEat</p>
</footer>
</body>

</html>




<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js" integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy" crossorigin="anonymous"></script>
</body>
</html>