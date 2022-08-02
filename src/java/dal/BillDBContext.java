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
import model.Bill;
import model.Category;
import model.Tag;
import model.User;

/**
 *
 * @author ADMIN
 */
public class BillDBContext extends DBContext {
    
    public int getCurrentIdentity() {
        try {
            String sql = "SELECT IDENT_CURRENT('Bill') as [current_id]";
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

    public ArrayList<Bill> getBills(String username) {
        ArrayList<Bill> bills = new ArrayList<>();
        try {
            String sql = "SELECT * FROM Bill b join [User] u on b.username = u.username WHERE u.username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));

                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setName(rs.getString("name"));

                bill.setUser(user);

                bill.setPackageTitle(rs.getString("package_title"));
                bill.setPrice(rs.getFloat("price"));
                bill.setRegistration_date(rs.getDate("registration_date"));
                bill.setValid_from(rs.getDate("valid_from"));
                bill.setValid_to(rs.getDate("valid_to"));

                bills.add(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return bills;
    }

    public void insertBill(Bill bill) {
        try {
            String sql = "INSERT INTO [dbo].[Bill]\n"
                    + "           ([username]\n"
                    + "           ,[package_title]\n"
                    + "           ,[price]\n"
                    + "           ,[registration_date]\n"
                    + "           ,[valid_from]\n"
                    + "           ,[valid_to])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?, ?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, bill.getUser().getUsername());
            stm.setString(2, bill.getPackageTitle());
            stm.setFloat(3, bill.getPrice());
            stm.setDate(4, bill.getRegistration_date());
            stm.setDate(5, bill.getValid_from());
            stm.setDate(6, bill.getValid_to());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(BillDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public Bill getBillById(int id) {
        try {
            String sql = "SELECT * FROM Bill b join [User] u on b.username = u.username"
                    + "\nWHERE b.bill_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));

                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setName(rs.getString("name"));

                bill.setUser(user);

                bill.setPackageTitle(rs.getString("package_title"));
                bill.setPrice(rs.getFloat("price"));
                bill.setRegistration_date(rs.getDate("registration_date"));
                bill.setValid_from(rs.getDate("valid_from"));
                bill.setValid_to(rs.getDate("valid_to"));

                return bill;
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
