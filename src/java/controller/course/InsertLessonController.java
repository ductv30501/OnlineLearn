/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dal.CourseDBContext;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Chapter;
import model.Lesson;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "InsertLessonController", urlPatterns = {"/authen/manage/course/lesson/insert"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 1024 * 5 * 5)
public class InsertLessonController extends HttpServlet {
    
    private static final String LOCAL = "\\assets\\video";
    private static final String REMOTE = "video/";

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

        // Step 1: Call DB Context
        CourseDBContext cdb = new CourseDBContext();

        // Step 2: Get course information from user input
        String lessonTitle = request.getParameter("lessonTitle");
        String description = request.getParameter("description");
        int chapterId = Integer.parseInt(request.getParameter("chapterId"));
        Chapter chapter = cdb.getChapter(chapterId);

        // Get video file 
        Part filePart = request.getPart("video-input");
        String uploadPath = getServletContext().getRealPath("") + LOCAL;
        String submmittedFileName = filePart.getSubmittedFileName();
        String fileAbsolutePath = uploadPath + File.separator + submmittedFileName;
        
        InputStream is = filePart.getInputStream();
        byte[] byteVideo = new byte[is.available()];
        is.read(byteVideo);
        
        try ( // Add temporarily video file to project folder
                 FileOutputStream fos = new FileOutputStream(fileAbsolutePath)) {
            fos.write(byteVideo);
            fos.flush();
        }
        File video = new File(fileAbsolutePath);

        // Step 4: Call cloudinary API
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dttzqtaiq",
                "api_key", "496231876975156",
                "api_secret", "HWtNjuUnEMmTCvpgCD3tbOLmkPc",
                "secure", true));
        Map<String, Object> uploadResult = cloudinary.uploader().upload(video,
                ObjectUtils.asMap("resource_type", "video",
                        "image_metadata", true,
                        "public_id", REMOTE + submmittedFileName));

        // Step 5: Get video properties after upload video to cloudinary
        String videoURL = String.valueOf(uploadResult.get("url"));
        String publicId = String.valueOf(uploadResult.get("public_id"));
        String durationStr = String.valueOf(uploadResult.get("duration"));
        
        int duration = (int) Float.parseFloat(durationStr);

        // Delete temporarily video file from project folder
        Path path = Paths.get(fileAbsolutePath);
        
        
        Files.delete(path);

        // Step 6: Insert lesson to database
        Lesson lesson = new Lesson(chapter, lessonTitle, duration, videoURL,
                publicId, description);
        
        cdb.insertLesson(lesson);
        
        int courseId = Integer.parseInt(request.getParameter("id"));
        
        response.sendRedirect(
                "../prepare?id=" + courseId);
        
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
