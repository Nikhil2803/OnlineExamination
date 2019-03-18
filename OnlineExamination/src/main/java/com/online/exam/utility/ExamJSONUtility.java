package com.online.exam.utility;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.online.exam.beans.Exam;
import com.online.exam.beans.ExamResult;
import com.online.exam.beans.Question;

public class ExamJSONUtility {

	
	private static final String questionDir = "./Questions";
	private static final String examDir = "./Exams";
	private static final String resultDir = "./Results";
	private static final String questionFilePrefix = "QUEST_";
	private static final String examFilePrefix = "EXAM_";
	private static final String resultFilePrefix = "RESULT_";
	
	public static void checkAndCreateDirectory(String dir){
		new File(dir).mkdirs();
	}
	
	public static Exam getExamFromId(String examId, String subjectId){
		String dir = examDir+"/"+subjectId;
		String fileName = examFilePrefix+subjectId+"_"+examId+".json";;
		File f = new File(dir);
	    File[] files = f.listFiles();
		 Exam exam = null;	
	    if (files != null)
	    for (int i = 0; i < files.length; i++) {
	        File file = files[i];
	        if(file.getName().equalsIgnoreCase(fileName)){
	        	exam = readExamObjectFromFile(dir+"/"+file.getName());
	        }
	    }
	    return exam;
	}
	
	public String generateFilePath(String dir,String prefix,String subjctId,String id){
		return dir+"/"+subjctId+"/"+prefix+subjctId+"_"+id+".json";
		}
	
	public static void writeQuestionObjectToFile(Question question){
		ObjectMapper mapper = new ObjectMapper();
		 try {
			 	checkAndCreateDirectory(questionDir+"/"+question.getSubjectId());
	            mapper.writeValue(new File(questionDir+"/"+question.getSubjectId()+"/"+questionFilePrefix+question.getSubjectId()+"_"+question.getQuestionId()+".json"), question);//Plain JSON
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	
	public static void writeExamObjectToFile(Exam exam){
		ObjectMapper mapper = new ObjectMapper();
		 try {
			 	checkAndCreateDirectory(examDir+"/"+exam.getSubjectId());
	            mapper.writeValue(new File(examDir+"/"+exam.getSubjectId()+"/"+examFilePrefix+exam.getSubjectId()+"_"+exam.getExamId()+".json"), exam);//Plain JSON
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	
	public static void writeResultObjectToFile(ExamResult result){
		ObjectMapper mapper = new ObjectMapper();
		 try {
			 	checkAndCreateDirectory(resultDir+"/"+result.getExamId());
	            mapper.writeValue(new File(resultDir+"/"+result.getExamId()+"/"+resultFilePrefix+result.getExamId()+"_"+result.getEnrollmentId()+".json"), result);//Plain JSON
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	
	public static Question readQuestionObjectFromFile(String subjectId,String questionId){
		Question question=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			question = mapper.readValue(new File(questionDir+"/"+subjectId+"/"+questionFilePrefix+subjectId+"_"+questionId+".json"), Question.class);
        } catch (Exception e) {
            e.printStackTrace();
        }   
		return question;
	}
	
	public static Question readQuestionObjectFromFile(String filePath){
		Question question=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			question = mapper.readValue(new File(filePath), Question.class);
        } catch (Exception e) {
            e.printStackTrace();
        }   
		return question;
	}
	
	
	public static ExamResult readExamResultObjectFromFile(String filePath){
		ExamResult exam=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			exam = mapper.readValue(new File(filePath), ExamResult.class);
        } catch (Exception e) {
            e.printStackTrace();
        }   
		return exam;
	}
	
	public static Exam readExamObjectFromFile(String filePath){
		Exam exam=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			exam = mapper.readValue(new File(filePath), Exam.class);
        } catch (Exception e) {
            e.printStackTrace();
        }   
		return exam;
	}
	
	public static Exam readExamObjectFromFile(String subjectId,String examId){
		Exam exam=null;
		ObjectMapper mapper = new ObjectMapper();
		try {
			exam = mapper.readValue(new File(examDir+"/"+subjectId+"/"+examFilePrefix+subjectId+"_"+examId+".json"), Exam.class);
        } catch (Exception e) {
            e.printStackTrace();
        }   
		return exam;
	}
	
	public static int getQuestionId(){
		ExamJSONUtility eu = new ExamJSONUtility();
		int countId = eu.getFileCount(questionDir,0)+10;
		Question alreadyPResent = readQuestionObjectFromFile("1",Integer.toString(countId));
		if(alreadyPResent!=null
				&& alreadyPResent.getQuestionId()!=0);
			countId = eu.getFileCount(questionDir,countId)+10;
		return countId;
	}
	
	public static int getExamId(){
		ExamJSONUtility eu = new ExamJSONUtility();
		return eu.getFileCount(examDir,0)+10;
	}
	
	private int getFileCount(String dir, int cnt){
		int count =cnt;
		File f = new File(dir);
	    File[] files = f.listFiles();
	 
	    if (files != null)
	    for (int i = 0; i < files.length; i++) {
	        count++;
	        File file = files[i];
	 
	        if (file.isDirectory()) {   
	        	count =count+getFileCount(file.getAbsolutePath(),0); 
	        }
	    }
	    return count;
	}
	
	
	
	public static List<Question> getQuestionsFromDir(String subjectId){
		String dir = questionDir+"/"+subjectId;
		File folder = new File(dir);
		File[] listOfFiles = folder.listFiles();
		List<Question> questions = new ArrayList<Question>();
		if(listOfFiles!=null){
		for (int i = 0; i < listOfFiles.length; i++) {
			  if (listOfFiles[i].isFile()) {
				  Question question = readQuestionObjectFromFile(dir+"/"+listOfFiles[i].getName());
				  System.out.println("File read - " + listOfFiles[i].getName());
				  questions.add(question);
			  } else if (listOfFiles[i].isDirectory()) {
			    System.out.println("Directory " + listOfFiles[i].getName());
			  }
			  
		}
		}
		return questions;
	}
	
	public static void processResult(ExamResult result){
		if(result!=null){
			double totalMarks = 0;
			int numOfCorrectAnswers = 0;
			Map<String, String> questAnsMap = result.getQuestAnsMap();
			for(String key:questAnsMap.keySet()){
				questAnsMap.put(key, questAnsMap.get(key).replace(",", ""));
			}
			Set<String> keySet = questAnsMap.keySet();
			for(String questionId:keySet){
				Question question = readQuestionObjectFromFile(String.valueOf(1), questionId);
				if(question!=null && question.getAnswers()!=null){
					if((question.getQuestionType()!=null && question.getQuestionType().equalsIgnoreCase("Text") )){
						String correctAns = question.getAnswers().get(0);
						String studentAns = questAnsMap.get(questionId).trim();
						if(correctAns.matches("-?\\d+(\\.\\d+)?") 
								&&  studentAns.matches("-?\\d+(\\.\\d+)?")){
							double numericAns = Double.parseDouble(correctAns);
							double givenAns = Double.parseDouble(studentAns);
							if((Math.abs(numericAns-givenAns)/numericAns)<0.05){
								totalMarks=totalMarks+question.getMarks();
								++numOfCorrectAnswers;
							}
						}else if(correctAns.equalsIgnoreCase(studentAns)){
							totalMarks=totalMarks+question.getMarks();
							++numOfCorrectAnswers;
						}
						
					
					}else if(question.getAnswers().contains(questAnsMap.get(questionId).trim())){
						totalMarks=totalMarks+question.getMarks();
						++numOfCorrectAnswers;
					}
					
				}
			}
			result.setMarksObtained(totalMarks);
			result.setNumberOfCorrectAns(numOfCorrectAnswers);
		}
	}
	
	public static 	Map<String, Integer> prepareResultSummary(){
		ExamJSONUtility util = new ExamJSONUtility();
		Map<String, Integer> resultSummary = new HashMap<>();
		File f = new File(resultDir);
	    File[] files = f.listFiles();
	 
	    if (files != null)
	    for (int i = 0; i < files.length; i++) {
	        File file = files[i];
	 
	        if (file.isDirectory()) { 
	        	
	        	int count = util.getFileCount(file.getAbsolutePath(),0); 
	        	resultSummary.put(file.getName(), count);
	        }
	    }
	    
	    return resultSummary;
	}
	
	public static Map<String, String> getListOfExamsInDir(String subId){
		Map<String, String> resultSummary = new HashMap<>();
		File f = new File(examDir+"/"+subId);
	    File[] files = f.listFiles();
	 
	    if (files != null)
	    for (int i = 0; i < files.length; i++) {
	        File file = files[i];
	 
	        if (!file.isDirectory()) { 
	        	String fileName = file.getName();
	        	String examId = fileName.replace(examFilePrefix+subId+"_", "").replace(".json", "");
	        	resultSummary.put(examId, examId.substring(0, examId.lastIndexOf("_")));
	        }
	    }
	    return resultSummary;
	}
	
	
	public static Exam getExamDetail(String subId, String examId){
	   Exam exam = readExamObjectFromFile(subId,examId);
	   List<Question> questions = new ArrayList<Question>();
	   for(String questionId: exam.getQuestinIds()){
		   Question question = readQuestionObjectFromFile(subId, questionId);
		   questions.add(question);
	   }
	   exam.setQuestions(questions);
	    return exam;
	}
	
	
	
	public static 	Map<String, Double> prepareExamResultSummary(String examId){
		Map<String, Double> resultSummary = new HashMap<>();
		File f = new File(resultDir+"/"+examId);
	    File[] files = f.listFiles();
	 
	    if (files != null)
	    for (int i = 0; i < files.length; i++) {
	        File file = files[i];
	 
	        if (!file.isDirectory()) { 
	        	String fileName = file.getName();
	        	ExamResult examResult = readExamResultObjectFromFile(file.getAbsolutePath());
	        	String name = fileName.substring(fileName.lastIndexOf("_")+1, fileName.length()).split(".json")[0];
	        	resultSummary.put(name,examResult.getMarksObtained());
	        }
	    }
	    
	    return resultSummary;
	}

	public static ExamResult getExamDetailForEnrollment(String examId,String enrollmentId) {
		String filePath = resultDir+"/"+examId+"/"+resultFilePrefix+examId+"_"+enrollmentId+".json";
		ExamResult examResult= readExamResultObjectFromFile(filePath);
		Set<String> questionIds = examResult.getQuestAnsMap().keySet();
		List<Question> questions = new ArrayList<Question>();
		for(String questionId:questionIds){
			Question question = readQuestionObjectFromFile(String.valueOf(1), questionId);
			questions.add(question);
		}
		examResult.setQuestions(questions);
		return examResult;
	}
	
	
}
