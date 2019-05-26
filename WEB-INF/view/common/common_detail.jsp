<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<style type="text/css">
	#cus_name {
		width: 200px;
		height: 30px;
		text-align: center;
		font-size: 20pt;
		font-family: ���;
		
	}
	#div_detail {
		width:100%;
		height:100%;
		display: inline-block;
	}
	
	li {
		cursor: pointer;
	}
	
	li:link    { text-decoration:none }
	li:visited { text-decoration:none }
	li:hover   { text-decoration:underline }
	li:active  { text-decoration:none }
	
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$(".plan").click(function(){
			if($("#plan_down").css("display") == "none") {
				$("#plan_down").fadeIn("slow");
				$("#plan_down").css("display","inline-block");
			} else {
				$("#plan_down").fadeOut("slow");
				$("#plan_down").css("display","none");
			}
		});
		
		$(".pt").click(function(){
			if($("#pt_down").css("display") == "none") {
				$("#pt_down").fadeIn("slow");
				$("#pt_down").css("display","inline-block");
			} else {
				$("#pt_down").fadeOut("slow");
				$("#pt_down").css("display","none");
			}
		});
		
		$("#ptp").click(function(){
			if($("#prog").val()==0) {
				alert("�������� ���� �ۼ����ּ���.");
			} else if($("#prog").val()==1) {
				alert("����� ���� ��Ʈ�������� ���� �����ϼ���.");
			} else {
				document.getElementById("goPtP").submit();
			}
		});
		
		$("#fill_in").click(function(){
			if($("#prog").val()!=0) {
				alert("������ �̹� ������ �Ϸ��Ͽ����ϴ�.");
			} else {
				location.href='survey';
			}
		});
		$("#fill_in_result").click(function(){
			if($("#prog").val()==0) {
				alert("�������� ���� �ۼ����ּ���.");
			} else {
				location.href='result';
			}
		});
		$("#one_result").click(function(){
			if($("#prog").val()==0) {
				alert("�������� ���� �ۼ����ּ���.");
			} else {
				location.href='adviceResult';
			}
		});
	});
</script>
</head>
<body>
<form action="ppPage" method="post" id="goPtP">
<input type="hidden" name="progress" id="prog"/>
</form>
<br/>
<br/>
<div id="div_detail" > 
	<div align="center"> 
		<input type="text" id="cus_name" readonly="readonly" value="${nm}" onclick="location.href='progress'">
	</div>
	<br/>
	<ul>
		<li class="plan">�����繫����</li><br/>
			<ul id="plan_down" style="display: none; padding-left: 10px;">
			     <li id="fill_in">���������ۼ�</li><br/>
			     <li id="fill_in_result">����������</li><br/>
			     <li id="one_result">1�������</li><br/>
		     </ul>
		<li class="pt">��Ʈ������ ����</li><br/>
			<ul id="pt_down" style="display: none; padding-left: 10px;">
				     <li id="ptp">������Ʈ������</li><br/>
		     </ul>
	</ul>
</div>
</body>
</html>