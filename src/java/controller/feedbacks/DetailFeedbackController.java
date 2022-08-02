/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feedbacks;

import com.google.gson.Gson;
import dal.FeedbackDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
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
@WebServlet(name = "DetailFeedbackController", urlPatterns = {"/authen/feedback/detail"})
public class DetailFeedbackController extends HttpServlet {

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
            out.println("<title>Servlet DetailFeedbackController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DetailFeedbackController at " + request.getContextPath() + "</h1>");
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
        // Step 1: Get feedback id 
        String rawId = request.getParameter("id");
        int feedbackId = Integer.parseInt(rawId);

        // Step 2: Get feedback by id
        FeedbackDBContext fdb = new FeedbackDBContext();
        Feedback f = fdb.getFeedback(feedbackId);
        String reply = fdb.getReplyFB(feedbackId);
        if (reply == null || reply == "") {
            reply = "1";
        }
        // Step 3: Get topic detail
        Gson gson = new Gson();

        // Step 4: Create hashmap for coverting to json
        HashMap<String, Object> map = new HashMap<>();
        map.put("feedback", f);
        map.put("course", f.getCourse());
        map.put("topic", f.getCourse().getTopic());
        map.put("user", f.getUser());
        map.put("reply", reply);

//        // Step 5: Return topic detail
        PrintWriter writer = response.getWriter();
        writer.write(gson.toJson(map));
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
