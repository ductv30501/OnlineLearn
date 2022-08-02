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
@WebServlet(name = "EditLessonController", urlPatterns = {"/authen/manage/course/lesson/edit"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 1024 * 5 * 5)
public class EditLessonController extends HttpServlet {

    private static final String LOCAL = "\\assets\\video";
    private static final String REMOTE = "video/";

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
        int lessonId = Integer.parseInt(request.getParameter("id"));

        CourseDBContext cdb = new CourseDBContext();
        Lesson lesson = cdb.getLesson(lessonId);

        PrintWriter writer = response.getWriter();

        String result = "";

        result += lesson.getLessonId() + "|";
        result += lesson.getChapter().getChapterId() + "|";
        result += lesson.getPublicId() + "|";
        result += lesson.getVideoURL() + "|";
        result += lesson.getLessonTitle() + "|";
        result += lesson.getDescription();

        writer.write(result);
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
        // Step 1: Call database context
        CourseDBContext cdb = new CourseDBContext();

        // Step 2: Get data from user
        int lessonId = Integer.parseInt(request.getParameter("lessonId"));
        String lessonTitle = request.getParameter("lessonTitle");
        int chapterId = Integer.parseInt(request.getParameter("chapterId"));
        String currentPublicId = request.getParameter("publicId");
        String currentVideoURL = request.getParameter("videoURL");
        String description = request.getParameter("description");
        Chapter chapter = cdb.getChapter(chapterId);

        // Step 3: Call cloudinary API
        Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                "cloud_name", "dttzqtaiq",
                "api_key", "496231876975156",
                "api_secret", "HWtNjuUnEMmTCvpgCD3tbOLmkPc",
                "secure", true));

        Map<String, String> uploadResult = null;

        // Step 4: Get video and set upload path in local 
        String uploadPath = getServletContext().getRealPath("") + LOCAL;
        Part filePart = request.getPart("video-input");
        String submmittedFileName = filePart.getSubmittedFileName();
        String fileAbsolutePath = uploadPath + File.separator + submmittedFileName;

        InputStream is = filePart.getInputStream();
        byte[] byteVideo = new byte[is.available()];
        is.read(byteVideo);

        try ( // Step 5: Temporally store video file in project
                 FileOutputStream fos = new FileOutputStream(fileAbsolutePath)) {
            fos.write(byteVideo);
            fos.flush();
        }

        File video = new File(fileAbsolutePath);

        // Step 6: Check if file is already exist or not 
        String newPublicId = REMOTE + submmittedFileName;
        String videoURL = "";
        String publicId = "";

        if (currentPublicId.equals(newPublicId)) {
            videoURL = currentVideoURL;
            publicId = currentPublicId;
        } else {
            cloudinary.uploader().destroy(currentPublicId,
                    ObjectUtils.asMap("resource_type", "video"));

            uploadResult = cloudinary.uploader().upload(video,
                    ObjectUtils.asMap("resource_type", "video",
                            "public_id", newPublicId));
            videoURL = String.valueOf(uploadResult.get("url"));
            publicId = String.valueOf(uploadResult.get("public_id"));
        }
        
        int duration = 100;

        Lesson lesson = new Lesson(lessonId, chapter, lessonTitle, duration,
                videoURL, publicId, description);
        Path path = Paths.get(fileAbsolutePath);
        Files.delete(path);

        cdb.updateLesson(lesson);

        int id = Integer.parseInt(request.getParameter("id"));

        response.sendRedirect("../prepare?id=" + id);
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
