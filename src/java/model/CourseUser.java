/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author win
 */
public class CourseUser {
    private Course course;
    private User user;
    private int star;
    private String comment;
    private int totalLearnedTime;
    
    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public int getStar() {
        return star;
    }

    public void setStar(int star) {
        this.star = star;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
    
    

    public String getTotalLearnedTimeAsText() {
        String time = "";
        int hour = totalLearnedTime / 3600;
        int minutes = 0;

        if (hour > 0) {
            time += hour + "h ";
            minutes = (totalLearnedTime - (hour * 3600)) / 60;
        } else {
            minutes = (totalLearnedTime) / 60;
        }
        time += minutes + "p";

        return time;
    }
    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public int getTotalLearnedTime() {
        return totalLearnedTime;
    }

    public void setTotalLearnedTime(int totalLearnedTime) {
        this.totalLearnedTime = totalLearnedTime;
    }
 
}
