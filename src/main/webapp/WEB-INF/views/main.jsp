<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script type="text/javascript">
	var naver_id_login = new naver_id_login("fCdwoV6CXprVdA34988p", "http://localhost:8080/project/member/main");
	// 네이버 사용자 프로필 조회
	naver_id_login.get_naver_userprofile("naverSignInCallback()");
	// 네이버 사용자 프로필 조회 이후 프로필 정보를 처리할 callback function
	function naverSignInCallback() {
		alert(naver_id_login.getProfileData('email'));
		alert(naver_id_login.getProfileData('nickname'));
		alert(naver_id_login.getProfileData('age'));
	}
</script>

<style type="text/css">
    .tag{
        position: absolute;
        border: 1px solid black;
        border-radius: 0.5em;
        text-align: center;
        height: 70px; width: 250px;
        top: 35%; right: 43%;
    }
    .tag:hover{
        background-color: gray;
    }
</style>
</head>
<body>
    <%@ include file="default/header.jsp" %>

    <div class="tag">
        <a href="/project/community/boardList"><br>커뮤니티 게시판</a>
    </div>
</body>
</html>
