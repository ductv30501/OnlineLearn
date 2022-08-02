/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import dal.BlogDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Blog;
import model.Category;
import model.Group;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "BlogController", urlPatterns = {"/blog"})
public class BlogController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");

        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();
        //get user in session
        String url = "";

        // get paramenter
        String searchKey = request.getParameter("search");
        String rawCateId = request.getParameter("cate");
        String rawTagId = request.getParameter("tag");
        String rawPage = request.getParameter("page");

        //DB Context
        BlogDBContext bdb = new BlogDBContext();
        //check search, cate_id,tag_id,page null or not?
        if (searchKey == null) {
            searchKey = "";
        }
        if (rawCateId == null) {
            rawCateId = "-1";
        }
        if (rawTagId == null) {
            rawTagId = "-1";
        }
        if (rawPage == null) {
            rawPage = "1";
        }
        // get current page
        int size = 6;
        int totalPage = 0;
        int currentPage = Integer.parseInt(rawPage);
        int cate = Integer.parseInt(rawCateId);
        int tag = Integer.parseInt(rawTagId);
        // list of blogs searched by search, cate_id, tag_id at current page
        ArrayList<Blog> listBlog = bdb.getSearchBlogByAll(searchKey, cate, tag, size, currentPage);
        // total page
        if (bdb.countTotaltBlog() % size != 0) {
            totalPage = bdb.countTotaltBlog() / size;
            totalPage += 1;
        } else {
            totalPage = bdb.countTotaltBlog() / size;
        }

        request.setAttribute("totalPage", totalPage);
        request.setAttribute("page", currentPage);
        request.setAttribute("search", searchKey);
        request.setAttribute("cate", rawCateId);
        request.setAttribute("tag", rawTagId);
        request.setAttribute("listBlog", listBlog);
        request.setAttribute("topics", topics);

        // get list categories, list lastestBlog
        ArrayList<Category> listCategories = bdb.getCategory();
        ArrayList<Blog> listLatestBlog = bdb.getLatestBlog();

        request.setAttribute("listCategories", listCategories);
        request.setAttribute("listLatestBlog", listLatestBlog);
        url = "view/dynamic/public/blog.jsp";

        request.getRequestDispatcher(url).forward(request, response);

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
