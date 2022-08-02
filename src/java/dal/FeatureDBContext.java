/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Feature;
import model.Group;
import model.GroupFeature;

/**
 *
 * @author ADMIN
 */
public class FeatureDBContext extends DBContext {

    public ArrayList<Feature> getFeatures() {
        ArrayList<Feature> features = new ArrayList<>();
        try {
            String sql = "SELECT [feature_id],\n"
                    + "		[url],\n"
                    + "		[description]\n"
                    + "  FROM [dbo].[Feature]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Feature feature = new Feature();
                feature.setFeatureId(rs.getInt("feature_id"));
                feature.setUrl(rs.getString("url"));
                feature.setDescription(rs.getString("description"));
                features.add(feature);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return features;
    }

    public ArrayList<GroupFeature> getGroupFeatures() {
        ArrayList<GroupFeature> groupFeatures = new ArrayList<>();
        try {
            String sql = "SELECT [feature_id]\n"
                    + "      ,[group_id]\n"
                    + "  FROM [dbo].[Group_Feature]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                GroupFeature groupFeature = new GroupFeature();
                groupFeature.setFeatureId(rs.getInt("feature_id"));
                groupFeature.setGroupId(rs.getInt("group_id"));
                groupFeatures.add(groupFeature);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groupFeatures;
    }

    public Feature getFeature(int featureId) {
        try {
            String sql = "SELECT [url]\n"
                    + "      ,[description]\n"
                    + "  FROM [dbo].[Feature]"
                    + "  WHERE [feature_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, featureId);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Feature feature = new Feature();
                feature.setFeatureId(featureId);
                feature.setUrl(rs.getString("url"));
                feature.setDescription(rs.getString("description"));

                ArrayList<Group> groups = getGroups(featureId);

                feature.setGroups(groups);
                return feature;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertFeature(Feature feature) {
        try {
            String sql = "INSERT INTO [dbo].[Feature]\n"
                    + "           ([url]\n"
                    + "           ,[description])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, feature.getUrl());
            stm.setString(2, feature.getDescription());
            stm.executeUpdate();

            int currentId = getCurrentIdentity();

            ArrayList<Group> groups = feature.getGroups();

            for (Group group : groups) {
                insertGroupFeature(currentId, group.getId());
            }

        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int getCurrentIdentity() {
        try {
            String sql = "SELECT IDENT_CURRENT('feature') as [current_id]";
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

    public void updateFeature(Feature feature) {
        try {
            String sql = "UPDATE [dbo].[Feature]\n"
                    + "   SET [url] = ?\n"
                    + "      ,[description] = ?\n"
                    + " WHERE [feature_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, feature.getUrl());
            stm.setString(2, feature.getDescription());
            stm.setInt(3, feature.getFeatureId());
            stm.executeUpdate();

            deleteGroupFeature(feature.getFeatureId());
            ArrayList<Group> groups = feature.getGroups();

            for (int i = 0; i < groups.size(); i++) {
                insertGroupFeature(feature.getFeatureId(), groups.get(i).getId());
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteFeature(int featureId) {
        try {
            String sql1 = "DELETE FROM [dbo].[Group_Feature]\n"
                    + "      WHERE [feature_id] = ?";
            PreparedStatement stm1 = connection.prepareStatement(sql1);
            stm1.setInt(1, featureId);
            stm1.executeUpdate();

            String sql2 = "DELETE FROM [dbo].[Feature]\n"
                    + "      WHERE [feature_id] = ?";
            PreparedStatement stm2 = connection.prepareStatement(sql2);
            stm2.setInt(1, featureId);
            stm2.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteGroupFeature(int featureId, int groupId) {
        try {
            String sql = "DELETE FROM [dbo].[Group_Feature]\n"
                    + "      WHERE [feature_id] = ? AND [group_id] = ? ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, featureId);
            stm.setInt(2, groupId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteGroupFeature(int featureId) {
        try {
            String sql = "DELETE FROM [dbo].[Group_Feature]\n"
                    + "      WHERE [feature_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, featureId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateGroupFeature(int featureId, int groupId) {
        try {
            String sql = "UPDATE [dbo].[Group_Feature]\n"
                    + "   SET [group_id] = ?\n"
                    + " WHERE [feature_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, groupId);
            stm.setInt(2, featureId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void insertGroupFeature(int featureId, int groupId) {
        try {
            String sql = "INSERT INTO [dbo].[Group_Feature]\n"
                    + "           ([feature_id]\n"
                    + "           ,[group_id])\n"
                    + "     VALUES\n"
                    + "           (?, ?)";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, featureId);
            stm.setInt(2, groupId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkContextPath(String contextPath, String username) {

        try {
            String sql = "select a.url from Feature a \n"
                    + "join Group_Feature b on a.feature_id = b.feature_id\n"
                    + "join [Group] c on b.group_id = c.group_id\n"
                    + "join User_Group d on c.group_id = d.group_id\n"
                    + "join [User] e on d.username = e.username\n"
                    + "where e.username = ? and url = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, username);
            stm.setString(2, contextPath);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public ArrayList<Group> getGroups() {
        ArrayList<Group> groups = new ArrayList<>();
        try {
            String sql = "select g.group_id,\n"
                    + "	g.group_name,\n"
                    + "	count(*) as total\n"
                    + "from [group] g join [user_group] ug on g.group_id = ug.group_id \n"
                    + "join [user] u on u.username = ug.username\n"
                    + "where g.group_id != 1\n"
                    + "group by  g.group_id,\n"
                    + "	g.group_name";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Group r = new Group();
                r.setId(rs.getInt("group_id"));
                r.setName(rs.getString("group_name"));
                r.setTotalUsers(rs.getInt("total"));
                groups.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groups;
    }

    public ArrayList<Group> getAllGroups() {
        ArrayList<Group> groups = new ArrayList<>();
        try {
            String sql = "select g.group_id,\n"
                    + "	g.group_name,\n"
                    + "	count(*) as total\n"
                    + "from [group] g join [user_group] ug on g.group_id = ug.group_id \n"
                    + "join [user] u on u.username = ug.username\n"
                    + "group by  g.group_id,\n"
                    + "	g.group_name";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Group r = new Group();
                r.setId(rs.getInt("group_id"));
                r.setName(rs.getString("group_name"));
                r.setTotalUsers(rs.getInt("total"));
                groups.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groups;
    }

    public ArrayList<Group> getGroups(int featureId) {
        ArrayList<Group> groups = new ArrayList<>();
        try {
            String sql = "SELECT gf.group_id\n"
                    + "FROM [dbo].[Feature] f left join [group_feature] gf\n"
                    + "on f.[feature_id] = gf.[feature_id]\n"
                    + "where f.[feature_id] = ?\n"
                    + "order by gf.group_id asc ";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, featureId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Group r = new Group();
                r.setId(rs.getInt("group_id"));
                groups.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return groups;
    }

    public void updateUserGroup(int id, String username) {
        try {
            String sql = "UPDATE [User_Group]\n"
                    + "   SET [group_id] = ?\n"
                    + " WHERE [username] = ? AND group_id != 1";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setString(2, username);
            ps.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(FeatureDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
