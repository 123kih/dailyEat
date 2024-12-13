package com.project.dailyeat.users;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/signup/checkDuplicate")
public class DuplicateCheckController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String id = req.getParameter("id");
        String nickname = req.getParameter("nickname");

        SignUpDAO dao = new SignUpDAO();
        boolean isIdAvailable = dao.checkId(id);
        boolean isNicknameAvailable = dao.checkNickname(nickname);
        dao.close();

        resp.setContentType("applocation/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.print("{");
        out.print("\"idAvailable\":" + isIdAvailable + ",");
        out.print("\"nicknameAvailable\":" + isNicknameAvailable);
        out.print("}");
        out.flush();
    }

}
