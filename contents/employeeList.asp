<%Option Explicit %>
<%
	Session.Timeout=20
	If session("loginId")=""then
		response.redirect "../default.asp"
	End If
	'dim add:add=request.querystring("sentAddNumber")
	'response.write "test" &add
	'Dim param :param=Request.querystring("action")
	'response.write "test " &param
	Dim objConn, objRS, sql ,message,strId,searchedName,column ,nPageCount ,strSql
	Dim checkedIds : checkedIds = Request.form("hidChkIds")
	Dim strName,strRank,strTeam,strDOB,strGender,strBlood,strAddress,strEmail,strPhone,strUser,strPass
	Dim strMob,strEmer,strCity,strDistrict,strCountry,strEmOff,strEmPer,strHom,order ,strOff
	searchedName=Request.form("txtSearch")
	Dim selectedIndex :selectedIndex = Request.form("HiddenRecordsPerPage")
	Dim nPage: nPage = Request.form("HiddenPageNumber")
	Dim userInputNumber :userInputNumber =Request.form("HiddenNumber")
	Dim strDisplay :strDisplay = "none"
	'Response.Write "</br> Page Number entered is :" &userInputNumber
	If nPage="" Then 
		nPage= 0 
	End If
	
	If selectedIndex="" Then
		selectedIndex = 8  
	End If
	If  Not nPage=Request.form("HiddenPageNumber") Then 
		nPage =userInputNumber
	End If

	Set objConn = Server.createobject("ADODB.connection")
	Set objRS = Server.createobject("ADODB.Recordset")
	objConn.Open "Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;Password=procit;Initial Catalog=EmployeeInfo;Data Source=ITH-PC"
	sql=  "SELECT  * FROM employee INNER JOIN tblEmployeeDetail ON employee.fldEmpId=tblEmployeeDetail.fk_fldEmpId "
	If Request.form("action")= "Search" OR  searchedName <>"" Then
		sql=  sql & "WHERE fldName LIKE  '%" & searchedName & "%'  OR  fldCity  LIKE '%" & searchedName &"%' OR "
		sql= sql & "fldTeam LIKE '%" & searchedName & "%' OR fldCountry LIKE  '%" &searchedName& "%'  OR "
		sql=  sql & "fldRank LIKE '%" & searchedName & "%' OR fldGender LIKE '%" &searchedName& "%' OR "
		sql = sql & " fldDistrict LIKE '%" & searchedName & "%' OR fldBloodGroup LIKE '%" &searchedName&"%' OR fldEmailPErsonal LIKE '%" & searchedName & "%' OR"
		sql = sql & " fldPhoneMobile  LIKE '%" & searchedName & "%' OR fldDOB LIKE '%" &searchedName& "%' "
	End If 
	column= Request.form("sortColumn")
	order = Request.form("sortOrder")
	
	If Request.form("action")="order" Then 
		sql = sql & " ORDER BY " &column& " " &order& ";"
		'response.write sql
	End If
	If Request.form("action")="delete" AND  checkedIds<>"" Then
	
		sql=" DELETE from employee WHERE fldEmpId in (" &checkedIds& " );DELETE from tblEmployeeDetail WHERE fk_fldEmpId in (" &checkedIds& ") "
		response.write sql
		objConn.Execute (sql)
		Response.redirect "employeeList.asp"
	
	End If
	
	objRS.CursorLocation=3
	'response.write sql
	objRS.Open sql, objConn
	objRS.PageSize = CLng(selectedIndex)
	'response.write "</br>selected " &CLng(selectedIndex)
	nPageCount = objRS.PageCount
	'response.write "</br>page No.:" &nPage & "<br> PageCount:" &nPageCount 
	'response.write "</br>-----------------------------"
	If nPage="" Then 
		nPage= 0 
	End If
	
	nPage = Clng(nPage)
	'response.write "</br>test Page Number " &nPage
	
	If (nPage < 1 Or nPage > nPageCount) Then
	'response.Write "</br>Page1"
		nPage = 1
	End If

	'response.write "</br>page No.:" &nPage & "<br> PageCount:" &nPageCount 
	objRS.AbsolutePage = nPage
	
%>
<script language="JavaScript" src="../script/EmployeeList.js"></script>
<html>
	<link rel="stylesheet" type="text/css" href="../contents/external.css"  />
	<body>
	<!--#include file="header.asp"-->
	<!--#include file="menu.asp"-->
	<form method="post" action="">	
	<div id="wrapper">
		<div id="toolbar">
			<table>
					<tr>
					<input type="hidden" id="hidChkIds" name="hidChkIds" value=""/>
					<input type="hidden" id="action" name="action" value=""/>
					<input type="hidden" id="sortColumn" name="sortColumn" value="<%=column%>"/>
					<input type="hidden" id="sortOrder" name="sortOrder" value="<%=order%>"/>
					<input type="hidden" id="dropDown" name="dropDown" value=""/>
					<input type="hidden" name="HiddenRecordsPerPage" id="HiddenRecordsPerPage" value="<%=selectedIndex%>" />
					<input type="hidden" name="HiddenPageNumber" id="HiddenPageNumber" value="" />
					<input type="hidden" name="HiddenNumber" id="HiddenNumber" value="" />
					
					<td><input type="button" onclick="fnEditMyProfile('<%=session("loginId")%>');" name="editMyProfile" id="editMyProfile" value="Edit My Profile" /></td>&nbsp&nbsp&nbsp
					<td><input type="text" id="txtSearch" value="<%=searchedName%>" name="txtSearch" placeholder="Please enter the name to search"/></td>
					<td><input type="button" id="buttonSearch" name="buttonSearch" onclick="javascript:fnSearch();" value="Search"/></td>
					<td><input type="button"  id="butAdd" name="butAdd" onclick="javascript:fnAdd(<%=session("loginUserGroupId")%>,0);" value="add"/></td>
					<td><input type="button"  id="butDelete" name="butDelete" onclick="javascript:fnDel('<%=session("loginUserGroupId")%>');" value="delete"/></td>
					</tr>
			</table>
		</div>
	
		<table     width="1100" style="margin:0 auto;" frame="box">
				<tr rowspan  bgcolor="#C0C0C0" >
					<td><input type="checkbox" onchange="fnSelectAll(this);" name="chk"  id="idCheck" /></td>	
					<td onclick="fnSort('fldName','ASC')">FirstName</td>
					<td onclick="fnSort('fldUsername','ASC')">UserName</td>
					<td onclick="fnSort('fldPassword','ASC')">PassWord</td>
					<td onclick="fnSort('fldRank','ASC')">Rank</td>
					<td onclick="fnSort('fldTeam','ASC')">Team</td>
					<td onclick="fnSort('fldDOB','ASC')">DOB</td>
					<td onclick="fnSort('fldGender','ASC')">Gender</td>
					<td onclick="fnSort('fldBloodGroup','ASC')">BloodGroup</td>
					<td onclick="fnSort('fldCity','fldDistrict','fldCountry''ASC')">Address</td>
					<td onclick="fnSort('fldEmailPErsonal','ASC')">Email(Personal)</td>
					<td onclick="fnSort('fldEmailOfficial','ASC')">Email(Official)</td>
					<td onclick="fnSort('fldPhoneMobile','ASC')">Contact(M)</td>
					<td onclick="fnSort('fldPhoneHome','ASC')">Contact(H)</td>
					<td onclick="fnSort('fldPhoneEmergency','ASC')">Contact(E)</td>
					<td>
				</tr>
				
		
		<%
				If objRs.EOF Then
		%>
					<tr><td colspan=14>No records found</td></tr>
		<%
				Else
					Do While Not (objRS.Eof Or objRS.AbsolutePage <> nPage )
						strId= objRS.fields("fldEmpId")
						strName = objRS.fields("fldName")
						strUser=objRS.fields("fldUsername")
						strPass=objRS.fields("fldPassword")
						strRank = objRS.fields("fldRank")
						strTeam = objRS.fields("fldTeam")
						strDOB = objRS.fields("fldDOB")
						strGender = objRS.fields("fldGender")
						strBlood = objRS.fields("fldBloodGroup")
						strEmPer= objRS.fields("fldEmailPErsonal")
						strOff= objRS.fields("fldEmailOfficial")
						strMob = objRS.fields("fldPhoneMobile")
						strHom = objRS.fields("fldPhoneHome")
						strEmer = objRS.fields("fldPhoneEmergency")
						strCity = objRS.fields("fldCity")
						strDistrict = objRS.fields("fldDistrict")
						strCountry = objRS.fields("fldCountry")
						
		%> 
						<tr>
						<td><input type="checkbox" class="chk"  name="recordcheckbox" id="chk_<%=strId%>" /></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strName%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strUser%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strPass%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strRank%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strTeam%> </td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strDOB%></td>
							<td onclick="javascript:fnDetail('<%=strID%>','<%=session("loginUserGroupId")%>');"><%=strGender%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strBlood%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strCity%> ,<%=strDistrict%> ,<%=strCountry%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strEmPer%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strOff%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strMob%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strHom%></td>
							<td onclick="javascript:fnDetail('<%=strId%>','<%=session("loginUserGroupId")%>');"><%=strEmer%></td>
						</tr>
						
		<%
						objRS.Movenext
						
					Loop
				End If
						
				objRS.close
				Set objRS=Nothing
				objConn.close
				Set objConn=Nothing
				
		%>			
		</table>
		
	</br>
	
	
	<!--#include file="footer.asp"-->
		</body>
	</form>	
	<div id="frame">
			<iframe id="iFrameID" frameborder="50"  style=<%If Request.querystring("sentId")="" Then %> "display:none" <% Else If Request.querystring("sentId")<>0 Then  %> "display:block " <%End If End If%>" scrolling="no" marginwidth="20"  
width="1110" height="600"
			img src="iFrameEmployeeDetail.asp?sentId=<%=Request.querystring("sentId")%>"
			name="imgbox" id="imgbox"></iframe><br />
	</div>
	</div>
	</html>



	   
	 
       