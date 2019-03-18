<html>
<head>
<title>Online Examination</title>
<style>
body {background-color: powderblue;}
.icons {height: 100px;width: 100px;}
.icons:hover { transform: scale(1.2); }
</style>

</head>

<body>
<jsp:include page="header.jsp"></jsp:include>
    <h3>Welcome !! To the Examiner portal.</h3>
    
    <div align="center" style="margin-top:50">
    <table>
    <tr align="center">
    <td><a href="/createQuestion" title="Add a Question to Dictionary"><input class = "icons" type="image" src="questions.png" ></a></td>
    <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
    <td><a href="/createExam" title="Create a Exam with Questions"><input class = "icons" type="image" src="exams.png" size="30"></a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
     <td>&nbsp;</td>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     <td>&nbsp;</td>
    <td><a href="/listExams" title="List of Exams"><input class = "icons" type="image" src="listofexams.jpg" size="30"></a></td>
    <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
    <td><a href="/showResults" title="Show Results"><input class = "icons" type="image" src="results.png" size="30"></a></td>
    </tr>
    
     <tr align="center">
    <td><a href="/createQuestion"><h5>Add Question</h5></a></td>
    <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
    <td><a href="/createExam"><h5>Create Exam</h5></a></td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
     <td>&nbsp;</td>
       <td>&nbsp;</td>
       <td>&nbsp;</td>
     <td>&nbsp;</td>
    <td><a href="/listExams"><h5>List All Exam</h5></a></td>
    <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
     <td>&nbsp;</td>
    <td><a href="/showResults"><h5>Exam Results</h5></a></td>
    </tr>
    </table>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
</body>


</html>