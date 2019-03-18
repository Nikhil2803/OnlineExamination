<html>
<head>
<title>Online Examination</title>
<style>
#header {
background-color: #254d74;
color: white;
margin-top: 0px;
height: 130px;
}
img {
margin-top: 5px; margin-left : 10px; height: 100px;width: 100px;
}
body {background-color: powderblue;}
.icons {height: 100px;width: 100px;}

</style>

</head>

<body>
<div id="header">
<a href="/Login" style="float: left;"><img src="sgsits.png"></a>
<a href="/About" style="float: right;" title="About portal"><img src="about.png" style="height:60px;width: 60px;"></a>
</div>
<h3>Welcome !! To Examination portal.</h3>
<h4 style="color:red;">${message}</h4>
<div align="center" style="margin-top:100">
<form action="/access" method="post">
<table>
<tr><td>Role :</td><td><select id="role" name="role">
<option>Admin</option>
<option>Student</option>
</select></td></tr>
<tr><td>Enter Enrollment :</td><td><input type="text" name="enrollment"></td></tr>
<tr><td>Enter Exam Id/password :</td><td><input type="text" name="accessid"></td></tr>
<tr align="center"><td colspan="2"><input type="submit" value="Login"></td></tr>
</table>
</form>
</div>
<jsp:include page="footer.jsp"></jsp:include>
</body>


</html>