
	function fnAdd(loginUserGroup,value){
	//alert('1')
		if (loginUserGroup==1){
			location.href = "employeeList.asp?sentId=" + value;
		}
		else{
			alert("You dont have permission to do add operation")
		}

	}
	
	
	function fnDel(loginID){ 
	//alert('1')
	
		if( loginID ==1) {
			var checkedIds = "";
			checkboxes = document.getElementsByClassName("chk");
				for(var i=0, n=checkboxes.length;i<n;i++){
						if(checkboxes[i].checked){
							checkedIds = checkedIds + ',' + checkboxes[i].id.replace("chk_","");
							}
					}
			checkedIds = checkedIds.substring(1,checkedIds.length);
			document.getElementById("hidChkIds").value= checkedIds;
			alert(checkedIds)
			if (checkedIds==""){
				alert(" Please select any one of the records")
			}
			else{
				document.getElementById("action").value= "delete";
				document.forms[0].submit();
			}
		}
		else{
			alert("You dont have permission to do this operation")
		}
		
	
	}
	function fnSearch(){
		document.getElementById("action").value="Search";
		document.forms[0].submit();
	
	}
	function fnDetail(empId , loginId){
	//alert('1')
		if (loginId==1) {
			location.href="employeeList.asp?sentId=" + empId;
		}
		else{
			alert("you dont have permission to this operation")
		}
		
	}
	
	function fnSort(column,order){
	//alert(order)
		document.getElementById("action").value="order";
		if (column == document.getElementById("sortColumn").value && order == document.getElementById("sortOrder").value) {
			order= "DESC " ;
		}
		else{
			order="ASC";
		}
		//alert(order)
		document.getElementById("sortColumn").value=column; 
		document.getElementById("sortOrder").value = order ;
		document.forms[0].submit();
	}
	
	
	function fnChangeRecordsPerPage(objDropDown) {
		var objHidden = document.getElementById("HiddenRecordsPerPage");
		objHidden.value = objDropDown.value; 
		alert( objDropDown.value);
		document.forms[0].submit();
	}
	
	function fnNavigation(page ,records){
		document.getElementById("HiddenPageNumber").value = page;
		document.getElementById("HiddenRecordsPerPage").value=records ;
	
		document.forms[0].submit();
		
	}
	
	function fnGoToPageNumber(page){
		document.getElementById("HiddenNumber").value = page;
		alert (page);
		document.forms[0].submit();

	}
	
	function fnEditMyProfile(loginId) {
		location.href="employeeList.asp?sentId= " + loginId
		
	}
	function fnSelectAll(obj) {
		checkboxes = document.getElementsByName("recordcheckbox");
		for(var i=0, n=checkboxes.length;i<n;i++) 
		{
			checkboxes[i].checked = obj.checked;
		}
	}
	
	
