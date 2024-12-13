package com.project.dailyeat.openapi;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

public class OpenAPI {

    // API 키를 여기에 입력하세요.
    private static final String API_KEY = "e570fcacc04041baa0be";

    public static void main(String[] args) {
        // 요청할 API URL
        String urlString = "http://openapi.foodsafetykorea.go.kr/api/" + API_KEY + "/I2790/xml/1/1000";

        try {
            // URL 객체 생성
            URL url = new URL(urlString);

            // HTTP 연결 객체 생성
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();

            // GET 요청 설정
            conn.setRequestMethod("GET");

            // 응답 코드 확인
            int responseCode = conn.getResponseCode();
            System.out.println("Response Code: " + responseCode);

            // 응답이 성공적으로 수신되었을 경우
            if (responseCode == HttpURLConnection.HTTP_OK) {
                // 응답 데이터를 읽기 위한 버퍼 리더 생성
                BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
                String inputLine;
                StringBuilder response = new StringBuilder();

                // 응답 데이터 읽기
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }

                // 버퍼 리더 닫기
                in.close();

                // 응답 데이터 출력
                System.out.println("Response Data:");
                System.out.println(response.toString());
            } else {
                System.out.println("GET request failed");
            }

            // HTTP 연결 해제
            conn.disconnect();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}