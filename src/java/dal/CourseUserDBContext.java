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
import model.CourseUser;

/**
 *
 * @author ADMIN
 */
public class CourseUserDBContext extends DBContext{

    //get list of review by course id
    public ArrayList<CourseUser> getReviewByCourse(int courseID) {

        CourseDBContext courseDB = new CourseDBContext();
        UserDBContext userDB = new UserDBContext();
        ArrayList<CourseUser> reviewList = new ArrayList<>();
        try {
            String sql = " SELECT CU.[course_id]\n"
                    + "      ,CU.[username]\n"
                    + "      ,CU.[star]\n"
                    + "      ,CU.[comment]\n"
                    + "  FROM [dbo].[Course_User] CU INNER JOIN [Course] C ON C.[course_id] = CU.[course_id]\n"
                    + "  WHERE C.[course_id] = ? AND CU.[star] IS NOT NULL";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                CourseUser cu = new CourseUser();
                cu.setUser(userDB.getUser(rs.getString("username")));
                cu.setStar(rs.getInt("star"));
                cu.setComment(rs.getNString("comment"));
                cu.setCourse(courseDB.getCourse(rs.getInt("course_id")));
                reviewList.add(cu);
            }
        } catch (SQLException ex) {
            Logger.getLogger(CourseUserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return reviewList;
    }

    public int getCountStar(int courseID, int i) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) AS [starcount]\n"
                    + "  FROM [dbo].[Course_User]\n"
                    + "  WHERE star =? AND course_id=?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, i);
            stm.setInt(2, courseID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("starcount");
                return count;
            }

        } catch (SQLException ex) {
            Logger.getLogger(CourseUserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;

    }
}
