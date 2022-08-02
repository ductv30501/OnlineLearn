/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.pricepackage;

import dal.PricePackageDBContext;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "EditPricePackageController", urlPatterns = {"/authen/manage/package/edit"})
public class EditPricePackageController extends HttpServlet {

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
        // Step 1: Get package id 
        String rawPackageId = request.getParameter("id");
        int packageId = Integer.parseInt(rawPackageId);

        // Step 2: Get price package by its id 
        PricePackageDBContext pdb = new PricePackageDBContext();
        PricePackage pack = pdb.getPackage(packageId);

        // Step 3: Get price package detail
        String packageDetail = "";
        packageDetail += pack.getPackageId() + "|";
        packageDetail += pack.getPackageTitle() + "|";
        packageDetail += pack.getPrice() + "|";
        packageDetail += pack.getDuration() + "|";
        packageDetail += pack.getDurationtype() + "|";
        String[] benefits = pack.getBenefits();
        for (int i = 0; i < benefits.length; i++) {
            String benefit = "- " + benefits[i];
             packageDetail = packageDetail.concat(benefit);
            if(i != benefits.length - 1) {
             packageDetail = packageDetail.concat("\n");
            }
        }
        packageDetail += "|";
        if (pack.isStatus()) {
            packageDetail += "public" + "|";
        } else {
            packageDetail += "private" + "|";
        }

        // Step 4: Return price package detail
        PrintWriter writer = response.getWriter();
        writer.write(packageDetail);
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
        String rawPackageId = request.getParameter("id");
        String packageTitle = request.getParameter("title").trim();
        String rawDrice = request.getParameter("price").trim();
        String rawDuration = request.getParameter("duration").trim();
        String durationType = request.getParameter("durationType").trim();
        String rawBenefits = request.getParameter("benefits").trim();
        rawBenefits = rawBenefits.replaceAll("\\s+", " ");
       
        String rawStatus = request.getParameter("status").trim();
        // Step 2: Convert
        int packageId = Integer.parseInt(rawPackageId);
        float price = Float.parseFloat(rawDrice);
        int duration = Integer.parseInt(rawDuration);
        Boolean status = true;

        if (rawStatus.equals("private")) {
            status = false;
        }
        // Step 3: Create price package object
        model.PricePackage pack = new model.PricePackage(packageId, packageTitle, 
                price, duration, durationType, rawBenefits, status);

        // Step 4: Insert new price package to database
        PricePackageDBContext pdb = new PricePackageDBContext();
        pdb.editPackage(pack);
        
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
