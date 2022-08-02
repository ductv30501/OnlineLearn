/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Lesson{

    private int lessonId;
    private Chapter chapter;
    private String lessonTitle;
    private int duration;
    private String videoURL;
    private String publicId;
    private String description;

//    // This attribute is for checking lesson done by user
//    private Boolean completedStatus;
//
//    public Boolean getCompletedStatus() {
//        return completedStatus;
//    }
//
//    public void setCompletedStatus(Boolean completedStatus) {
//        this.completedStatus = completedStatus;
//    }

    public String getDurationTimeAsText() {
        String time = "";
        int hour = duration / 3600;
        int minutes = 0;
        int second = 0;

        if (hour > 0) {
            time += hour + "h ";
            minutes = (duration - (hour * 3600)) / 60;
        } else {
            minutes = (duration) / 60;
            if (minutes > 0) {
                time += minutes + "m ";
                second = duration - (minutes * 60);
                time += second + "s";
            } else {
                
                time += duration + "s";
            }
        }


        return time;
    }

    public Lesson() {
    }

    public Lesson(Chapter chapter, String lessonTitle, int duration, String videoURL, String publicId, String description) {
        this.chapter = chapter;
        this.lessonTitle = lessonTitle;
        this.duration = duration;
        this.videoURL = videoURL;
        this.publicId = publicId;
        this.description = description;
    }

    public Lesson(int lessonId, Chapter chapter, String lessonTitle, int duration, String videoURL, String publicId, String description) {
        this.lessonId = lessonId;
        this.chapter = chapter;
        this.lessonTitle = lessonTitle;
        this.duration = duration;
        this.videoURL = videoURL;
        this.publicId = publicId;
        this.description = description;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public String getLessonTitle() {
        return lessonTitle;
    }

    public void setLessonTitle(String lessonTitle) {
        this.lessonTitle = lessonTitle;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getVideoURL() {
        return videoURL;
    }

    public void setVideoURL(String videoURL) {
        this.videoURL = videoURL;
    }

    public String getPublicId() {
        return publicId;
    }

    public void setPublicId(String publicId) {
        this.publicId = publicId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }


    public boolean equals(Lesson lesson) {
        return lesson.lessonId == lessonId;
    }

}
