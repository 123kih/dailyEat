package com.project.dailyeat.users;

import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/mypage/updatePassword")
public class PasswordController extends HttpServlet {
    private UserDAO dao;

    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("user controller init");
//        dao = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String currentPassword = req.getParameter("currentPassword");
        String newPassword = req.getParameter("newPassword");
        dao = new UserDAO();

        //파라미터가 null일 경우 처리
        if (id == null || currentPassword == null || newPassword == null) {
            JSFunction.alertBack(resp, "모든 필드를 입력해주세요.");
            return;
        }

        //사용자 ID로 사용자 정보를 조회
        UserDTO dto = dao.getUserByID(id);

        // 캐시 방지 헤더 추가
        resp.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        resp.setHeader("Pragma", "no-cache");
        resp.setDateHeader("Expires", 0);

        if (dto != null && dto.getPassword().equals(currentPassword)) {
            boolean result = dao.updatePassword(id, newPassword);
            dao.close();
            if (result) {
                JSFunction.alertLocation(resp, "비밀번호가 성공적으로 변경되었습니다.", "/project/mypage/MyPageMain.jsp");
            } else {
                JSFunction.alertBack(resp, "비밀번호 업데이트 실패");
            }
        } else {
            JSFunction.alertBack(resp, "현재 비밀번호가 일치하지 않습니다.");
        }
    }

    @Override
    public void destroy() {
        // 필요한 경우 리소스 정리
    }
}
