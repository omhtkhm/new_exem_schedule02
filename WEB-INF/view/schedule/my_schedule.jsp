<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.min.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" /> 
<link rel="stylesheet" type="text/css" href="./resources/css/fullcalendar.css" media="all" />
<link rel="stylesheet" type="text/css" href="./resources/css/schedule/my_schedule.css" media="all" ></link>
<link rel="stylesheet" type="text/css" href="./resources/css/jquery/jquery.datetimepicker.min.css">

<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.datetimepicker.full.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/moment.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/fullcalendar.min.js"></script>

<!-- DWR setting -->
<script type="text/javascript" src="dwr/engine.js"></script>
<script type="text/javascript" src="dwr/util.js"></script>
<!-- <script type="text/javascript" src="dwr/interface/IMypageService.js"></script> -->
<script type="text/javascript" src="dwr/interface/IScheduleService.js"></script>
<script type="text/javascript" src="dwr/interface/ICustomerService.js"></script>

<!-- TOAST UI GRID  -->
<!-- <script src="./resources/script/node_modules/jquery/dist/jquery.js"></script> -->
<script src="./resources/script/node_modules/underscore/underscore.js"></script>
<script src="./resources/script/node_modules/backbone/backbone.js"></script>
<script src="./resources/script/node_modules/tui-code-snippet/dist/tui-code-snippet.js"></script>
<script src="./resources/script/node_modules/tui-pagination/dist/tui-pagination.js"></script>
<script src="./resources/script/node_modules/tui-date-picker/dist/tui-date-picker.js"></script>
<script src="./resources/script/node_modules/tui-grid/dist/tui-grid.js"></script>
<link rel="stylesheet" type="text/css" href="./resources/script/node_modules/tui-grid/dist/tui-grid.css" />

<script>
var userId = "<%=(String)session.getAttribute("sUserId")%>";
var userDept = "<%=(String)session.getAttribute("sUserDept")%>";
var userDbms = "<%=(String)session.getAttribute("sUserDbms")%>";

var year = "${year}";
var from_day = "${from_day}";
var to_day = "${to_day}";

var currentPjtId;
//console.log(year);
//console.log(from_day);
//console.log(to_day);

var temp = [];
$(document).ready(function(){
	// dateTimePicker 한글화
	$.datetimepicker.setLocale('ko');
	
	// dateTimePicker moment.js와 연동. 시간 단위로 선택하도록 설정하는 작업
	$.datetimepicker.setDateFormatter({
	    parseDate: function (date, format) {
	        var d = moment(date, format);
	        return d.isValid() ? d.toDate() : false;
	    },
	 
	    formatDate: function (date, format) {
	        return moment(date).format(format);
	    }
	})
	
    // datetimepicker 선택시 팝업창 표시
    $('.datetimepicker').datetimepicker({
          format:'YYYY-MM-DD HH:mm',
          formatTime:'HH:mm',
          formatDate:'YYYY-MM-DD'
    });
	
	$('textarea[name=contents]').bind('mouseenter', function() {
		$(this).addClass('enlarged_textarea');
	})
	
	$('textarea[name=contents]').bind('mouseout', function() {
		$(this).removeClass('enlarged_textarea');
	})
	
	$("#sch_insert").bind("click", function(){	
	   	location.href = "schedule_insert";
	});
	
	$("#my_sch").bind("click", function(){	
	   	location.href = "my_schedule";
	});
	
	$("#team_sch").bind("click", function(){	
	   	location.href = "team_schedule";
	});
	
	/* 체크박스 이벤트 */
	$("#checkall").click(function(){
        //클릭되었으면
        if($("#checkall").prop("checked")){
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 true로 정의
            $("input[name=chk]").prop("checked",true);
            //클릭이 안되있으면
        }else{
            //input태그의 name이 chk인 태그들을 찾아서 checked옵션을 false로 정의
            $("input[name=chk]").prop("checked",false);
        }
    });
	
	// 수정버튼 클릭 시
	$("#edit_update_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("수정할 행을 선택하세요.");
		} else{
			
	   	    $('#checkbox_id:checked').each(function() {   	    
   	    	    var chkId = $(this).val();

   	    	 	var user_id = userId;    // 세션에서 가져와야 함
   	    	 	//var startDay = $("#startDay_"+chkId).val();
   	    	    var cusId = $("#cusNm_"+chkId+" option:selected").val();
   	         	var pjtId = $("#pjtNm_"+chkId+" option:selected").val();
   	         	var startTime = $("#startTime_"+chkId).val();
   	         	var endTime = $("#endTime_"+chkId).val();
   	         	var dbmsId = $("#dbmsId_"+chkId+" option:selected").val();
   	         	var cateId = $("#cateId_"+chkId+" option:selected").val();
   	         	var contents = $("#contents_"+chkId).val();
   	         	
   	         	//console.debug( " | " + cusId + " | " + pjtId + " | " +startTime + " | " + endTime + " | " + dbmsId + " | " + cateId + " | " +contents + " | " + chkId );
   	         	
   	         	IScheduleService.updateSchinfo(
  					user_id, 
  					cusId,
  					pjtId,
					dbmsId, 
					cateId, 
					startTime,
					endTime,
					contents,
					chkId,
					updateSchinfoCallBack
				)
	   	    });	
		}
	});
	
	$("#edit_delete_btn").bind("click", function(){	
		if ( $('#form1 input[type=checkbox]:checked').length == 0  ) {
			alert("삭제할 행을 선택하세요.");
		} else{
			if (confirm("정말 삭제하시겠습니까??") == true){    //확인
				
		   	    $('#checkbox_id:checked').each(function() {   	    
	   	    	    var chkId = $(this).val();

	   	         	IScheduleService.deleteSchinfo(
	  					chkId,
						deleteSchinfoCallBack
					)
		   	    });
			
			}else{   //취소
			    return;
			}

		}
	});
	
	$('#week-label-year').val(year);	
	$('#week-label-from-day').val(from_day);	
	$('#week-label-to-day').val(to_day);	
	
	// 이전주, 다음주 클릭시 이벤트 처리
	$("#prevWeek").bind("click", function(){	
		// 현재 셋팅된 날짜를 가지고 와서, 이값을 입력하면 이전주의 시작일과 종료일을 리턴한다.
		
		//var yyyy = $('#week-label-year').text();
		var yyyy = $('#week-label-year').val();
		var mmdd = $('#week-label-from-day').val();
		//var mm = mm-dd.substring(0,2);
		//var dd = mm-dd.substring(3,5);
		var selectedDay = yyyy + '-' + mmdd;  // yyyy-mm-dd로 입력
	
		var cal_yyyymmdd_yyyymmdd = calWeek(selectedDay,'prev'); // yyyy-mm-ddyyyy-mm-dd 이렇게 계산한다.
		
		yyyy = cal_yyyymmdd_yyyymmdd.substring(0,4);
		mmdd = cal_yyyymmdd_yyyymmdd.substring(5,10);
		mmdd2 =  cal_yyyymmdd_yyyymmdd.substring(15,20);
		
		//$('#week-label-year').text(yyyy);
		$('#week-label-year').val(yyyy);
		$('#week-label-from-day').val(mmdd);
		$('#week-label-to-day').val(mmdd2);
		
		$("#form1").submit();
	});
	
	$("#nextWeek").bind("click", function(){	
		// 현재 셋팅된 날짜를 가지고 와서, 이값을 입력하면 다음주의 시작일과 종료일을 리턴한다.
		
		//var yyyy = $('#week-label-year').text();
		var yyyy = $('#week-label-year').val();
		var mmdd = $('#week-label-from-day').val();
		//var mm = mm-dd.substring(0,2);
		//var dd = mm-dd.substring(3,5);
		var selectedDay = yyyy + '-' + mmdd;  // yyyy-mm-dd로 입력
	
		var cal_yyyymmdd_yyyymmdd = calWeek(selectedDay,'next'); // yyyy-mm-ddyyyy-mm-dd 이렇게 계산한다.
		
		yyyy = cal_yyyymmdd_yyyymmdd.substring(0,4);
		mmdd = cal_yyyymmdd_yyyymmdd.substring(5,10);
		mmdd2 =  cal_yyyymmdd_yyyymmdd.substring(15,20);
		
		//$('#week-label-year').text(yyyy);
		$('#week-label-year').val(yyyy);
		$('#week-label-from-day').val(mmdd);
		$('#week-label-to-day').val(mmdd2);
		
		$("#form1").submit();
	});
	
	/*페이지 처리(이전 버튼 이벤트 )*/
    $("#backVal").live("click", function(){
    	$("#nowPage").val($("#nowPage").val() - 1);    	
    	$("#form1").submit();	
    	
    });
    
    /*페이지 처리(다음 버튼 이벤트 )*/
    $("#nextVal").live("click", function(){
    	$("#nowPage").val($("#nowPage").val()*1 + 1);
    	$("#form1").submit();	
    });

    /*페이지 처리(페이지 숫자 버튼 이벤트 )*/
    $("a[name='moreArea']").live("click", function(){
    	$("#nowPage").val($(this).attr("id"));
    	$("#form1").submit();	
    });
    
    // 고객사 선택시 프로젝트목록 자동 변경 처리
    $('select[name=select_cust]').change(function(){
    	var cusId = $(this).val();
    	console.log("cusId: " + cusId)
    	// 현재 Id로 부터 선택된 행을 알아내어, 프로젝트 선택박스ID 찾는데 사용
    	var currentCusId = $(this).attr('id'); 
    	var temps = currentCusId.split('_');
    	currentPjtId = 'pjtNm_' + temps[1];
    	console.log("currentPjtId: " + currentPjtId)
    	
    	// cusId를 입력하여 해당 프로젝트 목록 정보를 가져오는 서비스 호출
    	ICustomerService.getProinfo2(cusId, getProinfoCallBack);
    });
    
    // 프로젝트명 선택박스 선택시 프로젝트목록 자동 변경 처리
    $('select[name=select_pjt]').click(function(){
    	//$(this).html('');
    	var pjtId = $(this).val();
    	//console.log("pjtId: " + pjtId)
    	// 현재 Id로 부터 선택된 행을 알아내어, 프로젝트 선택박스ID 찾는데 사용
    	currentPjtId = $(this).attr('id'); 
    	var temps = currentPjtId.split('_');
    	var currentCusId = 'cusNm_' + temps[1];
    	//console.log("currentCusId: " + currentPjtId)
    	var cusId = $('#'+currentCusId).val();
    	
    	// cusId를 입력하여 해당 프로젝트 목록 정보를 가져오는 서비스 호출
    	ICustomerService.getProinfo2(cusId, getProinfoCallBack);
    });
    
});
			
// 이전주와 다음주 계산하는 함수
function calWeek(yyyymmdd, isPrev ){
	console.log(yyyymmdd);
	// yyyymmdd에는 yyyy-mm-dd 형태로 값이 들어옴
	var selectedDay = new Date(yyyymmdd);  // 금주 월요일  
	console.log(selectedDay);
	
	var resultDay = new Date(selectedDay);
	var thisMonday;
	var thistoSunday;
	
	if ( isPrev == 'prev')
		resultDay.setDate( resultDay.getDate() - 7 );  // 전주 월요일
	else
		resultDay.setDate( resultDay.getDate() + 7 );  // 다음주 월요일
	
	console.log(resultDay);
	
	var yyyy = resultDay.getFullYear();
	var mm = Number(resultDay.getMonth()) + 1;
	var dd = resultDay.getDate();
	
	mm = String(mm).length === 1 ? '0' + mm : mm;
	dd = String(dd).length === 1 ? '0' + dd : dd;
	
	thisMonday = yyyy + '-' + mm + '-' + dd;
	////////
	var resultDay2 = new Date(resultDay);
	resultDay2.setDate( resultDay2.getDate() +6 ) ; // 주일 계산
	
	var mm2 = Number(resultDay2.getMonth()) + 1;
	var dd2 = resultDay2.getDate();
	
	var yyyy2 = resultDay2.getFullYear();
	mm2 = String(mm2).length === 1 ? '0' + mm2 : mm2;
	dd2 = String(dd2).length === 1 ? '0' + dd2 : dd2;
	
	thistoSunday = yyyy2 + '-' + mm2 + '-' + dd2;
	
	console.log(thisMonday+thistoSunday);
	return thisMonday+thistoSunday;  // 결과값은 yyyy-mm-ddyyyy-mm-dd 형태임
}

function updateSchinfoCallBack(res){
	if(res == "FAILED"){
		//alert("실패");
		location.href = "my_schedule";
	}else if(res == "SUCCESS"){
		//alert("성공");
		location.href = "my_schedule";
	}
}

function deleteSchinfoCallBack(res){
	if(res == "FAILED"){
		//alert("실패");
		location.href = "my_schedule";
	}else if(res == "SUCCESS"){
		//alert("성공");
		location.href = "my_schedule";
	}
}

function getProinfoCallBack(arrayList){
	$("#"+currentPjtId).html("");  // 프로젝트 리스트 초기화
	if(arrayList.length > 0) { // arrayList에 프로젝트목록이 들어온다. customer_project_id 셀렉트박스목록을 갱신한다.
		for(var i=0; i<arrayList.length; i++)
		{
		    var testObj = arrayList[i];
		    console.log("testObj.proNm: " + testObj.proNm);
		    $('#'+currentPjtId).append('<option value='+testObj.proId+'>'+testObj.proNm+'</option>');
		}
	} else {
		alert("선택한 고객사에 등록된 프로젝트가 없습니다.");
	}
}

</script>

</head>

<body>
<c:import url="/main_upview"></c:import>
		<div class="top_SubMenuPart">
			<div class="top_MenuBase">
				<a href="#" class="top_SubMenu01" id="sch_insert">일정등록</a>
				<a href="#" class="top_SubMenu02" id="my_sch">내 일정보기</a>
				<a href="#" class="top_SubMenu03" id="team_sch">팀 일정보기</a>
			</div>
		</div>
		
<div class="row"> <!-- dummy -->

	<form id="form1" method="post" action="my_schedule_next">	
	     <!-- 아래는 hidden 2개는 사실상 필요없음. javascript처리와 java에서 함께 삭제해야함 -->
		 <input type="hidden" id="cus_select4" name="selectBtnVal" value="0">
		 <input type="hidden" id="select_text" name="selectTextVal" value="검색 조건을 선택하세요.">
		 
		 <!-- div class="column middle"-->
		 <div class="top_mainDisplayPart">
		 	<div align="center"><h3>내 일정 정보</h3></div>
		 	
			<input type="hidden" id="nowPage" name="pageNo" value="${nowPage}">
			<input type="hidden" id="userId_hidden_id" value="">				
		 		 	
		 	<table>
			 	<tr>
				 	<td>
				 		<div>
				 			<a href="#" class="main_title_box_2 nTitleFont" id="prevWeek">&laquo; 이전주</a>
				 		</div>
				 	</td>
				 	<td>	 		
				 	    <div class="nTitleFont">
						  <div style='display:inline;'>&nbsp;&nbsp;&nbsp;</div>
						  <!-- div id="week-label-year" style='display:inline;'></div-->
						  <input type="text" id="week-label-year" name="week-label-year" class="titleFont_2">
						  <div style='display:inline;'>년</div>
						  <!-- div id="week-label-from-day" style='display:inline;'>01-01</div-->
						  <input type="text" id="week-label-from-day" name="week-label-from-day" class="titleFont_2">
						  <div style='display:inline;'>(월) &nbsp; ~ </div>
						  <!-- div id="week-label-to-day" style='display:inline;'>02-05</div-->
						  <input type="text" id="week-label-to-day" name="week-label-to-day" class="titleFont_2">
						  <div style='display:inline;'>(일)</div>
						  <div style='display:inline;'>&nbsp;&nbsp;&nbsp;</div>
						</div>
				 	</td>
					 <td>	 		
					 	<div>			 		
					 	    <a href="#" class="main_title_box_2 nTitleFont" id="nextWeek">다음주 &raquo;</a>
						</div>
				 	</td>
				 </tr>
			</table>
			
			<div id="grid"></div>

			<div id="schedule_list">		
		 		<table id="sch_list">	
					<thead id="sch_list_th">
						<tr>
							<td>
								<ul>
								<li class="main_title_box_2 box_01 nCheckBox">
									<input type="checkbox" id="checkall"/>
								</li>
								</ul>
							</td>
							<td><input type="text" class="main_title_box_2 box_02 nTitleFont" value="지원일자"> </td>
							<td><input type="text" class="main_title_box_2 box_03 nTitleFont" value="고객사명"> </td>
							<td><input type="text" class="main_title_box_2 box_04 nTitleFont" value="프로젝트명"> </td>
							<td><input type="text" class="main_title_box_2 box_05 nTitleFont" value="지원시작일"> </td>
							<td><input type="text" class="main_title_box_2 box_06 nTitleFont" value="지원종료일"> </td>
							<td><input type="text" class="main_title_box_2 box_07 nTitleFont" value="제품구분"> </td>
							<td><input type="text" class="main_title_box_2 box_08 nTitleFont" value="지원유형(범주)"> </td>
							<td><input type="text" class="main_title_box_2 box_09 nTitleFont" value="요청내역 및 지원목적"> </td>
						</tr>					
					</thead>
					<tbody id="sch_list_tb">
						<c:forEach var="sch" items="${sch_list}">											
							<tr>
								<td>
									<ul>
									<li class="main_title_box_2 box_01 nCheckBox">
										<input type="checkbox" name="chk" value="${sch.schId}" id="checkbox_id">
									</li>
									</ul>
								</td>
								<td>
									<input type="text" class="main_input_box_2 box_02 nInputFont" value="${sch.start_day}" id="startDay_${sch.schId}">	
								</td>						
								<td>
									<!-- input type="text" class="main_input_box_2 box_03 nInputFont" value="${sch.schCusNm}" id="cusNm_${sch.schId}"-->
									<select class="main_input_box_2 box_03 nInputFont" id="cusNm_${sch.schId}" name="select_cust">
										<c:if test="${sch.schCusNm == '' || sch.schCusNm eq null}">
											<option value="0" selected></option>
										</c:if>
										<c:forEach var="cus" items="${cus_list}">
											<c:choose>
												<c:when test="${cus.cusId  == sch.schCusId}">
													<option value="${cus.cusId}" selected>${cus.cusNm}</option>
												</c:when>
												<c:otherwise>
													<option value="${cus.cusId}">${cus.cusNm}</option>	
												</c:otherwise>
											</c:choose>
										</c:forEach>			
									</select>	
								</td>
								<td>
									<!-- input type="text" class="main_input_box_2 box_04 nInputFont" value="${sch.schPjtNm}" id="pjtNm_${sch.schId}"-->
									<select class="main_input_box_2 box_04 nInputFont" id="pjtNm_${sch.schId}" name="select_pjt">
										<c:if test="${sch.schPjtNm == '' || sch.schPjtNm eq null}">
											<option value="0" selected></option>
										</c:if>
										<c:forEach var="pjt" items="${pjt_list}">
											<!-- script>console.log( 'pjt.cusId: ' + <c:out value="${pjt.cusId}"></c:out> );</script-->
												<c:choose>
													<c:when test="${pjt.pjtId  == sch.schPjtId}">
														<option value="${pjt.pjtId}" selected>${pjt.pjtNm}</option>
													</c:when>
													<%-- c:otherwise>
														<option value="${pjt.pjtId}">${pjt.pjtNm}</option>	
													</c:otherwise --%>
												</c:choose>
										</c:forEach>			
									</select>
								</td>							
								<td>
									<input type="text" class="main_input_box_2 box_05 nInputFont datetimepicker" value="${fn:substring(sch.start_time,0,16)}" id="startTime_${sch.schId}">
									<!-- input type="hidden" value="${fn:substring(sch.start_time,0,16)}" id="h_startTime_${sch.schId}"-->
								</td>
								<td>
									<input type="text" class="main_input_box_2 box_06 nInputFont datetimepicker" value="${fn:substring(sch.end_time,0,16)}" id="endTime_${sch.schId}">
									<!-- input type="hidden" value="${fn:substring(sch.end_time,0,16)}" id="h_endTime_${sch.schId}"-->
								</td>
								<td>
									<!-- input type="text" class="main_input_box_2 box_07 nInputFont" value="${sch.dbms_id}" id="dbms_${sch.schId}"-->
									<select class="main_input_box_2 box_07 nInputFont" id="dbmsId_${sch.schId}">
										<c:if test="${sch.dbms_id == ''}">
											<option value="0" selected>지정필요.</option>
										</c:if>
										<c:forEach var="dbms" items="${dbms_list}">
													<c:choose>
														<c:when test="${dbms.dbmsId  == sch.dbms_id}">
															<option value="${dbms.dbmsId}" selected>${dbms.dbmsNm}</option>
														</c:when>
														<c:otherwise>
															<option value="${dbms.dbmsId}">${dbms.dbmsNm}</option>	
														</c:otherwise>
													</c:choose>
										</c:forEach>			
									</select>
								</td>
								<td>
									<select class="main_input_box_2 box_08 nInputFont" id="cateId_${sch.schId}">
										<c:if test="${sch.category_id == 0}">
											<option value="0" selected></option>
										</c:if>
										<c:forEach var="cat" items="${cat_list}">
													<c:choose>
														<c:when test="${cat.catId  == sch.category_id}">
															<option value="${cat.catId}" selected>${cat.catNm}</option>
														</c:when>
														<c:otherwise>
															<option value="${cat.catId}">${cat.catNm}</option>	
														</c:otherwise>
													</c:choose>
										</c:forEach>			
									</select>
								</td>
								<td>
									<!-- input type="text" class="main_input_box_2 box_09 nInputFont" name="contents" value="${sch.contents}" id="contents_${sch.schId}"-->
									<textarea class="main_input_box_2 box_09 nInputFont" name="contents" id="contents_${sch.schId}">${sch.contents}</textarea>
								</td>			
							</tr>					
						</c:forEach>										
					</tbody>
					
					<tfoot id="sch_list_tf"> 
						<tr>
							<td colspan="9" class="center_align">
								<div>
									<c:if test="${nowPage > 1}">
											<a href="#" id="backVal" class="nTitleFont">이전</a>
										</c:if>
										<c:forEach var="i" begin="${startPage}" end="${endPage}" step="1">
											<c:choose>
												<c:when test="${nowPage==i}">
													<a id="${i}" name="moreArea" class="pageFont">${i}</a>
												</c:when>
												<c:otherwise>
													<a href="#" id="${i}" name="moreArea" class="pageFont">${i}</a>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										<c:if test="${maxPage > nowPage}">
											<a href="#" id="nextVal" class="nTitleFont">다음</a>
										</c:if>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="9" class="center_align">
								<div>
							  		<input type="button" id="edit_update_btn" value="수정" class="inBtt_OK_2">
							  		<input type="button" id="edit_delete_btn" value="삭제" class="inBtt_OK_2">
							  	</div>
							</td>
						</tr>				
					</tfoot>
		 		</table>
			</div>  <!-- table end -->
		</div>
	</form>	
</div>  <!--  dummy  -->



<script type="text/javascript">

	const options = {
	  el: document.getElementById('grid'),
	  columns: [
		{
		  title: 'Name',
		  name: 'name'
		},
		{
		  title: 'Artist',
		  name: 'artist'
		},
		{
		  title: 'Release',
		  name: 'release'
		},
		{
		  title: 'Genre',
		  name: 'genre'
		}
	  ],
	  data: [
		{
		  name: 'Beautiful Lies',
		  artist: 'Birdy',
		  release: '2016.03.26',
		  genre: 'Pop'
		}
	  ]
	};

	const grid = new tui.Grid(options);

  </script>
</body>
</html>

