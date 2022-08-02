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
import javax.servlet.http.HttpSession;
import model.Course;
import model.Feedback;
import model.Notification;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "EditFeedbackController", urlPatterns = {"/authen/feedback/edit"})
public class EditFeedbackController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        String rawStars = request.getParameter("stars");
        String rawFeedbackId = request.getParameter("feedbackId");

        int stars = Integer.parseInt(rawStars);
        int feebackId = Integer.parseInt(rawFeedbackId);
        String rawCourseId = request.getParameter("courseId");
        int courseId = Integer.parseInt(rawCourseId);
        String msg = request.getParameter("message");
        if (msg == null) {
            msg = "";
        }

        FeedbackDBContext fdb = new FeedbackDBContext();
        Feedback f = new Feedback();
        f.setFeedbackContent(msg);
        f.setStars(stars);
        Course c = new Course();
        c.setCourseId(courseId);
        f.setCourse(c);
        f.setUser(user);
        f.setFeedbackId(feebackId);

        fdb.updateFB(f);

        Notification n1 = new Notification("success", "Thông báo", "Chỉnh sửa thành công", true);

        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();
        map.put("notification", n1);

        PrintWriter writer = response.getWriter();
        writer.print(gson.toJson(map));
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
