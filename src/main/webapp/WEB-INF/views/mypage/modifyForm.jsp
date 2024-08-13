<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.box1{
		position: absolute;
		border: 1px solid black;
		border-radius: 1cm;
		height: 550px;	width: 650px;
		top: 15%;	left: 35%;
	}
	.form-group {
		margin-top: 30px;
        margin-bottom: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
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
        gap: 10px;
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
        margin-left: 30px; 
        cursor: pointer;
	}
</style>
</head>
<body>
	<%@ include file="mypage.jsp" %>
	
	<div class="box1">
		<form action="modify" method="post">
			<div class="form-group">
				<label for="id" class="form-label">아이디</label>
				<input type="text" name="id" class="form-control" style="width: 300px;" value="${ content.id }" required="required" readonly>
			</div>
			<div class="form-group">
				<label for="pwd" class="form-label">비밀번호</label>
				<input type="text" name="pwd" class="form-control" style="width: 300px;" value="${ content.pwd }" required="required">
			</div>
			<div class="form-group">
				<label for="email" class="form-label">이메일</label>
				<input type="text" name="email" class="form-control" style="width: 300px;" value="${ content.email }" required="required">
			</div>
			
			<div class="form-group">
				<label for="addr" class="form-label">주소</label>
				<div class="form-group">
					<input type="text" id="addr1" name="addr1" class="form-control" style="width: 150px;" value="${ content.addr1 }" placeholder="우편번호" required="required" readonly="readonly">
					<button type="button" class="postBtn" onclick="daumPost()">우편번호 찾기</button>
				</div>
			</div>
			<div class="form-group">
				<label class="form-label"></label>
				<input type="text" id="addr2" name="addr2" class="form-control" style="width: 300px;" value="${ content.addr2 }" placeholder="상세정보1" required="required" readonly="readonly">
			</div>
			<div class="form-group">
				<label class="form-label"></label>
				<input type="text" id="addr3" name="addr3" class="form-control" style="width: 300px;" value="${ content.addr3 }" placeholder="상세정보2" required="required">
			</div>
			<div class="form-group form-submit-group">
				<button type="submit" class="form-submit">수정</button>
			</div>
		</form>
	</div>
</body>
</html>