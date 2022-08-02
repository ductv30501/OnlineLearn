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
import model.Course;
import model.CourseUser;
import model.Topic;

/**
 *
 * @author win
 */
public class MyCourseDBContext extends DBContext {

    public ArrayList<CourseUser> getCourseDone(String username) {
        CourseDBContext cdb = new CourseDBContext();
        ArrayList<CourseUser> listMyCourse = new ArrayList<>();
        try {

            String sql = "with t as (select a.course_id, sum(le.duration) as totaltime from course a left join chapter ch \n"
                    + "on a.course_id = ch.course_id join Course_User cu \n"
                    + "on cu.course_id = a.course_id join [User] u \n"
                    + "on u.username = cu.username left join Lesson le\n"
                    + "on le.chapter_id = ch.chapter_id\n"
                    + "where u.username = ?\n"
                    + "group by a.course_id)\n"
                    + "\n"
                    + "\n"
                    + "select t.*, b.totalleaner from t join (select count(b.username)\n"
                    + "as totalleaner, a.course_id from Course a \n"
                    + "     join Course_User b on a.course_id = b.course_id\n"
                    + "                    group by a.course_id) b\n"
                    + "                    on t.course_id = b.course_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                CourseUser cu = new CourseUser();
                int courseId = rs.getInt("course_id");
                Course c = cdb.getCourseDetail(courseId);
                c.setTotalLearner(rs.getInt("totalleaner"));
                cu.setCourse(c);

                int totalLearnedtime = getTotalLearnedTime(username, courseId);
                cu.setTotalLearnedTime(totalLearnedtime);
                if (totalLearnedtime == c.getDuration()) {
                System.out.println(c.getDuration() + ", " + totalLearnedtime);
                    listMyCourse.add(cu);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(MyCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listMyCourse;
    }

    public ArrayList<CourseUser> getInProgressCourse(String username) {
        CourseDBContext cdb = new CourseDBContext();
        ArrayList<CourseUser> listMyCourse = new ArrayList<>();
        try {

            String sql = "with t as (select a.course_id, sum(le.duration) as totaltime from course a left join chapter ch \n"
                    + "on a.course_id = ch.course_id join Course_User cu \n"
                    + "on cu.course_id = a.course_id join [User] u \n"
                    + "on u.username = cu.username left join Lesson le\n"
                    + "on le.chapter_id = ch.chapter_id\n"
                    + "where u.username = ?\n"
                    + "group by a.course_id)\n"
                    + "\n"
                    + "\n"
                    + "select t.*, b.totalleaner from t join (select count(b.username)\n"
                    + "as totalleaner, a.course_id from Course a \n"
                    + "     join Course_User b on a.course_id = b.course_id\n"
                    + "                    group by a.course_id) b\n"
                    + "                    on t.course_id = b.course_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                CourseUser cu = new CourseUser();
                int courseId = rs.getInt("course_id");
                Course c = cdb.getCourseDetail(courseId);
                                c.setTotalLearner(rs.getInt("totalleaner"));

                cu.setCourse(c);

                int totalLearnedtime = getTotalLearnedTime(username, courseId);
                cu.setTotalLearnedTime(totalLearnedtime);

                if (totalLearnedtime < c.getDuration()) {
                    listMyCourse.add(cu);
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(MyCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listMyCourse;
    }

    public int getTotalLearnedTime(String username, int courseId) {

        try {

            String sql = "select sum(le.duration) as totalLearnedTime, a.course_id \n"
                    + "from course a join chapter ch \n"
                    + "on a.course_id = ch.course_id  join Course_User cu \n"
                    + "on cu.course_id = a.course_id  join [User] u \n"
                    + "on u.username = cu.username  join Lesson le \n"
                    + "on le.chapter_id = ch.chapter_id join lesson_done ld \n"
                    + "on ld.lesson_id = le.lesson_id\n"
                    + "where u.username = ? and a.course_id = ?\n"
                    + "group by a.course_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("totalLearnedTime");
            }

        } catch (SQLException ex) {
            Logger.getLogger(MyCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<CourseUser> getMyCourses(String username) {
        ArrayList<CourseUser> listMyCourse = new ArrayList<>();
        CourseDBContext cdb = new CourseDBContext();
        try {

            String sql = "select * from course c join course_user cu\n"
                    + "on c.course_id = cu.course_id\n"
                    + "where cu.username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CourseUser cu = new CourseUser();
                Course c = cdb.getCourseDetail(rs.getInt("course_id"));
                cu.setCourse(c);
                listMyCourse.add(cu);
            }

        } catch (SQLException ex) {
            Logger.getLogger(MyCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listMyCourse;
    }
}
