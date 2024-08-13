package com.care.project.mypage.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.care.project.DTO.MemberDTO;
import com.care.project.Mybatis.MemberMapper;
import com.care.project.community.board.Service.BoardFileService;

@Service
@Transactional
public class MypageServiceImpl implements MypageService{
	@Autowired MemberMapper membermapper;
	@Autowired BoardFileService bfs;
	
	public MemberDTO getContent( String id ) {
		return membermapper.getContent( id );
	}
	
	public String modify( MemberDTO dto ) {
		int result = membermapper.modify( dto );
		
		String msg = "", url = "";
		if( result == 1 ) {
			msg = "수정하였습니다.";
			url = "/project/mypage/modifyForm?id=" + dto.getId();
		} else {
			msg = "실패하였습니다.";
			url = "/project/mypage/modifyForm?id=" + dto.getId();
		}
		return bfs.getMessage(msg, url);
	}
}
