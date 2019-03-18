package com.online.exam.beans;

import java.util.Date;
import java.util.List;

public class Exam {

	private String examId;
	private int subjectId;
	private String examName;
	private double totalMarks;
	private int totalTime;
	private List<Question> questions;
	private List<String> questinIds;
	private String createdBy;
	private Date createDt;
	
	
	
	public Exam() {
		super();
	}
	public Exam(String examId, int subjectId, String examName, double totalMarks,
			int totalTime, List<Question> questions, String createdBy,
			Date createDt) {
		super();
		this.examId = examId;
		this.subjectId = subjectId;
		this.examName = examName;
		this.totalMarks = totalMarks;
		this.totalTime = totalTime;
		this.questions = questions;
		this.createdBy = createdBy;
		this.createDt = createDt;
	}
	public String getExamId() {
		return examId;
	}
	public void setExamId(String examId) {
		this.examId = examId;
	}
	public int getSubjectId() {
		return subjectId;
	}
	public void setSubjectId(int subjectId) {
		this.subjectId = subjectId;
	}
	public String getExamName() {
		return examName;
	}
	public void setExamName(String examName) {
		this.examName = examName;
	}
	public double getTotalMarks() {
		return totalMarks;
	}
	public void setTotalMarks(double totalMarks) {
		this.totalMarks = totalMarks;
	}
	public int getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(int totalTime) {
		this.totalTime = totalTime;
	}
	public List<Question> getQuestions() {
		return questions;
	}
	public void setQuestions(List<Question> questions) {
		this.questions = questions;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreateDt() {
		return createDt;
	}
	public void setCreateDt(Date createDt) {
		this.createDt = createDt;
	}
	public List<String> getQuestinIds() {
		return questinIds;
	}
	public void setQuestinIds(List<String> questinIds) {
		this.questinIds = questinIds;
	}
}
