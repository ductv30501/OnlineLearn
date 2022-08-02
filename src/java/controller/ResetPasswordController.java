/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ResetPasswordController", urlPatterns = {"/reset/password"})
public class ResetPasswordController extends HttpServlet {

    

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
        String username = (String) request.getAttribute("username");
        UserDBContext userDB = new UserDBContext();
        User user = userDB.getUser(username);
        request.setAttribute("user", user);
        request.getRequestDispatcher("../view/dynamic/access/reset-password.jsp").forward(request, response);
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
        
        String username = request.getParameter("username");
        String newpass = request.getParameter("newpass");
        String renewpass = request.getParameter("renewpass");
        UserDBContext uc = new UserDBContext();

        if ((newpass.equals(renewpass))) {
            uc.ChangePass(username, newpass);
            request.setAttribute("message", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("../view/dynamic/access/reset-password.jsp").forward(request, response);
        }else{
            request.setAttribute("message", "Mật khẩu mới và mật khẩu nhắc lại không trùng nhau!");
            request.getRequestDispatcher("../view/dynamic/access/reset-password.jsp").forward(request, response);
        }
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
