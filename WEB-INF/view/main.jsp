<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>EXEM</title> 
<link rel="stylesheet" type="text/css" media="screen" href="./resources/css/exem_mem.css"/>


<!-- jQuery Script -->
<script type="text/javascript" src="resources/script/jquery/jquery-1.8.2.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery-ui-1.8.min.js"></script>
<script type="text/javascript" src="resources/script/jquery/jquery.form.js"></script>

<script type="text/javascript">

$(document).ready(function(){
	//$("#scheduleBtn").bind("click", function(){
		location.href = "my_schedule";
	//});
});

</script>

<style>

</style>
</head>
<body>

<c:import url="/main_upview"></c:import>
<!-- 
<div class="row">
  <div class="column side">	
     <h2>Side</h2>    
     <a href="#">Link</a></br>
     <a href="#">Link</a></br>
     <a href="#">Link</a></br> 
  </div>
  <div class="column middle">
  	
  </div>
</div>

<c:import url="/main_botview"></c:import>
-->
</body>
</html>













