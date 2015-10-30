<%Option Explicit%>

<%  
Dim fldUserName : fldUserName = Request.Form("txtUserName")
Dim fldPassword : fldPassword = Request.Form("txtPassword")
Dim loginMessage
'response.write "login" &session("loginUser")

If Request.Form("action") = "log_in" Then
	Dim objConn, objRS, sql
	Set objConn = Server.createobject("ADODB.connection")
	Set objRS = Server.createobject("ADODB.Recordset")
	objConn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=procit;Initial Catalog=EmployeeInfo;Data Source=ITH-PC"

	sql = "SELECT * FROM Employee WHERE fldUserName = '"  & fldUserName & "'"
	objRs.Open sql, objConn
	
	If objRs.EOF Then
		loginMessage = "Login failed"
	Else
		session("dbConnString") = "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa; password=procit; Initial Catalog=EmployeeInfoApplication;Data Source=ITH-105"
		session("loginId") = objRS.fields("fldEmpId")
		session("loginUser") = objRS.fields("fldUsername")
		session("loginUserGroupId") = objRS.fields("fld_fkUserGroupId")
		response.redirect("employeeList.asp")
	End If
	
	objRs.Close
	Set objRs = Nothing
	objConn.Close
	Set objConn = Nothing
End If	
%>
<html>
<script>
	function fnLogin(){
		
		if (validate()){
			document.getElementById("action").value = "log_in";
			document.forms[0].submit();
		}
	}
	
function validate(){
		var returnVal=true;
		var username = document.getElementById("txtUserName").value;
		var password = document.getElementById("txtPassword").value;
		if ((username=="") || (password== "") ){
			alert('Username and Password are empty');
			returnVal=false;
		}
		else {
			location.href="employeeList.asp";
			returnVal=true;
		}
		return returnVal;
	}
	
</script>

<html>
<link rel="stylesheet" type="text/css" href="external.css"  />
<div id="header">
<div class="header1">
<h1 align="center">Employee Info Application</h1>
</div></div>
<div id="wrapper">
<div class="menu"
</div>
</div>

	<fieldset id="fieldset3" style="padding:20px;top:230px; position: absolute; margin-left : 450px" >
	<legend><h3 style=" color:black ">Login:</h3></legend>
	<form method="post" action="">
		<input type="hidden" id="action" name="action" value=""><br>
		<table align="center" height="100" width="100"/>
	
		<tr>
		<td>Username:</td>
		<td><input type="text" id="txtUserName" name="txtUserName" value="<%=fldUserName%>" ></input></td><br>
		</tr>
		<tr>
		<td>Password:</td>
		<td><input type="password" id="txtPassword" name="txtPassword" value=""></input></td><br>
		</tr>
		<tr>
		<td position="absolute" align="left" ><input type="button"  onclick="fnLogin();" value="login" ></input></td>
		</tr>
		<%If loginMessage <> "" Then%>
			<span style="color:red"><%=loginMessage%></span>
		<%End If%>
		</fieldset>
	</form>
	
</body>
</html>