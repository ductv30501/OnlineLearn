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
import model.UserCourse;
import model.UserPackage;

/**
 *
 * @author Admin
 */
public class UserPackageDBContext extends DBContext {

    public void deleteUserPackage(String username) {

        try {
            String sql = "DELETE FROM [dbo].[User_Package]\n"
                    + "      WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserPackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<UserPackage> getUserPackage() {
        ArrayList<UserPackage> userPackages = new ArrayList<>();
        try {
            String sql = "select u.username,u.email,up.package_id,up.registration_date,p.package_title, p.price,up.status,up.valid_from,up.valid_to,up.edit_by\n"
                    + "from User_Package as up inner join Package as p on up.package_id = p.package_id\n"
                    + "		join [User] as u on up.username = u.username ";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                UserPackage user_package = new UserPackage();
                user_package.setUsername(rs.getString("username"));
                user_package.setEmail(rs.getString("email"));
                user_package.setPackageID(rs.getInt("package_id"));
                user_package.setRegistration_date(rs.getDate("registration_date"));
                user_package.setPackageTitle(rs.getString("package_title"));
                user_package.setTotal_price(rs.getFloat("price"));
                user_package.setValid_from(rs.getDate("valid_from"));
                user_package.setValid_to(rs.getDate("valid_to"));
                user_package.setStatus(rs.getBoolean("status"));
                user_package.setLastUpdateBy(rs.getString("edit_by"));
                userPackages.add(user_package);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserPackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userPackages;
    }

    public UserPackage getUserPackageByUsername(String UserName, int packageID) {
        try {
            String sql = "select up.username,u.email,up.registration_date,p.package_title, p.price,up.status,up.valid_from,up.valid_to,up.edit_by\n"
                    + "from User_Package as up inner join Package as p on up.package_id = p.package_id\n"
                    + "		join [User] as u on up.username = u.username \n"
                    + "where up.username = ? and up.package_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, UserName);
            stm.setInt(2, packageID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                UserPackage user_package = new UserPackage();
                user_package.setUsername(UserName);
                user_package.setEmail(rs.getString("email"));
                user_package.setRegistration_date(rs.getDate("registration_date"));
                user_package.setPackageTitle(rs.getString("package_title"));
                user_package.setTotal_price(rs.getFloat("price"));
                user_package.setValid_from(rs.getDate("valid_from"));
                user_package.setValid_to(rs.getDate("valid_to"));
                user_package.setStatus(rs.getBoolean("status"));
                user_package.setLastUpdateBy(rs.getString("edit_by"));
                return user_package;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserPackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void editUserPackage(UserPackage userPackage, int packageID) {
        try {
            String sql = "UPDATE [dbo].[User_Package]\n"
                    + "   SET [valid_from] = ?\n"
                    + "      ,[valid_to] = ?\n"
                    + "      ,[status] = ?\n"
                    + "      ,[edit_by] = ?\n"
                    + " WHERE [username] = ? and [package_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, userPackage.getValid_from());
            stm.setDate(2, userPackage.getValid_to());
            stm.setBoolean(3, userPackage.isStatus());
            stm.setString(4, userPackage.getLastUpdateBy());
            stm.setString(5, userPackage.getUsername());
            stm.setInt(6, packageID);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserPackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public UserPackage getUserPackageByUsername(String username) {
        try {
            String sql = "select *\n"
                    + "from User_Package as up inner join Package as p on up.package_id = p.package_id\n"
                    + "join [User] as u on up.username = u.username \n"
                    + "where up.username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                UserPackage user_package = new UserPackage();
                user_package.setUsername(username);
                user_package.setEmail(rs.getString("email"));
                user_package.setRegistration_date(rs.getDate("registration_date"));
                user_package.setPackageTitle(rs.getString("package_title"));
                user_package.setTotal_price(rs.getFloat("price"));
                user_package.setValid_from(rs.getDate("valid_from"));
                user_package.setValid_to(rs.getDate("valid_to"));
                user_package.setStatus(rs.getBoolean("status"));
                user_package.setLastUpdateBy(rs.getString("edit_by"));
                return user_package;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserPackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertUserPackage(UserPackage userPackage) {
        String sql = "INSERT INTO [User_Package]\n"
                + "           ([username]\n"
                + "           ,[package_id]\n"
                + "           ,[status]\n"
                + "           ,[edit_by]\n"
                + "           ,[total_price]\n"
                + "           ,[registration_date]\n"
                + "           ,[valid_from]\n"
                + "           ,[valid_to])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, userPackage.getUsername());
            stm.setInt(2, userPackage.getPackageID());
            stm.setBoolean(3, userPackage.isStatus());
            stm.setString(4, userPackage.getLastUpdateBy());
            stm.setFloat(5, userPackage.getTotal_price());
            stm.setDate(6, userPackage.getRegistration_date());
            stm.setDate(7, userPackage.getValid_from());
            stm.setDate(8, userPackage.getValid_to());
            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(UserPackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
