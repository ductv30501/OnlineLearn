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
public class Quiz {

    private int quizId;
    private String quizTitle;
    private String description;
    private int toPass;
    private Course course;
    private Chapter chapter;
    private int duration;
    private ArrayList<Question> questions;

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }
    
    
    private int numberQuestion;

    public int getNumberQuestion() {
        return numberQuestion;
    }

    public void setNumberQuestion(int numberQuestion) {
        this.numberQuestion = numberQuestion;
    }
    
    

    //----------------------------------------
    private int mark;
    
    
    //-------------------------------------------
    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }
    
    

    public String getDurationTimeAsText() {
        String time = "";
        int hour = duration / 3600;
        int minutes = 0;
        int seconds = 0;

        if (hour > 0) {
            time += hour + "h ";
            minutes = (duration - (hour * 3600)) / 60;
            seconds = (duration - (hour * 3600)) % 60;
        } else {
            minutes = (duration) / 60;
            seconds = (duration) % 60;
        }

        if (minutes != 0 || seconds != 0) {
            if (seconds >= 30) {
                minutes += 1;
            }
            time += minutes + "m";
        }

        return time;
    }
    public String getDurationTimeAsVN() {
        String time = "";
        int hour = duration / 3600;
        int minutes = 0;
        int seconds = 0;

        if (hour > 0) {
            time += hour + " giờ ";
            minutes = (duration - (hour * 3600)) / 60;
            seconds = (duration - (hour * 3600)) % 60;
        } else {
            minutes = (duration) / 60;
            seconds = (duration) % 60;
        }

        if (minutes != 0 || seconds != 0) {
            if (seconds >= 30) {
                minutes += 1;
            }
            time += minutes + " phút";
        }

        return time;
    }

    public int getTotalPoint() {
        int sum = 0;
        for (Question question : questions) {
            sum += question.getPoint();
        }
        return sum;
    }

    public ArrayList<Question> getQuestions() {
        return questions;
    }

    public void setQuestions(ArrayList<Question> questions) {
        this.questions = questions;
    }

    public Quiz() {
        questions = new ArrayList<>();
    }

    public Quiz(int quizId, String quizTitle, String description, int toPass, Chapter chapter) {
        this.quizId = quizId;
        this.quizTitle = quizTitle;
        this.description = description;
        this.toPass = toPass;
        this.chapter = chapter;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuizTitle() {
        return quizTitle;
    }

    public void setQuizTitle(String quizTitle) {
        this.quizTitle = quizTitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getToPass() {
        return toPass;
    }

    public void setToPass(int toPass) {
        this.toPass = toPass;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public int getMark() {
        return mark;
    }

    public void setMark(int mark) {
        this.mark = mark;
    }

    
}
