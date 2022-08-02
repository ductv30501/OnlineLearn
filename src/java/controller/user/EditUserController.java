/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import com.google.gson.Gson;
import dal.FeatureDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Group;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditUserController", urlPatterns = {"/authen/manage/user/edit"})
public class EditUserController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");

        String username = request.getParameter("username");
        UserDBContext uc = new UserDBContext();

        User user = uc.getUserForEdit(username);
        
        FeatureDBContext fdb = new FeatureDBContext();
        ArrayList<Group> groups = fdb.getGroups();

        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();
        map.put("user", user);
        map.put("avatar", user.getAvatar());
        map.put("groups", groups);
        
        
        if (user.getDob() != null) {
            SimpleDateFormat date = new SimpleDateFormat("dd/MM/yyyy");
            map.put("dob", date.format(user.getDob()));
        }
        response.getWriter().write(gson.toJson(map));

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

        // Get Data
        String username = request.getParameter("username");
        String rawGroup = request.getParameter("group");
        String rawStatus = request.getParameter("status");

        Boolean status = false;
        if (rawStatus.equals("1")) {
            status = true;
        } 
        
        int group = Integer.parseInt(rawGroup);

        UserDBContext udb = new UserDBContext();
        udb.changeStatus(status, username);
        FeatureDBContext fc = new FeatureDBContext();
        fc.updateUserGroup(group, username);

        response.sendRedirect("list");
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
