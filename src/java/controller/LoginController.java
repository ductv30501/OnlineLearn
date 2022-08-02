/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Group;
import model.Notification;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "LoginController", urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");

        ServletContext ctx = getServletContext();
        Object status = ctx.getAttribute("notificationStatus");
        if (status != null) {
            ctx.removeAttribute("notificationStatus");
        }
        request.setAttribute("notificationStatus", status);
        request.getRequestDispatcher("view/dynamic/access/login.jsp").forward(request, response);
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");
        String usernameOrEmail = request.getParameter("usernameOrEmail");
        String passwrod = request.getParameter("password");
        String remember = request.getParameter("remember");
        String isCheck = request.getParameter("isCheck");

        ArrayList<Notification> notifications = new ArrayList<>();

        UserDBContext udb = new UserDBContext();
        User user = udb.getUser(usernameOrEmail, passwrod);

        if (user != null) {
            Group userGroup = udb.getUserGroup(user);
            user.setGroup(userGroup);
            //check status of user
            if (!user.isStatus()) {
                Notification n1 = new Notification();
                n1.setType("warning");
                n1.setAutoClose(true);
                n1.setTitle("Cảnh báo");
                n1.setText("Tài khoản của bạn đã bị khoá");
                notifications.add(n1);
            }
            //set session for user
            HttpSession session = request.getSession();

            //add cookie for user
            if (remember != null) {
                Cookie cookieUser = new Cookie("username", user.getUsername());
                Cookie cookiePass = new Cookie("password", passwrod);
                Cookie cookieRemeber = new Cookie("remember", remember);

                cookieUser.setMaxAge(3600 * 24 * 7);
                cookiePass.setMaxAge(3600 * 24 * 7);
                cookieRemeber.setMaxAge(3600 * 24 * 7);

                response.addCookie(cookieUser);
                response.addCookie(cookiePass);
            }

            LocalDate localDate = LocalDate.now();
            Date loginDate = Date.valueOf(localDate);

            if (!udb.checkExitLoginDate(user.getUsername(), loginDate)) {
                udb.insertLoginDate(user.getUsername(), loginDate);
            }
            if (!user.getUsername().equals("admin")) {
                udb.insertActiveUser(user.getUsername());
            }

            session.setAttribute("user", user);

        } else {
            Notification n2 = new Notification();
            n2.setType("warning");
            n2.setAutoClose(true);
            n2.setTitle("Cảnh báo");
            n2.setText("Tài khoản hoặc mật khẩu không chính xác");
            notifications.add(n2);
        }

        HashMap<String, Object> map = new HashMap<>();
        map.put("notifications", notifications);

        Gson gson = new Gson();

        PrintWriter writer = response.getWriter();
        writer.write(gson.toJson(map));

        if (isCheck == null) {
            String url = "home";
            response.sendRedirect(url);
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
