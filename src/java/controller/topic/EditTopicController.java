/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.topic;

import com.google.gson.Gson;
import dal.PricePackageDBContext;
import dal.TopicDBContext;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Base64;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.PricePackage;
import model.Topic;

/**
 *
 * @author win
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "EditTopicController", urlPatterns = {"/authen/manage/topic/edit"})
public class EditTopicController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet EditTopicController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditTopicController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        // Step 1: Get topic id 
        String rawId = request.getParameter("id");
        int topicId = Integer.parseInt(rawId);

        // Step 2: Get topic by id
        TopicDBContext tdb = new TopicDBContext();
        Topic topic = tdb.getTopic(topicId);

        // Step 3: Get topic detail
        Gson gson = new Gson();

        // Step 4: Create hashmap for coverting to json
        HashMap<String, Object> map = new HashMap<>();
        map.put("topic", topic);
        map.put("topicAvatar", topic.getAvatar());
        map.put("avatarStr", topic.getImgStr());

        // Step 5: Return topic detail
        PrintWriter writer = response.getWriter();
        writer.write(gson.toJson(map));

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

        // Step 1: Call DB Context
        TopicDBContext tdb = new TopicDBContext();

        // Step 2: Get topic information from user
        String rawId = request.getParameter("topicId");
        int id = Integer.parseInt(rawId);
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        Part img = request.getPart("img");
        InputStream is = img.getInputStream();
        byte[] avt = new byte[is.available()];

        is.read(avt);
        // Step 3: If user don't choose new image then get current image
        if (avt.length == 0) {
            avt = Base64.getDecoder().decode(request.getParameter("currentImg"));
        }

        // Step 4: Create new topic
        Topic t = new Topic();
        t.setTopicId(id);
        t.setTopicName(title);
        t.setDescription(description);
        t.setImg(avt);

        // Step 5: Update topic
        tdb.updateTopic(t);

        // Step 6: Send redirect to list topic page
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
