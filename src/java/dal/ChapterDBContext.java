/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Chapter;
import model.Course;
import model.Lesson;

/**
 *
 * @author Admin
 */
public class ChapterDBContext extends DBContext{

    public ArrayList<Chapter> getChapterByCourseID(String courseID) {
        ArrayList<Chapter> chapters = new ArrayList<>();
        try {
            String sql = "SELECT [chapter_id]\n" +
                        "      ,[course_id]\n" +
                        "      ,[chapter_title]\n" +
                        "      ,[description]\n" +
                        "  FROM [Chapter]\n" +
                        "  WHERE course_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, courseID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setChapterId(rs.getInt("chapter_id"));
                chapter.setChapterTitle(rs.getString("chapter_title"));
                chapter.setDescription(rs.getString("description"));
                Course c = new Course();
                chapter.setCourse(c);
                ArrayList<Lesson> l = new ArrayList<>();
                chapter.setLessons(l);
                chapters.add(chapter);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return chapters;
    }

    public ArrayList<Chapter> getChapterOfCourse(String question_id) {
        ArrayList<Chapter> chapters = new ArrayList<>();
        try {
            String sql = "SELECT [chapter_id]\n" +
                            "       ,[course_id]\n" +
                            "       ,[chapter_title]\n" +
                            "       ,[description]\n" +
                            "FROM [Chapter]\n" +
                            "WHERE course_id = (SELECT co.course_id\n" +
                            "					FROM [Question] as q \n" +
                            "						join Chapter as c on q.chapter_id = c.chapter_id\n" +
                            "						join Course as co on c.course_id = co.course_id\n" +
                            "					WHERE q.question_id = ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, question_id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setChapterId(rs.getInt("chapter_id"));
                chapter.setChapterTitle(rs.getString("chapter_title"));
                chapter.setDescription(rs.getString("description"));
                Course c = new Course();
                c.setCourseId(rs.getInt("course_id"));
                chapter.setCourse(c);
                ArrayList<Lesson> l = new ArrayList<>();
                chapter.setLessons(l);
                chapters.add(chapter);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ChapterDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return chapters;
    }
    
}
