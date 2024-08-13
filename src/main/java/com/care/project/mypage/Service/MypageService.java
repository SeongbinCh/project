package com.care.project.mypage.Service;

import org.springframework.stereotype.Service;

import com.care.project.DTO.MemberDTO;

@Service
public interface MypageService {
	public MemberDTO getContent( String id );
	public String modify( MemberDTO dto );
}
