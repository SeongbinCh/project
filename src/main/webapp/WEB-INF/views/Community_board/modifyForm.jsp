<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    .tb-class {
        position: absolute;
        border: 1px solid black;
        border-collapse: collapse;
        top: 12%;	left: 35%;
        width: 600px;	height: 655px;
    }
    .form-group {
        margin-bottom: 15px;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .form-label {
        display: inline-block;
        width: 150px; /* 라벨의 너비 조정 */
        text-align: left;
        margin-right: 10px; /* 라벨과 입력 필드 사이의 간격 */
        font-weight: bold; /* 라벨의 텍스트 굵게 */
        color: #333; /* 라벨 텍스트 색상 */
    }
    .form-submit-group {
        display: flex;
        justify-content: center;
        gap: 10px; /* 버튼 사이의 간격 */
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
	
	<table class="tb-class">
		<tr>
			<td>
				<form action="modify" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="write_no" class="form-label">글 번호</label>
						<input type="text" name="write_no" class="form-control" style="width: 300px;" value="${ content.write_no }" readonly>
					</div>
					<div class="form-group">
						<label for="id" class="form-label">아이디</label>
						<input type="text" name="id" class="form-control" style="width: 300px;" value="${ content.id }" readonly>
					</div>
					<div class="form-group">
						<label for="title" class="form-label">제목</label>
						<input type="text" name="title" class="form-control" style="width: 300px;" value="${ content.title }">
					</div>
					<div class="form-group">
						<label for="content" class="form-label">내용</label>
						<textarea name="content" class="form-control" aria-label="With textarea" style="height: 100px;width: 300px;">${ content.content }</textarea>
					</div>
					<div class="form-group">
						<input type="hidden" name="imageFileName" value="${ content.imageFileName }">
						<img alt="이미지 없음" id="preview" width="100" height="100" src="download?name=${ content.imageFileName }">
					</div>
					<div class="form-group">
						<input type="file" name="file" onchange="readURL(this)">
					</div>
					<div class="form-group form-submit-group">
						<button type="submit" class="form-submit">수정</button>
						<button type="button" class="form-submit" onclick="history.back()">이전</button>
					</div>		
				</form>
			</td>
		</tr>
	</table>
</body>
</html>