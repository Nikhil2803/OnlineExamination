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

</style>

</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
    <h3>Welcome !! To the Examiner portal.</h3>
    
    <div align="center" style="margin-top:50">
    <table>
    <tr><th>Sr. No</th> <th> Exam Id</th> <th>Exam Description</th></tr>
    <tr align="center">
    
    <c:forEach items="${exams}" var="exam" varStatus="status">
		<tr>
			<td>${status.index+1}</td>
			<td><a href="/getExamDetail?examId=${exam.key}">${exam.key}</a></td>
			<td>${exam.value}</td>
		</tr>
	</c:forEach>
     </tr>
    </table>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>


</html>