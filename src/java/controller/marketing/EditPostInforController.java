/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import dal.PostDBContext;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Blog;
import model.Category;
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "EditPostInforController", urlPatterns = {"/authen/marketing/post/edit"})
public class EditPostInforController extends HttpServlet {
    
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
        
        //Step 1: Get parameter from jsp
        String rawPostId = request.getParameter("postid");
        String rawTitle = request.getParameter("post_title");
        String rawCateId = request.getParameter("cateid");
        String rawAuthorName = request.getParameter("author");
        String rawDate = request.getParameter("public_date");
        String rawIsPublic = request.getParameter("ispubic");
        
        int postid = Integer.parseInt(rawPostId);
        String title = rawTitle;
        int cateid = Integer.parseInt(rawCateId);
        String author = rawAuthorName;
        Date publicDate = Date.valueOf(rawDate);
        boolean isPublic = rawIsPublic.equals("1");
        
        // Get course image
        Part img = request.getPart("thumnail");
        InputStream is = img.getInputStream();
        byte[] avt = new byte[is.available()];
        is.read(avt);
        
        //Step 2: Create object
        Category cate = new Category();
        cate.setCate_id(cateid);
        
        Blog b = new Blog();
        b.setBlog_id(postid);
        b.setBlog_title(title);
        b.setCategory(cate);
        b.setAuthor(author);
        b.setPublic_date(publicDate);
        b.setIs_public(isPublic);
        b.setImg(avt);
        
        //Step 3: Update information in database
        PostDBContext postDB = new PostDBContext();
        postDB.updatePost(b);
        
        response.sendRedirect("http://localhost:8080/onlinelearn/authen/marketing/post/insert/content?id="+postid);
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
