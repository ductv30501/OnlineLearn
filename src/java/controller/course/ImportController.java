/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.course;

import com.google.gson.Gson;
import dal.CourseDBContext;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Chapter;
import model.Course;
import model.Option;
import model.Question;
import model.QuestionClone;
import model.QuestionType;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

/**
 *
 * @author Admin
 */
@WebServlet(name = "TemplateController", urlPatterns = {"/authen/manage/question/import"})
@MultipartConfig(maxFileSize = 1024 * 1024 * 5, maxRequestSize = 1024 * 1024 * 50)
public class ImportController extends HttpServlet {

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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String search = request.getParameter("search");

        CourseDBContext cc = new CourseDBContext();

        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();

        ArrayList<Course> courses = cc.getCourses(search);

        map.put("courses", courses);
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        ArrayList<Question> questions = new ArrayList<>();
        ArrayList<QuestionClone> Invalidquestions = new ArrayList<>();
        ArrayList<QuestionClone> importResult = new ArrayList<>();

        Part part = request.getPart("excel");
        String chapter = request.getParameter("chapter");


        // Creating a Workbook from an Excel file (.xls or .xlsx)
        Workbook workbook = WorkbookFactory.create(part.getInputStream());

        // Getting the Sheet at index zero
        Sheet sheet = workbook.getSheetAt(0);

        // Create a DataFormatter to format and get each cell's value as String
        DataFormatter dataFormatter = new DataFormatter();
        Iterator<Row> rowIterator = sheet.rowIterator();

        boolean check = true;
        int index = 1;
        while (rowIterator.hasNext()) {
            Row row = rowIterator.next();
            index++;
            if (row.getRowNum() == 0) {
                // Ignore header
                continue;
            }

            // Now let's iterate over the columns of the current row
            Iterator<Cell> cellIterator = row.cellIterator();
            Question q = new Question();
            QuestionClone qc = new QuestionClone();
            
            
            boolean flag = true;
            while (cellIterator.hasNext()) {

                Cell cell = cellIterator.next();
                String cellValue = dataFormatter.formatCellValue(cell);
                if (cellValue == null || cellValue.toString().isEmpty()) {
                    continue;
                }
                int columnIndex = cell.getColumnIndex();

                switch (columnIndex) {
                    case 0:
                        if (cell.getStringCellValue().length() > 150) {
                            qc.setNote((qc.getNote() == null) ? "Nội dung quá dài!" : qc.getNote() + "\nNội dung quá dài!");
                            qc.setQuestionTitle(cell.getStringCellValue());
                            flag = false;
                            check = false;
                        }
                        if (cell.getStringCellValue().isEmpty()) {
                            qc.setNote((qc.getNote() == null) ? "Nội dung bị trống!" : qc.getNote() + "\nNội dung bị trống!");
                            qc.setQuestionTitle(" ");
                            flag = false;
                            check = false;
                        } else {
                            q.setQuestionTitle(cell.getStringCellValue());
                            qc.setQuestionTitle(cell.getStringCellValue());
                        }
                        break;
                    case 1:                      
                        try {
                        if (String.valueOf(cell.getNumericCellValue()).isEmpty()) {
                            qc.setNote((qc.getNote() == null) ? "Điểm bị trống!" : qc.getNote() + "\nĐiểm bị trống!");
                            qc.setPoint(" ");
                            flag = false;
                            check = false;
                        } else {
                            q.setPoint((int) cell.getNumericCellValue());
                            qc.setPoint(String.valueOf(cell.getNumericCellValue()));
                        }
                    } catch (Exception ex) {
                        qc.setNote((qc.getNote() == null) ? "Nhập điểm sai!" : qc.getNote() + "\nNhập điểm sai!");
                        qc.setPoint(cell.getStringCellValue());
                        flag = false;
                        check = false;
                    }
                    break;
                    case 2:                       
                        try {
                        if (String.valueOf(cell.getNumericCellValue()).isEmpty()) {
                            qc.setNote((qc.getNote() == null) ? "Cấp độ trống!" : qc.getNote() + "\nCấp độ trống!");
                            qc.setQuestionLevel(" ");
                            flag = false;
                            check = false;
                        } else {
                            q.setQuestionLevel((int) cell.getNumericCellValue());
                            qc.setQuestionLevel(String.valueOf(cell.getNumericCellValue()));
                        }
                    } catch (Exception ex) {
                        qc.setNote((qc.getNote() == null) ? "Nhập cấp độ sai!" : qc.getNote() + "\nNhập cấp độ sai!");
                        qc.setQuestionLevel(cell.getStringCellValue());
                        qc.setStt(index);
                        flag = false;
                        check = false;
                    }
                    break;
                    case 3:
                        if (cell.getStringCellValue().isEmpty()) {
                            qc.setNote((qc.getNote() == null) ? "Đáp án trống!" : qc.getNote() + "\nĐáp án trống!");
                            qc.setOptions(" ");
                            flag = false;
                            check = false;
                        }
                        try {
                            String[] details = cell.getStringCellValue().trim().replaceAll("\\s+", " ").split("\\|");
                            if (details.length > 0) {
                                ArrayList<Option> listop = new ArrayList<>();
                                for (int i = 0; i < details.length; i++) {
                                    Option o = new Option();
                                    try {
                                        String[] opdetails = details[i].split("\\+");
                                        o.setOptionDetail(opdetails[0]);
                                        if (opdetails[1].equalsIgnoreCase("true")) {
                                            o.setIsCorrect(true);
                                        } else if (opdetails[1].equalsIgnoreCase("false")) {
                                            o.setIsCorrect(false);
                                        } else {
                                            qc.setNote((qc.getNote() == null) ? "Trạng thái đúng sai của câu hỏi chỉ có thể là \"true/false\"" : qc.getNote() + "\nTrạng thái đúng sai của câu hỏi chỉ có thể là \"true/false\"");
                                            qc.setOptions(cell.getStringCellValue());
                                            qc.setStt(index);
                                            flag = false;
                                            check = false;
                                            break;
                                        }
                                        listop.add(o);
                                    } catch (Exception ex) {
                                        qc.setNote((qc.getNote() == null) ? "Nhập đáp án thiếu \"+\" hoặc \"true/false\"" : qc.getNote() + "\nNhập đáp án thiếu \"+\" hoặc \"true/false\"");
                                        qc.setOptions(cell.getStringCellValue());
                                        qc.setStt(index);
                                        flag = false;
                                        check = false;
                                        break;
                                    }
                                }
                                qc.setOptions(cell.getStringCellValue());
                                q.setOptions(listop);
                            }
                        } catch (Exception ex) {
                            qc.setNote((qc.getNote() == null) ? "Nhập đáp án thiếu \"|\" giữa các câu" : qc.getNote() + "\nNhập đáp án thiếu \"|\" giữa các câu");
                            qc.setOptions(cell.getStringCellValue());
                            qc.setStt(index);
                            flag = false;
                            check = false;
                            break;
                        }
                        break;
                    case 4:                        
                        try {
                        if (String.valueOf(cell.getNumericCellValue()).isEmpty()) {
                            qc.setNote((qc.getNote() == null) ? "loại câu hỏi trống!" : qc.getNote() + "\nloại câu hỏi trống!");
                            qc.setQuestionType(" ");
                            flag = false;
                            check = false;
                        }
                        int questionType = (int) cell.getNumericCellValue();
                        q.setQuestionType(new QuestionType(questionType));
                        qc.setQuestionType(String.valueOf(cell.getNumericCellValue()));
                    } catch (Exception ex) {
                        qc.setNote((qc.getNote() == null) ? "Nhập loại câu hỏi sai!" : qc.getNote() + "\nNhập loại câu hỏi sai!");
                        qc.setQuestionType(cell.getStringCellValue());
                        qc.setStt(index);
                        flag = false;
                        check = false;
                    }
                    break;
                    default:
                        break;
                }
                if (chapter != null) {
                    Chapter c = new Chapter();
                    c.setChapterId(Integer.parseInt(chapter));
                    q.setChapter(c);
                }
            }
            if (flag) {
                questions.add(q);
                qc.setNote("Tải lên thành công");
            } else {
                Invalidquestions.add(qc);
            }
            importResult.add(qc);
        }
        Gson gson = new Gson();
        HashMap<String, Object> map = new HashMap<>();

        CourseDBContext cc = new CourseDBContext();
        boolean importQuestion = cc.importQuestion(questions);

//        map.put("notification", "2");
        map.put("Invalidquestions", Invalidquestions);
        map.put("importResult", importResult);
        response.getWriter().write(gson.toJson(map));

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
