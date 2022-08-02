/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Base64;

/**
 *
 * @author ADMIN
 */
public class Slider {

    private int sliderId;
    private String sliderTitle;
    private String sliderContent;
    private byte[] sliderImage;
    private Boolean status;

    
      public String getAvatar() {
        return "data:image/gif;base64," + Base64.getEncoder().encodeToString(this.sliderImage);
    }
    public Slider(int sliderId, String sliderTitle, String sliderContent, byte[] sliderImage, Boolean status) {
        this.sliderId = sliderId;
        this.sliderTitle = sliderTitle;
        this.sliderContent = sliderContent;
        this.sliderImage = sliderImage;
        this.status = status;
    }

    public Slider(String sliderTitle, String sliderContent, byte[] sliderImage, Boolean status) {
        this.sliderTitle = sliderTitle;
        this.sliderContent = sliderContent;
        this.sliderImage = sliderImage;
        this.status = status;
    }

    public Slider() {
    }

    public int getSliderId() {
        return sliderId;
    }

    public void setSliderId(int sliderId) {
        this.sliderId = sliderId;
    }

    public String getSliderTitle() {
        return sliderTitle;
    }

    public void setSliderTitle(String sliderTitle) {
        this.sliderTitle = sliderTitle;
    }

    public String getSliderContent() {
        return sliderContent;
    }

    public void setSliderContent(String sliderContent) {
        this.sliderContent = sliderContent;
    }

    public byte[] getSliderImage() {
        return sliderImage;
    }

    public void setSliderImage(byte[] sliderImage) {
        this.sliderImage = sliderImage;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

   

}
