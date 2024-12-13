package com.project.dailyeat.users;

import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String password = req.getParameter("password");

        LoginDTO dto = new LoginDTO();
        dto.setId(id);
        dto.setPassword(password);

        LoginDAO dao = new LoginDAO();
        UserDTO user = dao.userLogin(dto); // 로그인 메서드를 수정하여 UserDTO 객체 반환

        if (user != null) {
            // 로그인 성공 시 세션에 사용자 정보 저장
            HttpSession session = req.getSession();
            session.setAttribute("loginMember", user); // 세션에 사용자 정보 저장

            //원래 가고자 했던 URL이 있으면 그 URL로 리다이렉트, 없으면 홈으로 이동
            String redirectURL = (String) session.getAttribute("redirectAfterLogin");
            if (redirectURL != null) {
                session.removeAttribute("redirectAfterLogin");// 한 번 사용한 후에는 제거
                resp.sendRedirect(req.getContextPath() + redirectURL);
            }else {
                JSFunction.alertLocation(resp, "로그인에 성공했습니다.", req.getContextPath() + "/project/home/Home.jsp");
            }
        } else {
            JSFunction.alertBack(resp, "로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.");
        }
    }
}
