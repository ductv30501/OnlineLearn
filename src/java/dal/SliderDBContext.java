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
import model.Slider;

/**
 *
 * @author ADMIN
 */
public class SliderDBContext extends DBContext {

    public ArrayList<Slider> getSliders() {
        ArrayList<Slider> sliders = new ArrayList<>();
        try {
            String sql = "SELECT [slider_id]\n"
                    + "      ,[slider_title]\n"
                    + "      ,[slider_content]\n"
                    + "      ,[status]\n"
                    + "      ,[slider_img]\n"
                    + "  FROM [dbo].[Slider]";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("slider_id"));
                slider.setSliderTitle(rs.getString("slider_title"));
                slider.setSliderContent(rs.getString("slider_content"));
                slider.setSliderImage(rs.getBytes("slider_img"));
                slider.setStatus(rs.getBoolean("status"));
                sliders.add(slider);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sliders;
    }
    public ArrayList<Slider> getActiveSliders() {
        ArrayList<Slider> sliders = new ArrayList<>();
        try {
            String sql = "SELECT [slider_id]\n"
                    + "      ,[slider_title]\n"
                    + "      ,[slider_content]\n"
                    + "      ,[status]\n"
                    + "      ,[slider_img]\n"
                    + "  FROM [dbo].[Slider] "
                    + " WHERE [status] = 1";

            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(rs.getInt("slider_id"));
                slider.setSliderTitle(rs.getString("slider_title"));
                slider.setSliderContent(rs.getString("slider_content"));
                slider.setSliderImage(rs.getBytes("slider_img"));
                slider.setStatus(rs.getBoolean("status"));
                sliders.add(slider);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return sliders;
    }

    public Slider getSlider(int sliderId) {
        try {
            String sql = "SELECT [slider_id]\n"
                    + "      ,[slider_title]\n"
                    + "      ,[slider_content]\n"
                    + "      ,[status]\n"
                    + "      ,[slider_img]\n"
                    + "  FROM [dbo].[Slider] "
                    + "  WHERE [slider_id] = ?";

            PreparedStatement stm = connection.prepareStatement(sql);

            stm.setInt(1, sliderId);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                Slider slider = new Slider();
                slider.setSliderId(sliderId);
                slider.setSliderTitle(rs.getString("slider_title"));
                slider.setSliderContent(rs.getString("slider_content"));
                slider.setSliderImage(rs.getBytes("slider_img"));
                slider.setStatus(rs.getBoolean("status"));
                return slider;
            }
        } catch (SQLException ex) {
            Logger.getLogger(SliderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void insertSlider(Slider slider) {
        try {
            String sql = "INSERT INTO [dbo].[Slider]\n"
                    + "           ([slider_title]\n"
                    + "           ,[slider_content]\n"
                    + "           ,[status]\n"
                    + "           ,[slider_img])\n"
                    + "     VALUES\n"
                    + "           (?, ?, ?, ?)";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, slider.getSliderTitle());
            stm.setString(2, slider.getSliderContent());
            stm.setBoolean(3, slider.getStatus());
            stm.setBytes(4, slider.getSliderImage());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SliderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void updateSlider(Slider slider) {
        try {
            String sql = "UPDATE [dbo].[Slider]\n"
                    + "   SET [slider_title] = ?\n"
                    + "      ,[slider_content] = ?\n"
                    + "      ,[slider_img] = ?\n"
                    + "      ,[status] = ?\n"
                    + " WHERE [slider_id] = ?";

            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setString(1, slider.getSliderTitle());
            stm.setString(2, slider.getSliderContent());
            stm.setBytes(3, slider.getSliderImage());
            stm.setBoolean(4, slider.getStatus());
            stm.setInt(5, slider.getSliderId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SliderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void deleteSlider(int sliderId) {
        try {
            String sql = "DELETE FROM [dbo].[Slider]\n"
                    + " WHERE [slider_id] = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, sliderId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(SliderDBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
