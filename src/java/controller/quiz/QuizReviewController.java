/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.quiz;

import dal.QuizDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Option;
import model.Question;
import model.Quiz;
import model.User;
import model.UserQuestionDetail;
import model.UserQuizDetail;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuizReviewController", urlPatterns = {"/authen/course/quiz/review"})
public class QuizReviewController extends HttpServlet {

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
        // Step 0: Call DB Context
        QuizDBContext qdb = new QuizDBContext();
        //Get User in session
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        //Step 1: get QuizID ID parameter
        String rawQuizId = request.getParameter("quizId");
        int quizId = Integer.parseInt(rawQuizId);
        //Step 2: get quiz, question and option in a quiz
        Quiz quiz = qdb.getQuizById(quizId);

        //Step 3: Get question and option that learner answered
        String username = user.getUsername();
        ArrayList<UserQuizDetail> questionsAnswered = qdb.getQuestionsAnswered(username, quizId);

        //Step 4: Get status done or notdone of each option
        for (Question question : quiz.getQuestions()) {
            for (Option option : question.getOptions()) {
                boolean isChoosen = checkOptionChoosen(option, questionsAnswered);
                option.setIschoosen(isChoosen);
            }
        }
        request.setAttribute("answered", questionsAnswered);
        request.setAttribute("quiz", quiz);

        request.getRequestDispatcher("../../../view/dynamic/authen/manage/quiz/review.jsp").forward(request, response);
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

    private boolean checkOptionChoosen(Option option, ArrayList<UserQuizDetail> questionsAnswered) {
        boolean isChoosen = false;
        for (UserQuizDetail userQuizDetail : questionsAnswered) {
            ArrayList<UserQuestionDetail> quesDetail = userQuizDetail.getUserQuestionDetails();
            for (UserQuestionDetail userQuestionDetail : quesDetail) {
                if (option.getOptionId() == userQuestionDetail.getOption().getOptionId()) {
                    isChoosen = true;
                    break;
                }
            }
        }
        return isChoosen;
    }

}
