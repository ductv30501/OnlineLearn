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
import model.CourseTaget;
import model.Lesson;
import model.Option;
import model.Question;
import model.Quiz;
import model.Topic;
import model.User;

/**
 *
 * @author ADMIN
 */
public class CourseDBContext extends DBContext {

    public boolean importQuestion(ArrayList<Question> questions) {
        for (Question question : questions) {
            try {
                String sql = "INSERT INTO [dbo].[Question]\n"
                        + "           ([question_content]\n"
                        + "           ,[point]\n"
                        + "           ,[chapter_id]\n"
                        + "           ,[question_type_id]\n"
                        + "           ,[question_level])\n"
                        + "     VALUES\n"
                        + "           (?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?\n"
                        + "           ,?)";
                PreparedStatement stm = connection.prepareStatement(sql);
                stm.setString(1, question.getQuestionTitle());
                stm.setInt(2, question.getPoint());
                stm.setInt(3, question.getChapter().getChapterId());
                stm.setInt(4, question.getQuestionType().getQuestionTypeId());
                stm.setInt(5, question.getQuestionLevel());
                stm.executeUpdate();
                for (Option option : question.getOptions()) {
                    String optionSql = "INSERT INTO [dbo].[Option]\n"
                            + "           ([option_detail]\n"
                            + "           ,[is_correct]\n"
                            + "           ,[question_id])\n"
                            + "     VALUES\n"
                            + "           (?\n"
                            + "           ,?\n"
                            + "           ,?)";
                    PreparedStatement insertOption = connection.prepareStatement(optionSql);
                    insertOption.setString(1, option.getOptionDetail());
                    insertOption.setBoolean(2, option.isIsCorrect());
                    insertOption.setInt(3, getLastQuestion());
                    insertOption.executeUpdate();
                }
            } catch (SQLException ex) {
                Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return true;
    }

    public int getLastQuestion() {
        try {
            String sql = "select top 1 question_id from Question order by question_id desc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("question_id");
                return id;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Chapter> getChapters(String courseId) {
        ArrayList<Chapter> chapters = new ArrayList<>();
        try {
            String sql = "select * from [Chapter] where course_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Chapter c = new Chapter();
                c.setChapterTitle(rs.getString("chapter_title"));
                c.setChapterId(rs.getInt("chapter_id"));
                chapters.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return chapters;
    }

    public ArrayList<Course> getCourseList() {
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "select distinct course_id,course_title from [course]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setCourseId(rs.getInt("course_id"));
                c.setCourseTitle(rs.getString("course_title"));
                courses.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }

    public ArrayList<Question> getQuestions(String course, String chapter, String level, String search, int index, int number, String sort, String obj) {
        ArrayList<Question> questions = new ArrayList<>();
        try {
            String sql = "select a.question_id,a.question_content,c.course_id,c.course_title,\n"
                    + "  b.chapter_id,b.chapter_title,a.question_level\n"
                    + "  from Question a join Chapter b on a.chapter_id=b.chapter_id\n"
                    + "join Course c on c.course_id = b.course_id where a.question_id!= 0 \n"
                    + " " + ((!course.isEmpty()) ? "and c.course_id=" + course + "" : "")
                    + " " + ((!chapter.isEmpty()) ? "and  b.chapter_id=" + chapter + "" : "")
                    + " " + ((!level.isEmpty()) ? "and  a.question_level=" + level + "" : "")
                    + " " + ((!search.isEmpty()) ? "and a.question_content like ?" : "");
            sql += " order by " + obj + " " + sort + " offset " + (index - 1) * number + " row fetch next " + number + " row only";

            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Question q = new Question();
                q.setQuestionId(rs.getInt("question_id"));
                q.setQuestionTitle(rs.getString("question_content"));
                Course cs = new Course();
                cs.setCourseId(rs.getInt("course_id"));
                cs.setCourseTitle(rs.getString("course_title"));
                Chapter ct = new Chapter();
                ct.setChapterId(rs.getInt("chapter_id"));
                ct.setChapterTitle(rs.getString("chapter_title"));
                ct.setCourse(cs);
                q.setChapter(ct);
                q.setQuestionLevel(rs.getInt("question_level"));
                questions.add(q);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return questions;
    }

    public int countQuestions(String course, String chapter, String level, String search) {
        try {
            String sql = " select count(*) as total from Question a join Chapter b on a.chapter_id=b.chapter_id\n"
                    + "join Course c on c.course_id = b.course_id where a.question_id != 0\n"
                    + " " + ((!course.isEmpty()) ? "and c.course_id=" + course + "" : "")
                    + " " + ((!chapter.isEmpty()) ? "and  b.chapter_id=" + chapter + "" : "")
                    + " " + ((!level.isEmpty()) ? "and  a.question_level=" + level + "" : "")
                    + " " + ((!search.isEmpty()) ? "and a.question_content like ?" : "");
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Course> getTopCourses() {
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "SELECT TOP (10) c.course_id,\n"
                    + "				c.course_title, \n"
                    + "				c.duration,\n"
                    + "				c.[description],\n"
                    + "				c.img,\n"
                    + "				c.is_public,\n"
                    + "				c.rate,\n"
                    + "				c.createdby,\n"
                    + "				t.topic_id,\n"
                    + "				t.topic_name,\n"
                    + "				COUNT(*) AS Total_User FROM [User] u\n"
                    + "JOIN User_Group ug\n"
                    + "ON ug.username = u.username JOIN [Group] g\n"
                    + "ON g.group_id = ug.group_id JOIN Course_User cu \n"
                    + "ON cu.username = u.username JOIN Course c\n"
                    + "ON c.course_id = cu.course_id JOIN Topic t\n"
                    + "ON t.topic_id = c.topic_id\n"
                    + "WHERE g.group_name = N'Học viên'\n"
                    + "Group by c.course_id,\n"
                    + "		c.course_title, \n"
                    + "		c.duration,\n"
                    + "		c.[description],\n"
                    + "		c.img,\n"
                    + "		c.is_public,\n"
                    + "		c.rate,\n"
                    + "		c.createdby,\n"
                    + "		t.topic_id,\n"
                    + "		t.topic_name\n"
                    + "ORDER BY Total_User DESC";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseTitle(rs.getString("course_title"));

                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));

                course.setTopic(topic);

                course.setStatus(rs.getBoolean("is_public"));
                course.setDescription(rs.getString("description"));
                course.setRate(rs.getFloat("rate"));
                course.setImg(rs.getBytes("img"));
                course.setTotalLearner(rs.getInt("Total_User"));
                course.setCreatedBy(rs.getString("createdby"));
                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }

    public int getTotalCourses() {
        try {
            String sql = "SELECT COUNT(*) AS [Total] \n"
                    + "  FROM [dbo].[Course]";
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

    public ArrayList<Course> getRelatedCourses(int courseId) {
        ArrayList<Course> relatedCourses = new ArrayList<>();
        TopicDBContext tdb = new TopicDBContext();
        try {
            String sql = "SELECT * FROM Course\n"
                    + "WHERE topic_id = (SELECT t.topic_id FROM Topic t JOIN Course c\n"
                    + "				ON t.topic_id = c.topic_id\n"
                    + "				WHERE c.course_id = ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = getCourseDetail(rs.getInt("course_id"));
                if (course.getCourseId() != courseId) {
                    relatedCourses.add(course);
                }

            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return relatedCourses;
    }

    public int countCourse(String topicId, String status, String search) {
        try {
            String sql = "SELECT count(*) as total\n"
                    + "FROM [Course] a  join [Topic] b on a.topic_id=b.topic_id where a.topic_id!=0 \n"
                    + " " + ((!topicId.isEmpty()) ? "and a.topic_id=" + topicId + "" : "")
                    + " " + ((!status.isEmpty()) ? "and  a.[is_public]=" + status + "" : "")
                    + " " + ((!search.isEmpty()) ? "and a.course_title like ?" : "");

            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
            }
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<Course> getCourses(String topicId, String status, String search, int index, int number, String sort, String obj) {
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "SELECT a.course_id,a.course_title,a.img,a.topic_id,b.topic_name,a.createdby,a.[is_public]\n"
                    + "FROM [Course] a  join [Topic] b on a.topic_id=b.topic_id where a.topic_id!=0 \n"
                    + " " + ((!topicId.isEmpty()) ? "and a.topic_id=" + topicId + "" : "")
                    + " " + ((!status.isEmpty()) ? "and  a.[is_public]=" + status + "" : "")
                    + " " + ((!search.isEmpty()) ? "and a.course_title like ?" : "");
            sql += " order by " + obj + " " + sort + " offset " + (index - 1) * number + " row fetch next " + number + " row only";

            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
            }

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseTitle(rs.getString("course_title"));
                course.setCreatedBy(rs.getString("createdby"));
                course.setStatus(rs.getBoolean("is_public"));
                course.setImg(rs.getBytes("img"));
                Topic t = new Topic();
                t.setTopicId(rs.getInt("topic_id"));
                t.setTopicName(rs.getString("topic_name"));
                course.setTopic(t);
                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }

    public void ChangeStatus(boolean status, int id) {
        try {
            String sql = "UPDATE [Course]\n"
                    + "   SET [is_public] = ?\n"
                    + " WHERE [course_id] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, status);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int countCourse() {
        int count = 0;
        try {
            String sql = "select count(*) as count from Course";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {

                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public void insertCourse(Course c) {
        try {
            String sql = "INSERT INTO [dbo].[Course]\n"
                    + "           ([course_title]\n"
                    + "           ,[topic_id]\n"
                    + "           ,[is_public]\n"
                    + "           ,[duration]\n"
                    + "           ,[description]\n"
                    + "           ,[rate]\n"
                    + "           ,[img]\n"
                    + "           ,[createdby])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, c.getCourseTitle());
            stm.setInt(2, c.getTopic().getTopicId());
            stm.setBoolean(3, true);
            stm.setInt(4, 0);
            stm.setString(5, c.getDescription());
            stm.setFloat(6, 0);
            stm.setBytes(7, c.getImg());
            stm.setString(8, c.getCreatedBy());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updateCourse(Course c) {
        try {
            String sql = "UPDATE [dbo].[Course]\n"
                    + "   SET [course_title] = ?\n"
                    + "      ,[topic_id] = ?\n"
                    + "      ,[description] = ?\n"
                    + "      ,[img] = ?\n"
                    + "      ,[createdby] = ?\n"
                    + " WHERE [course_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, c.getCourseTitle());
            stm.setInt(2, c.getTopic().getTopicId());
            stm.setString(3, c.getDescription());
            stm.setBytes(4, c.getImg());
            stm.setString(5, c.getCreatedBy());
            stm.setInt(6, c.getCourseId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public boolean checkExistLessonDone(int courseId, int lessonId, String username) {
        try {
            String sql = "SELECT COUNT(*) AS total FROM  [dbo].[Lesson_Done]\n"
                    + "WHERE [username] = ? AND [lesson_id] = ?  AND [course_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            stm.setString(2, username);
            stm.setInt(3, lessonId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                if (rs.getInt("total") > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void insertLessonDone(int courseId, int lessonId, String username) {
        try {
            String sql = "INSERT INTO [dbo].[Lesson_Done]\n"
                    + "           ([course_id]\n"
                    + "           ,[username]\n"
                    + "           ,[lesson_id])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            stm.setString(2, username);
            stm.setInt(3, lessonId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public int getCurrentIdentity() {
        try {
            String sql = "SELECT IDENT_CURRENT('course') as [current_id]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("current_id");
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public void insertCourseUser(Course c, User u) {
        try {
            String sql = "INSERT INTO [dbo].[Course_User]\n"
                    + "           ([course_id]\n"
                    + "           ,[username])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, c.getCourseId());
            stm.setString(2, u.getUsername());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<Course> getcourseByTopic(int topicID) {
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "with t as  ( SELECT C.[course_id]\n"
                    + "	  ,T.[topic_id]\n"
                    + "	  ,T.[topic_name]\n"
                    + "	  ,T.[description]\n"
                    + "  FROM [dbo].[Course] C inner join [Topic] T ON C.topic_id=T.topic_id\n"
                    + "  WHERE T.topic_id = ?)\n"
                    + "select t.*, b.totalleaner from t join (select count(b.username)\n"
                    + "as totalleaner, a.course_id from Course a \n"
                    + "     join Course_User b on a.course_id = b.course_id\n"
                    + "                    group by a.course_id) b\n"
                    + "                    on t.course_id = b.course_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, topicID);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {

                Course course = getCourseDetail(rs.getInt("course_id"));

                Topic topic = new Topic();
                topic.setTopicId(rs.getInt("topic_id"));
                topic.setTopicName(rs.getString("topic_name"));
                course.setTopic(topic);

                course.setTotalLearner(rs.getInt("totalleaner"));

                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }

//    public ArrayList<Course> getPopularCourse() {
//        ArrayList<Course> courses = new ArrayList<>();
//        try {
//            String sql = "WITH Total as (SELECT TOP 10  COUNT(*)  AS total_learner, c.course_id\n"
//                    + "FROM [Course_User] cu INNER JOIN [Course] c ON c.course_id = cu.course_id\n"
//                    + "GROUP BY c.course_id\n"
//                    + "ORDER BY total_learner DESC) \n"
//                    + "\n"
//                    + "SELECT TOP 10 * FROM Total t JOIN Course c \n"
//                    + "ON t.course_id = c.course_id";
//            PreparedStatement stm = connection.prepareStatement(sql);
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                Course course = new Course();
//                course.setCourseId(rs.getInt("course_id"));
//                course.setCourseTitle(rs.getString("course_title"));
//
//                course.setTopic(new Topic(rs.getInt("topic_id")));
//                course.setStatus(rs.getBoolean("is_public"));
//                course.setDescription(rs.getString("description"));
//                course.setRate(rs.getFloat("rate"));
//                course.setImg(rs.getBytes("img"));
//                course.setCreatedBy(rs.getString("createdby"));
//                course.setTotalLearner(rs.getInt("total_learner"));
//                courses.add(course);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return courses;
//
//    }
    public int getNumberRegistered(int courseId) {
        int count;
        try {
            String sql = "SELECT COUNT([username]) AS registered\n"
                    + "  FROM [Course_User] CU INNER JOIN [Course] C ON C.course_id = CU.course_id \n"
                    + "  GROUP BY C.course_iD\n"
                    + "  HAVING C.course_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("registered");
                return count;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;

    }

//    public ArrayList<Course> getTopCourses() {
//        TopicDBContext tdb = new TopicDBContext();
//        ArrayList<Course> courses = new ArrayList<>();
//        try {
//            String sql = "SELECT [course_id]\n"
//                    + "       ,[course_title]\n"
//                    + "       ,[topic_id]\n"
//                    + "       ,[is_public]\n"
//                    + "       ,[description]\n"
//                    + "       ,[rate]\n"
//                    + "       ,[img]\n"
//                    + "       ,[createdby]\n"
//                    + "FROM [dbo].[Course]\n"
//                    + "ORDER BY [RATE] DESC";
//            PreparedStatement stm = connection.prepareStatement(sql);
//            ResultSet rs = stm.executeQuery();
//            while (rs.next()) {
//                Course course = new Course();
//                course.setCourseId(rs.getInt("course_id"));
//                course.setCourseTitle(rs.getString("course_title"));
//                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
//                course.setStatus(rs.getBoolean("is_public"));
//                course.setDescription(rs.getString("description"));
//                course.setRate(rs.getFloat("rate"));
//                course.setImg(rs.getBytes("img"));
//                course.setCreatedBy(rs.getString("createdby"));
//                courses.add(course);
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
//        }
//        return courses;
//    }
    public ArrayList<Course> getCourses() {
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "with t as (select course_id from Course)\n"
                    + "select t.*, b.totalleaner from t join (select count(b.username)\n"
                    + "as totalleaner, a.course_id from Course a \n"
                    + "     join Course_User b on a.course_id = b.course_id\n"
                    + "                    group by a.course_id) b\n"
                    + "                    on t.course_id = b.course_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {

                Course course = getCourseDetail(rs.getInt("course_id"));
                course.setTotalLearner(rs.getInt("totalleaner"));
                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }
    
     public ArrayList<Course> getCourseTitles() {
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "select course_id, course_title from course";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setCourseId(rs.getInt("course_id"));
                c.setCourseTitle(rs.getString("course_title"));
                courses.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }

    public ArrayList<Course> getCourses(String search) {
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "select course_id, course_title from course where course_title like ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + search + "%");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setCourseId(rs.getInt("course_id"));
                c.setCourseTitle(rs.getString("course_title"));
                courses.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }

    public Course getCourse(int courseId) {
        TopicDBContext tdb = new TopicDBContext();
        try {
            String sql = "SELECT [course_title]\n"
                    + "      ,[topic_id]\n"
                    + "      ,[is_public]\n"
                    + "      ,[description]\n"
                    + "      ,[rate]\n"
                    + "      ,[img]\n"
                    + "      ,[createdby]\n"
                    + "  FROM [dbo].[Course]"
                    + "  WHERE [course_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {

                Course course = new Course();
                course.setCourseId(courseId);
                course.setCourseTitle(rs.getString("course_title"));
                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
                course.setStatus(rs.getBoolean("is_public"));
                course.setDescription(rs.getString("description"));
                course.setRate(rs.getFloat("rate"));
                course.setImg(rs.getBytes("img"));
                course.setCreatedBy(rs.getString("createdby"));
                return course;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Course getCourseDetail(int courseId) {
        TopicDBContext tdb = new TopicDBContext();
        QuizDBContext qdb = new QuizDBContext();
        try {
            String sql = "with t as(SELECT  [course_id]\n"
                    + "   ,[course_title]\n"
                    + "      ,[topic_id]\n"
                    + "      ,[is_public]\n"
                    + "      ,[description]\n"
                    + "      ,[rate]\n"
                    + "      ,[img]\n"
                    + "      ,[createdby]\n"
                    + "  FROM [dbo].[Course]   "
                    + "  WHERE [course_id] = ?)\n"
                    + "select t.*, b.totalleaner from t join (select count(b.username)\n"
                    + "as totalleaner, a.course_id from Course a \n"
                    + "     join Course_User b on a.course_id = b.course_id\n"
                    + "                    group by a.course_id) b\n"
                    + "                    on t.course_id = b.course_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {

                Course course = new Course();
                course.setCourseId(courseId);
                course.setCourseTitle(rs.getString("course_title"));
                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
                course.setStatus(rs.getBoolean("is_public"));
                course.setDescription(rs.getString("description"));
                course.setRate(rs.getFloat("rate"));
                course.setImg(rs.getBytes("img"));
                course.setCreatedBy(rs.getString("createdby"));
                course.setTotalLearner(courseId);
                ArrayList<Chapter> chapters = getChapters(course);

                for (Chapter chapter : chapters) {
                    ArrayList<Lesson> lessons = getLessons(chapter);
                    Quiz quizByChapter = qdb.getQuizByChapter(chapter.getChapterId());
                    chapter.setQuiz(quizByChapter);
                    chapter.setLessons(lessons);
                }

                course.setChapters(chapters);

                String durationText = course.getDurationText();
                return course;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Lesson> getLessonDone(int courseId, String username) {
        ArrayList<Lesson> lessons = new ArrayList<>();
        try {
            String sql = "SELECT [lesson_id]\n"
                    + "  FROM [dbo].[Lesson_Done]\n"
                    + "  WHERE [course_id] = ? AND [username] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            stm.setString(2, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonId(rs.getInt("lesson_id"));
                lessons.add(lesson);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lessons;
    }

    public void insertChapter(Chapter chapter) {
        try {
            String sql = "INSERT INTO [dbo].[Chapter]\n"
                    + "           ([course_id]\n"
                    + "           ,[chapter_title]\n"
                    + "           ,[description])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?)";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapter.getCourse().getCourseId());
            stm.setString(2, chapter.getChapterTitle());
            stm.setString(3, chapter.getDescription());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertLesson(Lesson lesson) {
        try {
            String sql = "INSERT INTO [dbo].[Lesson]\n"
                    + "           ([chapter_id]\n"
                    + "           ,[lesson_tilte]\n"
                    + "           ,[duration]\n"
                    + "           ,[videoURL]\n"
                    + "           ,[public_id]\n"
                    + "           ,[description])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?)";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lesson.getChapter().getChapterId());
            stm.setString(2, lesson.getLessonTitle());
            stm.setInt(3, lesson.getDuration());
            stm.setString(4, lesson.getVideoURL());
            stm.setString(5, lesson.getPublicId());
            stm.setString(6, lesson.getDescription());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Chapter> getChapters(Course course) {
        ArrayList<Chapter> chapters = new ArrayList<>();
        try {
            String sql = "select ch.chapter_id,\n"
                    + "		ch.chapter_title,\n"
                    + "		ch.[description]\n"
                    + "from course c join chapter ch \n"
                    + "on c.course_id = ch.course_id \n"
                    + "where c.course_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, course.getCourseId());
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setCourse(course);
                chapter.setChapterId(rs.getInt("chapter_id"));
                chapter.setChapterTitle(rs.getString("chapter_title"));
                chapter.setDescription(rs.getString("description"));
                chapters.add(chapter);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return chapters;
    }

    public ArrayList<Lesson> getLessons(Chapter chapter) {
        ArrayList<Lesson> lessons = new ArrayList<>();
        try {
            String sql = "select le.lesson_id,\n"
                    + "		le.lesson_tilte,\n"
                    + "		le.duration,\n"
                    + "		le.videoURL,\n"
                    + "		le.[description],\n"
                    + "		le.[public_id]\n"
                    + "from chapter ch join lesson le\n"
                    + "on ch.chapter_id = le.chapter_id \n"
                    + "where ch.chapter_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapter.getChapterId());
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setChapter(chapter);
                lesson.setLessonTitle(rs.getString("lesson_tilte"));
                lesson.setLessonId(rs.getInt("lesson_id"));
                lesson.setPublicId(rs.getString("public_id"));
                lesson.setDescription(rs.getString("description"));
                lesson.setVideoURL(rs.getString("videoURL"));
                lesson.setDuration(rs.getInt("duration"));

                lessons.add(lesson);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return lessons;
    }

    public Lesson getLesson(int lessonId) {

        try {
            String sql = "SELECT [chapter_id]\n"
                    + "      ,[lesson_tilte]\n"
                    + "      ,[duration]\n"
                    + "      ,[videoURL]\n"
                    + "      ,[public_id]\n"
                    + "      ,[description]\n"
                    + "  FROM [dbo].[Lesson]\n"
                    + "  WHERE [lesson_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lessonId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Lesson lesson = new Lesson();
                lesson.setLessonId(lessonId);
                lesson.setChapter(getChapter(rs.getInt("chapter_id")));
                lesson.setLessonTitle(rs.getString("lesson_tilte"));
                lesson.setPublicId(rs.getString("public_id"));
                lesson.setDescription(rs.getString("description"));
                lesson.setVideoURL(rs.getString("videoURL"));
                lesson.setDuration(rs.getInt("duration"));

                return lesson;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Chapter getChapter(int chapterId) {
        try {
            String sql = "SELECT [course_id]\n"
                    + "      ,[chapter_title]\n"
                    + "      ,[description]\n"
                    + "  FROM [dbo].[Chapter]\n"
                    + "WHERE [chapter_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Chapter chapter = new Chapter();
                chapter.setChapterId(chapterId);
                chapter.setChapterTitle(rs.getString("chapter_title"));
                chapter.setDescription(rs.getString("description"));
                return chapter;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void deleteLesson(Lesson lesson) {
        try {
            String sql = "DELETE FROM [dbo].[Lesson]\n"
                    + "      WHERE [lesson_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, lesson.getLessonId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteChapter(Chapter chapter) {
        QuizDBContext qdb = new QuizDBContext();
        QuestionDBContext cdb = new QuestionDBContext();

        try {

            String sql0 = "select q.quizz_id from quizz q join Chapter c \n"
                    + "on c.chapter_id = q.chapter_id \n"
                    + "WHERE c.chapter_id  = ?";

            PreparedStatement stm0 = connection.prepareStatement(sql0);
            stm0.setInt(1, chapter.getChapterId());
            ResultSet rs = stm0.executeQuery();

            while (rs.next()) {
                qdb.deleteQuizByQuizId(rs.getInt("quizz_id"));
            }
            cdb.deleteQuestion(chapter.getChapterId());

            String sql = "DELETE FROM [Lesson_Done] \n"
                    + "Where lesson_id in (SELECT ld.lesson_id FROM [Lesson_Done] ld join [Lesson] le\n"
                    + "on le.lesson_id = ld.lesson_id join Chapter ch\n"
                    + "on ch.chapter_id = le.chapter_id\n"
                    + "join Course c on c.course_id = ch.course_id\n"
                    + "WHERE le.chapter_id = ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapter.getChapterId());
            stm.executeUpdate();

            String sql1 = "DELETE FROM [dbo].[Lesson]\n"
                    + "      WHERE [chapter_id] = ?";
            PreparedStatement stm1 = connection.prepareStatement(sql1);
            stm1.setInt(1, chapter.getChapterId());
            stm1.executeUpdate();

            String sql2 = "DELETE FROM [dbo].[Chapter]\n"
                    + "      WHERE [chapter_id] = ?";
            PreparedStatement stm2 = connection.prepareStatement(sql2);
            stm2.setInt(1, chapter.getChapterId());
            stm2.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateChapter(Chapter chapter) {
        try {
            String sql = "UPDATE [dbo].[Chapter]\n"
                    + "   SET [chapter_title] = ?\n"
                    + "      ,[description] = ?\n"
                    + " WHERE [chapter_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, chapter.getChapterTitle());
            stm.setString(2, chapter.getDescription());
            stm.setInt(3, chapter.getChapterId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateLesson(Lesson lesson) {
        try {
            String sql = "UPDATE [dbo].[Lesson]\n"
                    + "   SET [lesson_tilte] = ?\n"
                    + "      ,[duration] = ?\n"
                    + "      ,[videoURL] = ?\n"
                    + "      ,[public_id] = ?\n"
                    + "      ,[description] = ?\n"
                    + " WHERE [lesson_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, lesson.getLessonTitle());
            stm.setInt(2, lesson.getDuration());
            stm.setString(3, lesson.getVideoURL());
            stm.setString(4, lesson.getPublicId());
            stm.setString(5, lesson.getDescription());
            stm.setInt(6, lesson.getLessonId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

//    //get course by course ID
//    public Course getCourseByID(int courseID) {
//        TopicDBContext tdb = new TopicDBContext();
//        try {
//            String sql = "  SELECT [course_id]\n"
//                    + "      ,[course_title]\n"
//                    + "      ,[topic_id]\n"
//                    + "      ,[is_public]\n"
//                    + "      ,[description]\n"
//                    + "      ,[rate]\n"
//                    + "      ,[img]\n"
//                    + "      ,[createdby]\n"
//                    + "  FROM [dbo].[Course]\n"
//                    + "  WHERE [course_id] = ?";
//
//            PreparedStatement stm = connection.prepareStatement(sql);
//            stm.setInt(1, courseID);
//            ResultSet rs = stm.executeQuery();
//            if (rs.next()) {
//
//                Course course = new Course();
//                course.setCourseId(rs.getInt("course_id"));
//                course.setCourseTitle(rs.getString("course_title"));
//                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
//                course.setStatus(rs.getBoolean("is_public"));
//                course.setDescription(rs.getString("description"));
//                course.setRate(rs.getFloat("rate"));
//                course.setImg(rs.getBytes("img"));
//                course.setCreatedBy(rs.getString("createdby"));
//                return course;
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
//            ex.printStackTrace();
//        }
//        return null;
//
//    }
    //get course target by course id
    public ArrayList<CourseTaget> getTargetByCourseID(int courseID) {
        ArrayList<CourseTaget> courseTargets = new ArrayList<>();
        try {
            String sql = "SELECT CT.[target_id]\n"
                    + "      ,CT.[target_detail]\n"
                    + "      ,CT.[course_id]\n"
                    + "  FROM [dbo].[Course_Target] CT INNER JOIN [Course] C ON C.[course_id] = CT.[course_id]\n"
                    + "  WHERE C.[course_id] = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseID);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                CourseTaget target = new CourseTaget();
                target.setTargetID(rs.getInt("target_id"));
                target.setTargetDetail(rs.getNString("target_detail"));
                target.setCourse(getCourse(rs.getInt("course_id")));
                courseTargets.add(target);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courseTargets;

    }

    public ArrayList<Course> getMyCourse(String username) {
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "SELECT C.[course_id]\n"
                    + "      ,C.[course_title]\n"
                    + "      ,C.[topic_id]\n"
                    + "      ,C.[is_public]\n"
                    + "      ,C.[duration]\n"
                    + "      ,C.[description]\n"
                    + "      ,C.[rate]\n"
                    + "      ,C.[img]\n"
                    + "      ,C.[createdby]\n"
                    + "  FROM [dbo].[Course] C INNER JOIN [Course_User] CU ON C.[course_id] = CU.[course_id]\n"
                    + "  WHERE CU.[username] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseTitle(rs.getString("course_title"));
                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
                course.setStatus(rs.getBoolean("is_public"));
                course.setDescription(rs.getString("description"));
                course.setRate(rs.getFloat("rate"));
                course.setImg(rs.getBytes("img"));
                course.setCreatedBy(rs.getString("createdby"));
                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;

    }

    public String getCourseNameByID(int id) {
        try {
            String sql = "SELECT [course_title]\n"
                    + "  FROM [Course]\n"
                    + "WHERE course_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String courseTitle = rs.getString("course_title");
                return courseTitle;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    //duc---------------------------------------------------------------------
    public int getCourseIDByTitle(String courseTitle) {
        try {
            String sql = "SELECT [course_id]\n"
                    + "  FROM [Course]\n"
                    + "  WHERE course_title = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, courseTitle);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int course_id = rs.getInt("course_id");
                return course_id;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public ArrayList<Course> searchCourse(int index, String query) {
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "SELECT [course_id]\n"
                    + "      ,[course_title]\n"
                    + "      ,[topic_id]\n"
                    + "      ,[is_public]\n"
                    + "      ,[duration]\n"
                    + "      ,[description]\n"
                    + "      ,[rate]\n"
                    + "      ,[img]\n"
                    + "      ,[createdby]\n"
                    + "  FROM [dbo].[Course]\n"
                    + "  WHERE [course_title] LIKE N'%" + query + "%'\n"
                    + "  ORDER BY [course_id]\n"
                    + "  OFFSET " + (index - 1) * 8 + " ROWS\n"
                    + "  FETCH FIRST 8 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseTitle(rs.getString("course_title"));
                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
                course.setStatus(rs.getBoolean("is_public"));
                course.setDescription(rs.getString("description"));
                course.setRate(rs.getFloat("rate"));
                course.setImg(rs.getBytes("img"));
                course.setCreatedBy(rs.getString("createdby"));

                int totalLearner = getNumberRegistered(course.getCourseId());
                course.setTotalLearner(totalLearner);
                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;

    }

    public ArrayList<Course> getFilterCourses(String query, ArrayList<Integer> topicIds, ArrayList<Integer> rateChoose, int index) {
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String topicStr = "";
            String rateStr = "";
            String sql = "SELECT [course_id]\n"
                    + "      ,[course_title]\n"
                    + "      ,[topic_id]\n"
                    + "      ,[is_public]\n"
                    + "      ,[duration]\n"
                    + "      ,[description]\n"
                    + "      ,[rate]\n"
                    + "      ,[img]\n"
                    + "      ,[createdby]\n"
                    + "  FROM [dbo].[Course]\n"
                    + "  WHERE [course_id] > 0 \n";
            if (query != null) {
                sql += "  AND [course_title] LIKE N'%" + query + "%'\n";
            }
            if (!topicIds.isEmpty()) {
                topicStr += " [topic_id]=" + topicIds.get(0) + " ";
                if (topicIds.size() > 1) {
                    for (int i = 1; i < topicIds.size(); i++) {
                        topicStr += "  OR [topic_id]=" + topicIds.get(i) + " ";
                    }
                }
                sql += "  AND (" + topicStr + ")";
            }

            if (!rateChoose.isEmpty()) {
                rateStr += "\n  ([rate] >= " + (rateChoose.get(0) - 1) + " AND [rate] <= " + rateChoose.get(0) + " ) ";
                if (rateChoose.size() > 1) {
                    for (int i = 1; i < rateChoose.size(); i++) {
                        rateStr += "OR ([rate]>=" + (rateChoose.get(i) - 1) + " AND [rate]<= " + rateChoose.get(i) + ") ";
                    }
                }
                sql += "  AND (" + rateStr + ")";
            }

            sql += "ORDER BY [course_id]\n"
                    + "  OFFSET " + (index - 1) * 8 + " ROWS\n"
                    + "  FETCH FIRST 8 ROWS ONLY";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseTitle(rs.getString("course_title"));
                course.setTopic(tdb.getTopic(rs.getInt("topic_id")));
                course.setStatus(rs.getBoolean("is_public"));
                course.setDescription(rs.getString("description"));
                course.setRate(rs.getFloat("rate"));
                course.setImg(rs.getBytes("img"));
                course.setCreatedBy(rs.getString("createdby"));

                int totalLearner = getNumberRegistered(course.getCourseId());
                course.setTotalLearner(totalLearner);
                courses.add(course);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return courses;
    }
}
