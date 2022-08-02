/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import dal.CourseDBContext;
import dal.PricePackageDBContext;
import dal.UserCourseDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.PricePackage;
import model.User;
import model.UserCourse;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditCourseRegistedController", urlPatterns = {"/courseregisted/update"})
public class EditCourseRegistedController extends HttpServlet {

    
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
         HttpServletRequest req = (HttpServletRequest) request;

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        CourseDBContext cdb = new CourseDBContext();
        String courseTitle = cdb.getCourseNameByID(courseID);
        
        PricePackageDBContext pdb = new PricePackageDBContext();
        ArrayList<PricePackage> pricePackages = pdb.getPackages();
        request.setAttribute("pricePackage", pricePackages);
        
        request.setAttribute("courseTitle", courseTitle);
        request.setAttribute("courseID", courseID);
        request.setAttribute("user", user);
        request.getRequestDispatcher("../view/dynamic/user/learner/updatecourseRegisted.jsp").forward(request, response);
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
