/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Email;
import model.Notification;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ForgotPasswordController", urlPatterns = {"/password/forgot"})

public class ForgotPasswordController extends HttpServlet {

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
        request.setCharacterEncoding("utf-8");
        request.getRequestDispatcher("../view/dynamic/access/forgot-password.jsp").forward(request, response);
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
        PrintWriter writer = response.getWriter();

        Gson gson = new Gson();

        HashMap<String, Object> map = new HashMap<>();
        try {
            String emailName = request.getParameter("email");
            UserDBContext userDB = new UserDBContext();
            User user = userDB.getUserByEmail(emailName);
            if (user.getPassword() == null || user.getPassword().length() == 0) {

                Notification n1 = new Notification("warning", "Thông báo", "Email không tồn tại", false);

                map.put("notify", n1);

            } else {
                Email email = new Email();
                email.setFrom("ductvhe151448@fpt.edu.vn");
                email.setFromPassword("khongnoi123");
                email.setTo(emailName);
                email.setSubject("Forgot Password");
                String message = "<!DOCTYPE html>\n"
                        + "<html lang=\"en\">\n"
                        + "\n"
                        + "<head>\n"
                        + "</head>\n"
                        + "\n"
                        + "<body>\n"
                        + "    <h3 style=\"color: blue;\">Để cập nhật mật khẩu mới vui lòng bấm vào đường link dưới đây</h3>\n"
                        + "    <a  href=\"http://localhost:8080/onlinelearn/reset/password?username=" + user.getUsername() + "\">tạo mật khẩu mới</a>\n"
                        + "    <div>Người gửi :Admin</div>\n"
                        + "    <div>số điện thoại : 0899999999</div>\n"
                        + "    <div>địa chỉ : Hoa Lac, Ha Noi</div>\n"
                        + "    <h3 style=\"color: blue;\">Cảm ơn bạn đã sử dụng dịch vụ của chúng tôi!</h3>\n"
                        + "\n"
                        + "</body>\n"
                        + "\n"
                        + "</html>";
                email.setContent(message);
                EmailUtils.send(email);
                Notification n2 = new Notification("warning", "Thông báo", "Gửi thông báo thành công, Hãy kiểm tra email của bạn", false);
                map.put("notify", n2);
            }
        } catch (Exception e) {
            e.printStackTrace();

            request.setAttribute("message", e.getMessage());
        }

        writer.write(gson.toJson(map));

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
