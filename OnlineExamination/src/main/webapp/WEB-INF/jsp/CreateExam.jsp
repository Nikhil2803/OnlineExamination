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

<script type="text/javascript">

function updateMarksTime(elem, mark, time,rowid){
var examMarks = parseInt(document.getElementById("marks").value);
var examTime = parseInt(document.getElementById("time").value);
if(elem!=null && elem.checked == true){
	examMarks = examMarks+parseInt(mark);
	examTime = examTime+parseInt(time);
	//document.getElementById(rowid).style.backgroundcolor='#ffff1a';
}else{
	//document.getElementById(rowid).style.backgroundcolor='#f5f5f5';
	if(examMarks>0){
		examMarks=examMarks-parseInt(mark);
	}
	if(examTime>0){
		examTime = examTime-parseInt(time);
	}
}
	document.getElementById("marks").value = examMarks;
	document.getElementById("time").value = examTime;
	document.getElementById("minutes").value = parseInt(examTime/60);
	document.getElementById("seconds").value = parseInt((examTime%60));
}

function updatedTime(){
var min =document.getElementById("minutes").value;
var sec =document.getElementById("seconds").value;
document.getElementById("time").value = parseInt(min*60)+parseInt(sec);
return true;

}

function populateTimeMarks(marks,time){
if(marks!=null && marks > 0){
	document.getElementById("marks").value = marks;
}
if(time!=null && time > 0){
	document.getElementById("minutes").value = parseInt(time/60);
	document.getElementById("seconds").value = parseInt((time%60));
}
}
</script>
</head>

<body onLoad="populateTimeMarks(${exam.totalMarks},${exam.totalTime})">
<jsp:include page="header.jsp"></jsp:include>
    <h2>Create Exam</h2>
    
    <div align="center" style="margin-top:50">
    <form:form method="POST"
          action="/addExam" modelAttribute="exam">
          
             <table>
 				<tr>
                    <td><form:label path="examName">Exam</form:label></td>
                    <td><form:input path="examName" value="${exam.examName}"/></td>
                </tr>
                
                 <tr>
                     <td><form:label path="subjectId">Subject</form:label></td>
                    <td><form:select path="subjectId"> 
                    	<%--  <form:option value="1" label="Maths"/>
                    	  <form:option value="2" label="Power System"/>
                    	  <form:option value="3" label="Digital Electronice"/> --%>
                    	   <form:option value="1" label="Electrical"/>
                     </form:select>
                </tr>
                
                <tr>
                <table>
                <tr><th> Select </th> <th> Question Description </th>  <th> Marks </th>  <th> Time </th></tr>
                <c:forEach items="${exam.questions}" var="question" varStatus="status">
               <tr id="row_${status.index} }"> <td><form:checkbox path="questinIds" value = "${question.questionId}" onchange="updateMarksTime(this,${question.marks},${question.time},'row_${status.index}')"></form:checkbox></td>
               		<td> ${question.questionDesc}</td>
               		<td> ${question.marks}</td>
               		<td> ${question.time} Seconds</td>
               	</tr>
                </c:forEach>
                </table>
                </tr>
                
                <tr>
                <table>
                <tr>
                    <td><form:label path="totalMarks" >Total Marks</form:label></td>
                    <td><form:input path="totalMarks" id="marks" value="${exam.totalMarks}"/></td>
                </tr>
                
                
                <tr>
                    <td><form:label path="totalTime">Total Time</form:label></td>
                    <td><input type="text" id="minutes"> Minutes <input type="text" id="seconds">Seconds
                    <form:hidden path="totalTime" id="time" value="${exam.totalTime}"/></td>
                </tr>
                
                 <tr>
                    <td><input type="submit" value="Submit" onclick="return updatedTime()"/></td>
                     <td><input type="reset" value="Reset"/></td>
                </tr>
                </table>
                </tr>
              </table>
        </form:form>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>


</html>