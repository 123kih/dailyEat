<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>글 수정하기</title>
    <link rel="stylesheet" href="/css/CommuEdit.css">
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
        }
    </script>
</head>

<body>
<jsp:include page="../include/navbar.jsp"/>
<br/>
<div class="container">
<h2>작성글 수정</h2>
<form name="writeFrm" method="post" action="../../mvcboard/edit.do" onsubmit="return validateForm(this);"
      enctype="multipart/form-data">
    <div>
        <div class="button-container">
            <button type="submit" class="submit">작성 완료</button>
            <button type="reset" class="reset">다시 입력</button>
            <button type="button" class="list" onclick="location.href='../../mvcboard/list.do';">목록 보기</button>
        </div>
    </div>
    <input type="hidden" name="num" value="${dto.num}">
    <input type="hidden" name="prevOfile" value="${dto.ofile}">
    <input type="hidden" name="prevSfile" value="${dto.sfile}">

        <div class="writer">
            <label for="id">작성자</label>
            <input type="text" name="id" id="id" value="${dto.id}" readonly/>
        </div>
        <div>
            <input type="text" name="title" class="title-area" value="${dto.title}"/>
        </div>
        <div>
                <textarea name="content" class="content">
                    ${dto.content}
                </textarea>
        </div>
        <div>
            <input type="file" name="ofile" class="file-upload">
        </div>

</form>
</div>
<jsp:include page="../include/footer.jsp"/>
</body>
</html>