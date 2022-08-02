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
import model.Feedback;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
public class FeedbackDBContext extends DBContext {

    public ArrayList<Feedback> getFeedbacks() {
        UserDBContext udb = new UserDBContext();
        ArrayList<Feedback> feedbacks = new ArrayList<>();
        try {
            String sql = "SELECT TOP 10 [feedback_id]\n"
                    + "      ,[feedback_content]\n"
                    + "      ,[username]\n"
                    + "      ,[stars]\n"
                    + "  FROM [dbo].[Feedback]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setStars(rs.getInt("stars"));
                feedback.setFeedbackContent(rs.getString("feedback_content"));
                feedback.setUser(udb.getUser(rs.getString("username")));
                feedbacks.add(feedback);
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return feedbacks;
    }

    public Feedback getFeedback(String username, int courseId) {
        UserDBContext udb = new UserDBContext();
        try {
            String sql = "SELECT [feedback_id]\n"
                    + "      ,[feedback_content]\n"
                    + "      ,[username]\n"
                    + "      ,[course_id]\n"
                    + "      ,[stars]\n"
                    + "  FROM [dbo].[Feedback] \n"
                    + "  WHERE [course_id] = ? and username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            stm.setString(2, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setStars(rs.getInt("stars"));
                feedback.setFeedbackContent(rs.getString("feedback_content"));
                feedback.setUser(udb.getUser(rs.getString("username")));
                return feedback;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertFB(Feedback f) {
        PreparedStatement stm;
        try {
            String sql = "INSERT INTO [Feedback]\n"
                    + "           ([feedback_content]\n"
                    + "           ,[username]\n"
                    + "           ,[course_id]\n"
                    + "           ,[stars])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, f.getFeedbackContent());
            stm.setString(2, f.getUser().getUsername());
            stm.setInt(3, f.getCourse().getCourseId());
            stm.setInt(4, f.getStars());
            stm.executeUpdate();
            String update = "UPDATE Course\n"
                    + "SET Course.rate = b.sumrate\n"
                    + "FROM Course a\n"
                    + "JOIN (select CAST(sum(stars) AS float) / CAST(count(feedback_id) AS float)  as sumrate,course_id from Feedback  group by course_id) b\n"
                    + "ON (a.course_id = b.course_id)";
            stm = connection.prepareStatement(update);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updateFB(Feedback f) {
        PreparedStatement stm;
        try {
            String sql = "UPDATE [dbo].[Feedback]\n"
                    + "   SET [feedback_content] = ?\n"
                    + "      ,[username] = ?\n"
                    + "      ,[course_id] = ?\n"
                    + "      ,[stars] = ?\n"
                    + " WHERE [feedback_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, f.getFeedbackContent());
            stm.setString(2, f.getUser().getUsername());
            stm.setInt(3, f.getCourse().getCourseId());
            stm.setInt(4, f.getStars());
            stm.setInt(5, f.getFeedbackId());
            stm.executeUpdate();
            String update = "UPDATE Course\n"
                    + "SET Course.rate = b.sumrate\n"
                    + "FROM Course a\n"
                    + "JOIN (select CAST(sum(stars) AS float) / CAST(count(feedback_id) AS float)  as sumrate,course_id from Feedback  group by course_id) b\n"
                    + "ON (a.course_id = b.course_id)";
            stm = connection.prepareStatement(update);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public int getCurrentIdentity() {
        try {
            String sql = "SELECT IDENT_CURRENT('feedback') as [feedback_id]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("feedback_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Feedback> getAllFeedback(String searchKey, int sizePage, int page) {
        ArrayList<Feedback> listFeedBack = new ArrayList<>();
        try {
            String sql = "select a.feedback_id, a.feedback_content,a.[stars], b.course_title, c.[name] \n"
                    + "from Feedback a join Course b on a.course_id = b.course_id \n"
                    + "join [User] c on a.username = c.username ";
            sql += "where a.feedback_content + b.course_title + c.[name] ";
            if (searchKey.equals("")) {
                sql += " not like ? ";
            } else {
                sql += " like ? ";
            }
            sql += " order by a.feedback_id \n"
                    + " offset (?-1)*? row fetch next ? rows only";
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!searchKey.equals("")) {
                stm.setString(1, "%" + searchKey + "%");
            } else {
                stm.setString(1, searchKey);
            }
            stm.setInt(2, page);
            stm.setInt(3, sizePage);
            stm.setInt(4, sizePage);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setFeedbackContent(rs.getString("feedback_content"));
                feedback.setStars(rs.getInt("stars"));
                Course c = new Course();
                c.setCourseTitle(rs.getString("course_title"));
                feedback.setCourse(c);
                User u = new User();
                u.setName(rs.getString("name"));
                feedback.setUser(u);
                listFeedBack.add(feedback);
            }

        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listFeedBack;
    }

    public void deleteFeedback(int id) {
        PreparedStatement stm;
        try {
            String sql = "DELETE FROM [Feedback]\n"
                    + "      WHERE feedback_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
            String update = "UPDATE Course\n"
                    + "SET Course.rate = b.sumrate\n"
                    + "FROM Course a\n"
                    + "JOIN (select CAST(sum(stars) AS float) / CAST(count(feedback_id) AS float)  as sumrate,course_id from Feedback  group by course_id) b\n"
                    + "ON (a.course_id = b.course_id)";
            stm = connection.prepareStatement(update);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Feedback getFeedback(int feedbackId) {

        try {
            String sql = "select a.feedback_id, a.feedback_content, a.stars, b.course_title, b.rate, d.topic_name,\n"
                    + "c.[name], c.email, c.phone\n"
                    + "from Feedback a \n"
                    + "join Course b on a.course_id = b.course_id\n"
                    + "join [User] c on a.username = c.username\n"
                    + "join Topic d on b.topic_id = d.topic_id where a.feedback_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, feedbackId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getInt("feedback_id"));
                feedback.setFeedbackContent(rs.getString("feedback_content"));
                feedback.setStars(rs.getInt("stars"));
                Course c = new Course();
                c.setCourseTitle(rs.getString("course_title"));
                c.setRate(rs.getInt("rate"));
                Topic t = new Topic();
                t.setTopicName(rs.getString("topic_name"));
                c.setTopic(t);
                feedback.setCourse(c);
                User u = new User();
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                feedback.setUser(u);

                return feedback;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public String getReplyFB(int feedbackId) {
        try {
            String sql = "select feedbackofsysterm from Feedback where feedback_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, feedbackId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("feedbackofsysterm");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertReplyFeedback(int id, String messageReplyfb) {
        try {
            String sql = "UPDATE [Feedback]\n"
                    + "   SET [feedbackofsysterm] = ?\n"
                    + " WHERE feedback_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, messageReplyfb);
            stm.setInt(2, id);
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public String getFeedbackOfSysterm(String username, int courseId) {
        try {
            String sql = "select feedbackofsysterm from Feedback where username = ? and course_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, courseId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getString("feedbackofsysterm");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeedbackDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
