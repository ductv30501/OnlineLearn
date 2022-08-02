/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.question;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ExportController", urlPatterns = {"/authen/manage/question/export"})
public class ExportController extends HttpServlet {

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
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ExportController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ExportController at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String[] questionTitles = request.getParameterValues("questionTitle");
        String[] point = request.getParameterValues("point");
        String[] questionLevel = request.getParameterValues("questionLevel");
        String[] options = request.getParameterValues("options");
        String[] questionType = request.getParameterValues("questionType");
        String[] note = request.getParameterValues("note");
        ExportFileExcelFunction(questionTitles, point, questionLevel, options, questionType, note, response);
    }

    private void ExportFileExcelFunction(String[] questionTitles, String[] point, String[] questionLevel, String[] options, String[] questionType, String[] note, HttpServletResponse response) throws IOException {
        try {
            XSSFWorkbook wordkbook = new XSSFWorkbook();
            XSSFSheet sheet = wordkbook.createSheet("ListErrQuestions");
            XSSFRow row = null;
            Cell cell = null;

            row = sheet.createRow(0);
            cell = row.createCell(0, CellType.STRING);
            cell.setCellValue("Nội dung");

            cell = row.createCell(1, CellType.STRING);
            cell.setCellValue("Điểm");

            cell = row.createCell(2, CellType.STRING);
            cell.setCellValue("Độ khó");

            cell = row.createCell(3, CellType.STRING);
            cell.setCellValue("Đáp án");

            cell = row.createCell(4, CellType.STRING);
            cell.setCellValue("Loại câu hỏi");
            
            cell = row.createCell(5, CellType.STRING);
            cell.setCellValue("Ghi chú");

            int index = -1;
            for (int i = 0; i < questionTitles.length; i++) {
                index++;
                row = sheet.createRow(1 + index);

                cell = row.createCell(0, CellType.STRING);
                cell.setCellValue(questionTitles[i]);

                cell = row.createCell(1, CellType.NUMERIC);
                try{
                cell.setCellValue((int)Double.parseDouble(point[i]));
                }catch(Exception ex){
                    cell.setCellValue(point[i]);
                }

                cell = row.createCell(2, CellType.NUMERIC);
                try{
                cell.setCellValue((int)Double.parseDouble(questionLevel[i]));
                }catch(Exception ex){
                    cell.setCellValue(questionLevel[i]);
                }

                cell = row.createCell(3, CellType.STRING);
                cell.setCellValue(options[i]);

                cell = row.createCell(4, CellType.NUMERIC);
                 try{
                cell.setCellValue((int)Double.parseDouble(questionType[i]));
                }catch(Exception ex){
                    cell.setCellValue(questionType[i]);
                }
                
                cell = row.createCell(5, CellType.STRING);
                cell.setCellValue(note[i]);   
            }
            response.setContentType("application/vnd.ms-excel;charset=UTF-8");
            response.setHeader("Content-Disposition", "attachment; filename=List error questions" + ".xlsx");
            try {
                wordkbook.write(response.getOutputStream());
            } catch (FileNotFoundException ex) {
                ex.printStackTrace();

            } catch (IOException ex) {
                ex.printStackTrace();
            }
        } catch (Exception ex) {
            ex.printStackTrace();
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
