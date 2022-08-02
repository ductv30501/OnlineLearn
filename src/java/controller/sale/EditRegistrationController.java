/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.sale;

import dal.PricePackageDBContext;
import dal.UserDBContext;
import dal.UserPackageDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.User;
import model.UserPackage;

/**
 *
 * @author Admin
 */
    @WebServlet(name = "EditRegistrationController", urlPatterns = {"/authen/sale/registration/edit"})
public class EditRegistrationController extends HttpServlet {


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
        // Step 1: Get package id 
        String username = request.getParameter("id");
        int packageID = Integer.parseInt(request.getParameter("packageID"));
        // Step 2: Get user package by its id 
        UserPackageDBContext userPackage = new UserPackageDBContext();
        UserPackage userPack = userPackage.getUserPackageByUsername(username,packageID);
        // Step 3: Get user package detail
        String userPackageDetail = "";
        userPackageDetail += userPack.getUsername() +"|";
        userPackageDetail += userPack.getEmail() +"|";
        userPackageDetail += userPack.getRegistration_date() +"|";
        userPackageDetail += userPack.getPackageTitle() +"|";
        userPackageDetail += userPack.getTotal_price() +"|";
        userPackageDetail += userPack.getValid_from() +"|";
        userPackageDetail += userPack.getValid_to() +"|";
        userPackageDetail += userPack.getLastUpdateBy() +"|";
        if (userPack.isStatus()) {
            userPackageDetail += "active" + "|";
        } else {
            userPackageDetail += "non-active" + "|";
        }
        userPackageDetail += packageID +"|";
        // Step 4: Return price package detail
        PrintWriter writer = response.getWriter();
        writer.write(userPackageDetail);
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
        // Step 1: Get value from user
        String userId = request.getParameter("userId");
        String email = request.getParameter("email").trim();
        String rawRegistrationDate = request.getParameter("registration_date").trim();
        String packageTitle = request.getParameter("package_title").trim();
        String rawTotalPrice = request.getParameter("total_price").trim();
        String rawValidFrom = request.getParameter("valid_from").trim();
        String rawValidTo = request.getParameter("valid_to").trim();
        String editBy = request.getParameter("editBy").trim();
        String rawStatus = request.getParameter("status").trim();
        int packageID = Integer.parseInt(request.getParameter("packageID"));
        // Step 2: Convert
        float price = Float.parseFloat(rawTotalPrice);
        Date registrationDate = Date.valueOf(rawRegistrationDate);
        Date validFrom = Date.valueOf(rawValidFrom);
        Date validTo = Date.valueOf(rawValidTo);
        Boolean status = true;

        if (rawStatus.equals("active")) {
            status = true;
        }else{
            status = false;
        }
        UserPackageDBContext userPackageDB = new UserPackageDBContext();
        UserPackage userPack = userPackageDB.getUserPackageByUsername(userId,packageID);
        //check sale update or not (follow status)
        if (status != userPack.isStatus()) {
            //get user from session
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            editBy = user.getName();
        }
        // Step 3: Create user package object
        
        UserPackage userPackage = new UserPackage(userId, email,0, registrationDate, 
                packageTitle, price, status, validFrom, validTo, editBy);
        
        // Step 4: update user package to database
        
        UserPackageDBContext uPDB = new UserPackageDBContext();
        uPDB.editUserPackage(userPackage,packageID);
        
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
