/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.learner;

import dal.CourseDBContext;
import dal.FeedbackDBContext;
import dal.QuizDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Chapter;
import model.Course;
import model.Feedback;
import model.Lesson;
import model.Quiz;
import model.Topic;
import model.User;
import model.UserQuiz;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "LessonViewController", urlPatterns = {"/authen/lesson/view"})
public class LessonViewController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");

        // Step 1: Call course database context
        CourseDBContext cdb = new CourseDBContext();
        UserDBContext udb = new UserDBContext();
        QuizDBContext qdb = new QuizDBContext();
        FeedbackDBContext fdb = new FeedbackDBContext();
        QuizDBContext quizDb = new QuizDBContext();
         TopicDBContext tdb = new TopicDBContext();


                ArrayList<Topic> topics = tdb.getTopics();
        // Step 2: Get course by id and related courses
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        Course course = cdb.getCourseDetail(courseId);
        ArrayList<Course> relatedCourses = cdb.getRelatedCourses(courseId);

        // Step 3: Get teacher by course id
        User teacher = udb.getTeacherByCourseID(courseId);

        // Step 4: Get lesson-done in the courses of an user
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        ArrayList<Lesson> lessonDone = cdb.getLessonDone(courseId, user.getUsername());
        ArrayList<Quiz> quizDone = qdb.getQuizDone(courseId, user.getUsername());

        //------------------------------------------------------------------------//
        //Call QuizDBContext
        //Step 1: Get chapter in course
        ArrayList<Chapter> chapters = course.getChapters();

        //Step 2: get user-quiz result list

        for (Chapter chapter : chapters) {
            ArrayList<Quiz> quizList = quizDb.getQuizListByChapter(chapter.getChapterId());

            //Step 2: Get user mark of each quiz
            for (Quiz quiz : quizList) {
                int quizScore = quizDb.getQuizMark(quiz, user);
                quiz.setMark(quizScore);

            }
            chapter.setQuizz(quizList);
        }
        //----------------------------------------------------------------------------

        Feedback feedback = fdb.getFeedback(user.getUsername(), courseId);

        // Step 5: Set attribute for request scope
        request.setAttribute("course", course);
        request.setAttribute("lessonDone", lessonDone);
        request.setAttribute("teacher", teacher);
        request.setAttribute("topics", topics);
        request.setAttribute("quizDone", quizDone);
        request.setAttribute("relatedCourses", relatedCourses);
        request.setAttribute("feedback", feedback);

        request.getRequestDispatcher("../../view/dynamic/user/learner/lesson-view.jsp").forward(request, response);
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
