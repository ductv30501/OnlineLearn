/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.question;

import dal.ChapterDBContext;
import dal.CourseDBContext;
import dal.QuestionDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Course;
import model.Option;
import model.Question;

/**
 *
 * @author Admin
 */
@WebServlet(name = "QuestionDetailController", urlPatterns = {"/authen/manage/question/detail"})
public class QuestionDetailController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet QuestionDetailController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuestionDetailController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        String questionId = request.getParameter("question_id");

        ChapterDBContext chapterDB = new ChapterDBContext();
        CourseDBContext courseDB = new CourseDBContext();
        QuestionDBContext questionDB = new QuestionDBContext();
        //get question 
        Question question = questionDB.GetQuestion(questionId);
        //get chapters of course
        ArrayList<Chapter> chapters = chapterDB.getChapterOfCourse(questionId);
        //get all course
        ArrayList<Course> courses = courseDB.getCourses();
        //get options of question
        ArrayList<Option> options = questionDB.GetOptionsOfQuestion(questionId);

        int courseIDFIndex = courses.get(0).getCourseId();
        String courseFIndex = String.valueOf(courseIDFIndex);
        ArrayList<Chapter> chapterOfFristCourse = chapterDB.getChapterByCourseID(courseFIndex);

        request.setAttribute("question", question);
        request.setAttribute("options", options);
        request.setAttribute("courses", courses);
        request.setAttribute("chapters", chapters);
        request.setAttribute("chapterOfFristCourse", chapterOfFristCourse);
        request.getRequestDispatcher("../../../view/dynamic/authen/manage/question/detail.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");
        
        String rawQuestionId = request.getParameter("question_id");
        String content = request.getParameter("content");
        String rawChapterId = request.getParameter("chapter");
        String rawPoint = request.getParameter("point");
        String rawLevel = request.getParameter("level");
        int questionId = Integer.parseInt(rawQuestionId);
        int chapterID = Integer.parseInt(rawChapterId);
        int point = Integer.parseInt(rawPoint);
        int level = Integer.parseInt(rawLevel);
        
        Question question = new Question();
        question.setQuestionId(questionId);
        question.setPoint(point);
        question.setQuestionTitle(content);
        question.setQuestionLevel(level);
        Chapter chapter = new Chapter();
        chapter.setChapterId(chapterID);
        question.setChapter(chapter);
        
        QuestionDBContext questionDB = new QuestionDBContext();
        questionDB.UpdateQuestion(question);
        response.sendRedirect("list");
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
