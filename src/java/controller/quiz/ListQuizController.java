/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.quiz;

import dal.ChapterDBContext;
import dal.CourseDBContext;
import dal.QuizDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.JDBCType;
import java.util.ArrayList;
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
@WebServlet(name = "ListQuizController", urlPatterns = {"/authen/expert/quiz/list"})
public class ListQuizController extends HttpServlet {

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
        //DBContext
        QuizDBContext quizDB = new QuizDBContext();
        CourseDBContext courseDB = new CourseDBContext();
        ChapterDBContext chapterDB = new ChapterDBContext();
        //get parameter from jsp
        String rawSortTitle = request.getParameter("sortTitle");
        String rawNumber = request.getParameter("number");
        // role --> course
        String rawCourse = request.getParameter("course");
        // status --> chapter
        String rawChapter = request.getParameter("chapter");
        
        String search = request.getParameter("search");
        String rawIndex = request.getParameter("index");
        
        String course = (rawCourse == null || rawCourse.length() == 0 || rawCourse.equals("-1")) ? "" : rawCourse;
        String chapter = (rawChapter == null || rawChapter.length() == 0||rawChapter.equals("-1")) ? "" : rawChapter;
        search = (search == null || search.length() == 0) ? "" : search;
        rawIndex = (rawIndex == null || rawIndex.length() == 0) ? "1" : rawIndex;
        rawNumber = (rawNumber == null || rawNumber.length() == 0) ? "5" : rawNumber;
        String[] sortTitle = (rawSortTitle == null || rawSortTitle.length() == 0) ? null : rawSortTitle.split(" ");
        String sort = (sortTitle == null) ? "asc" : sortTitle[0];
        String obj = (sortTitle == null) ? "quizz_id" : sortTitle[1];
        
        int index = Integer.parseInt(rawIndex);
        int number = Integer.parseInt(rawNumber);
        
        int count = quizDB.CountQuiz(course,chapter,search);
        int totalPage = count / number;
        if (count % number != 0) {
            totalPage++;
        }
        
        ArrayList<Quiz> quizies = quizDB.GetQuizies(course,chapter,search, index, number, sort, obj);
        ArrayList<Course> courses = courseDB.getCourses();
        ArrayList<Chapter> chapters = chapterDB.getChapterByCourseID(course);
        int courseIDFIndex = courses.get(0).getCourseId();
        String courseFIndex = String.valueOf(courseIDFIndex);
        ArrayList<Chapter> chapterOfFristCourse = chapterDB.getChapterByCourseID(courseFIndex);
        
        request.setAttribute("sortTitle", sort + " " + obj);
        request.setAttribute("sort", sort);
        request.setAttribute("obj", obj);
        request.setAttribute("number", number);
        request.setAttribute("index", index);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("courses", courses);
        request.setAttribute("chapters", chapters);
        request.setAttribute("quizies", quizies);
        request.setAttribute("course", course);
        request.setAttribute("chapter", chapter);
        request.setAttribute("chapterOfFristCourse", chapterOfFristCourse);
        request.setAttribute("search", search);
        request.getRequestDispatcher("../../../view/dynamic/authen/manage/quiz/list.jsp").forward(request, response);
        
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
