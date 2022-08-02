/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author ADMIN
 */
public class Bill {

    private int billId;
    private User user;
    private String packageTitle;
    private float price;
    private Date registration_date;
    private Date valid_from, valid_to;

    public Bill() {
    }

    public Bill(int billId, User user, String packageTitle, float price, Date registration_date, Date valid_from, Date valid_to) {
        this.billId = billId;
        this.user = user;
        this.packageTitle = packageTitle;
        this.price = price;
        this.registration_date = registration_date;
        this.valid_from = valid_from;
        this.valid_to = valid_to;
    }

    public Bill(User user, String packageTitle, float price, Date registration_date, Date valid_from, Date valid_to) {
        this.user = user;
        this.packageTitle = packageTitle;
        this.price = price;
        this.registration_date = registration_date;
        this.valid_from = valid_from;
        this.valid_to = valid_to;
    }

    public int getBillId() {
        return billId;
    }

    public void setBillId(int billId) {
        this.billId = billId;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
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

    public Date getRegistration_date() {
        return registration_date;
    }

    public void setRegistration_date(Date registration_date) {
        this.registration_date = registration_date;
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
    
    

}
