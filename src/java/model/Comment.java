/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.util.ArrayList;

/**
 *
 * @author win
 */
public class Comment {

    private int commentId;
    private String content;
    private Date date;
    private User user;
    private boolean reply;
    private Chapter chapter;
    private ArrayList<Comment> replies;
    private String listReplyStr;
    private int countComment;

    public int getCountComment() {
        return countComment;
    }

    public void setCountComment(int countComment) {
        this.countComment = countComment;
    }

    public String getListReplyStr() {
        return listReplyStr;
    }

    public void setListReplyStr(String listReplyStr) {
        this.listReplyStr = listReplyStr;
    }
    
    

    public Comment(int commentId, String content, Date date) {
        this.commentId = commentId;
        this.content = content;
        this.date = date;
    }
    
    

    public Comment(String content, Date date, User user, boolean reply, Chapter chapter) {
        this.content = content;
        this.date = date;
        this.user = user;
        this.reply = reply;
        this.chapter = chapter;
    }

    public Comment(String content, Date date, User user, boolean reply, Chapter chapter, ArrayList<Comment> replies) {
        this.content = content;
        this.date = date;
        this.user = user;
        this.reply = reply;
        this.chapter = chapter;
        this.replies = replies;
    }

    public ArrayList<Comment> getReplies() {
        return replies;
    }

    public void setReplies(ArrayList<Comment> replies) {
        this.replies = replies;
    }

    public Comment() {
    }

    public int getCommentId() {
        return commentId;
    }

    public String getContent() {
        return content;
    }

    public Date getDate() {
        return date;
    }

    public User getUser() {
        return user;
    }

    public boolean isReply() {
        return reply;
    }

    public Chapter getChapter() {
        return chapter;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setReply(boolean reply) {
        this.reply = reply;
    }

    public void setChapter(Chapter chapter) {
        this.chapter = chapter;
    }

    public Comment(int commentId, String content, Date date, User user, boolean reply, Chapter chapter, ArrayList<Comment> replies) {
        this.commentId = commentId;
        this.content = content;
        this.date = date;
        this.user = user;
        this.reply = reply;
        this.chapter = chapter;
        this.replies = replies;
    }

   
    

   
}
