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
import model.Option;
import model.Question;

/**
 *
 * @author Admin
 */
public class QuestionDBContext extends DBContext {

    public ArrayList<Question> getQuestionByChapterId(int chapterId) {
        ArrayList<Question> questions = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [Question] WHERE chapter_id  = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Question question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                question.setQuestionTitle(rs.getString("question_content"));
                question.setPoint(rs.getInt("point"));
                Chapter chapter = new Chapter();

                chapter.setChapterId(rs.getInt("chapter_id"));
                question.setChapter(chapter);

                question.setQuestionLevel(rs.getInt("question_level"));
                questions.add(question);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return questions;
    }

    public Question GetQuestion(String question_id) {
        try {
            String sql = "SELECT  [question_id]\n"
                    + "      ,[question_content]\n"
                    + "      ,[point]\n"
                    + "      ,[chapter_id]\n"
                    + "      ,[question_level]\n"
                    + "FROM [Question]\n"
                    + "Where question_id  = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, question_id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Question question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                question.setQuestionTitle(rs.getString("question_content"));
                question.setPoint(rs.getInt("point"));
                Chapter chapter = new Chapter();
                chapter.setChapterId(rs.getInt("chapter_id"));
                question.setChapter(chapter);
                question.setQuestionLevel(rs.getInt("question_level"));
                return question;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<Option> GetOptionsOfQuestion(String question_id) {
        ArrayList<Option> options = new ArrayList<>();
        try {
            String sql = "SELECT [option_id]\n"
                    + "      ,[option_detail]\n"
                    + "      ,[is_correct]\n"
                    + "      ,[question_id]\n"
                    + "FROM [Option]\n"
                    + "WHERE question_id = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, question_id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Option option = new Option();
                option.setOptionId(rs.getInt("option_id"));
                option.setOptionDetail(rs.getString("option_detail"));
                option.setIsCorrect(rs.getBoolean("is_correct"));
                options.add(option);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return options;
    }

    public void updateOption(Option option) {
        try {
            String sql = "UPDATE [Option]\n"
                    + "   SET [option_detail] = ?\n"
                    + "      ,[is_correct] = ?\n"
                    + " WHERE option_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, option.getOptionDetail());
            ps.setBoolean(2, option.isIsCorrect());
            ps.setInt(3, option.getOptionId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteQuestion(int chapterId) {
        try {
            String sql = "DELETE FROM [option] \n"
                    + "WHERE option_id in (SELECT o.option_id FROM [option] o join question q \n"
                    + "on o.question_id  = q.question_id\n"
                    + "WHERE q.chapter_id = ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);

            stm.executeUpdate();

            String sql2 = "DELETE FROM question \n"
                    + "WHERE question_id in (SELECT q.question_id FROM question q \n"
                    + "WHERE q.chapter_id = ?)";
            PreparedStatement stm2 = connection.prepareStatement(sql2);
            stm2.setInt(1, chapterId);

            stm2.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void UpdateQuestion(Question question) {
        try {
            String sql = "UPDATE [Question]\n"
                    + "   SET [question_content] = ?\n"
                    + "      ,[point] = ?\n"
                    + "      ,[chapter_id] = ?\n"
                    + "      ,[question_level] = ?\n"
                    + " WHERE question_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, question.getQuestionTitle());
            ps.setInt(2, question.getPoint());
            ps.setInt(3, question.getChapter().getChapterId());
            ps.setInt(4, question.getQuestionLevel());
            ps.setInt(5, question.getQuestionId());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int InsertOption(Option option) {
        String sql = "INSERT INTO [Option]\n"
                + "           ([option_detail]\n"
                + "           ,[is_correct]\n"
                + "           ,[question_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, option.getOptionDetail());
            stm.setBoolean(2, option.isIsCorrect());
            stm.setInt(3, option.getQuestion_id());
            stm.executeUpdate();
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public int DeleteOption(int option_id) {
        try {
            String sql = "DELETE FROM [Option]\n"
                    + "      WHERE option_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, option_id);
            stm.executeUpdate();
            return 1;
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
            return 0;
        }
    }

    public Option GetOption(int option_id) {
        Option option = new Option();
        try {
            String sql = "SELECT [option_id]\n"
                    + "      ,[option_detail]\n"
                    + "      ,[is_correct]\n"
                    + "      ,[question_id]\n"
                    + "FROM [Option]\n"
                    + "WHERE option_id = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, option_id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {

                option.setOptionId(rs.getInt("option_id"));
                option.setOptionDetail(rs.getString("option_detail"));
                option.setIsCorrect(rs.getBoolean("is_correct"));
                option.setQuestion_id(rs.getInt("question_id"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(QuestionDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return option;
    }

}
