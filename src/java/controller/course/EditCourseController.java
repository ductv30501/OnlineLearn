/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import com.google.gson.Gson;
import dal.CourseDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Course;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "EditCourseController", urlPatterns = {"/authen/manage/course/edit"})
public class EditCourseController extends HttpServlet {

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

        int courseId = Integer.parseInt(request.getParameter("courseId"));

        CourseDBContext cdb = new CourseDBContext();

        Course course = cdb.getCourse(courseId);

        
        Gson gson = new Gson();
        
        
        PrintWriter writer = response.getWriter();
        
        HashMap<String, Object> map = new HashMap<>();
        
        map.put("course", course);
        
        
        writer.print(gson.toJson(map));
        
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
        request.setCharacterEncoding("utf-8");

        // Step 1: Get course info
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        String courseTitle = request.getParameter("course_title");
        int topicId = Integer.parseInt(request.getParameter("topic_id"));
        String usernameXxpert = request.getParameter("username_expert");
        String description = request.getParameter("description");

        // Get course image
        Part img = request.getPart("img");
        InputStream is = img.getInputStream();
        byte[] avt = new byte[is.available()];
        is.read(avt);

        // Step 2: Get topic and expert username
        Topic t = new Topic();
        t.setTopicId(topicId);
        User user = new User();
        user.setUsername(usernameXxpert);

        // Step 3: Create new course
        Course course = new Course();
        course.setCourseId(courseId);
        course.setCourseTitle(courseTitle);
        course.setTopic(t);
        course.setDescription(description);
        course.setCreatedBy(user.getUsername());
        course.setImg(avt);

        // Step 4: Insert course and course user to db
        CourseDBContext db = new CourseDBContext();

        db.updateCourse(course);




        // Step 6: Return back to the user view
        response.sendRedirect("list");
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
