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
public class UserQuizDetail {

    private User user;
    private Quiz quiz;
    private Question question;
    private ArrayList<UserQuestionDetail> userQuestionDetails;

    public ArrayList<UserQuestionDetail> getUserQuestionDetails() {
        return userQuestionDetails;
    }

    public void setUserQuestionDetails(ArrayList<UserQuestionDetail> userQuestionDetails) {
        this.userQuestionDetails = userQuestionDetails;
    }

    public UserQuizDetail() {
    }

    public UserQuizDetail(User user, Quiz quiz, Question question) {
        this.user = user;
        this.quiz = quiz;
        this.question = question;
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

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

}
