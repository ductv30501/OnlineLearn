/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.quiz;

import com.google.gson.Gson;
import dal.ChapterDBContext;
import dal.CourseDBContext;
import dal.QuizDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javafx.scene.control.Alert;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Course;
import model.Quiz;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditQuizController", urlPatterns = {"/authen/expert/quiz/edit"})
public class EditQuizController extends HttpServlet {

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

        String quizId = request.getParameter("quiz_id");

        QuizDBContext quizDB = new QuizDBContext();
        ChapterDBContext chapterDB = new ChapterDBContext();
        CourseDBContext courseDB = new CourseDBContext();

        Quiz quiz = quizDB.GetQuiz(quizId);
        int courseID = courseDB.getCourseIDByTitle(quiz.getCourse().getCourseTitle());
        String courseId = String.valueOf(courseID);
        //get chapter of course
        ArrayList<Chapter> chapters = chapterDB.getChapterByCourseID(courseId);
        //get all course
        ArrayList<Course> courses = courseDB.getCourseList();

        //check exist quiz in user_quiz
        boolean checkExist = quizDB.CheckUserQuizExist(quizId);

        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();

        int duration = quiz.getDuration();

        int hours = duration / 3600;
        int minutes = (duration - hours * 3600) / 60;
        int seconds = duration - ((hours * 3600) + (minutes * 60));
        String durationStr = "";

        String hourstr = String.valueOf(hours);
        if (String.valueOf(hours).length() == 1) {
            hourstr = "0" + hours;
        }
        String minuteStr = String.valueOf(minutes);
        if (String.valueOf(minutes).length() == 1) {
            minuteStr = "0" + minutes;
        }
        String secondStr = String.valueOf(seconds);
        if (String.valueOf(seconds).length() == 1) {
            secondStr = "0" + seconds;
        }

        durationStr = hourstr + ":" + minuteStr + ":" + secondStr;

        map.put("quiz", quiz);
        map.put("courses", courses);
        map.put("chapters", chapters);
        map.put("checkExist", checkExist);
        map.put("duration", durationStr);
        response.getWriter().write(gson.toJson(map));
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

        int quizId = Integer.parseInt(request.getParameter("quiz_id"));
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
        quiz.setQuizId(quizId);
        quiz.setQuizTitle(quizTitle);
        quiz.setDescription(description);
        quiz.setToPass(topass);
        quiz.setNumberQuestion(numberQuestion);
        Chapter chapter = new Chapter();
        chapter.setChapterId(chapterID);
        quiz.setChapter(chapter);
quiz.setDuration(duration);
        QuizDBContext quizDB = new QuizDBContext();
        quizDB.updateQuiz(quiz);
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
