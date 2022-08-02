/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dal.CourseDBContext;
import dal.FeedbackDBContext;
import dal.MyCourseDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Blob;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Course;
import model.CourseUser;
import model.Feedback;
import model.Group;
import model.Topic;
import model.User;

/**
 *
 * @author win
 */
@WebServlet(name = "MyCourseController", urlPatterns = {"/authen/course/mycourse"})
public class MyCourseController extends HttpServlet {

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
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();
        String url = "";

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        UserDBContext udb = new UserDBContext();

        Group userGroup = udb.getUserGroup(user);

        String groupName = userGroup.getName();
        if (groupName.equalsIgnoreCase("Học viên")) {
            session.setAttribute("user", user);
            session.setAttribute("userGroup", userGroup);
            MyCourseDBContext db = new MyCourseDBContext();
            ArrayList<CourseUser> listMyCourseDone = db.getCourseDone(user.getUsername());
            request.setAttribute("listMyCourseDone", listMyCourseDone);

            ArrayList<CourseUser> inProgressCourse = db.getInProgressCourse(user.getUsername());
            request.setAttribute("InProgressCourse", inProgressCourse);
            url = "../../view/dynamic/user/learner/my-course.jsp";
        }

        session.setAttribute("user", user);
        session.setAttribute("userGroup", userGroup);
        request.setAttribute("topics", topics);

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
