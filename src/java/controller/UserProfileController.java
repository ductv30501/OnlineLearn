/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.cloudinary.Cloudinary;
import com.cloudinary.utils.ObjectUtils;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import model.Lesson;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "UserProfileController", urlPatterns = {"/authen/user/profile"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
public class UserProfileController extends HttpServlet {

    private static final String LOCAL = "\\assets\\avatar";
    private static final String REMOTE = "avatar/";

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
        // Get user from session
        User user = (User) request.getSession().getAttribute("user");
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();

        request.setAttribute("user", user);
        request.setAttribute("topics", topics);
        request.getRequestDispatcher("../../view/dynamic/user/profile.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");

        // Get Data
        String username = request.getParameter("username");
        String name = request.getParameter("name");
        String rawDob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String rawGender = request.getParameter("gender");
        String rawEmail = request.getParameter("email");
        String address = request.getParameter("address");
        String description = request.getParameter("description");

        String currentPublicId = request.getParameter("publicId");
        String currentImageURL = request.getParameter("imageURL");

        Date dob = null;
        Boolean gender = null;

        // Process dob
        if (rawDob != null && !rawDob.equals("")) {
            dob = Date.valueOf(rawDob);
        }

        // Process gender
        if (rawGender.equals("male")) {
            gender = true;
        } else if (rawGender.equals("female")) {
            gender = false;
        }

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        // Create new user
        user.setUsername(username);
        user.setName(name);
        user.setDob(dob);
        user.setPhone(phone);
        user.setGender(gender);
        user.setEmail(rawEmail);
        user.setAddress(address);
        user.setDescription(description);

        Part filePart = request.getPart("img");
        InputStream is = filePart.getInputStream();
        byte[] avatar = new byte[is.available()];
        is.read(avatar);

        if (avatar.length > 0) {
            Cloudinary cloudinary = new Cloudinary(ObjectUtils.asMap(
                    "cloud_name", "dttzqtaiq",
                    "api_key", "496231876975156",
                    "api_secret", "HWtNjuUnEMmTCvpgCD3tbOLmkPc",
                    "secure", true));
            // Get video file 
            String uploadPath = getServletContext().getRealPath("") + LOCAL;
            String submmittedFileName = filePart.getSubmittedFileName();
            String fileAbsolutePath = uploadPath + File.separator + submmittedFileName;

            try ( // Add temporarily video file to project folder
                     FileOutputStream fos = new FileOutputStream(fileAbsolutePath)) {
                fos.write(avatar);
                fos.flush();
            }
            File image = new File(fileAbsolutePath);

            // Step 6: Check if file is already exist or not 
            String newPublicId = REMOTE + submmittedFileName;
            String imageURL = "";
            String publicId = "";
            Map<String, String> uploadResult = null;

            if (currentPublicId.equals(newPublicId)) {
                imageURL = currentImageURL;
                publicId = currentPublicId;
            } else {
                cloudinary.uploader().destroy(currentPublicId,
                        ObjectUtils.asMap("resource_type", "image"));

                uploadResult = cloudinary.uploader().upload(image,
                        ObjectUtils.asMap("resource_type", "image",
                                "public_id", newPublicId));
                imageURL = String.valueOf(uploadResult.get("url"));
                publicId = String.valueOf(uploadResult.get("public_id"));
            }


            // Delete temporarily video file from project folder
            Path path = Paths.get(fileAbsolutePath);
            Files.delete(path);
            user.setAvatar(imageURL);
            user.setPublicId(publicId);
        }

        // Update user info
        UserDBContext udb = new UserDBContext();
        udb.UpdateUser(user);

        response.sendRedirect("../../view/dynamic/component/notification.jsp");
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
