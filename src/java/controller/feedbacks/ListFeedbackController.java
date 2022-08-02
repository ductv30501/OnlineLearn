/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedbacks;

import dal.FeedbackDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Feedback;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ListFeedbackController", urlPatterns = {"/authen/feedback/list"})
public class ListFeedbackController extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListFeedbackController</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListFeedbackController at " + request.getContextPath() + "</h1>");
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
        FeedbackDBContext fdb = new FeedbackDBContext();
        String rawSearchKey = request.getParameter("search");
        String rawSizePage = request.getParameter("sizePage");
        String rawPage = request.getParameter("page");

        if (rawSearchKey == null) {
            rawSearchKey = "";
        }
        if(rawPage==null) rawPage="1";
        if(rawSizePage==null) rawSizePage="5";


        int sizePage = Integer.parseInt(rawSizePage);
        int page = Integer.parseInt(rawPage);

        request.setAttribute("search", rawSearchKey);
        request.setAttribute("sizePage", sizePage);
        request.setAttribute("page", page);
        ArrayList<Feedback> listFeedback = fdb.getAllFeedback(rawSearchKey, sizePage, page);

        int sizeListFeedback = fdb.getFeedbacks().size();
        int totalPage =0;
        // get total page
        if(sizeListFeedback%sizePage!=0){
            totalPage = sizeListFeedback/sizePage +1;
        }else{
            totalPage = sizeListFeedback/sizePage;
        }
        if(totalPage<page){
            page=1;
        }
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("sizeListFeedback", sizeListFeedback);
        request.setAttribute("listFeedback", listFeedback);
        request.getRequestDispatcher("../../view/dynamic/authen/manage/feedback/list.jsp").forward(request, response);
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
