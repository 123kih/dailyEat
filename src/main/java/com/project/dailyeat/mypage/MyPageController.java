package com.project.dailyeat.mypage;

import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/mypage.do")
public class MyPageController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginMember") == null) {
            //로그인 상태가 아니라면, 가고자 했던 URL을 세션에 저장
            session = req.getSession(true); //세션이 없으면 새로 생성
            session.setAttribute("redirectAfterLogin", req.getRequestURI());

            //로그인 페이지로 리다이렉트
            JSFunction.alertLocation(resp, "로그인이 필요합니다.", req.getContextPath() + "/project/login/LoginMain.jsp");
            return;
        }

        //로그인 상태일 경우 마이페이지로 포워딩
        req.getRequestDispatcher("/project/mypage/MyPageMain.jsp").forward(req, resp);
    }
}
