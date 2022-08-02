/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.slider;

import com.google.gson.Gson;
import dal.SliderDBContext;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Slider;

/**
 *
 * @author ADMIN
 */
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)

@WebServlet(name = "EditSliderController", urlPatterns = {"/authen/manage/slider/edit"})
public class EditSliderController extends HttpServlet {

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
        SliderDBContext sdb = new SliderDBContext();

        int sliderId = Integer.parseInt(request.getParameter("sliderId"));

        Slider slider = sdb.getSlider(sliderId);

        Gson gson = new Gson();

        HashMap<String, Object> map = new HashMap<>();
        map.put("slider", slider);

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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        SliderDBContext sdb = new SliderDBContext();

        // Step 1: Get value from user
        Part part = request.getPart("sliderImg");
        InputStream in = part.getInputStream();
        byte[] silderImg = new byte[in.available()];
        in.read(silderImg);

        int sliderId = Integer.parseInt(request.getParameter("sliderId"));
        String sliderTitle = request.getParameter("sliderTitle");
        String sliderContent = request.getParameter("sliderContent");
        Boolean status = Boolean.parseBoolean(request.getParameter("status"));
        
        Slider slider = new Slider(sliderId, sliderTitle, sliderContent, 
                silderImg, status);

        sdb.updateSlider(slider);

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
