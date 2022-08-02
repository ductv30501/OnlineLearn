/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.BlogDBContext;
import dal.CourseDBContext;
import dal.TopicDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Blog;
import model.Category;
import model.Course;
import model.Topic;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SearchController", urlPatterns = {"/search"})
public class SearchController extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        //init course DB
        CourseDBContext courseDb = new CourseDBContext();
        TopicDBContext topicDb = new TopicDBContext();
        BlogDBContext blogDb = new BlogDBContext();
        
        
        //Step 1: Get keyword from jsp
        String rawQuery = request.getParameter("query");
        String rawIndex = request.getParameter("index");
        
        String query = (rawQuery == null || rawQuery.trim().length() == 0) ? null : rawQuery;
        int index = (rawIndex == null || rawIndex.trim().length()==0)?1:Integer.parseInt(rawIndex);
        
        //Step 2: Get all topic
        ArrayList<Topic> topics = topicDb.getTopics();
        //Step 3: get all course relate with this keywork
        ArrayList<Course> searchCourse = courseDb.searchCourse(index, query);
        //Step 4: get all blog relate with thí keyword
        ArrayList<Blog> searchBlog = blogDb.searchBlog(query, index);
        //Step 5: get all category
        ArrayList<Category> categories = blogDb.getCategory();
        
        //Get total page size
        int totalCourse = courseDb.getTotalCourses();
        int countPaging = totalCourse/8;
        if (totalCourse % 8 != 0) {
            countPaging++;
        }
        
        request.setAttribute("result", searchCourse);
        request.setAttribute("topics", topics);
        request.setAttribute("query", query);
        request.setAttribute("index", index);
        request.setAttribute("blogs", searchBlog);
        request.setAttribute("categories", categories);
        request.setAttribute("countPaging", countPaging);

        request.getRequestDispatcher("view/dynamic/public/search.jsp").forward(request, response);
        
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
