package com.project.dailyeat.calendar;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import org.json.XML;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/saveToSession")
public class AddFoodServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        //json 데이터 읽기
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = req.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);

            }
        }

        // XML 데이터를 JSON으로 변환
        JSONObject json = new JSONObject();

        json.put("foodData" , sb.toString());
//        try {
//            json = XML.toJSONObject(xml);
//        } catch (Exception e) {
//            // XML 변환 오류 처리
//            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
//            PrintWriter out = resp.getWriter();
//            out.write("{\"status\":\"error\", \"message\":\"Invalid XML data.\"}");
//            out.flush();
//            return;
//        }


        // JSON 데이터 확인
//        String json = sb.toString();
        System.out.println("Received JSON: " + json);

//        System.out.println("sb : " +  sb);

        //json 파싱
        Gson gson = new Gson();
        MenuDTO foodData;
        try {
            foodData = gson.fromJson(json.toString(), MenuDTO.class);
            // Debugging the MenuDTO object
            System.out.println("FoodData: " + foodData);
            System.out.println("Selected Meal Type: " + foodData.getSelectedMealType());

            System.out.println("fd : " +foodData);
            if (foodData == null) {
                throw new IllegalArgumentException("JSON 데이터가 MenuDTO 객체로 변환되지 않았습니다.");
            }
        } catch (Exception e) {
            // JSON 파싱 오류 처리
            resp.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            PrintWriter out = resp.getWriter();
            out.write("{\"status\":\"error\", \"message\":\"Invalid JSON data.\"}");
            out.flush();
            return;
        }


        // 세션에 저장
        HttpSession session = req.getSession();
        List<MenuDTO> foodList = (List<MenuDTO>) session.getAttribute("foodList");
        if (foodList == null) {
            foodList = new ArrayList<>();
        }
        foodList.add(foodData);
        session.setAttribute("foodList", foodList);

        // 응답 반환
        PrintWriter out = resp.getWriter();
        out.write("{\"status\":\"success\"}");
        out.flush();
    }
}