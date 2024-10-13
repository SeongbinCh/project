<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="${contextPath }/resources/js/daumPost.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script type="text/javascript">
	function enterkey() {
	    if (window.event.keyCode == 13) {
	         document.getElementById("searchForm").submit();
	    }
	}
	const loginMsg = "${ loginMsg }";
	if( loginMsg ){
		alert( loginMsg );
	}
	const logoutMsg = "${ logoutMsg }";
	if( logoutMsg ){
		alert( logoutMsg );
	}
</script>
<style type="text/css">
	body {
            overflow-y: auto;
            height: 100vh;
        }
	.header {		
		display: flex; 
		justify-content:space-between;
		margin: 20px 0;
		padding: 0 50px;
		border-bottom: 1px solid #000000;
	}
	ul {
		list-style: none;
	}
	a {
		text-decoration: none;
		color: black;
	}
	.headerUl {
		float: right;
		display: inline-flex;
		gap: 20px;
	}
	.header h2 {
		margin-bottom: 20px;
	}
	button {
		margin-top: 5px;
	}
	button[type="button"],
	button[type="submit"] {
		border: 1px solid #6c757d;
		color: #6c757d;
		background-color: transparent;
		border-radius: 0.25rem;
	}
	button[type="button"]:hover,
	button[type="button"]:hover {
		background-color: #6c757d;
		color: white;
	}
</style>
</head>
<body>
	<div class="header">
		<h2><a href="/project/member/main">게시판</a></h2>
		
		<nav class="headerNav">
			<ul class="headerUl">
				<c:if test="${ not empty sessionScope.login }">
					<li><a href="${ contextPath }/mypage">내 정보</a>
					<li><a href="${ contextPath }/member/logout">로그아웃</a></li>
				</c:if>
				<c:if test="${ empty sessionScope.login }">
					<li><a href="${ contextPath }/member/login">로그인</a></li>
					<li><a href="${ contextPath }/member/membership">회원가입</a></li>
				</c:if>
			</ul>
		</nav>
	</div>
	<br>
</body>
</html>