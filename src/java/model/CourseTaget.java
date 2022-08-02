/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class CourseTaget {
    private int targetID;
    private String targetDetail;
    private Course course;

    public CourseTaget() {
    }

    public CourseTaget(int targetID, String targetDetail, Course course) {
        this.targetID = targetID;
        this.targetDetail = targetDetail;
        this.course = course;
    }

    public int getTargetID() {
        return targetID;
    }

    public void setTargetID(int targetID) {
        this.targetID = targetID;
    }

    public String getTargetDetail() {
        return targetDetail;
    }

    public void setTargetDetail(String targetDetail) {
        this.targetDetail = targetDetail;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }
    
    
}
