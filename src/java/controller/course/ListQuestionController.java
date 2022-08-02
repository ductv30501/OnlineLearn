/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dal.CourseDBContext;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Course;
import model.Question;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ListQuestionController", urlPatterns = {"/authen/manage/question/list"})
public class ListQuestionController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        CourseDBContext cc = new CourseDBContext();

        String rawSortTitle = request.getParameter("sortTitle");
        String rawNumber = request.getParameter("number");
        String rawCourse = request.getParameter("course");
        String rawChapter = request.getParameter("chapter");
        String rawlevel = request.getParameter("level");
        String search = request.getParameter("search");
        String rawIndex = request.getParameter("index");

        String course = (rawCourse == null || rawCourse.length() == 0 || rawCourse.equals("-1")) ? "" : rawCourse;
        String chapter = (rawChapter == null || rawChapter.length() == 0 || rawChapter.equals("-1")) ? "" : rawChapter;
        String level = (rawlevel == null || rawlevel.length() == 0 || rawlevel.equals("-1")) ? "" : rawlevel;
        search = (search == null || search.length() == 0) ? "" : search;
        rawIndex = (rawIndex == null || rawIndex.length() == 0) ? "1" : rawIndex;
        rawNumber = (rawNumber == null || rawNumber.length() == 0) ? "5" : rawNumber;
        String[] sortTitle = (rawSortTitle == null || rawSortTitle.length() == 0) ? null : rawSortTitle.split(" ");
        String sort = (sortTitle == null) ? "asc" : sortTitle[0];
        String obj = (sortTitle == null) ? "question_id" : sortTitle[1];

        int index = Integer.parseInt(rawIndex);
        int number = Integer.parseInt(rawNumber);

        int count = cc.countQuestions(course, chapter, level, search);
        int totalPage = count / number;
        if (count % number != 0) {
            totalPage++;
        }
        
        Course currentCourse = cc.getCourse(Integer.parseInt(course));
        Chapter currentChapter = cc.getChapter(Integer.parseInt(chapter));

        ArrayList<Question> questions = cc.getQuestions(course, chapter, level, search, index, number, sort, obj);
        ArrayList<Course> courseList = cc.getCourseList();
        ArrayList<Chapter> chapters = cc.getChapters(course);
        String courseID = String.valueOf(courseList.get(0).getCourseId());
        ArrayList<Chapter> fistchapters = cc.getChapters(courseID);

        request.setAttribute("sortTitle", sort + " " + obj);
        request.setAttribute("sort", sort);
        request.setAttribute("obj", obj);
        request.setAttribute("number", number);
        request.setAttribute("index", index);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("questions", questions);
        request.setAttribute("courses", courseList);
        request.setAttribute("chapters", chapters);
        request.setAttribute("fistchapters", fistchapters);
        request.setAttribute("course", course);
        request.setAttribute("chapter", chapter);
        request.setAttribute("level", level);
        request.setAttribute("search", search);
        
        request.setAttribute("currentCourse", currentCourse);
        request.setAttribute("currentChapter", currentChapter);
        
        
        request.getRequestDispatcher("../../../view/dynamic/authen/manage/question/list.jsp").forward(request, response);
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
