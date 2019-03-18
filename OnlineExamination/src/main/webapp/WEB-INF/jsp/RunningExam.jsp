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

var tabSwitch = 3;
var alreadySwitched=false;
function checkFocus() {
  var info = document.getElementById("message");

  if ( !document.hasFocus() ) {
    alert("Do not Switch the tab or minimize the current window while the test is on.");
    
    if(alreadySwitched==false)
    --tabSwitch;
    
    alreadySwitched=true;
    
  }else{
  	alreadySwitched=false;
  }
  if(tabSwitch==0){
    alert("Due to repeated switching of Tab or minimizing the test window. This test is getting submitted");
     clearInterval() ;
    document.forms["examResult"].submit();
  }
}

function populateOptions(){

	var divElements = document.getElementsByTagName('div');
	var count=0;
		for(var i=0; i<divElements.length;i++){
			if(divElements[i].id.includes("quest_")){
				if(document.getElementById("questType_"+count).value == 'Text'){
					document.getElementById('questTextAns_'+count).style.display="block";
					document.getElementById('quest_'+count).style.display="none";
				}else{
					document.getElementById('questTextAns_'+count).style.display="none";
					document.getElementById('quest_'+count).style.display="block";
				}
					++count;
			}
		}

}

function updateTime(){
var currentTime = document.getElementById('time').innerHTML.split(':');
var hour;
var min =0;
var sec = 0;
if(currentTime.length>1){
	if(currentTime[2]>0){
		hour = currentTime[0];
		min = currentTime[1];
		sec = currentTime[2]-1;
	}else if(currentTime[1]>0) {
		hour = currentTime[0];
		sec = 60;
		min = currentTime[1]-1;
	}else if (currentTime[0]>0){
		hour = currentTime[0]-1;
		sec = 60;
		min = 60;
	}
	else{
		hour = 0;
		sec = 0;
		min = 0;
	  alert('Time for Exam is over. Submiting Exam.');
	  clearInterval() ;
	  document.forms["examResult"].submit();
	}
}else{
	hour = parseInt(currentTime/3600);
	min = parseInt((currentTime%3600)/60);
	sec = parseInt((((currentTime%3600)%60)));
}

if(hour == 0  && sec ==0 && min==5){
	alert("Last 5 Minutes remaining")
}

document.getElementById('time').innerHTML = " "+hour+":"+min+":"+sec;
}

window.setInterval(updateTime,1000);
window.setInterval(checkFocus,1000);
</script> 
</head>

<body onload="populateOptions()">
<jsp:include page="header.jsp"></jsp:include>
<div>
    <h2>Best of Luck !!</h2>
	<h4 id="time" style="color:red;float:right;"> ${totalTime}</h4><h4 id="timer" style="float:right">Time remaining :: </h4>
</div>    
    
    <div align="center" style="margin-top:50">
    <form:form method="POST"
          action="/generateResult" modelAttribute="examResult">
          <form:hidden path="enrollmentId"  value="${examResult.enrollmentId}"/>
          <form:hidden path="examId"  value="${examResult.examId}"/>
          
            <table>
            
            <tr>
                    <td><form:label path="examId">Exam ID</form:label></td>
                    <td> ${examResult.examId}</td>
             </tr>
             
             <tr>
                    <td><form:label path="enrollmentId">Enrollment ID </form:label></td>
                    <td> ${examResult.enrollmentId}</td>
             </tr>
             </table>
             <br/>

         <div id="examDiv">
               <c:forEach items="${examResult.questions}" var="question" varStatus="status">
               	<input type="hidden" id ="questType_${(status.index)}" value="${question.questionType}">
               	
               	<div id="quest_${(status.index)}">	
               		<table>
               		<tr><td colspan="3">${(status.index)+1}. ${question.questionDesc}</td></tr>
               		<tr>
               		<td><form:radiobutton id="${(status.index)+1}" path="questAnsMap[${question.questionId}]" value="${question.options.get(0)}"/> ${question.options.get(0)}</td> 
               		<td><form:radiobutton id="${(status.index)+1}" path="questAnsMap[${question.questionId}]" value="${question.options.get(1)}"/> ${question.options.get(1)}</td>
               		</tr>
               		<tr>
               		<td><form:radiobutton id="${(status.index)+1}" path="questAnsMap[${question.questionId}]" value="${question.options.get(2)}"/> ${question.options.get(2)}</td> 
               		 <td><form:radiobutton  id="${(status.index)+1}" path="questAnsMap[${question.questionId}]" value="${question.options.get(3)}"/>  ${question.options.get(3)}</td>
               		</tr>
               		</table>
               	</div>	
               	
               	
               	 <div id="questTextAns_${(status.index)}">	
               		<table>
               		<tr><td colspan="3">${(status.index)+1}. ${question.questionDesc}</td></tr>
               		<tr>
               		<td><form:input path="questAnsMap[${question.questionId}]" value=""/></td></table>
               	</div>
 					
 					<br/>
                </c:forEach>
                <br/>
            </div>
               <table>
                 <tr>
                    <td><input type="submit" value="Submit"/></td>
                     <td><input type="reset" value="Reset"/></td>
                </tr>
 			</table>
        </form:form>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>


</html>