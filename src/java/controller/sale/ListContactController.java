/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.sale;

import dal.ContactDBContext;
import dal.TopicDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Contact;
import model.Topic;

/**
 *
 * @author win
 */
@WebServlet(name = "ListContactController", urlPatterns = {"/authen/contact/list"})
public class ListContactController extends HttpServlet {

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
            out.println("<title>Servlet ListContactController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListContactController at " + request.getContextPath() + "</h1>");
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
        ContactDBContext cdb = new ContactDBContext();
        String rawSearchKey = request.getParameter("search");
        String rawSizePage = request.getParameter("sizePage");
        String rawPage = request.getParameter("page");
        String rawsStatus = request.getParameter("status");

        if (rawSearchKey == null) {
            rawSearchKey = "";
        }
        if (rawPage == null) {
            rawPage = "1";
        }
        if (rawSizePage == null) {
            rawSizePage = "5";
        }
        if (rawsStatus == null) {
            rawsStatus = "-1";
        }

        int sizePage = Integer.parseInt(rawSizePage);
        int page = Integer.parseInt(rawPage);
        int status = Integer.parseInt(rawsStatus);

        ArrayList<Contact> contacts = cdb.getContactsBySearch(page, sizePage, rawSearchKey, status);

        int sizeListContact = contacts.size();
        int totalPage = 0;
        // get total page
        if (sizeListContact % sizePage != 0) {
            totalPage = sizeListContact / sizePage + 1;
        } else {
            totalPage = sizeListContact / sizePage;
        }
        if (totalPage < page) {
            page = 1;
        }
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("sizeListContact", sizeListContact);

        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();
        request.setAttribute("topics", topics);
        request.setAttribute("contacts", contacts);
        request.setAttribute("search", rawSearchKey);
        request.setAttribute("status", status);
        request.setAttribute("sizePage", sizePage);
        request.setAttribute("page", page);
        request.getRequestDispatcher("../../view/dynamic/authen/manage/contact/list.jsp").forward(request, response);
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
