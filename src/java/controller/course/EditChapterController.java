/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dal.CourseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Course;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "EditChapterController", urlPatterns = {"/authen/manage/course/chapter/edit"})
public class EditChapterController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        int chapterId = Integer.parseInt(request.getParameter("id"));

        CourseDBContext cdb = new CourseDBContext();
        Chapter chapter = cdb.getChapter(chapterId);

        PrintWriter writer = response.getWriter();

        String result = "";

        result += chapter.getChapterId() + "|";
        result += chapter.getChapterTitle() + "|";
        result += chapter.getDescription();

        writer.write(result);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        CourseDBContext cdb = new CourseDBContext();

        int chapterId = Integer.parseInt(request.getParameter("chapterId"));
        String chapterTitle = request.getParameter("chapterTitle");
        String description = request.getParameter("description");
        int courseId = 1;
        Course course = cdb.getCourse(courseId);

        Chapter chapter = new Chapter(chapterId, course, chapterTitle, description);

        cdb.updateChapter(chapter);

         int id = Integer.parseInt(request.getParameter("id"));

        response.sendRedirect("../prepare?id=" + id);
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
