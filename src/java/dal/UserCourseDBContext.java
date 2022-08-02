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
import model.PricePackage;
import model.UserCourse;
import model.UserPackage;

/**
 *
 * @author Admin
 */
public class UserCourseDBContext extends DBContext {

    public boolean checkExistRegister(String username, int courseId) {
        String sql = "SELECT COUNT(*) AS Total FROM [Course_User]\n"
                + "      WHERE username = ? and course_id = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setInt(2, courseId);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getInt("Total") > 0) {
                    return true;
                }
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void deleteUserCourse(int CourseId, String userName) {
        String sql = "DELETE FROM [Course_User]\n"
                + "      WHERE username = ? and course_id = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, userName);
            stm.setInt(2, CourseId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int count(String username) {
        try {
            String sql = "SELECT COUNT(*) as Total FROM Course_User where username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }

    public void insertUserCourse(int courseID, String username) {
        String sql = "INSERT INTO [Course_User]\n"
                + "           ([course_id]\n"
                + "           ,[username])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, courseID);
            stm.setString(2, username);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<UserCourse> getUserCourseByUserName(String username, int pageindex, int pagesize) {
        ArrayList<UserCourse> usercourses = new ArrayList<>();
        try {
            String sql = "Select cu.course_id, cu.username, course_title, up.total_price,registration_date,valid_from,valid_to\n"
                    + "from Course_User as cu  inner join Course as c on cu.course_id = c.course_id \n"
                    + "	join User_Package as up on cu.username = up.username\n"
                    + "Where cu.username = ? \n"
                    + "order by username offset (" + pageindex + "-1) * " + pagesize + " row fetch next " + pagesize + " row only ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserCourse u = new UserCourse();
                u.setCourseID(rs.getInt("course_id"));
                u.setUserName(rs.getString("username"));
                u.setCourse_title(rs.getString("course_title"));
                u.setTotal_price(rs.getFloat("total_price"));
                u.setRegistration_date(rs.getDate("registration_date"));
                u.setValid_from(rs.getDate("valid_from"));
                u.setValid_to(rs.getDate("valid_to"));
                usercourses.add(u);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return usercourses;

    }

    public UserPackage getUserPackageByUserName(String username, int pageindex, int pagesize) {
        PricePackageDBContext pdb = new PricePackageDBContext();
        try {
            String sql = "Select up.package_id,p.package_title,up.username,up.total_price,up.[status],up.registration_date,up.valid_from,up.valid_to\n"
                    + "from User_Package as up join Package as p on  up.package_id= p.package_id	\n"
                    + "Where up.username = ? \n"
                    + "order by username offset (" + (pageindex - 1) + ") * " + pagesize + " row fetch next " + pagesize + " row only ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                UserPackage u = new UserPackage();
                PricePackage pa = pdb.getPackage(rs.getInt("package_id"));
                u.setP(pa);
                u.setPackageID(rs.getInt("package_id"));
                u.setPackageTitle(rs.getString("package_title"));
                u.setUsername(rs.getString("username"));
                u.setStatus(rs.getBoolean("status"));
                u.setTotal_price(rs.getFloat("total_price"));
                u.setRegistration_date(rs.getDate("registration_date"));
                u.setValid_from(rs.getDate("valid_from"));
                u.setValid_to(rs.getDate("valid_to"));
                return u;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserCourseDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
