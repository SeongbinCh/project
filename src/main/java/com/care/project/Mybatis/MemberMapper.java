package com.care.project.Mybatis;

import java.util.Map;

import com.care.project.DTO.MemberDTO;

public interface MemberMapper {
	public MemberDTO loginChk( String id );
	public void keepLogin( Map<String, Object> map);
	public int register( MemberDTO member );
	public MemberDTO getContent( String id );
	public int modify( MemberDTO dto );
}
