package com.keyan.graduationphoto.bean;

import java.io.Serializable;

/**
 * 教育履历实体类
 */
public class Education implements Serializable {
    private Integer id;
    private Integer userId;
    private String stage;           // 教育阶段：幼儿园、小学、初中、高中、大学、硕士研究生、博士研究生、其他
    private String schoolName;      // 学校全称
    private String entranceYear;    // 入学年份，例如：2020级
    private String className;       // 班级，例如：1班、2班、3班

    // 关联的用户名（用于展示）
    private String username;

    public Education() {
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getStage() {
        return stage;
    }

    public void setStage(String stage) {
        this.stage = stage;
    }

    public String getSchoolName() {
        return schoolName;
    }

    public void setSchoolName(String schoolName) {
        this.schoolName = schoolName;
    }

    public String getEntranceYear() {
        return entranceYear;
    }

    public void setEntranceYear(String entranceYear) {
        this.entranceYear = entranceYear;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }
}
