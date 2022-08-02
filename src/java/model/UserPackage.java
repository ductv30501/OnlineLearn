/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author Admin
 */
public class UserPackage {
    private String username,email;
    private int packageID;
    private String packageTitle;
    private float total_price;
    private boolean status;
    private Date registration_date;
    private Date valid_from,valid_to;
    private String lastUpdateBy;
    
    private PricePackage p;

    public PricePackage getP() {
        return p;
    }

    public void setP(PricePackage p) {
        this.p = p;
    }
    
    

    public UserPackage() {
    }

    public UserPackage(String username, String email, int packageID, Date registration_date, String packageTitle, float total_price, boolean status, Date valid_from, Date valid_to, String lastUpdateBy) {
        this.username = username;
        this.email = email;
        this.packageID = packageID;
        this.registration_date = registration_date;
        this.packageTitle = packageTitle;
        this.total_price = total_price;
        this.status = status;
        this.valid_from = valid_from;
        this.valid_to = valid_to;
        this.lastUpdateBy = lastUpdateBy;
    }
    

    public int getPackageID() {
        return packageID;
    }

    public void setPackageID(int packageID) {
        this.packageID = packageID;
    }
    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Date getRegistration_date() {
        return registration_date;
    }

    public void setRegistration_date(Date registration_date) {
        this.registration_date = registration_date;
    }

    public String getPackageTitle() {
        return packageTitle;
    }

    public void setPackageTitle(String packageTitle) {
        this.packageTitle = packageTitle;
    }

    public float getTotal_price() {
        return total_price;
    }

    public void setTotal_price(float total_price) {
        this.total_price = total_price;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getValid_from() {
        return valid_from;
    }

    public void setValid_from(Date valid_from) {
        this.valid_from = valid_from;
    }

    public Date getValid_to() {
        return valid_to;
    }

    public void setValid_to(Date valid_to) {
        this.valid_to = valid_to;
    }

    public String getLastUpdateBy() {
        return lastUpdateBy;
    }

    public void setLastUpdateBy(String lastUpdateBy) {
        this.lastUpdateBy = lastUpdateBy;
    }
    
    
}
