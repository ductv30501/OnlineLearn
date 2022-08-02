/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dal.CourseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Chapter;
import model.Lesson;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "DeleteChapterController", urlPatterns = {"/authen/manage/course/chapter/delete"})
public class DeleteChapterController extends HttpServlet {

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
        CourseDBContext cdb = new CourseDBContext();

        int chapterId = Integer.parseInt(request.getParameter("id"));
        int courseId = Integer.parseInt(request.getParameter("courseId"));
        Chapter chapter = cdb.getChapter(chapterId);
        ArrayList<Lesson> lessons = cdb.getLessons(chapter);

        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dttzqtaiq",
                "api_key", "496231876975156",
                "api_secret", "HWtNjuUnEMmTCvpgCD3tbOLmkPc",
                "secure", true));

        for (Lesson lesson : lessons) {
            cloudinary.uploader().destroy(lesson.getPublicId(),
                    ObjectUtils.asMap("resource_type", "video"));
        }
        cdb.deleteChapter(chapter);


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