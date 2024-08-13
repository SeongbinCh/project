<%@page import="java.math.BigInteger"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.security.SecureRandom"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<style type="text/css">
    .box1 {
        border:1px solid black;
        border-radius: 0.5em;
        width: 550px; height: 450px;
        margin: 0 auto; padding: 0px;
        margin-top: 100px;
    }
    .loginForm {
        text-align: center;
        line-height: 30pt;
        margin-top: 130px;
    }
    .formClass {
        position: absolute;
        top: 30%; right: 30%;
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
        margin-right: 0px;
        font-weight: bold;
        color: #333;
    }
    .form-input {
        width: 200px;
        height: 30px;
        margin-right: 0px;
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
        margin-top: 15px;
    }
    .form-submit:hover {
        background-color: #6c757d;
		color: white;
    }
</style>
<script type="text/javascript">
    window.onload = function(){
        var loginError = "${loginError}";
        if(loginError) {
            alert(loginError);
        }
    }
</script>
</head>
<body>
    <%@ include file="../default/header.jsp" %>

    <div class="box1">
        <div class="loginForm">
            <form action="login_chk" method="post" class="formclass">
                <div class="form-group">
                    <label for="id" class="form-label">아이디</label>
                    <input type="text" name="id" class="form-control" style="width: 250px;" placeholder="ID">
                </div>
                <div class="form-group">
                    <label for="pwd" class="form-label">비밀번호</label>
                    <input type="password" name="pwd" class="form-control" style="width: 250px;" placeholder="Password">
                </div>
                <div class="form-group form-submit-group">
                    <button type="submit" class="form-submit">로그인</button>
                    <button type="button" onclick="history.back()" class="form-submit">취소</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>