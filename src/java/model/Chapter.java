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
public class Chapter {

    private int chapterId;
    private Course course;
    private String chapterTitle;
    private String description;
    private Quiz quiz;

    private ArrayList<Lesson> lessons;

    //-------------------------------------------------------------------
    private ArrayList<Quiz> quizz;
    
    
    //-----------------------------------------------------------------------
    public Chapter() {
        lessons = new ArrayList<>();
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public Chapter(int chapterId, Course course, String chapterTitle, String description, Quiz quiz, ArrayList<Lesson> lessons) {
        this.chapterId = chapterId;
        this.course = course;
        this.chapterTitle = chapterTitle;
        this.description = description;
        this.quiz = quiz;
        this.lessons = lessons;
    }
    

    public Chapter(Course course, String chapterTitle, String description) {
        this.course = course;
        this.chapterTitle = chapterTitle;
        this.description = description;
        lessons = new ArrayList<>();
    }

    public Chapter(int chapterId, Course course, String chapterTitle, String description) {
        this.chapterId = chapterId;
        this.course = course;
        this.chapterTitle = chapterTitle;
        this.description = description;
        lessons = new ArrayList<>();
    }

    public int getChapterId() {
        return chapterId;
    }

    public void setChapterId(int chapterId) {
        this.chapterId = chapterId;
    }

    public Course getCourse() {
        return course;
    }

    public void setCourse(Course course) {
        this.course = course;
    }

    public String getChapterTitle() {
        return chapterTitle;
    }

    public void setChapterTitle(String chapterTitle) {
        this.chapterTitle = chapterTitle;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public ArrayList<Lesson> getLessons() {
        return lessons;
    }

    public void setLessons(ArrayList<Lesson> lessons) {
        this.lessons = lessons;
    }

    public ArrayList<Quiz> getQuizz() {
        return quizz;
    }

    public void setQuizz(ArrayList<Quiz> quizz) {
        this.quizz = quizz;
    }

    

}
