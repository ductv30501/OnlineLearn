package model;

import java.sql.Blob;
import java.util.Base64;

/**
 *
 * @author ADMIN
 */
public class Topic {

    private int topicId;
    private String topicName;
    private byte[] img;
    private String description;
    private int totalLearner;
    private int totalCourse;

    public int getTotalCourse() {
        return totalCourse;
    }

    public void setTotalCourse(int totalCourse) {
        this.totalCourse = totalCourse;
    }
    
    

    public int getTotalLearner() {
        return totalLearner;
    }

    public void setTotalLearner(int totalLearner) {
        this.totalLearner = totalLearner;
    }
    
    

    public String getAvatar() {
        return "data:image/gif;base64," + Base64.getEncoder().encodeToString(this.img);
    }

    public String getImgStr() {
        return Base64.getEncoder().encodeToString(this.img);
    }

    public Topic() {
    }

    public Topic(int topicId, String topicName, byte[] img, String description) {
        this.topicId = topicId;
        this.topicName = topicName;
        this.img = img;
        this.description = description;
    }

    public Topic(int topicId) {
        this.topicId = topicId;
    }
    

    public int getTopicId() {
        return topicId;
    }

    public void setTopicId(int topicId) {
        this.topicId = topicId;
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName;
    }

    public byte[] getImg() {
        return img;
    }

    public void setImg(byte[] img) {
        this.img = img;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
