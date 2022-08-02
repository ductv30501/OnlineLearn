/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class UserDate {
    private ArrayList<String> date;
    private ArrayList<Integer> totalUser;

    public UserDate() {
        date = new ArrayList<>();
        totalUser = new ArrayList<>();
    }

    public ArrayList<String> getDate() {
        return date;
    }

    public void setDate(ArrayList<String> date) {
        this.date = date;
    }

    public ArrayList<Integer> getTotalUser() {
        return totalUser;
    }

    public void setTotalUser(ArrayList<Integer> totalUser) {
        this.totalUser = totalUser;
    }
    

    
    
    
}
