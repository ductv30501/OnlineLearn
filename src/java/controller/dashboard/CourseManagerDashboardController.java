/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard;

import com.google.gson.Gson;
import dal.CourseDBContext;
import dal.PricePackageDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Course;
import model.Topic;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CourseManagerDashboardController", urlPatterns = {"/authen/manager/dashboard"})
public class CourseManagerDashboardController extends HttpServlet {

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
        TopicDBContext tdb = new TopicDBContext();
        CourseDBContext cdb = new CourseDBContext();
        UserDBContext udb = new UserDBContext();

        int totalTopics = tdb.getTotalTopics();
        int totalCourses = cdb.getTotalCourses();
        int totalExperts = udb.getTotalExperts();
        int totalLearners = udb.getTotalLearners();

        ArrayList<Course> topCourses = cdb.getTopCourses();
        ArrayList<Topic> popularTopics = tdb.getPopularTopics();

        request.setAttribute("totalTopics", totalTopics);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("totalExperts", totalExperts);
        request.setAttribute("totalLearners", totalLearners);
        request.setAttribute("topCourses", topCourses);
        request.setAttribute("popularTopics", popularTopics);

        request.getRequestDispatcher("../../view/dynamic/user/manager/dashboard.jsp").forward(request, response);

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
        response.setContentType("text/html;charset=UTF-8");
        TopicDBContext tdb = new TopicDBContext();
        CourseDBContext cdb = new CourseDBContext();
        UserDBContext udb = new UserDBContext();

        ArrayList<Course> topCourses = cdb.getTopCourses();
        ArrayList<Topic> popularTopics = tdb.getPopularTopics();

        int totalLearners = udb.getTotalLearners();

        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();

        String[] topicLables = new String[popularTopics.size()];
        int[] topicLearners = new int[popularTopics.size()];
        for (int i = 0; i < popularTopics.size(); i++) {
            Topic t = popularTopics.get(i);
            topicLables[i] = t.getTopicName();

            topicLearners[i] = t.getTotalLearner();
        }

        String[] courseLables = new String[topCourses.size()];
        int[] courseLearners = new int[topCourses.size()];
        for (int i = 0; i < topCourses.size(); i++) {
            Course c = topCourses.get(i);
            courseLables[i] = c.getCourseTitle();
            courseLearners[i] = c.getTotalLearner();
        }
        
       

        map.put("topicLables", topicLables);
        map.put("topicLearners", topicLearners);
        map.put("courseLables", courseLables);
        map.put("courseLearners", courseLearners);
        map.put("totalLearners", totalLearners);

        response.getWriter().println(gson.toJson(map));

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
