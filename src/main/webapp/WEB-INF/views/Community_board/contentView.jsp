<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
    table {
    	position: absolute;
    	top: 10%; left: 35%;
        border-collapse: collapse;
        width: 600px;
    }
    .reply {
    	position: relative;
    	padding: 5px;
    	}
    .reply-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 5px;
    }
    .reply-id {
    	text-align: left;
    	font-weight: bold;
    }
    .reply-date {
    	text-align: right;
    	font-size: 10pt;
    }
    .reply-content-actions {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .reply-content {
        text-align: left;
        font-size: 11pt;
    	flex-grow: 1;
    	word-wrap: break-word;
        word-break: break-word;
        margin-right: 10px;
    }
    .reply-actions {
        margin-top: 0px;
        text-align: right;
        flex-shrink: 0;
    }
    .reply-actions button {
        height: 30px; /* 원하는 높이 값으로 설정 */
        line-height: 1; /* 높이 조정에 따른 텍스트 정렬 */
        margin-left: 5px;
    }
    .modify-form {
        display: none; /* Initially hide modify form */
    }
    .submit-btn-container {
        text-align: right;
    }
    .reply_pagination {
    	text-align: center;
    	display: flex;
        justify-content: center;
    }
</style>
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
    let currentPage = 1;
    const pageSize = 5;
    let totalReplies = 0;

    var dto = {
        write_no: "${dto.write_no}",
        id: "${dto.id}",
        saveDate: "${dto.saveDate}",
        hit: "${dto.hit}",
        title: "${dto.title}",
        content: "${dto.content}",
        imageFileName: "${dto.imageFileName}"
    };

    function rep() {
        let form = {};
        let arr = $("#frm").serializeArray();
        arr.forEach(data => {
            form[data.name] = data.value;
        });
        console.log(form);
        $.ajax({
            url: "addReply",
            type: "post",
            data: JSON.stringify(form),
            contentType: "application/json; charset=utf-8",
            success: () => {
                alert("답글이 달렸습니다");
                $("#content").val("");
                replyData(currentPage); // 댓글을 등록한 후 현재 페이지를 기준으로 댓글을 다시 불러옴
            },
            error: () => {
                alert("문제 발생1");
            }
        });
    }

    function updatePagination(total) {
        const totalPages = Math.ceil(total / pageSize) || 1;
        let paginationHtml = '';

        paginationHtml += '<li class="page-item ' + (currentPage === 1 ? 'disabled' : '') + '">';
        paginationHtml += '<a class="page-link" href="#" aria-label="Previous" onclick="navigatePage(' + (currentPage - 1) + ')">';
        paginationHtml += '<span aria-hidden="true">&laquo;</span>';
        paginationHtml += '</a></li>';

        for (let i = 1; i <= totalPages; i++) {
            paginationHtml += '<li class="page-item ' + (i === currentPage ? 'active' : '') + '">';
            paginationHtml += '<a class="page-link" href="#" onclick="navigatePage(' + i + ')">' + i + '</a></li>';
        }

        paginationHtml += '<li class="page-item ' + (currentPage === totalPages ? 'disabled' : '') + '">';
        paginationHtml += '<a class="page-link" href="#" aria-label="Next" onclick="navigatePage(' + (currentPage + 1) + ')">';
        paginationHtml += '<span aria-hidden="true">&raquo;</span>';
        paginationHtml += '</a></li>';

        $("#pagination").html(paginationHtml);
    }

    function navigatePage(page) {
        if (page < 1 || page > Math.ceil(totalReplies / pageSize)) {
            return;
        }
        currentPage = page;
        replyData(currentPage);
    }

    function replyData(page) {
        $.ajax({
            url: "replyData/" + dto.write_no + "?page=" + page + "&size=" + pageSize,
            type: "get",
            dataType: "json",
            success: (data) => {
                console.log(data);
                let txt = "";
                if(data.length == 0){
                	updatePagination(0);
                	return;
                }
                data.forEach((d) => {
                    txt += '<div class="reply">';
                    txt += '<div class="reply-header">';
                    txt += '<div class="reply-id">아이디: ' + d.id + '</div>';
                    var date = new Date(d.write_date);
                    txt += '<div class="reply-date">작성일: ' + date.toLocaleString() + '</div>';
                    txt += '</div>';
                    txt += '<div class="reply-content-actions">';
                    txt += '<div class="reply-content">내용: ' + d.content + '</div>';
                    txt += '<div class="reply-actions">';
                    if(d.id === '${ login }'){
                        txt += '<button type="button" onclick="editReply(' + d.reply_no + ', \'' + d.content.replace(/'/g, "\\'") + '\')">수정</button>';
                        txt += '<button type="button" onclick="deleteReply(' + d.reply_no + ')">삭제</button>';
                    }
                    txt += '</div>';
                    txt += '</div>';
                    txt += '<div class="modify-form" id="modifyForm_' + d.reply_no + '">';
                    txt += '<textarea rows="2" cols="70" id="modifyContent_' + d.reply_no + '" placeholder="수정할 내용을 입력하세요">' + d.content.replace(/'/g, "\\'") + '</textarea>';
                    txt += '<button type="button" onclick="submitModifiedReply(' + d.reply_no + ')">확인</button>';
                    txt += '</div>';
                    txt += '</div><hr>';
                });
                $("#reply").html(txt);

                // 댓글 수를 업데이트하는 부분
                $.ajax({
                    url: "replyCount/" + dto.write_no,
                    type: "get",
                    success: (total) => {
                        totalReplies = total;  // 전체 댓글 수를 업데이트
                        updatePagination(totalReplies);
                    },
                    error: () => {
                        alert("페이지네이션 업데이트 중 문제가 발생했습니다.");
                    }
                });
            },
            error: (xhr, status, error) => {
                console.error("댓글 불러오기 중 문제가 발생했습니다:", error);
                alert("댓글 불러오기 중 문제가 발생했습니다.");
            }
        });
    }

    function editReply(reply_no, content){
        $('#modifyForm_' + reply_no).show();
        $('#modifyContent_' + reply_no).val(content);
        $('#modifyContent_' + reply_no).focus();
    }

    function submitModifiedReply(reply_no){
        let modifiedContent = $('#modifyContent_' + reply_no).val();

        $.ajax({
            url : "modifyReply",
            type : "post",
            data : JSON.stringify({ reply_no : reply_no, content : modifiedContent }),
            contentType : "application/json; charset=utf-8",
            success : () => {
                alert("수정되었습니다");
                $('#modifyForm_' + reply_no).hide();
                replyData(currentPage);
            },
            error : () => {
                alert("문제가 발생하였습니다");
            }
        });
    }

    function deleteReply(reply_no){
        if(confirm("댓글을 삭제하시겠습니까?")){
            $.ajax({
                url : "deleteReply",
                type : "post",
                data : JSON.stringify({ reply_no : reply_no }),
                contentType : "application/json; charset=utf-8",
                success : () => {
                    alert("삭제하였습니다");
                    replyData(currentPage);
                },
                error : () => {
                    alert("문제가 발생하였습니다");
                }
            })
        }
    }

    $(document).ready(function() {
        replyData(currentPage);
    });
</script>
</head>
<body>
    <%@ include file="../default/header.jsp" %>
    
    <table border="1">
        <tr style="height: 30px;">
            <th>글 번호</th><td style="width: 50px;">${dto.write_no}</td>
            <th>아이디</th><td style="width: 75px;">${dto.id}</td>
            <th>등록 시간</th><td style="width: 175px;">${dto.saveDate}</td>
            <th>조회수</th><td style="width: 50px;">${dto.hit}</td>
        </tr>
        <tr>
            <th>제목</th><td colspan="7" style="height: 30px;">${dto.title}</td>
        </tr>
        <tr>
            <th>내용</th><td colspan="7" style="height: 200px;">${dto.content}</td>
        </tr>
        <tr>
         <td colspan="8">
         	<img src="download?name=${ dto.imageFileName }" width="100" height="100" alt="없음">
         	<button type="button" onclick="location.href='download?name=${dto.imageFileName}'">다운로드</button>
         </td>
        </tr>
        <tr style="height:30px;">
            <td colspan="8" style="text-align: right;">
                <c:if test="${login == dto.id}">
                    <button type="button" onclick="location.href='modifyForm?write_no=${dto.write_no}'">수정</button>
                    <button type="button" onclick="location.href='delete?write_no=${dto.write_no}&fileName=${ dto.imageFileName }'">삭제</button>
                </c:if>
                <button type="button" onclick="location.href='boardList'">목록</button>
            </td>
        </tr>
        <tr>
            <td id="reply" colspan="8" style="text-align: center">
                댓글이 없습니다
            </td>
        </tr>
        <tr>
            <td colspan="8">
                <form id="frm">
                    <input type="text" name="write_group" value="${dto.write_no}" readonly hidden="hidden"><br>
                    <b>작성자</b> ${login} <br>
                    <textarea rows="3" cols="85" name="content" id="content" placeholder="댓글을 입력하세요"></textarea>
                    <div class="submit-btn-container">
                    	<button type="button" onclick="rep()">등록</button>
                	</div>
                </form>
            </td>
        </tr>
        <tr>
        	<td colspan="8">
        		<div class="reply_pagination">
        			<nav aria-label="Page navigation example">
        				<ul class="pagination" id="pagination"></ul>
        			</nav>	
        		</div>
        	</td>
        </tr>
    </table>
</body>
</html>
