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
import java.util.Calendar;
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
import model.UserQuiz;
import model.UserQuizDetail;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "QuizHandleController", urlPatterns = {"/authen/manage/quiz/handle"})
public class QuizHandleController extends HttpServlet {

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
            out.println("<title>Servlet QuizHandleController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet QuizHandleController at " + request.getContextPath() + "</h1>");
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

        // Step 1: Call DB Context
        QuizDBContext qdb = new QuizDBContext();

        // Step 2: Get chapter id
        int quizId = Integer.parseInt(request.getParameter("quizId"));

        int chid = Integer.parseInt(request.getParameter("chapterId"));
        int cid = Integer.parseInt(request.getParameter("courseId"));
        Quiz quiz = qdb.getQuizById(quizId);

        LocalDate today = LocalDate.now();
        Date takenDate = Date.valueOf(today);

        request.setAttribute("quiz", quiz);
        request.setAttribute("chapterId", chid);
        request.setAttribute("courseId", cid);
        request.setAttribute("takenDate", takenDate);

        request.getRequestDispatcher("../../../view/dynamic/authen/manage/quiz/handle.jsp").forward(request, response);
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

        // Step 1: Call DBContext
        QuizDBContext qdb = new QuizDBContext();
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Step 2:
        int chid = Integer.parseInt(request.getParameter("chapterId"));
        int quizId = Integer.parseInt(request.getParameter("quizId"));
        // Get today  date
        LocalDate today = LocalDate.now();
        Date takenDate = Date.valueOf(today);

        // Get quiz by chapter id
        Quiz quiz = qdb.getQuizByChapter(chid);

        int realPoint = 0;

        // Create user quiz
        UserQuiz userQuiz = new UserQuiz(user, quiz, takenDate);

        // Get question in quiz
        ArrayList<Question> questions = quiz.getQuestions();
        ArrayList<UserQuizDetail> userQuizDetails = new ArrayList<>();

        for (int i = 0; i < questions.size(); i++) {

            Question question = questions.get(i);

            // Create user quiz detail
            UserQuizDetail userQuizDetail = new UserQuizDetail(user, quiz, question);
            String[] chosenOptions = request.getParameterValues(String.valueOf(question.getQuestionId()));

            ArrayList<UserQuestionDetail> userQuestionDetails = new ArrayList<>();
            if (chosenOptions == null) {
                continue;
            }

            for (int j = 0; j < chosenOptions.length; j++) {
                String chosenOptionStr = chosenOptions[j];
                int optionId = Integer.parseInt(chosenOptionStr);

                Option chosenOption = new Option();
                chosenOption.setOptionId(optionId);

                UserQuestionDetail userOptionDetail = new UserQuestionDetail(user, quiz, question, chosenOption);
                userQuestionDetails.add(userOptionDetail);

                ArrayList<Option> options = question.getOptions();
                for (Option option : options) {
                    if (option.getOptionId() == optionId && option.isIsCorrect()) {
                        realPoint += question.getPoint();
                    }
                }
            }
            userQuizDetail.setUserQuestionDetails(userQuestionDetails);
            userQuizDetails.add(userQuizDetail);
        }

        // Get quiz id in the chapter
        userQuiz.setScore(realPoint);
        userQuiz.setUserQuizDetails(userQuizDetails);

        if (quizId != -1) {
            qdb.deleteUserQuiz(user.getUsername(), quizId);
        }

        qdb.insertUserQuiz(userQuiz);

        request.getRequestDispatcher("../../course/quiz/review").forward(request, response);

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
