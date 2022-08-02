/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.feature;

import com.google.gson.Gson;
import dal.FeatureDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Feature;
import model.Group;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "EditFeatureController", urlPatterns = {"/authen/manage/feature/edit"})
public class EditFeatureController extends HttpServlet {

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

        int featureId = Integer.parseInt(request.getParameter("featureId"));

        FeatureDBContext fdb = new FeatureDBContext();
        Feature feature = fdb.getFeature(featureId);

        Gson gson = new Gson();

        HashMap<String, Object> map = new HashMap<>();
        map.put("feature", feature);

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

        FeatureDBContext fdb = new FeatureDBContext();

        int featureId = Integer.parseInt(request.getParameter("featureId"));
        String url = request.getParameter("url");
        String description = request.getParameter("description");

        String[] groupIds = request.getParameterValues("group");
        ArrayList<Group> groups = new ArrayList<>();

        if (groupIds != null) {
            for (String groupId : groupIds) {
                int id = Integer.parseInt(groupId);
                Group group = new Group(id);
                groups.add(group);
            }
        }

        Feature feature = new Feature(featureId, url, description, groups);

        fdb.updateFeature(feature);
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
