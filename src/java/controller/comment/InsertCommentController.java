/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.comment;

import com.google.gson.Gson;
import dal.CommentDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Chapter;
import model.Comment;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "InsertCommentController", urlPatterns = {"/authen/comment/insert"})
public class InsertCommentController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        CommentDBContext cdb = new CommentDBContext();

        int chapterId = Integer.parseInt(request.getParameter("chapterId"));
        boolean isReply = Boolean.parseBoolean(request.getParameter("isReply"));
        int commentId = 0;
        if (isReply) {
            commentId = Integer.parseInt(request.getParameter("commentId"));
        }

        String content = request.getParameter("content");

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");
        Chapter chapter = new Chapter();
        chapter.setChapterId(chapterId);

        LocalDate localDate = LocalDate.now();
        Date today = Date.valueOf(localDate);

        Comment comment = new Comment(content, today, user, isReply, chapter);

        cdb.insertComment(comment);

        Gson gson = new Gson();

        int lastedId = cdb.getCurrentIdentity();

        if (isReply) {
            cdb.insertCommentReply(commentId, lastedId);
        }
        comment = cdb.getCommentById(lastedId);

        PrintWriter writer = response.getWriter();

        HashMap<String, Object> map = new HashMap<>();
        map.put("comment", comment);

        writer.println(gson.toJson(map));
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
