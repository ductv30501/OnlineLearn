/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.user;

import controller.EmailUtils;
import dal.FeatureDBContext;
import dal.UserDBContext;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Email;
import model.Group;
import model.User;

/**
 *
 * @author Admin
 */
@WebServlet(name = "InsertUserController", urlPatterns = {"/authen/manage/user/insert"})
public class InsertUserController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InsertUserController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InsertUserController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("utf-8");

        UserDBContext userDB = new UserDBContext();

        String username = request.getParameter("username");
        String address = request.getParameter("address");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String rawRole = request.getParameter("role");
        String rawDob = request.getParameter("dob");
        String rawGender = request.getParameter("gender");
        String rawStatus = request.getParameter("status");

        int role = Integer.parseInt(rawRole);
        //process dob
        Date dob = null;
        if (rawDob != null && !rawDob.equals("")) {
            dob = Date.valueOf(rawDob);
        }
        //process gender
        String displayGender = "Nữ";
        boolean gender = false;
        if (rawGender.equals("true")) {
            gender = true;
            displayGender = "Nam";
        }

        //process status
        boolean status = false;
        if (rawStatus.equals("1")) {
            status = true;
        }

        //Generate random password
        String password = GetRandomPass(8);

        String notification = "";
        //check email is existed or not
        if (userDB.checkExistEmail(email)) {
            notification = "1";
            response.getWriter().write(notification);
        } //check username existed or not
        else if (userDB.checkExistUsername(username)) {
            notification = "0";
            response.getWriter().print(notification);
        } else {

            User user = new User();
            user.setUsername(username);
            user.setPassword(password);
            user.setName(name);
            user.setEmail(email);
            user.setPhone(phone);
            user.setAvatar("https://res.cloudinary.com/dttzqtaiq/image/upload/v1657121488/avatar/default_bjpgxv.png");
            user.setPublicId("avatar/default_bjpgxv.png");
            user.setDob(dob);
            user.setGender(gender);
            user.setStatus(status);
            user.setAddress(address);
            user.setGroup(new Group(role));

            //insert to db
            userDB.insertUser(user);
            

            EmailUtils sendMail = new EmailUtils();
            Email e = new Email();
            e.setFrom("lamnthe150456@fpt.edu.vn");
            e.setFromPassword("lamperuz362533");
            e.setTo(email);
            e.setSubject("Xin chào! " + name + ", hãy kiểm tra thông tin tài khoản");
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
                    + "                                                <h2> Thông tin người dùng:</h2>\n"
                    + "                                                <p>  "
                    + "                                                    Tên tài khoản: " + username + "\n"
                    + "                                                </p>  "
                    + "                                                <p>    "
                    + "                                                    Mật khẩu: " + password + "\n"
                    + "                                                </p>       "
                    + "                          <p>          "
                    + "                                                    Họ và tên: " + name + "\n"
                    + "                                                </p>"
                    + "                                                <p>"
                    + "                                                    Ngày sinh: " + dob + "\n"
                    + "                                                </p>"
                    + "                                                <p>"
                    + "                                                    Số điện thoại: " + phone + "\n"
                    + "  </p> "
                    + "                                                <p> "
                    + "                                                    Giới tính: " + displayGender + "\n"
                    + "                                                </p> "
                    + "                                                <p> "
                    + "                                                    Địa chỉ: " + address + "\n"
                    + "                                                </p> "
                    + "                                            </td> "
                    + "                                        </tr>\n"
                    + "                                    </table> "
                    + "                                </div>\n"
                    + "                            </body>\n"
                    + "                            </html>");
            try {
                sendMail.send(e);
            } catch (Exception ex) {
                Logger.getLogger(InsertUserController.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

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

    public String GetRandomPass(int n) {

        // chose a Character random from this String
        String randomPass = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
                + "0123456789"
                + "abcdefghijklmnopqrstuvxyz";

        // create StringBuilder size of Random pass
        StringBuilder sb = new StringBuilder(n);

        for (int i = 0; i < n; i++) {

            // generate a random number between
            // 0 to RandomPass variable length
            int index = (int) (randomPass.length() * Math.random());

            // add Character one by one in end of sb
            sb.append(randomPass.charAt(index));
        }

        return sb.toString();
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
