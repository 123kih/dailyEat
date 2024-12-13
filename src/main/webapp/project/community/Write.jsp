<%@ page contentType="text/html;charset=UTF-8" language="java"
         pageEncoding="UTF-8"
%>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 쓰기</title>
    <link rel="stylesheet" href="/css/CommuWrite.css">
    <script>
      function validateForm(form){
        if(form.name.value == ""){
          alert("작성자를 입력 하세요");
          form.name.focus();
          return false;
        }
        if(form.title.value == ""){
          alert("제목을 입력 하세요");
          form.title.focus();
          return false;
        }
        if(form.content.value == ""){
          alert("내용을 입력 하세요");
          form.content.focus();
          return false;
        }
        if(form.pass.value == ""){
          alert("비밀번호를 입력 하세요");
          form.pass.focus();
          return false;
        }
      }
    </script>
  </head>
<jsp:include page="../include/navbar.jsp"/>
<br/>
<body>
<div class="container">
<h2>글쓰기</h2>
<form name="writeFrm" method="post" action="../../mvcboard/write.do" onsubmit="return validateForm(this);"
      enctype="multipart/form-data">
  <div class="button-container">
      <button type="submit" class="submit">작성 완료</button>
      <button type="reset" class="reset">다시 입력</button>
      <button type="button" class="list" onclick="location.href='../../mvcboard/list.do';">목록 보기</button>
  </div>
  <div>
    <div>
      <input type="text" name="title" placeholder="제목" class="title-area" />
    </div>
    <div>
      <textarea name="content" id="textarea" class="content"></textarea>
    </div>
    <div>
      <input type="file" name="ofile" class="file-upload">
    </div>
    <div>
      <p>비밀번호</p>
      <input type="password" name="pass" width="100px;">
    </div>
  </div>
</form>
</div>
</body>
<jsp:include page="../include/footer.jsp"/>
</html>
