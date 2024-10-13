package com.care.project.Service;

import com.care.project.DTO.MemberDTO;

public interface MemberService {
	public int loginChk( String id, String pwd );
	public void keepLogin( String sessionId, String id);
	public int register( MemberDTO member );
	public void saveNaverUser( String naverId, String name, String email, String mobile);
}
