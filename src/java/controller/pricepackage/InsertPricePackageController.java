/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.pricepackage;

import dal.PricePackageDBContext;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.PricePackage;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "InsertPricePackageController", urlPatterns = {"/authen/manage/package/insert"})
public class InsertPricePackageController extends HttpServlet {

 

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
        // Step 1: Get value from user
        String packageTitle = request.getParameter("title").trim();
        String rawDrice = request.getParameter("price").trim();
        String rawDuration = request.getParameter("duration").trim();
        String durationType = request.getParameter("durationType").trim();
        String rawBenefits = request.getParameter("benefits").trim();
        rawBenefits = rawBenefits.replaceAll("\\s+", " ");

        String rawStatus = request.getParameter("status").trim();
        
        // Step 2: Convert to valid value
        float price = Float.parseFloat(rawDrice);
        int duration = Integer.parseInt(rawDuration);
        Boolean status = true;
        
        if(rawStatus.equals("private")) {
            status = false;
        }
        
        // Step 3: Create price package object
        PricePackage pack = new PricePackage(packageTitle, price, 
                duration, durationType, rawBenefits, status);
        
        // Step 4: Insert new price package to database
        PricePackageDBContext pdb = new PricePackageDBContext();
        pdb.insertPackage(pack);
        
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
