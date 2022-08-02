/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author ADMIN
 */
public class Feature {
    private int featureId;
    private String url;
    private String description;
    private ArrayList<Group> groups;

    
     
    public Feature(int featureId) {
        this.featureId = featureId;
    }

    public Feature() {
    }

    public Feature(int featureId, String url, String description, ArrayList<Group> groups) {
        this.featureId = featureId;
        this.url = url;
        this.description = description;
        this.groups = groups;
    }

    public Feature(String url, String description) {
        this.url = url;
        this.description = description;
    }

    public Feature(String url, String description, ArrayList<Group> groups) {
        this.url = url;
        this.description = description;
        this.groups = groups;
    }

    public int getFeatureId() {
        return featureId;
    }

    public void setFeatureId(int featureId) {
        this.featureId = featureId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<Group> getGroups() {
        return groups;
    }

    public void setGroups(ArrayList<Group> groups) {
        this.groups = groups;
    }
    
    
    
    
}
