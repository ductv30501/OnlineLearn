/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.common;

import com.google.gson.Gson;
import dal.ContactDBContext;
import dal.TopicDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Contact;
import model.Notification;
import model.Topic;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ContactController", urlPatterns = {"/contact"})
public class ContactController extends HttpServlet {

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
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Topic> topics = tdb.getTopics();
        request.setAttribute("topics", topics);
        request.getRequestDispatcher("view/dynamic/public/contact.jsp").forward(request, response);
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
         request.setCharacterEncoding("UTF-8");
        String name  = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        String phone = request.getParameter("phone");
        Contact c = new Contact();
        c.setName(name);
        c.setEmail(email);
        c.setMessage(message);
        c.setPhone(phone);
        c.setSubject(subject);
        ContactDBContext cdb = new ContactDBContext();
        boolean check = cdb.insert(c);
        Notification n1;
        if(check) {
            n1 = new Notification("success", "Thông báo", "Gửi thông tin thành công", true);
        }
        else{
            n1 = new Notification("error", "Thông báo", "Gửi thông tin không thành công", true);
        }
        // Convert to json 
        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();
        map.put("notification", n1);
        
       PrintWriter writer = response.getWriter();
       writer.print(gson.toJson(map));
    
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
