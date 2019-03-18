package com.online.exam.controllers;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.online.exam.beans.Exam;
import com.online.exam.beans.ExamResult;
import com.online.exam.beans.Question;
import com.online.exam.utility.ExamJSONUtility;


@Controller
//@SessionAttributes("name")
//@RestController
public class ExamController {
	
	private static List<String> options = new ArrayList<>();
	private static List<String> answers = new ArrayList<>(1);
	
	static{
		for(int i=0;i<4;i++){
			options.add("");
		}
		answers.add("");
	}
	 @RequestMapping(value="/ExamHome", method = RequestMethod.GET)
	    public String showExamHome(ModelMap model){
		 System.out.println("Request to Examiner's Home");
	        return "ExaminerHome";
	    }
	 
	 @RequestMapping(value="/About", method = RequestMethod.GET)
	    public String aboutPage(ModelMap model){
		 System.out.println("Request to About Page");
	        return "about";
	    }
	 
	 @RequestMapping(value="/createQuestion", method = RequestMethod.GET)
	    public ModelAndView createQuestion(ModelMap model){
		 System.out.println("Request to Create Question page");
		 Question question = new Question();
		 question.setOptions(options);
		 question.setAnswers(answers);
		 return new ModelAndView("CreateQuestion" , "question", question);
	    }
	 
	 @RequestMapping(value="/createExam", method = RequestMethod.GET)
	    public ModelAndView createExam(ModelMap model){
		 System.out.println("Request to create Exam Page");
		 //Subject id hardcoded
		 List<Question> questions = ExamJSONUtility.getQuestionsFromDir("1");
		 Exam exam = new Exam();
		 exam.setQuestions(questions);
	        return new ModelAndView("CreateExam" , "exam", exam);
	    }
	 
	 @RequestMapping(value="/showResults", method = RequestMethod.GET)
	    public ModelAndView showResults(ModelMap model){
		 System.out.println("Request to Result Summary Page");
		 Map<String, Integer> examResults = ExamJSONUtility.prepareResultSummary();
	     return new ModelAndView("Results" , "examResults", examResults);
	    }
	 
	 
	 @RequestMapping(value="/listExams", method = RequestMethod.GET)
	    public ModelAndView listExams(ModelMap model){
		 //subject hardcoded
		 System.out.println("Request to get list of Exams");
		 Map<String,String> exams = ExamJSONUtility.getListOfExamsInDir("1");
	     return new ModelAndView("ListOfExams" , "exams", exams);
	    }
	 
	 
	 
	 @RequestMapping(value = "/addQuestion", method = RequestMethod.POST)
	    public String addQuestion(@Valid @ModelAttribute("question")Question question, 
	      BindingResult result, ModelMap model) {
	        if (result.hasErrors()) {
	            return "error";
	        }
	      System.out.println("Request to Submit a question");
	      question.setQuestionId(ExamJSONUtility.getQuestionId());
	  
	      for(int i=0;i<question.getAnswers().size();i++){
			String ans = question.getAnswers().get(i).trim();
			ans=ans.replace(",", "");
			question.getAnswers().set(i, ans);
	      }
	      System.out.println(question.getQuestionDesc());
	      System.out.println(question.getMarks());
	      System.out.println(question.getTime());
	      ExamJSONUtility.writeQuestionObjectToFile(question);
	      System.out.println("Question created successfully");
	        return "ExaminerHome";
	    }
	 
	 
	 @RequestMapping(value = "/addExam", method = RequestMethod.POST)
	    public String addExam(@Valid @ModelAttribute("exam")Exam exam, 
	      BindingResult result, ModelMap model) {
	        if (result.hasErrors()) {
	            return "error";
	        }
	      exam.setExamId(exam.getExamName().replace(" ", "_")+"_"+ExamJSONUtility.getExamId());
	      exam.setCreateDt(new Date(System.currentTimeMillis()));
	      System.out.println(exam.getQuestinIds().size());
	      System.out.println(exam.getTotalMarks());
	      System.out.println(exam.getTotalTime());
	      ExamJSONUtility.writeExamObjectToFile(exam);
	      System.out.println("Exam created successfully");
	        return "ExaminerHome";
	    }
	 
	 
	 
	 @RequestMapping(value="/startExam", method = RequestMethod.GET)
	    public ModelAndView startExam(@RequestParam(value ="examId",required=true) String examId,
	    		@RequestParam(value ="enrollId",required=true) String enrollId,
	    		ModelMap model){
		 //Subject id hardcoded
		 Exam exam = ExamJSONUtility.readExamObjectFromFile("1", examId);
		 List<String> questionIds = exam.getQuestinIds();
		 List<Question> questions = new ArrayList<Question>();
		 Map<String, String>  questnAnsMap = new HashMap<>();

		 for(String questionId: questionIds){
			Question question = ExamJSONUtility.readQuestionObjectFromFile("1",questionId);
			questions.add(question);
			questnAnsMap.put(questionId, "");
		 }
		 
		 ExamResult result = new ExamResult();
		 result.setExamId(exam.getExamId());
		 result.setSubjectId(exam.getSubjectId());
		 result.setEnrollmentId(enrollId);
		 result.setQuestions(questions);
		 result.setQuestAnsMap(questnAnsMap);
		 
		 ModelAndView modelView = new ModelAndView("RunningExam" , "examResult", result);
		 modelView.addObject("totalTime", exam.getTotalTime());
	     return modelView;
	    }
	 
	 @RequestMapping(value = "/generateResult", method = RequestMethod.POST)
	    public String generateResult(@Valid @ModelAttribute("examResult")ExamResult examResult, 
	      BindingResult result, ModelMap model) {
	        if (result.hasErrors()) {
	            return "error";
	        }
	     examResult.setNumberOfAttemptedQuest(examResult.getQuestAnsMap().size());
	     ExamJSONUtility.processResult(examResult);
	      ExamJSONUtility.writeResultObjectToFile(examResult);
	      System.out.println("Result Generated successfully");
	      model.addAttribute("message", "Exam Completed Successfully");
	        return "Login";
	    }
	 
	 @RequestMapping(value = "/getResultForExam", method = RequestMethod.GET)
	   public ModelAndView generateResultOfExam(@RequestParam(value ="examId",required=true)String examId) {
		 Map<String, Double> examResults = ExamJSONUtility.prepareExamResultSummary(examId);
		 ModelAndView modelNView = new ModelAndView("ExamResults" , "examResults", examResults);
		 modelNView.addObject("examId", examId);
		 return modelNView;
	    }
	 
	 
	 @RequestMapping(value = "/getExamDetail", method = RequestMethod.GET)
	   public ModelAndView getExamDetail(@RequestParam(value ="examId",required=true)String examId) {
		//Subject id hardcoded
		 Exam exam = ExamJSONUtility.getExamDetail("1",examId);
		 ModelAndView modelNView = new ModelAndView("CreateExam" , "exam", exam);
		 modelNView.addObject("examId", examId);
		 return modelNView;
	    }
	 
	 
	 @RequestMapping(value = "/getResultOfEnrollment", method = RequestMethod.GET)
	   public ModelAndView getResultOfEnrollment(@RequestParam(value ="examId",required=true)String examId,
			   @RequestParam(value ="enrollmentId",required=true)String enrollmentId) {
		 ExamResult result = ExamJSONUtility.getExamDetailForEnrollment(examId,enrollmentId);
		 return new ModelAndView("StudentResult" , "enrollmentResult", result);
	    }
}
