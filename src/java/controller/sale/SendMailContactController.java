/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.sale;

import com.google.gson.Gson;
import controller.EmailUtils;

import dal.ContactDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Contact;
import model.Email;


/**
 *
 * @author win
 */
@WebServlet(name = "SendMailContactController", urlPatterns = {"/authen/contact/sendmail"})
public class SendMailContactController extends HttpServlet {



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
        String rawId = request.getParameter("id");
        int id = Integer.parseInt(rawId);
        ContactDBContext cdb = new ContactDBContext();
        Contact c = cdb.getContact(id);
        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();
        map.put("contact", c);

        PrintWriter writer = response.getWriter();
        writer.print(gson.toJson(map));

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
        String rawId = request.getParameter("contactId");
        int id = Integer.parseInt(rawId);
        String name = request.getParameter("name");
        String subject = request.getParameter("subject");
        String email = request.getParameter("email");
        String msg = request.getParameter("msg");

        EmailUtils sendMail = new EmailUtils();
            Email e = new Email();
            e.setFrom("hoaithu1707.25@gmail.com");
            e.setFromPassword("truongthithu");
            e.setTo(email);
            e.setSubject(subject);
            e.setContent("<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
                    + "<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\" xmlns:v=\"urn:schemas-microsoft-com:vml\" lang=\"en\">\n"
                    + "\n"
                    + "    <head>\n"
                    + "\n"
                    + "        <link rel=\"stylesheet\" type=\"text/css\" hs-webfonts=\"true\" href=\"https://fonts.googleapis.com/css?family=Lato|Lato:i,b,bi\">\n"
                    + "            <meta property=\"og:title\" content=\"Email template\">\n"
                    + "\n"
                    + "                <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
                    + "\n"
                    + "                    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
                    + "\n"
                    + "                        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                    + "\n"
                    + "                            <style type=\"text/css\">\n"
                    + "\n"
                    + "                                a{\n"
                    + "                                    text-decoration: underline;\n"
                    + "                                    color: inherit;\n"
                    + "                                    font-weight: bold;\n"
                    + "                                    color: #253342;\n"
                    + "                                }\n   \n"
                    + "                                h1 {\n"
                    + "                                    font-size: 56px;\n"
                    + "        }\n\n"
                    + "                                p {\n"
                    + "                                    font-weight: 100;\n"
                    + "}\n\n"
                    + "                                td {\n"
                    + "                                    vertical-align: top;\n"
                    + "                                                }\n\n"
                    + "                                #email {\n"
                    + "                                    margin: auto;\n"
                    + "                                    width: 600px;\n"
                    + "                                    background-color: white;\n"
                    + "                                  }\n\n"
                    + "                                button{\n"
                    + "                                    font: inherit;\n"
                    + "                                    background-color: #FF7A59;\n"
                    + "                                    border: none;\n"
                    + "                                    padding: 10px;\n"
                    + "                                    text-transform: uppercase;\n"
                    + "                                    letter-spacing: 2px;\n"
                    + "                                    font-weight: 900;\n"
                    + "                                    color: white;\n"
                    + "                                    border-radius: 5px;\n"
                    + "                                    box-shadow: 3px 3px #d94c53;\n"
                    + "                                }\n\n"
                    + "                                .subtle-link {\n"
                    + "                                    font-size: 9px;\n"
                    + "                                    text-transform:uppercase;\n"
                    + "                                    letter-spacing: 1px;\n"
                    + "                                    color: #CBD6E2;\n"
                    + "                                }\n\n"
                    + "                            </style>\n"
                    + "                            </head>\n"
                    + "                            <body bgcolor=\"#F5F8FA\" style=\"width: 100%; margin: auto 0; padding:0; font-family:Lato, sans-serif; font-size:18px; color:#33475B; word-break:break-word\">\n"
                    + "                                <div id=\"email\">\n"
                    + "                                    <table role=\"presentation\" width=\"100%\">\n"
                    + "                                        <tr>\n\n"
                    + "                                            <td bgcolor=\"#00A4BD\" align=\"center\" style=\"color: white;\">\n"
                    + "                                                <div class=\"col-lg-3 d-none d-lg-block logo\">\n"
                    + "                                                    <h1 class=\"m-0\"><span class=\"text-primary\"style=\"color: #FF7A59\">E</span>COURSE</h1>\n"
                    + "                                                </div>                                              \n"
                    + "                                            </td>\n"
                    + "                                    </table>"
                    + "                                    <table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"10px\" style=\"padding: 30px 30px 30px 60px;\">\n"
                    + "                                        <tr>"
                    + "                                            <td>"
                    + "                                                <h2>Xin Chào "+name+"!</h2>\n"
                    + "                                                <p>  "
                    + "                                                    "+msg+" \n"
                    + "                                                </p>  "
                    + "                                            </td> "
                    + "                                        </tr>\n"
                    + "                                    </table> "
                    + "                                </div>\n"
                    + "                            </body>\n"
                    + "                            </html>");
            try {
                sendMail.send(e);
            } catch (Exception ex) {
                Logger.getLogger(SendMailContactController.class.getName()).log(Level.SEVERE, null, ex);
            }
        ContactDBContext cdb = new ContactDBContext();
        cdb.updateStatus(id);
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
