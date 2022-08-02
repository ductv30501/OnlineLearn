/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import dal.PostDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
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
import model.User;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 5, 
        maxRequestSize = 1024 * 1024 * 50,
        fileSizeThreshold = 1024 * 1024 * 10)
@WebServlet(name = "InsertPostContent", urlPatterns = {"/authen/marketing/post/insert/content"})
public class BlockContentController extends HttpServlet {

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
        
        String rawId = request.getParameter("id");
        int pid = Integer.parseInt(rawId);
        request.setAttribute("pid", pid);
        
        //Step 1: Get post by id
        PostDBContext postDB = new PostDBContext();
        Blog blog = postDB.getPostById(pid);
        request.setAttribute("blog", blog);
        
        //Step 2: Get Block list of this post
        ArrayList<Block> blocks = postDB.getBlocksByPostId(pid);
        request.setAttribute("blocks", blocks);
        
        //Step 3: get all category
        ArrayList<Category> categories = postDB.getCategories();
        request.setAttribute("categories", categories);
        
        //Step 4: get all marketing in db
        UserDBContext userDB = new UserDBContext();
        ArrayList<User> authors = userDB.getAuthors();
        request.setAttribute("authors", authors);
        
        request.getRequestDispatcher("../../../../view/dynamic/authen/manage/blog/content.jsp").forward(request, response);
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
        PostDBContext postDB = new PostDBContext();
        
        //Step 1: Get parameters from jsp
        String heading = request.getParameter("heading");
        String content = request.getParameter("insert-content");
        String quote = request.getParameter("quote");
        String rawPostId = request.getParameter("postid");
        int postid = Integer.parseInt(rawPostId);

        //Step 2: Create a block
        Block block = new Block();
        block.setHeading(heading);
        block.setContent(content);
        block.setQuote(quote);

        Blog blog = new Blog();
        blog.setBlog_id(postid);

        block.setBlog(blog);
        //Step 3: Insert Block to db
        postDB.InsertBlock(block);
        response.sendRedirect("http://localhost:8080/onlinelearn/authen/marketing/post/insert/content?id="+postid);
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
