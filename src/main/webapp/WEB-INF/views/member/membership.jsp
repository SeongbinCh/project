<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.box1 {
		width: 600px;
		height: 600px;
        margin: 0 auto;
        padding: 0px;
		border:1px solid black;
		border-radius: 0.5em;
	}
	.loginForm {
		text-align: center;
        line-height: 30pt;
        margin-top: 65px;
	}
	.form-group {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 20px;
    }
    .form-label {
        display: inline-block;
        width: 150px;
        text-align: left;
        margin-right: 5px;
        font-weight: bold;
        color: #333; 
    }
    .form-submit-group {
        display: flex;
        justify-content: center;
        gap: 15px;
        margin-top: 35px;
    }
    .form-submit{
   		border: 1px solid black;
    	border-radius: 0.5em;
    	width: 120px;
    	height: 50px;
    	background: white;
    }
    .form-submit:hover {
		background-color: gray;
		cursor: pointer;
	}
	.postBtn {
		height: 30px;
		line-height: 30px;
        margin-left: 30px;
        cursor: pointer;
	}
</style>
</head>
<body>
	<%@ include file="../default/header.jsp" %>
	
	<div class="box1">
		<div class="loginForm">
			<form action="register" method="post">
				<div class="form-group">
					<label for="name" class="form-label">이름</label> 
					<input type="text" name="name" class="form-control" style="width: 300px;" placeholder="이름" required="required">
				</div>
				<div class="form-group">
					<label for="id" class="form-label">아이디</label> 
					<input type="text" name="id" class="form-control" style="width: 300px;" placeholder="아이디" required="required">
				</div>
				<div class="form-group">
					<label for="pwd" class="form-label">비밀번호</label>
					<input type="password" name="pwd" class="form-control" style="width: 300px;" placeholder="비밀번호" required="required">
				</div>
				<div class="form-group">
					<label for="eamil" class="form-label">이메일</label>
					<input type="text" name="email" class="form-control" style="width: 300px;" placeholder="E-mail" required="required">
				</div>
				<div class="form-group">
				<label for="addr" class="form-label">주소</label>
				<div class="form-group">
					<input type="text" id="addr1" name="addr1" class="form-control" style="width: 150px;" placeholder="우편번호" required="required" readonly="readonly">
					<button type="button" class="postBtn" onclick="daumPost()">우편번호 찾기</button>
				</div>
			</div>
			<div class="form-group">
				<label class="form-label"></label>
				<input type="text" id="addr2" name="addr2" class="form-control" style="width: 300px;" placeholder="상세정보1" required="required" readonly="readonly">
			</div>
			<div class="form-group">
				<label class="form-label"></label>
				<input type="text" id="addr3" name="addr3" class="form-control" style="width: 300px;" style="width: 100px;" placeholder="상세정보2" required="required">
			</div>
				<div class="form-group form-submit-group">
					<button type="submit" class="form-submit">완료</button>
					<button type="button" onclick="history.back()" class="form-submit">취소</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>