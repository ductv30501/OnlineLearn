/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Arrays;

/**
 *
 * @author ADMIN
 */
public class PricePackage {

    private int packageId;
    private String packageTitle;
    private float price;
    private int duration;
    private String durationtype;
    private String userBenefit;
    private boolean status;
    

    
    
    

    public String[] getBenefits() {
        String[] separatedBenefits = userBenefit.split("-");
       
        return Arrays.copyOfRange(separatedBenefits, 1, separatedBenefits.length);
    }
    
   

    public String getDurationText() {
        if (durationtype.equals("month")) {
            return duration + " tháng";
        } else {
            return duration + " năm";
        }
    }

    public PricePackage() {
    }

    public PricePackage(int packageId, String packageTitle, float price, int duration, String durationtype, String userBenefit, boolean status) {
        this.packageId = packageId;
        this.packageTitle = packageTitle;
        this.price = price;
        this.duration = duration;
        this.durationtype = durationtype;
        this.userBenefit = userBenefit;
        this.status = status;
    }

    public PricePackage(String packageTitle, float price, int duration, String durationtype, String userBenefit, boolean status) {
        this.packageTitle = packageTitle;
        this.price = price;
        this.duration = duration;
        this.durationtype = durationtype;
        this.userBenefit = userBenefit;
        this.status = status;
    }
    
    

    public int getPackageId() {
        return packageId;
    }

    public void setPackageId(int packageId) {
        this.packageId = packageId;
    }

    public String getPackageTitle() {
        return packageTitle;
    }

    public void setPackageTitle(String packageTitle) {
        this.packageTitle = packageTitle;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getDurationtype() {
        return durationtype;
    }

    public void setDurationtype(String durationtype) {
        this.durationtype = durationtype;
    }

    public String getUserBenefit() {
        return userBenefit;
    }

    public void setUserBenefit(String userBenefit) {
        this.userBenefit = userBenefit;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    

}
