<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.box{ 
		position: absolute;
		border: 1px solid black;
		border-radius: 0.5em;
		height: 150px;	width: 200px;
		top: 15%;	left: 2%;
		text-align: center;
		
		font-size: 18pt;
	}
	.mypage-form{
		display: flex;
		width: 100%; height: 50px;
		justify-content: center;
		align-items: center; 
		margin-top: 15px;	
	}
	.mypage-form:hover {
		background-color: #D8D8D8;
	}
</style>
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	
	<div class="box">
		<div class="mypage-form">
			<a href="/project/mypage/modifyForm?id=${ content.id }">개인정보수정</a>
		</div>
	</div>
</body>
</html>