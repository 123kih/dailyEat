package com.project.dailyeat.mvcboard;

import com.project.dailyeat.HelloServlet;
import com.project.dailyeat.fileupload.FileUtil;
import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/mvcboard/pass.do")
public class PassController extends HelloServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("mode", req.getParameter("mode"));
        req.getRequestDispatcher("/project/community/Pass.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //매개변수 저장
        String num = req.getParameter("num");
        String mode = req.getParameter("mode");
        String pass = req.getParameter("pass");

        //비밀번호 확인
        MVCBoardDAO dao = new MVCBoardDAO();
        boolean confirmed = dao.confirmPassword(pass, num);
        dao.close();

        if (confirmed) {//비밀번호 검증 성공
            if (mode.equals("edit")) {
                HttpSession session = req.getSession();
                session.setAttribute("pass", pass);
                resp.sendRedirect("../mvcboard/edit.do?num=" + num);

            } else if (mode.equals("delete")) {
                dao = new MVCBoardDAO();
                MVCBoardDTO dto = dao.selectView(num);
                int result = dao.deletePost(num);

                if (result == 1) {
                    String saveFileName = dto.getSfile();
                    FileUtil.deleteFile(req, "/upload", saveFileName);
                }

                JSFunction.alertLocation(resp, "삭제되었습니다.", "../../mvcboard/list.do");
            }
        } else {//비밀번호 검증 실패
            JSFunction.alertBack(resp, "비밀번호 검증 실패");
        }
    }
}
