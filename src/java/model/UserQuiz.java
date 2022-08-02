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
public class UserQuiz {
    private User user;
    private Quiz quiz;
    private int score;
    private Date takenDate;
    private ArrayList<UserQuizDetail> userQuizDetails;
    
    

    public UserQuiz() {
    }

    public ArrayList<UserQuizDetail> getUserQuizDetails() {
        return userQuizDetails;
    }

    public void setUserQuizDetails(ArrayList<UserQuizDetail> userQuizDetails) {
        this.userQuizDetails = userQuizDetails;
    }
    

    public UserQuiz(User user, Quiz quiz, Date takenDate) {
        this.user = user;
        this.quiz = quiz;
        this.takenDate = takenDate;
    }

    public UserQuiz(User user, Quiz quiz, int score, Date takenDate) {
        this.user = user;
        this.quiz = quiz;
        this.score = score;
        this.takenDate = takenDate;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Quiz getQuiz() {
        return quiz;
    }

    public void setQuiz(Quiz quiz) {
        this.quiz = quiz;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public Date getTakenDate() {
        return takenDate;
    }

    public void setTakenDate(Date takenDate) {
        this.takenDate = takenDate;
    }
    
    
    
    
}
