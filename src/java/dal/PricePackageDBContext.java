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

/**
 *
 * @author ADMIN
 */
public class PricePackageDBContext extends DBContext {

    public ArrayList<PricePackage> getPackages() {
        ArrayList<PricePackage> packages = new ArrayList<>();
        try {
            String sql = "SELECT [package_id]\n"
                    + "      ,[package_title]\n"
                    + "      ,[price]\n"
                    + "      ,[duration]\n"
                    + "      ,[duration_type]\n"
                    + "      ,[user_benefit]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Package]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                PricePackage pack = new PricePackage();
                pack.setPackageId(rs.getInt("package_id"));
                pack.setPackageTitle(rs.getString("package_title"));
                pack.setPrice(rs.getFloat("price"));
                pack.setDuration(rs.getInt("duration"));
                pack.setDurationtype(rs.getString("duration_type"));
                pack.setUserBenefit(rs.getString("user_benefit"));
                pack.setStatus(rs.getBoolean("status"));

                packages.add(pack);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PricePackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return packages;
    }
    public ArrayList<PricePackage> getAvailablePackages() {
        ArrayList<PricePackage> packages = new ArrayList<>();
        try {
            String sql = "SELECT [package_id]\n"
                    + "      ,[package_title]\n"
                    + "      ,[price]\n"
                    + "      ,[duration]\n"
                    + "      ,[duration_type]\n"
                    + "      ,[user_benefit]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Package]" 
                    + "  WHERE [status] = 1"; 
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                PricePackage pack = new PricePackage();
                pack.setPackageId(rs.getInt("package_id"));
                pack.setPackageTitle(rs.getString("package_title"));
                pack.setPrice(rs.getFloat("price"));
                pack.setDuration(rs.getInt("duration"));
                pack.setDurationtype(rs.getString("duration_type"));
                pack.setUserBenefit(rs.getString("user_benefit"));
                pack.setStatus(rs.getBoolean("status"));

                packages.add(pack);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PricePackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return packages;
    }

    public PricePackage getPackage(int packageId) {
        try {
            String sql = "SELECT [package_title]\n"
                    + "      ,[price]\n"
                    + "      ,[duration]\n"
                    + "      ,[duration_type]\n"
                    + "      ,[user_benefit]\n"
                    + "      ,[status]\n"
                    + "  FROM [dbo].[Package]\n"
                    + "  WHERE [package_id] = ?\n";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, packageId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                PricePackage pack = new PricePackage();
                pack.setPackageId(packageId);
                pack.setPackageTitle(rs.getString("package_title"));
                pack.setPrice(rs.getFloat("price"));
                pack.setDuration(rs.getInt("duration"));
                pack.setDurationtype(rs.getString("duration_type"));
                pack.setUserBenefit(rs.getString("user_benefit"));
                pack.setStatus(rs.getBoolean("status"));

                return pack;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PricePackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertPackage(PricePackage pack) {
        try {
            String sql = "INSERT INTO [dbo].[Package]\n"
                    + "           ([package_title]\n"
                    + "           ,[price]\n"
                    + "           ,[duration]\n"
                    + "           ,[duration_type]\n"
                    + "           ,[user_benefit]\n"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, pack.getPackageTitle());
            stm.setFloat(2, pack.getPrice());
            stm.setInt(3, pack.getDuration());
            stm.setString(4, pack.getDurationtype());
            stm.setString(5, pack.getUserBenefit());
            stm.setBoolean(6, pack.isStatus());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PricePackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void editPackage(PricePackage pack) {
        try {
            String sql = "UPDATE [dbo].[Package]\n"
                    + "   SET [package_title] = ?\n"
                    + "      ,[price] = ?\n"
                    + "      ,[duration] = ?\n"
                    + "      ,[duration_type] = ?\n"
                    + "      ,[user_benefit] = ?\n"
                    + "      ,[status] = ?\n"
                    + " WHERE [package_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setString(1, pack.getPackageTitle());
            stm.setFloat(2, pack.getPrice());
            stm.setInt(3, pack.getDuration());
            stm.setString(4, pack.getDurationtype());
            stm.setString(5, pack.getUserBenefit());
            stm.setBoolean(6, pack.isStatus());
            stm.setInt(7, pack.getPackageId());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PricePackageDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
