package com.care.project.Service;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.care.project.DTO.MemberDTO;
import com.care.project.Mybatis.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{
	@Autowired MemberMapper mapper;
	
	public int loginChk( String id, String pwd ) {
		MemberDTO dto = mapper.loginChk( id );
		if ( dto == null ) {
			return 1;
		} 
		if( dto.getPwd() == null || !dto.getPwd().equals( pwd ) ) {
			return 2;
		}
		return 0;
	}
	
	public void keepLogin( String sessionId, String id ) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put( "sessionId", sessionId );
		map.put( "id", id );
		mapper.keepLogin( map );
	}
	
	public int register( MemberDTO dto ) {
		try {
			return mapper.register( dto );
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
	}
	
	public void saveNaverUser( String naverId, String name, String email, String mobile) {
		String id = naverId;
		MemberDTO naverMember = mapper.getUserByNaverId(naverId);
		
		if( naverMember == null ) {
			naverMember = new MemberDTO();
			naverMember.setId(id);
			naverMember.setNaverId(naverId);
			naverMember.setName(name);
			naverMember.setEmail(email);
			naverMember.setMobile(mobile);
			
			System.out.println(id);
			System.out.println(naverId);
			System.out.println(name);
			System.out.println(email);
			System.out.println(mobile);
			
			int result= mapper.registerNaverId(naverMember);
			if( result > 0 ) {
				System.out.println("네이버 사용자 정보가 등록되었습니다");
			} else {
				System.out.println("네이버 사용자 정보 등록이 실패하였습니다");
			}
		}
	}
}
