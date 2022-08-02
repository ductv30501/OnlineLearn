/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.topic;

import dal.TopicDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Topic;

/**
 *
 * @author win
 */
@WebServlet(name = "ListTopicController", urlPatterns = {"/authen/manage/topic/list"})
public class ListTopicController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListTopicController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListTopicController at " + request.getContextPath() + "</h1>");
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
        // Step 1: Call DB Context
        TopicDBContext tdb = new TopicDBContext();
        
        // Step 2: Get parameters
        String rawPage = request.getParameter("page");
        String rawSizePage = request.getParameter("sizePage");
        String searchKey = request.getParameter("search");
        
        // Step 3: Convert recieved data to the valid
        if(rawPage==null) rawPage="1";
        if(rawSizePage==null) rawSizePage="5";
        if (searchKey == null) searchKey = "";
        
        int page = Integer.parseInt(rawPage);
        int sizepage = Integer.parseInt(rawSizePage);

        int sizeListTopic = tdb.getTopics().size();
        int totalPage =0;
        // get total page
        if(sizeListTopic%sizepage!=0){
            totalPage = sizeListTopic/sizepage +1;
        }else{
            totalPage = sizeListTopic/sizepage;
        }
        if(totalPage<page){
            page=1;
        }
        
        // Step 4: Get list topics
        ArrayList<Topic> listTopic = tdb.getTopics(searchKey,page,sizepage);
        
        // Step 5: Set request attribute
        request.setAttribute("page", page);
        request.setAttribute("sizePage", sizepage);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("listTopic", listTopic);
        request.setAttribute("sizeListTopic", sizeListTopic);
        
        // Step 5: Send request to list topic jsp page
        request.getRequestDispatcher("../../../view/dynamic/authen/manage/topic/list.jsp").forward(request, response);
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
