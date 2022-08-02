/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.topic;

import dal.TopicDBContext;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Topic;

/**
 *
 * @author win
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "InsertTopicController", urlPatterns = {"/authen/manage/topic/insert"})
public class InsertTopicController extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        // Step 1: Call DB Context
        TopicDBContext tdb = new TopicDBContext();

        // Step 2: Get data from user
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        Part img = request.getPart("img");
        
        // Step 3: Convert image to byte array
        InputStream is = img.getInputStream();
        byte[] avt = new byte[is.available()];
        is.read(avt);

        // Set default topic image if the user doesn't choose image
        if (avt.length == 0) {
            // Get file name absolute in computer
            String realPath = getServletContext().getRealPath("");
            String fileName = realPath + File.separator + "assets\\img\\topic-default.jpg";
            // Read file image for add default image
            BufferedImage bufferedImage = ImageIO.read(new File(fileName));
            ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
            ImageIO.write(bufferedImage, "jpg", byteArrayOutputStream);
            avt = byteArrayOutputStream.toByteArray();
        }

        
        // Step 4: Create new topic
        Topic t = new Topic();
        t.setTopicName(title);
        t.setImg(avt);
        t.setDescription(description);
        
        // Step 5: Insert topic to database 
        tdb.insertTopic(t);
        
        // Step 6: Send redirect to list topic page
        response.sendRedirect("list");
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurss
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
