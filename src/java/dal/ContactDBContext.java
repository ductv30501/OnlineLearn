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
import model.Contact;

/**
 *
 * @author win
 */
public class ContactDBContext extends DBContext {

    public ArrayList<Contact> getContacts() {
        ArrayList<Contact> contacts = new ArrayList<>();
        try {
            String sql = "SELECT[contact_id]\n"
                    + "      ,[name]\n"
                    + "      ,[email]\n"
                    + "      ,[phone]\n"
                    + "      ,[subject]\n"
                    + "      ,[message]"
                    + "      ,[status]\n"
                    + "  FROM [Contact]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Contact c = new Contact();
                c.setContactId(rs.getInt("contact_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setSubject(rs.getString("subject"));
                c.setMessage(rs.getString("message"));
                c.setStatus(rs.getBoolean("status"));
                contacts.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return contacts;
    }

    public boolean insert(Contact c) {
        boolean check = false;
        PreparedStatement stm = null;
        String sql;
        try {
            sql = "INSERT INTO [dbo].[Contact]\n"
                    + "           ([name]\n"
                    + "           ,[email]\n"
                    + "           ,[phone]\n"
                    + "           ,[subject]\n"
                    + "           ,[message]"
                    + "           ,[status])\n"
                    + "     VALUES\n"
                    + "           (?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?\n"
                    + "           ,?,1)";

            stm = connection.prepareStatement(sql);
            stm.setString(1, c.getName());
            stm.setString(2, c.getEmail());
            stm.setString(3, c.getPhone());
            stm.setString(4, c.getSubject());
            stm.setString(5, c.getMessage());
            stm.executeUpdate();
            // check data
            sql = "select * from contact where [name] = ? and email = ? and phone = ? and [subject] = ? and [message] =? and status = 1";

            stm = connection.prepareStatement(sql);
            stm.setString(1, c.getName());
            stm.setString(2, c.getEmail());
            stm.setString(3, c.getPhone());
            stm.setString(4, c.getSubject());
            stm.setString(5, c.getMessage());
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                check = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return check;
    }

    public Contact getContact(int id) {
        Contact c = new Contact();
        try {
            String sql = "SELECT[contact_id]\n"
                    + "      ,[name]\n"
                    + "      ,[email]\n"
                    + "      ,[phone]\n"
                    + "      ,[subject]\n"
                    + "      ,[message]"
                    + "      ,[status]\n"
                    + "  FROM [Contact] where contact_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                c.setContactId(rs.getInt("contact_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setSubject(rs.getString("subject"));
                c.setMessage(rs.getString("message"));
                c.setStatus(rs.getBoolean("status"));
                return c;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return c;
    }

    public void updateStatus(int id) {
        try {
            String sql = "UPDATE [Contact] SET [status] = 0\n"
                    + " WHERE contact_id = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(ContactDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ArrayList<Contact> getContactsBySearch(int page, int sizePage, String rawSearchKey, int status) {
        ArrayList<Contact> contacts = new ArrayList<>();
        try {
            String sql = "SELECT[contact_id]\n"
                    + "      ,[name]\n"
                    + "      ,[email]\n"
                    + "      ,[phone]\n"
                    + "      ,[subject]\n"
                    + "      ,[message]"
                    + "      ,[status]\n"
                    + "  FROM [Contact] ";
            sql += " where [name] + email + phone + [subject] + [message] ";

            if (rawSearchKey.equals("")) {
                sql += " not like ?";
            } else {
                sql += " like ?";
            }
            sql += " and status ";

            if (status == -1) {
                sql += " != ?";
            } else {
                sql += " = ? ";
            }

            sql += " order by contact_id \n"
                    + " offset (?-1)*? row fetch next ? rows only";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + rawSearchKey + "%");
            stm.setInt(2, status);
            stm.setInt(3, page);
            stm.setInt(4, sizePage);
            stm.setInt(5, sizePage);
            stm.setBoolean(page, true);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Contact c = new Contact();
                c.setContactId(rs.getInt("contact_id"));
                c.setName(rs.getString("name"));
                c.setEmail(rs.getString("email"));
                c.setPhone(rs.getString("phone"));
                c.setSubject(rs.getString("subject"));
                c.setMessage(rs.getString("message"));
                c.setStatus(rs.getBoolean("status"));
                contacts.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ContactDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return contacts;
    }

}
