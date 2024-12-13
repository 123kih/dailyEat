<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.io.StringWriter" %>
<%@ page import="java.io.PrintWriter" %>

<html>
<head>
    <title>Food Safety API Example</title>
</head>
<body>
<h1>Food Safety API Data</h1>

<%
    // API 키
    String apiKey = "e570fcacc04041baa0be";
    // 요청할 API URL
    String urlString = "http://openapi.foodsafetykorea.go.kr/api/" + apiKey + "/I2790/xml/1/100";

    try {
        // URL 객체 생성
        URL url = new URL(urlString);

        // HTTP 연결 객체 생성
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();

        // GET 요청 설정
        conn.setRequestMethod("GET");

        // 응답 코드 확인
        int responseCode = conn.getResponseCode();

        // 응답이 성공적으로 수신되었을 경우
        if (responseCode == HttpURLConnection.HTTP_OK) {
            // 응답 데이터를 읽기 위한 버퍼 리더 생성
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder resp = new StringBuilder();

            // 응답 데이터 읽기
            while ((inputLine = in.readLine()) != null) {
                resp.append(inputLine);
            }

            // 버퍼 리더 닫기
            in.close();

            // 응답 데이터 출력

            out.println("<h2>Response Data:</h2>");
            out.println("<pre>" + resp.toString() + "</pre>");
        } else {
            out.println("<p>GET request failed. Response Code: " + responseCode + "</p>");
        }

        // HTTP 연결 해제
        conn.disconnect();
    } catch (Exception e) {
        // 에러 메시지를 JSP 페이지에 출력하기 위해 StringWriter와 PrintWriter 사용
        StringWriter sw = new StringWriter();
        e.printStackTrace(new PrintWriter(sw));
        String errorString = sw.toString();

        out.println("<p>Error: " + e.getMessage() + "</p>");
        out.println("<pre>" + errorString + "</pre>");
    }
%>
</body>
</html>
