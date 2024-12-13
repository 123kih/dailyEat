package com.project.dailyeat.users;

import com.project.dailyeat.HelloServlet;
import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/logout.do")
public class LogoutController extends HelloServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // 현재 세션을 가져오되, 세션이 없으면 null을 반환

        if (session != null) {
            session.invalidate(); //세션 무효화
        }

        String redirectUrl = req.getParameter("redirect");
        String message = req.getParameter("message");
        if (message != null) {
            JSFunction.alertLocation(resp, message, req.getContextPath() + "/project/home/Home.jsp");
        }else {
            JSFunction.alertLocation(resp, "로그아웃 되었습니다.", req.getContextPath() + "/project/home/Home.jsp");
        }

    }
}

