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
import model.Option;
import model.Question;
import model.QuestionType;
import model.Quiz;
import model.User;
import model.UserQuestionDetail;
import model.UserQuiz;
import model.UserQuizDetail;

/**
 *
 * @author ADMIN
 */
public class QuizDBContext extends DBContext {
    
    public Quiz getQuizByChapter(int chapterId) {
        PreparedStatement stm = null;
        try {
            String sql = "SELECT [quizz_id]\n"
                    + "      ,[quizz_title]\n"
                    + "      ,[description]\n"
                    + "      ,[topass]\n"
                    + "      ,[chapter_id]\n"
                    + "      ,[duration]\n"
                    + "  FROM [dbo].[Quizz]\n"
                    + " WHERE chapter_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Quiz quiz = new Quiz();
                Chapter chapter = new Chapter();
                chapter.setChapterId(chapterId);
                quiz.setChapter(chapter);
                quiz.setQuizId(rs.getInt("quizz_id"));
                quiz.setQuizTitle(rs.getString("quizz_title"));
                quiz.setDescription(rs.getString("description"));
                quiz.setDuration(rs.getInt("duration"));
                quiz.setToPass(rs.getInt("topass"));
                quiz.setQuestions(getQuestionsByChapterId(chapterId));
                return quiz;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            
        }
        return null;
    }
    
    public ArrayList<Question> getQuestionsByChapterId(int chapterId) {
        ArrayList<Question> questions = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT q.[question_id]\n"
                    + ",q.[question_content]\n"
                    + ",q.[point]\n"
                    + ",q.[chapter_id]\n"
                    + ",q.[question_level]\n"
                    + ",q.[question_type_id]\n"
                    + ",qt.[question_type_name]\n"
                    + "FROM [dbo].[Question] q join [Question_Type] qt \n"
                    + "on q.question_type_id = qt.question_type_id\n"
                    + "WHERE q.[chapter_id] = ?";
            
            stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int questionId = rs.getInt("question_id");
                
                Question question = new Question();
                question.setQuestionId(questionId);
                question.setQuestionTitle(rs.getString("question_content"));
                question.setPoint(rs.getInt("point"));
                
                Chapter chapter = new Chapter();
                chapter.setChapterId(chapterId);
                question.setChapter(chapter);
                question.setQuestionLevel(rs.getInt("question_level"));
                
                QuestionType questionType = new QuestionType();
                questionType.setQuestionTypeId(rs.getInt("question_type_id"));
                questionType.setQuestionTypeName(rs.getString("question_type_name"));
                
                ArrayList<Option> options = getOptionByQuestionId(questionId);
                question.setOptions(options);
                question.setQuestionType(questionType);
                questions.add(question);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return questions;
        
    }
    
    public ArrayList<Option> getOptionByQuestionId(int questionId) {
        ArrayList<Option> options = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "SELECT [option_id]\n"
                    + "      ,[option_detail]\n"
                    + "      ,[is_correct]\n"
                    + "      ,[question_id]\n"
                    + "  FROM [dbo].[Option]\n"
                    + " WHERE [question_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, questionId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Option option = new Option();
                option.setOptionId(rs.getInt("option_id"));
                option.setOptionDetail(rs.getString("option_detail"));
                option.setIsCorrect(rs.getBoolean("is_correct"));
                
                Question question = new Question();
                question.setQuestionId(questionId);
                
                option.setQuestion(question);
                options.add(option);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return options;
        
    }
    
    public void insertUserQuiz(UserQuiz userQuiz) {
        
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[User_Quizz]\n"
                    + "           ([username]\n"
                    + "           ,[quizz_id]\n"
                    + "           ,[score]\n"
                    + "           ,[taken_date])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, userQuiz.getUser().getUsername());
            stm.setInt(2, userQuiz.getQuiz().getQuizId());
            stm.setInt(3, userQuiz.getScore());
            stm.setDate(4, userQuiz.getTakenDate());
            stm.executeUpdate();
            
            ArrayList<UserQuizDetail> userQuizDetails = userQuiz.getUserQuizDetails();
            for (UserQuizDetail userQuizDetail : userQuizDetails) {
                insertUserQuizDetail(userQuizDetail);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public void insertUserQuizDetail(UserQuizDetail userQuizDetail) {
        
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[User_Quizz_Detail]\n"
                    + "           ([username]\n"
                    + "           ,[quizz_id]\n"
                    + "           ,[question_id])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, userQuizDetail.getUser().getUsername());
            stm.setInt(2, userQuizDetail.getQuiz().getQuizId());
            stm.setInt(3, userQuizDetail.getQuestion().getQuestionId());
            stm.executeUpdate();
            
            ArrayList<UserQuestionDetail> userQuestionDetails = userQuizDetail.getUserQuestionDetails();
            
            for (UserQuestionDetail userQuestionDetail : userQuestionDetails) {
                insertUserQuestionDetail(userQuestionDetail);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public void insertUserQuestionDetail(UserQuestionDetail userQuestionDetail) {
        
        PreparedStatement stm = null;
        try {
            String sql = "INSERT INTO [dbo].[User_Question_Detail]\n"
                    + "           ([username]\n"
                    + "           ,[quizz_id]\n"
                    + "           ,[question_id]\n"
                    + "           ,[option_id])\n"
                    + "     VALUES\n"
                    + "           (?, ? ,?, ?)";
            stm = connection.prepareStatement(sql);
            stm.setString(1, userQuestionDetail.getUser().getUsername());
            stm.setInt(2, userQuestionDetail.getQuiz().getQuizId());
            stm.setInt(3, userQuestionDetail.getQuestion().getQuestionId());
            stm.setInt(4, userQuestionDetail.getOption().getOptionId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public int getQuizIdByChapterId(int chapterId) {
        PreparedStatement stm = null;
        try {
            String sql = "Select quizz_id from quizz where chapter_id = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("quizz_id");
            }
            
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public void deleteUserQuestionDetail(String username, int quizId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[User_Question_Detail]\n"
                    + "      WHERE [username] = ? and [quizz_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public void deleteUserQuizDetail(String username, int quizId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[User_Quizz_Detail]\n"
                    + "      WHERE [username] = ? and [quizz_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void removeUserQuiz(String username, int quizId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[User_Quizz]\n"
                    + "      WHERE [username] = ? and [quizz_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteUserQuestionDetail(int quizId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[User_Question_Detail]\n"
                    + "WHERE [quizz_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    public void deleteUserQuizDetail(int quizId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[User_Quizz_Detail]\n"
                    + "      WHERE [quizz_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void removeUserQuiz(int quizId) {
        PreparedStatement stm = null;
        try {
            String sql = "DELETE FROM [dbo].[User_Quizz]\n"
                    + "      WHERE [quizz_id] = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, quizId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public void deleteQuizByQuizId(int quizId) {
        deleteUserQuestionDetail(quizId);
        deleteUserQuizDetail(quizId);
        removeUserQuiz(quizId);
        DeleteQuiz(String.valueOf(quizId));
    }
    
    public void deleteUserQuiz(String username, int quizId) {
        deleteUserQuestionDetail(username, quizId);
        deleteUserQuizDetail(username, quizId);
        removeUserQuiz(username, quizId);
    }
    
    public ArrayList<Quiz> getQuizDone(int courseId, String username) {
        ArrayList<Quiz> quizes = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "select q.quizz_id from user_quizz uq join quizz q\n"
                    + "on uq.quizz_id = q.quizz_id\n"
                    + "join Chapter ch on q.chapter_id = ch.chapter_id\n"
                    + "join Course co on co.course_id = ch.course_id\n"
                    + "WHERE co.course_id = ? AND uq.username = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, courseId);
            stm.setString(2, username);
            
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setQuizId(rs.getInt("quizz_id"));
                quizes.add(quiz);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
        }
        return quizes;
    }

    //-------------------------------------------------------------------------------------------------------------
    public ArrayList<Quiz> getQuizListByChapter(int chapId) {
        ArrayList<Quiz> quizz = new ArrayList<>();
        
        try {
            String sql = "SELECT Q.[quizz_id]\n"
                    + "      ,Q.[quizz_title]\n"
                    + "      ,Q.[description]\n"
                    + "      ,Q.[topass]\n"
                    + "      ,Q.[chapter_id]\n"
                    + "  FROM [dbo].[Quizz] Q INNER JOIN [Chapter] C ON C.[chapter_id] = Q.[chapter_id]\n"
                    + "  WHERE Q.[chapter_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Quiz q = new Quiz();
                q.setQuizId(rs.getInt("quizz_id"));
                q.setQuizTitle(rs.getString("quizz_title"));
                q.setToPass(rs.getInt("topass"));
                q.setDescription("description");
                
                Chapter chap = new Chapter();
                chap.setChapterId(rs.getInt("chapter_id"));
                
                q.setChapter(chap);
                
                ArrayList<Question> questions = getQuestionsByQuiz(q.getQuizId());
                q.setQuestions(questions);
                quizz.add(q);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return quizz;
        
    }
    
    public ArrayList<Question> getQuestionsByQuiz(int quizId) {
        ArrayList<Question> questions = new ArrayList<>();
        PreparedStatement stm = null;
        try {
            String sql = "  SELECT q.[question_id]\n"
                    + "         ,q.[question_content]\n"
                    + "         ,q.[point]\n"
                    + "         ,q.[chapter_id]\n"
                    + "         ,q.[question_level]\n"
                    + "         ,q.[question_type_id]\n"
                    + "         ,qt.[question_type_name]\n"
                    + "  FROM [dbo].[Question] q join [Question_Type] qt on q.question_type_id = qt.question_type_id\n"
                    + "                          JOIN [Quizz] Quiz ON Quiz.[chapter_id]=q.[chapter_id]\n"
                    + "  WHERE Quiz.[quizz_id] = ?";
            
            stm = connection.prepareStatement(sql);
            stm.setInt(1, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                int questionId = rs.getInt("question_id");
                
                Question question = new Question();
                question.setQuestionId(questionId);
                question.setQuestionTitle(rs.getString("question_content"));
                question.setPoint(rs.getInt("point"));
                
                Chapter chapter = new Chapter();
                chapter.setChapterId(quizId);
                question.setChapter(chapter);
                question.setQuestionLevel(rs.getInt("question_level"));
                
                QuestionType questionType = new QuestionType();
                questionType.setQuestionTypeId(rs.getInt("question_type_id"));
                questionType.setQuestionTypeName(rs.getString("question_type_name"));
                
                ArrayList<Option> options = getOptionByQuestionId(questionId);
                question.setOptions(options);
                question.setQuestionType(questionType);
                questions.add(question);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return questions;
    }

    /**
     * get quiz mark
     *
     * @param quiz
     * @param user
     * @return
     */
    public int getQuizMark(Quiz quiz, User user) {
        int totalMark = 0;
        try {
            String sqlOneChoice = "SELECT UQuesD.[username]\n"
                    + "       ,UQuesD.[quizz_id]\n"
                    + "       ,SUM(Q.[point]) AS Score\n"
                    + "FROM [dbo].[User_Question_Detail] UQuesD INNER JOIN [Option] O ON  UQuesD.[option_id]=O.[option_id]\n"
                    + "                                         INNER JOIN [Question] Q ON Q.[question_id]=O.[question_id]\n"
                    + "WHERE UQuesD.[username]=N'" + user.getUsername() + "' and UQuesD.[quizz_id]=" + quiz.getQuizId() + " AND O.[is_correct]=1 AND Q.[question_type_id]=2\n"
                    + "GROUP BY UQuesD.[username]\n"
                    + "        ,UQuesD.[quizz_id]";
            
            PreparedStatement stmOneChoice = connection.prepareStatement(sqlOneChoice);
//            stmOneChoice.setString(1, user.getUsername());
//            stmOneChoice.setInt(2, quiz.getQuizId());
            ResultSet rs = stmOneChoice.executeQuery();
            while (rs.next()) {
                
                int totalScoreOneChoice = rs.getInt("Score");
                totalMark += totalScoreOneChoice;
            }
            
            String sqlMultipleChoice = "SELECT DISTINCT UQuesD.[username]\n"
                    + "       ,UQuesD.[quizz_id]\n"
                    + "       ,Q.[question_id]\n"
                    + "       ,SUM(DISTINCT Q.[point]) AS Score\n"
                    + "FROM [dbo].[User_Question_Detail] UQuesD FULL JOIN [Option] O ON  UQuesD.[option_id]=O.[option_id]\n"
                    + "                                         FULL JOIN [Question] Q ON Q.[question_id]=O.[question_id]\n"
                    + "WHERE UQuesD.[username]=? and UQuesD.[quizz_id]=? AND O.[is_correct]=1 AND Q.[question_type_id]=1 \n"
                    + "GROUP BY UQuesD.[username]\n"
                    + "        ,UQuesD.[quizz_id]\n"
                    + "        ,Q.[question_id]\n"
                    + "HAVING COUNT(Q.[question_id])=(SELECT COUNT(*) FROM [OPTION] WHERE [question_id]=Q.[question_id] AND [is_correct]=1)";
            PreparedStatement stmMultipleChoice = connection.prepareStatement(sqlMultipleChoice);
            stmMultipleChoice.setString(1, user.getUsername());
            stmMultipleChoice.setInt(2, quiz.getQuizId());
            ResultSet rsMultiple = stmMultipleChoice.executeQuery();
            while(rsMultiple.next()) {
                int totalScoreMutilChoice = rsMultiple.getInt("Score");
                totalMark += totalScoreMutilChoice;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return totalMark;
    }

    //-------------------------------------------------------------------------------------
    /**
     * Get quiz by quiz id
     *
     * @param quizId
     * @return
     */
    public Quiz getQuizById(int quizId) {
        
        try {
            String sql = "SELECT * FROM [dbo].[Quizz] q Join [Chapter] ch\n"
                    + "on q.chapter_id = ch.chapter_id join [Course] c \n"
                    + "on c.course_id = ch.course_id\n"
                    + "WHERE [quizz_id]= ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, quizId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Quiz q = new Quiz();
                q.setQuizId(rs.getInt("quizz_id"));
                q.setQuizTitle(rs.getString("quizz_title"));
                q.setToPass(rs.getInt("topass"));
                q.setDescription(rs.getString("description"));
                
                q.setDuration(rs.getInt("duration"));
                
                Chapter chap = new Chapter();
                chap.setChapterId(rs.getInt("chapter_id"));
                
                q.setChapter(chap);
                
                q.setCourse(new Course(rs.getInt("course_id")));
                
                ArrayList<Question> questions = getQuestionsByQuiz(quizId);
                q.setQuestions(questions);
                
                return q;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
        
    }

    /**
     * Get question answered of user
     *
     * @param username
     * @param quizId
     * @return
     */
    public ArrayList<UserQuizDetail> getQuestionsAnswered(String username, int quizId) {
        ArrayList<UserQuizDetail> uQuizDetails = new ArrayList<>();
        try {
            String sql = "  SELECT [username]\n"
                    + "      ,[quizz_id]\n"
                    + "      ,[question_id]\n"
                    + "  FROM [dbo].[User_Quizz_Detail]\n"
                    + "  WHERE [username]=? AND [quizz_id]=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, quizId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserQuizDetail detail = new UserQuizDetail();
                Question question = new Question();
                question.setQuestionId(rs.getInt("question_id"));
                detail.setQuestion(question);
                
                Quiz quiz = new Quiz();
                quiz.setQuizId(rs.getInt("quizz_id"));
                detail.setQuiz(quiz);
                
                User user = new User();
                user.setUsername(rs.getString("username"));
                detail.setUser(user);
                
                ArrayList<UserQuestionDetail> uQuestionDetail = getUserQuestionDetails(user, quiz, question);
                detail.setUserQuestionDetails(uQuestionDetail);
                
                uQuizDetails.add(detail);
                
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return uQuizDetails;
        
    }

    /**
     * Get user option of each question
     *
     * @param username
     * @param quizId
     * @param questionId
     * @return
     */
    private ArrayList<UserQuestionDetail> getUserQuestionDetails(User user, Quiz quiz, Question question) {
        ArrayList<UserQuestionDetail> uQuesDetails = new ArrayList<>();
        try {
            String sql = "  SELECT [username]\n"
                    + "      ,[quizz_id]\n"
                    + "      ,[question_id]\n"
                    + "      ,[option_id]\n"
                    + "  FROM [dbo].[User_Question_Detail]\n"
                    + "  WHERE [username]=? AND [quizz_id]=? AND [question_id]=?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, user.getUsername());
            stm.setInt(2, quiz.getQuizId());
            stm.setInt(3, question.getQuestionId());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserQuestionDetail quesDetail = new UserQuestionDetail();
                quesDetail.setUser(user);
                quesDetail.setQuiz(quiz);
                quesDetail.setQuestion(question);
                Option o = new Option();
                o.setOptionId(rs.getInt("option_id"));
                quesDetail.setOption(o);
                uQuesDetails.add(quesDetail);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return uQuesDetails;
        
    }

    //----duc------------------------------------------------------------------------
    public int CountQuiz(String course, String chapter, String search) {
        try {
            String sql = "Select COUNT(*) as total from Quizz as q \n"
                    + "	join Chapter as c on q.chapter_id = c.chapter_id\n"
                    + "	join Course as co on co.course_id = c.course_id \n"
                    + "Where q.quizz_id > -1\n"
                    + " " + ((!course.isEmpty()) ? " and co.course_id =" + course + "" : "")
                    + " " + ((!chapter.isEmpty()) ? " and  c.chapter_id=" + chapter + "" : "")
                    + " " + ((!search.isEmpty()) ? " and (q.description like ? or q.quizz_title like ?)" : "");
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
                stm.setString(2, search + "%");
            }
            
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
        
    }
    
    public ArrayList<Quiz> GetQuizies(String course, String chapter, String search, int index, int number, String sort, String obj) {
        ArrayList<Quiz> quizies = new ArrayList<>();
        try {
            String sql = "Select q.quizz_id, q.chapter_id, q.description,q.numberQuestion , q.quizz_title, q.topass,"
                    + " c.chapter_title, co.course_title from Quizz as q \n"
                    + "	join Chapter as c on q.chapter_id = c.chapter_id\n"
                    + "	join Course as co on co.course_id = c.course_id \n"
                    + "Where q.quizz_id > -1 "
                    + " " + ((!course.isEmpty()) ? " and co.course_id =" + course + " " : "")
                    + " " + ((!chapter.isEmpty()) ? " and  c.chapter_id=" + chapter + " " : "")
                    + " " + ((!search.isEmpty()) ? " and (q.description like ? or q.quizz_title like ?)" : "");
            sql += " order by " + obj + " " + sort + " offset " + (index - 1) * number + " row fetch next " + number + " row only";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
                stm.setString(2, search + "%");
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setQuizId(rs.getInt("quizz_id"));
                quiz.setQuizTitle(rs.getString("quizz_title"));
                quiz.setDescription(rs.getString("description"));
                quiz.setToPass(rs.getInt("topass"));
                
                Chapter ch = new Chapter();
                ch.setChapterId(rs.getInt("chapter_id"));
                ch.setChapterTitle(rs.getString("chapter_title"));
                
                quiz.setChapter(ch);
                
                quiz.setCourse(new Course(rs.getString("course_title")));
                quiz.setNumberQuestion(rs.getInt("numberQuestion"));
                quizies.add(quiz);
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return quizies;
        
    }
    
    public void insertQuiz(Quiz quiz) {
        String sql = "INSERT INTO [Quizz]\n"
                + "           ([quizz_title]\n"
                + "           ,[description]\n"
                + "           ,[topass]\n"
                + "           ,[duration]\n"
                + "           ,[numberQuestion]\n"
                + "           ,[chapter_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, quiz.getQuizTitle());
            stm.setString(2, quiz.getDescription());
            stm.setInt(3, quiz.getToPass());
            stm.setInt(4, quiz.getDuration());
            stm.setInt(5, quiz.getNumberQuestion());
            stm.setInt(6, quiz.getChapter().getChapterId());
            stm.executeUpdate();
            
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public boolean CheckUserQuizExist(String quiz_id) {
        try {
            String sql = "select COUNT(*) as total from User_Quizz\n"
                    + "  where quizz_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, quiz_id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int total = rs.getInt("total");
                if (total == 0) {
                    return false;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }
    
    public void DeleteQuiz(String quiz_id) {
        String sql = "DELETE FROM [Quizz]\n"
                + "      WHERE quizz_id = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, quiz_id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }
    
    public Quiz GetQuiz(String quiz_id) {
        try {
            String sql = "SELECT  q.[quizz_id]\n"
                    + "      ,q.[quizz_title]\n"
                    + "      ,q.[description]\n"
                    + "      ,q.[topass]\n"
                    + "      ,q.[duration]\n"
                    + "      ,q.[numberQuestion]\n"
                    + "      ,q.[chapter_id]\n"
                    + "      ,c.chapter_title\n"
                    + "      ,co.course_title\n"
                    + "  FROM [Quizz] as q join Chapter as c on q.chapter_id = c.chapter_id\n"
                    + "		join Course as co on c.course_id = co.course_id\n"
                    + "  WHERE quizz_id = ?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, quiz_id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Quiz quiz = new Quiz();
                quiz.setQuizId(rs.getInt("quizz_id"));
                quiz.setQuizTitle(rs.getString("quizz_title"));
                quiz.setDescription(rs.getString("description"));
                quiz.setToPass(rs.getInt("topass"));
                Chapter chapter = new Chapter();
                chapter.setChapterId(rs.getInt("chapter_id"));
                chapter.setChapterTitle(rs.getString("chapter_title"));
                quiz.setDuration(rs.getInt("duration"));
                quiz.setChapter(chapter);
                
                quiz.setCourse(new Course(rs.getString("course_title")));
                quiz.setNumberQuestion(rs.getInt("numberQuestion"));
                return quiz;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
    public int CountNumberQuestionChapter(int course, int chapter) {
        try {
            String sql = "select COUNT(*) as total from Question as q \n"
                    + "		join Chapter as c on q.chapter_id = c.chapter_id\n"
                    + "		join Course as co on c.course_id = co.course_id\n"
                    + "where q.chapter_id = ? and c.course_id = ?";
            
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapter);
            stm.setInt(2, course);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                int number = rs.getInt("total");
                return number;
            }
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
    
    public void updateQuiz(Quiz quiz) {
        String sql = "UPDATE [Quizz]\n"
                + " SET [quizz_title] = ?\n"
                + "      ,[description] = ?\n"
                + "      ,[topass] = ?\n"
                + "      ,[chapter_id] = ?\n"
                + "      ,[numberQuestion] = ?\n"
                + "      ,[duration] = ?\n"
                + " WHERE quizz_id = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, quiz.getQuizTitle());
            stm.setString(2, quiz.getDescription());
            stm.setInt(3, quiz.getToPass());
            stm.setInt(4, quiz.getChapter().getChapterId());
            stm.setInt(5, quiz.getNumberQuestion());
            stm.setInt(6, quiz.getDuration());
            stm.setInt(7, quiz.getQuizId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(QuizDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public ArrayList<Course> SearchCourse(String searchBy) {
        TopicDBContext tdb = new TopicDBContext();
        ArrayList<Course> courses = new ArrayList<>();
        try {
            String sql = "SELECT [course_id]\n"
                    + "      ,[course_title]\n"
                    + "      ,[topic_id]\n"
                    + "      ,[is_public]\n"
                    + "      ,[description]\n"
                    + "      ,[rate]\n"
                    + "      ,[img]\n"
                    + "      ,[createdby]\n"
                    + "  FROM [Course]"
                    + "WHERE course_title like ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + searchBy + "%");
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
    
}
