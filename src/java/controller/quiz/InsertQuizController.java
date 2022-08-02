/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.quiz;

import com.google.gson.Gson;
import dal.ChapterDBContext;
import dal.QuizDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Quiz;

/**
 *
 * @author Admin
 */
@WebServlet(name = "InsertQuizController", urlPatterns = {"/authen/expert/quiz/insert"})
public class InsertQuizController extends HttpServlet {

    

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
        
        String quizTitle = request.getParameter("quiz_title");
        int topass = Integer.parseInt(request.getParameter("topass"));
        String description = request.getParameter("description");
        int chapterID = Integer.parseInt(request.getParameter("chapter"));
        int numberQuestion = Integer.parseInt(request.getParameter("numberQuestion"));
        
        String durationStr = request.getParameter("duration");
        String[] durationSeparated = durationStr.split(":");
        int hours = Integer.parseInt(durationSeparated[0]);
        int minutes = Integer.parseInt(durationSeparated[1]);
        int seconds = Integer.parseInt(durationSeparated[2]);
        int duration =  (hours * 60 + minutes) * 60 + seconds;
        
        Quiz quiz = new Quiz();
        quiz.setQuizTitle(quizTitle);
        quiz.setDescription(description);
        quiz.setToPass(topass);
        Chapter chapter = new Chapter();
        chapter.setChapterId(chapterID);
        quiz.setChapter(chapter);
        quiz.setNumberQuestion(numberQuestion);
        
        quiz.setDuration(duration);
        
        
        QuizDBContext quizDB = new QuizDBContext();
        quizDB.insertQuiz(quiz);
        
        String notification = "3";
        response.getWriter().print(notification);
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
