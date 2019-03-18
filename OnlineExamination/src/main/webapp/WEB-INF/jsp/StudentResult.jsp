<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>Online Examination</title>
<style>
body {background-color: powderblue;}
.icons {height: 100px;width: 100px;}
table {
font-family: "Trebuchet MS", Arial, Helvetica, sans-serif;
  width: 100%;
}

td {
 padding: 15px;
  height: 50px;
  background-color: #f5f5f5;
}

.button {
  -webkit-transition-duration: 0.4s; /* Safari */
  transition-duration: 0.4s;
}

.button:hover {
  background-color: #4CAF50; /* Green */
  color: white;
}
</style>

<!-- <script type="text/javascript">

/* function updateMarksTime(elem, mark, time){
var examMarks = document.getElementById("marks").value;
var examTime = document.getElementById("time").value;
if(elem!=null && elem.checked == "true")
	examMarks=examMarks+mark;
	examTime = examTime+time;
}else{
	if(examMarks>0){
		examMarks=examMarks-mark;
	}
	if(examTime>0){
		examTime = examTime-time;
	}
	
	document.getElementById("marks").value = examMarks;
	document.getElementById("time").value = examTime;
} */
</script> -->
</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
    <h2>Student Result Page</h2>
    
    <div align="center" style="margin-top:50">
    <form:form method="POST" 
          action="/generateResult" modelAttribute="enrollmentResult">
          <form:hidden path="enrollmentId"  value="${enrollmentResult.enrollmentId}"/>
          <form:hidden path="examId"  value="${enrollmentResult.examId}"/>
          
            <table>
             <tr>
                    <td><form:label path="enrollmentId">Enrollment ID</form:label></td>
                    <td> ${enrollmentResult.enrollmentId}</td>
             </tr>
             <tr>       
                    <td><form:label path="examId">Exam ID</form:label></td>
                    <td> ${enrollmentResult.examId}</td>
             </tr>

             <br/>
               <c:forEach items="${enrollmentResult.questions}" var="question" varStatus="status" >
               		<hr/>
               		<table>
               		
               		<tr><td colspan="3">${(status.index)+1}. ${question.questionDesc}</td></tr>
               		</table>
               		
            		<table>
            			<tr><th>Students Answer</th><th>Correct Answer</th></tr>
            			
            			<tr><td>
            			<c:forEach items="${enrollmentResult.questAnsMap}" var="mapEntry">
	            			<c:if test="${mapEntry.key == question.questionId }">
	            				 ${mapEntry.value}
	            			</c:if>
            			</c:forEach>
            			</td><td>${question.answers[0]}</td></tr>
            			
            		</table>
 					<br/>
                </c:forEach>
                <br/>
                <tr>
                    <td><form:label path="marksObtained" >Total Marks Obtained</form:label></td>
                    <td><form:input path="marksObtained" id="marksObtained"/></td>
                </tr>

 			</table>
        </form:form>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>


</html>