/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.dashboard;

import com.google.gson.Gson;
import dal.CourseDBContext;
import dal.FeatureDBContext;
import dal.PricePackageDBContext;
import dal.TopicDBContext;
import dal.UserDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Course;
import model.Group;
import model.PricePackage;
import model.Topic;
import model.User;
import model.UserDate;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/authen/dashboard"})
public class AdminDashboardController extends HttpServlet {

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
        request.getRequestDispatcher("../view/dynamic/user/dashboard.jsp").forward(request, response);
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
        UserDBContext udb = new UserDBContext();
        FeatureDBContext fdb = new FeatureDBContext();

        LocalDate today = LocalDate.now();

        Date endDate = Date.valueOf(today);
        Date startDate = Date.valueOf(today.minusDays(7));

        // Total User
        int totalLearner = 0;
        int totalExpert = 0;
        int totalSale = 0;
        int totalMarketing = 0;
        int totalManager = 0;
        int totalAmin = 0;

        ArrayList<User> users = udb.getUsers();
        ArrayList<Group> groups = fdb.getAllGroups();

        int totalUsers = users.size();
        for (Group group : groups) {
            int total = group.getTotalUsers();
            if (group.getName().equals("Học viên")) {
                totalLearner = total;
            }
            if (group.getName().equals("Giảng viên")) {
                totalExpert = total;
            }
            if (group.getName().equals("Bán hàng")) {
                totalSale = total;
            }
            if (group.getName().equals("Tiếp thị")) {
                totalMarketing = total;
            }
            if (group.getName().equals("Quản trị nội dung")) {
                totalManager = total;
            }
            if (group.getName().equals("Admin")) {
                totalAmin = total;
            }
        }

        int deactiveUsers = udb.getTotalDeactiveUsers();

        ArrayList<User> registeredUsers = udb.getTotalRegisterUsers(startDate, endDate);
        ArrayList<User> frequentUsers = udb.getTotalFrequentUsers(startDate, endDate);
        ArrayList<User> activeUsers = udb.getActiveUsers();

        double activeRate = (Double.parseDouble(String.valueOf(activeUsers.size())) / totalUsers);

        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("deactiveUsers", deactiveUsers);
        request.setAttribute("registeredUsers", registeredUsers);
        request.setAttribute("frequentUsers", frequentUsers);
        request.setAttribute("activeUsers", activeUsers);

        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);

        request.setAttribute("totalLearner", totalLearner);
        request.setAttribute("totalExpert", totalExpert);
        request.setAttribute("totalSale", totalSale);
        request.setAttribute("totalMarketing", totalMarketing);
        request.setAttribute("totalManager", totalManager);
        request.setAttribute("totalAmin", totalAmin);
        request.setAttribute("activeRate", activeRate);

        TopicDBContext tdb = new TopicDBContext();
        CourseDBContext cdb = new CourseDBContext();

        int totalTopics = tdb.getTotalTopics();
        int totalCourses = cdb.getTotalCourses();
        int totalExperts = udb.getTotalExperts();
        int totalLearners = udb.getTotalLearners();

        ArrayList<Course> topCourses = cdb.getTopCourses();
        ArrayList<Topic> popularTopics = tdb.getPopularTopics();

        request.setAttribute("totalTopics", totalTopics);
        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("totalExperts", totalExperts);
        request.setAttribute("totalLearners", totalLearners);
        request.setAttribute("topCourses", topCourses);
        request.setAttribute("popularTopics", popularTopics);

        PricePackageDBContext ppdb = new PricePackageDBContext();
        ArrayList<PricePackage> pp = ppdb.getPackages();

        request.setAttribute("totalPricePackages", pp.size());

        request.getRequestDispatcher("../view/dynamic/user/dashboard.jsp").forward(request, response);
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
        Gson gson = new Gson();
        UserDBContext udb = new UserDBContext();
        FeatureDBContext fdb = new FeatureDBContext();

        String searchDuration = request.getParameter("searchDuration");

        LocalDate today = LocalDate.now();

        Date endDate = Date.valueOf(today);
        Date startDate = null;
        if (searchDuration == null) {
            searchDuration = "Từ 7 ngày trước";

        }
        if (searchDuration.equals("Từ 7 ngày trước")) {
            startDate = Date.valueOf(today.minusDays(7));
        }
        if (searchDuration.equals("Từ 2 tuần trước")) {
            startDate = Date.valueOf(today.minusWeeks(2));
        }
        if (searchDuration.equals("Từ 1 tháng trước")) {
            startDate = Date.valueOf(today.minusMonths(1));
        }
        if (searchDuration.equals("Từ 2 tháng trước")) {
            startDate = Date.valueOf(today.minusMonths(2));
        }

        UserDate userLoginDate = new UserDate();
        UserDate userRegisterDate = new UserDate();

        Date start = startDate;
        while (start.compareTo(endDate) <= 0) {
            LocalDate ld = start.toLocalDate();

            userLoginDate.getDate().add(ld.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            userLoginDate.getTotalUser().add(0);

            userRegisterDate.getDate().add(ld.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
            userRegisterDate.getTotalUser().add(0);

            start = Date.valueOf(ld.plusDays(1));
        }

        userLoginDate = udb.getTotalUserLoginDate(startDate, endDate, userLoginDate);
        userRegisterDate = udb.getTotalUserRegisterDate(startDate, endDate, userRegisterDate);

        // Active User Date
        ArrayList<String> dates = userLoginDate.getDate();
        ArrayList<Integer> gtu = userLoginDate.getTotalUser();
        String[] activeUserLabel = new String[dates.size()];

        int[] activeUserData = new int[dates.size()];
        for (int i = 0; i < dates.size(); i++) {
            activeUserLabel[i] = dates.get(i);
            activeUserData[i] = gtu.get(i);
        }

        // Register User Date
        dates = userRegisterDate.getDate();
        gtu = userRegisterDate.getTotalUser();

        String[] newUserLabel = new String[dates.size()];
        int[] newUserData = new int[dates.size()];

        for (int i = 0; i < dates.size(); i++) {
            newUserLabel[i] = dates.get(i);
            newUserData[i] = gtu.get(i);
        }

        ///
        ArrayList<User> activeUsers = udb.getActiveUsers();
        ArrayList<Group> groups = fdb.getGroups();
        String[] groupLables = new String[groups.size()];
        int[] totalUserData = new int[groups.size()];

        for (int i = 0; i < groups.size(); i++) {
            Group g = groups.get(i);
            groupLables[i] = g.getName();
            totalUserData[i] = g.getTotalUsers();
        }

        int totalUsers = udb.getTotalUsers();
        ArrayList<User> registeredUsers = udb.getTotalRegisterUsers(startDate, endDate);
        ArrayList<User> frequentUsers = udb.getTotalFrequentUsers(startDate, endDate);
        HashMap<String, Object> map = new HashMap<>();

        map.put("activeUsers", activeUsers);
        map.put("groupLables", groupLables);
        map.put("totalUserData", totalUserData);
        map.put("registeredUsers", registeredUsers);
        map.put("frequentUsers", frequentUsers);
        map.put("userLoginDate", userLoginDate);
        map.put("totalUsers", totalUsers);

        map.put("activeUserData", activeUserData);
        map.put("activeUserLabel", activeUserLabel);

        map.put("newUserData", newUserData);
        map.put("newUserLabel", newUserLabel);

        response.getWriter().println(gson.toJson(map));

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
