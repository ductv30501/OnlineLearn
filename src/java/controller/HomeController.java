/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.sun.faces.util.CollectionsUtils;
import dal.BlogDBContext;
import dal.CourseDBContext;
import dal.FeedbackDBContext;
import dal.MyCourseDBContext;
import dal.SliderDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Blog;
import model.Course;
import model.CourseUser;
import model.Feedback;
import model.Group;
import model.Slider;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "HomeController", urlPatterns = {"/home"})
public class HomeController extends HttpServlet {

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
        response.setContentType("image/gif");
        request.setCharacterEncoding("utf-8");
        // DB Context
        UserDBContext udb = new UserDBContext();
        TopicDBContext tdb = new TopicDBContext();
        CourseDBContext cdb = new CourseDBContext();
        SliderDBContext sdb = new SliderDBContext();
        BlogDBContext bdb = new BlogDBContext();
        FeedbackDBContext fdb = new FeedbackDBContext();

        // Step 1: Get user from session
        String url = "";
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // Step 2: Get entity from db
        ArrayList<Topic> topics = tdb.getTopics();

        ArrayList<User> experts = udb.getExperts();
        ArrayList<Course> courses = cdb.getCourses();
        ArrayList<Slider> sliders = sdb.getActiveSliders();
        ArrayList<Feedback> feedbacks = fdb.getFeedbacks();
        //get course most rate from db

        // get top blog list 
        ArrayList<Blog> topBlog = bdb.getTopThreeBlog();
        request.setAttribute("topBlog", topBlog);
        // Step 3: Check user login or not
        if (user == null) {
            url = "view/dynamic/user/guest/home.jsp";
        } else {
            Group userGroup = udb.getUserGroup(user);
            String groupName = userGroup.getName();
            if (groupName.equals("Học viên")) {
                MyCourseDBContext dbm = new MyCourseDBContext();
                ArrayList<CourseUser> myCourses = dbm.getMyCourses(user.getUsername());
                request.setAttribute("mycourses", myCourses);
                url = "view/dynamic/user/learner/home.jsp";
            } else {
                url = "/authen/dashboard";
            }
            session.setAttribute("user", user);
            session.setAttribute("groupName", groupName);
        }

        request.setAttribute("topics", topics);
        request.setAttribute("experts", experts);
        request.setAttribute("sliders", sliders);
        request.setAttribute("courses", courses);
        request.setAttribute("feedbacks", feedbacks);

        request.getRequestDispatcher(url).forward(request, response);

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
