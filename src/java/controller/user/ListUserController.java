/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import dal.FeatureDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Group;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ListUserController", urlPatterns = {"/authen/manage/user/list"})
public class ListUserController extends HttpServlet {

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

        UserDBContext uc = new UserDBContext();
        FeatureDBContext fc = new FeatureDBContext();

        String rawSortTitle = request.getParameter("sortTitle");
        String rawNumber = request.getParameter("number");
        String rawGroup = request.getParameter("group");
        String rawStatus = request.getParameter("status");
        String search = request.getParameter("search");
        String rawIndex = request.getParameter("index");
        
        String group = (rawGroup == null || rawGroup.length() == 0 || rawGroup.equals("-1")) ? "" : rawGroup;
        String status = (rawStatus == null || rawStatus.length() == 0||rawStatus.equals("-1")) ? "" : rawStatus;
        search = (search == null || search.length() == 0) ? "" : search;
        rawIndex = (rawIndex == null || rawIndex.length() == 0) ? "1" : rawIndex;
        rawNumber = (rawNumber == null || rawNumber.length() == 0) ? "5" : rawNumber;
        String[] sortTitle = (rawSortTitle == null || rawSortTitle.length() == 0) ? null : rawSortTitle.split(" ");
        String sort = (sortTitle == null) ? "asc" : sortTitle[0];
        String obj = (sortTitle == null) ? "username" : sortTitle[1];

        int index = Integer.parseInt(rawIndex);
        int number = Integer.parseInt(rawNumber);

        int count = uc.countUser(group, status, search);
        int totalPage = count / number;
        if (count % number != 0) {
            totalPage++;
        }

        ArrayList<User> users = uc.getUsers(group, status, search, index, number, sort, obj);
        ArrayList<Group> groups = fc.getGroups();

        request.setAttribute("sortTitle", sort + " " + obj);
        request.setAttribute("sort", sort);
        request.setAttribute("obj", obj);
        request.setAttribute("number", number);
        request.setAttribute("index", index);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("groups", groups);
        request.setAttribute("users", users);
        request.setAttribute("group", group);
        request.setAttribute("status", status);
        request.setAttribute("search", search);
        request.getRequestDispatcher("../../../view/dynamic/authen/manage/user/list.jsp").forward(request, response);
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
