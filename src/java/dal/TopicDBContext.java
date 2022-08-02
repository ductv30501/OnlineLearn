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
import model.Topic;

/**
 *
 * @author ADMIN
 */
public class TopicDBContext extends DBContext {

    public int getTotalTopics() {
        try {
            String sql = "SELECT COUNT(*) AS [Total] \n"
                    + "  FROM [dbo].[Topic]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Topic> getTopics() {
        ArrayList<Topic> topics = new ArrayList<>();
        try {
            String sql = "SELECT [topic_id]\n"
                    + "      ,[topic_name]\n"
                    + "      ,[description]\n"
                    + "      ,[img]\n"
                    + "  FROM [dbo].[Topic]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                topic.setDescription(rs.getString("description"));
                topic.setImg(rs.getBytes("img"));
                topics.add(topic);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topics;
    }
    
     public int getTotalCourseByTopic(int topicID) {
        try {
            String sql = "  SELECT COUNT(*) AS Total\n"
                    + "  FROM [dbo].[Course] C inner join [Topic] T ON C.topic_id=T.topic_id\n"
                    + "  WHERE T.topic_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, topicID);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {

               return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Topic> getPopularTopics() {
        ArrayList<Topic> topics = new ArrayList<>();
        try {
            String sql = "SELECT TOP (10) t.topic_id,\n"
                    + "             t.topic_name,\n"
                    + "             t.img,\n"
                    + "             t.[description],\n"
                    + "             COUNT(*) AS Total_User FROM [User] u\n"
                    + "JOIN User_Group ug\n"
                    + "ON ug.username = u.username JOIN [Group] g\n"
                    + "ON g.group_id = ug.group_id JOIN Course_User cu \n"
                    + "ON cu.username = u.username JOIN Course c\n"
                    + "ON c.course_id = cu.course_id JOIN Topic t\n"
                    + "ON t.topic_id = c.topic_id\n"
                    + "WHERE g.group_name = N'Học viên'\n"
                    + "Group by t.topic_id,\n"
                    + "		t.topic_name,\n"
                    + "		t.img,\n"
                    + "		t.[description]\n"
                    + "ORDER BY Total_User DESC";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                topic.setDescription(rs.getString("description"));
                topic.setImg(rs.getBytes("img"));
                topic.setTotalLearner(rs.getInt("Total_User"));
                topic.setTotalCourse(getTotalCourseByTopic(topic.getTopicId()));
                topics.add(topic);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topics;
    }

    public Topic getTopic(int topicId) {
        try {
            String sql = "SELECT [topic_id], [topic_name],[description],[img] FROM [Topic] WHERE [topic_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, topicId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                topic.setDescription(rs.getString("description"));
                topic.setImg(rs.getBytes("img"));
                return topic;
            }
        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Topic> getTopics(String searchKey, int page, int sizepage) {
        ArrayList<Topic> topics = new ArrayList<>();
        try {
            String sql = "SELECT [topic_id],[topic_name],[description],[img] FROM [Topic]";
            sql += "where topic_name ";
            if (searchKey.equals("")) {
                sql += " not like ? ";
            } else {
                sql += " like ? ";
            }
            sql += "or description ";
            if (searchKey.equals("")) {
                sql += " not like ? ";
            } else {
                sql += " like ? ";
            }
            sql += "or topic_id ";
            if (searchKey.equals("")) {
                sql += " not like ? ";
            } else {
                sql += " like ? ";
            }
            sql += "order by topic_id\n"
                    + "offset (?-1)*? row fetch next ? rows only";
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!searchKey.equals("")) {
                stm.setString(1, "%" + searchKey + "%");
                stm.setString(2, "%" + searchKey + "%");
                stm.setString(3, "%" + searchKey + "%");
            } else {
                stm.setString(1, searchKey);
                stm.setString(2, searchKey);
                stm.setString(3, searchKey);
            }
            stm.setInt(4, page);
            stm.setInt(5, sizepage);
            stm.setInt(6, sizepage);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                topic.setDescription(rs.getString("description"));
                topic.setImg(rs.getBytes("img"));
                topics.add(topic);
            }
        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return topics;
    }

    public void deleteTopic(int topicId) {
        try {
            String sql = "UPDATE [Course]\n"
                    + "   SET [topic_id] = 1\n"
                    + "where topic_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, topicId);
            stm.executeUpdate();
            String delete = "DELETE FROM [Topic]\n"
                    + "      WHERE topic_id =?";
            PreparedStatement dstm = connection.prepareStatement(delete);
            dstm.setInt(1, topicId);
            dstm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertTopic(Topic t) {
        try {
            String sql = "INSERT INTO [dbo].[Topic]\n"
                    + "           ([topic_name]\n"
                    + "           ,[description]\n"
                    + "           ,[img])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, t.getTopicName());
            stm.setString(2, t.getDescription());
            stm.setBytes(3, t.getImg());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateTopic(Topic t) {

        try {
            String sql = "UPDATE [dbo].[Topic]\n"
                    + "   SET [topic_name] = ?\n"
                    + "      ,[description] = ?\n"
                    + "      ,[img] = ?\n"
                    + " WHERE topic_id =?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, t.getTopicName());
            stm.setString(2, t.getDescription());
            stm.setBytes(3, t.getImg());
            stm.setInt(4, t.getTopicId());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(TopicDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
