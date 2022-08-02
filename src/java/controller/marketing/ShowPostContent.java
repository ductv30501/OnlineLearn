/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.marketing;

import dal.CourseDBContext;
import dal.PostDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Block;
import model.Blog;
import model.Category;
import model.Tag;
import model.Topic;
import model.User;
import model.UserPost;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "ShowPostContent", urlPatterns = {"/blog/content"})
public class ShowPostContent extends HttpServlet {

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
        
        //Step 1: Get Post id
        String rawPostId = request.getParameter("pid");
        int postId = Integer.parseInt(rawPostId);
        
        //step 2: Get Block list by post id
        PostDBContext postDB = new PostDBContext();
        TopicDBContext tdb = new TopicDBContext();
        
        ArrayList<Block> blocks = postDB.getBlocksByPostId(postId);
        request.setAttribute("blocks", blocks);
        
        //Step 3: Get Post by id
        Blog blog = postDB.getPostById(postId);
        request.setAttribute("blog", blog);
        
        //Step 4: Get Categories
        ArrayList<Category> categories = postDB.getCategories();
        request.setAttribute("categories", categories);
        
        //Step 5: Get Recentt post
        ArrayList<Blog> recentsBlog = postDB.getTopRecentPost();
        request.setAttribute("recents", recentsBlog);
        
        //Step 6: Get user-post comment
        ArrayList<UserPost> comments = postDB.getComment(postId);
        request.setAttribute("comments", comments);
        int totalComment = comments.size();
        request.setAttribute("totalComment", totalComment);
        
        //Step 7: Get tag list by postId
        ArrayList<Tag> tags = postDB.getTagsByPostID(postId);
        request.setAttribute("tags", tags);
        
        //Step 8: get author's information
        UserDBContext userDB = new UserDBContext();
        User author = userDB.getUser(blog.getAuthor());
        ArrayList<Topic> topics = tdb.getTopics();
        
        request.setAttribute("author", author);
        request.setAttribute("topics", topics);
        
        
        request.getRequestDispatcher("../view/dynamic/authen/manage/blog/showpost.jsp").forward(request, response);
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
