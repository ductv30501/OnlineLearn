/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.BillDBContext;
import dal.TopicDBContext;
import dal.UserCourseDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Bill;
import model.Topic;
import model.User;
import model.UserCourse;
import model.UserPackage;

/**
 *
 * @author Admin
 */
@WebServlet(name = "UserCourseController", urlPatterns = {"/user/package"})
public class UserCourseController extends HttpServlet {

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
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();

        BillDBContext bdb = new BillDBContext();

        HttpSession session = request.getSession();
        User account = (User) session.getAttribute("user");
        UserCourseDBContext ucdb = new UserCourseDBContext();
        
        ArrayList<Bill> bills = bdb.getBills(account.getUsername());
        
        String rawPage = request.getParameter("page");
        if (rawPage == null || rawPage.trim().length() == 0) {
            rawPage = "1";
        }
        int pageindex = Integer.parseInt(rawPage);
        int pagesize = 6;
        UserPackage pp = ucdb.getUserPackageByUserName(account.getUsername(), pageindex, pagesize);
        int totalrecords = ucdb.count(account.getUsername());
        int totalpage = (totalrecords % pagesize == 0) ? totalrecords / pagesize
                : (totalrecords / pagesize) + 1;
        request.setAttribute("package", pp);
        request.setAttribute("totalpage", totalpage);
        request.setAttribute("pageindex", pageindex);
        request.setAttribute("pagesize", pagesize);
        request.setAttribute("topics", topics);
        request.setAttribute("bills", bills);
        request.getRequestDispatcher("../view/dynamic/user/user-package.jsp").forward(request, response);
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
