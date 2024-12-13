package com.project.dailyeat.users;

import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/signup/signup.do")
public class SignUpController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        //폼 데이터 가져오기
        String id = req.getParameter("id");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String nickname = req.getParameter("nickname");
        String email = req.getParameter("email");

        //비밀번호 확인
        if (!password.equals(confirmPassword)) {
            JSFunction.alertBack(resp, "비민번호가 일치하지 않습니다.");
            return;
        }

        //DTO 생성 및 값 설정
        SignUpDTO dto = new SignUpDTO();
        dto.setId(id);
        dto.setPassword(password);
        dto.setNickname(nickname);
        dto.setEmail(email);

        //DAO를 통해 DB에 저장
        SignUpDAO dao = new SignUpDAO();
        int result = dao.insertUsers(dto);
        dao.close();

        if (result == 1) {
            JSFunction.alertLocation(resp,"회원가입에 성공했습니다.", "/project/login/LoginMain.jsp");
        }else {
            JSFunction.alertBack(resp, "회원가입에 실패했습니다.");
        }

    }
}

