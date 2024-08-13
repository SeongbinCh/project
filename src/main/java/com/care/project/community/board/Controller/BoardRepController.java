package com.care.project.community.board.Controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.care.project.common.LoginSession;
import com.care.project.community.board.DTO.BoardRepDTO;
import com.care.project.community.board.Service.BoardService;
import com.care.project.community.board.Service.BoardServiceImpl;

@RestController
@RequestMapping("community")
public class BoardRepController {
	@Autowired BoardService bs;
	
	//댓글 등록 메서드
	@PostMapping(value="addReply", produces="application/json; charset=utf-8")
	public void addReply(@RequestBody BoardRepDTO dto, HttpSession session) {
		dto.setId( (String)session.getAttribute( LoginSession.LOGIN ) );
		bs.addReply( dto );
	}
	// 게시글의 댓글 리스트를 불러오는 메서드
    @GetMapping(value = "replyData/{write_group}", produces = "application/json; charset=utf-8")
    public List<BoardRepDTO> replyData(@PathVariable int write_group,
    								@RequestParam(required = false, defaultValue = "1") int page, 
    								@RequestParam int size) {
    	List<BoardRepDTO> comments = bs.replyList(write_group, page, size);
    	
        return comments;
    }
    //게시글의 댓글 갯수를 가져오는 메서드
    @GetMapping(value = "replyCount/{write_group}", produces = "application/json; charset=utf-8")
    public int replyCount(@PathVariable int write_group) {
    	return bs.getRepCount(write_group);
    }
    //게시글의 댓글을 수정하는 메서드
    @PostMapping(value = "modifyReply", produces = "application/json; charset=utf-8")
    public void modifyReply(@RequestBody BoardRepDTO dto) {
    	bs.modifyReply( dto );
    }
    //게시글의 댓글을 삭제하는 메서드
    @PostMapping(value = "deleteReply", produces = "application/json; charset=utf-8")
    public void deleteReply(@RequestBody BoardRepDTO dto) {
    	bs.deleteReply( dto.getReply_no() );
    }
}
