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

function hideOptionAnswer(){
	document.getElementById('forSingleSelect').style.display = "none";
	document.getElementById('forText').style.display = "none";
}


function changeForQuestionType(){
	var questionType = document.getElementById('questionType').value;
	if(questionType == "Text"){
		document.getElementById('forSingleSelect').style.display = "none";
		document.getElementById('forText').style.display = "block";
	}else{
		document.getElementById('forSingleSelect').style.display = "block";
		document.getElementById('forText').style.display = "none";
	}
}

function updateTime(){
var time = document.getElementById('timeInput').value;
var timeInSec = 0;
if(document.getElementById('timeType').value == 'minutes'){
	timeInSec = time*60;
}else{
	timeInSec = time;
}

document.getElementById('time').value=timeInSec;
}
</script>
</head>

<body onload="hideOptionAnswer()">
<jsp:include page="header.jsp"></jsp:include>
    <h3>Create Question</h3>
    
    <div align="center" style="margin-top:50">
    <form:form method="POST" id="questionForm"
          action="/addQuestion" modelAttribute="question">
             <table>

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
                    <td><form:label path="questionDesc">
                      Question Description</form:label></td>
                    <td><form:textarea path="questionDesc"/></td>
                </tr>
                
                 <tr>
                    <td><form:label path="questionType">
                      Question Type</form:label></td>
                    <td><form:select path="questionType" id="questionType" onchange="changeForQuestionType()"> 
                    	 <form:option value="---Select Option Type------"/>
                    	 <form:option value="Single" label="Sinlge Choice"/>
                    	  <form:option value="Multiple" label="Multiple Choice"/>
                    	  <form:option value="Text" label="Text Answer"/>
                    	</form:select>
                </tr>
                </table>
                
                <div id="forSingleSelect">
                <table>
                <c:forEach items="${question.options}" var="option" varStatus="status">
               	<tr> <td>Option ${status.index}</td><td><input name="options[${status.index}]" /></td></tr>
                </c:forEach>
          
               <c:forEach items="${question.answers}" var="answer" varStatus="status">
              <tr> <td>Answer ${status.index}</td><td><input name="answers[${status.index}]" /></td></tr>
                </c:forEach>
                </table>
               </div>
                
                <div id="forText">
          	  	<c:forEach items="${question.options}" var="option" varStatus="status">
               	<input type="hidden" name="options[${status.index}]" />
                </c:forEach>
                
                <table>
		              <tr> <td>Answer </td><td><form:input path="answers[0]" /></td></tr>
              </table>
               </div>
               <table>
                 <tr>
                    <td><form:label path="marks">Marks Alloted to Question</form:label></td>
                    <td><form:input path="marks"/></td>
                </tr>
                
                <tr>
                    <td><form:label path="time">Time For Question</form:label></td>
                    <td><form:hidden path="time" id="time" value="60"/>
                    <input type="text" id="timeInput"/>
                   	<select id="timeType" onchange="updateTime()">
                       <option value="seconds">----Select Time Unit----</option>
                     <option value="seconds">in Seconds</option>
                     <option value="minutes">in Minutes</option>
                    </select></td>
                </tr>
                
                <tr>
               	    <td><input type="reset" value="Reset"/></td>
                    <td><input type="submit" value="Submit" /></td>
                </tr>
            </table>
        </form:form>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>



</html>