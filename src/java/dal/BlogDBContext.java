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
import model.Blog;
import model.Category;
import model.Tag;

/**
 *
 * @author win
 */
public class BlogDBContext extends DBContext {

    public ArrayList<Category> getCategory() {
        ArrayList<Category> listcategory = new ArrayList<>();
        try {
            String sql = "select a.cate_id, a.cate_title,a.cate_id,count(b.post_id) as total \n"
                    + "from Category a join Post b on a.cate_id = b.cate_id\n"
                    + "                    where b.is_public = 1\n"
                    + "                    group by a.cate_id, a.cate_title,a.cate_id\n"
                    + "                    order by a.cate_id\n"
                    + "					OFFSET 0 ROWS\n"
                    + "                    FETCH FIRST 10 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Category c = new Category();
                c.setCate_id(rs.getInt("cate_id"));
                c.setCate_title(rs.getString("cate_title"));
                c.setTotalPost(rs.getInt("total"));
                listcategory.add(c);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listcategory;
    }

    public ArrayList<Blog> getBlog() {
        ArrayList<Blog> listBlog = new ArrayList<>();
        try {
            String sql = "select a.post_id, a.post_title,a.is_public, a.author,a.public_date,a.img,a.cate_id from Post a "
                    + "where a.is_public = 1\n"
                    + "order by a.public_date\n"
                    + "OFFSET 0 ROWS \n"
                    + "FETCH FIRST 10 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                b.setIs_public(rs.getBoolean("is_public"));
                b.setAuthor(rs.getString("author"));
                b.setPublic_date(rs.getDate("public_date"));
                b.setImg(rs.getBytes("img"));
                Category c = new Category();
                c.setCate_id(rs.getInt("cate_id"));
                b.setCategory(c);
                listBlog.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listBlog;
    }

    public int countTotaltBlog() {
        int count = 0;
        try {
            String sql = "select count(a.post_id) as count from Post a "
                    + "where a.is_public = 1 "
                    + "group by a.post_id \n";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                count = rs.getInt("count");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public ArrayList<Blog> getLatestBlog() {
        ArrayList<Blog> listBlog = new ArrayList<>();
        try {
            String sql = "select a.post_id, a.post_title,a.is_public, a.author,a.public_date,a.img,a.cate_id from Post a "
                    + "where a.is_public = 1\n"
                    + "order by a.public_date\n"
                    + "OFFSET 0 ROWS \n"
                    + "FETCH FIRST 3 ROWS ONLY";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                b.setIs_public(rs.getBoolean("is_public"));
                b.setAuthor(rs.getString("author"));
                b.setPublic_date(rs.getDate("public_date"));
                b.setImg(rs.getBytes("img"));
                Category c = new Category();
                c.setCate_id(rs.getInt("cate_id"));
                b.setCategory(c);
                listBlog.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listBlog;
    }

    public ArrayList<Blog> getSearchBlogByAll(String searchKey, int cate_id, int tag_id, int size, int page) {
        ArrayList<Blog> listBlog = new ArrayList<>();
        try {
            String sql = "select a.post_id, a.post_title,a.is_public, a.author,a.public_date,a.img,a.cate_id from Post a\n"
                    + "join [User] b on a.author = b.username\n"
                    + "";

            sql += "where a.post_title ";

            if (searchKey.equals("")) {
                sql += " not like ";
            } else {
                sql += " like ";
            }
            sql += " ? and a.cate_id ";

            if (cate_id == -1) {
                sql += " != ";
            } else {
                sql += " = ";
            }

            sql += " ? and [is_public] = 1\n";

            sql += "order by a.public_date\n"
                    + "offset (?-1)*? row fetch next ? rows only";
            PreparedStatement stm = connection.prepareStatement(sql);

            if (!searchKey.equals("")) {
                stm.setString(1, "%" + searchKey + "%");
            } else {
                stm.setString(1, searchKey);
            }
            stm.setInt(2, cate_id);

            stm.setInt(3, page);
            stm.setInt(4, size);
            stm.setInt(5, size);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                b.setIs_public(rs.getBoolean("is_public"));
                b.setAuthor(rs.getString("author"));
                b.setPublic_date(rs.getDate("public_date"));
                b.setImg(rs.getBytes("img"));
                Category c = new Category();
                c.setCate_id(rs.getInt("cate_id"));
                b.setCategory(c);
                listBlog.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }

        return listBlog;
    }

    public ArrayList<Blog> getTopThreeBlog() {
        ArrayList<Blog> listBlog = new ArrayList<>();
        try {
            String sql = "select top 3 a.post_id, a.post_title,a.is_public, a.author,a.public_date,a.img,a.cate_id from Post a "
                    + "where a.is_public = 1\n"
                    + "order by a.public_date desc";
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                b.setIs_public(rs.getBoolean("is_public"));
                b.setAuthor(rs.getString("author"));
                b.setPublic_date(rs.getDate("public_date"));
                b.setImg(rs.getBytes("img"));
                Category c = new Category();
                c.setCate_id(rs.getInt("cate_id"));
                b.setCategory(c);
                listBlog.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return listBlog;
    }

    public ArrayList<Blog> searchBlog(String query, int index) {
        ArrayList<Blog> results = new ArrayList<>();
        try {
            String sql = "SELECT [post_id]\n"
                    + "      ,[post_title]\n"
                    + "      ,[is_public]\n"
                    + "      ,[author]\n"
                    + "      ,[public_date]\n"
                    + "      ,[img]\n"
                    + "      ,[cate_id]\n"
                    + "  FROM [dbo].[Post]\n"
                    + "  WHERE [post_title] LIKE N'%" + query + "%'\n"
                    + "  ORDER BY [post_id]\n"
                    + "  OFFSET " + (index - 1) * 8 + " ROWS\n"
                    + "  FETCH FIRST 8 ROWS ONLY";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();

            while (rs.next()) {
                Blog b = new Blog();
                b.setBlog_id(rs.getInt("post_id"));
                b.setBlog_title(rs.getString("post_title"));
                b.setIs_public(rs.getBoolean("is_public"));
                b.setAuthor(rs.getString("author"));
                b.setPublic_date(rs.getDate("public_date"));
                b.setImg(rs.getBytes("img"));
                Category c = new Category();
                c.setCate_id(rs.getInt("cate_id"));
                b.setCategory(c);
                results.add(b);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BlogDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return results;

    }
}
