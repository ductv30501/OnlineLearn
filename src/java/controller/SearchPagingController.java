/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CourseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Course;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SearchPagingController", urlPatterns = {"/search/paging"})
public class SearchPagingController extends HttpServlet {

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

        CourseDBContext courseDb = new CourseDBContext();
        PrintWriter out = response.getWriter();
        //Step 1: get query and index from jsp
        String rawIndex = request.getParameter("index");
        int index = Integer.parseInt(rawIndex);
        String query = request.getParameter("query");

        String[] rawRates = request.getParameterValues("rate[]");        
        String[] rawTopicIds = request.getParameterValues("topic[]");
        
        ArrayList<Integer> topicIds = new ArrayList<>();
        ArrayList<Integer> rateChoose = new ArrayList<>();
        
        if (rawTopicIds != null) {
            for (int i = 0; i < rawTopicIds.length; i++) {                
                topicIds.add(Integer.parseInt(rawTopicIds[i]));
            }
        }
        if (rawRates != null) {
            for (int i = 0; i < rawRates.length; i++) {                
                rateChoose.add(Integer.parseInt(rawRates[i]));
            }
        }
        
        //step 2: Get courses in this page       
        ArrayList<Course> coursePaging = courseDb.getFilterCourses(query, topicIds, rateChoose, index);
        for (Course course : coursePaging) {
            out.println("<div class=\"col-lg-3 col-md-6 mb-3\">\n"
                    + "                            <div class=\"rounded overflow-hidden mb-2\">\n"
                    + "                                <img class=\"img-fluid\" src=\"" + course.getAvatar() + "\" alt=\"\" style=\"max-height: 264px; min-height: 248px; width: 100%\">\n"
                    + "                                <div class=\"bg-secondary p-4\">\n"
                    + "                                    <div class=\"d-flex justify-content-between mb-3\">\n"
                    + "                                        <small class=\"m-0\"><i class=\"fa fa-users text-primary mr-2\"></i>" + course.getTotalLearner() + " Học viên</small>\n"
                    + "                                        <small class=\"m-0\"><i class=\"far fa-clock text-primary mr-2\"></i>" + course.getDuration() + "</small>\n"
                    + "                                    </div>\n"
                    + "                                    <a class=\"h5\" href=\"\">" + course.getCourseTitle() + "</a>\n"
                    + "                                    <div class=\"border-top mt-4 pt-4\">\n"
                    + "                                        <div class=\"d-flex justify-content-between\">\n"
                    + "                                            <h6 class=\"m-0\"><i class=\"fa fa-star text-primary mr-2\"></i>" + course.getRate() + " <small>(0 đánh giá)</small></h6>\n"
                    + "                                            <!--<h5 class=\"m-0\">$99</h5>-->\n"
                    + "                                        </div>\n"
                    + "                                    </div>\n"
                    + "                                </div>\n"
                    + "                            </div>\n"
                    + "                        </div>");
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
