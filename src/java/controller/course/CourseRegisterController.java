/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import com.google.gson.Gson;
import dal.CourseDBContext;
import dal.PricePackageDBContext;
import dal.UserCourseDBContext;
import dal.UserPackageDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Notification;
import model.PricePackage;
import model.User;
import model.UserPackage;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CourseRegisterController", urlPatterns = {"/course-register"})
public class CourseRegisterController extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        HttpServletRequest req = (HttpServletRequest) request;
        //get user from session
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        //get courseID , user click to button (ID of course click)
        int courseID = Integer.parseInt(request.getParameter("courseID"));
        CourseDBContext cdb = new CourseDBContext();
        String courseTitle = cdb.getCourseNameByID(courseID);
        //price package
        PricePackageDBContext pdb = new PricePackageDBContext();
        ArrayList<PricePackage> pricePackages = pdb.getPackages();
        //set attribute
        request.setAttribute("courseTitle", courseTitle);
        request.setAttribute("courseID", courseID);
        request.setAttribute("user", user);
        request.setAttribute("pricePackage", pricePackages);
        //end old code
        //start new code
        UserPackageDBContext upDB = new UserPackageDBContext();
        UserPackage userPackage = upDB.getUserPackageByUsername(user.getUsername());
        String note = "";
        PrintWriter writer = response.getWriter();

        Gson gson = new Gson();

        HashMap<String, Object> map = new HashMap<>();
        // user have user package
        if (userPackage != null) {
            if (userPackage.isStatus()) {
                UserCourseDBContext ucDB = new UserCourseDBContext();
                ucDB.insertUserCourse(courseID,user.getUsername());
                //return course list
                response.sendRedirect("authen/course/mycourse");
            }else{
                note = "Gói ưu đãi của bạn chưa được duyệt hoặc bạn chưa thanh toán!";
                request.setAttribute("note", note);
                request.getRequestDispatcher("user/course").forward(request, response);
            }
        }else{

            request.setAttribute("status", "false");
             request.getRequestDispatcher("pricing").forward(request, response);
            //response.sendRedirect("../pricing");
        }

    }
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
