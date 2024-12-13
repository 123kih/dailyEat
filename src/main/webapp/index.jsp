<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--리다이렉트--%>
<%
    response.sendRedirect(request.getContextPath() + "/project/home/Home.jsp");

%>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
</head>
<body>
<h1><%= "Hello World!" %>
</h1>
<br/>
<a href="hello-servlet">Hello Servlet</a>
</body>
</html>
