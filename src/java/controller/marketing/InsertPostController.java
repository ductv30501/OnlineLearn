/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import com.google.gson.Gson;
import dal.PostDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Block;
import model.Blog;
import model.Category;
import model.Tag;
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "InsertPostController", urlPatterns = {"/authen/marketing/post/insert"})
public class InsertPostController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

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
        
        //init db context
        PostDBContext postDB = new PostDBContext();
        UserDBContext userDB = new UserDBContext();
        
        //get all marketing in db
        ArrayList<User> authors = userDB.getAuthors();
        request.setAttribute("authors", authors);
        
        //get all category
        ArrayList<Category> categories = postDB.getCategories();
        request.setAttribute("categories", categories);
        
        //get all tag
        ArrayList<Tag> tags = postDB.getTags();
        request.setAttribute("tags", tags);
              
        request.getRequestDispatcher("../../../view/dynamic/authen/manage/blog/insert.jsp").forward(request, response);
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
        
        //Step 1: get blog information
        String rawPostTitle = request.getParameter("post_title");
        String rawCateId = request.getParameter("cateid");
        String rawAuthor = request.getParameter("author");
        String rawPublicDate = request.getParameter("public_date");
        
        //Process blog infor
        String postTitle = rawPostTitle;
        int cateId = Integer.parseInt(rawCateId);
        String author = rawAuthor;
        Date publicDate = Date.valueOf(rawPublicDate);
        
        //Get thumbnail image
        Part img = request.getPart("thumnail");
        InputStream is = img.getInputStream();
        byte[] avt = new byte[is.available()];
        is.read(avt);
        
        //Step 2: get blog category
        Category cate = new Category();
        cate.setCate_id(cateId);
        
        //Step 3: Create new post
        Blog b = new Blog();
        b.setBlog_title(postTitle);
        b.setCategory(cate);
        b.setAuthor(author);
        b.setPublic_date(publicDate);
        b.setIs_public(false);
        b.setImg(avt);
        
        //Step 4: insert new post to database
        PostDBContext postDB = new PostDBContext();
        postDB.insertBlog(b);
        
        //Step 5: Get parameters from jsp
        //Step 5: Get the blog just add in db
        Blog currentBlog = postDB.getCurrentPost();
        
        response.sendRedirect("http://localhost:8080/onlinelearn/authen/marketing/post/insert/content?id="+currentBlog.getBlog_id());
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
