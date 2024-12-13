package com.project.dailyeat.users;

import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/mypage/updateNickname")
public class NicknameController extends HttpServlet {

    private UserDAO dao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("user controller init");
        //dao = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 파라미터에서 사용자 ID와 새로운 닉네임 가져오기
        String id = req.getParameter("id");
        String newNickname = req.getParameter("newNickname");
        dao = new UserDAO();

        //파라미터가 null일 경우 처리
        if (id == null || newNickname == null) {
            JSFunction.alertBack(resp, "사용자 ID 또는 닉네임이 제공되지 않았습니다.");
            return;
        }

        //닉네임 업데이트 시도
        boolean result = dao.updateNickname(id, newNickname);

        // 캐시 방지 헤더 추가
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        // 응답 설정
        if (result) {
            // 닉네임 업데이트 후 사용자 정보를 새로 가져옴
            UserDTO updatedUser = dao.getUserByID(id);

            //세션에서 사용자 정보를 업데이트
            HttpSession session = req.getSession();
            session.setAttribute("loginMember", updatedUser);

            JSFunction.alertLocation(resp, "닉네임이 성공적으로 변경되었습니다.", "/project/mypage/MyPageMain.jsp");

        }else {
            JSFunction.alertBack(resp, "닉네임 업데이트 실패");
        }

    }
    @Override
    public void destroy() {
        // 필요한 경우 리소스 정리
    }
}
