package com.project.dailyeat.users;

import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;

@WebServlet("/deleteUser")
public class DeleteController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //사용자 ID를 파라미터로 받아오기
        String id = req.getParameter("id");

        //DAO를 통해 사용자 삭제
        UserDAO dao = new UserDAO();
        boolean isDeleted = dao.deleteUser(id);

        //결과에 따라 적절한 응답 보내기
        if (isDeleted) {
            // 회원 탈퇴 메시지와 함께 로그아웃 서블릿으로 리디렉션
            String logoutMessage = "회원 탈퇴가 성공적으로 완료되었습니다.";
            String encodedMessage = URLEncoder.encode(logoutMessage, "UTF-8");
            String logoutUrl = req.getContextPath() + "/logout.do?message=" + encodedMessage;
            resp.sendRedirect(logoutUrl);
        } else {
            JSFunction.alertBack(resp, "회원 탈퇴에 실패했습니다.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req,resp);
    }
}
