<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.box1 {
		width: 800px;
		height: 750px;
        margin: 0 auto;
        padding: 0px;
		border:1px solid black;
		border-radius: 0.5em;
	}
    .writeFromCs {
        text-align: center;
        line-height: 30pt;
        margin-top: 100px;
    }
    .form-group {
        margin-bottom: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .form-label {
        display: inline-block;
        width: 150px;
        text-align: left;
        margin-right: 10px;
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
		background-color: #6c757d;
		color: white;
	}
</style>
<script src="<%=request.getContextPath() %>/resources/js/img_view.js"></script>
</head>
<body>
    <%@ include file="../default/header.jsp" %>
    <div class="box1">
	    <div class="writeFromCs">
	        <form action="writeSave" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
	            <div class="form-group">
	                <label for="id" class="form-label">작성자 아이디</label>
	                <input type="text" id="id" name="id" class="form-control" style="width: 300px;" value="${ login }" readonly>
	            </div>
	            <div class="form-group">
	                <label for="title" class="form-label">제목</label>
	                <input type="text" id="title" name="title" class="form-control" style="width: 300px;" placeholder="제목">
	            </div>
	            <div class="form-group">
	                <label for="content" class="form-label">내용</label>
	                <textarea id="content" name="content" class="form-control" aria-label="With textarea" style="height: 125px; width: 300px;" placeholder="내용"></textarea>
	            </div>
	            <div class="form-group">
	                <label for="image_file_name" class="form-label">이미지</label>
	                <input type="file" id="image_file_name" name="image_file_name" onchange="readURL(this)">
	            </div>
	            <div class="form-group">
	                <img id="preview" width="100" height="100" alt="선택없음">
	            </div>
	            <div class="form-group form-submit-group">
	                <button type="submit" class="form-submit">등록</button>
	                <button type="button" class="form-submit" onclick="history.back()">취소</button>
	            </div>
	        </form>
	    </div>
	</div>
</body>
</html>
