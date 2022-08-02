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
import model.Comment;
import model.User;

/**
 *
 * @author win
 */
public class CommentDBContext extends DBContext {

    public void deleteComment(int commentId) {
        try {
//            connection.setAutoCommit(false);
            String s1 = "with t as (select cr.commentReply from commentReply cr join comment c\n"
                    + "on cr.commentId = c.commentId where c.commentId = ?) \n"
                    + "select commentReply\n"
                    + "into CommentReplyTempTable\n"
                    + "from t\n"
                    + "delete from CommentReply where commentId = ?\n"
                    + "delete from Comment where commentId in (select * from CommentReplyTempTable)\n"
                    + "drop table CommentReplyTempTable";
            PreparedStatement stm1 = connection.prepareStatement(s1);
            stm1.setInt(1, commentId);
            stm1.setInt(2, commentId);
            stm1.executeUpdate();

            String s2 = "delete from Comment where commentId = ?";
            PreparedStatement stm2 = connection.prepareStatement(s2);
            stm2.setInt(1, commentId);
            stm2.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } 
//        finally {
//            try {
//                connection.setAutoCommit(true);
//            } catch (SQLException ex) {
//                Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
    }

    public void deleteReply(int commentReplyId) {
        try {
//            connection.setAutoCommit(false);
            String s1 = "delete from CommentReply where commentReply = ?";
            PreparedStatement stm1 = connection.prepareStatement(s1);
            stm1.setInt(1, commentReplyId);
            stm1.executeUpdate();

            String s2 = "delete from Comment where commentId = ?";
            PreparedStatement stm2 = connection.prepareStatement(s2);
            stm2.setInt(1, commentReplyId);
            stm2.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } 
//        finally {
//            try {
//                connection.setAutoCommit(true);
//            } catch (SQLException ex) {
//                Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
    }

    public ArrayList<Comment> getComments(int chapterId) {
//        DBContext db = new DBContext();
        ArrayList<Comment> listComment = new ArrayList<>();
        try {
            String sql = "select * from Comment c join [user] u on u.username = c.username where chapterId = ? AND isReply = 0";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, chapterId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                int commentId = rs.getInt("commentId");
                c.setCommentId(commentId);
                c.setContent(rs.getString("content"));
                c.setDate(rs.getDate("date"));
                c.setReply(rs.getBoolean("isReply"));
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setAvatar(rs.getString("img"));
                c.setUser(user);

                Chapter ch = new Chapter();
                ch.setChapterId(rs.getInt("chapterId"));
                c.setReplies(getRepliesByComment(c));
                listComment.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } 
//        finally {
//            try {
//                if (connection != null || !connection.isClosed()) {
//                    connection.close();
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
        return listComment;
    }

    public Comment getCommentById(int commentId) {
//        DBContext db = new DBContext();
        try {
            String sql = "select * from Comment c join [user] u on c.username = u.username where commentId = ?  ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, commentId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Comment c = new Comment();
                c.setCommentId(commentId);
                c.setContent(rs.getString("content"));
                c.setDate(rs.getDate("date"));
                c.setReply(rs.getBoolean("isReply"));
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setAvatar(rs.getString("img"));
                c.setUser(user);

                Chapter ch = new Chapter();
                ch.setChapterId(rs.getInt("chapterId"));
                c.setReplies(getRepliesByComment(c));

                return c;
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } 
//        finally {
//            try {
//                if (connection != null || !connection.isClosed()) {
//                    connection.close();
//                }
//            } catch (SQLException ex) {
//                Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
//            }
//        }
        return null;
    }

    public ArrayList<Comment> getRepliesByComment(Comment c) {
        ArrayList<Comment> listComment = new ArrayList<>();
        String listReplyStr = "";
        try {
            String sql = "select * from Comment c\n"
                    + "join [user] u on u.username = c.username\n"
                    + "where c.commentId in (select cr.commentReply from Comment c\n"
                    + "left join CommentReply cr on c.commentId = cr.commentId\n"
                    + "where c.commentId = ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, c.getCommentId());
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Comment reply = new Comment();
                int replyId = rs.getInt("commentId");
                listReplyStr += replyId + " ";
                reply.setCommentId(replyId);
                reply.setContent(rs.getString("content"));
                reply.setDate(rs.getDate("date"));
                reply.setReply(rs.getBoolean("isReply"));
                User user = new User();
                user.setAvatar(rs.getString("img"));
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                reply.setUser(user);
                Chapter ch = new Chapter();
                ch.setChapterId(rs.getInt("chapterId"));
//                reply.setReplies(getRepliesByComment(replyId));

                listComment.add(reply);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        c.setListReplyStr(listReplyStr);
        return listComment;
    }

    public void insertComment(Comment comment) {

        try {
            String sql = "INSERT INTO [dbo].[Comment]\n"
                    + "           ([content]\n"
                    + "           ,[date]\n"
                    + "           ,[username]\n"
                    + "           ,[isReply]\n"
                    + "           ,[chapterId])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, comment.getContent());
            stm.setDate(2, comment.getDate());
            stm.setString(3, comment.getUser().getUsername());
            stm.setBoolean(4, comment.isReply());
            stm.setInt(5, comment.getChapter().getChapterId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void updateComment(Comment comment) {

        try {
            String sql = "UPDATE [dbo].[Comment]\n"
                    + "   SET [content] = ?\n"
                    + "      ,[date] = ?\n"
                    + " WHERE commentId = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, comment.getContent());
            stm.setDate(2, comment.getDate());
            stm.setInt(3, comment.getCommentId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public void insertCommentReply(int commentId, int replyId) {
        try {
            String sql = "INSERT INTO [dbo].[CommentReply]\n"
                    + "           ([commentId]\n"
                    + "           ,[commentReply])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, commentId);
            stm.setInt(2, replyId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public int getCurrentIdentity() {
        try {
            String sql = "SELECT IDENT_CURRENT('comment') as [current_id]";
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
public int InsertLikeComment(int commentId, String username) {
        int countLike = 0;

        try {
            String check = "select count(*) as a from Like_Comment where commentId = ? and username = ?";
            PreparedStatement stm = connection.prepareStatement(check);
            stm.setInt(1, commentId);
            stm.setString(2, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getInt("a") == 0) {
                    String sql = "INSERT INTO [Like_Comment]\n"
                            + "           ([commentId]\n"
                            + "           ,[username])\n"
                            + "     VALUES\n"
                            + "           (?\n"
                            + "           ,?)";
                    PreparedStatement stm1 = connection.prepareStatement(sql);
                    stm1.setInt(1, commentId);
                    stm1.setString(2, username);
                    stm1.executeUpdate();
                } else {
                    String sql = "delete from Like_Comment where commentId = ? and username = ?";
                    PreparedStatement stm1 = connection.prepareStatement(sql);
                    stm1.setInt(1, commentId);
                    stm1.setString(2, username);
                    stm1.executeUpdate();
                }
                    String count = "select count(*) as a from Like_Comment where commentId = ?";
                    PreparedStatement stm2 = connection.prepareStatement(count);
                    stm2.setInt(1, commentId);
                    ResultSet rs1 = stm2.executeQuery();
                    if (rs1.next()) {
                        countLike = rs1.getInt("a");
                    }
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return countLike;
    }
}
