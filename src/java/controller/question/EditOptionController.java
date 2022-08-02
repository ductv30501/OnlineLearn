/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.question;

import com.google.gson.Gson;
import dal.QuestionDBContext;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Option;

/**
 *
 * @author Admin
 */
@WebServlet(name = "EditOptionController", urlPatterns = {"/authen/manage/question/edit"})
public class EditOptionController extends HttpServlet {

    
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
        request.setCharacterEncoding("UTF-8");
        
        String rawOptionId = request.getParameter("optionID");
        boolean status = true;
        
        if(request.getParameter("status").equals("0")) {
            status = false;
        }
        String rawQuestionId = request.getParameter("question_id");
        String optionDetail = request.getParameter("optionDetail");
        int optionID = Integer.parseInt(rawOptionId);
        int questionID = Integer.parseInt(rawQuestionId);
        Option option = new Option();
        option.setOptionId(optionID);
        option.setIsCorrect(status);
        option.setQuestion_id(questionID);
        option.setOptionDetail(optionDetail);
        
        QuestionDBContext questionDB = new QuestionDBContext();
        questionDB.updateOption(option);
        
        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();

        map.put("notification","1");
        response.getWriter().write(gson.toJson(map));
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
