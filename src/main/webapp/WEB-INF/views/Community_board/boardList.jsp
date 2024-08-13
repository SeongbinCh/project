<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<style type="text/css">
    .container {
		width: 80%;
		margin: 75px auto 0 auto;
	}
	table {
	  width: 80%;
	  margin-bottom: 1rem;
	  vertical-align: middle;
	  border-color: #dee2e6;
	  text-align: center;
	}
	
	.col-1 { width: 8%; }
	.col-2 { width: 10%; }
	.col-3 { width: 30%; }
	.col-4 { width: 8%; }
	.col-5 { width: 15%; }
	
	.pagination-wrapper {
		display: flex;
		justify-content: center;
	}
</style>
</head>
<body>
    <%@ include file="../default/header.jsp" %>
    
    <div class="container">
        <table class="table">
            <colgroup>
                <col class="col-1">
                <col class="col-2">
                <col class="col-3">
                <col class="col-4">
                <col class="col-5">
            </colgroup>
            <thead>
                <tr>
                    <th>글 번호</th>
                    <th>작성자</th>
                    <th>제목</th>
                    <th>조회수</th>
                    <th>날짜</th>
                </tr>
            </thead>
            <tbody class="table-group-divider">
                <c:if test="${ empty list }">
                    <tr>
                        <th colspan="5">작성된 글이 없습니다</th>
                    </tr>
                </c:if>
                <c:forEach var="dto" items="${ list }">
                    <tr>
                        <td>${ dto.write_no }</td>
                        <td>${ dto.id }</td>
                        <td>
                            <a href="contentView?write_no=${ dto.write_no }">
                                ${ dto.title }
                            </a>
                        </td>
                        <td>${ dto.hit }</td>
                        <td>${ dto.saveDate }</td>
                    </tr>
                </c:forEach>
                <tr>
                    <td>
                        <a href="writeForm">글 작성</a>
                    </td>
                    <td colspan="4">
                        <div class="pagination-wrapper">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination">
                                    <!-- 이전 페이지 버튼 -->
                                    <c:choose>
                                        <c:when test="${currentPage > 1}">
                                            <li class="page-item">
                                                <a class="page-link" href="boardList?num=${currentPage - 1}" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item disabled">
                                                <span class="page-link" aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </span>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- 페이지 번호 버튼 -->
                                    <c:forEach var="i" begin="1" end="${ repeat }">
                                        <li class="page-item ${i == currentPage ? 'active' : ''}">
                                            <a class="page-link" href="boardList?num=${ i }">${ i }</a>
                                        </li>
                                    </c:forEach>

                                    <!-- 다음 페이지 버튼 -->
                                    <c:choose>
                                        <c:when test="${currentPage < repeat}">
                                            <li class="page-item">
                                                <a class="page-link" href="boardList?num=${currentPage + 1}" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </c:when>
                                        <c:otherwise>
                                            <li class="page-item disabled">
                                                <span class="page-link" aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </span>
                                            </li>
                                        </c:otherwise>
                                    </c:choose>
                                </ul>
                            </nav>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
