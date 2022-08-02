/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;
import java.util.Base64;

/**
 *
 * @author ADMIN
 */
public class Course {

    private int courseId;
    private String courseTitle;
    private Topic topic;
    private boolean status;
    private float rate;
    private String description;
    private byte[] img;
    private int duration;
    private int totalLearner;
    private ArrayList<Chapter> chapters;

    public String getDurationText() {
        int totalDuration = 0;
        for (Chapter chapter : chapters) {
            ArrayList<Lesson> lessons = chapter.getLessons();
            for (Lesson lesson : lessons) {
                totalDuration += lesson.getDuration();
            }
        }
        
        String time = "";
        int hour = totalDuration / 3600;
        int minutes = 0;

        if (hour > 0) {
            time += hour + "h ";
            minutes = (totalDuration - (hour * 3600)) / 60;
        } else {
            minutes = (totalDuration) / 60;
            if (minutes > 0) {
                time += minutes + "m ";
            } else {
                time += totalDuration + "s";
            }
        }

        duration = totalDuration;
        return time;
    }

  
    private String avatar;

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    private String createdBy;

    public Course(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public Course(int courseId) {
        this.courseId = courseId;
    }

    public String getAvatar() {
        return "data:image/gif;base64," + Base64.getEncoder().encodeToString(this.img);
    }

    public int getNumberOfChapter() {
        return chapters.size();
    }

    public int getNumberOfLesson() {
        int count = 0;
        for (Chapter chapter : chapters) {
            count += chapter.getLessons().size();
        }
        return count;
    }

    public ArrayList getChapters() {
        return chapters;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {

        this.duration = duration;
    }

    public int getTotalLearner() {
        return totalLearner;
    }

    public void setTotalLearner(int totalLearner) {
        this.totalLearner = totalLearner;
    }

    public void setChapters(ArrayList chapters) {
        this.chapters = chapters;
    }

    public Course() {
        chapters = new ArrayList<>();
    }

    public Course(int courseId, String courseTitle, Topic topic, boolean status, float rate, String description, byte[] img) {
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.topic = topic;
        this.status = status;
        this.rate = rate;
        this.description = description;
        this.img = img;
        chapters = new ArrayList<>();

    }

    public Course(int courseId, String courseTitle, Topic topic, boolean status, float rate, String description, byte[] img, ArrayList chapters, String createdBy) {
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.topic = topic;
        this.status = status;
        this.rate = rate;
        this.description = description;
        this.img = img;
        this.chapters = chapters;
        this.createdBy = createdBy;
    }

    public Course(int courseId, String courseTitle, Topic topic, boolean status, float rate, String description, byte[] img, int duration, int totalLearner, ArrayList chapters, String createdBy) {
        this.courseId = courseId;
        this.courseTitle = courseTitle;
        this.topic = topic;
        this.status = status;
        this.rate = rate;
        this.description = description;
        this.img = img;
        this.duration = duration;
        this.totalLearner = totalLearner;
        this.chapters = chapters;
        this.createdBy = createdBy;
    }

    public Course(String courseTitle, Topic topic, boolean status, float rate, String description, byte[] img, int duration, int totalLearner, ArrayList chapters, String createdBy) {
        this.courseTitle = courseTitle;
        this.topic = topic;
        this.status = status;
        this.rate = rate;
        this.description = description;
        this.img = img;
        this.duration = duration;
        this.totalLearner = totalLearner;
        this.chapters = chapters;
        this.createdBy = createdBy;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getCourseTitle() {
        return courseTitle;
    }

    public void setCourseTitle(String courseTitle) {
        this.courseTitle = courseTitle;
    }

    public Topic getTopic() {
        return topic;
    }

    public void setTopic(Topic topic) {
        this.topic = topic;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public float getRate() {
        return rate;
    }

    public void setRate(float rate) {
        this.rate = rate;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public byte[] getImg() {
        return img;
    }

    public void setImg(byte[] img) {
        this.img = img;
        if(img != null) {
            this.avatar = "data:image/gif;base64," + Base64.getEncoder().encodeToString(this.img);
        }
    }

}
