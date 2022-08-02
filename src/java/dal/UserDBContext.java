/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Group;
import model.User;
import model.UserDate;

/**
 *
 * @author ADMIN
 */
public class UserDBContext extends DBContext {

    public int getTotalRegisterExperts(Date startDate, Date endDate) {
        try {
            String sql = "SELECT COUNT(*) AS Total_User FROM [User] u\n"
                    + "JOIN Register_History rh \n"
                    + "ON u.username = rh.username \n"
                    + "JOIN User_Group ug\n"
                    + "ON ug.username = u.username\n"
                    + "JOIN [Group] g\n"
                    + "ON g.group_id = ug.group_id\n"
                    + "WHERE rh.register_date BETWEEN ? AND ? AND g.group_name = N'Giảng viên'";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total_User");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalRegisterLearners(Date startDate, Date endDate) {
        try {
            String sql = "SELECT COUNT(*) AS Total_User FROM [User] u\n"
                    + "JOIN Register_History rh \n"
                    + "ON u.username = rh.username \n"
                    + "JOIN User_Group ug\n"
                    + "ON ug.username = u.username\n"
                    + "JOIN [Group] g\n"
                    + "ON g.group_id = ug.group_id\n"
                    + "WHERE rh.register_date BETWEEN ? AND ? AND g.group_name = N'Học viên'";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total_User");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalExperts() {
        try {
            String sql = "SELECT COUNT(*) AS Total_User FROM [User] u\n"
                    + "JOIN User_Group ug\n"
                    + "ON ug.username = u.username\n"
                    + "JOIN [Group] g\n"
                    + "ON g.group_id = ug.group_id\n"
                    + "WHERE g.group_name = N'Giảng viên'";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total_User");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalLearners() {
        try {
            String sql = "SELECT COUNT(*) AS Total_User FROM [User] u\n"
                    + "JOIN User_Group ug\n"
                    + "ON ug.username = u.username\n"
                    + "JOIN [Group] g\n"
                    + "ON g.group_id = ug.group_id\n"
                    + "WHERE g.group_name = N'Học viên'";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total_User");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public int getTotalUsers() {
        try {
            String sql = "SELECT COUNT(*) AS Total_User FROM [User]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total_User");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public ArrayList<User> getTotalRegisterUsers(Date startDate, Date endDate) {
        ArrayList<User> users = new ArrayList<>();

        try {
            String sql = "SELECT * FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id\n"
                    + "JOIN Register_History rh \n"
                    + "ON u.username = rh.username\n"
                    + "WHERE rh.register_date BETWEEN ? AND ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                user.setRegisterDate(rs.getDate("register_date"));
                Group g = new Group();
                g.setId(rs.getInt("group_id"));
                g.setName(rs.getString("group_name"));
                user.setGroup(g);
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public ArrayList<User> getUsers() {
        ArrayList<User> users = new ArrayList<>();

        try {
            String sql = "SELECT * FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                Group g = new Group();
                g.setId(rs.getInt("group_id"));
                g.setName(rs.getString("group_name"));
                user.setGroup(g);
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public UserDate getTotalUserLoginDate(Date startDate, Date endDate, UserDate userDate) {
        try {
            String sql = "SELECT h.login_date,count(*) as total FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id\n"
                    + "JOIN Login_History h \n"
                    + "ON u.username = h.username\n"
                    + "WHERE h.login_date BETWEEN ? AND ?\n"
                    + "group by h.login_date";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                for (int i = 0; i < userDate.getDate().size(); i++) {
                    String date = userDate.getDate().get(i);
                    if (date.compareTo(String.valueOf(rs.getDate("login_date"))) == 0) {
                        userDate.getTotalUser().set(i, rs.getInt("total"));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userDate;
    }
    public UserDate getTotalUserRegisterDate(Date startDate, Date endDate, UserDate userDate) {
        try {
            String sql = "SELECT h.register_date,count(*) as total FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id\n"
                    + "JOIN Register_History h \n"
                    + "ON u.username = h.username\n"
                    + "WHERE h.register_date BETWEEN ? AND ?\n"
                    + "group by h.register_date";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                for (int i = 0; i < userDate.getDate().size(); i++) {
                    String date = userDate.getDate().get(i);
                    if (date.compareTo(String.valueOf(rs.getDate("register_date"))) == 0) {
                        userDate.getTotalUser().set(i, rs.getInt("total"));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return userDate;
    }

    public ArrayList<User> getTotalFrequentUsers(Date startDate, Date endDate) {
        ArrayList<User> users = new ArrayList<>();
        try {
            String sql = "with t as (SELECT h.login_date,count(*) as total FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id\n"
                    + "JOIN Login_History h \n"
                    + "ON u.username = h.username\n"
                    + "WHERE h.login_date BETWEEN ? AND ?\n"
                    + "group by h.login_date)\n"
                    + "\n"
                    + "SELECT u.username,\n"
                    + "	u.email,\n"
                    + "	u.phone,\n"
                    + "	u.[name], \n"
                    + "	u.img,\n"
                    + "	u.[address],\n"
                    + "	g.group_name, COUNT(*) FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id\n"
                    + "JOIN Login_History h \n"
                    + "ON u.username = h.username join t \n"
                    + "on t.login_date = h.login_date\n"
                    + "where g.group_id != 1\n"
                    + "group by u.username,\n"
                    + "	u.email,\n"
                    + "	u.phone,\n"
                    + "	u.[name], \n"
                    + "	u.img,\n"
                    + "	u.[address],\n"
                    + "	g.group_name\n"
                    + "Having count(*) >= (DATEDIFF(day, ?,? ) * 80) / 100";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setDate(1, startDate);
            stm.setDate(2, endDate);
            stm.setDate(3, startDate);
            stm.setDate(4, endDate);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setAvatar(rs.getString("img"));

                Group g = new Group();
                g.setName(rs.getString("group_name"));
                user.setGroup(g);
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public ArrayList<User> getActiveUsers() {
        ArrayList<User> users = new ArrayList<>();
        try {
            String sql = "SELECT * FROM [User] u join User_Group ug\n"
                    + "on ug.username = u.username join [Group] g\n"
                    + "on g.group_id = ug.group_id\n"
                    + "join ActiveUser au\n"
                    + "on au.username = u.username";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                Group g = new Group();
                g.setId(rs.getInt("group_id"));
                g.setName(rs.getString("group_name"));
                user.setGroup(g);
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public int getTotalDeactiveUsers() {
        try {
            String sql = "SELECT COUNT(*) AS Total_User FROM [User] u\n"
                    + "WHERE u.[status] = 0";
            PreparedStatement stm = connection.prepareStatement(sql);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return rs.getInt("Total_User");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public void insertRegisterDate(String username, Date registerDate) {
        try {
            String sql = "INSERT INTO [dbo].[Register_History]\n"
                    + "           ([username]\n"
                    + "           ,[register_date])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setDate(2, registerDate);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertActiveUser(String username) {
        try {
            String sql = "INSERT INTO [dbo].[ActiveUser] VALUES (?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeActiveUser(String username) {
        try {
            String sql = "DELETE FROM [dbo].[ActiveUser] WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertLoginDate(String username, Date loginDate) {
        try {
            String sql = "INSERT INTO [dbo].[Login_History]\n"
                    + "           ([username]\n"
                    + "           ,[login_date])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setDate(2, loginDate);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkExistEmail(String email) {
        try {
            String sql = "SELECT COUNT(*) AS exist\n"
                    + "  FROM [dbo].[User]\n"
                    + "  WHERE  email = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getInt("exist") > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public User getUserForEdit(String userName) {
        try {
            String sql = "SELECT a.username,a.password,a.name,a.gender,a.dob\n"
                    + ",a.phone,a.email,a.address,a.description,a.status,a.img,a.public_id,b.group_id,c.group_id,c.group_name\n"
                    + "FROM [User] a join User_Group b on a.username=b.username\n"
                    + "join [Group] c on c.group_id=b.group_id\n"
                    + "WHERE a.username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, userName);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                Group g = new Group();
                g.setId(rs.getInt("group_id"));
                g.setName(rs.getString("group_name"));
                user.setGroup(g);
                return user;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public ArrayList<User> getUsers(String groupId, String status, String search, int index, int number, String sort, String obj) {
        ArrayList<User> users = new ArrayList<>();
        try {
            String sql = "select a.username,a.name,a.email,a.phone,a.img,c.group_name,a.status\n"
                    + "from [user] a join User_Group b on a.username=b.username \n"
                    + "join [Group] c on c.group_id=b.group_id where c.group_id!=1 \n"
                    + " " + ((!groupId.isEmpty()) ? "and c.group_id=" + groupId + "" : "")
                    + " " + ((!status.isEmpty()) ? "and  a.status=" + status + "" : "")
                    + " " + ((!search.isEmpty()) ? "and (a.name like ? or a.email like  ? or a.phone like ?)" : "");
            sql += " order by " + obj + " " + sort + " offset " + (index - 1) * number + " row fetch next " + number + " row only";

            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
                stm.setString(2, search + "%");
                stm.setString(3, search + "%");
            }
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setName(rs.getString("name"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));

                Group g = new Group();
                g.setName(rs.getString("group_name"));
                user.setGroup(g);
                users.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return users;
    }

    public void UpdateUser(User u) {
        try {
            String sql = "UPDATE [dbo].[User]\n"
                    + "   SET [name] = ?\n"
                    + "      ,[gender] = ?\n"
                    + "      ,[dob] = ?\n"
                    + "      ,[phone] = ?\n"
                    + "      ,[address] = ?\n"
                    + "      ,[description] = ?\n"
                    + "      ,[status] = ?\n"
                    + "      ,[img] = ?\n"
                    + "      ,[public_id] = ?\n"
                    + " WHERE username = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, u.getName());
            ps.setBoolean(2, u.isGender());
            ps.setDate(3, u.getDob());
            ps.setString(4, u.getPhone());
            ps.setString(5, u.getAddress());
            ps.setString(6, u.getDescription());
            ps.setBoolean(7, u.isStatus());
            ps.setString(8, u.getAvatar());
            ps.setString(9, u.getPublicId());
            ps.setString(10, u.getUsername());
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int countUser(String groupId, String status, String search) {
        try {
            String sql = "select count(*) as total from [user] a\n"
                    + "join User_Group b on a.username=b.username \n"
                    + "join [Group] c on c.group_id=b.group_id where c.group_id!=1\n"
                    + " " + ((!groupId.isEmpty()) ? "and c.group_id=" + groupId + "" : "")
                    + " " + ((!status.isEmpty()) ? "and  a.status=" + status + "" : "")
                    + " " + ((!search.isEmpty()) ? "and (a.name like ? or a.email like  ? or a.phone like ?)" : "");
            PreparedStatement stm = connection.prepareStatement(sql);
            if (!search.isEmpty()) {
                stm.setString(1, search + "%");
                stm.setString(2, search + "%");
                stm.setString(3, search + "%");
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

    public void changeStatus(boolean stt, String username) {
        try {
            String sql = "UPDATE [User]\n"
                    + "   SET [status] = ?\n"
                    + " WHERE [username] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setBoolean(1, stt);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public User getUser(String usernameOrEmail, String passwrod) {
        try {
            String sql = "SELECT *\n"
                    + "  FROM [dbo].[User]\n"
                    + "  WHERE (username = ? or email = ?) and [password] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, usernameOrEmail);
            stm.setString(2, usernameOrEmail);
            stm.setString(3, passwrod);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                return user;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUser(String usernameOrEmail) {
        try {
            String sql = "SELECT [username]\n"
                    + "      ,[password]\n"
                    + "      ,[name]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[phone]\n"
                    + "      ,[email]\n"
                    + "      ,[address]\n"
                    + "      ,[description]\n"
                    + "      ,[status]\n"
                    + "      ,[public_id]\n"
                    + "      ,[img]\n"
                    + "  FROM [dbo].[User]\n"
                    + "  WHERE username = ? or email = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, usernameOrEmail);
            stm.setString(2, usernameOrEmail);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                return user;
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public boolean checkExistUsername(String username) {
        try {
            String sql = "SELECT COUNT(*) AS exist\n"
                    + "  FROM [dbo].[User]\n"
                    + "  WHERE username = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);

            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                if (rs.getInt("exist") > 0) {
                    return true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public String getUserPasswordByEmail(String email) {
        String password = null;
        try {
            String sql = "SELECT \n"
                    + "      [password]\n"
                    + "  FROM [User]\n"
                    + "  WHERE email = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                password = rs.getString("password");

            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return password;
    }

    public Group getUserGroup(User u) {
        try {
            String sql = "select g.group_id, g.group_name from [group] g join user_group ug\n"
                    + "on g.group_id = ug.group_id join [user] u\n"
                    + "on u.username = ug.username \n"
                    + "where u.username = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, u.getUsername());
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Group group = new Group();
                group.setId(rs.getInt("group_id"));
                group.setName(rs.getString("group_name"));
                return group;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUserByEmail(String email) {
        User user = new User();
        try {
            String sql = "SELECT  [username]\n"
                    + "      ,[password]\n"
                    + "      ,[name]\n"
                    + "      ,[gender]\n"
                    + "      ,[dob]\n"
                    + "      ,[phone]\n"
                    + "      ,[email]\n"
                    + "      ,[address]\n"
                    + "      ,[description]\n"
                    + "  FROM [User]\n"
                    + "  WHERE email = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(email);
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));

            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }

    public void insertUser(User user) {
        String sql = "INSERT INTO [dbo].[User]\n"
                + "           ([username]\n"
                + "           ,[password]\n"
                + "           ,[name]\n"
                + "           ,[gender]\n"
                + "           ,[dob]\n"
                + "           ,[phone]\n"
                + "           ,[email]\n"
                + "           ,[address]\n"
                + "           ,[description]\n"
                + "           ,[status]\n"
                + "           ,[public_id]\n"
                + "           ,[img])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?\n"
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
            stm.setString(1, user.getUsername());
            stm.setString(2, user.getPassword());
            stm.setString(3, user.getName());
            stm.setBoolean(4, user.isGender());
            stm.setDate(5, user.getDob());
            stm.setString(6, user.getPhone());
            stm.setString(7, user.getEmail());
            stm.setString(8, user.getAddress());
            stm.setString(9, user.getDescription());
            stm.setBoolean(10, true);
            stm.setString(11, user.getPublicId());
            stm.setString(12, user.getAvatar());
            stm.executeUpdate();

            insertUserGroup(user, user.getGroup().getId());

            LocalDate localDate = LocalDate.now();
            Date registerDate = Date.valueOf(localDate);

            insertRegisterDate(user.getUsername(), registerDate);

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertUserGroup(User user, int groupId) {
        String sql = "INSERT INTO [dbo].[User_Group]\n"
                + "           ([username]\n"
                + "           ,[group_id])\n"
                + "     VALUES (?,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, user.getUsername());
            stm.setInt(2, groupId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean ChangePass(String username, String newpass) {
        try {
            String sql = "UPDATE [User]\n"
                    + "   SET [password] = ?\n"
                    + " WHERE [username] = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setNString(1, newpass);
            ps.setNString(2, username);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return true;
    }

    //get teacher by course ID
    public User getTeacherByCourseID(int courseID) {
        try {
            String sql = "  SELECT U.[username]\n"
                    + "        ,U.[name]\n"
                    + "        ,U.[description]\n"
                    + "        ,U.[email]\n"
                    + "        ,U.[img]\n"
                    + "        ,U.[phone]\n"
                    + "        ,C.[createdby]\n"
                    + "  FROM [dbo].[Course] C INNER JOIN [Course_User] CU ON C.course_id = CU.course_id\n"
                    + "  INNER JOIN [User] U ON U.username = CU.username\n"
                    + "  INNER JOIN [User_Group] UG ON UG.username = U.username\n"
                    + "   INNER JOIN [Group] G ON G.[group_id] = UG.[group_id]\n"
                    + "  WHERE C.[course_id] = ? AND g.[group_id] = 5";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, courseID);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setUsername(rs.getString("username"));
                u.setName(rs.getNString("name"));
                u.setEmail(rs.getString("email"));
                u.setAvatar(rs.getString("img"));
                u.setDescription(rs.getNString("description"));

                return u;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    public ArrayList<User> getExperts() {
        ArrayList<User> experts = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "  FROM [dbo].[User] a join User_Group b on a.username = b.username\n"
                    + "  join [Group] c on b.group_id = c.group_id\n"
                    + "  where c.group_name = N'Giảng viên'";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                experts.add(user);
            }

        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return experts;
    }

    /**
     * Phi added
     */
    public ArrayList<User> getAuthors() {
        ArrayList<User> authors = new ArrayList<>();
        try {
            String sql = "SELECT *\n"
                    + "  FROM [dbo].[User] U INNER JOIN [User_Group] UG ON U.username = UG.username\n"
                    + "  WHERE UG.group_id = 3";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setGender(rs.getBoolean("gender"));
                user.setDob(rs.getDate("dob"));
                user.setPhone(rs.getString("phone"));
                user.setEmail(rs.getString("email"));
                user.setAddress(rs.getString("address"));
                user.setDescription(rs.getString("description"));
                user.setStatus(rs.getBoolean("status"));
                user.setAvatar(rs.getString("img"));
                user.setPublicId(rs.getString("public_id"));
                authors.add(user);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return authors;
    }

    public boolean checkExitLoginDate(String username, Date loginDate) {
        int exist = 0;
        try {
            String sql = "SELECT COUNT(*) AS Total\n"
                    + "FROM [dbo].[Login_History]\n"
                    + "WHERE [username] = ? and [login_date] = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setDate(2, loginDate);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                exist = rs.getInt("Total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return (exist > 0) ? true : false;
    }
}
