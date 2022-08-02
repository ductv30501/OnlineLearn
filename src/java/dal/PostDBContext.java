/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.awt.Point;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Block;
import model.Blog;
import model.Category;
import model.Tag;
import model.User;
import model.UserPost;

/**
 *
 * @author ADMIN
 */
public class PostDBContext extends DBContext {

    /**
     * Get a post list to display in dashboard of marketing
     *
     * @return
     */
    public ArrayList<Blog> getPosts() {
        ArrayList<Blog> blogs = new ArrayList<>();
        try {
            String sql = "SELECT P.[post_id]\n"
                    + "      ,P.[post_title]\n"
                    + "      ,P.[is_public]\n"
                    + "      ,P.[author]\n"
                    + "      ,P.[public_date]\n"
                    + "      ,P.[img]\n"
                    + "      ,P.[cate_id]\n"
                    + "	  ,C.[cate_title]\n"
                    + "	  ,COUNT(UP.[username]) AS readed\n"
                    + "  FROM [dbo].[Post] P INNER JOIN [Category] C ON P.[cate_id] = C.[cate_id] LEFT JOIN [User_Post] UP ON UP.[post_id] = P.[post_id]\n"
                    + "  GROUP BY P.[post_id], P.[post_title], P.[is_public], P.[author], P.[public_date], P.[img], P.[cate_id], C.[cate_title]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlog_id(rs.getInt("post_id"));
                blog.setBlog_title(rs.getNString("post_title"));
                blog.setAuthor(rs.getString("author"));
                blog.setIs_public(rs.getBoolean("is_public"));
                blog.setPublic_date(rs.getDate("public_date"));
                blog.setImg(rs.getBytes("img"));
                blog.setTotalRead(rs.getInt("readed"));

                Category cate = new Category();
                cate.setCate_id(rs.getInt("cate_id"));
                cate.setCate_title(rs.getNString("cate_title"));

                blog.setCategory(cate);
                blogs.add(blog);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return blogs;
    }

    /**
     * Get category by CATEGORY ID
     *
     * @param cateID
     * @return
     */
    public Category getCateByID(int cateID) {
        String sql = "SELECT [cate_id]\n"
                + "      ,[cate_title]\n"
                + "  FROM [dbo].[Category]\n"
                + "  WHERE cate_id = ?";
        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, cateID);
            ResultSet rs = stm.executeQuery();

            if (rs.next()) {
                Category cate = new Category();
                cate.setCate_id(rs.getInt("cate_id"));
                cate.setCate_title(rs.getNString("cate_title"));
                return cate;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    /**
     * Get all category of a post
     *
     * @return
     */
    public ArrayList<Category> getCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        try {
            String sql = "SELECT C.[cate_id]\n"
                    + "      ,C.[cate_title]\n"
                    + "	  ,COUNT(P.post_id) AS [totalPost]\n"
                    + "  FROM [dbo].[Category] C LEFT JOIN [Post] P ON P.[cate_id] = C.[cate_id]\n"
                    + "  GROUP BY C.[cate_id], C.[cate_title]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category cate = new Category();
                cate.setCate_id(rs.getInt("cate_id"));
                cate.setCate_title(rs.getString("cate_title"));
                cate.setTotalPost(rs.getInt("totalPost"));
                categories.add(cate);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return categories;

    }

    /**
     * Insert new blog information
     *
     * @param b
     */
    public void insertBlog(Blog b) {
        String sql = "  INSERT INTO [dbo].[Post]\n"
                + "           ([post_title]\n"
                + "           ,[is_public]\n"
                + "           ,[author]\n"
                + "           ,[public_date]\n"
                + "           ,[img]\n"
                + "           ,[cate_id])\n"
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
            stm.setString(1, b.getBlog_title());
            stm.setBoolean(2, b.isIs_public());
            stm.setString(3, b.getAuthor());
            stm.setDate(4, b.getPublic_date());
            stm.setBytes(5, b.getImg());
            stm.setInt(6, b.getCategory().getCate_id());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public ArrayList<Tag> getTags() {
        ArrayList<Tag> tags = new ArrayList<>();
        try {
            String sql = "SELECT T.[tag_id]\n"
                    + "      ,T.[tag_name]\n"
                    + "	  ,P.[post_id]\n"
                    + "	  ,p.[post_title]\n"
                    + "  FROM [dbo].[Tag] T INNER JOIN [Post] P ON P.[post_id] = T.[post_id]";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Tag t = new Tag();
                t.setTag_id(rs.getInt("tag_id"));
                t.setTag_title(rs.getString("tag_name"));

                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                t.setBlog(b);
                tags.add(t);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tags;

    }

    public void InsertBlock(Block block) {
        String sql = "INSERT INTO [dbo].[block]\n"
                + "           ([heading]\n"
                + "           ,[block_content]\n"
                + "           ,[quote]\n"
                + "           ,[post_id])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?\n"
                + "           ,?)";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, block.getHeading());
            stm.setString(2, block.getContent());
            stm.setString(3, block.getQuote());
            stm.setInt(4, block.getBlog().getBlog_id());

            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    /**
     * Get current post in database
     *
     * @return
     */
    public Blog getCurrentPost() {
        try {
            String sql = "SELECT TOP(1) [post_id]\n"
                    + "      ,[post_title]\n"
                    + "      ,[is_public]\n"
                    + "      ,[author]\n"
                    + "      ,[public_date]\n"
                    + "      ,[img]\n"
                    + "      ,[cate_id]\n"
                    + "  FROM [dbo].[Post]\n"
                    + "  ORDER BY [post_id] DESC";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Blog blog = new Blog();
                blog.setBlog_id(rs.getInt("post_id"));
                blog.setBlog_title(rs.getNString("post_title"));
                blog.setAuthor(rs.getString("author"));
                blog.setIs_public(rs.getBoolean("is_public"));
                blog.setPublic_date(rs.getDate("public_date"));
                blog.setImg(rs.getBytes("img"));

                return blog;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    /**
     * Get post by post id
     *
     * @param pid
     * @return
     */
    public Blog getPostById(int pid) {
        String sql = "SELECT [post_id]\n"
                + "      ,[post_title]\n"
                + "      ,[is_public]\n"
                + "      ,[author]\n"
                + "      ,[public_date]\n"
                + "      ,[img]\n"
                + "      ,[cate_id]\n"
                + "  FROM [dbo].[Post]\n"
                + "  WHERE [post_id] = ?";
        PreparedStatement stm = null;
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                b.setIs_public(rs.getBoolean("is_public"));
                b.setAuthor(rs.getString("author"));
                b.setPublic_date(rs.getDate("public_date"));
                b.setImg(rs.getBytes("img"));

                Category cate = new Category();
                cate.setCate_id(rs.getInt("cate_id"));

                b.setCategory(cate);

                return b;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;

    }

    /**
     * Get block list of a post by post id
     *
     * @param pid
     * @return
     */
    public ArrayList<Block> getBlocksByPostId(int pid) {
        ArrayList<Block> blocks = new ArrayList<>();
        try {
            String sql = "SELECT [block_id]\n"
                    + "      ,[heading]\n"
                    + "      ,[block_content]\n"
                    + "      ,[quote]\n"
                    + "      ,[post_id]\n"
                    + "  FROM [dbo].[block]\n"
                    + "  WHERE [post_id] = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, pid);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Block block = new Block();
                block.setBlock_id(rs.getInt("block_id"));
                block.setHeading(rs.getString("heading"));
                block.setContent(rs.getString("block_content"));
                block.setQuote(rs.getString("quote"));

                Blog blog = new Blog();
                blog.setBlog_id(rs.getInt("post_id"));

                block.setBlog(blog);

                blocks.add(block);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return blocks;

    }

    /**
     * Update block infomation
     *
     * @param block
     */
    public void UpdateBlock(Block block) {
        String sql = "UPDATE [dbo].[block]\n"
                + "   SET [heading] = ?\n"
                + "      ,[block_content] = ?\n"
                + "      ,[quote] = ?\n"
                + "      ,[post_id] = ?\n"
                + " WHERE [block_id] = ?";
        PreparedStatement stm = null;

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, block.getHeading());
            stm.setString(2, block.getContent());
            stm.setString(3, block.getQuote());
            stm.setInt(4, block.getBlog().getBlog_id());
            stm.setInt(5, block.getBlock_id());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    /**
     * GET top 5 recent post
     *
     * @return
     */
    public ArrayList<Blog> getTopRecentPost() {
        ArrayList<Blog> blogs = new ArrayList<>();
        try {
            String sql = "SELECT TOP(5) P.[post_id]\n"
                    + "      ,P.[post_title]\n"
                    + "      ,P.[is_public]\n"
                    + "      ,P.[author]\n"
                    + "      ,P.[public_date]\n"
                    + "      ,P.[img]\n"
                    + "      ,P.[cate_id]\n"
                    + "	  ,C.[cate_title]\n"
                    + "	  ,COUNT(UP.[username]) AS readed\n"
                    + "  FROM [dbo].[Post] P INNER JOIN [Category] C ON P.[cate_id] = C.[cate_id] LEFT JOIN [User_Post] UP ON UP.[post_id] = P.[post_id]\n"
                    + "  GROUP BY P.[post_id], P.[post_title], P.[is_public], P.[author], P.[public_date], P.[img], P.[cate_id], C.[cate_title]\n"
                    + "  ORDER BY P.[public_date] DESC";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog blog = new Blog();
                blog.setBlog_id(rs.getInt("post_id"));
                blog.setBlog_title(rs.getNString("post_title"));
                blog.setAuthor(rs.getString("author"));
                blog.setIs_public(rs.getBoolean("is_public"));
                blog.setPublic_date(rs.getDate("public_date"));
                blog.setImg(rs.getBytes("img"));
                blog.setTotalRead(rs.getInt("readed"));

                Category cate = new Category();
                cate.setCate_id(rs.getInt("cate_id"));
                cate.setCate_title(rs.getNString("cate_title"));

                blog.setCategory(cate);
                blogs.add(blog);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return blogs;
    }

    /**
     * GET COMMENTS OF USER
     *
     * @return
     */
    public ArrayList<UserPost> getComment(int postId) {
        UserDBContext userDB = new UserDBContext();
        ArrayList<UserPost> comments = new ArrayList<>();

        try {
            String sql = "  SELECT [username]\n"
                    + "      ,[post_id]\n"
                    + "      ,[comment]\n"
                    + "  FROM [dbo].[User_Post]\n"
                    + "  WHERE [post_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, postId);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                UserPost us = new UserPost();
                us.setComment(rs.getString("comment"));

                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                us.setBlog(b);

                User u = new User();
                u = userDB.getUser(rs.getString("username"));
                us.setUser(u);

                comments.add(us);
            }

        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return comments;

    }

    /**
     * Get tags by post id
     *
     * @param postId
     * @return
     */
    public ArrayList<Tag> getTagsByPostID(int postId) {
        ArrayList<Tag> tags = new ArrayList<>();
        try {
            String sql = "SELECT [tag_id]\n"
                    + "      ,[tag_name]\n"
                    + "      ,[post_id]\n"
                    + "  FROM [dbo].[Tag]\n"
                    + "  WHERE [post_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, postId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Tag t = new Tag();
                t.setTag_id(rs.getInt("tag_id"));
                t.setTag_title(rs.getString("tag_name"));

                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                t.setBlog(b);
                tags.add(t);
            }
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return tags;
    }

    /**
     * Insert comment
     *
     * @param us
     */
    public void insertComment(UserPost us) {
        String sql = "INSERT INTO [dbo].[User_Post]\n"
                + "           ([username]\n"
                + "           ,[post_id]\n"
                + "           ,[comment])\n"
                + "     VALUES\n"
                + "           (?\n"
                + "           ,?\n"
                + "           ,?)";
        PreparedStatement stm = null;

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, us.getUser().getUsername());
            stm.setInt(2, us.getBlog().getBlog_id());
            stm.setString(3, us.getComment());

            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }

    /**
     * Update post information
     *
     * @param b
     */
    public void updatePost(Blog b) {
        String sql = "UPDATE [dbo].[Post]\n"
                + "   SET [post_title] = ?\n"
                + "      ,[is_public] = ?\n"
                + "      ,[author] = ?\n"
                + "      ,[public_date] = ?\n"
                + "      ,[img] = ?\n"
                + "      ,[cate_id] = ?\n"
                + " WHERE [post_id] = ?";;
        PreparedStatement stm = null;

        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, b.getBlog_title());
            stm.setBoolean(2, b.isIs_public());
            stm.setString(3, b.getAuthor());
            stm.setDate(4, b.getPublic_date());
            stm.setBytes(5, b.getImg());
            stm.setInt(6, b.getCategory().getCate_id());
            stm.setInt(7, b.getBlog_id());

            stm.executeUpdate();

        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }

    /**
     * Delete block by block id
     *
     * @param postid
     */
    public void deleteBlock(int blockid) {
        String sql = "DELETE FROM [dbo].[block]\n"
                + "      WHERE [block_id] = ?";
        PreparedStatement stm = null;

        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, blockid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }

    }

    /**
     * Delete blog by blog id
     *
     * @param postid
     */
    public void deletePost(int postid) {
        String sql = "DELETE FROM [dbo].[Post]\n"
                + "      WHERE [post_id]=?";
        PreparedStatement stm = null;

        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, postid);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            if (stm != null) {
                try {
                    stm.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(PostDBContext.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

}
