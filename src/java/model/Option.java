/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Option {
    private int optionId;
    private String optionDetail;
    private boolean isCorrect;
    private Question question;
    private int question_id;

    //---------------------------------------------
    private boolean ischoosen;
    
    
    //----------------------------------------------
    public Option() {
    }

    public Option(int optionId, String optionDetail, boolean isCorrect, Question question) {
        this.optionId = optionId;
        this.optionDetail = optionDetail;
        this.isCorrect = isCorrect;
        this.question = question;
    }

    public int getQuestion_id() {
        return question_id;
    }

    public void setQuestion_id(int question_id) {
        this.question_id = question_id;
    }
    

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    public String getOptionDetail() {
        return optionDetail;
    }

    public void setOptionDetail(String optionDetail) {
        this.optionDetail = optionDetail;
    }

    public boolean isIsCorrect() {
        return isCorrect;
    }

    public void setIsCorrect(boolean isCorrect) {
        this.isCorrect = isCorrect;
    }

    public Question getQuestion() {
        return question;
    }

    public void setQuestion(Question question) {
        this.question = question;
    }

    public boolean isIschoosen() {
        return ischoosen;
    }

    public void setIschoosen(boolean ischoosen) {
        this.ischoosen = ischoosen;
    }
    
    
}
