/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dal.CourseDBContext;
import dal.CourseUserDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Course;
import model.CourseTaget;
import model.CourseUser;
import model.Lesson;
import model.PricePackage;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CourseDetailController", urlPatterns = {"/course/detail"})
public class CourseDetailController extends HttpServlet {

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

        CourseDBContext courseDB = new CourseDBContext();

        CourseUserDBContext cuDB = new CourseUserDBContext();
        UserDBContext userDB = new UserDBContext();

        //get course ID
        String rawCourseId = request.getParameter("cid");
        int courseID = Integer.parseInt(rawCourseId);

        //get course by course ID
        Course courseByID = courseDB.getCourseDetail(courseID);
        request.setAttribute("courseById", courseByID);

        //get course target by course id
        ArrayList<CourseTaget> courseTargets = courseDB.getTargetByCourseID(courseID);
        request.setAttribute("targets", courseTargets);

        //get chapter list by course id
        ArrayList<Chapter> chapters = courseDB.getChapters(courseByID);
        request.setAttribute("chapters", chapters);

        HashMap<Integer, Object> lessonMap = new HashMap<>();
        int countLessons = 0;

        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();

        // Step 2: Set request attribute
        //loop each chapter
        for (int i = 0; i < chapters.size(); i++) {

            //get chapter id of each id as key of hash map
            int chapID = chapters.get(i).getChapterId();
            //get list of lesson base on each chapter
            ArrayList<Lesson> lessons = courseDB.getLessons(chapters.get(i));
            lessonMap.put(chapID, lessons);

            //count number of lesson
            countLessons += lessons.size();
        }
        //set attribute for hashmap     
        request.setAttribute("lessonMap", lessonMap);
        //set attrubute for count lesson
        request.setAttribute("countlessons", countLessons);
        //get review list by course id
        ArrayList<CourseUser> reviewList = cuDB.getReviewByCourse(courseID);
        request.setAttribute("reviews", reviewList);
        //get size of review list
        int reviewSize = reviewList.size();
        request.setAttribute("reviewsize", reviewSize);
        //get count of each number star
        ArrayList<Integer> countStars = new ArrayList<>();
        for (int i = 0; i < 5; i++) {
            int count = cuDB.getCountStar(courseID, i + 1);
            countStars.add(count);
        }
        request.setAttribute("countstar", countStars);

        //Get teacher by course ID
        User teacher = userDB.getTeacherByCourseID(courseID);
        request.setAttribute("teacher", teacher);
        //get number of learner enrolled this course
        int countEnrolled = courseDB.getNumberRegistered(courseID);
        request.setAttribute("enrolled", countEnrolled);
        request.setAttribute("topics", topics);
        request.getRequestDispatcher("../view/dynamic/course/coursedetail.jsp").forward(request, response);

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
