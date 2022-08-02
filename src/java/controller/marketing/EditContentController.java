/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import dal.PostDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Block;
import model.Blog;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(
        maxFileSize = 1024 * 1024 * 5, 
        maxRequestSize = 1024 * 1024 * 50,
        fileSizeThreshold = 1024 * 1024 * 10)


@WebServlet(name = "EditContentController", urlPatterns = {"/authen/marketing/post/content/edit"})
public class EditContentController extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");
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
        String rawBlockId = request.getParameter("bid");
        int blockId = Integer.parseInt(rawBlockId);
        String heading = request.getParameter("heading");
        String content = request.getParameter("content"+blockId);
        String quote = request.getParameter("quote");
        String rawPostId = request.getParameter("postId");
        int postId = Integer.parseInt(rawPostId);

        //Step 2: Set block with new values
        Block block = new Block();
        block.setBlock_id(blockId);
        block.setHeading(heading);
        block.setContent(content);
        block.setQuote(quote);
        
        Blog blog = new Blog();
        blog.setBlog_id(postId);
        
        block.setBlog(blog);
        
        //Step 3: Update block
        postDB.UpdateBlock(block);
        response.sendRedirect("http://localhost:8080/onlinelearn/authen/marketing/post/insert/content?id="+postId);
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
