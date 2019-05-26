<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<!-- <link rel="stylesheet" type="text/css" href="./resources/css/prettydropdowns.css" media="all" />  -->
<link rel="stylesheet" type="text/css" href="./resources/css/main.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery-ui-1.8.custom.css"/>
<link id="themecss" rel="stylesheet" type="text/css" href="./resources/css/common/all.min.css"/>
<!-- <link id="themecss" rel="stylesheet" type="text/css" href="//www.shieldui.com/shared/components/latest/css/light/all.min.css" /> -->
<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<!-- <script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script> -->
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.custom.js"></script>  
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/common/jquery-1.11.1.min.js"></script>  
<script type="text/javascript" src="resources/script/common/shieldui-all.min.js"></script>
<!-- <script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="//www.shieldui.com/shared/components/latest/js/shieldui-all.min.js"></script> -->

<!--popup event -->
<link type="text/css" rel="stylesheet" href="resources/css/member/member_list_popup.css" />
<script type="text/javascript" src="resources/script/member/member_list_popup.js"></script>

<!-- <script src="resources/script/jquery/jquery-latest.min.js"></script> 
<script src="resources/script/jquery/jquery.prettydropdowns.js"></script> 

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script> 
<script type="text/javascript" src="dwr/interface/IMatService.js"></script> 

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var temp = [];
$(document).ready(function(){

	$("#mat_insert").bind("click", function(){	
	    location.href = "maintenance_insert";
	});
	
	
	$("#mat_managed").bind("click", function(){	
	   	location.href = "maintenance";
	});
	
	/* 유지보스 등록 버튼 이벤트 */
    $("#edit_update_btn").bind("click", function(){   	
    	var cusNm = $("#cusName_id").val();
    	var proNm = $("#cusproName_id").val();
    	var dbmsId = $("#dbms_select_id").val();    	
    	var dbmsVersion = $("#dbmsVer_id").val();
    	var cusUserNm = $("#cusUser_id").val();
    	var salesmanId =$("#salesman_select_id").val();
    	var user1Id = $("#user1_select_id").val();
    	var user2Id = $("#user2_select_id").val();
    	var supoLeverId = $("#supo_level_select_id").val();
    	var supoVisitId = $("#supo_state_select_id").val();
    	var supoinstallData = $("#install_date_id").val();
        var supostateDate = $("#supo_start_date_id").val();
        var supoendDatae = $("#supo_end_date_id").val();
        var etc = $("#etc_id").val();
	
/*         alert(proId);
    	alert(dbmsId);
    	alert(dbmsVersion);
    	alert(cusNm);
    	alert(salesmanId);
    	alert(user1Id);
    	alert(user2Id);
    	alert(supoLeverId);
    	alert(supoVisitId);
    	alert(supoinstallData);
    	alert(supostateDate);
    	alert(supoendDatae);
    	alert(etc); */
    	
    	alert(supoinstallData);
    	
     	if(proNm == ""){     		
     		alert("프로젝트명을 선택하세요.");	   		
     	}else{
			if(dbmsId == "0"){
				alert("업무를 선택해주세요.");
     		}else{
     			if(salesmanId == "0"){
     				alert("담당영업을 선택하세요.");
     			}else{
     				if(user1Id == "0"){
     					alert("담당엔지니어를 선택하세요.");
     				}else{     				
     					IMatService.insertMatinfo(cusNm, proNm, dbmsId, dbmsVersion, cusUserNm, salesmanId,
     											user1Id, user2Id, supoLeverId, supoVisitId, supoinstallData,
     											supostateDate, supoendDatae, etc, insertMatinfoCallBack);     	                       
     				}
     			}     		
     		}     	
     	}     	
    });
	
	$("#cusName_id").shieldComboBox({
    	dataSource: {
            data: ""
        },        	        
        enabled: false
	}); 
	
	$("#cusproName_id").shieldComboBox({
    	dataSource: {
            data: ""
        },	        
        enabled: false
        
	});  
	
	$("#dbms_select_id").change(function (){
		var dbmsId = $("#dbms_select_id").val();	
		
		if(dbmsId > 0){	
			IMatService.getdeptteam(dbmsId, getTeaminfoCallBack);
		}else{
			$("#team_select_id").val("0");
			$("#team_select_id").val("0").prop("selected", true);
			$("#user1_select_id").val("0");
			$("#user1_select_id").val("0").prop("selected", true);
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#team_select_id").prop("disabled",true);				
			$("#user1_select_id").prop("disabled",true);
			$("#user2_select_id").prop("disabled",true);							
		}	
	});
	
	
	$("#team_select_id").change(function (){
	
		var teamId = $("#team_select_id").val();	

		if(teamId > 0){	
			IMatService.getTeammember(teamId, "", getUserinfo1CallBack);	 
		}else{
			$("#user1_select_id").val("0");
			$("#user1_select_id").val("0").prop("selected", true);
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#user1_select_id").prop("disabled",true);
			$("#user2_select_id").prop("disabled",true);							
		}	
	});
	
	
	$("#user1_select_id").change(function (){
		
		var user1Nm = $("#user1_select_id").val();	
		var teamId = $("#team_select_id").val();	
		
		if( user1Nm != "0"){	
			IMatService.getTeammember(teamId, user1Nm, getUserinfo1CallBack1);			
		}else{		
			$("#user2_select_id").val("0");
			$("#user2_select_id").val("0").prop("selected", true);
			$("#user2_select_id").prop("disabled",true);												
		}	
	});
	
	$("#supo_level_select_id").change(function (){
		var supoLevel = $("#supo_level_select_id").val();	
		
	 	if( supoLevel > 0){	
	 		IMatService.getSupovisit(supoLevel, getsupolevelinfoCallBack);
		}else{
			$("#supo_state_select_id").val("0");
			$("#supo_state_select_id").val("0").prop("selected", true);
			$("#supo_state_select_id").prop("disabled",true);						
		}	 
	});
	
	ICustomerService.getcusNminfo(cusNminfoCallBack);
	
});

function cusNminfoCallBack(res){
	var cuslist = [];
	
	for(var i = 0; i < res.length; i++){	
			 cuslist.push(res[i].cusNm);			
	 } 
	 
	 $("#cusName_id").swidget().destroy();
	
	 $("#cusName_id").shieldComboBox({
	    	dataSource: {
	            data: cuslist
	        },	        
	        autoComplete: {
	            enabled: true
	        },events: {
	        	change : function(e){   
        			var cusNm =  $("#cusName_id").val();	        			
        		
        			$("#cusUser_id").val("");
       			    ICustomerService.getcusNmProinfo(cusNm,"", cusNmProinfoCallBack);	           			   
        	   	}
	        }
    }); 	
}

function cusNmProinfoCallBack(res){	
	var prolist = [];
	
	if (res.length > 0){		
		$("#cusproName_id").swidget().enabled(true);
		
		for(var i = 0; i < res.length; i++){	
			 prolist.push(res[i].proNm);			
		}
				
		$("#cusproName_id").swidget().destroy();
				
		$("#cusproName_id").shieldComboBox({
	    	dataSource: {
	            data: prolist
	        }, 
	        autoComplete: {
	            enabled: true
	        } ,
	        events: {
	        	change : function(e){    
        			var cusNm = $("#cusName_id").val();   		 
        			var proNm = $("#cusproName_id").val();	        			
        		
       			    ICustomerService.getcusNmProinfo(cusNm,proNm, cusNmProcheckCallBack);	 
       			    
	        	}
	        }	       
		});  	
		
	}else{
		alert("해당 고객사는 존재하지 않습니다.");

		$("#cusproName_id").swidget().enabled(false);
		
		$("#salesman_select_id").prop("disabled",true);	
		$("#salesman_select_id").val("0");	
		$("#salesman_select_id").val("0").prop("selected", true);
		
		$("#dbms_select_id").prop("disabled",true);	
		$("#dbms_select_id").val("0");	
		$("#dbms_select_id").val("0").prop("selected", true);
		
		$("#team_select_id").prop("disabled",true);	
		$("#team_select_id").val("0");
		$("#team_select_id").val("0").prop("selected", true);
		
		$("#user1_select_id").prop("disabled",true);	
		$("#user1_select_id").val("0");
		$("#user1_select_id").val("0").prop("selected", true);
		
		$("#user2_select_id").prop("disabled",true);	
		$("#user2_select_id").val("0");
		$("#user2_select_id").val("0").prop("selected", true);
	}
}	

function cusNmProcheckCallBack(res){
	if (res.length > 0){
		$("#cusUser_id").val(res[0].cus1Nm);	
		if (res[0].salseId != null){
			$("#salesman_select_id").val(res[0].salseId).prop("selected", true);	
		}else{
			$("#salesman_select_id").val("0").prop("selected", true);
		}		
		
		$("#dbms_select_id").attr("disabled",false);

	}else{
		alert("해당 프로젝트는 존재하지 않습니다.");	
		
		$("#salesman_select_id").prop("disabled",true);	
		$("#salesman_select_id").val("0");	
		$("#salesman_select_id").val("0").prop("selected", true);
		
		$("#dbms_select_id").prop("disabled",true);	
		$("#dbms_select_id").val("0");	
		$("#dbms_select_id").val("0").prop("selected", true);
		
		$("#team_select_id").prop("disabled",true);	
		$("#team_select_id").val("0");
		$("#team_select_id").val("0").prop("selected", true);
		
		$("#user1_select_id").prop("disabled",true);	
		$("#user1_select_id").val("0");
		$("#user1_select_id").val("0").prop("selected", true);
		
		$("#user2_select_id").prop("disabled",true);	
		$("#user2_select_id").val("0");
		$("#user2_select_id").val("0").prop("selected", true);
				
	}
}

function getTeaminfoCallBack(res){
	var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#team_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){	
			
			text += "<option value="+res[i].teamId+">"+res[i].teamNm+"</option>";
		}
	}
	
	$("#team_select_id").html(text);
}

function getUserinfo1CallBack(res){
var text = "";			
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#user1_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){	
			
			text += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";
		}
	}
	
	$("#user1_select_id").html(text);
} 		   

function getUserinfo1CallBack1(res){
	var text = "";			
		
		text += "<option value='0' selected>지정하지 않음.</option>";

		if (res.length > 0){
		
			$("#user2_select_id").prop("disabled",false);	
			
			for(var i = 0; i < res.length; i++){	
				
				text += "<option value="+res[i].userId+">"+res[i].userNm+"</option>";
			}
		}
		
		$("#user2_select_id").html(text);
	} 		 
	
function getsupolevelinfoCallBack(res){
	var text = "";	
	
	text += "<option value='0' selected>지정하지 않음.</option>";

	if (res.length > 0){
	
		$("#supo_state_select_id").prop("disabled",false);	
		
		for(var i = 0; i < res.length; i++){	
			
			text += "<option value="+res[i].supoVisitId+">"+res[i].supoVisitNm+"</option>";
		}
	}
	
	$("#supo_state_select_id").html(text); 	
}

function insertMatinfoCallBack(res){
	if(res == "FAILED"){
		alert("실패");
		location.href = "maintenance_insert";
	}else if(res == "SUCCESS"){
		alert("성공");
		location.href = "maintenance_insert";
	}
}
</script>

<style>
/*
 table, td, th {    
    border: 1px solid #ddd;
    text-align: left;
}

table {
    border-collapse: collapse;
    width: 50%;
}

th, td {
    padding: 10px;
}

.redText{display: block;color: red;margin-left:10px;}
.greenText{display: block;color: green;margin-left:10px;}

    .sui-combobox
    {
        font-family: Arial, sans-serif;
        font-size: 14px;
    }
*/

.reg_pass {
	position:absolute; 
	border:1px solid #d1cece; 
	height:38px;
	padding:1px;
	width:290px;
	left:238px;
	top: 856px;
}

.miBtt_submit_top {
	position:absolute; 
	top: 856px;
	margin-left: 70px;
}
</style>

</head>
<body>
<c:import url="/main_upview"></c:import>
		<div class="top_SubMenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_SubMenu01_ma" id="mat_managed">유지보수 관리</a>
				<a href="#" class="top_SubMenu02_ma" id="mat_insert">유지보수 등록</a>
			</div>
		</div>
		
<div class="row">
	 <!-- div class="column side">
		   <h4>유지보수 관리 페이지</h4></br>
		   <a href="#" id="mat_managed">유지보수 관리</a></br>		    
		   <a href="#" id="mat_insert">유지보수 등록</a></br>		 
	 </div -->
	 <div class="top_mainDisplayPart">
		<div align="center"><h3>유지보수 등록 페이지</h3></div>
		<div id="customer_list" class="top_mainDisplayBase" >
		
			 <ul>
					<li class="input_title input_01 inputTxtFont">고객사명*</li>
					<li class="input_title input_02 inputTxtFont">프로젝트명*</li>
					<li class="input_title input_03 inputTxtFont">업무명*</li>
					<li class="input_title input_04 inputTxtFont">제품 버전</li>
					<li class="input_title input_05 inputTxtFont">고객담당자</li>
					<li class="input_title input_06 inputTxtFont">담당영업*</li>
					<li class="input_title input_07 inputTxtFont">담당부서</li>
					<li class="input_title input_08 inputTxtFont">담당 엔지니어(정)</li>
					<li class="input_title input_09 inputTxtFont">담당 엔지니어(부)</li>
					<li class="input_title input_10 inputTxtFont">최초 설치일</li>
					<li class="input_title input_11 inputTxtFont">MA 현 상태</li>
					<li class="input_title input_12 inputTxtFont">MA 유형</li>
					<li class="input_title input_13 inputTxtFont">MA 시작일</li>
					<li class="input_title input_14 inputTxtFont">MA 종료일</li>
					<li class="input_title input_15 inputTxtFont">비고</li>
			</ul>
	 			
	 			
						<div class="input_txt_01 input_01 inputTxtFont">
						    <input id="cusName_id"/>		
						</div>
						<div class="input_txt_01 input_02 inputTxtFont">
							<input id="cusproName_id"/>										
						</div>
						
							<select id="dbms_select_id" disabled="disabled" class="input_txt input_03 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="dl" items="${dbms_list}">
				 	    			<option value="${dl.dbmsId}">${dl.dbmsNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
									
						<input type="text" id='dbmsVer_id' value="" class="input_txt input_04 inputTxtFont sui-input">												
							
						<input type="text" id='cusUser_id' value="" readonly="readonly" class="input_txt input_05 inputTxtFont sui-input">													
					
							<select id='salesman_select_id' class="input_txt input_06 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sl" items="${salseman_list}">
				 	    			<option value="${sl.userId}">${sl.userNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						
							<select id='team_select_id' disabled="disabled" class="input_txt input_07 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
						
							<select id='user1_select_id' disabled="disabled" class="input_txt input_08 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
						
							<select id='user2_select_id' disabled="disabled" class="input_txt input_09 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>							  	
							</select>
												
							<input type='date' id='install_date_id' class="input_txt input_10 inputTxtFont sui-input">														
					
							<select d='supo_level_select_id' class="input_txt input_11 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>
							    <c:forEach var="sll" items="${supo_level_list}">
				 	    			<option value="${sll.supoId}">${sll.supoNm}</option>		 	    	
				 	    		</c:forEach>	
							</select>
						
						    <select id='supo_state_select_id' disabled="disabled" class="input_txt input_12 inputTxtFont sui-input">
								<option value="0" selected>지정하지 않음.</option>
							  <%--   <c:forEach var="svl" items="${supo_visit_list}">
				 	    			<option value="${svl.supoVisitId}">${svl.supoVisitNm}</option>		 	    	
				 	    		</c:forEach> --%>
							</select>
																							
							<input type='date' id='supo_start_date_id' class="input_txt input_13 inputTxtFont sui-input">														
					
							<input type='date' id='supo_end_date_id' class="input_txt input_14 inputTxtFont sui-input">															
					
							<textarea id="etc_id" name="contents" class="input_txt_02 input_15 inputTxtFont"></textarea>													
					
					
						  <input type="password" placeholder="등록 비밀번호 입력." id="editPw" required class="reg_pass inputTxtFont"> &nbsp;&nbsp;
						  <input type="button" id="edit_update_btn" name="OK" class="miBtt_submit_top miBtt_submit " value="등록">
					
		</div>
	</div>
</div>

</body>
</html>


