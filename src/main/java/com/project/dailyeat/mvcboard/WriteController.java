package com.project.dailyeat.mvcboard;

import com.project.dailyeat.fileupload.FileUtil;
import com.project.dailyeat.users.UserDTO;
import com.project.dailyeat.util.JSFunction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/mvcboard/write.do")
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 5, //5MB
        maxRequestSize = 1024 * 1024 * 5 //50MB
)
public class WriteController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 로그인된 사용자 ID 확인
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("loginMember") == null) {
            //로그인 상태가 아니라면, 가고자 했던 URL을 세션에 저장
            session = req.getSession(true);//세션이 없으면 새로 생성
            session.setAttribute("redirectAfterLogin", req.getRequestURI());

            //로그인 페이지로 리다이렉트
            JSFunction.alertLocation(resp, "로그인이 필요합니다.", req.getContextPath() + "/project/login/LoginMain.jsp");
            return;
        }
        // 게시글 작성 페이지로 포워딩
        req.getRequestDispatcher("/project/community/Write.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //세션에서 로그인된 사용자 ID 확인
        HttpSession session = req.getSession(false);
        UserDTO loginMember = (UserDTO) session.getAttribute("loginMember");
        if (loginMember == null) {
            // 로그인이 되어 있지 않다면 로그인 페이지로 리다이렉트
            JSFunction.alertLocation(resp, "로그인이 필요합니다.", req.getContextPath() + "/project/login/LoginMain.jsp");
            return;
        }

        String id = loginMember.getId();

        //파일 업로드 처리
        String saveDir = req.getServletContext().getRealPath("/upload");

        //파일 업로드
        String oFileName = "";
        try {
            oFileName = FileUtil.uploadFile(req, saveDir);

            //폼 값을 DTO에 저장
            MVCBoardDTO dto = new MVCBoardDTO();
            dto.setId(id); // 세션에서 가져온 사용자 ID 설정
            dto.setTitle(req.getParameter("title"));
            dto.setContent(req.getParameter("content"));
            dto.setPass(req.getParameter("pass"));

            if (oFileName != null && !oFileName.isEmpty()) {
                //파일명 변경
                String sFileName = FileUtil.renameFile(saveDir, oFileName);

                dto.setOfile(oFileName);
                dto.setSfile(sFileName);
            }

            //DAO를 통해 DB 저장
            MVCBoardDAO dao = new MVCBoardDAO();
            int result = dao.insertWrite(dto);
            dao.close();

            if (result == 1) {
                resp.sendRedirect(req.getContextPath() + "../../mvcboard/list.do");
            } else {
                JSFunction.alertLocation(resp, "글쓰기 실패", req.getContextPath() + "../../mvcboard/write.do");
            }

        } catch (Exception e) {
            e.printStackTrace();
            if (!resp.isCommitted()) {
                JSFunction.alertLocation(resp, "파일 업로드 오류", req.getContextPath() + "../../mvcboard.write.do");
            }
        }
    }
}
